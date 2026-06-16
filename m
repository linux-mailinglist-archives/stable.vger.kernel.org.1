Return-Path: <stable+bounces-264705-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EjvFKZx7MWoDkgUAu9opvQ
	(envelope-from <stable+bounces-264705-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:36:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 500EC692425
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:36:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=sNGGuyGn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264705-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264705-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8FC6300FB4B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3DD472786;
	Tue, 16 Jun 2026 16:30:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC644DB64;
	Tue, 16 Jun 2026 16:30:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627431; cv=none; b=B0IlVce+7zX+qOaBar7pukk/18ZJeOCZy3+mrs3J+TmsKgJ7A6tyzxAlu04ohTBmaPDYq0U9AbjYP1iU4Owy6m2DbVPyGvXwKEwYp4iv8azHwmxo9kbIQxUfcEDemKg8v7rmgWEMc4mC2a1Id2AmbftYxw0fMV/JkOCQY7pWbOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627431; c=relaxed/simple;
	bh=hl4h0bnrt76QXDyP3bwReIxfEt1z+7B3XrrsSS6vvaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7ka0MwkUhhmOHda8naICoq0bPyp+3UF7z2sLD5W+kNdeLKPFGHnazf8AvCepeGPlyWKdibDuJfmU8QNc6XCRL5ZqsZSdmRJATyjykv+dZyMHVMRrHJ9DLEocD+TeM/NjF+mb1yHvixNWQNcaxdogSs0yILjoErEg+Y4Q6Ll4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sNGGuyGn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0157B1F000E9;
	Tue, 16 Jun 2026 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627430;
	bh=G+7lNwwYAp2lCGzVBop2FHXYZTZkNl9f58M/ulB7PZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sNGGuyGnX6IXgvFzUm351cl78hqWrp1gxO5Fc6KH5n+rM2L9/oTm0SiQ6+BKIRyjE
	 3bOPtn7QGY71edCbTHrwwFof2/saoyNbN32wCUudPLaoDEBUrccwyFSj+4T/DJF9dM
	 f/OPlp3eIhG/BA3HDC0j4Nnd050SQkV3L1dTUnO0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: [PATCH 6.12 169/261] pidfd: refuse access to tasks that have started exiting harder
Date: Tue, 16 Jun 2026 20:30:07 +0530
Message-ID: <20260616145052.904014255@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264705-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 500EC692425

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

commit 62c4d31d78294bd61cf3403626b789e854357177 upstream.

The recent ptrace fix closed a hole where someone could rely on task->mm
becoming NULL during do_exit() to bypass dumpability checks. This api
here leans on on the very same check and so inherits the fix.

But there is no good reason to let it succeed at all once the target has
entered do_exit(). PF_EXITING is set by exit_signals() at the very top
of do_exit(), before exit_mm() and exit_files() run. Once we observe it,
the task is committed to dying and exit_files() will release the fdtable
shortly.

Fixes: 8649c322f75c ("pid: Implement pidfd_getfd syscall")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260518-obgleich-petersilie-2d77ccccf9b9@brauner
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/pid.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -674,10 +674,12 @@ static struct file *__pidfd_fget(struct
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS))
-		file = fget_task(task, fd);
-	else
+	if (!ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS))
 		file = ERR_PTR(-EPERM);
+	else if (task->flags & PF_EXITING)
+		file = ERR_PTR(-ESRCH);
+	else
+		file = fget_task(task, fd);
 
 	up_read(&task->signal->exec_update_lock);
 




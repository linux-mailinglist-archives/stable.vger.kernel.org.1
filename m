Return-Path: <stable+bounces-242913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FxoHrZc+GnatQIAu9opvQ
	(envelope-from <stable+bounces-242913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:45:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9D24BA735
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D8F4300FFBC
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528202E6CB3;
	Mon,  4 May 2026 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nJP8i5Bj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2010347BC5
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884337; cv=none; b=nMNO8ffb755oz8iKcNZJH1Du7OqBYYpWEr+fxISaR6R/U9s+Tc/itHQig5R3REMrEFFuI5P3lO+Ga23xN529f4lUurv7LRdRqFsTDBQZ+LXmsubsUySU8KnHGYhO++yjIDpvEbXMUutqdC3zTs7QrXfbZv4hL6afzl+21MNeX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884337; c=relaxed/simple;
	bh=/U86S23KyUL7ZQy/oAnGm1hbGqj/3pxltZV56df0OfQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R9fT1UYbNqHAehcWYyY8BpwPWi8ow/5nfRzQkxQlGc8bvAdxVey847pTBht5jZqoZvw6KcT233K7hnrsBfD7Ez86KHTD+IL1akkZA5wCt3XnaiLjE8YqENrQ7Q/eGdRbBrb25KCOjSsJcrHAmwsXqA0IJ77Xx1OVZ99Z/xlAJvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nJP8i5Bj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E6AC2BCB8;
	Mon,  4 May 2026 08:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777884336;
	bh=/U86S23KyUL7ZQy/oAnGm1hbGqj/3pxltZV56df0OfQ=;
	h=Subject:To:Cc:From:Date:From;
	b=nJP8i5BjHdjuEYzZuiiGknPoFUYCeeHOg3hSreCIoNp5kDFY3XNA0zhtZaOhmNJ3h
	 e8sUAiZEeDcT11OOQQDLPawXJWSrIiKLST6OZD6ppjxlcRh8BZoH/sUJXY3SIzpVP1
	 Vai8m1z7cgAfvlzjfN+vJMPYiG8r1v6+qiqaY8cA=
Subject: FAILED: patch "[PATCH] apparmor: use target task's context in apparmor_getprocattr()" failed to apply to 5.10-stable tree
To: cengiz.can@canonical.com,john.johansen@canonical.com,qsa@qualys.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:45:24 +0200
Message-ID: <2026050424-perceive-compress-fcb1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1F9D24BA735
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242913-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,canonical.com:email]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4afc61702bdcc3b9b519749ef966cf762a6e7051
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050424-perceive-compress-fcb1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4afc61702bdcc3b9b519749ef966cf762a6e7051 Mon Sep 17 00:00:00 2001
From: Cengiz Can <cengiz.can@canonical.com>
Date: Tue, 10 Feb 2026 11:17:14 +0300
Subject: [PATCH] apparmor: use target task's context in apparmor_getprocattr()

apparmor_getprocattr() incorrectly calls task_ctx(current) instead of
task_ctx(task) when retrieving prev and exec attributes, returning the
caller's labels rather than the target's.

Fix by passing task to task_ctx().

The issue can be reproduced when a process with an onexec transition
(e.g., configured by a container runtime) is inspected via
/proc/<pid>/attr/apparmor/exec. The reader's own value is returned
instead of the target's.

Reported-by: Qualys Security Advisory <qsa@qualys.com>
Fixes: 3b529a7600d8 ("apparmor: move task domain change info to task security")
Cc: stable@vger.kernel.org
Co-developed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Cengiz Can <cengiz.can@canonical.com>
Co-developed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c1d42fc72fdb..d3af2d10fc22 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -822,25 +822,23 @@ static int apparmor_getprocattr(struct task_struct *task, const char *name,
 				char **value)
 {
 	int error = -ENOENT;
-	/* released below */
-	const struct cred *cred = get_task_cred(task);
-	struct aa_task_ctx *ctx = task_ctx(current);
 	struct aa_label *label = NULL;
 
+	rcu_read_lock();
 	if (strcmp(name, "current") == 0)
-		label = aa_get_newest_label(cred_label(cred));
-	else if (strcmp(name, "prev") == 0  && ctx->previous)
-		label = aa_get_newest_label(ctx->previous);
-	else if (strcmp(name, "exec") == 0 && ctx->onexec)
-		label = aa_get_newest_label(ctx->onexec);
+		label = aa_get_newest_cred_label(__task_cred(task));
+	else if (strcmp(name, "prev") == 0  && task_ctx(task)->previous)
+		label = aa_get_newest_label(task_ctx(task)->previous);
+	else if (strcmp(name, "exec") == 0 && task_ctx(task)->onexec)
+		label = aa_get_newest_label(task_ctx(task)->onexec);
 	else
 		error = -EINVAL;
+	rcu_read_unlock();
 
 	if (label)
 		error = aa_getprocattr(label, value, true);
 
 	aa_put_label(label);
-	put_cred(cred);
 
 	return error;
 }



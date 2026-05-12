Return-Path: <stable+bounces-246117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFeFMM1uA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:17:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFA35273E7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56C1B3086FF0
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B42730BB80;
	Tue, 12 May 2026 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xdamnwTQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C93955D4;
	Tue, 12 May 2026 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608402; cv=none; b=UuD7AsTtPwDpNGyktpDW/qZTe3Wcjr/7DT1tiTC/HffxCnyaIO3sOCv9q/De7GBbkrQ94D67KW+uhM7atxG22FoxAhkqN8EfalnZ5SosbvbeqqvIImzL2lNhrGhiOe6Tkc6zhFR75oC5M7uz80Xf9SK4C6xGKkjop119DL8hr7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608402; c=relaxed/simple;
	bh=BrDqoDiBzfaclaQBVxbcow9wzqjtq7N03A2MmKsFd4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpI4QkNtOr4Pwp+rmY/KN7qX2eGdFNVHXCded5Z12+PGmRkaP3EcdietGtZDSgjpEvgx4DX5Lv6+RJJ6YfiOrGlryFBCB1zjBmMXDip361ls26cMUPMo1RAOoJTOCCjme6E7mzw4M3+WdbKP5Wk9fvIcJ0xqhLOICtaDzjSN+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xdamnwTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89564C2BCB0;
	Tue, 12 May 2026 17:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608401;
	bh=BrDqoDiBzfaclaQBVxbcow9wzqjtq7N03A2MmKsFd4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xdamnwTQOPGodcwT6KnLkN8Cd4sNYoWkYbNlG9Tf3kQ1Ptp6S7tT7feJYFBSq6dsh
	 iVusNzGu9vhP90pFcuDQ5deRDzwQS6caDfn8MqGcBCEdylZONaIDBSNPxx3OF6bTCE
	 DWCFX7sQnrKx0YYC3HKvuwElCttUiKB4lNcS9izI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 6.18 064/270] selinux: prune /sys/fs/selinux/checkreqprot
Date: Tue, 12 May 2026 19:37:45 +0200
Message-ID: <20260512173939.798473160@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 4FFA35273E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-246117-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,paul-moore.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Smalley <stephen.smalley.work@gmail.com>

commit 644132a48f4e28a1d949d162160869286f3e75de upstream.

commit a7e4676e8e2cb ("selinux: remove the 'checkreqprot'
functionality") removed the ability to modify the checkreqprot setting
but left everything except the updating of the checkreqprot value
intact. Aside from unnecessary processing, this could produce a local
DoS from log spam and incorrectly calls selinux_ima_measure_state() on
each write even though no state has changed. Prune it to just log an
error message once and return count (i.e. all bytes written
successfully) so that userspace never breaks.

Cc: stable@vger.kernel.org
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/selinux/selinuxfs.c |   47 ++++++-------------------------------------
 1 file changed, 7 insertions(+), 40 deletions(-)

--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -676,46 +676,13 @@ static ssize_t sel_read_checkreqprot(str
 static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 				      size_t count, loff_t *ppos)
 {
-	char *page;
-	ssize_t length;
-	unsigned int new_value;
-
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
-			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
-			      NULL);
-	if (length)
-		return length;
-
-	if (count >= PAGE_SIZE)
-		return -ENOMEM;
-
-	/* No partial writes. */
-	if (*ppos != 0)
-		return -EINVAL;
-
-	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
-
-	if (sscanf(page, "%u", &new_value) != 1) {
-		length = -EINVAL;
-		goto out;
-	}
-	length = count;
-
-	if (new_value) {
-		char comm[sizeof(current->comm)];
-
-		strscpy(comm, current->comm);
-		pr_err("SELinux: %s (%d) set checkreqprot to 1. This is no longer supported.\n",
-		       comm, current->pid);
-	}
-
-	selinux_ima_measure_state();
-
-out:
-	kfree(page);
-	return length;
+	/*
+	 * Setting checkreqprot is no longer supported, see
+	 * https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-checkreqprot
+	 */
+	pr_err_once("SELinux: %s (%d) wrote to checkreqprot. This is no longer supported.\n",
+		    current->comm, current->pid);
+	return count;
 }
 static const struct file_operations sel_checkreqprot_ops = {
 	.read		= sel_read_checkreqprot,




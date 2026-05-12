Return-Path: <stable+bounces-246389-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB25CytzA2rf5wEAu9opvQ
	(envelope-from <stable+bounces-246389-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:36:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C192B527D85
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D14131AB31C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622071DED4C;
	Tue, 12 May 2026 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UqKutxCs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BB13EDE55;
	Tue, 12 May 2026 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609100; cv=none; b=ck8uFZekpWTpK4KtEpgJGAImoMXSf4Jk1EShkq41K1vLmpqHrcuUXXvZ3MpS+ARaRmuMUiqohJ0J02fgcmXZyRe7tUDxMkV1ZzGTbhjWpJXQ//Q/spp26WdxUWh21hAq76svmcSn5LcfVj7bgEi65G7ww8CiPjIHTFXweEDjj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609100; c=relaxed/simple;
	bh=yaLsBvdsUbT7jkkc0tQ5BQrwDxvGNKuCNb9ucQ9sS1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHcgLkFjldoWHGQ6PKYHA2kPbPPZx9tvH4f1xraIkCpqFdYYA807yIADJe6GkIzecgv/0wCj7pMARY7hN1dU73RgxSKA/sDys9nLzp5+JLlqJKCknh4/Xikz7Q0ht7YKByXRka+PX+ohJ/QJecyMVpyBe7toBPI58mpnGtjAfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UqKutxCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF80CC2BCB0;
	Tue, 12 May 2026 18:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609100;
	bh=yaLsBvdsUbT7jkkc0tQ5BQrwDxvGNKuCNb9ucQ9sS1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UqKutxCs2VDuwlPmU5k1RxAgKIZr7LaMw3uTUfZHdwiKCI8//zhRQXFyWLMcvXsFc
	 P9dmdSAmdwdpcp8i7giQ7VV5pDaGE4jjZEb2SfCfuDUtmdoYM69bKn2WknVOWfXDau
	 p0ETQWvJFsZ4dSlYftfEU7w9JgCsm2zWvtqKQgnA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 7.0 063/307] selinux: prune /sys/fs/selinux/disable
Date: Tue, 12 May 2026 19:37:38 +0200
Message-ID: <20260512173941.451224410@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: C192B527D85
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
	TAGGED_FROM(0.00)[bounces-246389-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Smalley <stephen.smalley.work@gmail.com>

commit 19cfa0099024bb9cd40f6d950caa7f47ff8e77f6 upstream.

Commit f22f9aaf6c3d ("selinux: remove the runtime disable
functionality") removed the underlying SELinux runtime disable
functionality but left everything else intact and started logging an
error message to warn any residual users.

Prune it to just log an error message once and to return count
(i.e. all bytes written successfully) to avoid breaking
userspace. This also fixes a local DoS from logspam.

Cc: stable@vger.kernel.org
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/selinux/selinuxfs.c |   36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -272,35 +272,13 @@ static ssize_t sel_write_disable(struct
 				 size_t count, loff_t *ppos)
 
 {
-	char *page;
-	ssize_t length;
-	int new_value;
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
-	if (sscanf(page, "%d", &new_value) != 1) {
-		length = -EINVAL;
-		goto out;
-	}
-	length = count;
-
-	if (new_value) {
-		pr_err("SELinux: https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable\n");
-		pr_err("SELinux: Runtime disable is not supported, use selinux=0 on the kernel cmdline.\n");
-	}
-
-out:
-	kfree(page);
-	return length;
+	/*
+	 * Setting disable is no longer supported, see
+	 * https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable
+	 */
+	pr_err_once("SELinux: %s (%d) wrote to disable. This is no longer supported.\n",
+		    current->comm, current->pid);
+	return count;
 }
 
 static const struct file_operations sel_disable_ops = {




Return-Path: <stable+bounces-240673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPxZFvFw62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:32:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F95145F11F
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10B013002B54
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751543D6CA3;
	Fri, 24 Apr 2026 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kvu8trLI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571BE3D6CDA;
	Fri, 24 Apr 2026 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037544; cv=none; b=t3J8E6vVtewelE5w19u1bYE45U081b8sjglZqt7ZKnIx9FxkXE7Z0Yb9dUhDgiCdXQzcea7vY2bdxOrh0yNSPA1afztvyWOiGv85HZPC9pINxOrMdE/cxkfMDZVZpb1H1CtzaJ62UGLtR99cGp5X+QRarP1OjjHsVmPmvf0RFwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037544; c=relaxed/simple;
	bh=Hvmp7YnzPqL/xNDHrukHKWe2ioVkUM1+r11D8BkD6go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5gO+JE3xnzuikEM0dna7qGUX17n03TZudCyJvXty+puDWxzdrnvpIie2pRVZCP3fuiqW8wYNuOiTTT8tDNR/WrSfZapPSb5fCOvlkkwb7OOpWZHjsK2L6MQRELKE2G68XLKpMZqnAg/Bns7LbUjgPVVw1IfgcFmdfxA7QY5hRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kvu8trLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71855C2BCB2;
	Fri, 24 Apr 2026 13:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037543;
	bh=Hvmp7YnzPqL/xNDHrukHKWe2ioVkUM1+r11D8BkD6go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kvu8trLIaCNw6bwKSxHenPwkJcbtpt5EEKH/MFc/mjX/KidwrnqM5KKpuOm8tsL/4
	 t5shlu2oNgRGX4aoglbEGXTUeuYW3/f8MVclp0iVwTP0DJnn85JioUx40kk6v+dXbK
	 UoppZkLn+D4ZNoC9IjCehGp8+f6orQRNEm9phduo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 7.0 19/42] fuse: fuse_dev_ioctl_clone() should wait for device file to be initialized
Date: Fri, 24 Apr 2026 15:30:44 +0200
Message-ID: <20260424132424.514310241@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132420.410310336@linuxfoundation.org>
References: <20260424132420.410310336@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 5F95145F11F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240673-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit da6fcc6dbddbef80e603d2f0c1554a9f2ac03742 upstream.

Use fuse_get_dev() not __fuse_get_dev() on the old fd, since in the case of
synchronous INIT the caller will want to wait for the device file to be
available for cloning, just like I/O wants to wait instead of returning an
error.

Fixes: dfb84c330794 ("fuse: allow synchronous FUSE_INIT")
Cc: stable@vger.kernel.org # v6.18
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fuse/dev.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2599,9 +2599,8 @@ static int fuse_device_clone(struct fuse
 
 static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 {
-	int res;
 	int oldfd;
-	struct fuse_dev *fud = NULL;
+	struct fuse_dev *fud;
 
 	if (get_user(oldfd, argp))
 		return -EFAULT;
@@ -2614,17 +2613,15 @@ static long fuse_dev_ioctl_clone(struct
 	 * Check against file->f_op because CUSE
 	 * uses the same ioctl handler.
 	 */
-	if (fd_file(f)->f_op == file->f_op)
-		fud = __fuse_get_dev(fd_file(f));
+	if (fd_file(f)->f_op != file->f_op)
+		return -EINVAL;
 
-	res = -EINVAL;
-	if (fud) {
-		mutex_lock(&fuse_mutex);
-		res = fuse_device_clone(fud->fc, file);
-		mutex_unlock(&fuse_mutex);
-	}
+	fud = fuse_get_dev(fd_file(f));
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
-	return res;
+	guard(mutex)(&fuse_mutex);
+	return fuse_device_clone(fud->fc, file);
 }
 
 static long fuse_dev_ioctl_backing_open(struct file *file,




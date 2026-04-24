Return-Path: <stable+bounces-240899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ovB6Oh9162lRNAAAu9opvQ
	(envelope-from <stable+bounces-240899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:50:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC2945FBBA
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6923E305BFFF
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A013D6CCE;
	Fri, 24 Apr 2026 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ETEzzXDT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB673D6494;
	Fri, 24 Apr 2026 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038127; cv=none; b=eP0syIjBCbNV40jf8bOGcAKgVdoodu5W6xedxplr15pNAPiYyqpBGdKR7Q4BSQNpCQNrO3W0tO5zYyeyznF4oc7BQTe/NX7o/5p0mSxFKKKw/oGG/47S/L0tOSa1P1G0pV0TMlJA95Jzk58LvjhqhwsIzMjEOWASoz5uqfoJRK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038127; c=relaxed/simple;
	bh=PLrXS6+yzjMzL6QWXwUJetYgK70GBiV5EuJ285LMghk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewFQbEEHYVvP2tUvcWVVswRgkrT5naKC6sI348uYA1xzLQ030TIeRAQniZ1uC6WfUmRLMNIDT7vvw/TTE9MuZA4PW+2I2n97uNAvloJbYIZlM1e2nHaidUipjvrqhEAM/PeChxdPxy29lx3zOgU2+XHFzmO5i9A79iVCBhJ3/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ETEzzXDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5046FC19425;
	Fri, 24 Apr 2026 13:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777038127;
	bh=PLrXS6+yzjMzL6QWXwUJetYgK70GBiV5EuJ285LMghk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ETEzzXDT9/fXtpf8jgsYGspaAlT/Aeoz4xCZDG3lSgbcxCUQxhInVTOs9D5YleCBM
	 qXHfzIDr16C+MewgTC1h4MrSr7jF3bZoD63BiqYNyLbcy6XxisiqVUTy9kbZreszch
	 x0Phz0cEbneFCM86AgOK+xfV8RwugfSChopKUpwk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 6.18 35/55] fuse: fuse_dev_ioctl_clone() should wait for device file to be initialized
Date: Fri, 24 Apr 2026 15:31:14 +0200
Message-ID: <20260424132437.279624658@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132430.006424517@linuxfoundation.org>
References: <20260424132430.006424517@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 6CC2945FBBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240899-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

6.18-stable review patch.  If anyone has any objections, please let me know.

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




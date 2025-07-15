Return-Path: <stable+bounces-162902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C007BB06071
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2CF1C4754C
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FAC2ECD2D;
	Tue, 15 Jul 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PTZ5vuOD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1564F1F4CB3;
	Tue, 15 Jul 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587775; cv=none; b=SRpHapk17tqdKZ/NZwSXrelCVzTibQ+xln5Az0W2bnHGS/4BvkU3vcmu2Mwpx4kZMZSA1H8vS5b02m4A+oruIVHATzFxbMxVNbYyNtCQas+H+80lPIXSh6/JcCLBPXeRWgU4pJrFPaWWvxhJJO13qjB5gr4cv1Ri4z20fkJAjTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587775; c=relaxed/simple;
	bh=vp1MQU8g3DUu13CxBlzjAtAEbLfOp3Qlj97tU7PGoZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaJ//CUn7M4AbyuhnReKOCX71DJ+650hwyZ+bkvawgehgs66AEJdhlIi0/1vmVz2Alga1EKhoZnBl5ci1RUkvvLH3XDC2s6Sz/4bnTZnVkIgvlD5j28FVD9fMA194fxn7XkbNw/lzb+sO5+W5kUCYA2V05uAGiFb74crsuLKEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PTZ5vuOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D511C4CEE3;
	Tue, 15 Jul 2025 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587775;
	bh=vp1MQU8g3DUu13CxBlzjAtAEbLfOp3Qlj97tU7PGoZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PTZ5vuODF79s7gTbg4VGjHTO6PYjif5e6cs7HG00TP5kwEWwWUG2PYOT9XY5vf6Oq
	 os5l740Mvq/AqklTFOWK9GR5KDu0CtzsEYqPmZAPZH0e0dR/CbVQE2S3mLvvYbhI6M
	 zYo2Xyc03i8iI1PZgJE8uPkJB0sWYgT/pLtKnMTI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	Michal Luczaj <mhal@rbox.co>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 139/208] vsock: Fix transport_{g2h,h2g} TOCTOU
Date: Tue, 15 Jul 2025 15:14:08 +0200
Message-ID: <20250715130816.496586583@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
References: <20250715130810.830580412@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit 209fd720838aaf1420416494c5505096478156b4 ]

vsock_find_cid() and vsock_dev_do_ioctl() may race with module unload.
transport_{g2h,h2g} may become NULL after the NULL check.

Introduce vsock_transport_local_cid() to protect from a potential
null-ptr-deref.

KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
RIP: 0010:vsock_find_cid+0x47/0x90
Call Trace:
 __vsock_bind+0x4b2/0x720
 vsock_bind+0x90/0xe0
 __sys_bind+0x14d/0x1e0
 __x64_sys_bind+0x6e/0xc0
 do_syscall_64+0x92/0x1c0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
Call Trace:
 __x64_sys_ioctl+0x12d/0x190
 do_syscall_64+0x92/0x1c0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Link: https://patch.msgid.link/20250703-vsock-transports-toctou-v4-1-98f0eb530747@rbox.co
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/af_vsock.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index fc0306ba2d43e..5f82dfe50c123 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -498,9 +498,25 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 }
 EXPORT_SYMBOL_GPL(vsock_assign_transport);
 
+/*
+ * Provide safe access to static transport_{h2g,g2h,dgram,local} callbacks.
+ * Otherwise we may race with module removal. Do not use on `vsk->transport`.
+ */
+static u32 vsock_registered_transport_cid(const struct vsock_transport **transport)
+{
+	u32 cid = VMADDR_CID_ANY;
+
+	mutex_lock(&vsock_register_mutex);
+	if (*transport)
+		cid = (*transport)->get_local_cid();
+	mutex_unlock(&vsock_register_mutex);
+
+	return cid;
+}
+
 bool vsock_find_cid(unsigned int cid)
 {
-	if (transport_g2h && cid == transport_g2h->get_local_cid())
+	if (cid == vsock_registered_transport_cid(&transport_g2h))
 		return true;
 
 	if (transport_h2g && cid == VMADDR_CID_HOST)
@@ -2124,18 +2140,17 @@ static long vsock_dev_do_ioctl(struct file *filp,
 			       unsigned int cmd, void __user *ptr)
 {
 	u32 __user *p = ptr;
-	u32 cid = VMADDR_CID_ANY;
 	int retval = 0;
+	u32 cid;
 
 	switch (cmd) {
 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
 		/* To be compatible with the VMCI behavior, we prioritize the
 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
 		 */
-		if (transport_g2h)
-			cid = transport_g2h->get_local_cid();
-		else if (transport_h2g)
-			cid = transport_h2g->get_local_cid();
+		cid = vsock_registered_transport_cid(&transport_g2h);
+		if (cid == VMADDR_CID_ANY)
+			cid = vsock_registered_transport_cid(&transport_h2g);
 
 		if (put_user(cid, p) != 0)
 			retval = -EFAULT;
-- 
2.39.5





Return-Path: <stable+bounces-162511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64570B05E90
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F6B1C24CEA
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241DA2E7BDF;
	Tue, 15 Jul 2025 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zrISRTdI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32502E7BC5;
	Tue, 15 Jul 2025 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586748; cv=none; b=YIS7vWM8nFycLoEjbhT/uz+bG4vU/uSrXsSvZAek8FtkpjUjbEKB7nw4tSWTWpD2Cm3NFVTOJCYEy/4W18Kw3+Fyh5Y6r8ZyrqdI80ROGlrJCf2ErL2Y6kIsDh/mBbTXYDeXwzdFHkJFYSAVKlSk+YYEYa1Kr/kc5J62NkG7Kyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586748; c=relaxed/simple;
	bh=rGjN3xjl7fQxb+RmjQ+9s0Kuu70WovsDuQj5yg9wgns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUgM6rhgNURyQH5hmoW1e2UPpAiNSwZJkkwCkDKijq9Hnjf2NxNhNaXwNs9fY+DzmJqqXbbvIiVeeg5LJGMLSKd6Qjh9YyXjnUapi3pMQoxlzlSOz85YCV7F65bdVQqH4K8vIUVpouWioH9NHVGFjaxTRsd0hhRizdV6AXQySPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zrISRTdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605A2C4CEE3;
	Tue, 15 Jul 2025 13:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586748;
	bh=rGjN3xjl7fQxb+RmjQ+9s0Kuu70WovsDuQj5yg9wgns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zrISRTdIjFXA/1ubGGqdjZ3XXCeVDWGlgiB4snOH0wBYUCvmpZFJwB7YyjvAfmY09
	 rnefRdwMOqx9LMOxixTzRADiUqHGxs4tKbgwhcUwanQDLweKgnJ0V/8hBhf1Y3f16F
	 QHPCpepKv6d1f2fYuAhBfxbWy9bTTapWUJp6ioXs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	Michal Luczaj <mhal@rbox.co>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 034/192] vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_local`
Date: Tue, 15 Jul 2025 15:12:09 +0200
Message-ID: <20250715130816.226954517@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit 1e7d9df379a04ccd0c2f82f39fbb69d482e864cc ]

Support returning VMADDR_CID_LOCAL in case no other vsock transport is
available.

Fixes: 0e12190578d0 ("vsock: add local transport support in the vsock core")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Link: https://patch.msgid.link/20250703-vsock-transports-toctou-v4-3-98f0eb530747@rbox.co
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/af_vsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f947ab8787899..c50184eddb445 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2548,6 +2548,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
 		cid = vsock_registered_transport_cid(&transport_g2h);
 		if (cid == VMADDR_CID_ANY)
 			cid = vsock_registered_transport_cid(&transport_h2g);
+		if (cid == VMADDR_CID_ANY)
+			cid = vsock_registered_transport_cid(&transport_local);
 
 		if (put_user(cid, p) != 0)
 			retval = -EFAULT;
-- 
2.39.5





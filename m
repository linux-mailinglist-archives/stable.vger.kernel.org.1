Return-Path: <stable+bounces-88481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893159B2627
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5A82822A1
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ADF18E04F;
	Mon, 28 Oct 2024 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zUu7j5LC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8489D18DF68;
	Mon, 28 Oct 2024 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097429; cv=none; b=igDwNPmzICrFP0QkdqvJDwP+9GNDamH459uhT3Rwz+DDxyKeRmXHznPOe01gDqpy9LmqNjA+bzJCtMjTTsJ+OPKUb3olVU23xAMW71CefcfRkUxFVT7JZi3W9YZtDe6sGfav4hUkQHyt5kHFsIFTvhywbHHNlb08Yj5Vbe8OwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097429; c=relaxed/simple;
	bh=hpoQl94Bqx24gajBr6JtAvOLRoDPajKNiaSQX+Z/bEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akDaIps/tkXCCFe4rFZ9zIvrPruhG7tYejAMtivgtRTXxGg/Ola8hnO5FtcwAzL/6YfuV1v8OlYKB/kSC2CyO2SBN0xPHDPSSZulg1uaV3M+RNTdDEaMAr/KIuO0xoE8GLUsatT2IfFWgSY7OQ0oFtglukPXxfMYc/Ei8bY9sZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zUu7j5LC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239A3C4CEC3;
	Mon, 28 Oct 2024 06:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097429;
	bh=hpoQl94Bqx24gajBr6JtAvOLRoDPajKNiaSQX+Z/bEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zUu7j5LC9rLJs4m+DiCXAS5vqkXtq0XVcnO83njf7Nn19N905hLe1K74qGbBm0NmT
	 rXkt4G9EKMEX8QVOw+rkh/fslIhepPRULN6F+GtmNuUxX7tdDdJvS7HLEH3NyWHmbE
	 B/OWCr/m126CmIgQCIA5ooiIg7/uYKs78nxkcETw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Tonofa <b.tonofa@ideco.ru>,
	Petr Vaganov <p.vaganov@ideco.ru>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 6.1 127/137] xfrm: fix one more kernel-infoleak in algo dumping
Date: Mon, 28 Oct 2024 07:26:04 +0100
Message-ID: <20241028062302.254653154@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
References: <20241028062258.708872330@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Vaganov <p.vaganov@ideco.ru>

commit 6889cd2a93e1e3606b3f6e958aa0924e836de4d2 upstream.

During fuzz testing, the following issue was discovered:

BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x598/0x2a30
 _copy_to_iter+0x598/0x2a30
 __skb_datagram_iter+0x168/0x1060
 skb_copy_datagram_iter+0x5b/0x220
 netlink_recvmsg+0x362/0x1700
 sock_recvmsg+0x2dc/0x390
 __sys_recvfrom+0x381/0x6d0
 __x64_sys_recvfrom+0x130/0x200
 x64_sys_call+0x32c8/0x3cc0
 do_syscall_64+0xd8/0x1c0
 entry_SYSCALL_64_after_hwframe+0x79/0x81

Uninit was stored to memory at:
 copy_to_user_state_extra+0xcc1/0x1e00
 dump_one_state+0x28c/0x5f0
 xfrm_state_walk+0x548/0x11e0
 xfrm_dump_sa+0x1e0/0x840
 netlink_dump+0x943/0x1c40
 __netlink_dump_start+0x746/0xdb0
 xfrm_user_rcv_msg+0x429/0xc00
 netlink_rcv_skb+0x613/0x780
 xfrm_netlink_rcv+0x77/0xc0
 netlink_unicast+0xe90/0x1280
 netlink_sendmsg+0x126d/0x1490
 __sock_sendmsg+0x332/0x3d0
 ____sys_sendmsg+0x863/0xc30
 ___sys_sendmsg+0x285/0x3e0
 __x64_sys_sendmsg+0x2d6/0x560
 x64_sys_call+0x1316/0x3cc0
 do_syscall_64+0xd8/0x1c0
 entry_SYSCALL_64_after_hwframe+0x79/0x81

Uninit was created at:
 __kmalloc+0x571/0xd30
 attach_auth+0x106/0x3e0
 xfrm_add_sa+0x2aa0/0x4230
 xfrm_user_rcv_msg+0x832/0xc00
 netlink_rcv_skb+0x613/0x780
 xfrm_netlink_rcv+0x77/0xc0
 netlink_unicast+0xe90/0x1280
 netlink_sendmsg+0x126d/0x1490
 __sock_sendmsg+0x332/0x3d0
 ____sys_sendmsg+0x863/0xc30
 ___sys_sendmsg+0x285/0x3e0
 __x64_sys_sendmsg+0x2d6/0x560
 x64_sys_call+0x1316/0x3cc0
 do_syscall_64+0xd8/0x1c0
 entry_SYSCALL_64_after_hwframe+0x79/0x81

Bytes 328-379 of 732 are uninitialized
Memory access of size 732 starts at ffff88800e18e000
Data copied to user address 00007ff30f48aff0

CPU: 2 PID: 18167 Comm: syz-executor.0 Not tainted 6.8.11 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014

Fixes copying of xfrm algorithms where some random
data of the structure fields can end up in userspace.
Padding in structures may be filled with random (possibly sensitve)
data and should never be given directly to user-space.

A similar issue was resolved in the commit
8222d5910dae ("xfrm: Zero padding when dumping algos and encap")

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: c7a5899eb26e ("xfrm: redact SA secret with lockdown confidentiality")
Cc: stable@vger.kernel.org
Co-developed-by: Boris Tonofa <b.tonofa@ideco.ru>
Signed-off-by: Boris Tonofa <b.tonofa@ideco.ru>
Signed-off-by: Petr Vaganov <p.vaganov@ideco.ru>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_user.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -978,7 +978,9 @@ static int copy_to_user_auth(struct xfrm
 	if (!nla)
 		return -EMSGSIZE;
 	ap = nla_data(nla);
-	memcpy(ap, auth, sizeof(struct xfrm_algo_auth));
+	strscpy_pad(ap->alg_name, auth->alg_name, sizeof(ap->alg_name));
+	ap->alg_key_len = auth->alg_key_len;
+	ap->alg_trunc_len = auth->alg_trunc_len;
 	if (redact_secret && auth->alg_key_len)
 		memset(ap->alg_key, 0, (auth->alg_key_len + 7) / 8);
 	else




Return-Path: <stable+bounces-81223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BE79927F1
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 11:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CBF281367
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 09:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9C218BC1E;
	Mon,  7 Oct 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ideco.ru header.i=@ideco.ru header.b="cRDzPYcG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.ideco.ru (smtp.ideco.ru [46.36.23.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF4231CA9;
	Mon,  7 Oct 2024 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.23.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728292728; cv=none; b=AccunXIg+JiQbVU/MUDGP05fCFY2TCQAwPUCQnUJRmzHqCxlHzVnSjU7CqN5i8uVsJuisC6TCV7FNl1TAPfaS+Q15xeeq1jNCilZ2bQakR6eLarVBKRaxbN0PzKfDosk87y+Xw8mvg/mxEeBpSlj12swcTPJJNf8VD/oKulC464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728292728; c=relaxed/simple;
	bh=ah0plcJH83K1nD114MbEzQZq47uOyGUTf9PS1Y6wva0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DNma3/y9Bwyf7Dt8Ze7FrMt+HO4v6xQEv2kp7C4kgyILF/mXL9PD8qnnXnzUy+LMDokzL21qXBxYci80n8JHS6ZL9IAFxDFOuwU8mBw0/Nz1oEqxjXHIMs4jzaORafMus1ar/if7G3zvf+v8+X1K8NRn1FO5BN0cFTVbU4z7wF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideco.ru; spf=none smtp.mailfrom=ideco.ru; dkim=pass (2048-bit key) header.d=ideco.ru header.i=@ideco.ru header.b=cRDzPYcG; arc=none smtp.client-ip=46.36.23.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideco.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ideco.ru
Received: from [169.254.254.254] (localhost [127.0.0.1])
	by smtp.ideco.ru (Postfix) with ESMTP id 450E57005C82;
	Mon,  7 Oct 2024 14:18:34 +0500 (+05)
Received: from localhost.localdomain (unknown [5.189.15.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.ideco.ru (Postfix) with ESMTPSA id 806E97005C83;
	Mon,  7 Oct 2024 14:18:23 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 806E97005C83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
	t=1728292713; bh=bimnxKSsAOXhIzvh1rNS6NDuEAGgMtlXMv87QwpErdI=;
	h=From:To:Cc:Subject:Date;
	b=cRDzPYcGFhLatFGClhk6y/zk9o2HOawdfe3p8QwfEwBbajelZiYIzYb2qwy8NNdOI
	 JqSShxRDLrvY+Fh9ul1N2WvMz6eWhT8xrNQl8jbkBrdi8rW7bsBLSNmh9wIUAV4ANu
	 yVoI9uReBxzXwCRcs5U9VdNHgQmfG0viM+dt13cMJ4h6FPBuZTteDQbHbnqVrWdOQ2
	 0TPrS3ddcSk7+h0bVLwvZX+nJElxZuVZW1YF7u1oE8D5oEWXw1zRvPCCd/Asu/dpwp
	 xy9bzIOhtobNBeC+LQSb3LQLGfnicLrY5O3F/bV2YCiFXW5flRkgewL2AsPr1u8J/h
	 JbJPdd6sMpmMA==
From: Petr Vaganov <p.vaganov@ideco.ru>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Petr Vaganov <p.vaganov@ideco.ru>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stephan Mueller <smueller@chronox.de>,
	Antony Antony <antony.antony@secunet.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org,
	Boris Tonofa <b.tonofa@ideco.ru>
Subject: [PATCH ipsec v2] xfrm: fix one more kernel-infoleak in algo dumping
Date: Mon,  7 Oct 2024 14:16:05 +0500
Message-ID: <20241007091611.15755-1-p.vaganov@ideco.ru>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

This patch fixes copying of xfrm algorithms where some random
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
---
v2: Fixed typo in sizeof(sizeof(ap->alg_name) expression.
The third argument for the strscpy_pad macro was chosen by
analogy with those in other functions of this file - as did
commit 8222d5910dae ("xfrm: Zero padding when dumping algos and encap").
I still think it would be better to leave the strscpy_pad() macro with
three arguments in this patch, mainly so that it would be consistent 
with the existing similar code in this module.
Regarding strncpy() above, we don't think it is
a real issue since the uncopied parts should be already padded with zeroes
by nla_reserve().

 net/xfrm/xfrm_user.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 55f039ec3d59..0083faabe8be 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1098,7 +1098,9 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
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
-- 
2.46.1



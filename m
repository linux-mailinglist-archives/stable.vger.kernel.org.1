Return-Path: <stable+bounces-78597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFEE98CD2C
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 08:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243581F22F93
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 06:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682C913CF82;
	Wed,  2 Oct 2024 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ideco.ru header.i=@ideco.ru header.b="eiSBEeNH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.ideco.ru (smtp.ideco.ru [46.36.23.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EAB79CC;
	Wed,  2 Oct 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.23.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727850655; cv=none; b=GNivWM9H5Kqi9RdHEbDBqbnXQ2/OWdzXPGEK+JSg8KMmMpMcD1OAxpx3XAtrTYJyp8plN+kikCCH9N4uvwh1/DrZnw8hXi7u40G78APr1dB0YY2zv+ONyZX/ri33E8vV2DcRF58HFgujF0y1tQnUGnZkfNS4qIXlRCHLX/U3ozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727850655; c=relaxed/simple;
	bh=0O+mukDwvCX2ok6rLtH5hOl60OcC0SFKy53PWzY9Ldc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nu07jC7cDvsxLkO/jEwkOlxAMsMXMD27g9DPDdMd+ufAATlbg9KxaWTL23geOHiftiqWDGnpqVZGP3Uf2RyACM+rXDYiyWZRJ8pLPjWilg7nx4UUVNLTSz1z/0Xlk3ImpIySINTNeQQ9+/Q36b0PUpIjI1UzmM0x89j8hI+89VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideco.ru; spf=none smtp.mailfrom=ideco.ru; dkim=pass (2048-bit key) header.d=ideco.ru header.i=@ideco.ru header.b=eiSBEeNH; arc=none smtp.client-ip=46.36.23.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideco.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ideco.ru
Received: from [169.254.254.254] (localhost [127.0.0.1])
	by smtp.ideco.ru (Postfix) with ESMTP id 8AAC5580239D;
	Wed,  2 Oct 2024 11:19:08 +0500 (+05)
Received: from fedora.in.ideco.ru (unknown [46.36.23.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.ideco.ru (Postfix) with ESMTPSA id 874F2580226C;
	Wed,  2 Oct 2024 11:18:52 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 874F2580226C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
	t=1727849947; bh=QkaDGvQsj6E9bKrlipIozYmBVc2b6T/p5MpgOu6NXjA=;
	h=From:To:Cc:Subject:Date;
	b=eiSBEeNHaPb45zvIMEKrx8M+Px5b1llaBOIzbXxoXK6VADet4QA70TCzgjHAegsop
	 7I4tfJ+42Yb9YiohKgnIrVsmH36i6ENzDU83tJHVi2NNdZEEhNtKNpnZECl7ukTrP+
	 BPHsLyfKTBt7/prcJ5LEpHEd9KS0SAd1EhYRRFXvGnKohrc7j1/fQNBoDrujGo8etV
	 VWDKViqgGDmRH85W1k499lSExDGNvJXEBjpKAr63/SMd0rqQAqsib/ZbhMoyVJdOSE
	 MMr/YK+vGU6ARBk+2sZ27SCY1m0z+CojRqi7NLIEhQ7JqzZFEzzD6u3OjO43Zm3EkN
	 /urbJY4BKdveA==
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
Subject: [PATCH net] xfrm: fix one more kernel-infoleak in algo dumping
Date: Wed,  2 Oct 2024 11:17:24 +0500
Message-ID: <20241002061726.69114-1-p.vaganov@ideco.ru>
X-Mailer: git-send-email 2.46.1
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
Hardware name: 
QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014

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
---
 net/xfrm/xfrm_user.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 55f039ec3d59..97faeb3574ea 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1098,7 +1098,9 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
 	if (!nla)
 		return -EMSGSIZE;
 	ap = nla_data(nla);
-	memcpy(ap, auth, sizeof(struct xfrm_algo_auth));
+	strscpy_pad(ap->alg_name, auth->alg_name, sizeof(sizeof(ap->alg_name)));
+	ap->alg_key_len = auth->alg_key_len;
+	ap->alg_trunc_len = auth->alg_trunc_len;
 	if (redact_secret && auth->alg_key_len)
 		memset(ap->alg_key, 0, (auth->alg_key_len + 7) / 8);
 	else
-- 
2.46.1



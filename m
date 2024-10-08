Return-Path: <stable+bounces-81541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8420C99439C
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296611F250D0
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9731F18130D;
	Tue,  8 Oct 2024 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ideco.ru header.i=@ideco.ru header.b="pe/4R8RX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.ideco.ru (smtp.ideco.ru [46.36.23.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0474DF58;
	Tue,  8 Oct 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.23.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378214; cv=none; b=r+3LRaAnAljf7jsiXQjKfyWgdD5reEzMO2Jp9NjUvH8i2r1ogX4ar20OXpOShvaxhBbAyQ4Y+Lj83dCG4k1WTHLx+oqS3t+Mxi0pp1icNPhQ8Rb8z1nrGq25ZTOo4VMmx9i4jup6v7rIBHXYfMX9k7FNHAIU92lWqqu+EAfTyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378214; c=relaxed/simple;
	bh=oa1gj8apNjivRvy0FeqjjCQd4EIkJj5sytrBwpF4zYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9HezY/FywbQSxPe5dZtnTtwiBFaskKqHjk0wSNKjS4vWRD5g7WoRaHob/2S82UTTJztT1Nc3TJgE6ny159gssflUZzgsfHcggDUKzU8edX7oTGx7nG73QN856NgoFo8uUaMH8UtbYIfjyVGioOdP1T5afwlzpB0wY9ivenZILM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideco.ru; spf=none smtp.mailfrom=ideco.ru; dkim=pass (2048-bit key) header.d=ideco.ru header.i=@ideco.ru header.b=pe/4R8RX; arc=none smtp.client-ip=46.36.23.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideco.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ideco.ru
Received: from [169.254.254.254] (localhost [127.0.0.1])
	by smtp.ideco.ru (Postfix) with ESMTP id 5A2E97005C85;
	Tue,  8 Oct 2024 14:03:26 +0500 (+05)
Received: from localhost.localdomain (unknown [5.189.15.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.ideco.ru (Postfix) with ESMTPSA id CA44F7005C82;
	Tue,  8 Oct 2024 14:03:23 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru CA44F7005C82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
	t=1728378205; bh=j4Z7yKchBM4Oa9SHtTqar55A2WWFtP/hdSu/eN3XC9E=;
	h=From:To:Cc:Subject:Date;
	b=pe/4R8RXYGgYoehGzk2JkeIag63lEMbIn+ldrhqPAV2ykbQ2KpvA4RHlY4hG6PNrS
	 85aRZiAvFAy+KJpO7749ogz0RSodlKAa67NXfgHIy+ZKy7mCMRGyzevvR1SCnxHNr5
	 Pln7PYqm6dGeXpX9aZoHjTewpvFN6C8XZO5ZVK7GaRXdB+EJhRgyLh3PNr/Ghdt4H/
	 wTkCZ1ESljQ9u4gQ2SNx6k+Z38YrAL6wXkJlT60waNXRosGQ7+F65oj1MRwJR9or/J
	 fleDJeOWYk+GdPq47lr2+7qjOyfAvNii5C11pohzDYLkfX13fFD1FX1SN2Uj7NrRbG
	 3RCPiwCAi6lcQ==
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
Subject: [PATCH ipsec v3] xfrm: fix one more kernel-infoleak in algo dumping
Date: Tue,  8 Oct 2024 14:02:58 +0500
Message-ID: <20241008090259.20785-1-p.vaganov@ideco.ru>
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
v3: Corrected commit description "This patch fixes copying..." to
"Fixes copying..." according to accepted rules of Linux kernel commits,
as suggested by Markus Elfring <elfring@users.sourceforge.net>.
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
2.46.2



Return-Path: <stable+bounces-46441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB78D047E
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068E41F21566
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30B316EC02;
	Mon, 27 May 2024 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2Lh37GA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E94115FA6C;
	Mon, 27 May 2024 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819564; cv=none; b=basrUdTQhcFA2ZM6BIJCYSU7K43gQn/685Bz3Ul6tMEruEC/axaVRosC8sJy8AcvveRPbDNTrlMaKAh08CplECivrFhYC/xfuzE4A0eT9vddMWhkLu7q9Rcrp2gp8G9J2kD84hhJl5hgd/khucg/2Fpt49tBBx5tFUtemFtU4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819564; c=relaxed/simple;
	bh=Z2Lu6fp7hgS+t8UgQUG2yU3FkRiF5IM8aE8wjUPcwZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkOmnffcMQtwpa9u9E+AGA2r/b/NQq2ZsWcpcc742wJg38Vw2h156QfhjYSj3/pnW85IgRf9SoXELJql237Isy8Qnd75dOvajexcx3c9BFNukPZi2kOWlqE+/LpQSy/F52ykVo0hnDRQBHSmfXJMcA0i3OjFjQKpzgHNIurSUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2Lh37GA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF0BC32781;
	Mon, 27 May 2024 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819563;
	bh=Z2Lu6fp7hgS+t8UgQUG2yU3FkRiF5IM8aE8wjUPcwZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C2Lh37GAeVQg5A0qg19GVfleMzdSkEsmV1FQtX7c8lTemcwwwCFyhMT9xgA0IizZX
	 uJoesFPPf6joaMYRAwX1dmmmrM3DHPla8tFuBs8/nKvqkeWgxiVoMXTJpmLQyOZOLi
	 CI09ddBKjlcjkHZ932r9r0KeCZaZFx18TXOzkwswdDYNHwBl6L1sluwc1dGSSVZAdv
	 o01G6MC4kQ0iYQ995xThGOLOT/sGwi/fMnjpHCVoRS8ovZ0essHjQ8+D1ILP95JSqf
	 4v7t/S29uaRRV2po8CwNK2M2oiFcpu6K73ivQVpD8k7NrIlO7bPEdUQ+bArzx2OKg4
	 icO1Xdl8TqTXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Kees Cook <keescook@chromium.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 05/13] af_packet: avoid a false positive warning in packet_setsockopt()
Date: Mon, 27 May 2024 10:18:42 -0400
Message-ID: <20240527141901.3854691-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141901.3854691-1-sashal@kernel.org>
References: <20240527141901.3854691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 86d43e2bf93ccac88ef71cee36a23282ebd9e427 ]

Although the code is correct, the following line

	copy_from_sockptr(&req_u.req, optval, len));

triggers this warning :

memcpy: detected field-spanning write (size 28) of single field "dst" at include/linux/sockptr.h:49 (size 16)

Refactor the code to be more explicit.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index db5d16c5d5b11..3ae11961c9cc3 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3762,28 +3762,30 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 	case PACKET_TX_RING:
 	{
 		union tpacket_req_u req_u;
-		int len;
 
+		ret = -EINVAL;
 		lock_sock(sk);
 		switch (po->tp_version) {
 		case TPACKET_V1:
 		case TPACKET_V2:
-			len = sizeof(req_u.req);
+			if (optlen < sizeof(req_u.req))
+				break;
+			ret = copy_from_sockptr(&req_u.req, optval,
+						sizeof(req_u.req)) ?
+						-EINVAL : 0;
 			break;
 		case TPACKET_V3:
 		default:
-			len = sizeof(req_u.req3);
+			if (optlen < sizeof(req_u.req3))
+				break;
+			ret = copy_from_sockptr(&req_u.req3, optval,
+						sizeof(req_u.req3)) ?
+						-EINVAL : 0;
 			break;
 		}
-		if (optlen < len) {
-			ret = -EINVAL;
-		} else {
-			if (copy_from_sockptr(&req_u.req, optval, len))
-				ret = -EFAULT;
-			else
-				ret = packet_set_ring(sk, &req_u, 0,
-						    optname == PACKET_TX_RING);
-		}
+		if (!ret)
+			ret = packet_set_ring(sk, &req_u, 0,
+					      optname == PACKET_TX_RING);
 		release_sock(sk);
 		return ret;
 	}
-- 
2.43.0



Return-Path: <stable+bounces-46363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621AB8D036F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3CC2A3A59
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A059172762;
	Mon, 27 May 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4KbzEoR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69C171E72;
	Mon, 27 May 2024 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819274; cv=none; b=Qzs7ATzdOAB1GSd/ZR2XpkgqzMhcYsMuQv1qGb7CIuY+ud+Qb0/po/pxKuhTgOQDZP0SpurosGL/GTfM9oWB38lHs+9aFBNrILgQDII9AdfPN969JQ9RKwMitq5t1zLVU5EqKN4ML8lX4mYZMURYShBqjeQwpJ9pIPO7w0bvrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819274; c=relaxed/simple;
	bh=SV6qtfU/+d4z44hjkPenfsRMaU8QjujnfZcfHZCustU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyCL6uCTsUzLcb8mI521aypNssGeBW8lU3CK4MQHr4SpJLORkd2QLtEJqmpJdPJeFPi5+kLbmKqbNRLG+5xSgDXYmswK8/EKlSzgmSMavHuVBNpZHZhxEdn+OHnnHsMn7Xxg6bpUIy/B4crHk2xv3yOsoMyger1q2RyPqkXA5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4KbzEoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1CFC2BBFC;
	Mon, 27 May 2024 14:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819273;
	bh=SV6qtfU/+d4z44hjkPenfsRMaU8QjujnfZcfHZCustU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4KbzEoR7RA4bQ+41hJ94S3DpDqdGOBqrSvNo86FtAjysbO/Iu20rKtcoR/lbwRD/
	 t/EdtE18tFvy9hcB5nUW1leRXpMed1lp5Jc+P2TCM8SkAHNVBmkMVpLmp6Uh6LXaPb
	 NVR36BetY1f3n+Htm421f0M2EnqamifgO17qjbKGyMaG5gucJWLLtihv7EFnsX36T6
	 8iNi/a+PINKJ0sUkH0AwxGLdNU7qhiwv/HpaqYLhyF2mgCefYca8iGEfkflos6Bb1e
	 PJr9F897quc0bFBLunyW0H/9Rs8J6zdIaoFdDbFbgmIQczuDPbbuY2Nbnvq7Ag5HDZ
	 gETA+rBFWE6kw==
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
Subject: [PATCH AUTOSEL 6.8 08/30] af_packet: avoid a false positive warning in packet_setsockopt()
Date: Mon, 27 May 2024 10:13:17 -0400
Message-ID: <20240527141406.3852821-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141406.3852821-1-sashal@kernel.org>
References: <20240527141406.3852821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
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
index e6a8701a38dbe..59ca1e321db16 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3800,28 +3800,30 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
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



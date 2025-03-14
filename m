Return-Path: <stable+bounces-124474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B650A61C2E
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 21:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559EC19C7C67
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 20:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01302066F5;
	Fri, 14 Mar 2025 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPHqsbuh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724562066C2;
	Fri, 14 Mar 2025 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983133; cv=none; b=NmFcLb2ht4cbP+eu2NdrFhN5ArjrRBiDoLV9KNBSn2VfLn8cVOMUpv6GA44juhWInGRMztJ1y3pB/8huCJQFZIZ/KObowdc21P837evdno8pRogaSJXOfWCSlOadkCKVwh84TxyADnPiCjTGZ4huqF+eoOCZkaLAJRC4JpTuroE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983133; c=relaxed/simple;
	bh=VNSKAbcRLuCrJ7z0XpO3AjyVVmDvQNQN+M90Z/9YUl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZStviCV4L5sLJ2s6e98ITgN/lw5AoBJ14ubEal/qiLUJnk6TwGI/bzXUalvWzstgybFjg7+RfHZLpZ/mcx/adH5eXb6MHch5xv9tUMTvSs8LmYABUkza8Psfje9svDm8cDTufvBPIEF+Yh9kfUFe+Y67tD6Gx6CkraI/yonxJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPHqsbuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C12C4CEEC;
	Fri, 14 Mar 2025 20:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741983132;
	bh=VNSKAbcRLuCrJ7z0XpO3AjyVVmDvQNQN+M90Z/9YUl4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fPHqsbuhJioIBVVFMH4ju/t30fEgMVYnwFEUlqldSTNKOznAO5Olcu86hOtBVs8/z
	 XX8ff5H5Pan/EWipX7+DKfMMzDvcGT9x0rO8Z3pLNQ3H2e50zLU1TUStez4HpS7A5m
	 KVPFyQ4oCBpJQNrNDuTbFEL2wVdIyJfmRoHfCvacuF9KEflpCiDU80cOXWbFWN1kJJ
	 jJIYGpST6amGCEoJ3jBAu4MKd9YMfSmnkV9T+g1EtSARxaU+I+vn7CojeZ7VCPNDI1
	 zpXZZDENQPOy6MHsJCMZxeqO4w2yStH5is4RCke7mxzqcAlNSISNqv7dCSLdpSZO+P
	 Ooax1C7O9/MSQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Mar 2025 21:11:33 +0100
Subject: [PATCH net 3/3] mptcp: sockopt: fix getting freebind & transparent
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-3-122dbb249db3@kernel.org>
References: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
In-Reply-To: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VNSKAbcRLuCrJ7z0XpO3AjyVVmDvQNQN+M90Z/9YUl4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn1I2Hfq5LsFzARDWfayx67sdfPp9WXUcvkhv+u
 Odk6YPT5H+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9SNhwAKCRD2t4JPQmmg
 c8FWD/9F+dbp1XxKCCOgUX8azpnuojlX7oNZuZjI0+jkr/rk9RNBL/JyuiYMDcFI+qIJG5cewgE
 /SpCuhz9Bl9hW0SvJADUO9Nw5SqynVahXT7bi36OC32V60M6xT4NJtHdVXj7gsMWNVy+Ox1nhmT
 GwmT7a4poKlTKUwrKr85BYFf3JE1psMp2vpuNlOKPDOaVr/YZ58pQrXVigJeePfSgfsnqK/M75K
 FWo2Ls+LU/3VmIybJ++W/5KiK895srJvrCCqOSxg/nOeqo9H0uBvP90KNorKKqia9WwNN0XtzWS
 bUNMAkm8vgCVT2Z8lkgHEHLLrUianyvRdxFxPNUIcXU/X6KAgk8Bd9djypRp+32TgqVqvyK/e0l
 cio2dkGnwqkVSOe9hWVvFKvp/9PesFY6MKRKKJBKnORlG3MDqRt5XgE73TX7XyMwXpP9NWyvFAA
 NmNXSoWr6fGHUJRoe6n1J3x12BqOEa6walGcwvxafu+keV/WXywJ9LwqlTQi1fxB8DwoHoT61LK
 q2PHfj4S9TYih0PIxgn4dk5ZciSdMFbJ/uTnDeisZ1WQqDcFB1SXJTz9q32JYBfWgr/8A+nEd4U
 FBgn5mKopJQp4EcMwf9PA9BJKZNIX78lpryqhgTWJ27hcicnfotGZGHPjnwG+Upqou6RneyA9Nd
 dujMkG7Ttw7QXqw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When adding a socket option support in MPTCP, both the get and set parts
are supposed to be implemented.

IP(V6)_FREEBIND and IP(V6)_TRANSPARENT support for the setsockopt part
has been added a while ago, but it looks like the get part got
forgotten. It should have been present as a way to verify a setting has
been set as expected, and not to act differently from TCP or any other
socket types.

Everything was in place to expose it, just the last step was missing.
Only new code is added to cover these specific getsockopt(), that seems
safe.

Fixes: c9406a23c116 ("mptcp: sockopt: add SOL_IP freebind & transparent options")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 4b99eb796855e4578d14df90f9d1cc3f1cd5b8c7..3caa0a9d3b3885ce6399570f2d98a2e8f103638d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1419,6 +1419,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case IP_TOS:
 		return mptcp_put_int_option(msk, optval, optlen, READ_ONCE(inet_sk(sk)->tos));
+	case IP_FREEBIND:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(FREEBIND, sk));
+	case IP_TRANSPARENT:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(TRANSPARENT, sk));
 	case IP_BIND_ADDRESS_NO_PORT:
 		return mptcp_put_int_option(msk, optval, optlen,
 				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
@@ -1439,6 +1445,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_V6ONLY:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    sk->sk_ipv6only);
+	case IPV6_TRANSPARENT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_test_bit(TRANSPARENT, sk));
+	case IPV6_FREEBIND:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_test_bit(FREEBIND, sk));
 	}
 
 	return -EOPNOTSUPP;

-- 
2.48.1



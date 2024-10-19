Return-Path: <stable+bounces-86904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C2A9A4C98
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 11:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2041F232C6
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0E81DE8A9;
	Sat, 19 Oct 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmETzjzP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF4120E30B;
	Sat, 19 Oct 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729330264; cv=none; b=prJmeFVVdQMTKagpFwguPC30mAejr4QTOj7iiY+UdLS5v31YrmzzUZHX5QAA2xIYKDmv8LOenqDS0n/3H52BE4xWhjiGjFC+riWwVwrhqt40g9UdDZsXOtT2AftlrHOiCM4baJy8r/NcgNPUw3NvKEy6MfArLL+ykj/I0UNvGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729330264; c=relaxed/simple;
	bh=Nyyi6ACpkxqqMbX5Gkw51cuc95MBO4KhdKwzS+r+J50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTW2RDp2xh/EYCEyhI6VdEnXQEkYbOsWUhVuPhQ7lp99ojUo8cGfVANdCk21if1WUnq9zuzTVyC/tlsVh+eNnmTS4CRzFbWXF4uUkCB6PM2eIshU03UqP/W54UX9puLX43PsrcBM1mfuqXsUz7jLRcftpD87JhkYmEdH3Kdj9Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmETzjzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD3EC4CED0;
	Sat, 19 Oct 2024 09:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729330263;
	bh=Nyyi6ACpkxqqMbX5Gkw51cuc95MBO4KhdKwzS+r+J50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmETzjzPnvUfEmJVTkjMHY3QsOu0CHec4Gy0NV1gmqYGjJSu9xa4Byp9JH0OkiJ/u
	 +sN2BAH/EAnv2MJZAZtc5xiwhnVX+yxbl4dwyKZwY4I1Uvir+DKE2X/m4w9ONgdqJk
	 9lKDUn/gp8jYNSQLg+V/y4bYBNsUsqD+1Y8UzI7kEsBsRduBgro+/y1ULY8i4UTTwV
	 ust6eMXB8C/WMtuMNGH3iVWE4TOiWwyJdKcjZe++shbQzWjOJw4k9Riyh+o+wd0mbC
	 CCKe1D3KIXr+h6BE8HYmwkv3yI55gqrQVowYffEutU5TcTFm5NLz12/cVeQdrVVBuQ
	 bUJzDTY5NPUHw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Christoph Paasch <cpaasch@apple.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y 4/6] mptcp: fallback when MPTCP opts are dropped after 1st data
Date: Sat, 19 Oct 2024 11:30:50 +0200
Message-ID: <20241019093045.3181989-12-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241019093045.3181989-8-matttbe@kernel.org>
References: <20241019093045.3181989-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3940; i=matttbe@kernel.org; h=from:subject; bh=Nyyi6ACpkxqqMbX5Gkw51cuc95MBO4KhdKwzS+r+J50=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnE3xFGUEfEP7Ckns19rPAK/Vfztapv1oUK75vJ vh75X7ct5mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxN8RQAKCRD2t4JPQmmg c8BIEACZqm8ARD/DgDdu3BGfbFcf3aVW6lDCrG6lfUI6hLAakqCtgQOKgxsDdeXDrsKBTf15Tte fZP8iW6afwRilg/ABv6jeaVzXz4MG+eikdZBMr+R8dafKRbyb/1CvmahhhOr7+CJRvUVREwzOnP I/aak9yCUZuxJd1l23HaOMvom+3Xm7Zr4USguD6me0KaEPz+Koypacrk7iT7IrMB3FUV946azWa URQza7WS1eShYn8NGPbA9pShxlPZEwgVKr+0WuT0MXIqQcSsBy2PS4NDh1rIEcu78LPu171HqN9 yxKPRQ6xRKGI2o4jpUlmzUMM6JzC9ONLWpbCmny4NnXqevd+o0crCaAB8XVDyWwpys2tkR/Twip qcgTYNLmRSI8ENuXGdsKNT27NzDeXcVehnKyhKplivnMcAp0kgZRuS6mvu11v+GCdSOSq79p/Zp cB7ZYbVZj+9sPuLDrlwRx7H0Ezv6ZaPga5hpwqyCuQZEdLWvNfHwu3+OwqOYN4E0ATcISPPNjuP 1UiTpxaCH5z+vHS0LFMwOzUQ3/hvQfLzoI0ixkI/BSLi4yYp5FUTOTozFX38/4o5qYqOaDFXPIw eZMHk+NUqx+zqUn+4FYj96oRTq0s+7Z1Dyt2fKnFB8UR3afpchhO65/zJDGQaZIWzOf+M8PRdWc JWmSIY2TYQRX2Gw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 119d51e225febc8152476340a880f5415a01e99e upstream.

As reported by Christoph [1], before this patch, an MPTCP connection was
wrongly reset when a host received a first data packet with MPTCP
options after the 3wHS, but got the next ones without.

According to the MPTCP v1 specs [2], a fallback should happen in this
case, because the host didn't receive a DATA_ACK from the other peer,
nor receive data for more than the initial window which implies a
DATA_ACK being received by the other peer.

The patch here re-uses the same logic as the one used in other places:
by looking at allow_infinite_fallback, which is disabled at the creation
of an additional subflow. It's not looking at the first DATA_ACK (or
implying one received from the other side) as suggested by the RFC, but
it is in continuation with what was already done, which is safer, and it
fixes the reported issue. The next step, looking at this first DATA_ACK,
is tracked in [4].

This patch has been validated using the following Packetdrill script:

   0 socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
  +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
  +0 bind(3, ..., ...) = 0
  +0 listen(3, 1) = 0

  // 3WHS is OK
  +0.0 < S  0:0(0)       win 65535  <mss 1460, sackOK, nop, nop, nop, wscale 6, mpcapable v1 flags[flag_h] nokey>
  +0.0 > S. 0:0(0) ack 1            <mss 1460, nop, nop, sackOK, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey]>
  +0.1 <  . 1:1(0) ack 1 win 2048                                              <mpcapable v1 flags[flag_h] key[ckey=2, skey]>
  +0 accept(3, ..., ...) = 4

  // Data from the client with valid MPTCP options (no DATA_ACK: normal)
  +0.1 < P. 1:501(500) ack 1 win 2048 <mpcapable v1 flags[flag_h] key[skey, ckey] mpcdatalen 500, nop, nop>
  // From here, the MPTCP options will be dropped by a middlebox
  +0.0 >  . 1:1(0)     ack 501        <dss dack8=501 dll=0 nocs>

  +0.1 read(4, ..., 500) = 500
  +0   write(4, ..., 100) = 100

  // The server replies with data, still thinking MPTCP is being used
  +0.0 > P. 1:101(100)   ack 501          <dss dack8=501 dsn8=1 ssn=1 dll=100 nocs, nop, nop>
  // But the client already did a fallback to TCP, because the two previous packets have been received without MPTCP options
  +0.1 <  . 501:501(0)   ack 101 win 2048

  +0.0 < P. 501:601(100) ack 101 win 2048
  // The server should fallback to TCP, not reset: it didn't get a DATA_ACK, nor data for more than the initial window
  +0.0 >  . 101:101(0)   ack 601

Note that this script requires Packetdrill with MPTCP support, see [3].

Fixes: dea2b1ea9c70 ("mptcp: do not reset MP_CAPABLE subflow on mapping errors")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/518 [1]
Link: https://datatracker.ietf.org/doc/html/rfc8684#name-fallback [2]
Link: https://github.com/multipath-tcp/packetdrill [3]
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/519 [4]
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241008-net-mptcp-fallback-fixes-v1-3-c6fb8e93e551@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7eff961267d0..feb146a62f97 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1152,7 +1152,7 @@ static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
 	else if (READ_ONCE(msk->csum_enabled))
 		return !subflow->valid_csum_seen;
 	else
-		return !subflow->fully_established;
+		return READ_ONCE(msk->allow_infinite_fallback);
 }
 
 static bool subflow_check_data_avail(struct sock *ssk)
-- 
2.45.2



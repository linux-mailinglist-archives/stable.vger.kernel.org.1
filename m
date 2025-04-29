Return-Path: <stable+bounces-138979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323B5AA3D45
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 01:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CA53BC6AB
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 23:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D4C2609D5;
	Tue, 29 Apr 2025 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WANShZIu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB692609CB;
	Tue, 29 Apr 2025 23:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970651; cv=none; b=oV4CELCICNXqXJa1WAWp8vDObKLtSYEGbfZ3CE9mFN7XVLJSmhfLMlAxgTK2Ib/AuJ/lrReiouW1Ifa3KdlLnPoWYNpUt5J5ePzaY/tFZ2QKbCIsZ4sarXUozIAec+0/jHG6oAR4D7EPcq1v98WI2U2QP8sdRWgWMQcqEj5Z9nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970651; c=relaxed/simple;
	bh=u33HoFmmCK0pFmTqeo/Y8LcitMwrP/XZyBldDFamwgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+kCck/L/fgs+JqevDraOqq645hghadsm7/NLwKTFd8pQNb6grZovWr7nvw0SYfMqsZmpXUw389OnsAXRZBmXPH2gDNZqsqlu4g3ok4F41AoEcDFdOOdy8JlUZMONotWI2gcrOtGDVRmS0b6JkgePDPE+wwiFKoHLRl0K7mrnac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WANShZIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DDAC4CEED;
	Tue, 29 Apr 2025 23:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970651;
	bh=u33HoFmmCK0pFmTqeo/Y8LcitMwrP/XZyBldDFamwgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WANShZIuD6hUbMZy8opEKmQc/T3C5q5oH9K6hq96dBEeRjoJGvoBXvGnpGBLOwvOk
	 wma4qye14fKmvUrMWIUWaL36uSsN95j+RDDgpBOTU+dq6sVPumAQ6tHvJPvkhCRv9y
	 He6eQgNO3Bn2GIrT+o8h9e8Ak0eAOECzk7BF6F0PtHXEanmCTOD9gRZEqGtUiVRyW/
	 +64EAxF2s6EDKkEmMX8knpqmAKSmK+abx/u1jYJX7nKabp0iESVWpYHCFEnP1JoLUT
	 WLiwNQj9J3f+4qSf6nI/1fs9Aw47pedzfhv3n4BTvHy+3abPFzI/uwE06x4fdGn/I6
	 v8vl0IcV8Kc+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 23/39] net: enetc: refactor bulk flipping of RX buffers to separate function
Date: Tue, 29 Apr 2025 19:49:50 -0400
Message-Id: <20250429235006.536648-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 1d587faa5be7e9785b682cc5f58ba8f4100c13ea ]

This small snippet of code ensures that we do something with the array
of RX software buffer descriptor elements after passing the skb to the
stack. In this case, we see if the other half of the page is reusable,
and if so, we "turn around" the buffers, making them directly usable by
enetc_refill_rx_ring() without going to enetc_new_page().

We will need to perform this kind of buffer flipping from a new code
path, i.e. from XDP_PASS. Currently, enetc_build_skb() does it there
buffer by buffer, but in a subsequent change we will stop using
enetc_build_skb() for XDP_PASS.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Link: https://patch.msgid.link/20250417120005.3288549-3-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 2106861463e40..15f510d0913d3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1850,6 +1850,16 @@ static void enetc_xdp_drop(struct enetc_bdr *rx_ring, int rx_ring_first,
 	}
 }
 
+static void enetc_bulk_flip_buff(struct enetc_bdr *rx_ring, int rx_ring_first,
+				 int rx_ring_last)
+{
+	while (rx_ring_first != rx_ring_last) {
+		enetc_flip_rx_buff(rx_ring,
+				   &rx_ring->rx_swbd[rx_ring_first]);
+		enetc_bdr_idx_inc(rx_ring, &rx_ring_first);
+	}
+}
+
 static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 				   struct napi_struct *napi, int work_limit,
 				   struct bpf_prog *prog)
@@ -1965,11 +1975,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 				enetc_xdp_drop(rx_ring, orig_i, i);
 				rx_ring->stats.xdp_redirect_failures++;
 			} else {
-				while (orig_i != i) {
-					enetc_flip_rx_buff(rx_ring,
-							   &rx_ring->rx_swbd[orig_i]);
-					enetc_bdr_idx_inc(rx_ring, &orig_i);
-				}
+				enetc_bulk_flip_buff(rx_ring, orig_i, i);
 				xdp_redirect_frm_cnt++;
 				rx_ring->stats.xdp_redirect++;
 			}
-- 
2.39.5



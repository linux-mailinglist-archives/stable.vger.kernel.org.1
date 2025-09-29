Return-Path: <stable+bounces-181927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DF1BA99EF
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899841921D32
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7975C30C0F8;
	Mon, 29 Sep 2025 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmSNZ5Sx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342AE30AD1E
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156733; cv=none; b=htobIRziYQhisCYkUq8nfzCJ9hQsR//uaJaULH6J5iU493Ud4VjOT7zcM6bayIaYKeDxEi52ARx+QMmWslDZbjdpMQCCYBKprGJ0Lk91adi4PUfmdqz39oNup56nQlLXIP9XT423FHaq9xa6p4fVpzwbn+xR75M5NvIgyj+krgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156733; c=relaxed/simple;
	bh=5f9AwXT/Q0hDY4eb6QiTw5AQ6+ZYHsLEVfJ6pYJqjJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1/VXJriJqX5UJOA0Tjtflfzl5MfFzIw7EWqGVCxh95PQoS/t+S2bOlQgLQMlxfdaU8P15lw/TossTXIQFtHfjxkiKSsKXpMYsLgKpXbgScbKRDPKVN+BU13JpCO5HVt+VXQXyetgCHGf2T31OmQU7XffdCojAveB/QveD919/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmSNZ5Sx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189FBC4CEF4;
	Mon, 29 Sep 2025 14:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759156732;
	bh=5f9AwXT/Q0hDY4eb6QiTw5AQ6+ZYHsLEVfJ6pYJqjJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmSNZ5SxhRCEPxQmHV2QA6Bd2eCWApQF8F5GeT28yr5lyrQRa/oQ4+YW3dl//0EqO
	 py7VYRBWzmN8By8GM/yTyCHLOJ4Z0y7532l0OYUvkZkS1q4TNeMH9qAjlEv03kGzxP
	 ribMl2sTOMhidbdR9LzL7EvS8axbO+ujGqnFx+yR7opYsjW5q/cNf9y8SrZfGaty99
	 05dVk/P52Yel0qOAlsrya7dEYK9qhI9PIU7T1+RnWc5v2FhvWBmjRj2a/sKccnn33E
	 1r565qS10vsHeUyI3XnVV2QP0OZ283eAZg11aQ34tEVQobQuJQ2B84gQeyJ+oPN/ZS
	 z/2xopbqbz8VQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Justin Bronder <jsbronder@cold-front.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] i40e: increase max descriptors for XL710
Date: Mon, 29 Sep 2025 10:38:49 -0400
Message-ID: <20250929143850.92375-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092935-hatred-salutary-8769@gregkh>
References: <2025092935-hatred-salutary-8769@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Justin Bronder <jsbronder@cold-front.org>

[ Upstream commit aa6908ca3bd1e713fd6cd8d7193a008f060bf7d9 ]

In Tables 8-12 and 8-22 in the X710/XXV710/XL710 datasheet, the QLEN
description states that the maximum size of the descriptor queue is 8k
minus 32, or 8160.

Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://lore.kernel.org/r/20231113231047.548659-2-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 55d225670def ("i40e: add validation for ring_len param")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 25 ++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 223d5831a5bbe..e031906f23a4f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -50,6 +50,7 @@
 #define I40E_MAX_VEB			16
 
 #define I40E_MAX_NUM_DESCRIPTORS	4096
+#define I40E_MAX_NUM_DESCRIPTORS_XL710	8160
 #define I40E_MAX_CSR_SPACE		(4 * 1024 * 1024 - 64 * 1024)
 #define I40E_DEFAULT_NUM_DESCRIPTORS	512
 #define I40E_REQ_DESCRIPTOR_MULTIPLE	32
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 504edc8ec531c..74a18b8df11f6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1918,6 +1918,18 @@ static void i40e_get_drvinfo(struct net_device *netdev,
 		drvinfo->n_priv_flags += I40E_GL_PRIV_FLAGS_STR_LEN;
 }
 
+static u32 i40e_get_max_num_descriptors(struct i40e_pf *pf)
+{
+	struct i40e_hw *hw = &pf->hw;
+
+	switch (hw->mac.type) {
+	case I40E_MAC_XL710:
+		return I40E_MAX_NUM_DESCRIPTORS_XL710;
+	default:
+		return I40E_MAX_NUM_DESCRIPTORS;
+	}
+}
+
 static void i40e_get_ringparam(struct net_device *netdev,
 			       struct ethtool_ringparam *ring)
 {
@@ -1925,8 +1937,8 @@ static void i40e_get_ringparam(struct net_device *netdev,
 	struct i40e_pf *pf = np->vsi->back;
 	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 
-	ring->rx_max_pending = I40E_MAX_NUM_DESCRIPTORS;
-	ring->tx_max_pending = I40E_MAX_NUM_DESCRIPTORS;
+	ring->rx_max_pending = i40e_get_max_num_descriptors(pf);
+	ring->tx_max_pending = i40e_get_max_num_descriptors(pf);
 	ring->rx_mini_max_pending = 0;
 	ring->rx_jumbo_max_pending = 0;
 	ring->rx_pending = vsi->rx_rings[0]->count;
@@ -1949,12 +1961,12 @@ static bool i40e_active_tx_ring_index(struct i40e_vsi *vsi, u16 index)
 static int i40e_set_ringparam(struct net_device *netdev,
 			      struct ethtool_ringparam *ring)
 {
+	u32 new_rx_count, new_tx_count, max_num_descriptors;
 	struct i40e_ring *tx_rings = NULL, *rx_rings = NULL;
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_hw *hw = &np->vsi->back->hw;
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	u32 new_rx_count, new_tx_count;
 	u16 tx_alloc_queue_pairs;
 	int timeout = 50;
 	int i, err = 0;
@@ -1962,14 +1974,15 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
 
-	if (ring->tx_pending > I40E_MAX_NUM_DESCRIPTORS ||
+	max_num_descriptors = i40e_get_max_num_descriptors(pf);
+	if (ring->tx_pending > max_num_descriptors ||
 	    ring->tx_pending < I40E_MIN_NUM_DESCRIPTORS ||
-	    ring->rx_pending > I40E_MAX_NUM_DESCRIPTORS ||
+	    ring->rx_pending > max_num_descriptors ||
 	    ring->rx_pending < I40E_MIN_NUM_DESCRIPTORS) {
 		netdev_info(netdev,
 			    "Descriptors requested (Tx: %d / Rx: %d) out of range [%d-%d]\n",
 			    ring->tx_pending, ring->rx_pending,
-			    I40E_MIN_NUM_DESCRIPTORS, I40E_MAX_NUM_DESCRIPTORS);
+			    I40E_MIN_NUM_DESCRIPTORS, max_num_descriptors);
 		return -EINVAL;
 	}
 
-- 
2.51.0



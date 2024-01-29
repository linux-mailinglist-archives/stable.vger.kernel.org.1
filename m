Return-Path: <stable+bounces-16640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BF5840DCE
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0BA1F2CF27
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBD215AAC6;
	Mon, 29 Jan 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2eTxPxXv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8058415AAC4;
	Mon, 29 Jan 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548169; cv=none; b=MihNqMaCgyHlettrwG5y16X7ch/gIZJgkB+lLSMo179fqb6hXpim8KwFAg0U0pDf/zpPSVPO79mELZ/uk38xyVXd6aQThb9wi28r341TrtF46UkwjU6q2GXWgKdOJHCVZq0bE+PepcHwAaSB1rddCqIE6BwafxhZomd5hCj9qG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548169; c=relaxed/simple;
	bh=oEQYZYQK+0cSHYMQLXb+fSNsIKzewubhkqYRXLEakVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ak9wpqQqhe0Mejk0eS1SxqVAxCOePIXs6o7+mXpBCc11SgAU3cbjWdjMMcyifpsU8O4W1vruxFYh1i0ZWAs7bRmwtBrJx7cRb5qQYX5XKPzoBdsfLAx350fsdADV8Tz9Zg/PKKHLgHa1fLdT70Ch+vHM+K00ehLrrU/bkbk/CzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2eTxPxXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498F5C433F1;
	Mon, 29 Jan 2024 17:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548169;
	bh=oEQYZYQK+0cSHYMQLXb+fSNsIKzewubhkqYRXLEakVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2eTxPxXvj0MEr5H9evq76oXec0kCw8SbstT2XEPwNyBSM0lmSOKiffgOlt2dTjnae
	 8G9E9yzvKVExJibg1rxaQfKJPKbwhoEHwmEMju50ClR/lZvoFWiYwlOJkkmhQvPDzb
	 UU/x6lkKIHt9aEJFAeXWDQdHY27lv3qsdzQzeqdA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 213/346] ice: update xdp_rxq_info::frag_size for ZC enabled Rx queue
Date: Mon, 29 Jan 2024 09:04:04 -0800
Message-ID: <20240129170022.648832388@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit 3de38c87174225487fc93befeea7d380db80aef6 ]

Now that ice driver correctly sets up frag_size in xdp_rxq_info, let us
make it work for ZC multi-buffer as well. ice_rx_ring::rx_buf_len for ZC
is being set via xsk_pool_get_rx_frame_size() and this needs to be
propagated up to xdp_rxq_info.

Use a bigger hammer and instead of unregistering only xdp_rxq_info's
memory model, unregister it altogether and register it again and have
xdp_rxq_info with correct frag_size value.

Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Link: https://lore.kernel.org/r/20240124191602.566724-9-maciej.fijalkowski@intel.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 37 ++++++++++++++---------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 7fa43827a3f0..4f3e65b47cdc 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -534,19 +534,27 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 	ring->rx_buf_len = ring->vsi->rx_buf_len;
 
 	if (ring->vsi->type == ICE_VSI_PF) {
-		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
-			/* coverity[check_return] */
-			__xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
-					   ring->q_index,
-					   ring->q_vector->napi.napi_id,
-					   ring->vsi->rx_buf_len);
+		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
+			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+						 ring->q_index,
+						 ring->q_vector->napi.napi_id,
+						 ring->rx_buf_len);
+			if (err)
+				return err;
+		}
 
 		ring->xsk_pool = ice_xsk_pool(ring);
 		if (ring->xsk_pool) {
-			xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
+			xdp_rxq_info_unreg(&ring->xdp_rxq);
 
 			ring->rx_buf_len =
 				xsk_pool_get_rx_frame_size(ring->xsk_pool);
+			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+						 ring->q_index,
+						 ring->q_vector->napi.napi_id,
+						 ring->rx_buf_len);
+			if (err)
+				return err;
 			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 							 MEM_TYPE_XSK_BUFF_POOL,
 							 NULL);
@@ -557,13 +565,14 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 			dev_info(dev, "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
 				 ring->q_index);
 		} else {
-			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
-				/* coverity[check_return] */
-				__xdp_rxq_info_reg(&ring->xdp_rxq,
-						   ring->netdev,
-						   ring->q_index,
-						   ring->q_vector->napi.napi_id,
-						   ring->vsi->rx_buf_len);
+			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
+				err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+							 ring->q_index,
+							 ring->q_vector->napi.napi_id,
+							 ring->rx_buf_len);
+				if (err)
+					return err;
+			}
 
 			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 							 MEM_TYPE_PAGE_SHARED,
-- 
2.43.0





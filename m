Return-Path: <stable+bounces-191753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADB7C211BF
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 17:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BD194E99A2
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 16:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE54365D2B;
	Thu, 30 Oct 2025 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b="gF6Wlzqj"
X-Original-To: stable@vger.kernel.org
Received: from mail.waldn.net (mail.waldn.net [216.66.77.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0B73655FF
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.66.77.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840660; cv=none; b=kDU6jKRAGpzsvCLstjtfwo5WS13qkMY7LDlL3wb1yqDEqbuttDOYoMFr+pObUR7bPdNnSTc+aP0HYrjnG6H+1zN6EW55EIPdTokkR3bVVoQXqtlQdsaOVVNeO8Ij0S9M/nm+PgN8JgDz2Lry2JMaSbTfnKnmy1wmei9RYg0ubjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840660; c=relaxed/simple;
	bh=Fhb1jWToGOp2UJScGPydr4LFzJg7iBkOtAxvT600dlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUCbMn6Vo5g2lxcaFbKi/Xmg92LSaL9gOfiqXyEfmBmI72EC51tLwu69K3fMoQxE46NcBzreS8OS3WYmupTCAsFSc8HH0odmcxn/fvE5oYXR62MNmdahtVg12xcizVZGLR9pYx3u98+2UKNiwUsQhrtrZzp7CvaaRRLb3cXayNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net; spf=pass smtp.mailfrom=waldn.net; dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b=gF6Wlzqj; arc=none smtp.client-ip=216.66.77.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldn.net
From: Amelia Crate <acrate@waldn.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waldn.net; s=mail;
	t=1761840657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gn6gshkfNuvC4H96ZtnN69vmBa95IsgfyRHMArXU+A=;
	b=gF6WlzqjQttL6udFJlZNGdljeSxAuS62C/024fo35auSgp5WkvFTeUV/0ydGJkAaxoJpxV
	A+743/cUeD36wgvTwPPydAgOdOR1KaQqhp5D/LQRjD/8rfvL2NQeuVYeywlVJ6OJY2GEYe
	nLjVEPwNrOpq7N4ZVuPlo7qGs9WCbr0=
To: gregkh@linuxfoundation.org
Cc: dimitri.ledkov@surgut.co.uk,
	stable@vger.kernel.org,
	Edward Cree <ecree.xilinx@gmail.com>,
	Kyungwook Boo <bookyungwook@gmail.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Amelia Crate <acrate@waldn.net>
Subject: [PATCH v2 4/4] sfc: fix NULL dereferences in ef100_process_design_param()
Date: Thu, 30 Oct 2025 11:08:34 -0500
Message-ID: <20251030160942.19490-5-acrate@waldn.net>
In-Reply-To: <20251030160942.19490-1-acrate@waldn.net>
References: <2025103043-refinish-preformed-280e@gregkh>
 <20251030160942.19490-1-acrate@waldn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Cree <ecree.xilinx@gmail.com>

[ Upstream commit 8241ecec1cdc6699ae197d52d58e76bddd995fa5 ]

Since cited commit, ef100_probe_main() and hence also
 ef100_check_design_params() run before efx->net_dev is created;
 consequently, we cannot netif_set_tso_max_size() or _segs() at this
 point.
Move those netif calls to ef100_probe_netdev(), and also replace
 netif_err within the design params code with pci_err.

Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
Fixes: 98ff4c7c8ac7 ("sfc: Separate netdev probe/remove from PCI probe/remove")
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Link: https://patch.msgid.link/20250401225439.2401047-1-edward.cree@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Amelia Crate <acrate@waldn.net>
---
 drivers/net/ethernet/sfc/ef100_netdev.c |  6 ++--
 drivers/net/ethernet/sfc/ef100_nic.c    | 47 +++++++++++--------------
 2 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef100_netdev.c b/drivers/net/ethernet/sfc/ef100_netdev.c
index 7f7d560cb2b4..14dcca4ffb33 100644
--- a/drivers/net/ethernet/sfc/ef100_netdev.c
+++ b/drivers/net/ethernet/sfc/ef100_netdev.c
@@ -450,8 +450,9 @@ int ef100_probe_netdev(struct efx_probe_data *probe_data)
 	net_dev->hw_enc_features |= efx->type->offload_features;
 	net_dev->vlan_features |= NETIF_F_HW_CSUM | NETIF_F_SG |
 				  NETIF_F_HIGHDMA | NETIF_F_ALL_TSO;
-	netif_set_tso_max_segs(net_dev,
-			       ESE_EF100_DP_GZ_TSO_MAX_HDR_NUM_SEGS_DEFAULT);
+	nic_data = efx->nic_data;
+	netif_set_tso_max_size(efx->net_dev, nic_data->tso_max_payload_len);
+	netif_set_tso_max_segs(efx->net_dev, nic_data->tso_max_payload_num_segs);
 	efx->mdio.dev = net_dev;
 
 	rc = efx_ef100_init_datapath_caps(efx);
@@ -478,7 +479,6 @@ int ef100_probe_netdev(struct efx_probe_data *probe_data)
 	/* Don't fail init if RSS setup doesn't work. */
 	efx_mcdi_push_default_indir_table(efx, efx->n_rx_channels);
 
-	nic_data = efx->nic_data;
 	rc = ef100_get_mac_address(efx, net_dev->perm_addr, CLIENT_HANDLE_SELF,
 				   efx->type->is_vf);
 	if (rc)
diff --git a/drivers/net/ethernet/sfc/ef100_nic.c b/drivers/net/ethernet/sfc/ef100_nic.c
index 6da06931187d..5b1bdcac81d9 100644
--- a/drivers/net/ethernet/sfc/ef100_nic.c
+++ b/drivers/net/ethernet/sfc/ef100_nic.c
@@ -887,8 +887,7 @@ static int ef100_process_design_param(struct efx_nic *efx,
 	case ESE_EF100_DP_GZ_TSO_MAX_HDR_NUM_SEGS:
 		/* We always put HDR_NUM_SEGS=1 in our TSO descriptors */
 		if (!reader->value) {
-			netif_err(efx, probe, efx->net_dev,
-				  "TSO_MAX_HDR_NUM_SEGS < 1\n");
+			pci_err(efx->pci_dev, "TSO_MAX_HDR_NUM_SEGS < 1\n");
 			return -EOPNOTSUPP;
 		}
 		return 0;
@@ -901,32 +900,28 @@ static int ef100_process_design_param(struct efx_nic *efx,
 		 */
 		if (!reader->value || reader->value > EFX_MIN_DMAQ_SIZE ||
 		    EFX_MIN_DMAQ_SIZE % (u32)reader->value) {
-			netif_err(efx, probe, efx->net_dev,
-				  "%s size granularity is %llu, can't guarantee safety\n",
-				  reader->type == ESE_EF100_DP_GZ_RXQ_SIZE_GRANULARITY ? "RXQ" : "TXQ",
-				  reader->value);
+			pci_err(efx->pci_dev,
+				"%s size granularity is %llu, can't guarantee safety\n",
+				reader->type == ESE_EF100_DP_GZ_RXQ_SIZE_GRANULARITY ? "RXQ" : "TXQ",
+				reader->value);
 			return -EOPNOTSUPP;
 		}
 		return 0;
 	case ESE_EF100_DP_GZ_TSO_MAX_PAYLOAD_LEN:
 		nic_data->tso_max_payload_len = min_t(u64, reader->value,
 						      GSO_LEGACY_MAX_SIZE);
-		netif_set_tso_max_size(efx->net_dev,
-				       nic_data->tso_max_payload_len);
 		return 0;
 	case ESE_EF100_DP_GZ_TSO_MAX_PAYLOAD_NUM_SEGS:
 		nic_data->tso_max_payload_num_segs = min_t(u64, reader->value, 0xffff);
-		netif_set_tso_max_segs(efx->net_dev,
-				       nic_data->tso_max_payload_num_segs);
 		return 0;
 	case ESE_EF100_DP_GZ_TSO_MAX_NUM_FRAMES:
 		nic_data->tso_max_frames = min_t(u64, reader->value, 0xffff);
 		return 0;
 	case ESE_EF100_DP_GZ_COMPAT:
 		if (reader->value) {
-			netif_err(efx, probe, efx->net_dev,
-				  "DP_COMPAT has unknown bits %#llx, driver not compatible with this hw\n",
-				  reader->value);
+			pci_err(efx->pci_dev,
+				"DP_COMPAT has unknown bits %#llx, driver not compatible with this hw\n",
+				reader->value);
 			return -EOPNOTSUPP;
 		}
 		return 0;
@@ -946,10 +941,10 @@ static int ef100_process_design_param(struct efx_nic *efx,
 		 * So the value of this shouldn't matter.
 		 */
 		if (reader->value != ESE_EF100_DP_GZ_VI_STRIDES_DEFAULT)
-			netif_dbg(efx, probe, efx->net_dev,
-				  "NIC has other than default VI_STRIDES (mask "
-				  "%#llx), early probing might use wrong one\n",
-				  reader->value);
+			pci_dbg(efx->pci_dev,
+				"NIC has other than default VI_STRIDES (mask "
+				"%#llx), early probing might use wrong one\n",
+				reader->value);
 		return 0;
 	case ESE_EF100_DP_GZ_RX_MAX_RUNT:
 		/* Driver doesn't look at L2_STATUS:LEN_ERR bit, so we don't
@@ -961,9 +956,9 @@ static int ef100_process_design_param(struct efx_nic *efx,
 		/* Host interface says "Drivers should ignore design parameters
 		 * that they do not recognise."
 		 */
-		netif_dbg(efx, probe, efx->net_dev,
-			  "Ignoring unrecognised design parameter %u\n",
-			  reader->type);
+		pci_dbg(efx->pci_dev,
+			"Ignoring unrecognised design parameter %u\n",
+			reader->type);
 		return 0;
 	}
 }
@@ -999,13 +994,13 @@ static int ef100_check_design_params(struct efx_nic *efx)
 	 */
 	if (reader.state != EF100_TLV_TYPE) {
 		if (reader.state == EF100_TLV_TYPE_CONT)
-			netif_err(efx, probe, efx->net_dev,
-				  "truncated design parameter (incomplete type %u)\n",
-				  reader.type);
+			pci_err(efx->pci_dev,
+				"truncated design parameter (incomplete type %u)\n",
+				reader.type);
 		else
-			netif_err(efx, probe, efx->net_dev,
-				  "truncated design parameter %u\n",
-				  reader.type);
+			pci_err(efx->pci_dev,
+				"truncated design parameter %u\n",
+				reader.type);
 		rc = -EIO;
 	}
 out:
-- 
2.50.1



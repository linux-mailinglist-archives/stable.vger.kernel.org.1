Return-Path: <stable+bounces-18142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E6584818C
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1FE282CB2
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755732C694;
	Sat,  3 Feb 2024 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nm/rt54x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35870F9E9;
	Sat,  3 Feb 2024 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933578; cv=none; b=S6+4gFolReu6GpqdU8vmJ2espvaDVTlASuTZ4s+Nim0Sm7XDfRTex7mAR60ZRxorPMD9LyaAAkeoEe+pxL6KykuHJF0g/CixEaQkKVaymz/f9pSnlwPO0GC2a9LkDw3aOcHrhzwxKAcK5EyJQdN2dvj5GWIYdn4tRSTToUYTR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933578; c=relaxed/simple;
	bh=kBqpRAxxhoRVy/YH7zZZEbu4s8868p16X6fUEQ/gGOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jto9U7I+s+75W5sjfXCWvl0WUUQoP0QW4XPHJJteXTNcmkom/lPM3PXrI8tvlwkJ24PQhRicVTOnQDmJ+w/lzm6/drDsXqqDn0lZXtnKyRg3I/Yey2JW1PLuWxV14PvHgxsKEa8nhTqE9Pif+mPjC4mArJF4IPi+fiVKKag06UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nm/rt54x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F000CC433C7;
	Sat,  3 Feb 2024 04:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933578;
	bh=kBqpRAxxhoRVy/YH7zZZEbu4s8868p16X6fUEQ/gGOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nm/rt54xXJ2EZYxJ2hO68pUNTQnBy5mj1IyR15yA23wSaGfRkAbJ9po5zBO6hdeTY
	 iDjULIJJEIQL7EVKKyp6s1wnDiK7Pn758P0n/SvX7nAGu41aLUjSPV7Ng2TRw/GKx7
	 V4APkyavws0w3Be1AhyQpXCxkEPYwVOu7dVfj67g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 6.6 138/322] ice: fix pre-shifted bit usage
Date: Fri,  2 Feb 2024 20:03:55 -0800
Message-ID: <20240203035403.616496713@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

[ Upstream commit 7173be21ae29ef50ada42fd4464056a9d3f55bb3 ]

While converting to FIELD_PREP() and FIELD_GET(), it was noticed that
some of the RSS defines had *included* the shift in their definitions.
This is completely outside of normal, such that a developer could easily
make a mistake and shift at the usage site (like when using
FIELD_PREP()).

Rename the defines and set them to the "pre-shifted values" so they
match the template the driver normally uses for masks and the member
bits of the mask, which also allows the driver to use FIELD_PREP
correctly with these values. Use GENMASK() for this changed MASK value.

Do the same for the VLAN EMODE defines as well.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h  | 10 +++++-----
 drivers/net/ethernet/intel/ice/ice_lib.c         |  3 ++-
 .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c    | 16 +++++++++++-----
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index fafe083d1446..45f3e351653d 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -421,10 +421,10 @@ struct ice_aqc_vsi_props {
 #define ICE_AQ_VSI_INNER_VLAN_INSERT_PVID	BIT(2)
 #define ICE_AQ_VSI_INNER_VLAN_EMODE_S		3
 #define ICE_AQ_VSI_INNER_VLAN_EMODE_M		(0x3 << ICE_AQ_VSI_INNER_VLAN_EMODE_S)
-#define ICE_AQ_VSI_INNER_VLAN_EMODE_STR_BOTH	(0x0 << ICE_AQ_VSI_INNER_VLAN_EMODE_S)
-#define ICE_AQ_VSI_INNER_VLAN_EMODE_STR_UP	(0x1 << ICE_AQ_VSI_INNER_VLAN_EMODE_S)
-#define ICE_AQ_VSI_INNER_VLAN_EMODE_STR		(0x2 << ICE_AQ_VSI_INNER_VLAN_EMODE_S)
-#define ICE_AQ_VSI_INNER_VLAN_EMODE_NOTHING	(0x3 << ICE_AQ_VSI_INNER_VLAN_EMODE_S)
+#define ICE_AQ_VSI_INNER_VLAN_EMODE_STR_BOTH	0x0U
+#define ICE_AQ_VSI_INNER_VLAN_EMODE_STR_UP	0x1U
+#define ICE_AQ_VSI_INNER_VLAN_EMODE_STR		0x2U
+#define ICE_AQ_VSI_INNER_VLAN_EMODE_NOTHING	0x3U
 	u8 inner_vlan_reserved2[3];
 	/* ingress egress up sections */
 	__le32 ingress_table; /* bitmap, 3 bits per up */
@@ -490,7 +490,7 @@ struct ice_aqc_vsi_props {
 #define ICE_AQ_VSI_Q_OPT_RSS_GBL_LUT_S		2
 #define ICE_AQ_VSI_Q_OPT_RSS_GBL_LUT_M		(0xF << ICE_AQ_VSI_Q_OPT_RSS_GBL_LUT_S)
 #define ICE_AQ_VSI_Q_OPT_RSS_HASH_S		6
-#define ICE_AQ_VSI_Q_OPT_RSS_HASH_M		(0x3 << ICE_AQ_VSI_Q_OPT_RSS_HASH_S)
+#define ICE_AQ_VSI_Q_OPT_RSS_HASH_M		GENMASK(7, 6)
 #define ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ		0x0U
 #define ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ	0x1U
 #define ICE_AQ_VSI_Q_OPT_RSS_HASH_XOR		0x2U
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 4e7f67f54f1c..7f4bc110ead4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -979,7 +979,8 @@ static void ice_set_dflt_vsi_ctx(struct ice_hw *hw, struct ice_vsi_ctx *ctxt)
 	 */
 	if (ice_is_dvm_ena(hw)) {
 		ctxt->info.inner_vlan_flags |=
-			ICE_AQ_VSI_INNER_VLAN_EMODE_NOTHING;
+			FIELD_PREP(ICE_AQ_VSI_INNER_VLAN_EMODE_M,
+				   ICE_AQ_VSI_INNER_VLAN_EMODE_NOTHING);
 		ctxt->info.outer_vlan_flags =
 			(ICE_AQ_VSI_OUTER_VLAN_TX_MODE_ALL <<
 			 ICE_AQ_VSI_OUTER_VLAN_TX_MODE_S) &
diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
index 76266e709a39..8307902115ff 100644
--- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
@@ -131,6 +131,7 @@ static int ice_vsi_manage_vlan_stripping(struct ice_vsi *vsi, bool ena)
 {
 	struct ice_hw *hw = &vsi->back->hw;
 	struct ice_vsi_ctx *ctxt;
+	u8 *ivf;
 	int err;
 
 	/* do not allow modifying VLAN stripping when a port VLAN is configured
@@ -143,19 +144,24 @@ static int ice_vsi_manage_vlan_stripping(struct ice_vsi *vsi, bool ena)
 	if (!ctxt)
 		return -ENOMEM;
 
+	ivf = &ctxt->info.inner_vlan_flags;
+
 	/* Here we are configuring what the VSI should do with the VLAN tag in
 	 * the Rx packet. We can either leave the tag in the packet or put it in
 	 * the Rx descriptor.
 	 */
-	if (ena)
+	if (ena) {
 		/* Strip VLAN tag from Rx packet and put it in the desc */
-		ctxt->info.inner_vlan_flags = ICE_AQ_VSI_INNER_VLAN_EMODE_STR_BOTH;
-	else
+		*ivf = FIELD_PREP(ICE_AQ_VSI_INNER_VLAN_EMODE_M,
+				  ICE_AQ_VSI_INNER_VLAN_EMODE_STR_BOTH);
+	} else {
 		/* Disable stripping. Leave tag in packet */
-		ctxt->info.inner_vlan_flags = ICE_AQ_VSI_INNER_VLAN_EMODE_NOTHING;
+		*ivf = FIELD_PREP(ICE_AQ_VSI_INNER_VLAN_EMODE_M,
+				  ICE_AQ_VSI_INNER_VLAN_EMODE_NOTHING);
+	}
 
 	/* Allow all packets untagged/tagged */
-	ctxt->info.inner_vlan_flags |= ICE_AQ_VSI_INNER_VLAN_TX_MODE_ALL;
+	*ivf |= ICE_AQ_VSI_INNER_VLAN_TX_MODE_ALL;
 
 	ctxt->info.valid_sections = cpu_to_le16(ICE_AQ_VSI_PROP_VLAN_VALID);
 
-- 
2.43.0





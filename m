Return-Path: <stable+bounces-61220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A22193A9ED
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 01:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7992D1F23547
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 23:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52055149C55;
	Tue, 23 Jul 2024 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoWjQ2Qp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8D1494B1;
	Tue, 23 Jul 2024 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721777570; cv=none; b=MTB+HspOHAXXi6lGuylBNK0McrgkQwMyg+OTSD33Pmp2j7Qe4cLObeRAuWXMS2shKdGlGfkpBMhz8C6qmJTb6k1gep0gwsanWWZif5RgGMZOOqXjrzqCguoGiW+uyvmEgiPZGjFjw4K23A+MfVYv7sZ7XNsxl/6tA4iE4cTQkF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721777570; c=relaxed/simple;
	bh=eKog2Ep3dti5ZCaAkQIODl65EVfABP7KbitPd02YmDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWGhASewGaiNg1xxdyhvQaP7U4pQQfvPwsdV7BSKMm8yKVIGh161mwzE5J/ngQsYcH/pBqp6wiXxOKl0koYqplbYqbxU52kq5jtdpccXDycShAWuchuKn2/CZ3f+9R5IDHRFlvYNp6YsIfST9jd7okG/WAbXtcnD4BrN6rd/v/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoWjQ2Qp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721777569; x=1753313569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eKog2Ep3dti5ZCaAkQIODl65EVfABP7KbitPd02YmDg=;
  b=MoWjQ2Qp/kIqD6mUwbWp/ftlonf8xTiILrIj/6Im9dFN8benRa3TVg4V
   V4alse0imLN0117roV2Mi7ZBbB5k8y8e1xFztSz9GpTi0CgOpb4vAuMoL
   7dg7IRISZ3t/9nKThELWzM7LfDQ7FlFubdDRxrG/e819gvePjetWtVN2/
   J8LT81LBCupz8Q6BT/7+C5r82+Q5QteBtUx+PDjQts50HYaL6BhD6sgoV
   i2/oEUGqR7QX7Uf9po0XRV3ct71FPQIPqRtb6lFv2/+ZY7eADy8m4WvJN
   gSgV3LhxJuq1Q9A4aFMKI2y+meXB3PM+ovaz+r5feHZvzu18f7+/XyRIe
   Q==;
X-CSE-ConnectionGUID: kTr0XR/pRq64r4NuFh/oTQ==
X-CSE-MsgGUID: IzcHURH2S4WPyfiZVKiVdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30049074"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="30049074"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 16:32:46 -0700
X-CSE-ConnectionGUID: AoIF7R08RaencD5z7N4/hQ==
X-CSE-MsgGUID: XebpQBRzSYa4fJTBt56PNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="89847952"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 23 Jul 2024 16:32:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ahmed Zaki <ahmed.zaki@intel.com>,
	anthony.l.nguyen@intel.com,
	stable@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 1/2] ice: Add a per-VF limit on number of FDIR filters
Date: Tue, 23 Jul 2024 16:32:39 -0700
Message-ID: <20240723233242.3146628-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723233242.3146628-1-anthony.l.nguyen@intel.com>
References: <20240723233242.3146628-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Zaki <ahmed.zaki@intel.com>

While the iavf driver adds a s/w limit (128) on the number of FDIR
filters that the VF can request, a malicious VF driver can request more
than that and exhaust the resources for other VFs.

Add a similar limit in ice.

CC: stable@vger.kernel.org
Fixes: 1f7ea1cd6a37 ("ice: Enable FDIR Configure for AVF")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Suggested-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice_fdir.h        |  3 +++
 .../net/ethernet/intel/ice/ice_virtchnl_fdir.c   | 16 ++++++++++++++++
 .../net/ethernet/intel/ice/ice_virtchnl_fdir.h   |  1 +
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index e3cab8e98f52..5412eff8ef23 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -534,7 +534,7 @@ ice_parse_rx_flow_user_data(struct ethtool_rx_flow_spec *fsp,
  *
  * Returns the number of available flow director filters to this VSI
  */
-static int ice_fdir_num_avail_fltr(struct ice_hw *hw, struct ice_vsi *vsi)
+int ice_fdir_num_avail_fltr(struct ice_hw *hw, struct ice_vsi *vsi)
 {
 	u16 vsi_num = ice_get_hw_vsi_num(hw, vsi->idx);
 	u16 num_guar;
diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.h b/drivers/net/ethernet/intel/ice/ice_fdir.h
index 021ecbac7848..ab5b118daa2d 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.h
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.h
@@ -207,6 +207,8 @@ struct ice_fdir_base_pkt {
 	const u8 *tun_pkt;
 };
 
+struct ice_vsi;
+
 int ice_alloc_fd_res_cntr(struct ice_hw *hw, u16 *cntr_id);
 int ice_free_fd_res_cntr(struct ice_hw *hw, u16 cntr_id);
 int ice_alloc_fd_guar_item(struct ice_hw *hw, u16 *cntr_id, u16 num_fltr);
@@ -218,6 +220,7 @@ int
 ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 			  u8 *pkt, bool frag, bool tun);
 int ice_get_fdir_cnt_all(struct ice_hw *hw);
+int ice_fdir_num_avail_fltr(struct ice_hw *hw, struct ice_vsi *vsi);
 bool ice_fdir_is_dup_fltr(struct ice_hw *hw, struct ice_fdir_fltr *input);
 bool ice_fdir_has_frag(enum ice_fltr_ptype flow);
 struct ice_fdir_fltr *
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index 8e4ff3af86c6..b4feb0927687 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -536,6 +536,8 @@ static void ice_vc_fdir_reset_cnt_all(struct ice_vf_fdir *fdir)
 		fdir->fdir_fltr_cnt[flow][0] = 0;
 		fdir->fdir_fltr_cnt[flow][1] = 0;
 	}
+
+	fdir->fdir_fltr_cnt_total = 0;
 }
 
 /**
@@ -1560,6 +1562,7 @@ ice_vc_add_fdir_fltr_post(struct ice_vf *vf, struct ice_vf_fdir_ctx *ctx,
 	resp->status = status;
 	resp->flow_id = conf->flow_id;
 	vf->fdir.fdir_fltr_cnt[conf->input.flow_type][is_tun]++;
+	vf->fdir.fdir_fltr_cnt_total++;
 
 	ret = ice_vc_send_msg_to_vf(vf, ctx->v_opcode, v_ret,
 				    (u8 *)resp, len);
@@ -1624,6 +1627,7 @@ ice_vc_del_fdir_fltr_post(struct ice_vf *vf, struct ice_vf_fdir_ctx *ctx,
 	resp->status = status;
 	ice_vc_fdir_remove_entry(vf, conf, conf->flow_id);
 	vf->fdir.fdir_fltr_cnt[conf->input.flow_type][is_tun]--;
+	vf->fdir.fdir_fltr_cnt_total--;
 
 	ret = ice_vc_send_msg_to_vf(vf, ctx->v_opcode, v_ret,
 				    (u8 *)resp, len);
@@ -1790,6 +1794,7 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
 	struct virtchnl_fdir_add *stat = NULL;
 	struct virtchnl_fdir_fltr_conf *conf;
 	enum virtchnl_status_code v_ret;
+	struct ice_vsi *vf_vsi;
 	struct device *dev;
 	struct ice_pf *pf;
 	int is_tun = 0;
@@ -1798,6 +1803,17 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
 
 	pf = vf->pf;
 	dev = ice_pf_to_dev(pf);
+	vf_vsi = ice_get_vf_vsi(vf);
+
+#define ICE_VF_MAX_FDIR_FILTERS	128
+	if (!ice_fdir_num_avail_fltr(&pf->hw, vf_vsi) ||
+	    vf->fdir.fdir_fltr_cnt_total >= ICE_VF_MAX_FDIR_FILTERS) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		dev_err(dev, "Max number of FDIR filters for VF %d is reached\n",
+			vf->vf_id);
+		goto err_exit;
+	}
+
 	ret = ice_vc_fdir_param_check(vf, fltr->vsi_id);
 	if (ret) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h
index c5bcc8d7481c..ac6dcab454b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h
@@ -29,6 +29,7 @@ struct ice_vf_fdir_ctx {
 struct ice_vf_fdir {
 	u16 fdir_fltr_cnt[ICE_FLTR_PTYPE_MAX][ICE_FD_HW_SEG_MAX];
 	int prof_entry_cnt[ICE_FLTR_PTYPE_MAX][ICE_FD_HW_SEG_MAX];
+	u16 fdir_fltr_cnt_total;
 	struct ice_fd_hw_prof **fdir_prof;
 
 	struct idr fdir_rule_idr;
-- 
2.41.0



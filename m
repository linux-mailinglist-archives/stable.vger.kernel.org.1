Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE1670C7A1
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjEVTbz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjEVTbz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:31:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07375A3
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C9E96291B
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9391DC4339C;
        Mon, 22 May 2023 19:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783911;
        bh=VDNU54/BjLgh76FFL22BvmbunxZGvzVquXxCLaGrwvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GpR6Kyt2U/mmnsT1MOudIa2KIDFMyI82pQ7WGIVeKoXLLuaS5oypp3zKqA6WNLqsx
         L8r9KCqagHdaU048M/kG70gCLsDJp2BH+Xl9/Djp/BoAVAXHZlo8MwTtOF+G5OKC/f
         JXhQznZXrm9NZR5xKLErxFvKPPjIVa8953RznAtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jacob Keller <jacob.e.keller@intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Marek Szlosek <marek.szlosek@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 202/292] ice: introduce clear_reset_state operation
Date:   Mon, 22 May 2023 20:09:19 +0100
Message-Id: <20230522190411.007111245@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit fa4a15c85c849e92257da6dbffeb1e3a6399fd7b ]

When hardware is reset, the VF relies on the VFGEN_RSTAT register to detect
when the VF is finished resetting. This is a tri-state register where 0
indicates a reset is in progress, 1 indicates the hardware is done
resetting, and 2 indicates that the software is done resetting.

Currently the PF driver relies on the device hardware resetting VFGEN_RSTAT
when a global reset occurs. This works ok, but it does mean that the VF
might not immediately notice a reset when the driver first detects that the
global reset is occurring.

This is also problematic for Scalable IOV, because there is no read/write
equivalent VFGEN_RSTAT register for the Scalable VSI type. Instead, the
Scalable IOV VFs will need to emulate this register.

To support this, introduce a new VF operation, clear_reset_state, which is
called when the PF driver first detects a global reset. The Single Root IOV
implementation can just write to VFGEN_RSTAT to ensure it's cleared
immediately, without waiting for the actual hardware reset to begin. The
Scalable IOV implementation will use this as part of its tracking of the
reset status to allow properly reporting the emulated VFGEN_RSTAT to the VF
driver.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Marek Szlosek <marek.szlosek@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: 7255355a0636 ("ice: Fix ice VF reset during iavf initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c   |  2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c  | 16 ++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 12 +++++++++++-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h |  5 +++--
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index cfc57cfc46e42..6a50f8ba3940c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -573,7 +573,7 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	/* Disable VFs until reset is completed */
 	mutex_lock(&pf->vfs.table_lock);
 	ice_for_each_vf(pf, bkt, vf)
-		ice_set_vf_state_qs_dis(vf);
+		ice_set_vf_state_dis(vf);
 	mutex_unlock(&pf->vfs.table_lock);
 
 	if (ice_is_eswitch_mode_switchdev(pf)) {
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index b3849bc3d4fc6..b719e9a771e36 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -696,6 +696,21 @@ static void ice_sriov_free_vf(struct ice_vf *vf)
 	kfree_rcu(vf, rcu);
 }
 
+/**
+ * ice_sriov_clear_reset_state - clears VF Reset status register
+ * @vf: the vf to configure
+ */
+static void ice_sriov_clear_reset_state(struct ice_vf *vf)
+{
+	struct ice_hw *hw = &vf->pf->hw;
+
+	/* Clear the reset status register so that VF immediately sees that
+	 * the device is resetting, even if hardware hasn't yet gotten around
+	 * to clearing VFGEN_RSTAT for us.
+	 */
+	wr32(hw, VFGEN_RSTAT(vf->vf_id), VIRTCHNL_VFR_INPROGRESS);
+}
+
 /**
  * ice_sriov_clear_mbx_register - clears SRIOV VF's mailbox registers
  * @vf: the vf to configure
@@ -835,6 +850,7 @@ static void ice_sriov_post_vsi_rebuild(struct ice_vf *vf)
 static const struct ice_vf_ops ice_sriov_vf_ops = {
 	.reset_type = ICE_VF_RESET,
 	.free = ice_sriov_free_vf,
+	.clear_reset_state = ice_sriov_clear_reset_state,
 	.clear_mbx_register = ice_sriov_clear_mbx_register,
 	.trigger_reset_register = ice_sriov_trigger_reset_register,
 	.poll_reset_status = ice_sriov_poll_reset_status,
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 1c51778db951b..86abbcb480d9d 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -673,7 +673,7 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
  * ice_set_vf_state_qs_dis - Set VF queues state to disabled
  * @vf: pointer to the VF structure
  */
-void ice_set_vf_state_qs_dis(struct ice_vf *vf)
+static void ice_set_vf_state_qs_dis(struct ice_vf *vf)
 {
 	/* Clear Rx/Tx enabled queues flag */
 	bitmap_zero(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF);
@@ -681,6 +681,16 @@ void ice_set_vf_state_qs_dis(struct ice_vf *vf)
 	clear_bit(ICE_VF_STATE_QS_ENA, vf->vf_states);
 }
 
+/**
+ * ice_set_vf_state_dis - Set VF state to disabled
+ * @vf: pointer to the VF structure
+ */
+void ice_set_vf_state_dis(struct ice_vf *vf)
+{
+	ice_set_vf_state_qs_dis(vf);
+	vf->vf_ops->clear_reset_state(vf);
+}
+
 /* Private functions only accessed from other virtualization files */
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 52bd9a3816bf2..9f7fcd8e5714b 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -56,6 +56,7 @@ struct ice_mdd_vf_events {
 struct ice_vf_ops {
 	enum ice_disq_rst_src reset_type;
 	void (*free)(struct ice_vf *vf);
+	void (*clear_reset_state)(struct ice_vf *vf);
 	void (*clear_mbx_register)(struct ice_vf *vf);
 	void (*trigger_reset_register)(struct ice_vf *vf, bool is_vflr);
 	bool (*poll_reset_status)(struct ice_vf *vf);
@@ -213,7 +214,7 @@ u16 ice_get_num_vfs(struct ice_pf *pf);
 struct ice_vsi *ice_get_vf_vsi(struct ice_vf *vf);
 bool ice_is_vf_disabled(struct ice_vf *vf);
 int ice_check_vf_ready_for_cfg(struct ice_vf *vf);
-void ice_set_vf_state_qs_dis(struct ice_vf *vf);
+void ice_set_vf_state_dis(struct ice_vf *vf);
 bool ice_is_any_vf_in_unicast_promisc(struct ice_pf *pf);
 void
 ice_vf_get_promisc_masks(struct ice_vf *vf, struct ice_vsi *vsi,
@@ -259,7 +260,7 @@ static inline int ice_check_vf_ready_for_cfg(struct ice_vf *vf)
 	return -EOPNOTSUPP;
 }
 
-static inline void ice_set_vf_state_qs_dis(struct ice_vf *vf)
+static inline void ice_set_vf_state_dis(struct ice_vf *vf)
 {
 }
 
-- 
2.39.2




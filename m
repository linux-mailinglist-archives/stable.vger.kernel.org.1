Return-Path: <stable+bounces-201105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 615B8CC0003
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 22:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5B953018EC1
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 21:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB25E32A3CF;
	Mon, 15 Dec 2025 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgIhhqTV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498132C956
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834996; cv=none; b=Esb3rRVJengBnvV8xUJqyxYfAJYnCa9JfaLoCTOX4xrR2TCajvYmENh9vXkLeywdalG/soev7FQKKBlTMG41QtYLASx8maz8tVbToejZCZwZ4VNCU2c5fxhkcIHE3cYRKYFpGfRqAqU9VmNCPbfd1ExJtAs3nqO9vQFMFrOw+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834996; c=relaxed/simple;
	bh=6r6AoywnSDR6B3GpzJ5OO5QaBrvpEUF4PyNcM/55Wd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mqfay8pv0J/kzIKVHqA83jZr9NJ0rxZs2lLr1HGWqsBVd1/mzaw4v4cjcQHWCKlxOEELtXCza8i7W/7yVZbQTDSf//h4uocwjZaysJAxNkXtaZocTN3Huf3rABV66ljICdfWTWWG9qX+/q8Jrb9uqlQhqJvahq0u136Xg5Tplqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgIhhqTV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765834993; x=1797370993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6r6AoywnSDR6B3GpzJ5OO5QaBrvpEUF4PyNcM/55Wd4=;
  b=GgIhhqTVRCgsThPu30DFplBYYWUxKUj8VkWwYJjygrJDnLPuGxGvWS7M
   yNWPTRfGnvR2uQAVb5KIZDAMnFi4ZZ6etTdEiSCzA9/mvSbd+74DzGVaC
   baTEgh7VIM5wKaVY62PKJUFymXgoKt3OWKa+rQbHdpOahOkv7KTSGgkkz
   /38OH+WtQsxRVqT/cmjRWvGjJ1YFD7T7oD6GS5bqNjnsxNNPNdtQJYIP+
   tkW0extAke5OEsnwlZcvYchgm+amDeSWONpwOQmSXOw0Z7WzCh3l3ztwA
   +eGoxpRp94HdKClcFk4AudNU03YKDNIuJ0T07Bx/OuuttwUUbRGU+shXs
   Q==;
X-CSE-ConnectionGUID: PU2TrMH0TASRC30i6sjBEg==
X-CSE-MsgGUID: wDRncsaRTjiIhJTlpIlMRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67711904"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="67711904"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 13:43:11 -0800
X-CSE-ConnectionGUID: HNAItp6TT9GzFv4p644LEg==
X-CSE-MsgGUID: +uOYXbZmSBKdPvcf/aE7aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="197110679"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 15 Dec 2025 13:43:11 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: stable@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	madhu.chittim@intel.com,
	decot@google.com,
	lrizzo@google.com,
	brianvv@google.com,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH stable 6.12.y 1/8] idpf: add support for SW triggered interrupts
Date: Mon, 15 Dec 2025 13:42:40 -0800
Message-ID: <20251215214303.2608822-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251215214303.2608822-1-anthony.l.nguyen@intel.com>
References: <20251215214303.2608822-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

[ Upstream commit 93433c1d919775f8ac0f7893692f42e6731a5373 ]

SW triggered interrupts are guaranteed to fire after their timer
expires, unlike Tx and Rx interrupts which will only fire after the
timer expires _and_ a descriptor write back is available to be processed
by the driver.

Add the necessary fields, defines, and initializations to enable a SW
triggered interrupt in the vector's dyn_ctl register.

Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_dev.c    | 3 +++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 8 +++++++-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index 6c913a703df6..41e4bd49402a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -101,6 +101,9 @@ static int idpf_intr_reg_init(struct idpf_vport *vport)
 		intr->dyn_ctl_itridx_s = PF_GLINT_DYN_CTL_ITR_INDX_S;
 		intr->dyn_ctl_intrvl_s = PF_GLINT_DYN_CTL_INTERVAL_S;
 		intr->dyn_ctl_wb_on_itr_m = PF_GLINT_DYN_CTL_WB_ON_ITR_M;
+		intr->dyn_ctl_swint_trig_m = PF_GLINT_DYN_CTL_SWINT_TRIG_M;
+		intr->dyn_ctl_sw_itridx_ena_m =
+			PF_GLINT_DYN_CTL_SW_ITR_INDX_ENA_M;
 
 		spacing = IDPF_ITR_IDX_SPACING(reg_vals[vec_id].itrn_index_spacing,
 					       IDPF_PF_ITR_IDX_SPACING);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index ffeeaede6cf8..77389653f666 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -354,6 +354,8 @@ struct idpf_vec_regs {
  * @dyn_ctl_itridx_m: Mask for ITR index
  * @dyn_ctl_intrvl_s: Register bit offset for ITR interval
  * @dyn_ctl_wb_on_itr_m: Mask for WB on ITR feature
+ * @dyn_ctl_sw_itridx_ena_m: Mask for SW ITR index
+ * @dyn_ctl_swint_trig_m: Mask for dyn_ctl SW triggered interrupt enable
  * @rx_itr: RX ITR register
  * @tx_itr: TX ITR register
  * @icr_ena: Interrupt cause register offset
@@ -367,6 +369,8 @@ struct idpf_intr_reg {
 	u32 dyn_ctl_itridx_m;
 	u32 dyn_ctl_intrvl_s;
 	u32 dyn_ctl_wb_on_itr_m;
+	u32 dyn_ctl_sw_itridx_ena_m;
+	u32 dyn_ctl_swint_trig_m;
 	void __iomem *rx_itr;
 	void __iomem *tx_itr;
 	void __iomem *icr_ena;
@@ -437,7 +441,7 @@ struct idpf_q_vector {
 	cpumask_var_t affinity_mask;
 	__cacheline_group_end_aligned(cold);
 };
-libeth_cacheline_set_assert(struct idpf_q_vector, 112,
+libeth_cacheline_set_assert(struct idpf_q_vector, 120,
 			    24 + sizeof(struct napi_struct) +
 			    2 * sizeof(struct dim),
 			    8 + sizeof(cpumask_var_t));
@@ -471,6 +475,8 @@ struct idpf_tx_queue_stats {
 #define IDPF_ITR_IS_DYNAMIC(itr_mode) (itr_mode)
 #define IDPF_ITR_TX_DEF		IDPF_ITR_20K
 #define IDPF_ITR_RX_DEF		IDPF_ITR_20K
+/* Index used for 'SW ITR' update in DYN_CTL register */
+#define IDPF_SW_ITR_UPDATE_IDX	2
 /* Index used for 'No ITR' update in DYN_CTL register */
 #define IDPF_NO_ITR_UPDATE_IDX	3
 #define IDPF_ITR_IDX_SPACING(spacing, dflt)	(spacing ? spacing : dflt)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index aad62e270ae4..aba828abcb17 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -101,6 +101,9 @@ static int idpf_vf_intr_reg_init(struct idpf_vport *vport)
 		intr->dyn_ctl_itridx_s = VF_INT_DYN_CTLN_ITR_INDX_S;
 		intr->dyn_ctl_intrvl_s = VF_INT_DYN_CTLN_INTERVAL_S;
 		intr->dyn_ctl_wb_on_itr_m = VF_INT_DYN_CTLN_WB_ON_ITR_M;
+		intr->dyn_ctl_swint_trig_m = VF_INT_DYN_CTLN_SWINT_TRIG_M;
+		intr->dyn_ctl_sw_itridx_ena_m =
+			VF_INT_DYN_CTLN_SW_ITR_INDX_ENA_M;
 
 		spacing = IDPF_ITR_IDX_SPACING(reg_vals[vec_id].itrn_index_spacing,
 					       IDPF_VF_ITR_IDX_SPACING);
-- 
2.47.1



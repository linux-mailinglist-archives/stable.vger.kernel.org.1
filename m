Return-Path: <stable+bounces-47350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189B98D0DA1
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F01B21602
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B1015FCF0;
	Mon, 27 May 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HaItm4N9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E31017727;
	Mon, 27 May 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838323; cv=none; b=dLOR6RD3z4NgNmmymHBe2jUTUl++O3+lu5i5T9HqdDQvgXZmTQVO1GuMQ7IiBmkzxb0AlaEDmhmAWQnQz4PNufdbibyblt3P4c0Y1LbqnDnR3D0om3n7moe8zFprkwEhag5rIrHdxde9rwwOEFnsxDPkBQBsHKndqFXZCdMP4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838323; c=relaxed/simple;
	bh=umuW8GTX3OgYjUxUdz121uogisDQqO7rOHYnin0gVyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EinkimmewG7Y4+mVkWDOUsk8Afu8r06Y6UL7BzB5iphtuVErWqrLJ6wDuBcFLAGUcY6+wwxq0IebBbP/ETFx01pK+LYafxMxSRSqZeZixnt8L1qgXuk62SOMiA2bTSG2160UbHKfYXmaj+XfcCdpwPnhZPkv2IrKVXJAhTksxKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HaItm4N9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65D0C2BBFC;
	Mon, 27 May 2024 19:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716838323;
	bh=umuW8GTX3OgYjUxUdz121uogisDQqO7rOHYnin0gVyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaItm4N9C1Eom7zXDfs6IDrJqEj86LAJuPjOaV0TaKwn5dN58YD2wRdD2ew/Ianfy
	 GDON6QMcb/ArnHl1UecXQloUPxQF6xYhFbKolcSlphnoCXIyPdcJUWrn5xDnk/+6bJ
	 zseKca5P6ELx8poooPlxJF97VjNEbCf/QVLZpIzU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 347/493] overflow: Change DEFINE_FLEX to take __counted_by member
Date: Mon, 27 May 2024 20:55:49 +0200
Message-ID: <20240527185641.636227487@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

[ Upstream commit d8e45f2929b94099913eb66c3ebb18b5063e9421 ]

The norm should be flexible array structures with __counted_by
annotations, so DEFINE_FLEX() is updated to expect that. Rename
the non-annotated version to DEFINE_RAW_FLEX(), and update the
few existing users. Additionally add selftests for the macros.

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/20240306235128.it.933-kees@kernel.org
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: e77f43d531af ("Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_base.c   |  4 ++--
 drivers/net/ethernet/intel/ice/ice_common.c |  4 ++--
 drivers/net/ethernet/intel/ice/ice_ddp.c    |  8 +++----
 drivers/net/ethernet/intel/ice/ice_lag.c    |  6 ++---
 drivers/net/ethernet/intel/ice/ice_sched.c  |  4 ++--
 drivers/net/ethernet/intel/ice/ice_switch.c | 10 ++++-----
 include/linux/overflow.h                    | 25 +++++++++++++++++----
 lib/overflow_kunit.c                        | 19 ++++++++++++++++
 8 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index d2fd315556a39..a545a7917e4fc 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -956,7 +956,7 @@ ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_tx_ring *ring,
 int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings,
 			   u16 q_idx)
 {
-	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
 
 	if (q_idx >= vsi->alloc_txq || !tx_rings || !tx_rings[q_idx])
 		return -EINVAL;
@@ -978,7 +978,7 @@ int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings,
 static int
 ice_vsi_cfg_txqs(struct ice_vsi *vsi, struct ice_tx_ring **rings, u16 count)
 {
-	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
 	int err = 0;
 	u16 q_idx;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 10c32cd80fff6..ce50a322daa91 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4700,7 +4700,7 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 		enum ice_disq_rst_src rst_src, u16 vmvf_num,
 		struct ice_sq_cd *cd)
 {
-	DEFINE_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
 	u16 i, buf_size = __struct_size(qg_list);
 	struct ice_q_ctx *q_ctx;
 	int status = -ENOENT;
@@ -4922,7 +4922,7 @@ int
 ice_dis_vsi_rdma_qset(struct ice_port_info *pi, u16 count, u32 *qset_teid,
 		      u16 *q_id)
 {
-	DEFINE_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
 	u16 qg_size = __struct_size(qg_list);
 	struct ice_hw *hw;
 	int status = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 90b9e28ddba91..1bf8ee98f06f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1934,8 +1934,8 @@ static enum ice_ddp_state ice_init_pkg_info(struct ice_hw *hw,
  */
 static enum ice_ddp_state ice_get_pkg_info(struct ice_hw *hw)
 {
-	DEFINE_FLEX(struct ice_aqc_get_pkg_info_resp, pkg_info, pkg_info,
-		    ICE_PKG_CNT);
+	DEFINE_RAW_FLEX(struct ice_aqc_get_pkg_info_resp, pkg_info, pkg_info,
+			ICE_PKG_CNT);
 	u16 size = __struct_size(pkg_info);
 	u32 i;
 
@@ -1986,8 +1986,8 @@ static enum ice_ddp_state ice_chk_pkg_compat(struct ice_hw *hw,
 					     struct ice_pkg_hdr *ospkg,
 					     struct ice_seg **seg)
 {
-	DEFINE_FLEX(struct ice_aqc_get_pkg_info_resp, pkg, pkg_info,
-		    ICE_PKG_CNT);
+	DEFINE_RAW_FLEX(struct ice_aqc_get_pkg_info_resp, pkg, pkg_info,
+			ICE_PKG_CNT);
 	u16 size = __struct_size(pkg);
 	enum ice_ddp_state state;
 	u32 i;
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index a7a342809935f..f0e76f0a6d603 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -491,7 +491,7 @@ static void
 ice_lag_move_vf_node_tc(struct ice_lag *lag, u8 oldport, u8 newport,
 			u16 vsi_num, u8 tc)
 {
-	DEFINE_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
 	struct device *dev = ice_pf_to_dev(lag->pf);
 	u16 numq, valq, num_moved, qbuf_size;
 	u16 buf_size = __struct_size(buf);
@@ -849,7 +849,7 @@ static void
 ice_lag_reclaim_vf_tc(struct ice_lag *lag, struct ice_hw *src_hw, u16 vsi_num,
 		      u8 tc)
 {
-	DEFINE_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
 	struct device *dev = ice_pf_to_dev(lag->pf);
 	u16 numq, valq, num_moved, qbuf_size;
 	u16 buf_size = __struct_size(buf);
@@ -1873,7 +1873,7 @@ static void
 ice_lag_move_vf_nodes_tc_sync(struct ice_lag *lag, struct ice_hw *dest_hw,
 			      u16 vsi_num, u8 tc)
 {
-	DEFINE_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
 	struct device *dev = ice_pf_to_dev(lag->pf);
 	u16 numq, valq, num_moved, qbuf_size;
 	u16 buf_size = __struct_size(buf);
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index d174a4eeb899c..a1525992d14bc 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -237,7 +237,7 @@ static int
 ice_sched_remove_elems(struct ice_hw *hw, struct ice_sched_node *parent,
 		       u32 node_teid)
 {
-	DEFINE_FLEX(struct ice_aqc_delete_elem, buf, teid, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_delete_elem, buf, teid, 1);
 	u16 buf_size = __struct_size(buf);
 	u16 num_groups_removed = 0;
 	int status;
@@ -2219,7 +2219,7 @@ int
 ice_sched_move_nodes(struct ice_port_info *pi, struct ice_sched_node *parent,
 		     u16 num_items, u32 *list)
 {
-	DEFINE_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_move_elem, buf, teid, 1);
 	u16 buf_len = __struct_size(buf);
 	struct ice_sched_node *node;
 	u16 i, grps_movd = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index ba0ef91e4c19c..b4ea935e83005 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1812,7 +1812,7 @@ ice_aq_alloc_free_vsi_list(struct ice_hw *hw, u16 *vsi_list_id,
 			   enum ice_sw_lkup_type lkup_type,
 			   enum ice_adminq_opc opc)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
 	u16 buf_len = __struct_size(sw_buf);
 	struct ice_aqc_res_elem *vsi_ele;
 	int status;
@@ -2081,7 +2081,7 @@ ice_aq_get_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u64 *r_assoc,
  */
 int ice_alloc_recipe(struct ice_hw *hw, u16 *rid)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
 	u16 buf_len = __struct_size(sw_buf);
 	int status;
 
@@ -4420,7 +4420,7 @@ int
 ice_alloc_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
 		   u16 *counter_id)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
 	u16 buf_len = __struct_size(buf);
 	int status;
 
@@ -4448,7 +4448,7 @@ int
 ice_free_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
 		  u16 counter_id)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
 	u16 buf_len = __struct_size(buf);
 	int status;
 
@@ -4478,7 +4478,7 @@ ice_free_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
  */
 int ice_share_res(struct ice_hw *hw, u16 type, u8 shared, u16 res_id)
 {
-	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
 	u16 buf_len = __struct_size(buf);
 	u16 res_type;
 	int status;
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 51af56522915e..ab4fa77516236 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -321,7 +321,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * @count: Number of elements in the array; must be compile-time const.
  * @initializer: initializer expression (could be empty for no init).
  */
-#define _DEFINE_FLEX(type, name, member, count, initializer)			\
+#define _DEFINE_FLEX(type, name, member, count, initializer...)			\
 	_Static_assert(__builtin_constant_p(count),				\
 		       "onstack flex array members require compile-time const count"); \
 	union {									\
@@ -331,8 +331,8 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 	type *name = (type *)&name##_u
 
 /**
- * DEFINE_FLEX() - Define an on-stack instance of structure with a trailing
- * flexible array member.
+ * DEFINE_RAW_FLEX() - Define an on-stack instance of structure with a trailing
+ * flexible array member, when it does not have a __counted_by annotation.
  *
  * @type: structure type name, including "struct" keyword.
  * @name: Name for a variable to define.
@@ -343,7 +343,24 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * flexible array member.
  * Use __struct_size(@name) to get compile-time size of it afterwards.
  */
-#define DEFINE_FLEX(type, name, member, count)			\
+#define DEFINE_RAW_FLEX(type, name, member, count)	\
 	_DEFINE_FLEX(type, name, member, count, = {})
 
+/**
+ * DEFINE_FLEX() - Define an on-stack instance of structure with a trailing
+ * flexible array member.
+ *
+ * @TYPE: structure type name, including "struct" keyword.
+ * @NAME: Name for a variable to define.
+ * @MEMBER: Name of the array member.
+ * @COUNTER: Name of the __counted_by member.
+ * @COUNT: Number of elements in the array; must be compile-time const.
+ *
+ * Define a zeroed, on-stack, instance of @TYPE structure with a trailing
+ * flexible array member.
+ * Use __struct_size(@NAME) to get compile-time size of it afterwards.
+ */
+#define DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)	\
+	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .obj.COUNTER = COUNT, })
+
 #endif /* __LINUX_OVERFLOW_H */
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index c527f6b757894..c85c8b121d350 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -1113,6 +1113,24 @@ static void castable_to_type_test(struct kunit *test)
 #undef TEST_CASTABLE_TO_TYPE
 }
 
+struct foo {
+	int a;
+	u32 counter;
+	s16 array[] __counted_by(counter);
+};
+
+static void DEFINE_FLEX_test(struct kunit *test)
+{
+	DEFINE_RAW_FLEX(struct foo, two, array, 2);
+	DEFINE_FLEX(struct foo, eight, array, counter, 8);
+	DEFINE_FLEX(struct foo, empty, array, counter, 0);
+
+	KUNIT_EXPECT_EQ(test, __struct_size(two),
+			sizeof(struct foo) + sizeof(s16) + sizeof(s16));
+	KUNIT_EXPECT_EQ(test, __struct_size(eight), 24);
+	KUNIT_EXPECT_EQ(test, __struct_size(empty), sizeof(struct foo));
+}
+
 static struct kunit_case overflow_test_cases[] = {
 	KUNIT_CASE(u8_u8__u8_overflow_test),
 	KUNIT_CASE(s8_s8__s8_overflow_test),
@@ -1135,6 +1153,7 @@ static struct kunit_case overflow_test_cases[] = {
 	KUNIT_CASE(overflows_type_test),
 	KUNIT_CASE(same_type_test),
 	KUNIT_CASE(castable_to_type_test),
+	KUNIT_CASE(DEFINE_FLEX_test),
 	{}
 };
 
-- 
2.43.0





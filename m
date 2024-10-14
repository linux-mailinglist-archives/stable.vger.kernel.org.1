Return-Path: <stable+bounces-84269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA0F99CF56
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1737B20C1C
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A01A1C3314;
	Mon, 14 Oct 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N/JsC/1p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567C71C32FE;
	Mon, 14 Oct 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917422; cv=none; b=ZWavFMHJKWoyrBzcJfHqwYjoNIMmD2sQNc5nqkuDxKpsHliZUry307bkH/PWxkxP6yw5BgxU9GoyG5CSkkq8J8Ai0sN/Kzn1T/1cp+ltbbhhM0kPaliC2Yjxz3MJRjALKIq+2ya1N8Fjb+PaNlusuZ9ymW/nQyJ3eS0n76zu5BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917422; c=relaxed/simple;
	bh=FtaaADtObqEHiywAnNZNolftnySjDI0xSm6sCxnhF5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGnKaBdI0ns4mGp4ghC10IV7T/FOc5UEUl3RrEtUq1k3Q9CDRq6lJ9caszY+SUMGUwQXCFXwQFHT0a/rRjdZXL75hD04wTISPHrGy5w4BQE5DOkjx1+B0F8SDr9Ezk7QY+eDuucRwOs1q+mORUqr8JXBzirDpKsPn+fRUYbBbT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N/JsC/1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6DAC4CEC3;
	Mon, 14 Oct 2024 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917422;
	bh=FtaaADtObqEHiywAnNZNolftnySjDI0xSm6sCxnhF5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N/JsC/1p2oDPpeufIreu+YAw678d1p5jyT79Hv22X2TrWlBhHeWIUGfC27G2SXj3b
	 XjbcB73VPfe/4v3rU4D9crtk0xG/DQ5ktKFKTZCvh7VzoyCkktkBRZtGLLeMIwHzCf
	 9azjrwbhm2VwqqPhC9FXtpHHHeTbutHm6YRkVGS8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 031/798] perf/arm-cmn: Rework DTC counters (again)
Date: Mon, 14 Oct 2024 16:09:45 +0200
Message-ID: <20241014141219.169246023@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 7633ec2c262fab3e7c5bf3cd3876b5748f584a57 ]

The bitmap-based scheme for tracking DTC counter usage turns out to be a
complete dead-end for its imagined purpose, since by the time we have to
keep track of a per-DTC counter index anyway, we already have enough
information to make the bitmap itself redundant. Revert the remains of
it back to almost the original scheme, but now expanded to track per-DTC
indices, in preparation for making use of them in anger.

Note that since cycle count events always use a dedicated counter on a
single DTC, we reuse the field to encode their DTC index directly.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Link: https://lore.kernel.org/r/5f6ade76b47f033836d7a36c03555da896dfb4a3.1697824215.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Stable-dep-of: e79634b53e39 ("perf/arm-cmn: Refactor node ID handling. Again.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm-cmn.c | 126 +++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 62 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 899e4ed49905c..0ab6fe93f5e2b 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -273,16 +273,13 @@ struct arm_cmn_node {
 	u16 id, logid;
 	enum cmn_node_type type;
 
-	int dtm;
-	union {
-		/* DN/HN-F/CXHA */
-		struct {
-			u8 val : 4;
-			u8 count : 4;
-		} occupid[SEL_MAX];
-		/* XP */
-		u8 dtc;
-	};
+	u8 dtm;
+	s8 dtc;
+	/* DN/HN-F/CXHA */
+	struct {
+		u8 val : 4;
+		u8 count : 4;
+	} occupid[SEL_MAX];
 	union {
 		u8 event[4];
 		__le32 event_sel;
@@ -532,12 +529,12 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
 
 		seq_puts(s, "\n     |");
 		for (x = 0; x < cmn->mesh_x; x++) {
-			u8 dtc = cmn->xps[xp_base + x].dtc;
+			s8 dtc = cmn->xps[xp_base + x].dtc;
 
-			if (dtc & (dtc - 1))
+			if (dtc < 0)
 				seq_puts(s, " DTC ?? |");
 			else
-				seq_printf(s, " DTC %ld  |", __ffs(dtc));
+				seq_printf(s, " DTC %d  |", dtc);
 		}
 		seq_puts(s, "\n     |");
 		for (x = 0; x < cmn->mesh_x; x++)
@@ -581,8 +578,7 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
 struct arm_cmn_hw_event {
 	struct arm_cmn_node *dn;
 	u64 dtm_idx[4];
-	unsigned int dtc_idx;
-	u8 dtcs_used;
+	s8 dtc_idx[CMN_MAX_DTCS];
 	u8 num_dns;
 	u8 dtm_offset;
 	bool wide_sel;
@@ -592,6 +588,10 @@ struct arm_cmn_hw_event {
 #define for_each_hw_dn(hw, dn, i) \
 	for (i = 0, dn = hw->dn; i < hw->num_dns; i++, dn++)
 
+/* @i is the DTC number, @idx is the counter index on that DTC */
+#define for_each_hw_dtc_idx(hw, i, idx) \
+	for (int i = 0, idx; i < CMN_MAX_DTCS; i++) if ((idx = hw->dtc_idx[i]) >= 0)
+
 static struct arm_cmn_hw_event *to_cmn_hw(struct perf_event *event)
 {
 	BUILD_BUG_ON(sizeof(struct arm_cmn_hw_event) > offsetof(struct hw_perf_event, target));
@@ -1311,12 +1311,11 @@ static void arm_cmn_init_counter(struct perf_event *event)
 {
 	struct arm_cmn *cmn = to_cmn(event->pmu);
 	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
-	unsigned int i, pmevcnt = CMN_DT_PMEVCNT(hw->dtc_idx);
 	u64 count;
 
-	for (i = 0; hw->dtcs_used & (1U << i); i++) {
-		writel_relaxed(CMN_COUNTER_INIT, cmn->dtc[i].base + pmevcnt);
-		cmn->dtc[i].counters[hw->dtc_idx] = event;
+	for_each_hw_dtc_idx(hw, i, idx) {
+		writel_relaxed(CMN_COUNTER_INIT, cmn->dtc[i].base + CMN_DT_PMEVCNT(idx));
+		cmn->dtc[i].counters[idx] = event;
 	}
 
 	count = arm_cmn_read_dtm(cmn, hw, false);
@@ -1329,11 +1328,9 @@ static void arm_cmn_event_read(struct perf_event *event)
 	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
 	u64 delta, new, prev;
 	unsigned long flags;
-	unsigned int i;
 
-	if (hw->dtc_idx == CMN_DT_NUM_COUNTERS) {
-		i = __ffs(hw->dtcs_used);
-		delta = arm_cmn_read_cc(cmn->dtc + i);
+	if (CMN_EVENT_TYPE(event) == CMN_TYPE_DTC) {
+		delta = arm_cmn_read_cc(cmn->dtc + hw->dtc_idx[0]);
 		local64_add(delta, &event->count);
 		return;
 	}
@@ -1343,8 +1340,8 @@ static void arm_cmn_event_read(struct perf_event *event)
 	delta = new - prev;
 
 	local_irq_save(flags);
-	for (i = 0; hw->dtcs_used & (1U << i); i++) {
-		new = arm_cmn_read_counter(cmn->dtc + i, hw->dtc_idx);
+	for_each_hw_dtc_idx(hw, i, idx) {
+		new = arm_cmn_read_counter(cmn->dtc + i, idx);
 		delta += new << 16;
 	}
 	local_irq_restore(flags);
@@ -1396,7 +1393,7 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
 	int i;
 
 	if (type == CMN_TYPE_DTC) {
-		i = __ffs(hw->dtcs_used);
+		i = hw->dtc_idx[0];
 		writeq_relaxed(CMN_CC_INIT, cmn->dtc[i].base + CMN_DT_PMCCNTR);
 		cmn->dtc[i].cc_active = true;
 	} else if (type == CMN_TYPE_WP) {
@@ -1427,7 +1424,7 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
 	int i;
 
 	if (type == CMN_TYPE_DTC) {
-		i = __ffs(hw->dtcs_used);
+		i = hw->dtc_idx[0];
 		cmn->dtc[i].cc_active = false;
 	} else if (type == CMN_TYPE_WP) {
 		int wp_idx = arm_cmn_wp_idx(event);
@@ -1613,12 +1610,19 @@ static int arm_cmn_event_init(struct perf_event *event)
 	hw->dn = arm_cmn_node(cmn, type);
 	if (!hw->dn)
 		return -EINVAL;
+
+	memset(hw->dtc_idx, -1, sizeof(hw->dtc_idx));
 	for (dn = hw->dn; dn->type == type; dn++) {
 		if (bynodeid && dn->id != nodeid) {
 			hw->dn++;
 			continue;
 		}
 		hw->num_dns++;
+		if (dn->dtc < 0)
+			memset(hw->dtc_idx, 0, cmn->num_dtcs);
+		else
+			hw->dtc_idx[dn->dtc] = 0;
+
 		if (bynodeid)
 			break;
 	}
@@ -1630,12 +1634,6 @@ static int arm_cmn_event_init(struct perf_event *event)
 			nodeid, nid.x, nid.y, nid.port, nid.dev, type);
 		return -EINVAL;
 	}
-	/*
-	 * Keep assuming non-cycles events count in all DTC domains; turns out
-	 * it's hard to make a worthwhile optimisation around this, short of
-	 * going all-in with domain-local counter allocation as well.
-	 */
-	hw->dtcs_used = (1U << cmn->num_dtcs) - 1;
 
 	return arm_cmn_validate_group(cmn, event);
 }
@@ -1661,28 +1659,25 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
 	}
 	memset(hw->dtm_idx, 0, sizeof(hw->dtm_idx));
 
-	for (i = 0; hw->dtcs_used & (1U << i); i++)
-		cmn->dtc[i].counters[hw->dtc_idx] = NULL;
+	for_each_hw_dtc_idx(hw, j, idx)
+		cmn->dtc[j].counters[idx] = NULL;
 }
 
 static int arm_cmn_event_add(struct perf_event *event, int flags)
 {
 	struct arm_cmn *cmn = to_cmn(event->pmu);
 	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
-	struct arm_cmn_dtc *dtc = &cmn->dtc[0];
 	struct arm_cmn_node *dn;
 	enum cmn_node_type type = CMN_EVENT_TYPE(event);
-	unsigned int i, dtc_idx, input_sel;
+	unsigned int input_sel, i = 0;
 
 	if (type == CMN_TYPE_DTC) {
-		i = 0;
 		while (cmn->dtc[i].cycles)
 			if (++i == cmn->num_dtcs)
 				return -ENOSPC;
 
 		cmn->dtc[i].cycles = event;
-		hw->dtc_idx = CMN_DT_NUM_COUNTERS;
-		hw->dtcs_used = 1U << i;
+		hw->dtc_idx[0] = i;
 
 		if (flags & PERF_EF_START)
 			arm_cmn_event_start(event, 0);
@@ -1690,17 +1685,22 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 	}
 
 	/* Grab a free global counter first... */
-	dtc_idx = 0;
-	while (dtc->counters[dtc_idx])
-		if (++dtc_idx == CMN_DT_NUM_COUNTERS)
-			return -ENOSPC;
-
-	hw->dtc_idx = dtc_idx;
+	for_each_hw_dtc_idx(hw, j, idx) {
+		if (j > 0) {
+			idx = hw->dtc_idx[0];
+		} else {
+			idx = 0;
+			while (cmn->dtc[j].counters[idx])
+				if (++idx == CMN_DT_NUM_COUNTERS)
+					goto free_dtms;
+		}
+		hw->dtc_idx[j] = idx;
+	}
 
 	/* ...then the local counters to feed it. */
 	for_each_hw_dn(hw, dn, i) {
 		struct arm_cmn_dtm *dtm = &cmn->dtms[dn->dtm] + hw->dtm_offset;
-		unsigned int dtm_idx, shift;
+		unsigned int dtm_idx, shift, d = 0;
 		u64 reg;
 
 		dtm_idx = 0;
@@ -1719,11 +1719,11 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 
 			tmp = dtm->wp_event[wp_idx ^ 1];
 			if (tmp >= 0 && CMN_EVENT_WP_COMBINE(event) !=
-					CMN_EVENT_WP_COMBINE(dtc->counters[tmp]))
+					CMN_EVENT_WP_COMBINE(cmn->dtc[d].counters[tmp]))
 				goto free_dtms;
 
 			input_sel = CMN__PMEVCNT0_INPUT_SEL_WP + wp_idx;
-			dtm->wp_event[wp_idx] = dtc_idx;
+			dtm->wp_event[wp_idx] = hw->dtc_idx[d];
 			writel_relaxed(cfg, dtm->base + CMN_DTM_WPn_CONFIG(wp_idx));
 		} else {
 			struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
@@ -1743,7 +1743,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 		dtm->input_sel[dtm_idx] = input_sel;
 		shift = CMN__PMEVCNTn_GLOBAL_NUM_SHIFT(dtm_idx);
 		dtm->pmu_config_low &= ~(CMN__PMEVCNT0_GLOBAL_NUM << shift);
-		dtm->pmu_config_low |= FIELD_PREP(CMN__PMEVCNT0_GLOBAL_NUM, dtc_idx) << shift;
+		dtm->pmu_config_low |= FIELD_PREP(CMN__PMEVCNT0_GLOBAL_NUM, hw->dtc_idx[d]) << shift;
 		dtm->pmu_config_low |= CMN__PMEVCNT_PAIRED(dtm_idx);
 		reg = (u64)le32_to_cpu(dtm->pmu_config_high) << 32 | dtm->pmu_config_low;
 		writeq_relaxed(reg, dtm->base + CMN_DTM_PMU_CONFIG);
@@ -1771,7 +1771,7 @@ static void arm_cmn_event_del(struct perf_event *event, int flags)
 	arm_cmn_event_stop(event, PERF_EF_UPDATE);
 
 	if (type == CMN_TYPE_DTC)
-		cmn->dtc[__ffs(hw->dtcs_used)].cycles = NULL;
+		cmn->dtc[hw->dtc_idx[0]].cycles = NULL;
 	else
 		arm_cmn_event_clear(cmn, event, hw->num_dns);
 }
@@ -1951,7 +1951,6 @@ static int arm_cmn_init_dtcs(struct arm_cmn *cmn)
 {
 	struct arm_cmn_node *dn, *xp;
 	int dtc_idx = 0;
-	u8 dtcs_present = (1 << cmn->num_dtcs) - 1;
 
 	cmn->dtc = devm_kcalloc(cmn->dev, cmn->num_dtcs, sizeof(cmn->dtc[0]), GFP_KERNEL);
 	if (!cmn->dtc)
@@ -1961,23 +1960,26 @@ static int arm_cmn_init_dtcs(struct arm_cmn *cmn)
 
 	cmn->xps = arm_cmn_node(cmn, CMN_TYPE_XP);
 
+	if (cmn->part == PART_CMN600 && cmn->num_dtcs > 1) {
+		/* We do at least know that a DTC's XP must be in that DTC's domain */
+		dn = arm_cmn_node(cmn, CMN_TYPE_DTC);
+		for (int i = 0; i < cmn->num_dtcs; i++)
+			arm_cmn_node_to_xp(cmn, dn + i)->dtc = i;
+	}
+
 	for (dn = cmn->dns; dn->type; dn++) {
-		if (dn->type == CMN_TYPE_XP) {
-			dn->dtc &= dtcs_present;
+		if (dn->type == CMN_TYPE_XP)
 			continue;
-		}
 
 		xp = arm_cmn_node_to_xp(cmn, dn);
+		dn->dtc = xp->dtc;
 		dn->dtm = xp->dtm;
 		if (cmn->multi_dtm)
 			dn->dtm += arm_cmn_nid(cmn, dn->id).port / 2;
 
 		if (dn->type == CMN_TYPE_DTC) {
-			int err;
-			/* We do at least know that a DTC's XP must be in that DTC's domain */
-			if (xp->dtc == 0xf)
-				xp->dtc = 1 << dtc_idx;
-			err = arm_cmn_init_dtc(cmn, dn, dtc_idx++);
+			int err = arm_cmn_init_dtc(cmn, dn, dtc_idx++);
+
 			if (err)
 				return err;
 		}
@@ -2135,9 +2137,9 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 			cmn->mesh_x = xp->logid;
 
 		if (cmn->part == PART_CMN600)
-			xp->dtc = 0xf;
+			xp->dtc = -1;
 		else
-			xp->dtc = 1 << arm_cmn_dtc_domain(cmn, xp_region);
+			xp->dtc = arm_cmn_dtc_domain(cmn, xp_region);
 
 		xp->dtm = dtm - cmn->dtms;
 		arm_cmn_init_dtm(dtm++, xp, 0);
-- 
2.43.0





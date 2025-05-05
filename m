Return-Path: <stable+bounces-140181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB77AAA5FF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7933A50DB
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C9331A0E9;
	Mon,  5 May 2025 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3gmHveA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEDC31A0DE;
	Mon,  5 May 2025 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484284; cv=none; b=sbNjhMcFyZURfqqn2byMHnPrihjz2Rah7cH30ed8Fu82KJyq+h6eHwFUjAN3IyZzhvdtaVojEaDCKQyByQK6u9xRZIMFHOwur7qei04s7h1iKr4qpLxNbfIiOWUdT+lw6PdnkK05D5Qw0giQAXODJFNTzuyhyqMJ53JL+eionSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484284; c=relaxed/simple;
	bh=TZpFGMXpH5A7lLcfxRrM8HRa0+BE7zEJu72ns+dJXJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GnLNCR/kZncsME7kjV+eQ1hJYilNqlh4yns76iC4vxEjg/jlSpAPs+CP6pvtxBLF9Akb4/pGoTO4R4vPjCM1RSN7WYh3DV9ttxhBVw4xJm376s3SJCGCWLSWfBI1jK38KiTWlp3QSKPjjjJqW/fzdMeuuuCsFLjuGOgQXtJdIQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3gmHveA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB4EC4CEED;
	Mon,  5 May 2025 22:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484284;
	bh=TZpFGMXpH5A7lLcfxRrM8HRa0+BE7zEJu72ns+dJXJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d3gmHveApLOtgQC20jpqUzjOlEe7v5Pngux/1Q/zBZTRk9t4q3Foxu3S+DCnL9Yn8
	 4O11jw6OX+Gj5JLL6mehOv2rOEXfTl7j5nXHv9udP9wbl4j+DCvhiY4WDK3omvLWyk
	 KyvO5T0JLlKFBMf+qf3O6OJ0EhYLp8NXh2/r5q1zH48YxUvz+cMZdjhYDs4Wraww2Q
	 q+aA71Z1uRhHuQkA/ZoUVP+rps3WwAt8kFfhbr8X7IYcZe0SHtnTfueEn1avv91Niy
	 MiezSmv0ynJopWXMnId1+OjVdOloj4HLqehJr2A+2deGV73dUVuXk/TeIYuxazX4KK
	 l1JLPVVouhHrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 434/642] bnxt_en: Set NPAR 1.2 support when registering with firmware
Date: Mon,  5 May 2025 18:10:50 -0400
Message-Id: <20250505221419.2672473-434-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit ebdf7fe488c512b18add66b6c26e11e4d3830213 ]

NPAR (Network interface card partitioning)[1] 1.2 adds a transparent
VLAN tag for all packets between the NIC and the switch.  Because of
that, RX VLAN acceleration cannot be supported for any additional
host configured VLANs.  The driver has to acknowledge that it can
support no RX VLAN acceleration and set the NPAR 1.2 supported flag
when registering with the FW.  Otherwise, the FW call will fail and
the driver will abort on these NPAR 1.2 NICs with this error:

bnxt_en 0000:26:00.0 (unnamed net_device) (uninitialized): hwrm req_type 0x1d seq id 0xb error 0x2

[1] https://techdocs.broadcom.com/us/en/storage-and-ethernet-connectivity/ethernet-nic-controllers/bcm957xxx/adapters/introduction/features/network-partitioning-npar.html

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20250213011240.1640031-2-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 40af27c2ba799..719ae44aa7639 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5585,6 +5585,8 @@ int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap, int bmap_size,
 	if (bp->fw_cap & BNXT_FW_CAP_ERROR_RECOVERY)
 		flags |= FUNC_DRV_RGTR_REQ_FLAGS_ERROR_RECOVERY_SUPPORT |
 			 FUNC_DRV_RGTR_REQ_FLAGS_MASTER_SUPPORT;
+	if (bp->fw_cap & BNXT_FW_CAP_NPAR_1_2)
+		flags |= FUNC_DRV_RGTR_REQ_FLAGS_NPAR_1_2_SUPPORT;
 	req->flags = cpu_to_le32(flags);
 	req->ver_maj_8b = DRV_VER_MAJ;
 	req->ver_min_8b = DRV_VER_MIN;
@@ -8385,6 +8387,7 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
 
 	switch (resp->port_partition_type) {
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_0:
+	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_2:
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_5:
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR2_0:
 		bp->port_partition_type = resp->port_partition_type;
@@ -9549,6 +9552,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_HOT_RESET_IF;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_FW_LIVEPATCH_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_LIVEPATCH;
+	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_NPAR_1_2_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_NPAR_1_2;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_DFLT_VLAN_TPID_PCP_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_DFLT_VLAN_TPID_PCP;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_BS_V2_SUPPORTED)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d621fb621f30c..f91d9d8eacb97 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2498,6 +2498,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V3	BIT_ULL(39)
 	#define BNXT_FW_CAP_VNIC_RE_FLUSH		BIT_ULL(40)
 	#define BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS	BIT_ULL(41)
+	#define BNXT_FW_CAP_NPAR_1_2			BIT_ULL(42)
 
 	u32			fw_dbg_cap;
 
-- 
2.39.5



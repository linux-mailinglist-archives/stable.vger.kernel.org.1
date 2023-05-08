Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F736FAB16
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjEHLJr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjEHLIw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180F43413C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A373C62B14
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9755DC433EF;
        Mon,  8 May 2023 11:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544130;
        bh=9c/tredsx8D0HMdaDS7pGXYM6Xg3tAMW9O28XiTomMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hRS3t9vmBc1MJ03cPbg/F0w2hlcM4dZcgkHDqnH2sxzgcLYBgbyXVpx2tdO6VwKh2
         y20Tat90HteEq42w27hyKzxXrVTmRKnVWs9cQb8GpzW+XniVTQXkHjE4ZMiBXiK0Nv
         qkm8TFLwTBLqAyybXe+Om/eE05vmNO6j/TJWJbjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jing Zhang <renyu.zj@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 309/694] perf/arm-cmn: Fix port detection for CMN-700
Date:   Mon,  8 May 2023 11:42:24 +0200
Message-Id: <20230508094442.316922721@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 2ad91e44e6b0c7ef1ed151b3bb2242a2144e6085 ]

When the "extra device ports" configuration was first added, the
additional mxp_device_port_connect_info registers were added around the
existing mxp_mesh_port_connect_info registers. What I missed about
CMN-700 is that it shuffled them around to remove this discontinuity.
As such, tweak the definitions and factor out a helper for reading these
registers so we can deal with this discrepancy easily, which does at
least allow nicely tidying up the callsites. With this we can then also
do the nice thing and skip accesses completely rather than relying on
RES0 behaviour where we know the extra registers aren't defined.

Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
Reported-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/71d129241d4d7923cde72a0e5b4c8d2f6084525f.1681295193.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm-cmn.c | 57 ++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 9f2edc28d16ef..44b719f39c3b3 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -57,14 +57,12 @@
 #define CMN_INFO_REQ_VC_NUM		GENMASK_ULL(1, 0)
 
 /* XPs also have some local topology info which has uses too */
-#define CMN_MXP__CONNECT_INFO_P0	0x0008
-#define CMN_MXP__CONNECT_INFO_P1	0x0010
-#define CMN_MXP__CONNECT_INFO_P2	0x0028
-#define CMN_MXP__CONNECT_INFO_P3	0x0030
-#define CMN_MXP__CONNECT_INFO_P4	0x0038
-#define CMN_MXP__CONNECT_INFO_P5	0x0040
+#define CMN_MXP__CONNECT_INFO(p)	(0x0008 + 8 * (p))
 #define CMN__CONNECT_INFO_DEVICE_TYPE	GENMASK_ULL(4, 0)
 
+#define CMN_MAX_PORTS			6
+#define CI700_CONNECT_INFO_P2_5_OFFSET	0x10
+
 /* PMU registers occupy the 3rd 4KB page of each node's region */
 #define CMN_PMU_OFFSET			0x2000
 
@@ -396,6 +394,25 @@ static struct arm_cmn_node *arm_cmn_node(const struct arm_cmn *cmn,
 	return NULL;
 }
 
+static u32 arm_cmn_device_connect_info(const struct arm_cmn *cmn,
+				       const struct arm_cmn_node *xp, int port)
+{
+	int offset = CMN_MXP__CONNECT_INFO(port);
+
+	if (port >= 2) {
+		if (cmn->model & (CMN600 | CMN650))
+			return 0;
+		/*
+		 * CI-700 may have extra ports, but still has the
+		 * mesh_port_connect_info registers in the way.
+		 */
+		if (cmn->model == CI700)
+			offset += CI700_CONNECT_INFO_P2_5_OFFSET;
+	}
+
+	return readl_relaxed(xp->pmu_base - CMN_PMU_OFFSET + offset);
+}
+
 static struct dentry *arm_cmn_debugfs;
 
 #ifdef CONFIG_DEBUG_FS
@@ -469,7 +486,7 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
 	y = cmn->mesh_y;
 	while (y--) {
 		int xp_base = cmn->mesh_x * y;
-		u8 port[6][CMN_MAX_DIMENSION];
+		u8 port[CMN_MAX_PORTS][CMN_MAX_DIMENSION];
 
 		for (x = 0; x < cmn->mesh_x; x++)
 			seq_puts(s, "--------+");
@@ -477,14 +494,9 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
 		seq_printf(s, "\n%d    |", y);
 		for (x = 0; x < cmn->mesh_x; x++) {
 			struct arm_cmn_node *xp = cmn->xps + xp_base + x;
-			void __iomem *base = xp->pmu_base - CMN_PMU_OFFSET;
-
-			port[0][x] = readl_relaxed(base + CMN_MXP__CONNECT_INFO_P0);
-			port[1][x] = readl_relaxed(base + CMN_MXP__CONNECT_INFO_P1);
-			port[2][x] = readl_relaxed(base + CMN_MXP__CONNECT_INFO_P2);
-			port[3][x] = readl_relaxed(base + CMN_MXP__CONNECT_INFO_P3);
-			port[4][x] = readl_relaxed(base + CMN_MXP__CONNECT_INFO_P4);
-			port[5][x] = readl_relaxed(base + CMN_MXP__CONNECT_INFO_P5);
+
+			for (p = 0; p < CMN_MAX_PORTS; p++)
+				port[p][x] = arm_cmn_device_connect_info(cmn, xp, p);
 			seq_printf(s, " XP #%-2d |", xp_base + x);
 		}
 
@@ -2083,18 +2095,9 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 		 * from this, since in that case we will see at least one XP
 		 * with port 2 connected, for the HN-D.
 		 */
-		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P0))
-			xp_ports |= BIT(0);
-		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P1))
-			xp_ports |= BIT(1);
-		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P2))
-			xp_ports |= BIT(2);
-		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P3))
-			xp_ports |= BIT(3);
-		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P4))
-			xp_ports |= BIT(4);
-		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P5))
-			xp_ports |= BIT(5);
+		for (int p = 0; p < CMN_MAX_PORTS; p++)
+			if (arm_cmn_device_connect_info(cmn, xp, p))
+				xp_ports |= BIT(p);
 
 		if (cmn->multi_dtm && (xp_ports & 0xc))
 			arm_cmn_init_dtm(dtm++, xp, 1);
-- 
2.39.2




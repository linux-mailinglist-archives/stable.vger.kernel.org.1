Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D627ECC29
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjKOT1S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjKOT1K (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:27:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8808D4B
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:27:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AD2C433C7;
        Wed, 15 Nov 2023 19:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076426;
        bh=dCMJcjkR0YWl60C//lEpyfgIe+aWMNLXXcPwdmx7w2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfppIc5dwq7T+O94y3p7/rjHf/F650D7LLuDb2CXZoP05YHlR9pO0NNwN/biAggMn
         NhcYcoHhPKXwVgQIoO8lRHXEHsmKRZu8B7LHz9tO0GLA7Gmx3UyobcQLTXPj4p/76S
         M1YAxiIYUAvoDMrzuJRF8Q7XjpGGDzUkIxCFGkUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 257/550] perf/arm-cmn: Fix DTC domain detection
Date:   Wed, 15 Nov 2023 14:14:01 -0500
Message-ID: <20231115191618.519680970@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit e3e73f511c49c741f6309862c2248958ad77bbaa ]

It transpires that dtm_unit_info is another register which got shuffled
in CMN-700 without me noticing. Fix that in a way which also proactively
fixes the fragile laziness of its consumer, just in case any further
fields ever get added alongside dtc_domain.

Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Link: https://lore.kernel.org/r/3076ee83d0554f6939fbb6ee49ab2bdb28d8c7ee.1697824215.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm-cmn.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 43aba01399bef..4a2cb49010599 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -110,7 +110,9 @@
 
 #define CMN_DTM_PMEVCNTSR		0x240
 
-#define CMN_DTM_UNIT_INFO		0x0910
+#define CMN650_DTM_UNIT_INFO		0x0910
+#define CMN_DTM_UNIT_INFO		0x0960
+#define CMN_DTM_UNIT_INFO_DTC_DOMAIN	GENMASK_ULL(1, 0)
 
 #define CMN_DTM_NUM_COUNTERS		4
 /* Want more local counters? Why not replicate the whole DTM! Ugh... */
@@ -2007,6 +2009,16 @@ static int arm_cmn_init_dtcs(struct arm_cmn *cmn)
 	return 0;
 }
 
+static unsigned int arm_cmn_dtc_domain(struct arm_cmn *cmn, void __iomem *xp_region)
+{
+	int offset = CMN_DTM_UNIT_INFO;
+
+	if (cmn->part == PART_CMN650 || cmn->part == PART_CI700)
+		offset = CMN650_DTM_UNIT_INFO;
+
+	return FIELD_GET(CMN_DTM_UNIT_INFO_DTC_DOMAIN, readl_relaxed(xp_region + offset));
+}
+
 static void arm_cmn_init_node_info(struct arm_cmn *cmn, u32 offset, struct arm_cmn_node *node)
 {
 	int level;
@@ -2138,7 +2150,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 		if (cmn->part == PART_CMN600)
 			xp->dtc = 0xf;
 		else
-			xp->dtc = 1 << readl_relaxed(xp_region + CMN_DTM_UNIT_INFO);
+			xp->dtc = 1 << arm_cmn_dtc_domain(cmn, xp_region);
 
 		xp->dtm = dtm - cmn->dtms;
 		arm_cmn_init_dtm(dtm++, xp, 0);
-- 
2.42.0




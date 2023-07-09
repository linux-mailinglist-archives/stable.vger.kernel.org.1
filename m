Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA1874C23F
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjGILSl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjGILSg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:18:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B14C1BB
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F175F60BDC
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC15C433C7;
        Sun,  9 Jul 2023 11:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901507;
        bh=taFge5Xdrs++WAucPugFTVAFKiXy0V2vy7z5o+/zYVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4ckQoJ8XINMtlMYVe6BvF021cImKWaYNfWk8/5nZ1aT772W4/Par8wk3fOznee23
         N79uM28younEqtMJzpgpRRuJSCcmyJL8nlqbDEKihzF59BU5bVdTm0M63gkrU19afp
         AQGrjg9QVtr2GakAJYqMWh3ez6kuIlHK0hG7JU3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH 6.3 045/431] perf/arm_cspmu: Fix event attribute type
Date:   Sun,  9 Jul 2023 13:09:53 +0200
Message-ID: <20230709111452.161826359@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 71e0cb32d5fc61468e83ed962379af71bba8237e ]

ARM_CSPMU_EVENT_ATTR() defines a struct perf_pmu_events_attr, so
arm_cspmu_sysfs_event_show() should not be interpreting it as struct
dev_ext_attribute.

Fixes: e37dfd65731d ("perf: arm_cspmu: Add support for ARM CoreSight PMU driver")
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/27c0804af64007b2400abbc40278f642ee6a0a29.1685983270.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index c1b6f4bdb04af..35d2fe33a7b6f 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -189,10 +189,10 @@ static inline bool use_64b_counter_reg(const struct arm_cspmu *cspmu)
 ssize_t arm_cspmu_sysfs_event_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct dev_ext_attribute *eattr =
-		container_of(attr, struct dev_ext_attribute, attr);
-	return sysfs_emit(buf, "event=0x%llx\n",
-			  (unsigned long long)eattr->var);
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, typeof(*pmu_attr), attr);
+	return sysfs_emit(buf, "event=0x%llx\n", pmu_attr->id);
 }
 EXPORT_SYMBOL_GPL(arm_cspmu_sysfs_event_show);
 
-- 
2.39.2




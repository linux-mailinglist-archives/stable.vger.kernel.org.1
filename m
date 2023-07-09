Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A0574C240
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGILSq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjGILSf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:18:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912981B9
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FE2660BDB
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A978C433C7;
        Sun,  9 Jul 2023 11:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901504;
        bh=c7Z1TO1vjPoNEbBg2Xopc9/FhxEQKW+XgVp1R/2N77I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=060uSjPJy3ITZ63GTZ+zh092RMH+pcX8xOgo7O98NmHSBNsZUmCDPpYXYUF/S3dx3
         IVs8g5vfdfpYBqHq5weLmEPFCEq5OGhsRwO8vTbPvrvwSRyZ4+7R+RikryeBy5bFRk
         1FFHz4/cxc3cBfFTIDJUfei8/xK9psUVf9M5De1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 044/431] perf: arm_cspmu: Set irq affinitiy only if overflow interrupt is used
Date:   Sun,  9 Jul 2023 13:09:52 +0200
Message-ID: <20230709111452.136386567@linuxfoundation.org>
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

From: Ilkka Koskinen <ilkka@os.amperecomputing.com>

[ Upstream commit 225d757012e0afa673d8c862e6fb39ed2f429b4d ]

Don't try to set irq affinity if PMU doesn't have an overflow interrupt.

Fixes: e37dfd65731d ("perf: arm_cspmu: Add support for ARM CoreSight PMU driver")
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Link: https://lore.kernel.org/r/20230608203742.3503486-1-ilkka@os.amperecomputing.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index e31302ab7e37c..c1b6f4bdb04af 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1230,7 +1230,8 @@ static struct platform_driver arm_cspmu_driver = {
 static void arm_cspmu_set_active_cpu(int cpu, struct arm_cspmu *cspmu)
 {
 	cpumask_set_cpu(cpu, &cspmu->active_cpu);
-	WARN_ON(irq_set_affinity(cspmu->irq, &cspmu->active_cpu));
+	if (cspmu->irq)
+		WARN_ON(irq_set_affinity(cspmu->irq, &cspmu->active_cpu));
 }
 
 static int arm_cspmu_cpu_online(unsigned int cpu, struct hlist_node *node)
-- 
2.39.2




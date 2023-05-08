Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF456FAE3F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbjEHLmu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbjEHLmd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:42:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCFA3B7A3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1C4D635C5
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4370C433D2;
        Mon,  8 May 2023 11:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546118;
        bh=IyzHf0wMkXZAUZ8UcY46p9+7qGDAlRFpQ24RWIZkiV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AF5btENYSlt7XSBmV0MybVhMPARoz8D6kyexKZYU+TrL86eGeJEFDQQFTMAITgyuA
         DLby1Tf0bCWGngfL2z4D9G9G0/nnn314gWQ1tfkV1stq60nm7lHrADnfch4eKfTruS
         K4Q5elc326q1RD4jAY9HbG2LdyCpM/28WekaJniI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 263/371] coresight: etm_pmu: Set the module field
Date:   Mon,  8 May 2023 11:47:44 +0200
Message-Id: <20230508094822.506190172@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 18996a113f2567aef3057e300e3193ce2df1684c ]

struct pmu::module must be set to the module owning the PMU driver.
Set this for the coresight etm_pmu.

Fixes: 8e264c52e1dab ("coresight: core: Allow the coresight core driver to be built as a module")
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20230405094922.667834-1-suzuki.poulose@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 8ebd728d3a800..1feb8f0e6556a 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -830,6 +830,7 @@ int __init etm_perf_init(void)
 	etm_pmu.addr_filters_sync	= etm_addr_filters_sync;
 	etm_pmu.addr_filters_validate	= etm_addr_filters_validate;
 	etm_pmu.nr_addr_filters		= ETM_ADDR_CMP_MAX;
+	etm_pmu.module			= THIS_MODULE;
 
 	ret = perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 	if (ret == 0)
-- 
2.39.2




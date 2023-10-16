Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1DD7CAB59
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjJPOZH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjJPOZG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:25:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE587E6
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:25:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D584CC433C7;
        Mon, 16 Oct 2023 14:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697466303;
        bh=R5Cg8X8qnU9G+Cd0PsDtqfDXE9MR8P7pWiaLyQnrodY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJZJLC6iRSrloQPWJ3evheiMQlr4NNq922voGTmNwmoG/mBEb+gImFsAVwEUjbJhR
         X9JJwzi0e8sFS/aGOZ6OGUYNbhaqX7qGuwPij/Un4NZjGfNwRWIJofULjqsGXJqutA
         +XvV5n32JAdl4pFy3rxwYLloDuP4ZNJEaNaSkDi8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jing Zhang <renyu.zj@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 003/191] perf/arm-cmn: Fix the unhandled overflow status of counter 4 to 7
Date:   Mon, 16 Oct 2023 10:39:48 +0200
Message-ID: <20231016084015.482164366@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jing Zhang <renyu.zj@linux.alibaba.com>

[ Upstream commit 7f949f6f54ff593123ab95b6247bfa4542a65580 ]

The register por_dt_pmovsr Bits[7:0] indicates overflow from counters 7
to 0. But in arm_cmn_handle_irq(), only handled the overflow status of
Bits[3:0] which results in unhandled overflow status of counters 4 to 7.

So let the overflow status of DTC counters 4 to 7 to be handled.

Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")
Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/1695612152-123633-1-git-send-email-renyu.zj@linux.alibaba.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm-cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index b8c15878bc86d..43aba01399bef 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1862,7 +1862,7 @@ static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
 		u64 delta;
 		int i;
 
-		for (i = 0; i < CMN_DTM_NUM_COUNTERS; i++) {
+		for (i = 0; i < CMN_DT_NUM_COUNTERS; i++) {
 			if (status & (1U << i)) {
 				ret = IRQ_HANDLED;
 				if (WARN_ON(!dtc->counters[i]))
-- 
2.40.1




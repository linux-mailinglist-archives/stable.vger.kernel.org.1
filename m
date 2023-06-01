Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB006719DCC
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjFAN01 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjFAN0L (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:26:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C22E5B
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:26:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3448264486
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51228C433EF;
        Thu,  1 Jun 2023 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625960;
        bh=R4iVn6V0Hf60Dm0295zMRXR1m1SnyI3xNV4sbk1n2lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zYkIr3Vq7XNQZjyqzBQekt/9hu9hRvp7EIyE759cd63/E9QmVCLbCKy0iUoaCa5Fr
         ihHZ6GKPpxaA98oqCaDuA9aMmcJWqNCxbhic4+atfLacSOGKGvQz0dd8VBIvBX38w+
         X6gw+DW04xBdHa++IuYbAreknA/nxEonkgQKeyqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ruidong Tian <tianruidong@linux.alibaba.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 04/45] coresight: perf: Release Coresight path when alloc trace id failed
Date:   Thu,  1 Jun 2023 14:21:00 +0100
Message-Id: <20230601131938.901307083@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ruidong Tian <tianruidong@linux.alibaba.com>

[ Upstream commit 04ac7f98b92181179ea84439642493f3826d04a2 ]

Error handler for etm_setup_aux can not release coresight path because
cpu mask was cleared when coresight_trace_id_get_cpu_id failed.

Call coresight_release_path function explicitly when alloc trace id filed.

Fixes: 4ff1fdb4125c4 ("coresight: perf: traceid: Add perf ID allocation and notifiers")
Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20230425032416.125542-1-tianruidong@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 711f451b69469..89e8ed214ea49 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -402,6 +402,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		trace_id = coresight_trace_id_get_cpu_id(cpu);
 		if (!IS_VALID_CS_TRACE_ID(trace_id)) {
 			cpumask_clear_cpu(cpu, mask);
+			coresight_release_path(path);
 			continue;
 		}
 
-- 
2.39.2




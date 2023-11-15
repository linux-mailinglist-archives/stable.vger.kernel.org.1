Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D4A7ECC0E
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjKOT0n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjKOT01 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:26:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1235119E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:26:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88629C433CA;
        Wed, 15 Nov 2023 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076383;
        bh=kl7xX2qxQTh+1EPOOJvPHriX2VxkujJgWNFXZzJtfYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vXP4RZgzPCFeq72Hhhkv5wpedvHFkmuqUP8yqy5T9AztvjVTo3gAVfLxzrgVr3u0Y
         L2ibu+6tHG6E15b9W3BQCBzxv6XredkbuTP4aYeo4UJ/cllOOonHa6CKqU9xb+t/mq
         xwjnyRKmSfua79OZDlsSznVigFP8+wMCDrNKEKkk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yicong Yang <yangyicong@hisilicon.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 258/550] drivers/perf: hisi_pcie: Check the type first in pmu::event_init()
Date:   Wed, 15 Nov 2023 14:14:02 -0500
Message-ID: <20231115191618.587070101@linuxfoundation.org>
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

From: Yicong Yang <yangyicong@hisilicon.com>

[ Upstream commit 6d7d51e88e21c0af1ca96a3617afef334bfeffcf ]

Check whether the event type matches the PMU type firstly in
pmu::event_init() before touching the event. Otherwise we'll
change the events of others and lead to incorrect results.
Since in perf_init_event() we may call every pmu's event_init()
in a certain case, we should not modify the event if it's not
ours.

Fixes: 8404b0fbc7fb ("drivers/perf: hisi: Add driver for HiSilicon PCIe PMU")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Link: https://lore.kernel.org/r/20231024092954.42297-2-yangyicong@huawei.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index e10fc7cb9493a..dafff711185c8 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -353,6 +353,10 @@ static int hisi_pcie_pmu_event_init(struct perf_event *event)
 	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 
+	/* Check the type first before going on, otherwise it's not our event */
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
 	event->cpu = pcie_pmu->on_cpu;
 
 	if (EXT_COUNTER_IS_USED(hisi_pcie_get_event(event)))
@@ -360,9 +364,6 @@ static int hisi_pcie_pmu_event_init(struct perf_event *event)
 	else
 		hwc->event_base = HISI_PCIE_CNT;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	/* Sampling is not supported. */
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
-- 
2.42.0




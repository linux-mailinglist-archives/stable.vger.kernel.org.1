Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F35A6FAAC6
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjEHLGg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjEHLGR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E2F33D6B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B87A162A7F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBB8C433D2;
        Mon,  8 May 2023 11:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543878;
        bh=XMCriow+NwxCJWRgOiPGFLrSjT3rBd/hYEc8jHvLViI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6qTjUEIoqk/Snkr6mQNelNFI50XA11RK4dxunbGTixTDwQ4X9OoBWj2W74JQ1Mbm
         05zAm5wZAbiY/taJrQfNcoUANNa9PJYrid0qwD7ZFXntCkaLluVCgh0bL3YeAc05tH
         w0OOpMNFgUXZo71TlkaJqgfU1Kd24DRpsI09bN5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 230/694] perf/amlogic: Fix config1/config2 parsing issue
Date:   Mon,  8 May 2023 11:41:05 +0200
Message-Id: <20230508094439.830648401@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiucheng Xu <jiucheng.xu@amlogic.com>

[ Upstream commit c61e5720f23273269cc67ffb2908cf9831c8ca9d ]

The 3th argument of for_each_set_bit is incorrect, fix them.

Fixes: 2016e2113d35 ("perf/amlogic: Add support for Amlogic meson G12 SoC DDR PMU driver")
Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
Link: https://lore.kernel.org/r/20230209115403.521868-1-jiucheng.xu@amlogic.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/amlogic/meson_ddr_pmu_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
index b84346dbac2ce..0b24dee1ed3cf 100644
--- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
+++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
@@ -156,10 +156,14 @@ static int meson_ddr_perf_event_add(struct perf_event *event, int flags)
 	u64 config2 = event->attr.config2;
 	int i;
 
-	for_each_set_bit(i, (const unsigned long *)&config1, sizeof(config1))
+	for_each_set_bit(i,
+			 (const unsigned long *)&config1,
+			 BITS_PER_TYPE(config1))
 		meson_ddr_set_axi_filter(event, i);
 
-	for_each_set_bit(i, (const unsigned long *)&config2, sizeof(config2))
+	for_each_set_bit(i,
+			 (const unsigned long *)&config2,
+			 BITS_PER_TYPE(config2))
 		meson_ddr_set_axi_filter(event, i + 64);
 
 	if (flags & PERF_EF_START)
-- 
2.39.2




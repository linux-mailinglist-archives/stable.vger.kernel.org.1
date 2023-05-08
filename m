Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AFA6FA742
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjEHK2w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbjEHK2d (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FD325242
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B609361D74
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B1BC433EF;
        Mon,  8 May 2023 10:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541711;
        bh=WyqNQpvNKFJk5B2YTcE5F2CmwTuzba0tZ/lxaYHRTUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzp0bUsQJx30UPdhZIDygdY8YCnL4XTV3NWGgjMvuTQLBY9jUMFhrfv0L+fpQpIGn
         S9Q8lA4yoKMC4NNe7adezI8Z52xg1tjlFSPp7mhS1w9sDhNclwt3VfB89MzbWS0+YS
         RITVOKNrgB6UD1kgiaE7ixjzPICUSiSguurjW8OU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        Dan Carpenter <error27@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 201/663] cpufreq: mediatek: fix passing zero to PTR_ERR
Date:   Mon,  8 May 2023 11:40:27 +0200
Message-Id: <20230508094434.903863676@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Jia-Wei Chang <jia-wei.chang@mediatek.com>

[ Upstream commit d51c63230994f167126d9d8381011b4cb2b0ad22 ]

In order to prevent passing zero to 'PTR_ERR' in
mtk_cpu_dvfs_info_init(), we fix the return value of of_get_cci() using
error pointer by explicitly casting error number.

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
Fixes: 0daa47325bae ("cpufreq: mediatek: Link CCI device to CPU")
Reported-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 7f2680bc9a0f4..01d949707c373 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -373,13 +373,13 @@ static struct device *of_get_cci(struct device *cpu_dev)
 	struct platform_device *pdev;
 
 	np = of_parse_phandle(cpu_dev->of_node, "mediatek,cci", 0);
-	if (IS_ERR_OR_NULL(np))
-		return NULL;
+	if (!np)
+		return ERR_PTR(-ENODEV);
 
 	pdev = of_find_device_by_node(np);
 	of_node_put(np);
-	if (IS_ERR_OR_NULL(pdev))
-		return NULL;
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
 
 	return &pdev->dev;
 }
@@ -401,7 +401,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	info->ccifreq_bound = false;
 	if (info->soc_data->ccifreq_supported) {
 		info->cci_dev = of_get_cci(info->cpu_dev);
-		if (IS_ERR_OR_NULL(info->cci_dev)) {
+		if (IS_ERR(info->cci_dev)) {
 			ret = PTR_ERR(info->cci_dev);
 			dev_err(cpu_dev, "cpu%d: failed to get cci device\n", cpu);
 			return -ENODEV;
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC576FA472
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjEHJ7a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjEHJ73 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:59:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFAC2CD2D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:59:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54DFC62295
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A01C433EF;
        Mon,  8 May 2023 09:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539966;
        bh=MkBSir096ixF+SGKwT4r3tz493K1/jDeIupkG2T4ODk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tc/vv4vUqhpbJ/Bd/g0V/htkzQL3YmdUGZBXaeJuJtauT9juX+DE3gBVMvbYZ2HCK
         i9OYvSeJWDojlIpJXAWbVe4F2zMKVSO/RnHupjWCWMldMed5cxxtdDbQT2lb4JxFr3
         A8wlm0TT6gQR8m7bIsRUIF3tEsY5axJ823a+b+i4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dan Carpenter <error27@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 195/611] cpufreq: mediatek: fix KP caused by handler usage after regulator_put/clk_put
Date:   Mon,  8 May 2023 11:40:37 +0200
Message-Id: <20230508094428.709191702@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

[ Upstream commit d51e106240bc755cbe59634b70d567c192b045b2 ]

Any kind of failure in mtk_cpu_dvfs_info_init() will lead to calling
regulator_put() or clk_put() and the KP will occur since the regulator/clk
handlers are used after released in mtk_cpu_dvfs_info_release().

To prevent the usage after regulator_put()/clk_put(), the regulator/clk
handlers are addressed in a way of "Free the Last Thing Style".

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
Fixes: 4b9ceb757bbb ("cpufreq: mediatek: Enable clocks and regulators")
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Suggested-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 62 +++++++++++++++---------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 01d949707c373..6dc225546a8d6 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -420,7 +420,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 		ret = PTR_ERR(info->inter_clk);
 		dev_err_probe(cpu_dev, ret,
 			      "cpu%d: failed to get intermediate clk\n", cpu);
-		goto out_free_resources;
+		goto out_free_mux_clock;
 	}
 
 	info->proc_reg = regulator_get_optional(cpu_dev, "proc");
@@ -428,13 +428,13 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 		ret = PTR_ERR(info->proc_reg);
 		dev_err_probe(cpu_dev, ret,
 			      "cpu%d: failed to get proc regulator\n", cpu);
-		goto out_free_resources;
+		goto out_free_inter_clock;
 	}
 
 	ret = regulator_enable(info->proc_reg);
 	if (ret) {
 		dev_warn(cpu_dev, "cpu%d: failed to enable vproc\n", cpu);
-		goto out_free_resources;
+		goto out_free_proc_reg;
 	}
 
 	/* Both presence and absence of sram regulator are valid cases. */
@@ -442,14 +442,14 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	if (IS_ERR(info->sram_reg)) {
 		ret = PTR_ERR(info->sram_reg);
 		if (ret == -EPROBE_DEFER)
-			goto out_free_resources;
+			goto out_disable_proc_reg;
 
 		info->sram_reg = NULL;
 	} else {
 		ret = regulator_enable(info->sram_reg);
 		if (ret) {
 			dev_warn(cpu_dev, "cpu%d: failed to enable vsram\n", cpu);
-			goto out_free_resources;
+			goto out_free_sram_reg;
 		}
 	}
 
@@ -458,13 +458,13 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	if (ret) {
 		dev_err(cpu_dev,
 			"cpu%d: failed to get OPP-sharing information\n", cpu);
-		goto out_free_resources;
+		goto out_disable_sram_reg;
 	}
 
 	ret = dev_pm_opp_of_cpumask_add_table(&info->cpus);
 	if (ret) {
 		dev_warn(cpu_dev, "cpu%d: no OPP table\n", cpu);
-		goto out_free_resources;
+		goto out_disable_sram_reg;
 	}
 
 	ret = clk_prepare_enable(info->cpu_clk);
@@ -533,43 +533,41 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 out_free_opp_table:
 	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
 
-out_free_resources:
-	if (regulator_is_enabled(info->proc_reg))
-		regulator_disable(info->proc_reg);
-	if (info->sram_reg && regulator_is_enabled(info->sram_reg))
+out_disable_sram_reg:
+	if (info->sram_reg)
 		regulator_disable(info->sram_reg);
 
-	if (!IS_ERR(info->proc_reg))
-		regulator_put(info->proc_reg);
-	if (!IS_ERR(info->sram_reg))
+out_free_sram_reg:
+	if (info->sram_reg)
 		regulator_put(info->sram_reg);
-	if (!IS_ERR(info->cpu_clk))
-		clk_put(info->cpu_clk);
-	if (!IS_ERR(info->inter_clk))
-		clk_put(info->inter_clk);
+
+out_disable_proc_reg:
+	regulator_disable(info->proc_reg);
+
+out_free_proc_reg:
+	regulator_put(info->proc_reg);
+
+out_free_inter_clock:
+	clk_put(info->inter_clk);
+
+out_free_mux_clock:
+	clk_put(info->cpu_clk);
 
 	return ret;
 }
 
 static void mtk_cpu_dvfs_info_release(struct mtk_cpu_dvfs_info *info)
 {
-	if (!IS_ERR(info->proc_reg)) {
-		regulator_disable(info->proc_reg);
-		regulator_put(info->proc_reg);
-	}
-	if (!IS_ERR(info->sram_reg)) {
+	regulator_disable(info->proc_reg);
+	regulator_put(info->proc_reg);
+	if (info->sram_reg) {
 		regulator_disable(info->sram_reg);
 		regulator_put(info->sram_reg);
 	}
-	if (!IS_ERR(info->cpu_clk)) {
-		clk_disable_unprepare(info->cpu_clk);
-		clk_put(info->cpu_clk);
-	}
-	if (!IS_ERR(info->inter_clk)) {
-		clk_disable_unprepare(info->inter_clk);
-		clk_put(info->inter_clk);
-	}
-
+	clk_disable_unprepare(info->cpu_clk);
+	clk_put(info->cpu_clk);
+	clk_disable_unprepare(info->inter_clk);
+	clk_put(info->inter_clk);
 	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
 	dev_pm_opp_unregister_notifier(info->cpu_dev, &info->opp_nb);
 }
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81EE72C230
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbjFLLDX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbjFLLDI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:03:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664E87ABE
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:50:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F101F6252A
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E85AC433EF;
        Mon, 12 Jun 2023 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567045;
        bh=4VKdvJeQ4izTZl1blo3mkVCpCYtokCTrzCYAO0Bhff0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYKKvztjXPBBYdh+AZtHafmxGcYxDetWd38Zr2aPLs7CWoSn47DzO3Hff5mwD51qy
         TmP6On7AO/lpW+3sdMB4qPbXvGVY96l8ji0ycgVN+vfzIwrFKGCYDe7+3+L4d2XHLj
         hdrEjs580fAaA28dLHaRK4dx+i346uHlxdH59I4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.3 112/160] soc: qcom: icc-bwmon: fix incorrect error code passed to dev_err_probe()
Date:   Mon, 12 Jun 2023 12:27:24 +0200
Message-ID: <20230612101720.176963447@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 3530167c6fe8001de6c026a3058eaca4c8a5329f upstream.

Pass to dev_err_probe() PTR_ERR from actual dev_pm_opp_find_bw_floor()
call which failed, instead of previous ret which at this point is 0.
Failure of dev_pm_opp_find_bw_floor() would result in prematurely ending
the probe with success.

Fixes smatch warnings:

  drivers/soc/qcom/icc-bwmon.c:776 bwmon_probe() warn: passing zero to 'dev_err_probe'
  drivers/soc/qcom/icc-bwmon.c:781 bwmon_probe() warn: passing zero to 'dev_err_probe'

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202305131657.76XeHDjF-lkp@intel.com/
Cc: <stable@vger.kernel.org>
Fixes: b9c2ae6cac40 ("soc: qcom: icc-bwmon: Add bandwidth monitoring driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230513111747.132532-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/qcom/icc-bwmon.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -603,12 +603,12 @@ static int bwmon_probe(struct platform_d
 	bwmon->max_bw_kbps = UINT_MAX;
 	opp = dev_pm_opp_find_bw_floor(dev, &bwmon->max_bw_kbps, 0);
 	if (IS_ERR(opp))
-		return dev_err_probe(dev, ret, "failed to find max peak bandwidth\n");
+		return dev_err_probe(dev, PTR_ERR(opp), "failed to find max peak bandwidth\n");
 
 	bwmon->min_bw_kbps = 0;
 	opp = dev_pm_opp_find_bw_ceil(dev, &bwmon->min_bw_kbps, 0);
 	if (IS_ERR(opp))
-		return dev_err_probe(dev, ret, "failed to find min peak bandwidth\n");
+		return dev_err_probe(dev, PTR_ERR(opp), "failed to find min peak bandwidth\n");
 
 	bwmon->dev = dev;
 



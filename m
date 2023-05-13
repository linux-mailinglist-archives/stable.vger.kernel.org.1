Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89A970165B
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 13:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbjEMLRy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 07:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbjEMLRx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 07:17:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4525D30C3
        for <stable@vger.kernel.org>; Sat, 13 May 2023 04:17:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96598a7c5e0so1757120166b.3
        for <stable@vger.kernel.org>; Sat, 13 May 2023 04:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683976671; x=1686568671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=euhYG7UmFZ4gFEHsm78E/8ioQyFx2y8WD2YO5H5bfA0=;
        b=XOzhvH6L5tg0Hjy7q3ga6oI2Takd4P9vhCcWRLiUhKKmUoj4KfpcWXa8NcygVxh93o
         xXWyW/zgLKWjRk56afPcFKV797KIxLpWO5VtEHIObM+yWL1wcJYOuiY20LXGAYz4UhPN
         TA53D6aCqdVX1LWb2sKQhj2Cei3lXGY8tnonJZMCimpB03FB0M7GQm0tW+Sn+AbojpJ6
         vuNWh28WOqX9HTK5ybN/bQ5NZrr7RKvmb1R0TyF5+GAwvPg0gckb5jQMDNpLm4ftDGV1
         wOn6AV1FHwxttUzpOFMFLFtuywUyjRIrBdPhoizpGws/8+YUPAp2jNO8P2NDN6ee3KXa
         /I8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683976671; x=1686568671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euhYG7UmFZ4gFEHsm78E/8ioQyFx2y8WD2YO5H5bfA0=;
        b=hVc+Y5IWpxnTN5FhPdiqp9BsqqMkTWnS4xhioovTg6nd2Nv6VjtrMY3Rvs4dEvYmIB
         N2SGNm8U76fk4n/QHjmI3TjxlMjFrGhHKNMGO7pA9d9qiQHExszz+xUY5igNwQXu4aNG
         krI2POBImFNwH8lkoSyRtppg0pQxOngSmXGwRBR/bu127lGu+0ckRDOZ4KWNZPOe9oIE
         f1C0Evr+uGJzVd1XfuOzTjPvpiJVlnesgS8dMRxd6AREQE8rhUThVxwlT+wSIUN/tCMR
         sQYCV21Q08TlHprOQYZxnHjeb3H59hyeGkAOXSSm0GEhoTpBOynOM9u1y0AVLU9bFs+X
         iX+g==
X-Gm-Message-State: AC+VfDzP+ck2yANOjvz1KYpkCeRPXqAKfY8Uiz3nyL0HTf4BV9oFFIIy
        SRGPOsIeI2SjSXvASd96if4D+Q==
X-Google-Smtp-Source: ACHHUZ5th0INGdsqt6ZfidlIFO302kHwqpR9jUAvSepDZHJpamodKonx+d4oPgAYZ+wZlW5vqZyV4w==
X-Received: by 2002:a17:907:3d9e:b0:96a:bb6:7309 with SMTP id he30-20020a1709073d9e00b0096a0bb67309mr17167479ejc.62.1683976670739;
        Sat, 13 May 2023 04:17:50 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3aa:fd4:f432:676b])
        by smtp.gmail.com with ESMTPSA id tk13-20020a170907c28d00b0094f185d82dcsm6580230ejc.21.2023.05.13.04.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 04:17:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] soc: qcom: icc-bwmon: fix incorrect error code passed to dev_err_probe()
Date:   Sat, 13 May 2023 13:17:47 +0200
Message-Id: <20230513111747.132532-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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

---

Code was tested previously with smatch. Just this test in smatch is new.
---
 drivers/soc/qcom/icc-bwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index fd58c5b69897..f65bfeca7ed6 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -773,12 +773,12 @@ static int bwmon_probe(struct platform_device *pdev)
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
 
-- 
2.34.1


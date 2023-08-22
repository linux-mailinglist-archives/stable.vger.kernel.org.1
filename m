Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6E784AFF
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 22:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjHVUGf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 16:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjHVUGe (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 16:06:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8A6CEC
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 13:06:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fee06efd6bso21973015e9.0
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 13:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692734791; x=1693339591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRW3uVyacKVMz0n3X0Q3Lp2slVRo4x30QDLpyV/AFPs=;
        b=pyv40EeRUk5sNTQJgdpPPpXUXCt1QuMXExoWqPiS+aXi/LZ4ckuejF57/teXbrgiUA
         qcqkFyYKuAzOoPhgYJj6Jkm/+kE0teR6j8GuBtQr/XQhABol9Hxi0LdycC16aMViKpBX
         V6QW5DWyEWRfDPkhfEKK+AOQHTyAlVhz6KRVkA6yMsgKdJ71Wv++wD8FM3wknT1Cu/I6
         EEFaEUZ6YpU2S2WhSBBqhJ0Sfw31FhIN0D750TPBuiFRvzqJbGkGQxY+9TYFoeuZQCVs
         IJKSopZVVZH3YWz+F0MK7SZEPkiE62Lz7tj7jTzeb5feFTm2+mTgF8j9z5YVEoWfVkE7
         ngbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692734791; x=1693339591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRW3uVyacKVMz0n3X0Q3Lp2slVRo4x30QDLpyV/AFPs=;
        b=mF1gPxblRr880RKNwcR8RxR7HmPqzDVh2yJAnudSlphV+ZLB8BVY31343rLHXXVfik
         oSlxeds4i5TH6sL27ev+DO+xtaNBzJ/9Wlf5sSbgkZAV/ye7G44sAGAuKb9L2NN261FT
         2c9i+pd+np0p50utO3+BpG0O8dyY20xmkn8P9Rr+a8zK43MeLDppY6vCnJLUxJ+sC571
         nxBwF+er1gq1lqiR/Rt7JPdWzgYrY+k6+79Ef0mCjyIJfhiH0ZSsDzkdHqHdYJigqn0R
         wcClDFodMUNQe4SCAUWm122kcogB1gM4CRgzd/6gHYMTVHIcPQ9vDpZzG8Cab8Kp8pcY
         kM3g==
X-Gm-Message-State: AOJu0YzkxGAKb6lHlpbitYS3QAld2Kj3npm8DuUvgOq69JxKPv5iE/qF
        9iyo3mZQYwxCTJ6cxb/VIRBMTA==
X-Google-Smtp-Source: AGHT+IHnTe7HEmNxFWZ0B8YEYVbUAhQ/N/bPmVChcUUgLQPvHCaklpQEnCIzgQbOl0hUYuNia2+EMA==
X-Received: by 2002:a5d:5450:0:b0:313:f38d:555f with SMTP id w16-20020a5d5450000000b00313f38d555fmr9346672wrv.24.1692734790910;
        Tue, 22 Aug 2023 13:06:30 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y12-20020adfee0c000000b0031aeca90e1fsm12873690wrn.70.2023.08.22.13.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 13:06:30 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 1/9] media: qcom: camss: Fix pm_domain_on sequence in probe
Date:   Tue, 22 Aug 2023 21:06:18 +0100
Message-ID: <20230822200626.1931129-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822200626.1931129-1-bryan.odonoghue@linaro.org>
References: <20230822200626.1931129-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

We need to make sure camss_configure_pd() happens before
camss_register_entities() as the vfe_get() path relies on the pointer
provided by camss_configure_pd().

Fix the ordering sequence in probe to ensure the pointers vfe_get() demands
are present by the time camss_register_entities() runs.

In order to facilitate backporting to stable kernels I've moved the
configure_pd() call pretty early on the probe() function so that
irrespective of the existence of the old error handling jump labels this
patch should still apply to -next circa Aug 2023 to v5.13 inclusive.

Fixes: 2f6f8af67203 ("media: camss: Refactor VFE power domain toggling")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index f11dc59135a5a..75991d849b571 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1619,6 +1619,12 @@ static int camss_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_cleanup;
 
+	ret = camss_configure_pd(camss);
+	if (ret < 0) {
+		dev_err(dev, "Failed to configure power domains: %d\n", ret);
+		goto err_cleanup;
+	}
+
 	ret = camss_init_subdevices(camss);
 	if (ret < 0)
 		goto err_cleanup;
@@ -1678,12 +1684,6 @@ static int camss_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = camss_configure_pd(camss);
-	if (ret < 0) {
-		dev_err(dev, "Failed to configure power domains: %d\n", ret);
-		return ret;
-	}
-
 	pm_runtime_enable(dev);
 
 	return 0;
-- 
2.41.0


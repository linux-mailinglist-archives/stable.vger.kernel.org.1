Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1824B7846C4
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 18:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbjHVQQp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 12:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbjHVQQm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 12:16:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AE8CF3
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 09:16:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fef3c3277bso17901725e9.1
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 09:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692720996; x=1693325796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W80DDZNGe/khXLl1P1oJD7Ws9Jxxl4GH65wXpEW+I0=;
        b=U+I3c2omMZRorK598XE13zuIDehZ8w9I22s/zu04h0wsbhre50YlhPO9rSG201wEnd
         iw2Fi0WFthYfRo+6jZdWAJ5MOboaw4xIwSY+ETSC2M6ei2FarU8yplYx59eoi8N5tMyc
         xhEemMA122O/CKqHAJrkunE4cOHoLut8I7JkRk7BlxD2ejhJJYAR2CkCvXWpPd/z6IwD
         O4yZwAhRGMOBkDaeOz080yQ2D1CSOIDBa3shH+ypNQjHA0YzQj4RjS1u9PkHg20Erqpm
         bxsfI36OYHXOCwcAO/yIS1cDzscbBUO0M1d+aIiVvV2bwN+S65SHez/1R1q/vQpDxtUQ
         A3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692720996; x=1693325796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4W80DDZNGe/khXLl1P1oJD7Ws9Jxxl4GH65wXpEW+I0=;
        b=QtxQFRQ4EJl6Xc3DiYX6akdMxhQNX+I9UESa5QOHKM4h4jIns9ZuJO5Ag/qcZDEHU5
         b23rn3hn9+2ePeCvtUCmuy6/G3KvoEIHPc21YA+UWbr1MQnQLOhfkFdxX078JFLKDMCy
         fXFwCugQ7IqhML1EnOh33SX1Qt+apUWfP3FFa9MSPWxFnYJF5Vupl5YS4b8xvry1ZZeq
         0LO0K+VNxRfbCQ8/UM8ZkVozKZOkUGrncMBtApelHRxR4K0mpAKmjf7ZmOw+Ts0O+etx
         IsvIeGzKjNkYmPa2NOlb9P4fQyU5gMWk6NOhJyzEjirECAT8fx6C/YgR461RwzHRpxLt
         vx8g==
X-Gm-Message-State: AOJu0YwL8sI6UdXJUWRdf862TdQP5/alThHt0aHBcFuXBSOdnex9VsWX
        /vVylvjHtyurkhYGWUL7ZCiSFA==
X-Google-Smtp-Source: AGHT+IEbmEdUgVc8gPoUPKvvsXPkSIASSjWR0w0R/tzbC9KKX1EtZerjUipZVmqFoATxxQ09bMenEA==
X-Received: by 2002:a7b:c3d0:0:b0:3f9:c0f2:e1a4 with SMTP id t16-20020a7bc3d0000000b003f9c0f2e1a4mr7429737wmj.34.1692720996718;
        Tue, 22 Aug 2023 09:16:36 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t23-20020a7bc3d7000000b003fe1fe56202sm16516130wmj.33.2023.08.22.09.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 09:16:35 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v1 6/9] media: qcom: camss: Fix missing vfe_lite clocks check
Date:   Tue, 22 Aug 2023 17:16:17 +0100
Message-ID: <20230822161620.1915110-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
References: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

check_clock doesn't account for vfe_lite which means that vfe_lite will
never get validated by this routine. Add the clock name to the expected set
to remediate.

Fixes: 7319cdf189bb ("media: camss: Add support for VFE hardware version Titan 170")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 938f373bcd1fd..b021f81cef123 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -535,7 +535,8 @@ static int vfe_check_clock_rates(struct vfe_device *vfe)
 		struct camss_clock *clock = &vfe->clock[i];
 
 		if (!strcmp(clock->name, "vfe0") ||
-		    !strcmp(clock->name, "vfe1")) {
+		    !strcmp(clock->name, "vfe1") ||
+		    !strcmp(clock->name, "vfe_lite")) {
 			u64 min_rate = 0;
 			unsigned long rate;
 
-- 
2.41.0


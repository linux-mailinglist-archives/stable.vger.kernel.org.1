Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76268758D9A
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 08:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGSGRR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 02:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjGSGRO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 02:17:14 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFFE1FC4
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 23:16:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99313a34b2dso784423666b.1
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 23:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689747417; x=1692339417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/3D3opjX717GgTUWBiU+QHvEZYFXmjd+9qv4cSuPkuA=;
        b=fmSOGHZSbHFsabRaN28Z7YjPrEHukqwNbn/mICX7gQ4RZ8tGRUjDs7n8zF05HOiOpT
         7GsUHsd43WCALy5vq9f9JHqv9Mgp1IUjThZkb0NVtGarbXty4p3J0ygLvOzw0m+HJxIF
         Yc3OpMExpMeGRddyFjaj92TlieU9oGkcRv6WpUzmqfvtLKzxfkPq39F2ZoRbanBHEM/z
         3f4OD37fwnbdM1rINn8mRU2c/uCmTbc5iVmZ20/RZqi98lat+QcIB6DRxZ1HV8R/nTi5
         UlWhTvsbl5okc+Igl3YJGfiI+Y6RSmH0VzEAyKGsO+abEUB88Uvbm5fJwPpBIVSkBBX6
         /Swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689747417; x=1692339417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3D3opjX717GgTUWBiU+QHvEZYFXmjd+9qv4cSuPkuA=;
        b=ATooYFMvFwjtBR8NGGl0aIUFW7DFG7RCvGSO8FgKU5Zq6X/PU+9PHM/Rvl/7y/TfV8
         FTdZc8eJaNyWmx14JHUhMa6M8P0KenDfBoe9Zz7oQ6zvOP2nvbgo7iGpDSyOyN+vstiE
         ElyBC5JftjpJ7nBWBPsd+33wR1f7D2c2kxoTt9TLAqDsQzAU48Jxh84Ym4YJPiWXeRYI
         cx5AcK3I1ycpYDgtGP7wA4neXu8NHDW+Vq0kfFWYKJ0zHXA4tXRuK+TilWBB4VmpvbL7
         lhhmy/XBwRu1YeTwaCSERr4JdduGuHYmi8aJTK0gFTQVYHKZpye+7McsOLpEJ5VH62F8
         O20Q==
X-Gm-Message-State: ABy/qLY2nK3HJJGJdWjbtAM8JCkscgAwGiQepyZ1AGn0VPXkPbQ7Ka7T
        iUdY7Ax2Ie8OOCpIjtWozpOP7g==
X-Google-Smtp-Source: APBJJlFjhXwP3bLyDVtTdBEjE4Qpptq7rQRnfm4betnkIHUbPN9qsfs/gSev+pgbJLc/6S/2iH+b1A==
X-Received: by 2002:a17:906:7698:b0:986:f586:b97 with SMTP id o24-20020a170906769800b00986f5860b97mr1778494ejm.59.1689747417591;
        Tue, 18 Jul 2023 23:16:57 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w24-20020a17090633d800b009935aba3a9dsm1864576eja.48.2023.07.18.23.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 23:16:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v2] firmware: arm_scmi: drop OF node reference in setup
Date:   Wed, 19 Jul 2023 08:16:52 +0200
Message-Id: <20230719061652.8850-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The OF node reference obtained from of_parse_phandle() should be dropped
if node is not compatible with arm,scmi-shmem.

Fixes: 507cd4d2c5eb ("firmware: arm_scmi: Add compatibility checks for shmem node")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Correct also mailbox.c
---
 drivers/firmware/arm_scmi/mailbox.c | 4 +++-
 drivers/firmware/arm_scmi/smc.c     | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 1efa5e9392c4..19246ed1f01f 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -166,8 +166,10 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 		return -ENOMEM;
 
 	shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
-	if (!of_device_is_compatible(shmem, "arm,scmi-shmem"))
+	if (!of_device_is_compatible(shmem, "arm,scmi-shmem")) {
+		of_node_put(shmem);
 		return -ENXIO;
+	}
 
 	ret = of_address_to_resource(shmem, 0, &res);
 	of_node_put(shmem);
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 621c37efe3ec..2d8c510fbf52 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -137,8 +137,10 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 		return -ENOMEM;
 
 	np = of_parse_phandle(cdev->of_node, "shmem", 0);
-	if (!of_device_is_compatible(np, "arm,scmi-shmem"))
+	if (!of_device_is_compatible(np, "arm,scmi-shmem")) {
+		of_node_put(np);
 		return -ENXIO;
+	}
 
 	ret = of_address_to_resource(np, 0, &res);
 	of_node_put(np);
-- 
2.34.1


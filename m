Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040E07C861E
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 14:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjJMMtO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 08:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjJMMtN (ORCPT
        <rfc822;Stable@vger.kernel.org>); Fri, 13 Oct 2023 08:49:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD408C2
        for <Stable@vger.kernel.org>; Fri, 13 Oct 2023 05:49:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3247cefa13aso1877230f8f.1
        for <Stable@vger.kernel.org>; Fri, 13 Oct 2023 05:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697201349; x=1697806149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypOV+VbPmdWwWrEUFKY6phZ61kecykFXDGvPPkPkvFQ=;
        b=q7z+wsurOYAhaJHJS4jWRKJHHWfgYoXMQf5S1dr53jeLD16ruQ7wV4cPoHnkcrBfmP
         BEZP5x/xRCA4ACmTgv+zWGZNOWObYG6aPtsS4/zj9PflNmOr0bEKIhDlR23Nr9xFkWJN
         tuXPc0P4Z4fbNu59J1cx9sc81Ex+eisoATL1Z2/sYXQqrHr3orOQwt0nSuoX3y7Q6ed2
         471po7XdiPEcNraeYTERrivGAKID88TyHxZm90oC9ymyZ30O8xQ8fSWzBZSHoIIbwNNz
         D53mKfId6ltzOJirBM9+7nM5NGxvBpSLRSLvDYk615c8/SjGii7ZCW/21pJtI4GCoqju
         CtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697201349; x=1697806149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypOV+VbPmdWwWrEUFKY6phZ61kecykFXDGvPPkPkvFQ=;
        b=i+oV+z0Lui3VYRJCA85MNh0+mM59oIh0xvWB8nu3Te8K2vzXfQ4Ees3mIRPUmXlWd1
         ZxZvCRJiyixXtZjbUB9wiLdfGP37evJPcecQnM2UZ5kEeyYCrKRUI9leoA53vH6hMcd4
         CCdoRIPXf2v+KO606UKkoka/n+b08GAWazhSW5lncB7oO/Dk8eholfcwoCvBzaUVc3QP
         droi+a18oUBexKFwby7tM0hnQnlh+XuqwhZf8JByJptCVBrOQRlL17asElOmkKckiKo0
         Ca9T+1zi6X3Phi/CKTicsMcFzT1t+V0DB+k01qq1l3PFWe6KmF159ddwTBu6nBRQpCQ5
         NKWw==
X-Gm-Message-State: AOJu0YxhWXN2TeXpFnvfkW2CkYnQYRj4swHzFtcDxzEtNq7lMOQ+dlEY
        9wVO/t/e7qM0RTa07qr0EjEbLA==
X-Google-Smtp-Source: AGHT+IFDs40ZbS+RBv5tLRzN/8Ik3UlilIbYbh/CI+jpnNdOuXlgPRD5QOz5nJM2I9lUgC+3wYigzg==
X-Received: by 2002:a5d:4144:0:b0:321:7093:53f5 with SMTP id c4-20020a5d4144000000b00321709353f5mr22127542wrq.64.1697201349269;
        Fri, 13 Oct 2023 05:49:09 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id w16-20020adf8bd0000000b0032d81837433sm8035438wra.30.2023.10.13.05.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:49:08 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] nvmem: imx: correct nregs for i.MX6UL
Date:   Fri, 13 Oct 2023 13:49:03 +0100
Message-Id: <20231013124904.175782-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231013124904.175782-1-srinivas.kandagatla@linaro.org>
References: <20231013124904.175782-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=825; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=IDLOJh++S12+3MkFp/x9AZBIlgWcZyB4/vxr1ROAyB0=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlKTzAoueopYaASyEyHs0b9HqK0y6V6d9PD7/Uq I5FTMo7B4uJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZSk8wAAKCRB6of1ZxzRV N7tzB/43fOEOJrBxfSiT0e5uODXf1tfL1dlotd6V0P8poX/naLy4AKadSzzjwwjvn7hpp2cyGiv kL+0F8QVXV0GTmBMM/dy/QQQvwVaSGRRX/h5BS4iVYPSOwOYmdsslRCEoUqZ/0uhxio6UjWB3qi kmVxKHfYNxcyndIBVJ2zUQJs70VZOgxD3rGoAyyU5wWLEU5RojcptluGuPppQaeGncGW5GYlKxi 5ifLzeKKjiREQJZ8dBhexiLOOsw4HWNnvYzh2XackLkQsPjKlbL+2txGt0JJhehm9yGc9XFqLCE H77sl2Vpq9bAwCzIBp0hjJbXP0MzbrHfNLaNXgUVHhiBCwlp
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The nregs for i.MX6UL should be 144 per fuse map, correct it.

Fixes: 4aa2b4802046 ("nvmem: octop: Add support for imx6ul")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 7302f25b14a1..921afe114a2c 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -512,7 +512,7 @@ static const struct ocotp_params imx6sx_params = {
 };
 
 static const struct ocotp_params imx6ul_params = {
-	.nregs = 128,
+	.nregs = 144,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
-- 
2.25.1


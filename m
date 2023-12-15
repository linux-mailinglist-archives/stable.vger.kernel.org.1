Return-Path: <stable+bounces-6797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F09814682
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 12:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6D6B2384E
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9E3208A0;
	Fri, 15 Dec 2023 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0jKyCLB"
X-Original-To: Stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27BC24B57
	for <Stable@vger.kernel.org>; Fri, 15 Dec 2023 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-336447100e9so481918f8f.1
        for <Stable@vger.kernel.org>; Fri, 15 Dec 2023 03:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702638850; x=1703243650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnJpzLu7OYN2kATFIxauIPkE+ThNdZJEPlO0+LslewE=;
        b=q0jKyCLBqP5P2yytnfjdxWjXzP/FB2eWySUmf4FK5nSWEJrsqXt9JfsLqQEyx1GwOE
         UBF+sX/NiWGUQTjihJa+sf00WVZy3ezM+m5Dlqk0klshK5KAy8iVpSChDk3O5nz/946g
         VCFTuStKz4sere4JtQGK+MRcEDRiicGrjf0EAqwgD3PAXTy1oUO9GKDffwMAJk2HZQng
         Dve3hZ3jkx/+dO7fjwffSE02DUU8Gi98VQ55f6DZkv+GDluCZxszjnwZzFd44EAYeB3b
         i3YK1uvEDi+slcZbGjefACnR8R3K/MQhvbyJbppLgFsGGwtnvUe0UL/IFjoqImvf0eHs
         fYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638850; x=1703243650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnJpzLu7OYN2kATFIxauIPkE+ThNdZJEPlO0+LslewE=;
        b=lK4r6KID+xh/cK+9hoB2nBx/GvIlw661B5K7ZN1q7wEPnunVBsbFilP8h3KlVWrwYH
         edgRvVqGdWt0k03xz0Cc4htN8GUga2roo8HbQtI30ol0UnupIU7r+ewCJc7ES3j6gaoY
         Tz8kylwh/xaTi73uUBOEwd/BPLqsnSGIbMu/jpe0il1mAyG7NI7HWtX0/sHMRNSRQ4Wm
         srxHwukyCXBO1qpsgV0YvlKdXibL0geLuSOUh4br2tALyQBfR6J86aBCbMiGmtzisWET
         LOY91QsGk0t+Qzxw+k9S762rTflwx5Mo8XuIB6iEF+k07TzjrlY72FOFaE7YVBHkcoVn
         AuLw==
X-Gm-Message-State: AOJu0Yz6d6j6OLTNa4i1gTCnlaEWOM/0ge9Tp031Ox+EEAtuxiGDJH0u
	Xm6HckJaCyvAgMRDNBNP1unPxw==
X-Google-Smtp-Source: AGHT+IEQKXQ5LyKOaRaMJojLvq3gOiWO1LAIRx+9ZVuoAsq3xlmZhmmHfL8ZTS4YRtVL1AjHvilqoQ==
X-Received: by 2002:a05:6000:361:b0:334:b2bb:6d20 with SMTP id f1-20020a056000036100b00334b2bb6d20mr5855159wrf.136.1702638850043;
        Fri, 15 Dec 2023 03:14:10 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id s15-20020a5d69cf000000b0033641783aeesm6310757wrw.7.2023.12.15.03.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:14:08 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>,
	Stable@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp
Date: Fri, 15 Dec 2023 11:13:57 +0000
Message-Id: <20231215111358.316727-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215111358.316727-1-srinivas.kandagatla@linaro.org>
References: <20231215111358.316727-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=UKAdVIXxLSVBpAJKLuqzEbLVs38PD1Le2xvasZyzjIY=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlfDTr5PT7T6ZV3YrphFFwHqKtzIySk17uPKUOd zyrCuGAT46JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZXw06wAKCRB6of1ZxzRV N2RGB/48szrzNOEZ67K0VhqAoDiIn4lVCY8fRMR948594eiPbRPYnAb44I1O4cwf03yQgovwftU 1mumOpVul/nKyDJ5A4fSxVpdHbR/UTrzp9exXhsBs0nniqJ2pUcKspe4xMckjVI99nJhNG4Ysf4 ROPWqaO0xdYPhVOfOLaU1Lzj7jEFUN3MDO/06ZA2NLYOXlkPy7dxWR+gmp8oS4B//oJqp7t7zwl ZpDWZvwu/MB+F6XoPnqt6edD8Nl6a1GzxkKn12EOoYScASGPrmuXocA6cAQXUdatXwhvYdOkMT1 x1GHxoI76rT9nQQGCbdYhBEGVwbH21ljeuo87jtxO74UOJAx
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Both imx23.dtsi and imx28.dtsi describe the OCOTP nodes in
the format:

compatible = "fsl,imx28-ocotp", "fsl,ocotp";

Document the "fsl,ocotp" entry to fix the following schema
warning:

efuse@8002c000: compatible: ['fsl,imx23-ocotp', 'fsl,ocotp'] is too long
from schema $id: http://devicetree.org/schemas/nvmem/mxs-ocotp.yaml#

Fixes: 2c504460f502 ("dt-bindings: nvmem: Convert MXS OCOTP to json-schema")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Fabio Estevam <festevam@denx.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
index f43186f98607..d9287be89877 100644
--- a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
@@ -15,9 +15,11 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx23-ocotp
-      - fsl,imx28-ocotp
+    items:
+      - enum:
+          - fsl,imx23-ocotp
+          - fsl,imx28-ocotp
+      - const: fsl,ocotp
 
   reg:
     maxItems: 1
@@ -35,7 +37,7 @@ unevaluatedProperties: false
 examples:
   - |
     ocotp: efuse@8002c000 {
-        compatible = "fsl,imx28-ocotp";
+        compatible = "fsl,imx28-ocotp", "fsl,ocotp";
         #address-cells = <1>;
         #size-cells = <1>;
         reg = <0x8002c000 0x2000>;
-- 
2.25.1



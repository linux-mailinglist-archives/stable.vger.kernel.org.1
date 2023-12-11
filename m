Return-Path: <stable+bounces-5517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8AE80D3AB
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7701C215A8
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 17:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12244E1A1;
	Mon, 11 Dec 2023 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X/HElSps"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71C69B
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 09:24:22 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cef5220d07so1003900b3a.2
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 09:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702315462; x=1702920262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OIO4WNjR5xVb+yTIblaWghN44VQDB2yiwlWnOskO7lQ=;
        b=X/HElSpsabf/JSNO5yuoYy7tmRFjNqnSfKB8lq23BvtLoaEbQ/DnSu50VHbA6BR06L
         zs4lopBJYqqozWHk4ZG7iIlZrboP4B/mbUauspaHlcXlE+edktmPncm1OwbnRIIeoAsB
         diaiK3kW3ZaDM8K5hpS1RA3CGqLVhPN4IIkSUQIGc0OrEmvHqe5trqyaCcRu7L1f+/5l
         IngXVePIRNX/D6PflAUXWB/KYxx0aHl4MH3j0D0LvyQQOF547Bdv24qJ+xepqhgQJTQy
         t7uk1+1HopMXTp5RN36HOFsjz/cPsOVtUsh1YpjagZsaDtsvuqVbuClbln1kfwPDVgLC
         FVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702315462; x=1702920262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIO4WNjR5xVb+yTIblaWghN44VQDB2yiwlWnOskO7lQ=;
        b=cuyoUIR2iFngkqiZEu9d5cp8sKn+QLQGzTQw4EVEX+fUFYHhWQoqAi8XVdquzh+T0Y
         kpK7ZbpZVD1Qv3llwZpYed0rNYN4/2A4zw1nlw1PYrom/3HCIZPK3NHbNxz76j4Q9Ahj
         eQHALa6AOfY6czdg4pFKqu9C9rWJ2ZmCbtlUJ0XX4fNuhJF7ZupjwaIkDELMnR3fCH3H
         qPg2IxDd5trQAfKhWdrJldvkKF2jIfGsPwL94f1G+1Rtq+gRYkoW4nQliEa8aAxxPmQr
         9DS5pK9kU4REMsFHpZX2COIfkWUqYcx3I9gpK+o1x7ReyHrfgxeM2UErBj0Og58TMkvt
         rCNg==
X-Gm-Message-State: AOJu0YxF2PZH5qK0aIuiOdBf03JLuiJiU4ASDDmtZDFFByysdEtNHiXx
	w98oTarYsDxFQyRuzr/2/7oUETIL+jqn0fBx2g==
X-Google-Smtp-Source: AGHT+IF/o7tMygudcvDEgvWVGduVd5AMvlcE/EGogBR8ckxyLh/FBo/ByXUkDPmqNZldCt3kozHQaA==
X-Received: by 2002:a05:6a00:1b57:b0:6ce:f78d:b376 with SMTP id o23-20020a056a001b5700b006cef78db376mr1612136pfv.7.1702315462108;
        Mon, 11 Dec 2023 09:24:22 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:103d:670f:7d18:86fe:2cd9:84f3])
        by smtp.gmail.com with ESMTPSA id r21-20020aa78b95000000b006cef5c09ca3sm4495255pfd.147.2023.12.11.09.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:24:21 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom-sdx55: Fix the base address of PCIe PHY
Date: Mon, 11 Dec 2023 22:54:11 +0530
Message-Id: <20231211172411.141289-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While convering the binding to new format, serdes address specified in the
old binding was used as the base address. This causes a boot hang as the
driver tries to access memory region outside of the specified address. Fix
it!

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: stable@vger.kernel.org # 6.6
Fixes: bb56cff4ac03 ("ARM: dts: qcom-sdx55: switch PCIe QMP PHY to new style of bindings")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 2aa5089a8513..a88f186fcf03 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -436,9 +436,9 @@ pcie_ep: pcie-ep@1c00000 {
 			status = "disabled";
 		};
 
-		pcie_phy: phy@1c07000 {
+		pcie_phy: phy@1c06000 {
 			compatible = "qcom,sdx55-qmp-pcie-phy";
-			reg = <0x01c07000 0x2000>;
+			reg = <0x01c06000 0x2000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
2.25.1



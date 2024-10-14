Return-Path: <stable+bounces-83737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F082299C181
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 09:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF19B223E0
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 07:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C1814A615;
	Mon, 14 Oct 2024 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHCqTora"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F7149DFF
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891521; cv=none; b=VYpMWfpisVYOd6lRLh4t4k3A+twKzzdnW7/o42CORFbHaZ0AvLLhpojf0LZqVR8HFYH+ic8Ki6I8jneNr+eLLveAKq3cqiprFsPiDVeeVT5tIN6EvaAj6V4oI4k0sfTuot7I4bx2yG3RvY5etvgWQEj/2BliejEESsVdtntZuAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891521; c=relaxed/simple;
	bh=aFFisPPZd/Hre79PkGYujlf0RBJz+NA9/OJB7V4sSdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ne+yVaayWWMXg6EgTJZKtwdmj0aifkVhRCVBS0BxHCtWA3ldqbF+sivlVOxce5Jb+5tA5nu4Y9UGUpYHOIgLrlUmRooOO9ObPIwADOBUHeox6Ga9JKe2+RVhI1mxZHbFMPZMw+GzUsfTtjGRHW2smMfmh7kNoZXLK2qpp/h8m1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iHCqTora; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-430576ff251so34445535e9.0
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 00:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728891518; x=1729496318; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xMboIFiAJRNW3TNHj6EYhFbnvgnNhzRdZUv2visdWo8=;
        b=iHCqToraGfvR3BVEG5ohbaIlOnxGwKbN0Vc0hQj0lw6pWU/O3oEOq771Sk2Jp3YkBV
         Q9SDIX4G1ayxfWL1q5VpZ7jQZtHH5AGqoIqK5BxJ8+DU1woMD3KrCJfnYzUQTfJK3wpP
         Hwqeq8ODOHNyGjOtZWxgB3N7QvxMHFIuf4D0p1ZN+aoPuCf9aq8wThdyXfXqromtLzdy
         YGTwjOGMqtZCrsmF4hQweGlxAh6/B+2FfxCZYcIL8tnhVUdzWr9qQDB8stCRq+P+PPJc
         ZH3yPRtDji/KBi7NL7Lzhfivu5MMGxffqMnurcmVZ7df+9O8WsHtuk827B7rep+pwt1u
         +bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728891518; x=1729496318;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMboIFiAJRNW3TNHj6EYhFbnvgnNhzRdZUv2visdWo8=;
        b=NY03JfOTSLL4Bp6v88yQBRs+dD1z9DCwyWH2tsF6Npbk1f5Z0v7fGDKaD1govPA7LE
         1xohpTtVrs54NzaJQWm7L3JTSEjP96vi8sXdVZwgLYMA8SfejMd/Rbh9dWDKGo2fp18k
         RghSEbk995lrDVUyD8AhSvi0B+mUsCW14I8qX9Z2lA+d8zSSWryCGcBbA9dVcb0ewgKY
         w7Lu9IpHnBptWYc20gBQsN0AEoO3ZpM62ol0KTZQy8gMWKKGoQC+Pp4Tzt/b8JuINejH
         YHqMuwRvbCGRFC0Cu0otPmohLSnSUTFR2+zymQ1MtDLuKRHf1bW5w508LvZvHCzmrciE
         VHlw==
X-Forwarded-Encrypted: i=1; AJvYcCUgdopYUQb4mDoqBTGFAoxLg3KLeeQbQC+SGn1JYjuPaE17DoZ85w/cCuWUZlXjOgdHds5/OjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUkkcYei6kCmjiw1NjZzbjlgh06e33OEaZbovF9IzgIZtAMjG0
	cYbAwxZMaPJhaKHGrIKm7ha+NpYA1HN6M5BByoL8Z8Tp4sUCdXFVw1Kaqadmq3g=
X-Google-Smtp-Source: AGHT+IFxsH70du3q5AUZEen2YEsI0WawZmJ/dpo9/jyFxSTdY0Q5+qOHG3tFo7fOc0Q9dVBYFBL3OA==
X-Received: by 2002:a05:600c:3b9b:b0:42c:b843:792b with SMTP id 5b1f17b1804b1-4311deb5ef8mr81559385e9.2.1728891517777;
        Mon, 14 Oct 2024 00:38:37 -0700 (PDT)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ffabdsm112169075e9.14.2024.10.14.00.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:38:36 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 14 Oct 2024 10:38:20 +0300
Subject: [PATCH v2] arm64: dts: qcom: x1e80100: Add Broadcast_AND region in
 LLCC block
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-x1e80100-dts-llcc-add-broadcastand_region-v2-1-5ee6ac128627@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGvKDGcC/52NQQ6CMBAAv0J6dk1bwaIn/2GIKe0Cm5DWbAnBk
 P7dyhM8zhxmdpGQCZO4V7tgXClRDAX0qRJusmFEIF9YaKlraVQLm8JWKinBLwnm2Tmw3kPP0Xp
 n02KDfzGOpQLmZmp1QdS2HUTpvRkH2o7Xsys8UVoif471qn72n8uqQIGW/RX9UDeNwcdMwXI8R
 x5Fl3P+AkI8vMTjAAAA
X-Change-ID: 20240718-x1e80100-dts-llcc-add-broadcastand_region-797413ee2a8f
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=aFFisPPZd/Hre79PkGYujlf0RBJz+NA9/OJB7V4sSdA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnDMp03ZKoBF3gZn4wyNlkQ/qu0EqcxoioktmGs
 bg8r8yqmHSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZwzKdAAKCRAbX0TJAJUV
 Vm2lD/9Lqer8HmlyUImWfB6FeBaJDYfjgrtmXwjXzbAIKCocA3fE0YMpVjPmbA/z36lJsDH4gwY
 sAQ61APXU5f2f+yrU+2VR0go86I2GK/9ivOmVZ3WewROKYw/Ze3YdJABpXNhDxizGgNKe2XNCW+
 d3/rl01u+FM4OPQEjrbXILs0EKU8nE7v31OCcNK6DeDBOA12+NvAkxK/vSDUeF+xcoynUXPJ5nd
 Zz3N9XEARiT+7xjgPHlxrcuXB08mcJgrNY72Ta0mSL4hldIvbmvuNqklYQC7Mlr+Kpol3uSbjhK
 Aog4wNf2oA8hdxd1czmzeEG0df6AYhXmYfns3LufWpoj8h70h1TJ2l0RGgPqaGzca27s424aU6q
 Oh+mp+LCzgdDQXB0ZWYg3mEpAcR1wiYuuWDB1IgKu9xJgeywbbKywsRC9DQaI4HTC0txgHqMx/2
 dGtxBrn48ZxLIMKeucUfqu+jeBCTu0ho8r/jwnTPdQ87A3GqsQ3I/xe+/NukjVhCpszchH6UHJS
 QnrJ5QLxK3/nNRqV3vKlL40DAeWNpProB0XkApp0nh5uW1GcrFoqpBaBYQ0eQTeuxX6aUhkdV9P
 Nqecy6AC2uIzD5iK1dk5Y3/YPVA0sIGpeYh8Nwd1C+4UbKQ/Kxi8y3K3ga6irhFHCeA4ffMZG03
 FOKgbm7rpSVKGfw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add missing Broadcast_AND region to the LLCC block for x1e80100,
as the LLCC version on this platform is 4.1 and it provides the region.

This also fixes the following error caused by the missing region:

[    3.797768] qcom-llcc 25000000.system-cache-controller: error -EINVAL: invalid resource (null)

This error started showing up only after the new regmap region called
Broadcast_AND that has been added to the llcc-qcom driver.

Cc: stable@vger.kernel.org # 6.11: 055afc34fd21: soc: qcom: llcc: Add regmap for Broadcast_AND region
Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v2:
- fixed subject line to say x1e80100 instead of sm8450
- mentioned the reason why the new error is showing up
  and how it is related to the llcc-qcom driver
- cc'ed stable with patch dependency for cherry-picking
- Link to v1: https://lore.kernel.org/r/20240718-x1e80100-dts-llcc-add-broadcastand_region-v1-1-20b6edf4557e@linaro.org
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 0e6802c1d2d8375987c614ec69c440e2f38d25c6..fbf1acf8b0d84a2d2c723785242a65f47e63340b 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -6093,7 +6093,8 @@ system-cache-controller@25000000 {
 			      <0 0x25a00000 0 0x200000>,
 			      <0 0x25c00000 0 0x200000>,
 			      <0 0x25e00000 0 0x200000>,
-			      <0 0x26000000 0 0x200000>;
+			      <0 0x26000000 0 0x200000>,
+			      <0 0x26200000 0 0x200000>;
 			reg-names = "llcc0_base",
 				    "llcc1_base",
 				    "llcc2_base",
@@ -6102,7 +6103,8 @@ system-cache-controller@25000000 {
 				    "llcc5_base",
 				    "llcc6_base",
 				    "llcc7_base",
-				    "llcc_broadcast_base";
+				    "llcc_broadcast_base",
+				    "llcc_broadcast_and_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
 

---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20240718-x1e80100-dts-llcc-add-broadcastand_region-797413ee2a8f

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>



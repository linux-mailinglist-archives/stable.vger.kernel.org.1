Return-Path: <stable+bounces-104091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4599F0FF3
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB631889100
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB351E32A0;
	Fri, 13 Dec 2024 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivgTN71m"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7A01F03F8
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101692; cv=none; b=XO1IWjjHheO7jAZeLYhrSJpJN7J3AGyssOqzwy5BIXvFrFtnCjl/o42EJYuohnpGBaW+pkjH9y2o7PwohtzOiK/brbuj6suCyDRXsIz88yXiKl/m+gmvGTAfVBuCFj3Jeujmo3+xMQs2hrCLBaHXcOincJP4TIOmWB3ufEy/sLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101692; c=relaxed/simple;
	bh=ABFqbmHhHH7Xgv2t3rJYg8I/vUvg4tygW/JE2vLwoBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cg1DLkadwM2LrPyo/TJ86Ebsktj8TE4Def0CUpaWVKoFNkbsB8swcOgdJiS9xR9FCmqnfQrBVXHmKI8R+QqysMHUZfciVy8f8CfNHrX9wS1Qu2Tjj7efGlr4nCkFkc0EyFc8urkWOBlT8nQ/Yqyggg5+FEtyJRJ18tQEDqQmU5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ivgTN71m; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434f1e5e77dso1474355e9.3
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 06:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101689; x=1734706489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqP3rskjMQDYwGOkbcit2w+Rwm6c5e4swjuK4vYedMg=;
        b=ivgTN71mtpkZpijbNxfZCguT/EqZUQgqQJiYoz8zLhO3FiZfgg1VXV/6TeUAEIxIzv
         H7IjuxPYK3Yx391N9QgM/yk787XAUGbWWGmJNBx+p+0MaqQB6hhBzq1+bD2m5d4Qm45V
         SqHKzPioXMu3nLDzL/MJg/bt8QUv5VZc41JbFoBapO9M1sq2ExKcQbw/AnEnsbPA0mpo
         J+gVAldkfDHdltE1V4p8IjBO/wUHvNwThN9bDiYZHz8QX8MBnUUb/K1rMl3zuBh6a4d3
         Qr7S7NnagOJEC0Smk5+Fmz0Ww1yceseEppvOdeqVfL0N/OKcyCcd9Vozj4g1WhaZl4kL
         lLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101689; x=1734706489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqP3rskjMQDYwGOkbcit2w+Rwm6c5e4swjuK4vYedMg=;
        b=TJVS+yI9ihmI8BUKwsPWroYe7vU1d77oyrFFdF6KgsWiyQVskR0ODBwukOINREyYcL
         Bg0VI19TPwyRk3Vm4NR1Xi+W3J1wg85WIuM46etKMlF3f634tEpXwAa5jAbt/ofD3ZLr
         EI3RUUL7gHRSx73AlQvCNrXiVvUYHLAOtwU+9pWfi263+/GnmKukVPz3v+STsw88FyRZ
         5jEbs6QEZabopXZmuarEHklmEN7mjStPt3VcdTRbgO1huPxaZlqLc20fircPNgks07w7
         Jf/pefStUVuLTbPMLrbewUyX8rU13/4i8aU3ugIm2n+LZ9JkXycCxoJrw6p851GlYi+F
         AwFw==
X-Forwarded-Encrypted: i=1; AJvYcCXAz2X9JwagkNAKtAe/r8tRDi0fbcSIw5ciMxQ/6PK2UgtfTSkS7VWB0rmjri3neN9kShWIPEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+c6PJYkhX7W33U8Gy6PiI9A/C5Pb+3Ncohnl7wnclqPT3xZo
	vc/gjIW3JgFHS7sWVgetcTaFpIXjP3GeCsLfMv1rBQYje5jhuqpiZoTVdBhpWA8=
X-Gm-Gg: ASbGncs0DZhVdxFF1b0efPUURZm51FQrdlO9LHaEj2Xp4cGQBMJHgGFRF8ymqSQTTkA
	bcwpD0NyH2AJBpIjWlb2NLgsLWo/ZxPNxmsyv4xDOzhrzJLrg+0y0kX8m1GpSViYOoYfCQ+jafI
	0Z7tlcG+7mem95mJmgwkqthejK6k1QLhWxuzYjdzDfkgfJH0e/YqJG95hBwXRbJTxeJKU3QyrkM
	cbuceEHsEhc22pzY+IstNhCeRoVBio16wG/BiHOASJpc9B/CgAtkZcFgyF62ZeUUMZO58gG
X-Google-Smtp-Source: AGHT+IEVf1A7ScFCfXLEp/2sH5gbiP28ZvT7cwjORVXtRwRVfkj+NdsEKPjEQOo6twzJdUKwBjYoXg==
X-Received: by 2002:a05:600c:3b02:b0:434:fecf:cb2f with SMTP id 5b1f17b1804b1-4362aa8faa0mr9498505e9.5.1734101688846;
        Fri, 13 Dec 2024 06:54:48 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42c8sm51547305e9.29.2024.12.13.06.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:54:48 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 Dec 2024 15:54:05 +0100
Subject: [PATCH v3 16/23] arm64: dts: qcom: sm6350: Fix MPSS memory length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-dts-qcom-cdsp-mpss-base-address-v3-16-2e0036fccd8d@linaro.org>
References: <20241213-dts-qcom-cdsp-mpss-base-address-v3-0-2e0036fccd8d@linaro.org>
In-Reply-To: <20241213-dts-qcom-cdsp-mpss-base-address-v3-0-2e0036fccd8d@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ABFqbmHhHH7Xgv2t3rJYg8I/vUvg4tygW/JE2vLwoBA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnXEqVSz4Xii+5u2FkN9Errz1XRRYspMEV8kZyz
 h/QJrorKrGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1xKlQAKCRDBN2bmhouD
 19/6EACKV45lYPAP0ZEEzF2FtmpSxbwwxiaPWDuKuC2QPIEe0JvLJscY4Cr05LG7BaXOxkCZZP5
 eBLuFSPyRR4aOFZTpvVL187JDgT3b2sifVgsLm6EiDlFsh7BqJ9l0H0kgvwkYveVjzZ3Ei2GhG1
 Gy5H5/P6SS22zJO9wxwWou2gOOHp4nWwONjBClxrddBsAUIXH+EIoKk6ZgUCaeyM15ZP4ijEkkA
 nZ2T/fhOWq1/czZIi6GFsYDNw3ZWPEXT2VO7isetSB+F0QzF+OWCoFdo0j62HtC26C4yXTzxcWq
 Mmn3KVvzFDzHeLiXUkOfYXHNeOBU04PsSUIcC3MexRsBshX9r5RthW4wQZXRZjRNzllsSnKbvYs
 5xrGh7RJCo6B600A8tJIvxzbCgL4VOZpEnLENBb/I2j82ptezxzjG9xcBEfu+c021MIxxE3Ia5A
 IFiy/smtN+4WU2r04SQkp2sGjDSNN/8L0jxwcsUvdfA7mNCVoSlVlmuSn4mKVupeJceB9COUVoA
 oJbWEvPVaUzhYduEqjL3wtdnPJKcckbrBXtwf7aWVehlUh0EhlKpVkr5tT9u+INPXB6laAVTNVX
 TyzdVyoO0H3Yc8E8qdts8x3+STL30ePdP9srNXnVxr20/RvXKoQjS0D0ilZBJPiluaKVmttpjtB
 oxBNicltJniZbdw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in MPSS/Modem PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
copied from older DTS, but it grew since then.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: 489be59b635b ("arm64: dts: qcom: sm6350: Add MPSS nodes")
Cc: stable@vger.kernel.org
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v3:
1. Add missing Fixes tag
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 3df506c2745ea27f956ef7d7a4b5fbaf6285c428..64b9602c912c970b49f57e7f2b3d557c44717d38 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1503,7 +1503,7 @@ gpucc: clock-controller@3d90000 {
 
 		mpss: remoteproc@4080000 {
 			compatible = "qcom,sm6350-mpss-pas";
-			reg = <0x0 0x04080000 0x0 0x4040>;
+			reg = <0x0 0x04080000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_EDGE_RISING>,
 					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



Return-Path: <stable+bounces-99923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415DE9E7449
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D13C16ABC7
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEE320E71E;
	Fri,  6 Dec 2024 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOePFSh+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED47320E6FB
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499189; cv=none; b=LFhT9NzPMzdM64nrhal1/WXgY9hATTHjCSkc/feI0FjvTSVoaufK7vsB4mFdaAfYVSDGiFl10WT7HRPDjfPaXJuBUVj1fi5fygoem/wLoJD/eyD3C9Ulit3/Df4/wIB3x+utqQeOioozBV524wO8Ho1rG5n0+vYEn6PVbV3E/q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499189; c=relaxed/simple;
	bh=FsThsOL0Bf3ynw2jB6FK/cXhVu+oNNo1N/YAEGwlQdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMGJL04v/q6PEVchv1BsuFFi5Bvst4Y2HT6t3jmlIDa1Qt7xJDMEWeigRAZPqfCSgLTF0rh9XzCa4I8v+q9an/XwvSsSfrOKkU+aKVc9/u4zQZ8MlyvF8VH5D481NRUKHXQqr51dTPaORoAyaM5xSqxZ/JWMT969JDrv5h0QiSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VOePFSh+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434975a1fb1so1641695e9.0
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 07:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499186; x=1734103986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRKcaDdVJ0bgPnlxmst9lMgVMyjRGsC1UMd3B3RO8vw=;
        b=VOePFSh+/ZH2NVQGt6e41LprfgvZmfaO0MX244b99kSlRNBe6oxWFMCiruBmIhrMqq
         WAs2d9Aq9LvU2VrWt/RUp6gzST+BwSIekIAdoQEw8H7PIghA6f4oQsGMye6zOgB8lnDO
         zv/d3CY3KPzcX+aUL2i4Dc3VnAAsFDrdkrefRzlsbYw/DUMxRHngWzck+MACJ4Mfbxk0
         dxoQD+UE1JOhja+PAByPIA9UCeIO+jnk89LGibWE5LCUS4cxXlz3nU2QJ6cQZq41f+KX
         qlV4be8Vo3rGhkzDh5f3pHidHwUcUYuPHNGRXwUwjG3jJsNhmGnu/CSjQ3QwoHIdqD2F
         tLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499186; x=1734103986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRKcaDdVJ0bgPnlxmst9lMgVMyjRGsC1UMd3B3RO8vw=;
        b=aLLtickHt9K1dbvqUXaQhY1gbKDVhqL/pxq8TN6k1KcsdDEBBjw8G4nL+gd/Z4mepK
         naGZPNHKfyPnmDrltaZyxSbgIJ51sDFBolBiF5znGXVDnJc1GFYPZdh4iaENb69FNGzg
         wnLkRCkaEtA6juiDaTtuuH9SaPyK4tYkvbq7RLlnYtED/sL0lYv16AQqqsnrO0Yq7SHL
         /62j3unfvB5/p+7mJazy2tllgIgKaK4mWzoKJcpiZOlAGL01gigFGzFQP0SNGZ669Kq1
         y1+dw4a8TQX77s7XfyKYNmXHqmPOIp31C5bV1ftywsaK1z+WKONfjm9Op3Stocleei3M
         mWPA==
X-Forwarded-Encrypted: i=1; AJvYcCVTfak8FopA3VbtcSrGk4l+vR5tCI8xziBTumaCeTuc7UMdUOzt4jOSoGFopQauc2h2sKtqRrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxig0zRW4b6GzVhERAzJP9hbDQoQUYWH6uiSIruKdy7Q/XkacGU
	+MnYYtJ/S8YX3LTKKmoZPQyiTvzXewkZgrPkI6kQwjZeeBdAZl/UiALE4EPSRZA=
X-Gm-Gg: ASbGncvmDXKI7hnAKKDcgCV3mteDwhdsjXjQ+Jnu1iHgeVbGPni21oihkRQTfGDoHkP
	QVeTVhSimWV8ywDr0iNzXewBnOt5iYBftAf1AXFblnb+jCJtKypIib0ZFMA1jN5yFRTmsINCaUi
	0uZSGqNP6wGsge5aYfOOTjxS9Psgj6SlYyYg+V9wndgl4qsZ77uIMvVlFPe3qmerNfy0ReCXl/N
	yWeVRpxH61yvFg1Etn4W5x96bz3xpvnpHgTmqMc+fs0goE/ZrBSRgaMU860hZcOHg==
X-Google-Smtp-Source: AGHT+IGT251aJSS/3W7O8ICkukUWdXpKQhe7v5jriK8vXOjW3wjZtFc96BhnYFT2zg3DlUNmRxZqhg==
X-Received: by 2002:a05:600c:3543:b0:42c:ba6c:d9b1 with SMTP id 5b1f17b1804b1-434ddecfaacmr12717975e9.4.1733499186278;
        Fri, 06 Dec 2024 07:33:06 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113580sm61158035e9.29.2024.12.06.07.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 07:33:05 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 06 Dec 2024 16:32:33 +0100
Subject: [PATCH 09/19] arm64: dts: qcom: sm8550: Fix MPSS memory length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-dts-qcom-cdsp-mpss-base-address-v1-9-2f349e4d5a63@linaro.org>
References: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org>
In-Reply-To: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=FsThsOL0Bf3ynw2jB6FK/cXhVu+oNNo1N/YAEGwlQdg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnUxkV1DIfJiSWc9XCd9acCYt6cBRT5OxiCd78f
 /CsS0TERUSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1MZFQAKCRDBN2bmhouD
 14MeD/44MfC8jVPfBqsaigaN0WMgdBV4uDggN3cFr69Qh9vDoZEN/zAgfBCyNI0g4qEq4iQPGV+
 PQsBsr2Rj4ZAaOlDgJnxOeun+wyL/cUwxPoh7mPfmoOeVE58B450TMXfhDJT9kmZ9loSGgnWn0r
 0Wg76t4RLp9WOYFfBUBY1UKzlPwYCR5Xsdct5guUeaWEILGIf/+0y2lzJUL4YOTzUoRdg8gyDR9
 ZneZaWEswb0EUtxf2K2uirBNan5iAHotu381ReGG31nJA59VeIIZmfpdlZunGRh8OWU+fkiBHLR
 4pTs5yIphWwes4ptxj1YiJIAavfVnpM6plyoC3mxAJ+H0V8TIswpUG0t6y8//4RcvySy1GrWnAv
 Mm0bz1eoS8lYJlRASqezNhFNWOiLTlC4+hxsrvADtp1TQbTQrdc+Fs8rrd9NXIrsvZ5YRyt4Tpy
 /YLbyU6H082Fl++1l0vh4hmSkXeXpiCWLZTrynoq409/W6kPR5gsVBg0H+ay6h3qv9k/lC+ukyE
 N01CjnRO/S04x+6k708iV8XeaGQKVO20HwPLPDW7i1oDJFIPafvFjP8Dz+MZV8+jF2VcqSnZPW7
 C0MnrN+2zWfxcgbhQ6mZyeZD6SczO3DC/YmMk0Z755TkM/3+JInLsaOWT2zpcKZ/ElE/PZkkF/z
 aPtmkJGhX4X1X1w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in MPSS/Modem PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
copied from older DTS, but it grew since then.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: d0c061e366ed ("arm64: dts: qcom: sm8550: add adsp, cdsp & mdss nodes")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 541b88eb5f5300ef9e20220305ff638db9b2e46b..71ff15695d396a68720a785435e692d3bbb38888 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2314,7 +2314,7 @@ ipa: ipa@3f40000 {
 
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sm8550-mpss-pas";
-			reg = <0x0 0x04080000 0x0 0x4040>;
+			reg = <0x0 0x04080000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



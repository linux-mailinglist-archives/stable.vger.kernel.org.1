Return-Path: <stable+bounces-99933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E909E7473
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BBF1887157
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174BC2139C6;
	Fri,  6 Dec 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h8xiT3oh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04264213241
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499205; cv=none; b=N5+ThTffBWeNNBZ3bLZuWrvPcWtroDoLnxZczQhYru4hXIKJx0xs0fAvbTnnRbw1I7gQvJqH0NfyseGDkD/IebK4vFBaH5y+AXMaapyxR1cf6ct/ZZdDO4JL/VBk7liB8s0rZGyBuaGKe7sj9EresGetDQLubmEaB/sLE09QfOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499205; c=relaxed/simple;
	bh=TbHlMdWDbh+udm1eEV5kveS9te5ak6OhnhlUSegMb6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GRY165H709JZd+5UlNQs39unQI0gcfuc5rs2Mbbkc9VVTo56Nok9CKTQtQTXLrb6RPGOADuX0Os7Mes/KMPqO+flsKIOh4bue9YHE3IDvNu446raM6gpRz9NkhM7v/99ISowszaKLVUuTDOoQqKjG6832jsN5RfhLvgWFUp/iHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h8xiT3oh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434941aac88so1625465e9.3
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 07:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499202; x=1734104002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PGh5NFsA/7r2mvIfUSdrK5+hBRX+q+43rwMtzht8l8=;
        b=h8xiT3oh1+F7MvCEDQbNUa89xD7UbACHpHRMBIv7re/2jq+zh6sb9aQ5DJqqtW7bfY
         GZXgZAhhG6bG+kqcv7/JHKaARd/craVRfNRNLywyEtKPKQhgQaD7NBOELzeBs9zXiGaP
         NI1UVZN/xa/nMOrJ5QPHkT7msl1HziH1iFUZhVYuY1H2Hqqv+9FUTAo5ue6ce57oVubJ
         V9a7mB7fWjohpddZ1ixU1OjJDLsBLbL/6t9juQK5/3+tLjBzXrPithtn05PWVuZ06lHe
         asxXJ/PMZVL0b3gMT/yl009mCcxFhf2UXn0a6W+wv0uew9P+niGRDjlPKyKDdNDEXBi2
         BVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499202; x=1734104002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PGh5NFsA/7r2mvIfUSdrK5+hBRX+q+43rwMtzht8l8=;
        b=YKnLcNvq8dqNA9ub1EJk1iE6WmEuhvg8ZokgTTxnEZaU6JXgoBR2wnfLxz5QqWZzXr
         8Azjkjl/H8CZnvwElpIg/l4k3VXT+nVdbHbIu+Ei8RE+LfTdRBOxOl4sW5EfcR5WhctE
         y+JLPrdrHag4jrurg6OTPFjk/oyfH9YSJVyv8hNyCLrwuYpHJ8XdyHSv8fH58ib26uRe
         xFUmgKVPtxi1P4p1OHG5pVGvobOG86sxzw5fTrulvJ8NvzLO5bm+GmZVyYJIvDt9ve7z
         QiOmxHHvBVAB3I5Ke5OJLU2+/U3z6YMXo/d4d1GKka5w/vEGSuaw33NhSWaVkPwb0PaA
         YAGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjniBI5d5hM0P1WVIsnQHysKVTN7ZnCu1oyCImOR+da9YxgfFnDGiMY/VMyLxSjpSMzg+Sdc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn84oFooMKcd3VkGy2fIlDaOBvR9AYaeiXAcd49iW8m2pepdVK
	7NqAwMwCHUcOJG8FCdzz+dPyf9E/htpWrUnurieA9nZnr9rl09tWDFEig0SL6KM=
X-Gm-Gg: ASbGncsknTkZuggo0Av0sfggZxGIQY9SVvQzwDESz6lI97TlNcS39JGhAGpzg4ZrQvz
	tc+7wuLK683fsvQ++gv314wxtMLh7zLZA0QAAdtpVLkH7XFbO6fVQFQFMUA6z+tgVF6K9vOETN6
	fhJMEphrvcLsbqhckhpsCe2+yXuI+SBb9zgQAttMYOK5LvjE+eZwJTNBdgra3KKcvtVf1taJ1Qf
	etjPyyYQednuTK8fQhU3CimWmduiDAPGxcEQ4BNEl7tvHh/RPGdVDcA6OtearEsng==
X-Google-Smtp-Source: AGHT+IH1B94SLBhWXDfNvq4br6OP1CcpvtzCKvxOA3JO7DURrM78z3zJKco/aRxWLfnXA1MGV088jA==
X-Received: by 2002:a05:600c:3543:b0:42c:ba6c:d9b1 with SMTP id 5b1f17b1804b1-434ddecfaacmr12721645e9.4.1733499202485;
        Fri, 06 Dec 2024 07:33:22 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113580sm61158035e9.29.2024.12.06.07.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 07:33:22 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 06 Dec 2024 16:32:43 +0100
Subject: [PATCH PATCH RFT 19/19] arm64: dts: qcom: sm6375: Fix MPSS memory
 base and length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-dts-qcom-cdsp-mpss-base-address-v1-19-2f349e4d5a63@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=TbHlMdWDbh+udm1eEV5kveS9te5ak6OhnhlUSegMb6E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnUxkeAIIB7pzI5GvqISy04xr6O7p0geT0LdClC
 1pYkV8qIHyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1MZHgAKCRDBN2bmhouD
 16fdD/9EbGQ+ozJRjJI1gbclmXQZFKCGsbQjQApnsucKePir9oXwaWIhIjg866OtjDgpaVDfd7o
 1SvsDrRvB4R97PGlb8DYdsQBu8MFWoaa2wFgDZqxhJbQpVzWNVHClLqvbNL5UEdt81HSNKJhJWK
 ZKOQn+yk6mSaO4oinqYqKW2ba1qd8iWVLNETvcgrm6v6O83E4way+NprFfMc1IKdPKmMYFnFrti
 /ykTV+UqhJA/oEDgbVzBP3S4xiKfHDfRshX/E6NnYwq0hGhiVTvdSf+npZeEtPybg6uFdMslDdP
 Bx7yZqg+CI+cteFWeZOSi6eCm1TC9tsUeUL6z96gICCjONJkL0QczbfF+1ybxa0MJZ2Tue10qXU
 6GfoeIgZQ3Hl15h8JNdE5ODkwggbN74Gxz2Ke6A7T1e5GZANeUwHbUJlddiPhThvTIAaa0kN28r
 Qt1IVc3Q+qQ1/BbzJ5qAwKd20UaQh+GBlF0HFfMD+i0w04RD3NwscTx/vaVx3RrxSUUpwxIhTxs
 lLtWSoFJyY9bsX3+vvKoJJHj1bVFud6hEvOjMQWSEGzsmzC69F59nIGxyW6ADweKdIjmgpzu2QU
 7qudTeI1OKbzrFzObDQWelm7wSJlafZkVTI646F1UqbkK4e98CnYsLfCXNDQAE6e3z4RHUGBfFI
 O9Tzb5vfKKcUWZQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in MPSS/Modem PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB): 0x0608_0000 with length of 0x10000.

0x0600_0000, value used so far, is the main region of Modem.

Correct the base address and length, which should have no functional
impact on Linux users, because PAS loader does not use this address
space at all.

Fixes: 31cc61104f68 ("arm64: dts: qcom: sm6375: Add modem nodes")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index bb6511cb451b1c45ed2669f208fe3ed00848b481..4f1d4b233697005aa48dbf80700fb28980d88cc8 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1516,9 +1516,9 @@ gpucc: clock-controller@5990000 {
 			#power-domain-cells = <1>;
 		};
 
-		remoteproc_mss: remoteproc@6000000 {
+		remoteproc_mss: remoteproc@6080000 {
 			compatible = "qcom,sm6375-mpss-pas";
-			reg = <0 0x06000000 0 0x4040>;
+			reg = <0x0 0x06080000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 307 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



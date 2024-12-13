Return-Path: <stable+bounces-104078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165F49F0FBD
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD802836D3
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A551E3760;
	Fri, 13 Dec 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kJl0NXgn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481C1E2614
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101670; cv=none; b=VWLEfxDu9rKLq+Bx3v5Xu6O2iSmUeXCGkOReUA4fvCfFd1S9ZCvrKQSsGzTXGhypljQgoqmS8N9mRVBxyGUkh6e+87f1YicoH+C3Q2o6NMVL2xI1ePl+ho/OMJWX1NK5E02Dpbtb4PWDjTeHauffO/+bkVfqzHcP6hQb2HzVEEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101670; c=relaxed/simple;
	bh=gk48oC9f/Islqf8fEtMbT8F/fJ1LaCSok5/DLsdp368=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MZgFTW4FkEZRVmqjdynVxRojaKMNGj5z+ypZOWNflWS+/De4U5N8RiKPAi5C+y8VJ9YSO3Udx5wd0FKyftliJ7ywdSKXJHY4nHzGIMMblSzK06nIGgiva0h/BGTOq6YVkBGMqRlmN0yFObMk9GQB2F07HiSEB+ktq10Cg7mlVOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kJl0NXgn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436203f1203so1856315e9.2
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 06:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101667; x=1734706467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXqCJUJj7WkufcIYnMUlH0kiIEfBlpG+zhLF4O1kubE=;
        b=kJl0NXgnpVJfZeAxmU0qkjD15gIJO7i00B4ZGvxAVEFcjxPNsRU+kPGbLffMq9di1w
         9ics8aBEr797dEkDYXEa3PXcVEkyLaxmTl7xsdOOdlHk0DcHg+myej1vS+KA1NA3eOBJ
         KpbzS3jXK1ZPuWejWy9j4j6SaOSCqaovJe+DfX9tTDvz8f615rg7wgoQVokWNTcSKtO4
         Ny6/ANwP3xxwr9eHyP3/BZPeSS8pPg72RCvHyzXgtUoUw5wdzHIHD9GU7zwopAYcBdpW
         WbASoq2uZIZaMPo88qoD9oVwlTvof/5PA0OnuojksuDrZ9FI6kN3GcPZ7nT7odNO0O3+
         0b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101667; x=1734706467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXqCJUJj7WkufcIYnMUlH0kiIEfBlpG+zhLF4O1kubE=;
        b=hlCVmRx7HqUPimOTnafusxEApgEoTq4DRW4qPB9ZmtEzTKl4jD8i8lLruTQ/fjoCRK
         uOZW9XfOCv1qc1yZ66r+KxBqYZWvz6desHA1zpBN40u/SXMX0pMQuSvv5Fq0JFv97Lw0
         GMCgLWGzTQYGhdjmVGMec1GDqyQwKt5ccFjib1EXwW9v/uK8yryVkRaIvQRKizSiuniG
         Z8TfbaNjCtZ8UZ/aL41lB84QmdK90c1JhUw23JZlZhZnId5z6+OnIYcUuUUkeUT96/ke
         RRMduzGlJtQSDqLIXAM95UTC43M9L7Hdr35dNWWDbgQoodFsxs+5buBWGXweG310ZM/W
         Bq5w==
X-Forwarded-Encrypted: i=1; AJvYcCXOyF+bXyQ3zac0LMDcC3hWQuONhziHLy0HobJy/Y9E0L2QoaxIifwIJsRKMfyEAbgyerpaA3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiOsum/vfcg5bCKHYpreEZHIQG5TOrFqrANCl9NOkhQkY/MPLw
	IXSd5MmYgNICZlQ9Q3ChOrY/8B/oNMn3B7mm0tUFgvptxURPW1N/d+22NrHSdOU=
X-Gm-Gg: ASbGncsD1z6c7mRl+fCgt40BDVfdPlP4ZLRCmWBvfFnoez24XZHbN7SsYw1nJxsAQY0
	uW9zM/cf8Cp7ni6l8J9xGr3DR7C718FnbcdjAnhUaXh6pMrMufjv0wgJTHannKtvT1wpn4KT2WE
	DoOTLufwDMhfo6KDQAJ3W0WGrgZKld1mGwjUd4KGbjv6t/eJNOrmm5Ylak3phl69du2w8Ks5kF7
	MXjb53oEAmxcaGRollVxUYbAQP083Mf3+tWeLG4gIDcuYq6BYTSXXLAbijzjVuNaI1fIL+h
X-Google-Smtp-Source: AGHT+IESKqrqpWFcCULhdb8HodCenHYF98MC2zzh68Kay2W39cityMb4llcmVRKGbMmkETHet77wIQ==
X-Received: by 2002:a05:600c:1c14:b0:42c:b55f:f4f with SMTP id 5b1f17b1804b1-4362aaa97e7mr9363115e9.6.1734101666842;
        Fri, 13 Dec 2024 06:54:26 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42c8sm51547305e9.29.2024.12.13.06.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:54:26 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 Dec 2024 15:53:52 +0100
Subject: [PATCH v3 03/23] arm64: dts: qcom: sm8350: Fix MPSS memory length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-dts-qcom-cdsp-mpss-base-address-v3-3-2e0036fccd8d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=gk48oC9f/Islqf8fEtMbT8F/fJ1LaCSok5/DLsdp368=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnXEqJ3dGnTfAi33y8mxVZg/exhtL5ypK/jjJN1
 C8sNrQxGIOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1xKiQAKCRDBN2bmhouD
 1/GDD/9aMgwvbB35BFABD2Z1zlRMOAC+oEfmd+DSoCXB7MB5tGD6iDGCnhuseI7UdhpiFBmk+BE
 bT+FU7rubq3cObVFEgd2qdp8NsDwOO5PQQRax7aL8gYlu1kw1ttt6cPFb5LTgGXACr5m065SbSH
 DIQXK+Utu0S/BDK9J+VWGT1d9E0dv4lxuiFTXkliNdYXKPwIn6A4BS3xxlhshf1jCUcCetkWYfQ
 pVBmI/6+hdGpP05w0Bv5L3WiTDdinGJiCbbZu15c3TkiDIERyOVXlgOxjGAD3bYuG4R6Kfh3ROx
 wKPGTlZApd5WrRlqwTBBucxc2VQBA5KPbCkk/kfpUWE/bt9Te82koirTmLqRTJLh3m4YL8pAtrP
 l5UR4XHKR9MObfMRCEyPEwl7XwrH+m63KvR1YCxe7atXo/X4erhcht/RiSagn+evO2Q5g/U/MxY
 bF1JOn/YvBSGs/mWXYI/8atNPaZyQlU/0W3uT20eqQtnqazUKvpIdFQPoY2mSweqis4RkwxEQtd
 eEURWdDn1lYWWDKc4cz0iSsxLJ6CMccUjKSEpHwm4Z5ztZqu9qn2unEbtelDQ6vaLdPnljwHGFp
 KNRhCtOho/enVLmz1ku/0QjlEv5XApOH0SuedOn+BSP4latO4oyMDDEIg6vkOKvFyqQG8aTQO5k
 VMyaxDLqVt8Ncdw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in MPSS/Modem PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
copied from older DTS, but it grew since then.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: 177fcf0aeda2 ("arm64: dts: qcom: sm8350: Add remoteprocs")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 2a62405c0c9eff959abc4cee57753a8b1545c9bf..7d77dc528eb734a86be5f194b120b6d926f150c6 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2214,7 +2214,7 @@ lpass_ag_noc: interconnect@3c40000 {
 
 		mpss: remoteproc@4080000 {
 			compatible = "qcom,sm8350-mpss-pas";
-			reg = <0x0 0x04080000 0x0 0x4040>;
+			reg = <0x0 0x04080000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



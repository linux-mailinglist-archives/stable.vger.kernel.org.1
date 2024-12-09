Return-Path: <stable+bounces-100140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24469E9165
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D363280EC3
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607B121B914;
	Mon,  9 Dec 2024 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xjDfGveP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2FA21B1BE
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742164; cv=none; b=faPYsXIuKrQY1K+FSejuLhw0wwFf0+HTX2ws7TLVbbzzwUTeEXEg/gojuJd0ZBHlegm/cFWs0S3OrR2m7oo8LppT6YXVmf7VC1p5ZmIPLt1bpBPGPWV64H70dhRhvqcHnumkf36OPF7Lo0zTZsD39qmFZnV+ioOx34gL6bSUtCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742164; c=relaxed/simple;
	bh=yEPqHjmIbUmITf1O49UDWhwRUCdSrmaIhPmoTG307TM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esjS+Ef7hSOqBmVRJlcwVemk+s/9Td6s4cEbBSHweCUwU00ZPfkgrXAyDmeFZA9Wp1SMc/xjO/i2rwYuN3yfodo41hBs2jJv5kw2BduoUsiuS1HteA6rBiSa9+I3IQlg/ZNfR+epQzmwaIVoG88NHIztq/xxFYIuGCZYQb63E6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xjDfGveP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa6935b4f35so5794966b.0
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 03:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733742161; x=1734346961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJx0NfcTqStUzuYKIn4gg25GLXMxBa36UekQophjNMI=;
        b=xjDfGvePvwd5zKC/IxTNL6a4n856GA84yrGaeX/UQAVkz8vvPC2Ca4qxgm4MFS6fra
         TMCMXEft1UnYT/oQ2rgXoSQx2iJt/2bFk/+lE1EmtGqnKJJSN+D5wYR/oGRTfLbBw4cm
         8AXm1fkvYvy2IeRQfkA7lbL+J6jtCtCELaxsvGByIufW5DFqxvGtLA+ZTA7cQJRaZ/y8
         JIzA9NwJJQlKQ4lBxGvv2WJX6phdO0pOPJYkdhk6kPEkhFHPprDuif2yumx/63pd4lIR
         aJbsOqvnNCKTA5eLg017V9/jT/L8IOaHWu9Lg1/WPmyXkLRobDmllTcEZRYiCp7MYPId
         It4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742161; x=1734346961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJx0NfcTqStUzuYKIn4gg25GLXMxBa36UekQophjNMI=;
        b=TjlQWI9SQEglm9rtqYYU98zUGEI2gTQEymAVlD3vKqAddbBMszdEE7U8t07FYy5v8Q
         s3CdC1D3RH77lVlyzw9EMVJ/BU89poTOzGUoUoPEhZIoIOS7I6Feqzg1tLScoxizyC0g
         jG7jda0RbAEV6wEfbu5KZDIQqEN5S8kQj30b+Ork3OF4yGwBBpROiwetcMF/1BxRo8Pw
         euzvxlaU/l5pTjEQh2navLxSE3Fy/wM9ecihjm0L+/SgcHjww8QbomtTShN8sjcTHxle
         ag7qJ/UnNrkr3g8Wz4lF/Sm99XOyxXETlQlbmtVR8SOehsPO1GyBBdlG3H4k7dP7gpNg
         vcDw==
X-Forwarded-Encrypted: i=1; AJvYcCXSmwahGOzBO1DuYQg/XotrBjIqgt/jMCIV8SYzutpaw2J16nyEWwxnDEPQi6cM4Gb/iNzIfCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXu2jcU94IPvnLFNHCQ2QXv9A9St+tji4A4an33cVHn0al+aAz
	rLxa6qdsniGBpnh/GqT0Mi6UvduBQg57oHmrnyYP7AAH5xgX7jf1H7IvzpmOc+Y=
X-Gm-Gg: ASbGncuXeAfhFrtb18tGKbibAjKKAPxiAjftHp2+wW3d6z4wDYK0r0/zqnEXEcg6VtL
	0XevX9U+CbyYUyI/pnNZHLiN1wAjUeMkZorz0tWiIlKK9CvekunagxL8XMqlyVtH8k0cDA/d4SG
	mo7cckuEN3x1hXJZvba+47UACfd5I8OnegJPT5ilod7vEdz5OdGGpj8PUB+WwKR8yOpRJtTBw/4
	gLy6ofxx7okHk7/8tja+EsFtHjf+82CKjSURmlDM42c2em0vEsiz+Jy+NPwEbLWaA==
X-Google-Smtp-Source: AGHT+IFhhfRVDg1CGXum8gpQ0cgkjK1GmXgCh7/JnuDKniWLinqdsYk6z0kqv+PmHrmlqgraEjxaRQ==
X-Received: by 2002:a17:907:724f:b0:a9e:c430:713d with SMTP id a640c23a62f3a-aa639bfa414mr500502966b.0.1733742159564;
        Mon, 09 Dec 2024 03:02:39 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dd4f641bsm3348818a12.51.2024.12.09.03.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:02:39 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 12:02:11 +0100
Subject: [PATCH v2 06/19] arm64: dts: qcom: sm8450: Fix MPSS memory length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-dts-qcom-cdsp-mpss-base-address-v2-6-d85a3bd5cced@linaro.org>
References: <20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org>
In-Reply-To: <20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=yEPqHjmIbUmITf1O49UDWhwRUCdSrmaIhPmoTG307TM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVs41jELXY2sQtTLqRKxN0JKaSzDMSf7Icbj5A
 Iz/LmrIJPOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1bONQAKCRDBN2bmhouD
 1/q5D/4plWc/iXSk6IL+Wlc7s0c1MGWGF3hW5jR0WssTIe8BEPxS11XcjNKwS4YVXHCY2XoAC3A
 dZDNvZbkvVDQ9DI+K4vbnNuDj9u+lcxOJYqE/JaPokxlA9ykzDWG5SJAVzbLcHCxJncr0HyWrBp
 5sqyv8HLXMgWwahqQp1kTHlr1w6pSt4biMwpZlELkR4EMemTSqDyKmn1RwH+I9oz2UpvgqMMLyc
 b9byCVPZKNYD2YwGdemVt6QiQoTr8ymDHQqJYAMjeePKKDRPascMZHD6B5Vysk+dtIGzk4+mu4A
 AYR+C3qJhGOxlt0QIMf34GLVSGAE68V/H7IgU1IcDPHtvBAK9bj8hhRH7G5mcRDmoUIAAmeY4rn
 QP2A12QCucrPHStJMS0UKZK+Mu1kxtS/6g6e+5TONDwolBO8vPaXDQDbYPg38k9N8moazr0FPcv
 oBUTtQ6JwZNPv4G2QWNvQHuB7Ah+x7/tLfG6YC3CXQw5IF0c+/7BWLiSJdVyWYHHomGSBP9mwW/
 LDNiUDii9OT3u1eO6Tokt7iXnEHL2WxvySoO27PjXut78ZeLyo/27A6Epg0CDDwEBaMVeicAheN
 GkbB62BC94zLM6POivHfYg2DIb+zCWweOVzLKpVbalkjZrKn7j0l+j7D0xFuPu+8yNplS9aS7Ou
 cOvTgf3KJ6naJ/w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in MPSS/Modem PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
copied from older DTS, but it grew since then.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: 1172729576fb ("arm64: dts: qcom: sm8450: Add remoteproc enablers and instances")
Cc: stable@vger.kernel.org
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 7a3bf847b0b9eae2094b0a8f48f6900a31b28ae4..6df110f3ec21dd8efe0bf5e93621b2cabb77fd17 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2907,7 +2907,7 @@ compute-cb@8 {
 
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sm8450-mpss-pas";
-			reg = <0x0 0x04080000 0x0 0x4040>;
+			reg = <0x0 0x04080000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



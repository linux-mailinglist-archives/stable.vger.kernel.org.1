Return-Path: <stable+bounces-45303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADFC8C793C
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 17:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B41AB20F85
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 15:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB32014D439;
	Thu, 16 May 2024 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wu2GE1lS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC514B97A
	for <stable@vger.kernel.org>; Thu, 16 May 2024 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872903; cv=none; b=TxPByhx3rpVb0jin9Av9qnUNoHbYQGyon6suCsC217o6eunRr2H4D4eXPzrswSZiY59VQsCmKD2gO9eWoN6+BddYaSuZ0Fk+jScYCH3Zd1Oh6PCqY0zBzCrDfcnmA1NR8ZwZarQJ9hfJvnD9UWkxtDTFE5XmmbhJmgUaGaV/tuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872903; c=relaxed/simple;
	bh=InSuLl604U89RQPunJzThhSIkiSjc2LZbihM8ltX+Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kofw+qA4L0IqJr8mjkLxiX2Gb0+Mn1Dgh4IcXwmTkbvzPLftRrXdsPFz7283vXsB7blAxnM3vPojpHZaWmRR4M1okSfwYp5hh5911oRMgcSC0OM1e3c7n4JhDM5VCQiU9+KfePjdbabetNbFYbTe14RsM+FKWRhV0v+QzDk8aVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wu2GE1lS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572669fd9f9so3685888a12.0
        for <stable@vger.kernel.org>; Thu, 16 May 2024 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715872900; x=1716477700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SaHRH+mYLcZvnEqoaCOmbmlFeAJ9hDKTr835kz6kRpI=;
        b=Wu2GE1lS0NExT8uKxt5ArrjgMbxnRfIHwaxJalAmN03znDR0Jv3RI46UMFAeFDzv8A
         ZoxrfM0+k++sQClQst1kcLkLZRqCe6MCXW87Edf7n6+FKvie+BuTjXxPj+eW6MdAlfVw
         +BUfEv01P9YF5WEh250gLg04Fr0vneVaEt8X4l+yhLc4McwbrXIt44g8nEGQryweMv3m
         XaAIZpTPbYvTSpoVYd3D0IW9FLWuyydOEaxzHe+3SSrrNHRJfI1ED6jXIMgrI8aPu1XU
         IGRGBZH9TKK6q8EHUva5NB9MLvNCRcem1bpDnm2k3CUWNyK2gTYnxINGAYstk3E6Z5zy
         /EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872900; x=1716477700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaHRH+mYLcZvnEqoaCOmbmlFeAJ9hDKTr835kz6kRpI=;
        b=SXMW8ekxmayGA72nXwxzgxeKWdC5mW/qhyBR6meUq4hlp5lANHW3x5W5PTR0zWSYAn
         dLDMP5CDsXJA5ctWbydQJP47vFnZqTXTR0ilPJUDDD9Btm3iA7rWp42Mw0olwULz1nCZ
         3yEWPM+5FK00eyBawEMACL6MsT4Wp2ffKmvG755g/ny6gpvi9vyyp9BjpzJSlOEYXMxZ
         tUvekGFgXO5bTyQay2XypQiH5zKd48jjHVq8f4mSUgBcJ/12kTZYRAAPwhzsx4FfEeYq
         X00CFolLBRUaUe7meIsU2vWwuUduofb/+fXIpc1LjC1HDNMXZTJXKY8HtjpndBUs3xJk
         COqg==
X-Gm-Message-State: AOJu0YxuGSdPT+dW1F6pyAB6jwBig0qZjuD3eLLTBd8YSmbW9A2+T3QV
	cUF9rRQEtP/bYCWR/Jl7HtcsYP2KrsTvDVePvqp/X0OrsDkjN8/E+1U7mQOiB7masOKD8g53nR0
	fd1Y=
X-Google-Smtp-Source: AGHT+IGyS3tFi38rfpt7SHPfYJVr8YnCDDrBAJUgEbq8J3Hk1n0bx1UegnpKYmvY8t4uv6WjIovc8w==
X-Received: by 2002:a50:d653:0:b0:572:7d75:a715 with SMTP id 4fb4d7f45d1cf-5734d6b4120mr12519162a12.28.1715872900061;
        Thu, 16 May 2024 08:21:40 -0700 (PDT)
Received: from zoltan.localdomain ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bfe2dd1sm10621482a12.58.2024.05.16.08.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:21:39 -0700 (PDT)
From: Alex Elder <elder@linaro.org>
To: stable@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Gross <agross@kernel.org>,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 5.4.x] arm64: dts: qcom: Fix 'interrupt-map' parent address cells
Date: Thu, 16 May 2024 10:21:36 -0500
Message-Id: <20240516152136.276884-1-elder@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Herring <robh@kernel.org>

commit 0ac10b291bee84b00bf9fb2afda444e77e7f88f4 upstream.

The 'interrupt-map' in several QCom SoCs is malformed. The '#address-cells'
size of the parent interrupt controller (the GIC) is not accounted for.

Cc: <stable@vger.kernel.org>		# v5.4
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20210928192210.1842377-1-robh@kernel.org
Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 9cb7163c5714c..5c653ab907463 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -872,10 +872,10 @@
 			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map =	<0 0 0 1 &intc 0 135 IRQ_TYPE_LEVEL_HIGH>,
-					<0 0 0 2 &intc 0 136 IRQ_TYPE_LEVEL_HIGH>,
-					<0 0 0 3 &intc 0 138 IRQ_TYPE_LEVEL_HIGH>,
-					<0 0 0 4 &intc 0 139 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map =	<0 0 0 1 &intc 0 0 135 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 136 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 138 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 139 IRQ_TYPE_LEVEL_HIGH>;
 
 			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
 				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
-- 
2.39.2



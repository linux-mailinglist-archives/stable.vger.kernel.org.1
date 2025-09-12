Return-Path: <stable+bounces-179324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9853CB54374
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 09:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226D93ADE29
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 07:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E7B29992E;
	Fri, 12 Sep 2025 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRX327If"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1093C270EC3
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757660717; cv=none; b=n1FYZFRJetl3ScAiJMlbCLXpvo/O6sQZsuIB/EBPntrL3ZM3js/xBvguHgGlT76lIwD5Xr/FPjh2pJdJT8WG0c77satxoLYkdKyJH/T37Ci7q3imwXJYEKTgXiQQQARV04ySk5/Sex+QqQM6J1m39NysAgoKNLGkYz4Fy027eaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757660717; c=relaxed/simple;
	bh=572DFU9jfopt+pPd0GVuZvfPHZV7rjdAPyzKWts76qY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZRbwUQzc990IQpDATLphGntCDCgxN2618JQZ8oyvZLYniZYyhRAlNsI0CjrfAisA7eeylNuxwF+zaSwyBxwXF9pbmzgMlaiFnQAkp9LAGx7sPVvucrDHPYuRTPqjHuQj7Hz5Zp9+udvUalzBPXyDBpa/OQeztwVZjny4ek2fWS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRX327If; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7722bcb989aso1130162b3a.1
        for <stable@vger.kernel.org>; Fri, 12 Sep 2025 00:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757660714; x=1758265514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrCZ/4lfkyLu6sbBLzuKM2Dvm81cgTRaZ1Y0I7OWBd8=;
        b=IRX327If0r7Wk7XC0bdTEumhTg7YG8Y++fjWyt96DaPU+8Eo7uWd+pTLDmANcjvv8s
         D1Q/M9mE3yQliaLg+7qOIkTmGbYiDt5MkMh8T5lF80ppl6qO4Is8OnKHw5CUSIwfECEw
         1YmOB+RFxElIn+f6YH/0XWXJ9zs1eQYDd5vhG3fLGNRSM54M0iK6DMgksfpj+72jSLJf
         MhYDvMKunrVLdd0yEwctXrhgO7c+kV7Pox7KvQHiGzcb76w+Nk6krXffsePXIzYI3UfT
         Fc5cI4BNiQRg/40wP7bRKCuzUolMbN7wP3NKTgaRz/vca33DGeyTiD2N5z63aaX8YYR3
         DIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757660714; x=1758265514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrCZ/4lfkyLu6sbBLzuKM2Dvm81cgTRaZ1Y0I7OWBd8=;
        b=m6MSMkyLZnJCBKMLQsHQejUtisnhmYknU2/MvbVsPG/VeLTsihc4RN1TJxqKaaDyCM
         /UyWgdYIc1f9Gv/xnQnBeahsHDw1Pu7erVJsQWH3+rfDQdHYsq/9GM70XQm/CPqQDhZl
         8e3JWeDFgUO9RW6RmzdHG+hvbfXY2beFyyD4dDqeHPOkK9/FQ+MiD1ZPpBD4Dwzxw+5f
         GFifRPUFxC0nbVEnDk2ULYjgTKHNzSQZfZW7HFPTKllXGsHn9FhrrJa3yJ7lWmv+wPoA
         VMsc2kB3pMCxXck6FzWlZt8pTuLaQeY2TRd1qA6u57AijMnjxiv4fx+/2MASSOAmuGMu
         iIpg==
X-Forwarded-Encrypted: i=1; AJvYcCWjOAIE3VJAXVFYPgbzmwcJ4XnHoqtFqYgdKLkYige1crmUEMRpKPZiRx7bl7rQ8Nqnods+D9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf5cXj8JDrumQ+uhwWSgI3Yc3HNQvWvU//NKaFxWl8a+Fu+ejZ
	aSzekBMDbQbjmebxyAM8wmEtPvP2Spu0fXNQmdkOUqxAL18NO/Aijh9tF9yR8/fI
X-Gm-Gg: ASbGncuValNwq64ye57V1KJjTTen0KSs87372Ntbe3XB+8gbZJBxJpgBzbj6U9+/r1J
	vsR6V0RuBUAZbaOMlIoe7QG9VwPQUY6a9uWZbYuUJ3ilskbhb8+10LpV5vUfT01MkaFQf0dbIzE
	fFZGYMMqbgNDs826vwW3+gvn3Fbhw4AYszGRSi/8Y//cdrTSTPZ5NsFB0qQ6LyevZM1v036oTYq
	f9AjmjvBfpy6sxBVlohF4PH+aXImnmkjQPGV1Pn+5pmyRlNSgAHtUeCNzN5K45qwPw1GPVFUcjk
	lpBhVpJRuFVqguHe1Pog9X7TQ6ZGawbtOpCWYhhVQ45gpoPqzVDFUsd7tOw9Q9QYYFNrtD1swJ7
	mb6N+93XICcO08w8qxFaOmOvpq4J3id0pqCn9yKvzz+RmaEH19jbKFxedSLz20FaIvQ==
X-Google-Smtp-Source: AGHT+IEWEFpoL5MC+MBgCE4p1Z3kBFGvdcN5KhhxsYEkiO1s5V7LSIfR5KPmte2LyppCMRUnCfAeYg==
X-Received: by 2002:a05:6a21:33a0:b0:24d:b11b:e908 with SMTP id adf61e73a8af0-2602a3a4a37mr2268661637.11.1757660714251;
        Fri, 12 Sep 2025 00:05:14 -0700 (PDT)
Received: from af623941f5e9 (ai200241.d.west.v6connect.net. [138.64.200.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a47d7fsm4412620b3a.31.2025.09.12.00.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 00:05:13 -0700 (PDT)
From: Tamura Dai <kirinode0@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tamura Dai <kirinode0@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sdm845-shift-axolotl: Fix typo of compatible
Date: Fri, 12 Sep 2025 07:01:46 +0000
Message-Id: <20250912070145.54312-1-kirinode0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <38c24430-16ce-4d9a-8641-3340cc9364cf@kernel.org>
References: <38c24430-16ce-4d9a-8641-3340cc9364cf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bug is a typo in the compatible string for the touchscreen node.
According to Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml,
the correct compatible is "focaltech,ft8719", but the device tree used
"focaltech,fts8719".

Fixes: 45882459159de (arm64: dts: qcom: sdm845: add device tree for SHIFT6mq)
Cc: stable@vger.kernel.org
Signed-off-by: Tamura Dai <kirinode0@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 2cf7b5e1243c..a0b288d6162f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -432,7 +432,7 @@ &i2c5 {
 	status = "okay";
 
 	touchscreen@38 {
-		compatible = "focaltech,fts8719";
+		compatible = "focaltech,ft8719";
 		reg = <0x38>;
 		wakeup-source;
 		interrupt-parent = <&tlmm>;
-- 
2.34.1



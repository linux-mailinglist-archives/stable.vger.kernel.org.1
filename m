Return-Path: <stable+bounces-106614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170E09FEF71
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 14:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D473A2D9E
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 13:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940519DF7D;
	Tue, 31 Dec 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="go74SY6m"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1577719D8A3
	for <stable@vger.kernel.org>; Tue, 31 Dec 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735650161; cv=none; b=PTbvtqLmP6i7JyPC+DVH83zlC2O3mN2zI0BG8qvHBzSDSw8sEG3ZDxGcW//RjE0bbdVacMtoxL3Wuc/AAYPm0ynaEa3rmOodoaXaFp+81ANRfBM1f8ux3DAhhE8gaRl91+tmbvXBpaNSFWLUr/4Y07TaoiuCq4XsizKqxHRWlqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735650161; c=relaxed/simple;
	bh=hVyAuooOzyUbD/jnmspiTE8wCtobigUKFEsbNH4RJ0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fMbQGPo34pie+fdbpH2cnY9IA+aA4HZ8fbFfFsqlFSHUDfuA+sDuM6Fc0U5vOByhwLCzpT1EqDdaPTuXLSSUchzciaTM0LDwDAPe9hKTOfwM9NpBNQNmOtJUmr0hJjkLVDkTAUwZ/IW2kvSLxLieY9wB01DnnNwLI/t9iRk+PHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=go74SY6m; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2163b0c09afso130131835ad.0
        for <stable@vger.kernel.org>; Tue, 31 Dec 2024 05:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735650159; x=1736254959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvF+49X2gFMGE7dCbt+zol5pHVl//CcUiNX288CxZPg=;
        b=go74SY6mxOHBBTbqFyqzoW0alX3HxVyAkcpc3Fs0ci46EQ64hNCEhrLHEw9wsUzdjf
         StkcX3FZ9S99frVeuOvb5LDFSFPlOR+IX4Gv8ugW6eJEuDH9Bay4d8it+lDgSOY4eWRe
         anM4re/Uni/dwtuyI6LuP8Oku9cxynyn6CqORQpKYgwTEdnDb4GFWyn60+6XV75Gri2J
         zK+o7jwrkDguy3iJhpmwTeosUmscCf7uoP4p+UBr66jaKCaj1DpfBP9CkccC1xEXFUDz
         i1uK96UxqiyiEhwDLv3OqXj04+SBZc+ZKZtg7Wl525pN3yBOExMI8x/kSloYOKssFUl2
         mKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735650159; x=1736254959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvF+49X2gFMGE7dCbt+zol5pHVl//CcUiNX288CxZPg=;
        b=TNgNtnmJX7lh9k2ryldrjpmpFQEwZpaAPV/sSkUwV57YZbT2u6Il9UwfX6A9ePf/Wo
         cG/OPXqREh4uc1g5bd+BTeLXGmZHXjm12dmVHGmUbUhldBJtcQ/EcxV3rWEoC2POi+/4
         qwVKHv8KEXPg1SBV9a7iR6GBKJoRa4nVLcSCzAx9ABU4CG4yeJY+RPZrLCLf2W3y6ovn
         hfFORIINO3+B/Q50m7ilzliBC19bL9tRGv4s3u3rIElDLrUBRn82vj/Ptc9zV2HYELaJ
         T5VtIahl279+bkeAE3tDHugOH/UF7Bh8Ecew2MbmvUosVdr8h8fo4xH5YtHOptSUGbdA
         VXAw==
X-Forwarded-Encrypted: i=1; AJvYcCVFEK/hM4bnP7JLPvtY17cptlauJ96QwpclD3GL/mZyBzAx8X6ISO51ezUqWwYRZhDmVQscgow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAl44qPBPY4/MIdv5iW2wlCG2FHFOe0V+ODfhtv69gFfqOCrzn
	yWwMdCclzBe8RufqVV+fYdo+wu6zza9vzViONys38JWGkYEN2D1VU2vPMayrdg==
X-Gm-Gg: ASbGncscHsKWgMpNNa8giH/4tumWJl8R+4cmjIYcn2UBkIeqFYTPS4B8mTx4M2EneNf
	GDuQtfjSRN7HXq1IpaeL0vMRsWINg/HWo8gSHEAwFSqJUCQ0tFOVjsn/lnyWhoB4gK66W6XhUCI
	A7KOADw3N5sTKfdGLFwUeSFJCkMRJsy91goAKeF5wDGuRBbO+7ePM8IIaQTufGoeNZMhGTI0JB9
	SeYbB8F35FqiuvoCI8x1Ipd1XLiA5AtDqGxa1BUMiIgvQywswKtWEpeRkwLB1UM3zMBTyoUF4U1
	X1tY87Hc4Ic=
X-Google-Smtp-Source: AGHT+IEMULsfFORB7W9l9G4XPcBHlz6cU9L2NX3m3xplk+5DtOBI1D2wFJ5g7TgfuAIcWSgnGgDZdA==
X-Received: by 2002:a17:903:2286:b0:215:cbbf:8926 with SMTP id d9443c01a7336-219e6f10978mr531200865ad.35.1735650159283;
        Tue, 31 Dec 2024 05:02:39 -0800 (PST)
Received: from localhost.localdomain ([117.193.213.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d945csm194514275ad.117.2024.12.31.05.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 05:02:38 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	andersson@kernel.org,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH 1/2] arm64: dts: qcom: sa8775p: Fix the size of 'addr_space' regions
Date: Tue, 31 Dec 2024 18:32:23 +0530
Message-Id: <20241231130224.38206-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241231130224.38206-1-manivannan.sadhasivam@linaro.org>
References: <20241231130224.38206-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For both the controller instances, size of the 'addr_space' region should
be 0x1fe00000 as per the hardware memory layout.

Otherwise, endpoint drivers cannot request even reasonable BAR size of 1MB.

Cc: stable@vger.kernel.org # 6.11
Fixes: c5f5de8434ec ("arm64: dts: qcom: sa8775p: Add ep pcie1 controller node")
Fixes: 1924f5518224 ("arm64: dts: qcom: sa8775p: Add ep pcie0 controller node")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 9f315a51a7c1..368bcf7c9802 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -6092,7 +6092,7 @@ pcie0_ep: pcie-ep@1c00000 {
 		      <0x0 0x40000000 0x0 0xf20>,
 		      <0x0 0x40000f20 0x0 0xa8>,
 		      <0x0 0x40001000 0x0 0x4000>,
-		      <0x0 0x40200000 0x0 0x100000>,
+		      <0x0 0x40200000 0x0 0x1fe00000>,
 		      <0x0 0x01c03000 0x0 0x1000>,
 		      <0x0 0x40005000 0x0 0x2000>;
 		reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
@@ -6250,7 +6250,7 @@ pcie1_ep: pcie-ep@1c10000 {
 		      <0x0 0x60000000 0x0 0xf20>,
 		      <0x0 0x60000f20 0x0 0xa8>,
 		      <0x0 0x60001000 0x0 0x4000>,
-		      <0x0 0x60200000 0x0 0x100000>,
+		      <0x0 0x60200000 0x0 0x1fe00000>,
 		      <0x0 0x01c13000 0x0 0x1000>,
 		      <0x0 0x60005000 0x0 0x2000>;
 		reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
-- 
2.25.1



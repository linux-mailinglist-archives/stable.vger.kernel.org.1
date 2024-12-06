Return-Path: <stable+bounces-99556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 433169E7239
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5DC188381E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A0F148FE6;
	Fri,  6 Dec 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jXLMMDwG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB1353A7;
	Fri,  6 Dec 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497582; cv=none; b=s2ugVAj+/Q0q00EuE6rk/8W2O3y9lDv10xfmn2nYq5H6/0YN5SGnugs3ZEsW2QYV1YZWwb6wDGccBboyID/um6e3xigQ0xCFNuuaXfG5P5Ps1VKPLaXmpRR+EyAFbzzw44ikTRXHER5M2nP9nUOEr7aVzoz8Ll89bvEyara1loE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497582; c=relaxed/simple;
	bh=pzTMa3VClSINB+r0QMskpf+MiIdClYfUC9RN2UGwriQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcMxuBKG9qCBoRUFm6SwiKAxSrWQZa8IEWbMIZdioLWK2MvDa0lOANSmJe8x0acMd5Bmq79kPSh4BiIJIfOTZ+xCnkVDi/EP6rphQ3hWWt0EM1ga3xhAv65ir8P3ba6ptczokHpx2jGErtzgVOeiurTtcjBLq2gjQl14KQFrwNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jXLMMDwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33523C4CED1;
	Fri,  6 Dec 2024 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497580;
	bh=pzTMa3VClSINB+r0QMskpf+MiIdClYfUC9RN2UGwriQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jXLMMDwGAbEyj5DCJd9V7wM/F8wj8OhsUqZa5i/02YLKktJ/+2Pz71lPT3aAsRdEr
	 epdaVNP7b99+NowaBzGUXpftfkzBJIX3sb13/GIznu16iBTku8L3gJP/4oznZ8oaam
	 zlcf4FIPAi5wB0HRJq0AspwjC7iubR7moHd9UPzE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 331/676] arm64: dts: qcom: sc8180x: Add a SoC-specific compatible to cpufreq-hw
Date: Fri,  6 Dec 2024 15:32:30 +0100
Message-ID: <20241206143706.275800265@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

[ Upstream commit 5df30684415d5a902f23862ab5bbed2a2df7fbf1 ]

Comply with bindings guidelines and get rid of errors such as:

cpufreq@18323000: compatible: 'oneOf' conditional failed, one must be fixed:
        ['qcom,cpufreq-hw'] is too short

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 92b85de7706d3..dfeeada91b780 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3618,7 +3618,7 @@ lmh@18358800 {
 		};
 
 		cpufreq_hw: cpufreq@18323000 {
-			compatible = "qcom,cpufreq-hw";
+			compatible = "qcom,sc8180x-cpufreq-hw", "qcom,cpufreq-hw";
 			reg = <0 0x18323000 0 0x1400>, <0 0x18325800 0 0x1400>;
 			reg-names = "freq-domain0", "freq-domain1";
 
-- 
2.43.0





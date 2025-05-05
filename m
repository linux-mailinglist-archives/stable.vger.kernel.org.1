Return-Path: <stable+bounces-140405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AC4AAA863
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1351884781
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F351929B8EB;
	Mon,  5 May 2025 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPo8pfoh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE19B29B8E6;
	Mon,  5 May 2025 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484788; cv=none; b=EmsgGtmyhMG81NfKKlz/UXvtu0TsKEL94sCdBMp7Wx/OvpRnMS2DLuyVzeGedyBG78xWb6aPE/XEUkgG3TIq/CkU3ucLuUbSD8tttKKiI8PdQOWhH6BEIMVw0duT4/KqN9Vyp4i3Do+PZ8HjdnvxdhtNrhyl4JNzLAnTONZW1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484788; c=relaxed/simple;
	bh=7rCN9i0L8S4jhJmbJNiRczApZlbspus7Wsbm//C51yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GIScilVoRS0ojsUQgzS7yD4K2dL3pont6E6sUCoYhuKnYUhXi+oz1bNfE9OaBTeR7PNecW7AYRaeahjtMlmdC0p79xO6QMGqeA+50mzqP6vkRkHEXgvOCVLmt7/VJVe3yUHGYrzuhGz15nC/cjg+L2uVFxdygUluETgTF/FssEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPo8pfoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE08FC4CEE4;
	Mon,  5 May 2025 22:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484788;
	bh=7rCN9i0L8S4jhJmbJNiRczApZlbspus7Wsbm//C51yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pPo8pfohw6koU8xidAU1vYSqxoqpU46Q9fUtURLcgTAIRG2bkDDsdG+IEFQYCfLKJ
	 g48WGIqCvmj/I7Hfvs3dJ3nUk73B9J3DzWZ0k/rDZVyFAYiWwoOUc73FnKuaDzb1hY
	 17ZxFyx+ex5dTMLhr2l/nr4YX1qdLVg+uHjLesnwcZzsdxPgrk2m6desDWOKmbSqKw
	 UuzJMs6mytQCXdATKeknOagvzFIh9pLRMPEnwXrc5Wl4zNuk46beV2B124j/nh0TF6
	 HzWMwS9Enu2qLRe2dbcWO4ZdGC9/QZq87xHgWuwHs1HWK9muO0jOFKSREcJOt1nRl8
	 ZO/Jx8uRVggMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jinqian Yang <yangjinqian1@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	will@kernel.org,
	mark.rutland@arm.com,
	oliver.upton@linux.dev,
	shameerali.kolothum.thodi@huawei.com,
	dianders@chromium.org,
	maz@kernel.org,
	quic_tsoni@quicinc.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 014/486] arm64: Add support for HIP09 Spectre-BHB mitigation
Date: Mon,  5 May 2025 18:31:30 -0400
Message-Id: <20250505223922.2682012-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Jinqian Yang <yangjinqian1@huawei.com>

[ Upstream commit e18c09b204e81702ea63b9f1a81ab003b72e3174 ]

The HIP09 processor is vulnerable to the Spectre-BHB (Branch History
Buffer) attack, which can be exploited to leak information through
branch prediction side channels. This commit adds the MIDR of HIP09
to the list for software mitigation.

Signed-off-by: Jinqian Yang <yangjinqian1@huawei.com>
Link: https://lore.kernel.org/r/20250325141900.2057314-1-yangjinqian1@huawei.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 arch/arm64/kernel/proton-pack.c  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 2a4e686e633c6..3443e64adb4c3 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -131,6 +131,7 @@
 #define FUJITSU_CPU_PART_A64FX		0x001
 
 #define HISI_CPU_PART_TSV110		0xD01
+#define HISI_CPU_PART_HIP09			0xD02
 
 #define APPLE_CPU_PART_M1_ICESTORM	0x022
 #define APPLE_CPU_PART_M1_FIRESTORM	0x023
@@ -206,6 +207,7 @@
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
+#define MIDR_HISI_HIP09 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP09)
 #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
 #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
 #define MIDR_APPLE_M1_ICESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_PRO)
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 0f51fd10b4b06..aaf6578c39ac4 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -901,6 +901,7 @@ static u8 spectre_bhb_loop_affected(void)
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
 		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
+		MIDR_ALL_VERSIONS(MIDR_HISI_HIP09),
 		{},
 	};
 	static const struct midr_range spectre_bhb_k11_list[] = {
-- 
2.39.5



Return-Path: <stable+bounces-172837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 925C8B33EB2
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA8A1A84062
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 12:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8771426A0F8;
	Mon, 25 Aug 2025 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAUdhG+o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473EF1F4625
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123501; cv=none; b=U2NLQ0u72sJdaIAtc0C0RnSzMnwbL15IzyX7cD0UQ7MqfC9/MhPJJN4egWwO+lTMn0X3q4jxKl83b75z1QPLIyztzLrlQZfEHkRAP0BPDvHN0/e9foVINZZ59zjP7cxMEpjcVC9Pm3FoZ4KR9m7htXFeeG5Pw2lSboqfRAhpc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123501; c=relaxed/simple;
	bh=1wvV5GLERR8OQU5GfoQe9PtMeI++PBKgemESU9nHvNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miOdEO2mVENP/J597xWAd7x8/Syitrx5/KJm1vj1/LmpNtLtiJffcpSpdMsceIustSGrT584GwH3lxvrp6e9j15A/hYsnn70H0s3gKPUZ/wNfzueeDFszTbGECQJf90/xJgtRvzSk8T/V8Mao/c0oJbjpBJgtMoCvKb8W3ERPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAUdhG+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212DFC4CEED;
	Mon, 25 Aug 2025 12:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756123500;
	bh=1wvV5GLERR8OQU5GfoQe9PtMeI++PBKgemESU9nHvNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAUdhG+oRxzdhB1mW3PW6njf0VwAxFiix/D5vG3sBftE6zPpjQdBZVnLOdJggAToc
	 At7beI0kOIorNGCM2ZOmS5gbcxj4qZoR3o8kqK19Ub0nZFbo9aIcOedraqzE2lkuE9
	 KKkCittAr8U+3NNVq4A7QrO/HFBuuG8gx264zs2V0oBqL+JuI9AxVVlMqdZLuuf0VE
	 REHatMBP32wqtZfg8+woJTX4n6XK8y1tXC8T8zSSPctDw9SuJMhQFO9pS5lhaGlW+s
	 ZqcKJIk/03t/7jbdySDT3KXYYv2uhmqkyuHuvqE1gnU+jEeAfs2qYcAYW3Mx98x36H
	 JIOCcZnnrcMuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tianxiang Peng <txpeng@tencent.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Hui Li <caelli@tencent.com>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init helper
Date: Mon, 25 Aug 2025 08:04:58 -0400
Message-ID: <20250825120458.2980932-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082517-crazily-renewed-62e6@gregkh>
References: <2025082517-crazily-renewed-62e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianxiang Peng <txpeng@tencent.com>

[ Upstream commit d8df126349dad855cdfedd6bbf315bad2e901c2f ]

Since

  923f3a2b48bd ("x86/resctrl: Query LLC monitoring properties once during boot")

resctrl_cpu_detect() has been moved from common CPU initialization code to
the vendor-specific BSP init helper, while Hygon didn't put that call in their
code.

This triggers a division by zero fault during early booting stage on our
machines with X86_FEATURE_CQM* supported, where get_rdt_mon_resources() tries
to calculate mon_l3_config with uninitialized boot_cpu_data.x86_cache_occ_scale.

Add the missing resctrl_cpu_detect() in the Hygon BSP init helper.

  [ bp: Massage commit message. ]

Fixes: 923f3a2b48bd ("x86/resctrl: Query LLC monitoring properties once during boot")
Signed-off-by: Tianxiang Peng <txpeng@tencent.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Hui Li <caelli@tencent.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/20250623093153.3016937-1-txpeng@tencent.com
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/hygon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 8a80d5343f3a..4f69e85bc255 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -14,6 +14,7 @@
 #include <asm/cacheinfo.h>
 #include <asm/spec-ctrl.h>
 #include <asm/delay.h>
+#include <asm/resctrl.h>
 
 #include "cpu.h"
 
@@ -239,6 +240,8 @@ static void bsp_init_hygon(struct cpuinfo_x86 *c)
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << 10;
 		}
 	}
+
+	resctrl_cpu_detect(c);
 }
 
 static void early_init_hygon(struct cpuinfo_x86 *c)
-- 
2.50.1



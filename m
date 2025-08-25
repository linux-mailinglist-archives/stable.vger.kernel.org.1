Return-Path: <stable+bounces-172834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A342B33E82
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 13:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACFF1A81555
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 11:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BF72D543A;
	Mon, 25 Aug 2025 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBA+TBmD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825342C15B6
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122984; cv=none; b=mmygI9Ygh+5cM3e4yQN+RSlbCDHTaJNGw/dXkKgTYHrXJ5Kl9pe3d2hUg+TRv3bFEhYSkrrVQ1Sz6V8+MMNPPj3kas05YEdCg6n7AGltu9laMe1RD+YQOZk6/P/pqijNwDXn606zDtSC7EnYC1kKWpdBGcEhg3WGGUfTc7HjB0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122984; c=relaxed/simple;
	bh=1wvV5GLERR8OQU5GfoQe9PtMeI++PBKgemESU9nHvNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFMVQojnxfaqRwKWFjm3plN01Vt9LeeHFKU+z7sWFpoCQYEOG6HRZIUD9pZ7+NV+QErXxBujHKxAZ+vTYfwuDMS1avDY05vnSGavoNGcdeKQN8Nwn4UGrUOPDZtGOM04YIrjK3sJvcT4vRvevhhSxuiS4DkF1lupZOyq4snaVMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBA+TBmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E7CC4CEED;
	Mon, 25 Aug 2025 11:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756122984;
	bh=1wvV5GLERR8OQU5GfoQe9PtMeI++PBKgemESU9nHvNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OBA+TBmD2nhLY6mRZ//ERy0oOJ2HSJtI+/UL5iKb+uFnRAL+ABuu3lhDFazevCxzY
	 iLpIFf3qPUv208L6ow8jgdZd4AM4KjFGCCKKaKZoHuTsrDNq/7qnfYyc4CoXPRhjWp
	 Ip33emrajGe2774fjtRZ9xVxlUfAkxJigq0PFMZjZe0ch119DLN83k2dT5Gv6o8yis
	 P/yVfO1Pv6uMYVXnA9Poptt88dIqIgMpdGx0yhiXw72cR+pzdkF8hw5Cupq4sdfAiP
	 lduOBWdhNUGH8gR4pOLLEALEPMYlCTH82LtxeuRPSPdkHuABTtLc5R8FnMPE5+mfnq
	 kV6hgV63xD9Cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tianxiang Peng <txpeng@tencent.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Hui Li <caelli@tencent.com>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init helper
Date: Mon, 25 Aug 2025 07:56:22 -0400
Message-ID: <20250825115622.2973996-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082517-cramp-prissy-ebff@gregkh>
References: <2025082517-cramp-prissy-ebff@gregkh>
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



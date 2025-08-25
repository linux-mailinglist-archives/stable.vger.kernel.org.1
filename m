Return-Path: <stable+bounces-172827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034E8B33E55
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 13:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A0C27A3489
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 11:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E331B25FA34;
	Mon, 25 Aug 2025 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isYHgTB6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ADC1EA7CB
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122523; cv=none; b=OzUrt9q4oyDhjd5xKS4oIRMEi8lRxvuimK/fSHcN2jarbHhPpEk9HJluJYsj+uDCEGH1Ng7tPwrLzZDv3g95m+RMifdTVUL+aihvo08fo/EUflOrE8D60YZ9xXBH9KUwn7aNv3AwBlRBwD2pfhMthlxeFiFG3a09IFMGXj6H0+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122523; c=relaxed/simple;
	bh=OwPP6r6Uaes+GitdOq3V82sTvWngQ8oYHAmnwYUzJiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBe1Mii3kxkP1Ma6f0nU9XdFE5nMAFjnby+0hEO+VygchQYr8Urnfmnv85M2st0fOEMkKEnkRFqzsxmDiLaxkywsFLgJDaEExIE2BiUy294h+N3jhilE/W1lpx/N/ECgMrl5n4Uhv6+iw72t2tn+IY8bIAlQQVz2YsiLXxwmPmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isYHgTB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0642C4CEED;
	Mon, 25 Aug 2025 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756122523;
	bh=OwPP6r6Uaes+GitdOq3V82sTvWngQ8oYHAmnwYUzJiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=isYHgTB6FJdx/fBJV7UaxWNiHB/ITbBrlkrbxtTi1HWq3rGFjl2FxuZqcosVgFbq5
	 wqJB+CScEfYAXElE/Y48FSOYlvVthbybMGxtjc3uV+ZzmYmGzwWQ6zMYDZlN7aho5U
	 MNmLCUA++TcKqdT4EJWdxZtjHFKRLj5obOlw4iJM3iRhEUdF9mlkplKgjZVnJzC3OI
	 UjFbHRYNCRRu/zBqWsvaPqCuZY3UdBBpP0QzgvvbQBbd58WV1/UtISrq+TD6K45r9Y
	 TEQCClaSHpn0N2v28J92WeiP8qLMGvt+vuyZVbb8+3dESOSNgnBjHeCJ66rGYdiHqE
	 AvtmXC8o1Krkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tianxiang Peng <txpeng@tencent.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Hui Li <caelli@tencent.com>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init helper
Date: Mon, 25 Aug 2025 07:48:40 -0400
Message-ID: <20250825114840.2971197-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082516-wikipedia-entitle-8772@gregkh>
References: <2025082516-wikipedia-entitle-8772@gregkh>
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
index 6e738759779e..5c594781b463 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -15,6 +15,7 @@
 #include <asm/cacheinfo.h>
 #include <asm/spec-ctrl.h>
 #include <asm/delay.h>
+#include <asm/resctrl.h>
 
 #include "cpu.h"
 
@@ -240,6 +241,8 @@ static void bsp_init_hygon(struct cpuinfo_x86 *c)
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << 10;
 		}
 	}
+
+	resctrl_cpu_detect(c);
 }
 
 static void early_init_hygon(struct cpuinfo_x86 *c)
-- 
2.50.1



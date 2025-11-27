Return-Path: <stable+bounces-197455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 594A7C8F169
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FFB2345ABD
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2972E334690;
	Thu, 27 Nov 2025 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fg7ZpHtR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5A632AAC4;
	Thu, 27 Nov 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255868; cv=none; b=j8SDGg62q1MpVvKS3gIsF0uIkSa4evgR1fUPmqt4/6CoKJ0XJSTZQgb+mfSkF+5H4DFoefOt2CtIsTExw8IwPutoN+X3TJGlFpQ1Czk7S95+bS+dGMFLLgJKcsF6PKkJ49b/deGyVQxVSghZJTrPHUoXvhHGHcb0nwwmtAN8fyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255868; c=relaxed/simple;
	bh=JXSsWR+3xK5LkIEQllucEzZBK7Dut9MO9SHdqOk1Hb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4wCXgJir4MyUJY5RehmhcD6X8ZOpIXOGAnStIMS4I3SHPtkSPuprzPBnaWn48wiZUq6RC8daynKmZ0pdJMXYjH5OrEqnUhc/XO/hLgvHK/N8nApldnX8w885yL4FxdsW23Vw6DiTqlwQ4RtySuhyaekap/r+sg9TxvLtNbrlXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fg7ZpHtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380F0C4CEF8;
	Thu, 27 Nov 2025 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764255868;
	bh=JXSsWR+3xK5LkIEQllucEzZBK7Dut9MO9SHdqOk1Hb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fg7ZpHtRRCXUyRiMOUHrFOlbmdRadPwFfjnK7GUvXqi8Iy8nN2N+kO7ZKF3boOGqd
	 D6tovF40x+PBx35a2FEd6f5uGHTUUgOSavdh2xrsbotZS1+ERcjimbJ/vPQoAnlF/G
	 3Np2j4Irge9z2Nd3YgPkzCFKhiEmnfSDS4PIJU98=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	dongsheng <dongsheng.x.zhang@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 143/175] perf/x86/intel/uncore: Add uncore PMU support for Wildcat Lake
Date: Thu, 27 Nov 2025 15:46:36 +0100
Message-ID: <20251127144048.180327706@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144042.945669935@linuxfoundation.org>
References: <20251127144042.945669935@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: dongsheng <dongsheng.x.zhang@intel.com>

[ Upstream commit f4c12e5cefc8ec2eda93bc17ea734407228449ab ]

WildcatLake (WCL) is a variant of PantherLake (PTL) and shares the same
uncore PMU features with PTL. Therefore, directly reuse Pantherlake's
uncore PMU enabling code for WildcatLake.

Signed-off-by: dongsheng <dongsheng.x.zhang@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20250908061639.938105-2-dapeng1.mi@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/uncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a762f7f5b1616..d6c945cc5d07c 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1895,6 +1895,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_uncore_init),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&ptl_uncore_init),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,	&ptl_uncore_init),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&gnr_uncore_init),
-- 
2.51.0





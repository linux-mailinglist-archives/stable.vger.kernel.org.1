Return-Path: <stable+bounces-120109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77C2A4C74A
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E53165EE2
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD8B233D87;
	Mon,  3 Mar 2025 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXPIJtcp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70C23312E;
	Mon,  3 Mar 2025 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019418; cv=none; b=eGguEjcPLbL1iHj8encv+JyqNQrPNn5aU1NcAyVNR+XiNnRo8hZvuc8Ckt8dXTHaXALhYe2TDnVGzRkhV+qK1YB13oAOJ7Yu0VFsg2lcRRqIjQWX/GE/UPw3vJcMAqP0HtQtz72oH5lQoXdndZdW4dtLKFYNnMB8dIwyBG9p9gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019418; c=relaxed/simple;
	bh=5rWuHbscIDYEBwLBY7Q86SnsO+J0wqmT0frz3nQBX+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JkubgYUQ4YIRjkv0hjIwlEk50LsKw/NA6zBfBBbSmjWWS3lV+XRvygul7eYDP5H2AHhrk2nGTYVz3B7+m6RYapBP+OH6HxkKZQGvaGwG72qoYTrSMPQKnfJWo3+OXuFY0CdnHNE7fDGR6Mwa0QwsC4Rm9WwKP1EPwGliFbPlT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXPIJtcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0F3C4CED6;
	Mon,  3 Mar 2025 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019418;
	bh=5rWuHbscIDYEBwLBY7Q86SnsO+J0wqmT0frz3nQBX+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rXPIJtcpUst0IzOJ24BkhNfx0y/TG5AdhTsXK4clnNzbgVG23Pa0ObQexr4SNUD1/
	 WuNF0bNfpb4SSlI/wp1FdQ+UZxPhAV+AA2mq/OPtnLmX2DlC9YB1ln7L6J5fDJSn2G
	 f+rO/StHE9DV951yM6o5KDDCR+UveH61ezfe3Lof5VuATOsVC9EB4rjlWTXAeZ6Xth
	 kpFK6CPBA2GfTnzL88VuJ1eZ1g4clWTXJGZTecU4XM78DH16eKUrulmPPRsYcasMJO
	 Hd5CIMHPo9SHx5egYKcVH++5XbPoO2xEog/LMFpSvt71Oy0wgLg92fSuMWGknW/uOJ
	 gmEfUPbWl+FBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aaron Ma <aaron.ma@canonical.com>,
	Ingo Molnar <mingo@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 12/17] perf/x86/rapl: Add support for Intel Arrow Lake U
Date: Mon,  3 Mar 2025 11:29:44 -0500
Message-Id: <20250303162951.3763346-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303162951.3763346-1-sashal@kernel.org>
References: <20250303162951.3763346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.5
Content-Transfer-Encoding: 8bit

From: Aaron Ma <aaron.ma@canonical.com>

[ Upstream commit 68a9b0e313302451468c0b0eda53c383fa51a8f4 ]

Add Arrow Lake U model for RAPL:

  $ ls -1 /sys/devices/power/events/
  energy-cores
  energy-cores.scale
  energy-cores.unit
  energy-gpu
  energy-gpu.scale
  energy-gpu.unit
  energy-pkg
  energy-pkg.scale
  energy-pkg.unit
  energy-psys
  energy-psys.scale
  energy-psys.unit

The same output as ArrowLake:

  $ perf stat -a -I 1000 --per-socket -e power/energy-pkg/

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20241224145516.349028-1-aaron.ma@canonical.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a8defc813c369..7e493963d0576 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -796,6 +796,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&model_skl),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&model_skl),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&model_skl),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&model_skl),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&model_skl),
 	{},
 };
-- 
2.39.5



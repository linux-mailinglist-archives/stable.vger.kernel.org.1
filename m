Return-Path: <stable+bounces-65414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1D89480E0
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 19:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76220285889
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841E616C6B1;
	Mon,  5 Aug 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkKCpN4a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441B815F3E7;
	Mon,  5 Aug 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880610; cv=none; b=WGN6yjc45ATu0xjPhOD0S/Kq8xM4ynnzJtGSlnm+Q40hr4qbVQgLHpg1mPsKCbZcl0+5MOvc955Ii2h4s42sZJrkAhRePMr+eJ7aDbDwVmJrpzoONDM/sIsp/p+l6sEzsvOl3pPl5UvjE+N47tyuAu/kHu48tjyR6aclZsdEO9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880610; c=relaxed/simple;
	bh=Vrjm94oTk8ATB7nmQYt5c6DtOI0ZMbHC8FXbNfUW/fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvKElHpYk/zqWJ8L/qUnQDkjy2jCfUaH3xdfJ0VPYK8GIbx8gvvNmKUe9nTi5nLF3d79bP9KM7Ngy0ldS7vw56Yshtl2Fv7G9BgALb62Hzhl5VFwNRRbtbX5uGyOHixG2BRQYp3iypMR7vxqZGDq7XNERdmwuGnPDmveIv6drOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkKCpN4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A49C4AF0C;
	Mon,  5 Aug 2024 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880609;
	bh=Vrjm94oTk8ATB7nmQYt5c6DtOI0ZMbHC8FXbNfUW/fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkKCpN4aLUdy2POP22DTCzYnCTmAdXRD/s61rk+bro+I55hnjgkSvDbH5h2HwN7Gb
	 moSC7CBHeZXH5UBHlwDf5rnNvBMTgYEAfkpzVH8DP2rAOI3zMaLGGQp72YP9fhPA8S
	 m5fsVOj62V5H1Rj/lPIfi6W3DW8scGHHE6h+G/p+pjsI3zZJv0NTh0z4hWR1BI9OkM
	 99reErenVUYpmTRXbnGiZTLkJVhN3DDcnQwfPR863+NEUTvtjAG7P9nPBnzad0iJTD
	 GmxS9ByvjiZpwJqvfmX/jMSQMJAb0kCk96vQTdZd7QCwq9stz2NKA5YvsVoWM9ZkVp
	 xIjnLrtzKCiug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Perry Yuan <perry.yuan@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	nik.borisov@suse.com,
	peterz@infradead.org,
	brijesh.singh@amd.com
Subject: [PATCH AUTOSEL 6.10 09/16] x86/CPU/AMD: Add models 0x60-0x6f to the Zen5 range
Date: Mon,  5 Aug 2024 13:55:41 -0400
Message-ID: <20240805175618.3249561-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805175618.3249561-1-sashal@kernel.org>
References: <20240805175618.3249561-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.3
Content-Transfer-Encoding: 8bit

From: Perry Yuan <perry.yuan@amd.com>

[ Upstream commit bf5641eccf71bcd13a849930e190563c3a19815d ]

Add some new Zen5 models for the 0x1A family.

  [ bp: Merge the 0x60 and 0x70 ranges. ]

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240729064626.24297-1-bp@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 44df3f11e7319..7b4940530b462 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -462,7 +462,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		switch (c->x86_model) {
 		case 0x00 ... 0x2f:
 		case 0x40 ... 0x4f:
-		case 0x70 ... 0x7f:
+		case 0x60 ... 0x7f:
 			setup_force_cpu_cap(X86_FEATURE_ZEN5);
 			break;
 		default:
-- 
2.43.0



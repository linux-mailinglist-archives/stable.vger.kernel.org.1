Return-Path: <stable+bounces-110500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D27A1C96A
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE69C7A1BBA
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703021DE4E9;
	Sun, 26 Jan 2025 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKLvJjHo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7551DE4DF;
	Sun, 26 Jan 2025 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903070; cv=none; b=CHBEAACo0obYEjBWpKrqOij+Eb4qg4mDdutUFYfuW2oU17wfSKeSUMdH1DRxHeVXEy8UZbvZcTRVW/YJIlMl3kTFTdjAcjMKBECQvTLlDb03Prgs+CeWamXgnbW/FiYuW0elzSw7HUvud9xbvpiK4LgUK+hnnv7d8vcdlI9aCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903070; c=relaxed/simple;
	bh=90Q6IKRSvVFWviQFauE8bW1x2ODES6fNGLbItQqDoME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZFJjus/RXDPRm9U+KC3MGBPEmZpuGVHjIPaD6GJvIXEkhXns+XLZPEhIN+jC5DyJRrULxvk56Ms+3DTmc/vZ4+0SH1jqgXPK/apNYofN/Ql3lPnUQnOs4ZR3TLTNE8aMSc7Cx8jkjzTDawqVieWMuXqjTyfV47g947ZrJbj5iGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKLvJjHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BD4C4CED3;
	Sun, 26 Jan 2025 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903070;
	bh=90Q6IKRSvVFWviQFauE8bW1x2ODES6fNGLbItQqDoME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKLvJjHoGML8uje1WMst5yYGCAka7LS2BY1WvMJZ5RUfEe559dub6pSoZ8Fd3NMjd
	 ml9CkMFXvAHV+7OngAL6/RmR/h67WrU0Tr1PLkhvTrkzAZ+ZL2gO00yt+fXNe2TPzN
	 q4UzKHpLKJoOUuzEFWio4Gg3vUVGkxxjX/V5j5XpyZoFAUBWarRYGz7Z/xdbIskuIr
	 f6x6BCtDX+S70pPAZEWt8AHcHaRRcnvjrtXvlVJHsQlonM5Z2khuYKUbHREbW49nIZ
	 K+BTUcaG84B8RjgSnZFlE1Pave22SLuAv9P6WBjmRak0fDY4g/23MOv14oNw5xtcYo
	 3422P/sW0uv6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	Shyam-sundar.S-k@amd.com,
	mario.limonciello@amd.com,
	richard.gong@amd.com
Subject: [PATCH AUTOSEL 5.10 3/3] x86/amd_nb: Restrict init function to AMD-based systems
Date: Sun, 26 Jan 2025 09:51:03 -0500
Message-Id: <20250126145103.926122-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145103.926122-1-sashal@kernel.org>
References: <20250126145103.926122-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
Content-Transfer-Encoding: 8bit

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit bee9e840609cc67d0a7d82f22a2130fb7a0a766d ]

The code implicitly operates on AMD-based systems by matching on PCI
IDs. However, the use of these IDs is going away.

Add an explicit CPU vendor check instead of relying on PCI IDs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-3-yazen.ghannam@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/amd_nb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 16cd56627574d..3dcaeb25ee301 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -536,6 +536,10 @@ static __init void fix_erratum_688(void)
 
 static __init int init_amd_nbs(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return 0;
+
 	amd_cache_northbridges();
 	amd_cache_gart();
 
-- 
2.39.5



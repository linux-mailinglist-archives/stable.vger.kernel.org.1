Return-Path: <stable+bounces-110502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D69A1C987
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261DB3AB43E
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F591DE8AD;
	Sun, 26 Jan 2025 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQjMR7J6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A5F198823;
	Sun, 26 Jan 2025 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903076; cv=none; b=gzJkeEDX7yrSU55I1bJ54h6eeVptfeWiIniQV+uoZSf8ANmUPXPHr0QDVjsSXFOXTQfIEu7sFPP8dXTC+TNZF3SjQiveUWIeJeFzN5GzoMV1V5fOhR0Wc9+I5NLiaeuf17cM3qfEc/wh2x9lwrgzf728sFH85wmurChz5qlbWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903076; c=relaxed/simple;
	bh=vR2oJBwABChecKkfz04jszgSZW71ywSg3aGjTBo99Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/a7IjQfdZCG6U4OE4YEPtlWCT9sXKwUMLy13Z9VIcYJ5KT11Z9B9oanhcrNqVUc67LxJxVMBtzvSLg5hONgm56w4kleC2BTFl+8LhHtDtoATAZ/KQ42DeTEur9f60gS3AtYaruQnT5hKeUOrxodBtqusZtBv/dBhlyBeC//DG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQjMR7J6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00008C4CED3;
	Sun, 26 Jan 2025 14:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903075;
	bh=vR2oJBwABChecKkfz04jszgSZW71ywSg3aGjTBo99Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oQjMR7J6sVuyEE/2bq6NnnfAc+A632ccharQW9QV8CaO6YGDQ59J3tU8XO3o8Z/FM
	 7aZLYOjQxbEG4qNEcNSjF36FnxTIqyzQc23akeagPj5984J8qdVPPyTjsPnJNpxefQ
	 XUWnQrQZyCYm1Vh9AUmQlhd08qbX3yDKJPmzgMFlMm/7m9kXLp8NKZlRacViue1TAZ
	 6dxEJs2boKWvFgURG9K/kooYN8kK1OuV/alkctE1B3f9FFF7leTwsYThd0SBT/aOii
	 xPeXmhBK6Y8Apqt6QUKeOj2ZsjtsUxHAEYOjOfJulJYMFg6hYaneCiWQCh7aTDfqCn
	 udL0NVOwrad1Q==
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
	richard.gong@amd.com,
	mario.limonciello@amd.com
Subject: [PATCH AUTOSEL 5.4 2/2] x86/amd_nb: Restrict init function to AMD-based systems
Date: Sun, 26 Jan 2025 09:51:10 -0500
Message-Id: <20250126145110.926175-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145110.926175-1-sashal@kernel.org>
References: <20250126145110.926175-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.289
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
index e3b5de7b95988..ead78f981345c 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -538,6 +538,10 @@ static __init void fix_erratum_688(void)
 
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



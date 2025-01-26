Return-Path: <stable+bounces-110481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13FAA1C957
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2B73A7DF9
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384971CEAD6;
	Sun, 26 Jan 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laxiStT+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88DF18B47D;
	Sun, 26 Jan 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903027; cv=none; b=tXEEZWiEfA2qovT4M147V3tNxQ74//gzhVItOwOAz7sfjdQk0t53BLnM/r/sVe9YFcR4vhO12EToBI6hLulCG65+Hn4eUtZYnXxV+m+FsdAGW7M2p7hAeVbrGlWOM3Dbd8lINIC47Nj6ERiWLvYtuXWp5e6TRMAb/2DPBhaylyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903027; c=relaxed/simple;
	bh=ivPLaVKVhK8FH75LuU5vK0pflfjwziZzLaukhS3zmEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MVc0HggKW1aAtSgi1oCAax/GnwRssGMap7B2S2yTSUJP8YSEaGO4jGQHLSe90A+zgSOTK4QAQ40Axt1bJnnJs2WsTSQR6wiNG0na35iTnM+6yx1O6JykWyMtMmfz4Mpq+F6MNVNJw/b7f9A5TWbMJjsOv43jKbQKLKiE8gZUzDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laxiStT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1711FC4CEE2;
	Sun, 26 Jan 2025 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903026;
	bh=ivPLaVKVhK8FH75LuU5vK0pflfjwziZzLaukhS3zmEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=laxiStT+ai1i6WBt0kFfrBR7z8XIxcbLZ6VdmLLPJYM5JNnfw8lZm6HmP6gYx95BZ
	 Mse+fBlv1CmdRa6SZyHFPB818sN0h2IN0Af61fepLRpAVlBbPmaAlvqoLtpXONSAQP
	 sj4lPaUAsgUtvf/oHvUN6r3JS+W8h7WcJZYX1/7eYQOh1T9UZtwlkfqJHEoiQAtqsC
	 uDu7mFGCzQZ0i4CP3wA/bFhOA2oj9eQaPguOc3tGduS80NYhD5jUiccCy9DR+NEHMn
	 iHEvoVNV5WB+c50O2wc4lSZVm2rJ2BwN3YBEkO7YLLqYyychldNj0mXdafNk+10ayd
	 p+fbh2U2fm6Lg==
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
Subject: [PATCH AUTOSEL 6.13 7/7] x86/amd_nb: Restrict init function to AMD-based systems
Date: Sun, 26 Jan 2025 09:50:10 -0500
Message-Id: <20250126145011.925720-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145011.925720-1-sashal@kernel.org>
References: <20250126145011.925720-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index 9fe9972d2071b..37b8244899d89 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -582,6 +582,10 @@ static __init void fix_erratum_688(void)
 
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



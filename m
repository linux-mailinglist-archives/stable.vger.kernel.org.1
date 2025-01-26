Return-Path: <stable+bounces-110497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69190A1C970
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59861887F1C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1DE1DE3AA;
	Sun, 26 Jan 2025 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBtwMovu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65E1DE3A5;
	Sun, 26 Jan 2025 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903063; cv=none; b=aJJxrKTah6E+N9xJ9+dhcfd4JN06bawxgspyd+vY+mh5opOdNB+/k46JV51BcM0TRmuXYfGBPWCFfrZ45+F7YmtcPGMB/sNeUxBJPWhR4wZjUsEuXYoEzcj28fUs7QDhiMFMbhVaLy5x85qCveCry3whEPZ3yJeL2Yo4V/bL+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903063; c=relaxed/simple;
	bh=41ZHguMWvcHvhKKaTf2P6hFALArNKK2Q3CjNZDjU+Vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmYScrxcGlmVgQuwQFjFPqJMSb1YA2JlnUpDMH/cC3UGZr9SzOrJqGoZT/YY6uteN/kVdxMBytr43OsLSq1HlEIhXuJxzvi1balTrbX3xu5rLE98GgnjJEWtySZe6hileeiCdBxCblklQgCOItCYtwtBBIomddHEpw9jsgIOjdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBtwMovu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B21C4CED3;
	Sun, 26 Jan 2025 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903063;
	bh=41ZHguMWvcHvhKKaTf2P6hFALArNKK2Q3CjNZDjU+Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBtwMovuYj99+Ga1d//cMwG3e3GzJbsPpTC3Xc5FJTWYwXZlD18yXvkE2CgOpE5H5
	 bq+mCgLEDkpWjP/se/gabKsPbQSwUgVbvidUgIx37UcYlW4jbmeqPjGjZpwl8GmwMG
	 z3WfcXG5KCs7kYwwZlhz51cByuSIpBVJrmjfTcNhDcecQzKk2b4Befg2AYPYlB216G
	 kRVrbXQXEDryYnn57B0ogeAWljqNSaJicvukjvsO3gznWwK8pgsmF+e7xQwoHG9oQE
	 o9rz034NRTeqiSlf//5ORB997Vq6D9Al0bb1Lu/2tRhZ+2ddGevSEDtxJE7XbfSo1K
	 HC9wG/6P+CQKg==
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
Subject: [PATCH AUTOSEL 5.15 3/3] x86/amd_nb: Restrict init function to AMD-based systems
Date: Sun, 26 Jan 2025 09:50:56 -0500
Message-Id: <20250126145057.926069-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145057.926069-1-sashal@kernel.org>
References: <20250126145057.926069-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
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
index 62cd2af806b47..eda11832b6e62 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -544,6 +544,10 @@ static __init void fix_erratum_688(void)
 
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



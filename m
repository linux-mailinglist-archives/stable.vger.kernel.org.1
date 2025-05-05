Return-Path: <stable+bounces-139834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F311EAAA099
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E579F3B8B43
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7320827CCC9;
	Mon,  5 May 2025 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWzW8zH8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4DC293462;
	Mon,  5 May 2025 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483510; cv=none; b=SThZl1XGpCYOiRAF5LXEIGdXRIzZJhIPHFwE1iXEPPT4EruwyrWbzd2e/90NFeSNcz5mQ69hQLoeVplHjjpyK35ea/fwBcvMHBH1P3OvqU1Emxi6qM0vD1DZVYLZrDLM8HU4Tu0F8P7Jc+9JVd/f58aZHI/XOZMD6HF2FNRj53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483510; c=relaxed/simple;
	bh=a9q5QM5SH38BeJB22nHzyDIwDS4KmiH6/HqhWSpT20I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRJMmlCUL6gx2Uq65Nf70CSi/7SlKVXg/uyAsqcjDds5FMVHlopNyDtfcEcI9oWw22kcJhOww2HL3JbYk+dvPY5UKzjiLvhrHAoGxAmbg/rqwJ0CtmOPir4Ahl1REx5ziFyLYKhndlEFbPR3cuaN5BF9HYkCYpW2uK7zXI7WNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWzW8zH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD2EC4CEEE;
	Mon,  5 May 2025 22:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483510;
	bh=a9q5QM5SH38BeJB22nHzyDIwDS4KmiH6/HqhWSpT20I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DWzW8zH8/c/XQtRdnNuYCn2HqKs9PzA9gj9iWzxbapMQYPNCd6UZ84+TzkKqTjdrY
	 EGAk1P/e6nSDYi78XOTSIVp81hfikwR2tXbAFqCphdKWIqI0WWcMYVaFKgEUFUQxwh
	 2BmRf9keMXt6CGe1v7/rzESGYxE7POsxdNE6o0FwDKShuGTkl5uziWOzwzjE+Gmj2y
	 Yv0QMDq47mtooQA1MHYhVput/4ohAGZHlZh2iKo0ZBKuGrLQGL0TUyS2tc6xa+jzFI
	 jyzTDGHdRDw5vJnTy63TLQfYQK1x+ivjr5qWUSe3pT7ez0ykJrKoEf31E5lv6bUFLB
	 s3Pb6UT2nzvKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sohil Mehta <sohil.mehta@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de
Subject: [PATCH AUTOSEL 6.14 087/642] x86/microcode: Update the Intel processor flag scan check
Date: Mon,  5 May 2025 18:05:03 -0400
Message-Id: <20250505221419.2672473-87-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Sohil Mehta <sohil.mehta@intel.com>

[ Upstream commit 7e6b0a2e4152f4046af95eeb46f8b4f9b2a7398d ]

The Family model check to read the processor flag MSR is misleading and
potentially incorrect. It doesn't consider Family while comparing the
model number. The original check did have a Family number but it got
lost/moved during refactoring.

intel_collect_cpu_info() is called through multiple paths such as early
initialization, CPU hotplug as well as IFS image load. Some of these
flows would be error prone due to the ambiguous check.

Correct the processor flag scan check to use a Family number and update
it to a VFM based one to make it more readable.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250219184133.816753-4-sohil.mehta@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/intel-family.h   | 1 +
 arch/x86/kernel/cpu/microcode/intel.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index ef5a06ddf0287..44fe88d6cf5c0 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -46,6 +46,7 @@
 #define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
 
 #define INTEL_PENTIUM_PRO		IFM(6, 0x01)
+#define INTEL_PENTIUM_III_DESCHUTES	IFM(6, 0x05)
 
 #define INTEL_CORE_YONAH		IFM(6, 0x0E)
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index f3d534807d914..819199bc0119b 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -74,7 +74,7 @@ void intel_collect_cpu_info(struct cpu_signature *sig)
 	sig->pf = 0;
 	sig->rev = intel_get_microcode_revision();
 
-	if (x86_model(sig->sig) >= 5 || x86_family(sig->sig) > 6) {
+	if (IFM(x86_family(sig->sig), x86_model(sig->sig)) >= INTEL_PENTIUM_III_DESCHUTES) {
 		unsigned int val[2];
 
 		/* get processor flags from MSR 0x17 */
-- 
2.39.5



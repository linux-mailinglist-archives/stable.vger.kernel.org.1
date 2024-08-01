Return-Path: <stable+bounces-64914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A57C943C45
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8D1281574
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCD114BFA3;
	Thu,  1 Aug 2024 00:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N06vg2eI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47108136E3F;
	Thu,  1 Aug 2024 00:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471414; cv=none; b=VQX1G1Ynblv5IbT3uA/AClyKBYySZzLUeC5NowMhaCaSl4Sa2Mae2B4Frnrp/YzhqD5QYTYEpRF8hhDqFudWbMTNN95Z9PeidE5DedKb6G2cYDzwdYSOxpc/18BU1XYwM05z0J0E66EPHN1yk2dD5jRpdJ+PwXIJqMCd/YCnlNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471414; c=relaxed/simple;
	bh=wqvCfGhTJfX5N11u3OLFAOWJEbtfauWDxqT2+qsQgIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2RNABwsc6akrrcQH2AUkSf0bICtoB/HmzmRp78NDJWUjpRcz9n4DrqErKpG+bQZqOz16KOkhZs1Y+Kg7N+Fw0dNuKv8xolGYj+3xYOQ2vq8ADwlBhSQF2IoKXPEKkjuZyoX9vzfrRmT9I4ahUl/+C1Qz2x0rEcXoBwGwBJ2lW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N06vg2eI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157EDC32786;
	Thu,  1 Aug 2024 00:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471414;
	bh=wqvCfGhTJfX5N11u3OLFAOWJEbtfauWDxqT2+qsQgIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N06vg2eIy3zOtud3Xjc93YZKDj57M8FyS57pwIcr/syjoZxwg/QES5ItP2v3fLWS3
	 WZlP7qopWe2U+jcIs/y1YX77UJA8gjIPdRrE+p+n0cBemCHJW5TnjjdDczi8qYUe7F
	 woRQIM5uSECdsY2ijMgARsAuZbGuCBb//7SiklumRuSUajKkimEw4mJLxHOtiGWq+Z
	 FWVJHMcJ9g7lEZPBB43u52P2lx19OWXN6e0rm+0zpZ5Q6teZZzZRf9bMqlXj/3JRu2
	 4kSgXia3HOqcIJpi/aQU8iCn7Pco9Bje3PalAsyAImcg7+TGcEMiPMZ3hXz08aDxR2
	 Pksefqr2uCWBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	ast@kernel.org,
	peterz@infradead.org,
	jgross@suse.com,
	jpoimboe@kernel.org,
	leitao@debian.org,
	arnd@arndb.de
Subject: [PATCH AUTOSEL 6.10 089/121] x86/alternatives: Make FineIBT mode Kconfig selectable
Date: Wed, 31 Jul 2024 20:00:27 -0400
Message-ID: <20240801000834.3930818-89-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit d6f635bcaca8d38dfa47ee20658705f9eff156b5 ]

Since FineIBT performs checking at the destination, it is weaker against
attacks that can construct arbitrary executable memory contents. As such,
some system builders want to run with FineIBT disabled by default. Allow
the "cfi=kcfi" boot param mode to be selectable through Kconfig via the
newly introduced CONFIG_CFI_AUTO_DEFAULT.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20240501000218.work.998-kees@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Kconfig              | 9 +++++++++
 arch/x86/include/asm/cfi.h    | 2 +-
 arch/x86/kernel/alternative.c | 8 ++++----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d7122a1883e8..56e301921d2a1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2427,6 +2427,15 @@ config STRICT_SIGALTSTACK_SIZE
 
 	  Say 'N' unless you want to really enforce this check.
 
+config CFI_AUTO_DEFAULT
+	bool "Attempt to use FineIBT by default at boot time"
+	depends on FINEIBT
+	default y
+	help
+	  Attempt to use FineIBT by default at boot time. If enabled,
+	  this is the same as booting with "cfi=auto". If disabled,
+	  this is the same as booting with "cfi=kcfi".
+
 source "kernel/livepatch/Kconfig"
 
 endmenu
diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 7cd7525579051..31d19c815f992 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -93,7 +93,7 @@
  *
  */
 enum cfi_mode {
-	CFI_DEFAULT,	/* FineIBT if hardware has IBT, otherwise kCFI */
+	CFI_AUTO,	/* FineIBT if hardware has IBT, otherwise kCFI */
 	CFI_OFF,	/* Taditional / IBT depending on .config */
 	CFI_KCFI,	/* Optionally CALL_PADDING, IBT, RETPOLINE */
 	CFI_FINEIBT,	/* see arch/x86/kernel/alternative.c */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 89de612432728..7fcba437abaee 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -885,8 +885,8 @@ void __init_or_module apply_seal_endbr(s32 *start, s32 *end) { }
 
 #endif /* CONFIG_X86_KERNEL_IBT */
 
-#ifdef CONFIG_FINEIBT
-#define __CFI_DEFAULT	CFI_DEFAULT
+#ifdef CONFIG_CFI_AUTO_DEFAULT
+#define __CFI_DEFAULT	CFI_AUTO
 #elif defined(CONFIG_CFI_CLANG)
 #define __CFI_DEFAULT	CFI_KCFI
 #else
@@ -994,7 +994,7 @@ static __init int cfi_parse_cmdline(char *str)
 		}
 
 		if (!strcmp(str, "auto")) {
-			cfi_mode = CFI_DEFAULT;
+			cfi_mode = CFI_AUTO;
 		} else if (!strcmp(str, "off")) {
 			cfi_mode = CFI_OFF;
 			cfi_rand = false;
@@ -1254,7 +1254,7 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 		      "FineIBT preamble wrong size: %ld", fineibt_preamble_size))
 		return;
 
-	if (cfi_mode == CFI_DEFAULT) {
+	if (cfi_mode == CFI_AUTO) {
 		cfi_mode = CFI_KCFI;
 		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
 			cfi_mode = CFI_FINEIBT;
-- 
2.43.0



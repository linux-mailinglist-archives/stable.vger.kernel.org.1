Return-Path: <stable+bounces-127095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 047D3A7686F
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DCD188936E
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A59224224;
	Mon, 31 Mar 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STSqu9aV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A922371E;
	Mon, 31 Mar 2025 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431737; cv=none; b=M3P0KxP4FaZTOAJP/0sDARLT/BY3VABO7bI2vcL5Lk++SVNTf8BroTPGwOfPGVYD/igMFT1gTxakwJ25FKd0ywseQTRNlHIX9cTrRK3vfOf7HmN4rEgrKfVJRDsBcuJxlbs7aAVQpCdEyxAJS2FiiY0dkCU0+1NpU3ek8epDlGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431737; c=relaxed/simple;
	bh=dokLz64a3JAqkh0ZQOi/NgeiJe5tuEwL48FedkASPCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=anrJCOn/Qb3l4j8Ijb16FAc/jt7xvBHJ23SBrRzekYeFn4BAYilWpRkDkMs76CQx1+4g/h/BWJyKTpCue51LtAeY32Hb4N4UDVsEEn8Ph4abbXLSCPgmprXTKO1tsDvmJ9vrCPwRkL5yM4ZCebhAm1TJz7IHTDOPvzo9KokQ+/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STSqu9aV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B65CC4CEE3;
	Mon, 31 Mar 2025 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431736;
	bh=dokLz64a3JAqkh0ZQOi/NgeiJe5tuEwL48FedkASPCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=STSqu9aVWdnYpatBgdcgQaxgoR/DJfp8HfsBJXmVcqE6tmgzs1J5XXm/wYiWMWB5P
	 NVl9xZMUixEQvUttJsZgEX174eqHeZtaSc9EsDXRniRRiPWxnu5mB7M7ofCtHSkzeN
	 Nus3Bl+2/B1axV4eXgGLd7vkjNLgLiZguxb4Plmgd91GWupcGS9kXiTngfpTG/9vOr
	 1GmnAssARn4naomqF/zz6ETnlc5plhLdupXB64Pd4ykA1CRwsGA31b8RO52hB7stFX
	 JkKbILRV10YUVnCUMTe9ZadAYZAGPKrwKNiK1zKYeNjFWxa5K5RHFEf16mzzwZFiYZ
	 zyHsXIs220ORA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Matt Fleming <matt@readmodwrite.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: [PATCH AUTOSEL 6.12 03/13] x86/percpu: Disable named address spaces for UBSAN_BOOL with KASAN for GCC < 14.2
Date: Mon, 31 Mar 2025 10:35:17 -0400
Message-Id: <20250331143528.1685794-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143528.1685794-1-sashal@kernel.org>
References: <20250331143528.1685794-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Uros Bizjak <ubizjak@gmail.com>

[ Upstream commit b6762467a09ba8838c499e4f36561e82fc608ed1 ]

GCC < 14.2 does not correctly propagate address space qualifiers
with -fsanitize=bool,enum. Together with address sanitizer then
causes that load to be sanitized.

Disable named address spaces for GCC < 14.2 when both, UBSAN_BOOL
and KASAN are enabled.

Reported-by: Matt Fleming <matt@readmodwrite.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250227140715.2276353-1-ubizjak@gmail.com
Closes: https://lore.kernel.org/lkml/20241213190119.3449103-1-matt@readmodwrite.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Kconfig | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6f8e9af827e0c..e9fb64b55912d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2433,18 +2433,20 @@ config CC_HAS_NAMED_AS
 	def_bool $(success,echo 'int __seg_fs fs; int __seg_gs gs;' | $(CC) -x c - -S -o /dev/null)
 	depends on CC_IS_GCC
 
+#
+# -fsanitize=kernel-address (KASAN) and -fsanitize=thread (KCSAN)
+# are incompatible with named address spaces with GCC < 13.3
+# (see GCC PR sanitizer/111736 and also PR sanitizer/115172).
+#
+
 config CC_HAS_NAMED_AS_FIXED_SANITIZERS
-	def_bool CC_IS_GCC && GCC_VERSION >= 130300
+	def_bool y
+	depends on !(KASAN || KCSAN) || GCC_VERSION >= 130300
+	depends on !(UBSAN_BOOL && KASAN) || GCC_VERSION >= 140200
 
 config USE_X86_SEG_SUPPORT
-	def_bool y
-	depends on CC_HAS_NAMED_AS
-	#
-	# -fsanitize=kernel-address (KASAN) and -fsanitize=thread
-	# (KCSAN) are incompatible with named address spaces with
-	# GCC < 13.3 - see GCC PR sanitizer/111736.
-	#
-	depends on !(KASAN || KCSAN) || CC_HAS_NAMED_AS_FIXED_SANITIZERS
+	def_bool CC_HAS_NAMED_AS
+	depends on CC_HAS_NAMED_AS_FIXED_SANITIZERS
 
 config CC_HAS_SLS
 	def_bool $(cc-option,-mharden-sls=all)
-- 
2.39.5



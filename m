Return-Path: <stable+bounces-127083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF62A76840
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7777A50ED
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E654221D8B;
	Mon, 31 Mar 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDggeruj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D60D221D82;
	Mon, 31 Mar 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431703; cv=none; b=IGBp1DbYK8N88ms/sskaZtjtWMEeylEVm+2RNyPVuzdWWPbpE18xUeiAAgZSkdkb6IMx2oYB4nruMiC1L7Zk0ojUCg3LkUV7h6KSl05k6wMkAvcWUUqdq6voaAaIruFCckhQD/XyBUE0QjEikJWusZsSrD00bON+xvK+/TfU88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431703; c=relaxed/simple;
	bh=w6aIl8ZU6/TsEWQANDuwe3iAyyPKwkjAYfh+i0mSN24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eVbkumw/PsOVj7TyokpGXIubdubFVnZLQpBD2huAHi5LWbOtEZxqGYUTTPtvCGHcLjKfBeukLK55sLBciFXkMtehB6VudYOcxH+v6iMmd0WhZCFkvQH30+YDYx+ux3QOLeuzJhpau7FDooYBqhrxUdUwm3aMTsKqvebtTYZGpwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDggeruj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2614C4CEE3;
	Mon, 31 Mar 2025 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431703;
	bh=w6aIl8ZU6/TsEWQANDuwe3iAyyPKwkjAYfh+i0mSN24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LDggerujBtPSX7a9Hc3gSLLG4Tp8eVbpJ8M5UaEd7UxNJEAUCdagOvTDMJNF0Vji+
	 LcuJBJc2I7RlBhz4HHtHy9VICUKIZ9mCQtnfK/vhUzsHDHvu0cC/t/1F7usty4hj5K
	 jy72SPSKBVGfLnxpjINrvcIyJExRHi19a450uIfJVKGECVXRWQ7eA/mcNCkztG8F/R
	 ed6AEui/mb2mxTOnISPCU6x1d1226eJSak/c0JlH4J8aomChzybuEtJu73fA+RU3CI
	 327TrAgPBg4UMDU3fZ35eiCrpiaPKwWF25184/b/uIz9MuEDpSY4TQJrUE7iFs/N1E
	 VDUM8Eiid+htQ==
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
Subject: [PATCH AUTOSEL 6.13 05/16] x86/percpu: Disable named address spaces for UBSAN_BOOL with KASAN for GCC < 14.2
Date: Mon, 31 Mar 2025 10:34:39 -0400
Message-Id: <20250331143450.1685242-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143450.1685242-1-sashal@kernel.org>
References: <20250331143450.1685242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 757333fe82c76..83ebb7626c283 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2445,18 +2445,20 @@ config CC_HAS_NAMED_AS
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



Return-Path: <stable+bounces-96124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF6F9E08E7
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05B4BC264B
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93851B394D;
	Mon,  2 Dec 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="FGI73+x+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="evqxDflA"
X-Original-To: stable@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC941AC444
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156604; cv=none; b=dVHzyFmbJU02Jgjs/+vwXQRSI5ZqISfk/QTrs81rrkdG0W1bsrVBN41qzbGhFbyWoh2jmJT3pCdIk2BnNaLHYDRAD7PTosQSdsWzqxMJpG39y5zhKzfMaDZJ60+GvJ4pMpdX+YYMExtLTxJqWQ0N/09OvQQqCKWUiART2oKdIc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156604; c=relaxed/simple;
	bh=05G92EVrlhv3yOxiX9FIlWSU+y2sTMaXIb3mVRKEkto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEhtv/fuzqXYj3Ob9HGjQWnFpMoQqX52ZV3LkPTKVzSo5Ho8UjnDSX8VBdR1Wgp6dsPrX/xtfVpv2DMWlTJvvjcw2HDb/+SUkjpU1IgvUEPEOoMEfldjXq0FjlfJJqIFuZdN5p3tCT1k5WyNtMLT+ACjhoJLRe03DDaadvXyFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=FGI73+x+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=evqxDflA; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E1A613806B2;
	Mon,  2 Dec 2024 11:23:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 02 Dec 2024 11:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1733156600; x=
	1733243000; bh=D+hTh3v2GmvzPejfCAFGnfz26QpQzRpFO4C3N6oL8iw=; b=F
	GI73+x+C61KJ+YimR24UajIgCxXlJ0zMhyB3xAv/lZ+3oIw/q/GTYoyfbc84CtA6
	QPt3GjwzTayo75pFPq/ZgSVlR+pe1ARHpusiNPR6on3rSClskYN6WwYQsnz4NL5h
	my59isx9wRbLlJWUK9OUQO/gVAEIRkEnxb/V2wURkrd40EAcoa2sQ6Nvt2AKtzd3
	ja+ppMFMmJhuiI6IbJnwTmg3WLklEAkOI/kifZHFAKlcgCf/iE0hm01MOpXrU/YX
	IvKHbhsZaOHbjExqpPdtfzcF2nStoaOQqpdCJ4OWd2AYUER0oTqgX2pGL2BtUKtp
	M+M5RNOjXCgcmo9xq4OFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1733156600; x=1733243000; bh=D
	+hTh3v2GmvzPejfCAFGnfz26QpQzRpFO4C3N6oL8iw=; b=evqxDflAcimzzYAN4
	znKyvk6yF3GHTGabE3nt45dCnfftywMp0pJ/qoe33W97zvZF6B37OrHcgFUTg1Dr
	vt3kpOhu9/ZYaI2476x4rQAwcFoHRgcNWDEtlEjxr8ss3TN/ffwXUKMPNvODOfQ7
	OwJi34OpQ0C6VDLY6aLbz2hplyS+JRnKBW1sllbotwpzly1WGAn6eWd+brjJ0ltH
	TTU9VC369EDcBbeW/MTpf0Arw0DJXgtoamzCtI64u0vadpJ7SwjFJHYtdIVFC9JH
	shuwzhmzGmjtNvdNimWlO/ZYEM4cqNIwSFnBnS4WC9mX0ZBDRCJQcnw9BnVMeLB3
	buDjg==
X-ME-Sender: <xms:995NZ5F5sgmFVhriiKKvVw9HNUS4bStAXN7rRKNTpg5qTh2qh1UyCQ>
    <xme:995NZ-Uk2JFtp4dNL-7yFomrpdkkHAkO20ol6dWa6r6VUCF7fIqAN05pfi7d79ZYk
    NsMCE97x9HZDT4mTN8>
X-ME-Received: <xmr:995NZ7LLqdrgaEvAHN86UbOj_rIh3lxE1pX4WnRnKvrCMb4t6DUm-XgnTtXR2DjlWP-DAhcVyY7KdpGVt6u4eAR_OcueBbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculddutddmnecujfgurhephffvvefufffkofgj
    fhgggfestdekredtredttdenucfhrhhomheplfgrnhcujfgvnhgurhhikhcuhfgrrhhruc
    eokhgvrhhnvghlsehjfhgrrhhrrdgttgeqnecuggftrfgrthhtvghrnhepheetgeekteef
    kefftdeuuedujeevhffhfeejgfehvdejtefftddtleefvdejhfejnecuffhomhgrihhnpe
    hgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgpdhgnhhurdhorhhgpdhllhhvmhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hkvghrnhgvlhesjhhfrghrrhdrtggtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdp
    rhgtphhtthhopehkvghrnhgvlhesjhhfrghrrhdrtggtpdhrtghpthhtohepnhgrthhhrg
    hnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeholhhivhgvrhdrshgrnhhgsehinhht
    vghlrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepthhhohhrshhtvghnrdgslhhumheslhhinhhugidruggvvhdprhgtphhtthhopehk
    vggvsheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:995NZ_ESSRA5t3_tpXla0oHS_riattwhMr39NYtRm2pC-hG5HnXAfg>
    <xmx:995NZ_VakUZXdrjs2qVrkmZ8zAZszJ_vG9gaXEnf6VU8HSCkKKjoyQ>
    <xmx:995NZ6N0XnQPGQB8BoUdgTIEubIgLOBilv1ch7qilWPLp7Hrl8qORA>
    <xmx:995NZ-2s47sXXjo_2ehgszqNhmb1lNcUhpaZnfY5VGxwVCEcWoSnQQ>
    <xmx:-N5NZ7oECx3obdgcEgjI8ZkJG8qWjyke-ylLaWZqAWHrL8rxASokEuBF>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 11:23:18 -0500 (EST)
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 6.6.y] Compiler Attributes: disable __counted_by for clang < 19.1.3
Date: Mon,  2 Dec 2024 17:23:07 +0100
Message-ID: <20241202162307.325302-1-kernel@jfarr.cc>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2024120221-gizzard-thermos-ba19@gregkh>
References: <2024120221-gizzard-thermos-ba19@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f06e108a3dc53c0f5234d18de0bd224753db5019 upstream.

This patch disables __counted_by for clang versions < 19.1.3 because
of the two issues listed below. It does this by introducing
CONFIG_CC_HAS_COUNTED_BY.

1. clang < 19.1.2 has a bug that can lead to __bdos returning 0:
https://github.com/llvm/llvm-project/pull/110497

2. clang < 19.1.3 has a bug that can lead to __bdos being off by 4:
https://github.com/llvm/llvm-project/pull/112636

Fixes: c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and identifier expansion")
Cc: stable@vger.kernel.org # 6.6.x: 16c31dd7fdf6: Compiler Attributes: counted_by: bump min gcc version
Cc: stable@vger.kernel.org # 6.6.x: 2993eb7a8d34: Compiler Attributes: counted_by: fixup clang URL
Cc: stable@vger.kernel.org # 6.6.x: 231dc3f0c936: lkdtm/bugs: Improve warning message for compilers without counted_by support
Cc: stable@vger.kernel.org # 6.6.x
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20240913164630.GA4091534@thelio-3990X/
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409260949.a1254989-oliver.sang@intel.com
Link: https://lore.kernel.org/all/Zw8iawAF5W2uzGuh@archlinux/T/#m204c09f63c076586a02d194b87dffc7e81b8de7b
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jan Hendrik Farr <kernel@jfarr.cc>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://lore.kernel.org/r/20241029140036.577804-2-kernel@jfarr.cc
Signed-off-by: Kees Cook <kees@kernel.org>
(cherry picked from commit f06e108a3dc53c0f5234d18de0bd224753db5019)
Signed-off-by: Jan Hendrik Farr <kernel@jfarr.cc>
---
 drivers/misc/lkdtm/bugs.c           |  4 ++--
 include/linux/compiler_attributes.h | 13 -------------
 include/linux/compiler_types.h      | 19 +++++++++++++++++++
 init/Kconfig                        |  9 +++++++++
 4 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index c66cc05a68c4..473ec58f87a2 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -388,8 +388,8 @@ static void lkdtm_FAM_BOUNDS(void)
 
 	pr_err("FAIL: survived access of invalid flexible array member index!\n");
 
-	if (!__has_attribute(__counted_by__))
-		pr_warn("This is expected since this %s was built a compiler supporting __counted_by\n",
+	if (!IS_ENABLED(CONFIG_CC_HAS_COUNTED_BY))
+		pr_warn("This is expected since this %s was built with a compiler that does not support __counted_by\n",
 			lkdtm_kernel_info);
 	else if (IS_ENABLED(CONFIG_UBSAN_BOUNDS))
 		pr_expected_config(CONFIG_UBSAN_TRAP);
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index f5859b8c68b4..7e0a2efd90ca 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -94,19 +94,6 @@
 # define __copy(symbol)
 #endif
 
-/*
- * Optional: only supported since gcc >= 14
- * Optional: only supported since clang >= 18
- *
- *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
- * clang: https://reviews.llvm.org/D148381
- */
-#if __has_attribute(__counted_by__)
-# define __counted_by(member)		__attribute__((__counted_by__(member)))
-#else
-# define __counted_by(member)
-#endif
-
 /*
  * Optional: not supported by gcc
  * Optional: only supported since clang >= 14.0
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 0a182f088c89..02f616dfb15f 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -295,6 +295,25 @@ struct ftrace_likely_data {
 #define __no_sanitize_or_inline __always_inline
 #endif
 
+/*
+ * Optional: only supported since gcc >= 15
+ * Optional: only supported since clang >= 18
+ *
+ *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
+ * clang: https://github.com/llvm/llvm-project/pull/76348
+ *
+ * __bdos on clang < 19.1.2 can erroneously return 0:
+ * https://github.com/llvm/llvm-project/pull/110497
+ *
+ * __bdos on clang < 19.1.3 can be off by 4:
+ * https://github.com/llvm/llvm-project/pull/112636
+ */
+#ifdef CONFIG_CC_HAS_COUNTED_BY
+# define __counted_by(member)		__attribute__((__counted_by__(member)))
+#else
+# define __counted_by(member)
+#endif
+
 /* Section for code which can't be instrumented at all */
 #define __noinstr_section(section)					\
 	noinline notrace __attribute((__section__(section)))		\
diff --git a/init/Kconfig b/init/Kconfig
index 6054ba684c53..60ed7713b5ee 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -107,6 +107,15 @@ config CC_HAS_ASM_INLINE
 config CC_HAS_NO_PROFILE_FN_ATTR
 	def_bool $(success,echo '__attribute__((no_profile_instrument_function)) int x();' | $(CC) -x c - -c -o /dev/null -Werror)
 
+config CC_HAS_COUNTED_BY
+	# TODO: when gcc 15 is released remove the build test and add
+	# a gcc version check
+	def_bool $(success,echo 'struct flex { int count; int array[] __attribute__((__counted_by__(count))); };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
+	# clang needs to be at least 19.1.3 to avoid __bdos miscalculations
+	# https://github.com/llvm/llvm-project/pull/110497
+	# https://github.com/llvm/llvm-project/pull/112636
+	depends on !(CC_IS_CLANG && CLANG_VERSION < 190103)
+
 config PAHOLE_VERSION
 	int
 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
-- 
2.47.1



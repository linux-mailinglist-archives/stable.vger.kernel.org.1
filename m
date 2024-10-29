Return-Path: <stable+bounces-89210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 365309B4BA2
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 15:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6A3B21B0D
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 14:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1681206E78;
	Tue, 29 Oct 2024 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="nx7dlAE5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eWd3WxUS"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8842A92;
	Tue, 29 Oct 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210511; cv=none; b=Fo1U8Aupiq6u5d4pTZb56/t+xn7OyF4uAo+j1piUSho3eiHz7nDagGXxbJzuhhwAQefZ56mffXRN76V+/U0T/TTwe/tpJ2jW3zDCwwS9V0Wrd0ZD0sWZ6aNOGClSAln0i+iAzkjX1ASraXg4XlR8iqMoPBliOmD9UBQ6PleU6W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210511; c=relaxed/simple;
	bh=3rJfEeulcwmm5KkpsyLDLzpEobNGmIAWrdzAG/KU/nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlZeMvPFhwMuWF0WKQovtgeeTt5LaMbHw124Wf/DrQaB2W847sdAwEW76MNjpYQBHoV3UTIAMe99UzUf3CYRVrPj2DUljoJtcBWj4ztaoFFxfiyDGuJxCnEcx7ZLy+LYfwgd1Umphd0oQEaiQM60/57ZVFwE4Tmjp1KkjqsFYlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=nx7dlAE5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eWd3WxUS; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4687A11400FE;
	Tue, 29 Oct 2024 10:01:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 29 Oct 2024 10:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1730210508; x=
	1730296908; bh=KsHabXMU5ippsDdU8PoSGYpn9SGBocWvyQqhdvklShY=; b=n
	x7dlAE5GQU0RIzW7iP1VOyKJM52eCC2EjPFfaXC20iLUxo93+1Enc/e6rE8IQcrP
	kGkoywEvE/ZDVreOHXF2bjhkXOmuICxQtHc+694UBRajnpeV7+9G/ieehq/XqHS/
	Tbd0OH0p7l5MGUVNCNSnihtUndBXz1mhcUJvTG3F5tFtr2rHgBsWcW6YQ5tKmI8h
	3KWIaqD28Ah9QFShLg2fBzdbY5EMoiBHsWHF3g/L7k+DKiy60/pKWRe9VHjbDAlE
	d5VqWRz74FqfR7KG8k80TM5EJ8+y9RUjRgtEcpBHDmTO82cWoqCFecKgeogatOLb
	QvdoYrM0yUYyKsVXEluMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730210508; x=1730296908; bh=K
	sHabXMU5ippsDdU8PoSGYpn9SGBocWvyQqhdvklShY=; b=eWd3WxUSBwQurHIbL
	7Sh5o3h8FudUgh9HQTR6hMpEd2Ia0hJGdETjsqMcI3V4O8PrJCaScn+Wz5D9R2zB
	fZxrzBleYCKgixju6aXGvzeroT31tvJ8a/hycYx1iUyCC3a3ij0pnLzw0903f9jr
	7EnBz/sJEwKLj33WQcbg374KpFoLCxsqfo593BgtfWaxAngQgOWIA7I8xuK0Kad1
	JatbGunssMUSyUtrUBQsExQhXO1B5zxuMNoZBcYyg1vH8+qKkT8/W0hNr3YTXEIJ
	F/iRChw43r4bx5xd0tRNBJu00zOATM/MBHqhu7phIlGlp0T4TfIWlXId+ny3xzqL
	PCtLg==
X-ME-Sender: <xms:y-ogZy3t-mf799Ad3QXXVIWbJ6wBVQm3NWQoj1arHrdWPrh_KKprYg>
    <xme:y-ogZ1GGX6qvy5PFkthTs4yDw05nU51H8cmKEvVfQo1-7KT4BHFnK8YFR7jv6oYZj
    OPZdymhtYrpDjEI_eY>
X-ME-Received: <xmr:y-ogZ65OZWXEJ5CwViuVzzuCvPGcKD39lDPvVqo-mx_oEqNdGG33yKFeWvbojnmPOwBRaU2y3qdF8caJb1NfZFHaOn-QvJY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlud
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefl
    rghnucfjvghnughrihhkucfhrghrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenuc
    ggtffrrghtthgvrhhnpeefgeeihfejleefhfehhfetfeeggffgleefjeetgffhffefffel
    teegvdefheektdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdroh
    hrghdpghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkvghrnhgvlhesjhhfrghrrhdrtggtpdhnsggprhgtphhtthhopedvtd
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepoh
    hjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhguvghsrghulhhnihgvrhhs
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehmohhrsghosehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehjuhhsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehthhhorhhsthgvnhdrsghluhhmsehtohgslhhugidrtghomhdprhgtphhtthhope
    grrhgusgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhlihhvvghrrdhsrghnghes
    ihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:y-ogZz1AHuLFkLZM96y4dXKg0IyYnow4lMjDyeJP4D48weWmVw4BXw>
    <xmx:y-ogZ1HsF8_d6ynZp4_CdIfcNEPb7D_InYTPucSdTMd8esWkiKZsgQ>
    <xmx:y-ogZ88AE0W5UQhHBm0oF5sgYFrkd1PWLWlBvgx14FKWmh31anauJw>
    <xmx:y-ogZ6njQi_FLU9F1hT9A3D_1LlzgiJzBhQc_-57LCn6fX1Q77WoCA>
    <xmx:zOogZwnV7uGxy3ByzU7yB3SBUMM69MIEgGF5ma9HpcaLJw9-WmXQDMMb>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 10:01:45 -0400 (EDT)
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: kees@kernel.org
Cc: nathan@kernel.org,
	ojeda@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	thorsten.blum@toblux.com,
	ardb@kernel.org,
	oliver.sang@intel.com,
	gustavoars@kernel.org,
	kent.overstreet@linux.dev,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	tavianator@tavianator.com,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel@jfarr.cc
Subject: [PATCH 1/1] Compiler Attributes: disable __counted_by for clang < 19.1.3
Date: Tue, 29 Oct 2024 15:00:36 +0100
Message-ID: <20241029140036.577804-2-kernel@jfarr.cc>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029140036.577804-1-kernel@jfarr.cc>
References: <20241029140036.577804-1-kernel@jfarr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/misc/lkdtm/bugs.c           |  2 +-
 include/linux/compiler_attributes.h | 13 -------------
 include/linux/compiler_types.h      | 19 +++++++++++++++++++
 init/Kconfig                        |  9 +++++++++
 lib/overflow_kunit.c                |  2 +-
 5 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 62ba01525479..376047beea3d 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -445,7 +445,7 @@ static void lkdtm_FAM_BOUNDS(void)
 
 	pr_err("FAIL: survived access of invalid flexible array member index!\n");
 
-	if (!__has_attribute(__counted_by__))
+	if (!IS_ENABLED(CONFIG_CC_HAS_COUNTED_BY))
 		pr_warn("This is expected since this %s was built with a compiler that does not support __counted_by\n",
 			lkdtm_kernel_info);
 	else if (IS_ENABLED(CONFIG_UBSAN_BOUNDS))
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 32284cd26d52..c16d4199bf92 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -94,19 +94,6 @@
 # define __copy(symbol)
 #endif
 
-/*
- * Optional: only supported since gcc >= 15
- * Optional: only supported since clang >= 18
- *
- *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
- * clang: https://github.com/llvm/llvm-project/pull/76348
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
index 1a957ea2f4fe..639be0f30b45 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -323,6 +323,25 @@ struct ftrace_likely_data {
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
 /*
  * Apply __counted_by() when the Endianness matches to increase test coverage.
  */
diff --git a/init/Kconfig b/init/Kconfig
index 530a382ee0fe..92f106cf5572 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -116,6 +116,15 @@ config CC_HAS_ASM_INLINE
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
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 2abc78367dd1..5222c6393f11 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -1187,7 +1187,7 @@ static void DEFINE_FLEX_test(struct kunit *test)
 {
 	/* Using _RAW_ on a __counted_by struct will initialize "counter" to zero */
 	DEFINE_RAW_FLEX(struct foo, two_but_zero, array, 2);
-#if __has_attribute(__counted_by__)
+#ifdef CONFIG_CC_HAS_COUNTED_BY
 	int expected_raw_size = sizeof(struct foo);
 #else
 	int expected_raw_size = sizeof(struct foo) + 2 * sizeof(s16);
-- 
2.47.0



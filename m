Return-Path: <stable+bounces-151932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1859AD12CC
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 16:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB751694E0
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2304424DCFE;
	Sun,  8 Jun 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbRcXwlz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C891FC0EA
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749394524; cv=none; b=PmSeRBQ1SUNZMe+SnhqriotqOHkwcCPa+Yz++mXVR1GNdyzOJsJ6qtk+RnIkBnQdSYuM90A7+LSoiPf/VtiPHhDKX2Bjig3DJgXE1anjcZGZd+U05C2Bh4TJJEl+SjY9dCpm4/KVbc2bmmZek8yItJhBJVwU8Z3Tq3SV3dOTDJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749394524; c=relaxed/simple;
	bh=CU72MYvKCSUB0SA6bq38cvMpeK8Vzc4mcxZ73Ql56uA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5fO8QEGCG2af8v90oRvGV+TMxe04GiWVXG+iIoQP4p7NGKyzw1zpGmZ2IPmW/EZGJtK8GAg0Y5iODJ+B9tFM4oABWJ0KsJgaUFY3pCAsAOgJujLx7dq5oJObOTZWEm4UXLX1xcD2VJalrNwVQSqGzl0wU0fTYvK68s0lW7Kh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbRcXwlz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45310223677so2604105e9.0
        for <stable@vger.kernel.org>; Sun, 08 Jun 2025 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749394521; x=1749999321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgaKCZoQUFdj6ojhrX/ZfEZWvlpm3IPf8TsTogANg0g=;
        b=RbRcXwlzpaKIHzkDimR/TGEjKkGZ2i6dFJ6XqEIVEjW4R/bpwH5iqMdxJ9jpTZYj15
         cW2e+atA5x8KrElCFmEt+i5kC14TuRlx0mRPgiCyPFXuhSvQVqtvrxeA/wabopfmG+1M
         eZ9Ft6anYAaAPteILofCJFFRgAra0kP/G28ax9CSm2wQzeB3AkdxvjZSAAYRASqyWfoe
         7FCYqh+t24XCvAj/YyT/2P6o/4FZ6rPODBddpu0hfP78b5dyrsdmIdyI29DJ7Cw2ifmC
         /NiS4ueHN8qXf4xJaVLWMNyh4xzB7DEaSDdSZo0au/ESZy7np6yk1yqnTZeI1LgipJXS
         66Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749394521; x=1749999321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgaKCZoQUFdj6ojhrX/ZfEZWvlpm3IPf8TsTogANg0g=;
        b=TPhyh3zBQMAky0lqDHqrH9AQCQYFiGvbhbiSk8oLHWRlBoMWXwfcWk29XLMvR6pARo
         rj+5253nIloraTJMhfG1yinzuqtIVjKp8pJ9Mgh7ltUa5YE4Qx3weOkaKIX/fTAdIAUT
         TL5FcnEQUc8GoyI9S1ro5La7+C6hetle6JBChBIq48R2ajLxoaOrR1c78T03lz5ThtLO
         iDyE3hvQSZ5KXDSZ+sBX0+PhQVsRu25bXGgDAd2nTmPCjKZskVoOa4Vd3W8HFuyNe9mw
         7zJY4aB9LvZRMqqhMox5AqBuKVSnmQW86i37MOfeH3t1Gay3QqebIDb5AvOkszw8hvqG
         RQuw==
X-Gm-Message-State: AOJu0Yxv/wSHA6c4e/MSXv7XiMMypMOmed7rxL3eb6zwFBbnRveRfvRy
	gGCxaY62ybOGl+5dXTT3+lZvUCzM/SIjFLHsG4p0paaym78f8ip7HGkYwLrR32uY
X-Gm-Gg: ASbGncu6blR7DsmQBI7giDKZImxymPL6bjfXJJ31scs2qXWhsxRfAskOk6BLffDuvZF
	dj7aM5f66DWJpdSU24x/oai588QBiUhPSqqvR1qWWDCcKCaUgI6Kedeq0n1wDIen/lT2hB6FLoQ
	4R03XWtdBfkKPhphfgBBqi+dF+QqFfg3s6Bm9vEEcoZLskA69AtAb0L8vBsnflrgJ0hncxwqmsm
	Do/VkeyNKpSWKDCi//oG4IPaQ3uhsT+Kje9Ht6cpgPtUXp1z73n6gJwjdaSja1VS9/b+YbGbEk2
	XQbueGj4n3HsI2Zka3aR2RqmLUtm9veqXqxshLUVVat2bL/1kFxONLt9UOlskWB54NrrEfsZ4Et
	Ww810xJZ+C7dU4S6joEyQx1GGg6tKd+J/ufwh
X-Google-Smtp-Source: AGHT+IG00MHihCYJjs3QS97R9AoHO8xjLqiYgE/t07JG8LCI/yfkNNIPQqs5WPjgcKRwrcZt7+04+A==
X-Received: by 2002:a05:6000:2088:b0:3a4:d64a:3df6 with SMTP id ffacd0b85a97d-3a5319b1ab1mr7276280f8f.3.1749394520946;
        Sun, 08 Jun 2025 07:55:20 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5324520e7sm7345817f8f.84.2025.06.08.07.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 07:55:20 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH 6.12.y 1/2] Kunit to check the longest symbol length
Date: Sun,  8 Jun 2025 16:54:49 +0200
Message-Id: <20250608145450.7024-2-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250608145450.7024-1-sergio.collado@gmail.com>
References: <20250608145450.7024-1-sergio.collado@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit c104c16073b7 ("Kunit to check the longest symbol length") upstream

The longest length of a symbol (KSYM_NAME_LEN) was increased to 512
in the reference [1]. This patch adds kunit test suite to check the longest
symbol length. These tests verify that the longest symbol length defined
is supported.

This test can also help other efforts for longer symbol length,
like [2].

The test suite defines one symbol with the longest possible length.

The first test verify that functions with names of the created
symbol, can be called or not.

The second test, verify that the symbols are created (or
not) in the kernel symbol table.

[1] https://lore.kernel.org/lkml/20220802015052.10452-6-ojeda@kernel.org/
[2] https://lore.kernel.org/lkml/20240605032120.3179157-1-song@kernel.org/

Link: https://lore.kernel.org/r/20250302221518.76874-1-sergio.collado@gmail.com
Tested-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Rae Moar <rmoar@google.com>
Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
Link: https://github.com/Rust-for-Linux/linux/issues/504
Acked-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 arch/x86/tools/insn_decoder_test.c |  3 +-
 lib/Kconfig.debug                  |  9 ++++
 lib/Makefile                       |  2 +
 lib/longest_symbol_kunit.c         | 82 ++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 lib/longest_symbol_kunit.c

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 472540aeabc2..6c2986d2ad11 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -10,6 +10,7 @@
 #include <assert.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <linux/kallsyms.h>
 
 #define unlikely(cond) (cond)
 
@@ -106,7 +107,7 @@ static void parse_args(int argc, char **argv)
 	}
 }
 
-#define BUFSIZE 256
+#define BUFSIZE (256 + KSYM_NAME_LEN)
 
 int main(int argc, char **argv)
 {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e48375fe5a50..b1d7c427bbe3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2807,6 +2807,15 @@ config FORTIFY_KUNIT_TEST
 	  by the str*() and mem*() family of functions. For testing runtime
 	  traps of FORTIFY_SOURCE, see LKDTM's "FORTIFY_*" tests.
 
+config LONGEST_SYM_KUNIT_TEST
+	tristate "Test the longest symbol possible" if !KUNIT_ALL_TESTS
+	depends on KUNIT && KPROBES
+	default KUNIT_ALL_TESTS
+	help
+	  Tests the longest symbol possible
+
+	  If unsure, say N.
+
 config HW_BREAKPOINT_KUNIT_TEST
 	bool "Test hw_breakpoint constraints accounting" if !KUNIT_ALL_TESTS
 	depends on HAVE_HW_BREAKPOINT
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..fc878e716825 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -389,6 +389,8 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
+obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
+CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/longest_symbol_kunit.c b/lib/longest_symbol_kunit.c
new file mode 100644
index 000000000000..e3c28ff1807f
--- /dev/null
+++ b/lib/longest_symbol_kunit.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test the longest symbol length. Execute with:
+ *  ./tools/testing/kunit/kunit.py run longest-symbol
+ *  --arch=x86_64 --kconfig_add CONFIG_KPROBES=y --kconfig_add CONFIG_MODULES=y
+ *  --kconfig_add CONFIG_RETPOLINE=n --kconfig_add CONFIG_CFI_CLANG=n
+ *  --kconfig_add CONFIG_MITIGATION_RETPOLINE=n
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <kunit/test.h>
+#include <linux/stringify.h>
+#include <linux/kprobes.h>
+#include <linux/kallsyms.h>
+
+#define DI(name) s##name##name
+#define DDI(name) DI(n##name##name)
+#define DDDI(name) DDI(n##name##name)
+#define DDDDI(name) DDDI(n##name##name)
+#define DDDDDI(name) DDDDI(n##name##name)
+
+/*Generate a symbol whose name length is 511 */
+#define LONGEST_SYM_NAME  DDDDDI(g1h2i3j4k5l6m7n)
+
+#define RETURN_LONGEST_SYM 0xAAAAA
+
+noinline int LONGEST_SYM_NAME(void);
+noinline int LONGEST_SYM_NAME(void)
+{
+	return RETURN_LONGEST_SYM;
+}
+
+_Static_assert(sizeof(__stringify(LONGEST_SYM_NAME)) == KSYM_NAME_LEN,
+"Incorrect symbol length found. Expected KSYM_NAME_LEN: "
+__stringify(KSYM_NAME_LEN) ", but found: "
+__stringify(sizeof(LONGEST_SYM_NAME)));
+
+static void test_longest_symbol(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM, LONGEST_SYM_NAME());
+};
+
+static void test_longest_symbol_kallsyms(struct kunit *test)
+{
+	unsigned long (*kallsyms_lookup_name)(const char *name);
+	static int (*longest_sym)(void);
+
+	struct kprobe kp = {
+		.symbol_name = "kallsyms_lookup_name",
+	};
+
+	if (register_kprobe(&kp) < 0) {
+		pr_info("%s: kprobe not registered", __func__);
+		KUNIT_FAIL(test, "test_longest_symbol kallsyms: kprobe not registered\n");
+		return;
+	}
+
+	kunit_warn(test, "test_longest_symbol kallsyms: kprobe registered\n");
+	kallsyms_lookup_name = (unsigned long (*)(const char *name))kp.addr;
+	unregister_kprobe(&kp);
+
+	longest_sym =
+		(void *) kallsyms_lookup_name(__stringify(LONGEST_SYM_NAME));
+	KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM, longest_sym());
+};
+
+static struct kunit_case longest_symbol_test_cases[] = {
+	KUNIT_CASE(test_longest_symbol),
+	KUNIT_CASE(test_longest_symbol_kallsyms),
+	{}
+};
+
+static struct kunit_suite longest_symbol_test_suite = {
+	.name = "longest-symbol",
+	.test_cases = longest_symbol_test_cases,
+};
+kunit_test_suite(longest_symbol_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Test the longest symbol length");
+MODULE_AUTHOR("Sergio González Collado");
-- 
2.39.2



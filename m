Return-Path: <stable+bounces-158433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF58DAE6D23
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 18:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F52163755
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4142989AC;
	Tue, 24 Jun 2025 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdZBXxGb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622231DE3A8
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784357; cv=none; b=hOPJEtNFyl009mkuI0AHa2NYKdSRzWhBxbo3L9ubwAzDNs43xr5GuAMzCdZucZ6mREWNG7QNgMJN9yw7SzjCffa0SwzamFRuzfGbUqneX1ArUborcxHhTR6PQF/VMOk0VKjjbaJ9iO0tgDO1qngKGG9qRj9Ol4j8gT/HJBFku2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784357; c=relaxed/simple;
	bh=TiWuYd9O7f5/lO50/hwBI1QK+v24F8D/PcT3HOo2N7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AbnqfjkiHHnfTweokXH5fCnfnjipnvQ84Sb51K6QJCjUAxqTtTK290UtTy9h5dudBh7zqJpi1aStf+d2Lee06sNP/9GmmivFBaLiAl0XXG7bhbXwnURoD3civQfY0lB9z9C+G6ewmdc7TdafYGLOkHMDw0ewwbl2tnZ8tQ33gCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdZBXxGb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so52322185e9.3
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750784352; x=1751389152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDQWDda0DWcevM254v69i/LknVORQkO+iWKN3X/jDXM=;
        b=LdZBXxGbDii0qsWj3Ar/0FLSFbsT6l2XKOWb/IXGZX+ykjHa17vIPzINHV413q93LC
         pqvpnkeyNtpAv6lZO4USq7W//AyKa3Ivs+5GEx4BkI/R5IEIJQD2z7Rcyn1gUkXeqD9G
         Dli4cL2kjWwoDrK3VSDLIwYk7JjF7Wq0haXDkEHX2cJiLjiveFjwyUXV4z7TUWb2/LJQ
         S6NRt2Djl7r56Jm6SRagVWatTBeMVPIVN8/+MSgQfPkrjDOYXtJb4736+tAmx8wbNYvj
         uSXeMPLnFfBsg7L87xaAS0CUb9+6XSkllAK/UmgJ9M8I8x49uPTd6uDFSe7c85+OTIjd
         ldIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750784352; x=1751389152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDQWDda0DWcevM254v69i/LknVORQkO+iWKN3X/jDXM=;
        b=RWc9hbCWQ3791dd9qj4KPF6EgoE9+AP/6vMooLJNyCuXzw5TZB/R2ID01jvKp88iPO
         O/PO/U7V+v4U8HAgqNKbeb+047KN+pAGbP3CjIEXiakZ55LcV3W9karmlaxxJQbrHyfh
         TEoTmwElKG2RlRF0bTtEVHJZ4nZuM6yrVyVrBRVY0efWMWTvvxOvDvzk0lpQ5HXIgai6
         Ke1wOKog/eOAAUbyr+7X4hVjqeNWKLXhRb3O3D3cHCY3AI+bpSWzz+imDFKH1lhpvrCc
         c/fLQc/Odg1frdiIGsmfl+B6oRY8rXW7w2vHSkKtfVpMR3Jm/+AbtYl+w4O7lvpDH6vb
         yaqw==
X-Gm-Message-State: AOJu0Yx/lTyqkZm7S8aS5w6e1vesbwZpnd3L1uPbBuDu2DYTm4wWW3tf
	wA+5TMx1fGSywqTwkTADgsHSS1O54/FpI+LmEpT+gEr97l7Oi/5FN75glQOR7FbN
X-Gm-Gg: ASbGncs5I25jzW/VB+2ol0l6h74ErzgyQT3j4LfYl0zhhyHfsePeOb3FTNKGf8Vhr+p
	1IykI/GEnBGtHMOM0bSYgLa+vULCCRaEdXeoZ0Uw2vUwbbnzw6op/fvWu1pB9Y7zVpbGNPLZuSd
	mWBF7Vq9hGP1ZBr0LYq4yZewXusoh0ykMZCPja8A0Fda7Cm00oVdMm98tl26Gas9fOegO9ZUNyj
	WKIRmutBdO2wr4XNnv8DTyIvnHW6OXxriDtBSgfBU+abE0o9YYElwpuqgn+/cZQgmCB9ei1dHoS
	z8iT8QGuxp9wZ6dSGc6LgAQD8BEJ+AYRHzVMaaVBgKmYmXl4HUWRK+mZ2xF4sc4LZaJaN8XTvfZ
	tkNXxYScDi2lwEq0d9unmL6t2MuXm28LR3V7o
X-Google-Smtp-Source: AGHT+IFJ/ZvGKnDOOuLJSbAGgzNG1A430v+XXb14Z6s5zxl7VZb3Vp84ANNHEkRF2yozLC1L98yvtg==
X-Received: by 2002:a05:600c:1ca9:b0:43d:aed:f7d0 with SMTP id 5b1f17b1804b1-453659d4325mr138797745e9.28.1750784352014;
        Tue, 24 Jun 2025 09:59:12 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebd02basm179191265e9.39.2025.06.24.09.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:59:11 -0700 (PDT)
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
Subject: [PATCH v2 6.1.y 1/2] Kunit to check the longest symbol length
Date: Tue, 24 Jun 2025 18:58:51 +0200
Message-Id: <20250624165852.7689-2-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250624165852.7689-1-sergio.collado@gmail.com>
References: <20250624165852.7689-1-sergio.collado@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit c104c16073b7fdb3e4eae18f66f4009f6b073d6f upstream.

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
Reviewed-by: Rae Moar <rmoar@google.com>
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
index e5fbae585e52..1220e8113dad 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2600,6 +2600,15 @@ config FORTIFY_KUNIT_TEST
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
index 6f1611d053e6..6ae66e13f319 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -389,6 +389,8 @@ obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
 CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
 obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
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



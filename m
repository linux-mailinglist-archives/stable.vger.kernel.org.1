Return-Path: <stable+bounces-155255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86A8AE30AC
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 18:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6685016F5D2
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009913FB1B;
	Sun, 22 Jun 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqcCqDqo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13E68F5B
	for <stable@vger.kernel.org>; Sun, 22 Jun 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750608033; cv=none; b=ShHsjSPGf8VDHZzrTvItuvc5dns4+Poxzat70vIK7Wx7KC3/RgZr4yLnCcnc7CRAuOwdUaUbYvzC4iMFLjXCTpxW7RnD1h9iD/KXxFTdV1ZXUy4WsFiLWOvi+KP/3nW5dDgrkOGHmlc4FyHdc6FsidmVkiKpJal5dKxjraVzg88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750608033; c=relaxed/simple;
	bh=TiWuYd9O7f5/lO50/hwBI1QK+v24F8D/PcT3HOo2N7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTcw5AiZ72XSUsVg6OIzW9dIARlc/Rs9XoPdgZSLXF45i3pcBLB0+stJwwmXarK9nMIKEsN3VvlOET68hJurj30lWXNYIo3M06LH17t4Q1AuxMC+E7RFA3qS268oXBAvPTMt+OtEgWwevnFjsS4m2xshBmUt5J+e2n8d/v+Uv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqcCqDqo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a588da60dfso2044189f8f.1
        for <stable@vger.kernel.org>; Sun, 22 Jun 2025 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750608030; x=1751212830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDQWDda0DWcevM254v69i/LknVORQkO+iWKN3X/jDXM=;
        b=dqcCqDqoICg+/1JwKZBQfEZEP9Zc69uRcViSgu3ny06Z5s41kUcP5HHkPHRQu1mSwv
         p0OVzqmivD9puqsAyR1/Tk6lYmnu6Hv86lgIyRskM78lJNJMoWoIilA6EmTjdS+cF0xL
         +0tCT6XIHaBeBBaIuiXUgSeiztfquTeji9jjH7s098dIh40k5DjLCNaZf1IVNORRo/lt
         ov5YeniTgpZCPLlW7oObfAXeeEIycQHumlzuozoXfocZr3HvX1MNAJk2+GXPptsaBKqT
         9Uth8uFjwZfhAkZIWEbAE/ITJtDSoDTWRlWgFJk20E49O5F7cGvDot/wzkd60qoKb5sE
         KrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750608030; x=1751212830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDQWDda0DWcevM254v69i/LknVORQkO+iWKN3X/jDXM=;
        b=qXbVtnYnOKvsVCi9OfpxFtmEsNNVdULpiwQAKpWTs2GOFm3j7cHoMKiQOrVTJEn6rF
         x1ap/XTnrISw7VAZgocKopML35XR2G7Qu14zbgNc3OBwP3GZ4orJSl8EOufAvxGRTMlG
         DaS8/hiGmsvttHTaCt+S+sfvjZRT310in3g/h1X79yO5lJ2D3rnaunv4xfo9WrVodol1
         FxAbZ6ywHrnwc4SMUVJDdB6FEFYHfH1EgNDaDTDqo3TQKf2O50a35tYkzgy6wqAYsCmW
         NhRb2mh89Kw3+hMQc6y4vJEoX7y8gXQm7RFLmQM1SqZvmF/YKO7Z5hG4WOOO2I8kNk7u
         KRxg==
X-Gm-Message-State: AOJu0Yzd4XqXl4kQSqtE3ppkTX8pounF6BqIgu5oSUCdr5EsrtKVuk+7
	42SC+hVDcdckD2ufY9LRyQk/kQ8QYmPUSzmZ/y6TP3v1SZQI0EngFoagA/PC5A4M
X-Gm-Gg: ASbGncvrO0uuXvJT041XNd1OLxFwHLY+KA7naOte4IzxYf+r5Qm6J2Nh/SNrzHEIBz0
	8ajCb0NJaWZvJP/QW6wNBGbaL5qIvfngPDTCCP3DAjFyUI0dlw1C7W/O5pUB35e/rhup8eQzvuz
	tMrNSfVAxuPlwskRtm5Q4W4X1j92e2uskOd9xaSZhmDJb9G8GSHYriMHP7tmCLIw5DVAIuFaCGY
	WuUN8PWbNI+3EbOIZFBnlEFpa7YA2ApOtYoc1y7ugSxklxKZRcdqmc4hI6J0l7Un9kpb2oXddaM
	Vflbogy3vykY7wxnlFIm8EGbCDVRcSfHJDYHG4FYyZByR42GRVAdaHWXHWk2KxUQ36krpqqzWo4
	z7hIeY3pQKft6RqYB3E6KVqVX6r75eieE7SVT
X-Google-Smtp-Source: AGHT+IGFcpe/lXRAvE1q265ZrBCznj/PWSTU9CsYRxbaMbNYdyj9Ub1Vr5AcYof19Pgs1MtI6vbBnw==
X-Received: by 2002:a05:6000:471e:b0:3a4:dfc2:bb60 with SMTP id ffacd0b85a97d-3a6d12a9a5amr5843041f8f.26.1750608029884;
        Sun, 22 Jun 2025 09:00:29 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f19b30sm7408369f8f.37.2025.06.22.09.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 09:00:29 -0700 (PDT)
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
Subject: [PATCH 6.1.y 1/2] Kunit to check the longest symbol length
Date: Sun, 22 Jun 2025 18:00:07 +0200
Message-Id: <20250622160008.22195-2-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250622160008.22195-1-sergio.collado@gmail.com>
References: <20250622160008.22195-1-sergio.collado@gmail.com>
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



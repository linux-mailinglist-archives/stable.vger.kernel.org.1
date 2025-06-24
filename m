Return-Path: <stable+bounces-158437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC56AE6D3F
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 19:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BEF16BB84
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E182822A4F0;
	Tue, 24 Jun 2025 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC8GiXZR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C96226865
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784679; cv=none; b=l84qFriJbGJxD3ZwpQrpRcW0beVMKEoTclvSYU6jJwgUyueajneytG0LOx+AkqONvMH2BERHTUtEIIVYjTpCR0LmWMlCZK89FE2N+/bxws48WnVBRQUS/ocmYKrd1JiXn9nLVd4idrtykVfyZ/uCHlrSAMQLFH613GDf/AAZB8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784679; c=relaxed/simple;
	bh=iew0vedhv19N+qUW3mp+F15XQJSlMYg7KnGbLWI2Sd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/YJ+ZK8YSBAz4zmhXfRcM23cz8ouUmK48ht8uQBJdh1EV15By9AxyBRvJ/fn6Krdfo7LVayPCaaqrYJFSUhwA1NOmxF+XEpmvIcnqOUQjvbCZq5pcGpZyY5KCFcIq1FgUyCWR2qP7SXbTn+QGh+qSGApaAq30B6aTon+UYoOSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC8GiXZR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a6e2d85705so461739f8f.0
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750784675; x=1751389475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWlR7D+9sAdPdBCx4N64K++tSn6MIGlQDTYZ231K1KY=;
        b=MC8GiXZRgiYt4IPcl+8jX4ogLwBHRUmS6MFeTaVPfVxwphk5U+WsV1aDWVMWLkDwvS
         ofvVR6az7qe3Fe+LwX9L17dU853n+7w3qm6X1DriDXD6afkmgYyxxgVIUNAeUztM04nk
         ip6DZAl8Q0h1QGYhkXi3dSrfnhJcmUH+7aN7J72JQpGCPyaHzCr+1G5lOtH/OOUK6Ega
         fNbNEzKjY3RnTJG7oSGyyZ81g1hMOjDiCoRyUXu/b1riERuBZHyox0eEfepOSSnzJNYF
         HzTrmRUiqzrrcYHYq7o1gBRO3ah7SrZqlyGpAf4HICCjpwQS6BQxoikADrn0ojQCX7tB
         WpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750784675; x=1751389475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWlR7D+9sAdPdBCx4N64K++tSn6MIGlQDTYZ231K1KY=;
        b=vOX9mC4r8DCBlpBtRT1BkfcqDXHgKC5RkMYW5XP4qElqFLEjlsnMNroo86kVYpmans
         geEmtUWIihm6VKbxi5XJuxUqijgqX/LJtAWz24D0rAWE5CTi6YgW5zCfrs/T4y4aE/Og
         RVffcFre8UGH77zNke9dQAbOqvqNAII+5CUQXRpRGW/WtkrDpAnqFpz6lZAk1Gjbms2B
         qpglDbj6sJznWOhSlm17K8EYkdHSRoFg1c719kO/1phuvGA8n2gGmNbTH8jvRhSdagr9
         Pco2PbfUvBDxrJ7KezFLiNaPDlkIp4EOr7et7nHqD9hVaCxgaUdnuj9faLrSN0NiquMc
         dCWw==
X-Gm-Message-State: AOJu0YzvffEa/YaK8sPnXdLhgDdcgqj0q3O08oWPTPju0JfiiVkHyZJe
	6K2OW82nQnQGeE7tFmw8IQF2KBlTlp/xCiMLsWQw1h9lfdb1FBshYvETZ1QYIMiO
X-Gm-Gg: ASbGnctk7utK3kZH8HShgnymFvs64Cu1ZuCfTLWk+LiNGdtmDEhMu561dMAL7x/B2Pk
	IP6l0bNs01XcqKo1bJO35y0MjyAv6lZIdfDdWvPNhoRrRXfGuJ4XZD4zVNHVByrrwve8YXgU9BR
	AnaQt2JmAH0+czgV7PW3McjcC1winmav+u78yCIIlaVPcYMfWYtDGhj3AlPq8Vk9tO9xE8bEyu1
	EVgjXnfvzXpzACEsqB/Ya2oCo7b6F1c8JCseyo7pDHuFT58rE9jaxGI7vxW1zxOx3RA+ggRvDgq
	eRc6/GziOdExSwYJ/1G1DMpGJwbOYAhmC+JW0BXfxL5S6BtHaoOkB0dbEs4J0hTJXtBlKeXBQRF
	osVpKCn23J1HLdebRgz5+K76poRNAiwi7+7dE
X-Google-Smtp-Source: AGHT+IElV1g5JEfRiKfrYWtX23wV78mUmmaE6iokVdeJmdscQI8HMTJLvEzjUdR49MG/QdQJmAE6BQ==
X-Received: by 2002:a05:6000:1a8e:b0:3a4:e4ee:4ca9 with SMTP id ffacd0b85a97d-3a6ec4991d8mr556277f8f.23.1750784674495;
        Tue, 24 Jun 2025 10:04:34 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8069d78sm2386276f8f.45.2025.06.24.10.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 10:04:34 -0700 (PDT)
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
Subject: [PATCH v2 6.6.y 1/2] Kunit to check the longest symbol length
Date: Tue, 24 Jun 2025 19:04:12 +0200
Message-Id: <20250624170413.9314-2-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250624170413.9314-1-sergio.collado@gmail.com>
References: <20250624170413.9314-1-sergio.collado@gmail.com>
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
index e809b6d8bc53..1aae81c57b2c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2747,6 +2747,15 @@ config FORTIFY_KUNIT_TEST
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
index 740109b6e2c8..b9d2577fbbe1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -402,6 +402,8 @@ obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_STRCAT_KUNIT_TEST) += strcat_kunit.o
 obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
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



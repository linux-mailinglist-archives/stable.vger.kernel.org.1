Return-Path: <stable+bounces-41783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DC78B6709
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 02:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF24282814
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 00:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8B2205E30;
	Tue, 30 Apr 2024 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GaYb4yUX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660A83232
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714438168; cv=none; b=fMgyh/43GwptsjyDJslRYUMEITHeUmN3hM4nu9w0AJmWpxMAnxyMPnRNydGdR7fozvLGmBL8vmHFRkkvxrLrGJqPpkgjZhUDq0GQLO8WdqJbdwOsncbFbj52zdVP2h8xm8HacPLftyQQoZbdDyADcdCKhhhiqdw3lomgimHNvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714438168; c=relaxed/simple;
	bh=CQZ+rutb34tlCcqKjJD9BEd+5QtdQSwRC5IuvL3355o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RRW+HL6cphVSZnKJGq4ZQ8rZp4pcZDQomV7yRxlmYF3jAT4TWwuFn3AAnUlciiNBP1whTHRJkPDYHNgwdOVyfgGlM8ehUpM3Sf1G+6ty0RuY6OSooIiqxX11DHew96/gjScd871C1wcZTTAzpSVZb6NmoeuWGC3K9yFtCI01IpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GaYb4yUX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bea0c36bbso3898727b3.2
        for <stable@vger.kernel.org>; Mon, 29 Apr 2024 17:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714438164; x=1715042964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o1ppiacHBGt4deDldEbdpGFMwipyVa+kEjFesHxd+4M=;
        b=GaYb4yUXbCmmbmZV6ysZZs3f85p6iLWfuWgI9fS5K2ZeZmCp4PxqsgegMZtVKPTZW+
         Yp87VNUXr2ekbURwSsyjeAYb0fxIDLY0jiOLbNjH8dPRFZ/WTKGF6/3I5Q/2xWeTYSXb
         EXQvwPHeIKgoqx4ADeEaf9NuFygAycrodBhZQ8Na55etqhDBb+tH7Ib7G67yct/saZUW
         Jytl5bsyBo1I+W8m5b/9LL0HTY74A9Xc6GwRT24tvpK3Sf+jgdbXzP3FjJkqwBhjw2vr
         29o6eQlK2J5ZXkejW4ZPAPu0zFcZbTOVoLGN+eDa1fL1r6VvEqHYsUfVTAUQcoUdh26u
         QdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714438164; x=1715042964;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1ppiacHBGt4deDldEbdpGFMwipyVa+kEjFesHxd+4M=;
        b=T16GP0/Ea2N2zQsOGqSLqCW5Gx3tDJBdTeWpyKNGYHG6ItzGIJUT7dwshfpsBZVHPa
         wibwt92caw6NTmY3SQ1XVBLEo3hZf3/kluKx85PDam5HxF9Tc6+b8W56yoNoMbXGHL6M
         Wg9uNuKAQQy2VGSccrcR5ymCG2vzfh3NKaeB1eErETSdosgDuzoPfLHJFJxsQ6wa4JV/
         pqZ1+gLQhvxAH+nq52QdJxyz7oEem29R/TxWmZX15TAtIe1H1tH4U8r3oS1Zhag1ZjTU
         ePA6D2jO2OFbh12Y6hFqm9n81ColrUHczSv3PeCTbPzbnIo3C/XjrAHNbBr/lFlS4KB5
         QwIA==
X-Gm-Message-State: AOJu0YwTntYOZQqAVgHhA9wL9Jt5Rt1cX+GA94NgcwXZ8hjfmdpLlVh3
	hcZzVvH2m8u3kr4K3nv8QAyO31pfOPXgq8c2A09JXO09Txvn1ZTEhm0BCotEmsDykJtr4YrF0ct
	uMUZjnZ5i6/Ju04M5pDZONfzxjxr6Y2zIgMEKRP1jMA48xJeSHgY9OzcU3U1m9gvHigDwL+tSg9
	r6VjdtiMN7fo3U7Ke27hhZY/MKlva5lRzJ
X-Google-Smtp-Source: AGHT+IENnLlqrYtXCXtylGWiSBp8/4kI2FR3F2c3tGK00X6zJWwQq7PGDw9yYT+bwAFRgrPuE9Ry+c7gJvM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:20ca:b0:dc6:d233:ffdd with SMTP id
 dj10-20020a05690220ca00b00dc6d233ffddmr4176106ybb.0.1714438164494; Mon, 29
 Apr 2024 17:49:24 -0700 (PDT)
Date: Tue, 30 Apr 2024 00:49:08 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240430004909.425336-1-edliaw@google.com>
Subject: [PATCH] kselftest: Add a ksft_perror() helper
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc: kernel-team@android.com, Mark Brown <broonie@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Edward Liaw <edliaw@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 907f33028871fa7c9a3db1efd467b78ef82cce20 ]

The standard library perror() function provides a convenient way to print
an error message based on the current errno but this doesn't play nicely
with KTAP output. Provide a helper which does an equivalent thing in a KTAP
compatible format.

nolibc doesn't have a strerror() and adding the table of strings required
doesn't seem like a good fit for what it's trying to do so when we're using
that only print the errno.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Stable-dep-of: 071af0c9e582 ("selftests: timers: Convert posix_timers test to generate KTAP output")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/kselftest.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index e8eecbc83a60..ad7b97e16f37 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -48,6 +48,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <string.h>
 #include <stdio.h>
 #include <sys/utsname.h>
 #endif
@@ -156,6 +157,19 @@ static inline void ksft_print_msg(const char *msg, ...)
 	va_end(args);
 }
 
+static inline void ksft_perror(const char *msg)
+{
+#ifndef NOLIBC
+	ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
+#else
+	/*
+	 * nolibc doesn't provide strerror() and it seems
+	 * inappropriate to add one, just print the errno.
+	 */
+	ksft_print_msg("%s: %d)\n", msg, errno);
+#endif
+}
+
 static inline void ksft_test_result_pass(const char *msg, ...)
 {
 	int saved_errno = errno;
-- 
2.44.0.769.g3c40516874-goog



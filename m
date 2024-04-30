Return-Path: <stable+bounces-41785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2E78B6727
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 03:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061731C22191
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 01:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34641C33;
	Tue, 30 Apr 2024 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pIUnrvPu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340E11843
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439194; cv=none; b=b7u2qFc2N5QljBdlXCB+jcyacZcSUx3QVZAIrGqJLfng0gmxKcJnhM9vSSCXhJx4jzvqOjUR6nLeP4WP1V/wz613fczarb8Q7ur72QW6S4//1CwECp9vZboBm7VEM5CREvUy8j0q6gGtirjQwu7VUi03bLBr5t8oHdCbNJMva0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439194; c=relaxed/simple;
	bh=CQZ+rutb34tlCcqKjJD9BEd+5QtdQSwRC5IuvL3355o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jdUxGCP3Y3SxZsd9IuIocicdGHa05Jghr76pUDvKDVPa8FfxWEcf+UuK/V8CUMKTC1o0qWXYh4ayg4fsDvzQQbe7LSLNYLDT/pKfZ5pI6CPhRddkNc0m7AZMRLKupRzUxX6frv2xFx7rC9zAIaK0rgqTWJc1SB7JQ3LmLz+4PsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pIUnrvPu; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cdfd47de98so5243204a12.1
        for <stable@vger.kernel.org>; Mon, 29 Apr 2024 18:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714439192; x=1715043992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o1ppiacHBGt4deDldEbdpGFMwipyVa+kEjFesHxd+4M=;
        b=pIUnrvPu19HKo6KofwgjMrtkwNpbkF3GtTZC7LSI0Om2iqrAKRwaSaKeS6iw3h9UMV
         ZdMho5vD2PhzadZJAxpE6ayXw1XlXLRsMNaxMSlGjHUfExHrEeg2fHjwScmIDonSCXH5
         uhEydjFRqeuauhJZV2SZWAPL+tLh/TDI3sj8Oe0fbCy+wN5eQeciKbcvhhLBX20/q8Fz
         OGa03/tm23pzRyVtNSL2kJtBf5nReYZMmgMw5j5TZZbGKEwaMYS6Lb2SIW+JIWjT/TzY
         zNkIIM1KBvItOnmFkiYt64OsREUPs9D9bXObKwV394b6NiRULc5/huPoCimnwff1BUUv
         eTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714439192; x=1715043992;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1ppiacHBGt4deDldEbdpGFMwipyVa+kEjFesHxd+4M=;
        b=mwDEvhrbQVfuRbjEjFs0W0DJnAdFLv/0xkgiAV7rRbPIjZ7Zm+O+zKufOxnLM5P1y5
         hh4frbk3UTHnu9iNNM/6Zi7hmOT4H13aBlVJBz++66+ssRasiVqGkxT0XBofan4gUhOF
         Zahoqm8Cl0hacRl5Sb2Tw5Ig8IhtPq7G5+XmUpiT7cgrSoWz2FFuNgQUaRIKuYGwdwEX
         YHl36fKUkYDxcZoFVys9a+uUEl5IHSNd8toEStQmkHFIsqMcBwI+XFd5zwEnN1apVM0z
         2t9fq7TIoqLj81xzNiwUbqXYs0juW70ouzfU8ri77b9JhdpfdbGw8Xmq81/QHkmDWJ4r
         LMwA==
X-Gm-Message-State: AOJu0YzO7lpbUKfL7JuWhngAA08obBaS8sn2Mhwn55AbU2okSdGYM+se
	5CGBcl7ikK4Wl7F4Os6UpZA7xjpOPdtnE6C+PppD3S2jiR6uZhzv/RXQvhDXbBIczQPAbosKY/U
	3IBITBUmeNwO2DjV7S90t+hloMpvPv7kVTLGRFoutVtPlHrYCgrqm52NzHO9/pDsS/gbbvIkU6A
	v3l1qib23e92KaYHyP/VHUcAYHyC2ra6xO
X-Google-Smtp-Source: AGHT+IH3du7DU4SSas1waSsGTfaKPkaIxmUOV3AAlzhPD+DO0cmHY4Fhz82mZzN9VrX9rQfmrW+YUUXg57Q=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:33c4:0:b0:60a:869f:3a6c with SMTP id
 z187-20020a6333c4000000b0060a869f3a6cmr2542pgz.5.1714439191602; Mon, 29 Apr
 2024 18:06:31 -0700 (PDT)
Date: Tue, 30 Apr 2024 01:06:27 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240430010628.430427-1-edliaw@google.com>
Subject: [PATCH 6.6.y] kselftest: Add a ksft_perror() helper
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



Return-Path: <stable+bounces-126986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2ACA7538D
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 01:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B18F7A72AB
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 00:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03B17C91;
	Sat, 29 Mar 2025 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CqM6trdQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07424A0F
	for <stable@vger.kernel.org>; Sat, 29 Mar 2025 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743206633; cv=none; b=O4zAEOAhFNC3vHts0uOiV7tRdzB4VuQbxwSrOcq95hsgg3wraXcXSWjA6s4UOftzn4ytdg4dVa2yN5Q1pT/DdFob6AOV3n23RdbvCLpeNTyip8nHHQiAcVvfqPH4Zd7z3H1DNQz+s6KkuuFHy1MsqFwM8tUfX3vcjT1G09F0c8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743206633; c=relaxed/simple;
	bh=A4qOF8g/Lp0fNN70XKVNtD9pF/sKUksq0VFQkLxYtOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z1h/UVBVlY45rTZ2yDA2OwcArHh8+vg2AzyYSelUXCd4v6N3d8JMjczZ9IW+v6cWv3mrtLhMyO9UR0S4Q2jr7tN4bQfhySx40JZWMLo0KL76bzk9okgQC+LRHaE5J1aD1tmnVaSQGLS0+zsVXy4DGrUhWoevuw/1kfAM4DHavS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CqM6trdQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22410b910b0so39666695ad.2
        for <stable@vger.kernel.org>; Fri, 28 Mar 2025 17:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743206631; x=1743811431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mEgmoeCU7ZoBbD/6q07yzTwvuV9KDxvtvsClWJ9QuF8=;
        b=CqM6trdQnGyRuGojGezqW97vHKKPBba0YFXnxkJYUjR5WqFZ+srqQE/JxKuUcrK1zP
         epGyEB5E/IvmhgFwRBI2siYtJ+9TpAc0LvKD3TUdQMB1lsRs0o/H5vMU9RvMw05WVbFP
         PDBPYUTokovsDljKlToIbpQl5uCL/XAmwpkxibZ9JZi8Vristc4qGncD3ffkFnQt7/Gg
         6Gj/ge9MlbXnOw62liHAG6yavJcuJEQ8ek3eitT2Ym/4+fNkLctPutd3WvTpeGAZVmGX
         A/P++a8ym79yEDclEgWtyjaD7XOF84i3KRdjStdb21hrbdrD8gdxxxMnFwMG6UEiZ4Kh
         ucww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743206631; x=1743811431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEgmoeCU7ZoBbD/6q07yzTwvuV9KDxvtvsClWJ9QuF8=;
        b=XtBf9Qfcs8d0/5ykqdwa0MHSHKpyxF3pk1dbfh0+FjZRURnfIoZemPP+lLMS5XzTpK
         Dd/1NtqxUt9+mmM3HMddf+wHCAqyKy87yyz2rGkuW/LrNCk9cCn8wt56OlBzwbVUd73d
         deaiLRC7VUM8gjt23GnBZ1GNisZpoGiR2B2kEVuqFHcGLUm20G3PfjDKBf5Q/EWGKmUs
         zAhtxc5tJg7wu1Ov/BzefL4xwD9aQs544c1fSRy7pPPQDgdFO2rlbpbZnRnbmKbcq0Ba
         rYRNEiPC+iF5VycDU9OUXltz3FgjUfgghCMFJRI+FkR3/JGjOz8x3TSCxLQ8Zm6La4uY
         ZbEA==
X-Forwarded-Encrypted: i=1; AJvYcCUQU+eotYemNuGVLnuWXaVvpEcigylmm8ITZmYS/sIXoy6gd7sCDORhnjBXnqVDlrRmeiylQjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY3MA4vr2RB+8Uy2cuh2jX2+EDTD2FfSKhohGNtLPEIQX2Oybg
	B9AiegnJs9mr5k2b+2/3r+8vi3QMHO0gCiv1ndf5kNJE9RPwE9jpcJLwKuB7SAOgSg==
X-Google-Smtp-Source: AGHT+IHjR6hGtSOVpUkc0nyNRot3w3fhTtOD52YS62CSenulpOThQdeL5LjrShYtAkO27skye9Y/6dw=
X-Received: from pfbmd6.prod.google.com ([2002:a05:6a00:7706:b0:739:4935:6146])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e887:b0:223:f408:c3f8
 with SMTP id d9443c01a7336-2292f960348mr16354725ad.14.1743206631260; Fri, 28
 Mar 2025 17:03:51 -0700 (PDT)
Date: Fri, 28 Mar 2025 17:03:36 -0700
In-Reply-To: <20250329000338.1031289-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250329000338.1031289-1-pcc@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250329000338.1031289-2-pcc@google.com>
Subject: [PATCH v4 1/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The call to read_word_at_a_time() in sized_strscpy() is problematic
with MTE because it may trigger a tag check fault when reading
across a tag granule (16 bytes) boundary. To make this code
MTE compatible, let's start using load_unaligned_zeropad()
on architectures where it is available (i.e. architectures that
define CONFIG_DCACHE_WORD_ACCESS). Because load_unaligned_zeropad()
takes care of page boundaries as well as tag granule boundaries,
also disable the code preventing crossing page boundaries when using
load_unaligned_zeropad().

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4bf98ada827fdf755548
Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
Cc: stable@vger.kernel.org
---
v2:
- new approach

 lib/string.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index eb4486ed40d25..b632c71df1a50 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -119,6 +119,7 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
 		return -E2BIG;
 
+#ifndef CONFIG_DCACHE_WORD_ACCESS
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 	/*
 	 * If src is unaligned, don't cross a page boundary,
@@ -133,12 +134,14 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 	/* If src or dest is unaligned, don't do word-at-a-time. */
 	if (((long) dest | (long) src) & (sizeof(long) - 1))
 		max = 0;
+#endif
 #endif
 
 	/*
-	 * read_word_at_a_time() below may read uninitialized bytes after the
-	 * trailing zero and use them in comparisons. Disable this optimization
-	 * under KMSAN to prevent false positive reports.
+	 * load_unaligned_zeropad() or read_word_at_a_time() below may read
+	 * uninitialized bytes after the trailing zero and use them in
+	 * comparisons. Disable this optimization under KMSAN to prevent
+	 * false positive reports.
 	 */
 	if (IS_ENABLED(CONFIG_KMSAN))
 		max = 0;
@@ -146,7 +149,11 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 	while (max >= sizeof(unsigned long)) {
 		unsigned long c, data;
 
+#ifdef CONFIG_DCACHE_WORD_ACCESS
+		c = load_unaligned_zeropad(src+res);
+#else
 		c = read_word_at_a_time(src+res);
+#endif
 		if (has_zero(c, &data, &constants)) {
 			data = prep_zero_mask(c, data, &constants);
 			data = create_zero_mask(data);
-- 
2.49.0.472.ge94155a9ec-goog



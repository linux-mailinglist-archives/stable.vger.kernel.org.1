Return-Path: <stable+bounces-121525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A41A577A9
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 03:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEAA1897E37
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 02:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA19646426;
	Sat,  8 Mar 2025 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0PFhym6"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB4084D34
	for <stable@vger.kernel.org>; Sat,  8 Mar 2025 02:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741401200; cv=none; b=SLLIFfrcT9/pM65GPcS321YVjkAl1tGUkL8yykaECSbY/KIMuqJTh4pIwpcbxVqzmP6Am65LRQF2+0tPI8tM7c4Y4i/BvTTCnwmOykK1u77JKnL6mQR5W4mT0ajO7eM+UKyi6XEbcVxOJzzNlfQC1rwmZt+F/OShXZf2hpJ5lcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741401200; c=relaxed/simple;
	bh=8y7jXNcb6ARWEXok82aZRH5T5isSwP8i7PMYGI1wjuI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KWGeH88gLi5w3W5NBi0KIww21iOJsIy9tHIBtwjNJBAOCuWf289ia6NEiq8GIR0hbNPDTsAXKMnq65oZnz5L1o01vY5vCo9NulEYDOmjC1/n/bk3esB0nqtm7bIuasKqc85rGPdKpPgCNDpp2Ergzrk7JpNlJ5eRSkW/D3XmlUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0PFhym6; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-5fce04707a2so856033eaf.3
        for <stable@vger.kernel.org>; Fri, 07 Mar 2025 18:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741401197; x=1742005997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jKzjjHkyghJxAnuAXwC3PWRJfez3LkNv1m9ZaRZ16eg=;
        b=k0PFhym6QKycn58ms3PcuKzU7mFgWoQakPp97JPvFg7L27Cc71YeteHgTaTZZaMlnJ
         ogd3lgesN/Dr84dReNV7LCtztys27zpM1ZEg7Hm7KRMF3OZfZrj4vt/mt/uv8cOK+W/1
         sUH6gukIFwTe9ddB0ik2DoaH0VftCFTA4RbJSMqK/D9ROb0EJ1v/c1cC66LdIYpeX/I6
         UDm6hcQPo18bW9XLQVGIrBWhVmSLkhbUw1IXoHVyWUYlR0+aHMCsJNx6TWQ+oU92JJrG
         A1evKqbcjClZZ541zWLBbHkTtuzdlcC1g+XH+LQbrbgNh36Lit7QcEJKKuv4hF1b4KpG
         Yv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741401197; x=1742005997;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKzjjHkyghJxAnuAXwC3PWRJfez3LkNv1m9ZaRZ16eg=;
        b=hYqeJgCysYswyEZCBbMbtxlcwAAi8MqI41+xIC4O93qhOcU5nqy2FgHl2k7Hj7Tbb3
         Kt9Bu5Q/kJ/8s7kKCu7zZNHYdRMQ5LRXg4y/tJhWAO6eGpmUYc2GbjzXjFC+5ksqMh3y
         3DIhf6Olay8D9pgIDifCZeEndgRjntjku/RwlkAjdb41Daqm6nwh0YFmHZVa9cKMzqQ9
         ZLYMSRk1kvMfIXlwg/lqDnSm2kmLgDkTsukxlu3YTaxrIpLTeyexvwzSHnCjgJpm28B4
         ccariui+1lFOyZq1dTqta2hKxftfvGcWDHni5DW6sAV+Jp5Ymy6ucg+CzQtDEAN0Ul2I
         gVBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKhGaxEjAmvQjDk+IK/vaAb5Y4LoIesiS9yU2EmZC+JDCyc7XxLL0Zug0zFdZq5Jak6xMIqHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTDsbCHD22oIMghmMIXpVJMJcN0own595nfp5jkTp93LInREyo
	Pyj+z4nozb9W/9Mfk7Jn21DvDESo0mTeBdK7pjUiMsLzvrTKJ1Qd3/TLJ9UvcvxinQ==
X-Google-Smtp-Source: AGHT+IFFZMokntAqkxOEmyT2cvJ9U4fSWph4TCXA8wvZ1kT5cN4sra8A6sENMM+l+kubdYKyBOP+ETg=
X-Received: from oabnw7.prod.google.com ([2002:a05:6870:bb07:b0:2c1:c983:48c1])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:264e:b0:727:345d:3b7b
 with SMTP id 46e09a7af769-72a37b41aafmr3231129a34.5.1741401197125; Fri, 07
 Mar 2025 18:33:17 -0800 (PST)
Date: Fri,  7 Mar 2025 18:33:13 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308023314.3981455-1-pcc@google.com>
Subject: [PATCH] string: Disable read_word_at_a_time() optimizations if kernel
 MTE is enabled
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The optimized strscpy() and dentry_string_cmp() routines will read 8
unaligned bytes at a time via the function read_word_at_a_time(), but
this is incompatible with MTE which will fault on a partially invalid
read. The attributes on read_word_at_a_time() that disable KASAN are
invisible to the CPU so they have no effect on MTE. Let's fix the
bug for now by disabling the optimizations if the kernel is built
with HW tag-based KASAN and consider improvements for followup changes.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4bf98ada827fdf755548
Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
Cc: stable@vger.kernel.org
---
 fs/dcache.c  | 2 +-
 lib/string.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index e3634916ffb93..71f0830ac5e69 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -223,7 +223,7 @@ fs_initcall(init_fs_dcache_sysctls);
  * Compare 2 name strings, return 0 if they match, otherwise non-zero.
  * The strings are both count bytes long, and count is non-zero.
  */
-#ifdef CONFIG_DCACHE_WORD_ACCESS
+#if defined(CONFIG_DCACHE_WORD_ACCESS) && !defined(CONFIG_KASAN_HW_TAGS)
 
 #include <asm/word-at-a-time.h>
 /*
diff --git a/lib/string.c b/lib/string.c
index eb4486ed40d25..9a43a3824d0d7 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -119,7 +119,8 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
 		return -E2BIG;
 
-#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && \
+	!defined(CONFIG_KASAN_HW_TAGS)
 	/*
 	 * If src is unaligned, don't cross a page boundary,
 	 * since we don't know if the next page is mapped.
-- 
2.49.0.rc0.332.g42c0ae87b1-goog



Return-Path: <stable+bounces-127464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73571A7993C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 02:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C35B170BFA
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 00:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8F5746E;
	Thu,  3 Apr 2025 00:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eem3MP+g"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAABA927
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 00:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743638921; cv=none; b=F6G8e7BiQnCdMHeEIs7JbzLpz1vuPje7u1Eotm6htddUQkkV1R765iI/fwd0+Mkv0cZV8OerJokvvXkrhdhUHMfIYXmbanwmqDkYyaOsJmuuojYvZk6hpYvQfgUuMQiPwk8gjYfFKmsnTU0iuzZU2mgutflyGz6ecbPU3z0N3Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743638921; c=relaxed/simple;
	bh=A4qOF8g/Lp0fNN70XKVNtD9pF/sKUksq0VFQkLxYtOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YR+D7PGCCczOGk8iUPlxoR5eUk5ZQElHLNwBJchD0ttmUjINKyKExVmre33NrDgrIR8Tu3DaACtIvOxBZdGyfAQTHDtmlhDm0iOEdeBK6l9KU9dQIhfgTN0VGt/Say4IChiG7img0Qgtf+IKhxBF4h8koaYlLvmjF1k5k2Enmqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eem3MP+g; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso434678a91.2
        for <stable@vger.kernel.org>; Wed, 02 Apr 2025 17:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743638919; x=1744243719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mEgmoeCU7ZoBbD/6q07yzTwvuV9KDxvtvsClWJ9QuF8=;
        b=Eem3MP+g4EtVriA43tI3xztih2frs8m0SDRAT+ey1GJCq69R56WsoDNa7zniFZMVvy
         KTWeByMWvOGbbcc/exEJD6vt5bEyvx+8l0TyGdt9/q+2jT1wPzqbPFj7d2oRPAUHs3De
         gilDD7Lv+QRNJnXKCVQSV94JHof+SU2XzOUWNxrzRVOty4X7PvMGUgX4KrzQS7rmXfFj
         poBBJRSPDN/EaDlPEKUYbrUAkM7eWdtKhVyg8avnPA5PnkR4lTMGW2EAG6qfZQiRrk2f
         CTcTTbP4jlFTycgG+uT2L4x0msLPH39IbNqgV2YUK5MDiWochrxuJfxa7hDFFKBgT08Q
         urQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743638919; x=1744243719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEgmoeCU7ZoBbD/6q07yzTwvuV9KDxvtvsClWJ9QuF8=;
        b=Xxoggoid2YjGX1XMpQiwFj6k8JVDpLvsEVbpJXtGFPtUbMF4Kj+Z9SBGX65y0zxXou
         g7zvnr027PCpTYDalSlKMNI4TuWleWbCPMhqLv+aE1xzNuIVIPe+Askt3yZsMm38WL/g
         19gpDD/qF5JGgXxuXSjxroiZOqAGKHJlMg4X/xAF+KmeW4PgdPSjk7JnQ+I31OIS9vWR
         w2FlH49078hvnBbbpvIr4p6vUNcAcvJv+/9gKzE1AIL+3JeQ1uv4D6nO5NiVT0ekdJVj
         /X71SsqdJ5ZuSlvHtXGeac3gTyOWnU/H/GFfd36EEiCmQKyK17jqWqs0Knf+woVuLXny
         ShvQ==
X-Forwarded-Encrypted: i=1; AJvYcCViR6zitVoLlC7OS9209SxZFmE5K0VPNbjnMGqpS0/HVfxacNR5Mcr9fsIgoQCUsF28ov7wHuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBhlwnX1dXPXo/FHs3lYa2oYfeDpTwhAQsOHFuJC5CewKzY1+
	W5Km8RhTy63ZceM9trcbevXISoWHzrXqoej2VQiIw8fyJSi99CaTT0W1tYzBNbQb9w==
X-Google-Smtp-Source: AGHT+IEn+KDt633hxPIy/Xv0o5YX2H1GlYC0LI3Wy6iiMYKkwRX/0697A1IGauH6w3mSOoDfNBnB/3U=
X-Received: from pjbsu16.prod.google.com ([2002:a17:90b:5350:b0:2ea:9d23:79a0])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5241:b0:2ff:58a4:9db5
 with SMTP id 98e67ed59e1d1-3056ef46f92mr5028152a91.30.1743638918950; Wed, 02
 Apr 2025 17:08:38 -0700 (PDT)
Date: Wed,  2 Apr 2025 17:06:59 -0700
In-Reply-To: <20250403000703.2584581-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250403000703.2584581-1-pcc@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250403000703.2584581-2-pcc@google.com>
Subject: [PATCH v5 1/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
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



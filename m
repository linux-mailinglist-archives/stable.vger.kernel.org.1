Return-Path: <stable+bounces-125987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0D1A6E81D
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 02:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5CBE171B68
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 01:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0808616EB4C;
	Tue, 25 Mar 2025 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FkjewmG+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F20131E49
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742867785; cv=none; b=mBXfxPuwO0l67BqW6IEZwbG7Ix0mDsCPAJfLJIAGGy5Ewe7N/KYVJy+psZv//B43hcy+wvqtoMy7ruZ0is05qjve87USMyPFIXdwCP8JKZoFqaI9PnZb3mapcNZP+IIdNl3a2IILrMUmLUPaTqOUvPJ+VfZgazumX6N8XxBNcDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742867785; c=relaxed/simple;
	bh=48tNNYVxNbJIhapHHVTjKQnmA5ByjfhX/glfPRAKIhc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d20iNE2DXEH8bOjry7YSxP/v+fJtiHtWf+JaQjZ6bvpKvw2Ur40WWD/mDK7oLpLtlgl5c3Z5xh2m18013eCFamF5FrEp6m1/kdUaj71DtIw04nZ1006khQFyVSAadZAxW8EWxNYauZ7N5yBbJG3aRmDuX0OadhErYaNPpQ4gOy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FkjewmG+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so8393077a91.0
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 18:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742867784; x=1743472584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eTUn5qDH83alwoR8172wGnmaTD/nkQcDeotToQ/FQtU=;
        b=FkjewmG+FV+EP/1KOy41Zni1Cd5leqp1EcL7phKYW7cpCLzn++Zs/1mKxv6n5tipbN
         v6dldqrqUyTQ4n+7PVcr7ZTSnPCA38OJWYhB0kcH9grWUqi1AFYcJ/Kvvrv0JGosqNRD
         U1ezVSKfhrrIJ1G05C5QOck61+fy+ZbPZ0vSEwlSIbkG7RvHdGHmBGBEScKIyQeoAc4l
         Pofpt8FV4VBQPXA8Cmk+wsX17H1XKjhZCGYD+o0CvkIjrzvlHm2dB9bOEqBMVq9Sf30M
         6ARjGhcT6puXgBDjmL6spc0Apu15+90hynW8e973xxVIczDWlACRW8SLAFecjQO8WO9N
         vnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742867784; x=1743472584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTUn5qDH83alwoR8172wGnmaTD/nkQcDeotToQ/FQtU=;
        b=DlNID2JWuQyOKzIJogcmBl5lVqzAyKqnLM/pqJnnjiS5v9y4cONLjTI6q5cIIXxQ1J
         rETD1VBOKQBRP78+VTkRzsZ36tqdAQtqLPwBJe17i5L6S4ykTYvuIzveeid0yGHgTH0q
         90H5oI4UaMlShRcU1/Qp61dv1mOTJ2ho4xp/Q5GJbjRVwJBXaKW0VkyD1jE3h3bow5Vr
         r2Kq8bcej8j+slqbxbMgsvk/GOq63YuOzGfXr7hp6JuFx6Uu5ie0NtdxemxDfyZQ+1rg
         ddQoC9c7DIdHJdl+Rz1dmMIw13jamMaKyPVrxSetRxfvU35YZOTaGu92mJf5JtqUOHAt
         8uEg==
X-Forwarded-Encrypted: i=1; AJvYcCV5XA4CWcXiTG9iGsWtjIcA+GefhEgeMnKXOyu+WyvDG256L5XSP7No/AD/luybFptnXKn7g4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYnVfPwERr5GkaXkZEFZZbKepbXDGJFgixCYzdS83/cTiTY1dC
	qoVjI/PVeStbI9gANt9bFFKCL8w1PWop4QpEtRVNhcDtPxCgWS7wLV/ffBu4Ux2u0Q==
X-Google-Smtp-Source: AGHT+IFIvVndmJ5T1LC0v2mYgG4gIWIkXYdD4jSAqc98z2o614eIuEt5Jeeq109zoC0i0zwJ2WUV6dM=
X-Received: from pgrx8.prod.google.com ([2002:a65:4548:0:b0:af2:734a:2cfb])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:788b:b0:1f5:8179:4f47
 with SMTP id adf61e73a8af0-1fe42f557edmr27545583637.20.1742867783666; Mon, 24
 Mar 2025 18:56:23 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:56:14 -0700
In-Reply-To: <20250325015617.23455-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325015617.23455-1-pcc@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250325015617.23455-2-pcc@google.com>
Subject: [PATCH v3 1/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
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
2.49.0.395.g12beb8f557-goog



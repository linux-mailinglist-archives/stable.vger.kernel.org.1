Return-Path: <stable+bounces-214387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGPcLfAbhGmyywMAu9opvQ
	(envelope-from <stable+bounces-214387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 05:26:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64873EE879
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 05:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31DB73026148
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 04:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29F92DC344;
	Thu,  5 Feb 2026 04:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNSstRse"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3592550CD
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 04:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770265103; cv=none; b=GSgxJvFnpcTG2zwj3x72OEbFinjLiyxV4GJnG0uXP0ncoMTHPbOwjWo9huYROp0MHPLoc12xA+CTg0PLiB9nObpB44mPHuRMQu6EeZQCgEL5LJXXT7d/3YTHLWkCBirNFwVWgC9xl+QmzKo7rbPMqJD5upaeCvGl43hg+dzAKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770265103; c=relaxed/simple;
	bh=SE1wJiKFUbwmRhEJCp7iSLKdvgEcrpon2J3lDhjSELQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xp4G8hQU8qAToMjRqrqN5yG0flavnUyvBnaLiQ3rDyXgZMuPqbg/4iBxEZfd41yKt2FCkTGgyLe1bUvmWuK3Y7W1AjQfCMiisITINxT9dqtmv0N4rmdzZv/p40DU+R5KUdacNIQfKKVVYzZGxFmJkK4crKy9u6GHMQwVC2yffYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNSstRse; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a8fba3f769so1781365ad.2
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 20:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770265103; x=1770869903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmoelReQ9efimA3AVqzRHYairlBZ6Gd+e/kQdjhRrb4=;
        b=lNSstRseGd933pQvrTVtfZH0pXDyb8IxLXEshlWpLDQ9pY9rc+F16CfG1iZfF35tg+
         j+k2/Uk/new/dXj4K+cHUSBUnhb7MmDr4dKlgAVkLsdsbII2+g54Z2TlP7rwvZJvabBe
         3fXir0ua2gRb9ti6nOSVqtFs8G8g9RH+Hwg/xVv/lgKvzIwRetqHubED/r+wpj/okf2x
         dN9jYZ2gZTTT2xJxmNlUdbUkNuDCTIaiZIxgzxXeKTa5jESsf7L6+op7y8XK5PQRwpx8
         hBlbmX6BRKltGAc+ClCgbHgA8ALivJuDojqh0yfJmPg+oejBKhu9OTUBeUxg/esAii89
         V02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770265103; x=1770869903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qmoelReQ9efimA3AVqzRHYairlBZ6Gd+e/kQdjhRrb4=;
        b=NnqI+e77jOluMwnNjGoEN+W5K2A+2gMRUlIFPYt9NLBmLR6bNmchgkKnZOgyajnyrk
         u06PIIzPWdLssD/pwJ2p3lvzGRYCjh6cdsmMsPWT8/Zd/BaLgci83aBzPdFT1y+kEhTv
         /BP5GTqt1fl9bn5AmEhf0VB/8Vr+5GjW7WwgRDSdctAdzq6W7cOxCUxe6Fxu8ij/P25m
         gsid+GgEsWbGBi8UhvcTP0/MARGE/OzV0/NSqiJiiZQygBdV75w5sq/VXli8QvS60Y/t
         1ugJDwqFWoMCcFr2s7YYRaBz3FdkHtSHd1CPSgN2K2JgKw1vira8eYqfKyp0KKLLOWH0
         vyhw==
X-Forwarded-Encrypted: i=1; AJvYcCXrolWODnyT3GinmApakxu4QZdDQ6Wftbmc1wMe7YOaJppSrqu1hkhN6yhNu2WpFAPFy6Vj0x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP4IfMW3Xf+70OYgaM2tzsPJPGrD/9rNzzZE0LMdqw6UhnEsVW
	tyoGtAwUBt0IenkEQ/GcBXSfFpw5E68HXyYy9c/goNgk/uaMz9b7gxC5
X-Gm-Gg: AZuq6aKivIGQx6it4ugWV5Qxg6V7WVZj855wQllNx7VaeAuwDz6ahkRgMr6EHHBN5yl
	4f4gWXBFGFtYEh2U3h/kmNpVJCmg39sPeBOAnq+GzJqBMVxUP8Z7sHByyACZDHR0e27U3SY64PD
	YjKjl6aRw8PmvBkg+V0qgy9Zh4jn6MokLwvSB0vD+bqKSw7Civu3mTg5I5j0l4jMQ/A/R0B9a5x
	bUNl5DQ281/yMmW2HDA587crCKfR1KvE5yqRqqKx8oHm9qmZqjkQjCXei81pGi4ermqxQmlvP6o
	IMVflk63RRbwgn4e5b4R47Xg3ozoL3wNXw5UTqn1rCsB6+/1YHZg34dO9Qq64ROb7TUkCWxNdi0
	okzArZg9n2oSrNrvLWAaQOSSt+T6ZgFLBJcALhfUifKZoGa6T1ySbiBqsO1nWjz9tDYVkPlQJu1
	XPqLQ=
X-Received: by 2002:a17:902:e88d:b0:299:e215:f62d with SMTP id d9443c01a7336-2a933b9d409mr62869745ad.5.1770265102795;
        Wed, 04 Feb 2026 20:18:22 -0800 (PST)
Received: from misys ([58.120.241.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93396b2eesm38037785ad.78.2026.02.04.20.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 20:18:22 -0800 (PST)
From: HeeSu Kim <mlksvender@gmail.com>
To: nathan@kernel.org
Cc: a.hindborg@kernel.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@google.com,
	charmitro@posteo.net,
	dakr@kernel.org,
	gary@garyguo.net,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	nsc@kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org,
	tmgross@umich.edu,
	HeeSu Kim <mlksvender@gmail.com>
Subject: [PATCH v5 2/2] rust: Makefile: bound rustdoc workaround to affected versions
Date: Thu,  5 Feb 2026 22:18:15 +0900
Message-ID: <20260205131815.2943152-2-mlksvender@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205131815.2943152-1-mlksvender@gmail.com>
References: <20260203221224.GA2703490@ax162>
 <20260205131815.2943152-1-mlksvender@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	DATE_IN_FUTURE(4.00)[8];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-214387-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[kernel.org,google.com,protonmail.com,posteo.net,garyguo.net,vger.kernel.org,gmail.com,umich.edu];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mlksvender@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64873EE879
X-Rspamd-Action: no action

The `-Cunsafe-allow-abi-mismatch=fixed-x18` workaround was added to
handle a rustdoc bug where target modifiers were not properly saved [1].

This bug was fixed in Rust 1.90.0 [2]. Restrict the workaround to only
apply for Rust 1.88.x and 1.89.x versions that are affected by the
bug, preserving ABI compatibility checks on newer compiler versions.

Link: https://github.com/rust-lang/rust/issues/144521 [1]
Link: https://github.com/rust-lang/rust/pull/144523 [2]
Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/rust-for-linux/DG4JM9PU51M0.1YRGM9HVTY24U@garyguo.net/
Cc: stable@vger.kernel.org # Useful in 6.18.y and later.
Acked-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: HeeSu Kim <mlksvender@gmail.com>
---
Changes in v5:
- Split rustc-max-version macro into separate patch for easier backporting

Changes in v4:
- Add rustc-max-version macro for cleaner version bounds
- Use rustc-max-version instead of test-lt for readability

Changes in v3:
- Remove Fixes: tag (this is a feature, not a fix)
- Use full URLs with Link: tags instead of GitHub-style references
- Add Link: to lore.kernel.org for Suggested-by attribution
- Add Cc: stable for potential backporting to 6.18.y

Changes in v2:
- Change approach: bound to affected Rust versions instead of ARM64-only
  (the flag is simply ignored on non-ARM64 architectures)

 rust/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 5c0155b83454..1e8a75bc2878 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -136,7 +136,8 @@ pin_init-flags := \
 
 # `rustdoc` did not save the target modifiers, thus workaround for
 # the time being (https://github.com/rust-lang/rust/issues/144521).
-rustdoc_modifiers_workaround := $(if $(call rustc-min-version,108800),-Cunsafe-allow-abi-mismatch=fixed-x18)
+# The bug was fixed in Rust 1.90.0, so only apply for 1.88.x and 1.89.x.
+rustdoc_modifiers_workaround := $(if $(call rustc-min-version,108800),$(if $(call rustc-max-version,108999),-Cunsafe-allow-abi-mismatch=fixed-x18))
 
 # Similarly, for doctests (https://github.com/rust-lang/rust/issues/146465).
 doctests_modifiers_workaround := $(rustdoc_modifiers_workaround)$(if $(call rustc-min-version,109100),$(comma)sanitizer)
-- 
2.52.0



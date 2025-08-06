Return-Path: <stable+bounces-166719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB664B1C9A7
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB2B18A3F62
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFDE291882;
	Wed,  6 Aug 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UAmoVZGS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5682AF1D
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497208; cv=none; b=ivdCZAxQY77m1LSUAHrrvJgKCZfX/QMNM9nSKvSzg/wHfzND1FQKooZ3OWd1huCdUf5iZViE34u8ZJzx0gb+47zl/zhRqz8VVKBa0ffNcdK0o6Ba4vpgbLfiIFD+h6XnJvH7rCmzz9ouq518K3PTsTVISIumQ4EVfHYH5QqUDjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497208; c=relaxed/simple;
	bh=0X8oXi1bYS8M0aCdqtyEbfocq0QfgitMBDkNrB7vH/4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=n5GnilUMgbb0dfYeUbw1aNvMDhG39faNgH4SWVfQYaJv0d6ybIAkAaD31asfGjWQZ5JYp0ellAohPE3FiiTbA21XTDHaAMqjL9qa8GKoR/4QPtoOpPSkTjnWLWLBY6B9iPJ7CdmHceJYKxRZGs7dP+bGMJr9CWpo1zFOdlmjiLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UAmoVZGS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2400b28296fso152155ad.1
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754497206; x=1755102006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VSSeMLLAMhKUAZza2WNjj1MvOAkl+J1OyOksFF7wA7s=;
        b=UAmoVZGSSK0FDMSTA3HE2U+/KocTE8x7szQBT0z0IYpRrC9IkzXwR6t9TA27TETbv/
         0bJgjMATALpYOrrYLmBmSWo7rdiKdYYt4Wx8c+KhLudNIGZCxE4QulCt/sA8gmMJrfeY
         fhYTkI4CUhMp1mCOIwM7wNCKtFQD8c6ddRsV4ODpSI1yCC/iMw4XLN5HH2jCbBMiPpAT
         cPRIe9g7z1cI7WOUykbyZWDwqJTCvIx5wy/JRTEfp6tFTn3V88ZFXY9OKMyemEbdqKlX
         XIEs74+LsPjqRmyXKm5wZotBHVEbY5OJI+jc/ukBzYytDArK1lmF6+MTK9rHwlLyjJPP
         Dfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497206; x=1755102006;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSSeMLLAMhKUAZza2WNjj1MvOAkl+J1OyOksFF7wA7s=;
        b=esXELNz8wWk0s3aizzA/NPqtNWxB+NgS9hEhLDOow6nRYdb6/k1MWw9BABF34F5MiJ
         0TvhC5giY5SzTpHPn+cYvXH0gQUdKlM4ShUN7Xo9fJ752rFBEmDCc7J2zr0+ECPEyAor
         P/icl/fNyYupwqPEbl+NyhtdcsOPIzaQwItZwf8ohREwN1+d5dp357dgtHEJevzet/XR
         zwjuzH7CC9Nnndo6Gvxt5tlknU0KBZn5utS60wPcG8LwqtdDPz0tJ3XzRaHaseL2BqJJ
         ZjIiarQEyjkos+C048s4Zy3R/6+myGoxJNx4w+XMHpfPY+bOHu+q4oEcPxygKgT2Venl
         JR0A==
X-Gm-Message-State: AOJu0YwEKDMu5QgoIjx4FGVfinEzK7JcvMNNJBTTN2K5Trhy6taeac6B
	OsA7QKMUkiYAKOrLDpa/YvdlgTknGM2G/9fcKGQGX0OzPoX+SYfbUkv02KcTFPDJ9O+f8xqhBbT
	puxR9tQDohTehGLylCzYdt9AgOohoxiQ0d4wWJ9v/ZLFHe1LDgOeOPnFlUZlQqehiv9K6IYxMFb
	z43MXztNT3ByjjcPCbV6mkhaXj5aelBYX/AiApPl5EF/oWpqh383tM
X-Google-Smtp-Source: AGHT+IHz6G1Q7shyMCzajQlxoEutrNvojobmbTxNWJ6XYS1ypBZRqwzBE44BKlGDraDaqynOiOFG8ukPq/pKPI4=
X-Received: from plhl7.prod.google.com ([2002:a17:903:1207:b0:235:f4e3:ba29])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a67:b0:240:3c51:105e with SMTP id d9443c01a7336-2429f4244dfmr50212135ad.20.1754497206194;
 Wed, 06 Aug 2025 09:20:06 -0700 (PDT)
Date: Wed,  6 Aug 2025 16:19:56 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806162003.1134886-1-jtoantran@google.com>
Subject: [PATCH 6.6 v2 0/7] x86: fix user address masking non-canonical
From: Jimmy Tran <jtoantran@google.com>
To: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	David Laight <david.laight@aculab.com>, Andrei Vagin <avagin@gmail.com>, 
	Jimmy Tran <jtoantran@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

This is v2 of my series to backport the critical security fix,
identified as CVE-2020-12965 ("Transient Execution of Non-Canonical Accesses"),
to the 6.6.y stable kernel tree.

Linus Torvalds's second proposed solution offers a more targeted and
smaller backport for CVE-2020-12965 compared to backporting the entire
patch series.

 This alternative would focus solely on the user address masking
 logic that addresses the AMD speculation issue with non-canonical
 addresses.

 Instead of introducing the extensive "runtime-constant"
 infrastructure seen in the larger patch series, this solution would:

  - Introduce a single new variable for the USER_PTR_MAX
    value.
  - Use an actual memory load to access this USER_PTR_MAX value, rather than
    leveraging the runtime_const mechanism.

 While this approach would result in a noticeably smaller and more
 localized patch, it would differ from what's currently in the
 mainline kernel. This divergence would necessitate significant
 additional testing to ensure its stability.

I am ready to implement the second proposed solution if the
maintainers wish to move forward in that direction, understanding the
testing implications. Please let me know your preference.

Changes in v2:
==============
- Incorporated the commit 91309a708: x86: use cmov for user address
  as suggested by David Laight. This commit is now included as the first patch
  in the series.

This series addresses the CVE-2020-12965 vulnerability by
introducing the necessary x86 infrastructure and the specific fix for user
address masking non-canonical speculation issues.

v1:
==============
This patch series backports a critical security fix, identified as
CVE-2020-12965 ("Transient Execution of Non-Canonical Accesses"), to the
6.6.y stable kernel tree.

David Laight (1):
  x86: fix off-by-one in access_ok()

Linus Torvalds (6):
  vfs: dcache: move hashlen_hash() from callers into d_hash()
  runtime constants: add default dummy infrastructure
  runtime constants: add x86 architecture support
  arm64: add 'runtime constant' support
  x86: fix user address masking non-canonical speculation issue
  x86: use cmov for user address masking

 arch/arm64/include/asm/runtime-const.h | 92 ++++++++++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S        |  3 +
 arch/x86/include/asm/runtime-const.h   | 61 +++++++++++++++++
 arch/x86/include/asm/uaccess_64.h      | 44 +++++++-----
 arch/x86/kernel/cpu/common.c           | 10 +++
 arch/x86/kernel/vmlinux.lds.S          |  4 ++
 arch/x86/lib/getuser.S                 | 10 ++-
 fs/dcache.c                            | 17 +++--
 include/asm-generic/Kbuild             |  1 +
 include/asm-generic/runtime-const.h    | 15 +++++
 include/asm-generic/vmlinux.lds.h      |  8 +++
 11 files changed, 242 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm64/include/asm/runtime-const.h
 create mode 100644 arch/x86/include/asm/runtime-const.h
 create mode 100644 include/asm-generic/runtime-const.h

-- 
2.50.1.470.g6ba607880d-goog



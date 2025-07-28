Return-Path: <stable+bounces-165002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0924AB141A6
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C777E1671B6
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 18:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DDE1C1F0C;
	Mon, 28 Jul 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQQXcRzN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDE721E08D
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725433; cv=none; b=stpN+xTPYeKClaQEahyMCfzyfIrpqmm16ZKgS9Mvkl1TtO7QZ5TnI3J8tAxXpzwLMBIKeNkPRopw80KF+UoyosQhABJfJhqQSiIMgCGgZWUiXWesmJkD/VFyoLGUoJapitCm53owh0kzguYWO2CwJ17K8TOGXX+qC+85tlcqCPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725433; c=relaxed/simple;
	bh=0X8oXi1bYS8M0aCdqtyEbfocq0QfgitMBDkNrB7vH/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nHEHFwOchT8qMPL11131afhHUIL5eC6CQZviAtMcuV0ap3Ia6rcg6ECoqcqzmY2fkRPw8VpFlmLmlhj9+u4cMISvE9S6pZdGu0y6h2ysLW5/6tyUnEsC7uZer5BflqiZ+vUX6sg8Ctm6Z7G54FddRf3HjfS508YPGSKL0BFAG70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQQXcRzN; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-754f57d3259so7526224b3a.2
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725431; x=1754330231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSSeMLLAMhKUAZza2WNjj1MvOAkl+J1OyOksFF7wA7s=;
        b=aQQXcRzNFgyl2ggYPDYfJPViy79Z73KdNgR8WP2W4ehJkZF/rppJ9ezmY6TTXePJVY
         mzESiiTNnlZORMe2bBNHKjxbOX1k4ls+Svm2bZtc4eg6SAcdfnxIinIJQkOJdTN2WbmY
         VZlWtUmF5jSDC+8ZKQ5On1Y0SJgHoXqL8JsPDiVk8vWDnZc3HO6OaNh0MzmxBA5TB+xL
         4ZMNLrRXvJaEB5bZzeZJZYK4KNhFIsQ22PgTol3yC5FGv0/TMY9r4jhKWz0XF3PF1FBV
         lcVESAbv1XR5SEhh0297jnoRe3bINE2U7szzqExDzBx12ozakdboSvpDDJgJ7ihH+V8L
         kh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725431; x=1754330231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSSeMLLAMhKUAZza2WNjj1MvOAkl+J1OyOksFF7wA7s=;
        b=Z/7oV6ABsxbMLJZ4rd83/KJs3sy5ZuSPaVA8XGwWZLKzIwLoOsE91/eJXQK3gRQzTp
         YhfTUPuUOhZ30MtlgHtj6RPw17yyoOw6RmckTUR41c6XLO9tw3LKjHmXW3Zb7TR/QGQs
         bqlq1IYrmscB2I0XcG/metdyHC0mgv5ZkOYHxLYJWkLAGHB687IrXzUGOQOJ0Y/Ik7kj
         /V5pWj1zJE43Qt/EgVSwsqRyvK+JXI+H2y9XonM+ksewk6/YRZWrbdF4BNlIr3P+HhjM
         v0P5hSwjFC/ndqz8KuDFNhY+34GoG0tq7GMfMOXSNWNsAJre2mVwOVDr1846TP2OuyM/
         +9jw==
X-Gm-Message-State: AOJu0YzwZLYcdNnh1ZnA2zIZQ+Q0ASNKbwv2ZU7w2tMu+xLSzpq+svTp
	yoBdnsiQY7ilawoAjWE6E9Pj+kcVXN2aKr/b5b3SPYSOSFalMlpyEhSvcHgh+/zDKPfGv9OlALY
	+nnVyc0ruRNAN/BCz9BhyuHoFQpJiEiNul+TFw3N3L2sg0XSSlZuuWgKx3Yib4rrhH7Urn+wIyg
	9ZfGhQPI3urXVnFEenNJy8Df3rjFPq4LWe5CCAWQNBKZF46H5dP2dV
X-Google-Smtp-Source: AGHT+IEENuk65GyZmFqSaicWwAh16oQZIDKpoUcsUKguB7z7SuUaYsGhZM40o8uhso7bCG4e0QTrslzJGPJIYsA=
X-Received: from pfbdf10.prod.google.com ([2002:a05:6a00:470a:b0:748:f030:4e6a])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:99a:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-763349ba196mr18591277b3a.19.1753725430807;
 Mon, 28 Jul 2025 10:57:10 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:56:53 +0000
In-Reply-To: <20250723163209.1929303-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175701.3286764-1-jtoantran@google.com>
Subject: [PATCH v2 0/7] x86: fix user address masking non-canonical
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



Return-Path: <stable+bounces-164600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B48B1097F
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 13:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A56A1CE08A9
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5312272E58;
	Thu, 24 Jul 2025 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDWsvkFN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB41853
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357656; cv=none; b=k1KjtD9LQADqPJKfeSkCrmtwZ+s4qx2XhGbEGyFvAU99/8spCwbWe0rQnSEa6M2nHUP2atQLyCJS71bPNJ/FVRtP86ddQokBUVt5rar1jSBr8/g2X/tlVIMFNRmStJX/SScqOq9S5Jn7VxCF10dFJmyFE+LRfkhW9dr5LkQNJ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357656; c=relaxed/simple;
	bh=9wQVHGZNhIN2R1JK41UtmFfAdp00vst6EIW99Olu56E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwNu48bYRW6ctKGghbyTj6tp4uPlZ2IrPXFijXSdGTh4z7OT5HvnLWZHgPL7ipClHLlGMKEmPfrrN7jkJoTKCGKCGpcj1QdatoPxFA1Xl+AKl9rKI/B9XkVunHsadhy07bpEipmgAbjTQACHexwuTogGufcfLkHxqKmrqscEkd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDWsvkFN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a588da60dfso556484f8f.1
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753357653; x=1753962453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVxDWz9uEnki0n5jvVHojLj5TWUbKvewF9D91dWcEQ0=;
        b=hDWsvkFN4kYUPBZvbjQkfdHl4CT/pOefRrYfSBhpnsd/UBA1KpJUTCVNuFLhf0aw0N
         CF1BLMAqCcfz+qgdENVEl6Vi9ihDGSf5UDeV4tnJjjNQ7NXB/Yv7JYD5L9CLCurO/ve7
         gDjZCNR5XQqJqEBCTFW+4ZwapuuNbcRIuoTFa/Di+FLRdJ5vjcmBQ6TTzDvHthyIgzqL
         jJyZmawdLO895Eexfsu0WyHDpelxRbPB54UNTPmHDcFx3Daq0DGG+i9XycbxU5F8hdGT
         7g3R7hNgqUrAu6NCfFPEbNV8aMey/k6Po+nzMezak37yU+IBznv+FyhjCyNyRlBpBCdW
         Aabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753357653; x=1753962453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVxDWz9uEnki0n5jvVHojLj5TWUbKvewF9D91dWcEQ0=;
        b=htWXcCkDPLNRC8UbHJ3XRcgJzVF3WPK9RhmgKexeyyiavka4hzOLM3PBhPtMCm38Ak
         yHybVgkHuuduuep4bp4c6LvLJFQnDTKd4NJbuER600f83Mqwqve1BlH6yNby0eS6lfia
         75pYxmrjABz4HqCmwt1WD7ucfZta8/355FCIojKw0ddTWUJHWCMKTBmQ3xqao3jE/qmL
         xFMSwYuvGJvfKUVgHlUdFa51bMJC6fHI3Hod3dnYV+GvbdScUZ9T0ZqyAmiEpCmeoqOl
         Lj4MVepbQQKXQzIt9osps4sJTO1T3P0tL9KkdzePuckCSNZnl5fBDx7nKVoX2S5omm0p
         Q08w==
X-Gm-Message-State: AOJu0Yyl6090V4gg8YmTfMlO/KelEDWKTBvfRQxPAi57vZEa8k8JikO+
	On+K6C5UMug0GsAR3oEv4nZRh+Jfb8s6+3PPb3KN5wzLRUlnRJ8ITWvE
X-Gm-Gg: ASbGnctgZyruuV1gPFNRHVTk/+Y8o87J3RrNz794uBccmzLUpC8J8syiMkPvIwlxjnX
	ZkuN2YMzGf3Bc3nlDVv6g5ux+GqyC1I2G9aiv8ytd9Fa/wSq/4p1wB6u1+/5C0hCMbR8kIxpdhS
	TIDpY4xeHotyZ1Q1HyeTUfpZ7W9I6htw5IGpOwfCmmbdX1kHNrgrHKMNJVj337A/hjUj5+fApoz
	TZ8/Es7pqUJcQy5l06dxUHSMFBUPc/dwIR/WuwQAUIQH+p/UbuHBnHVbAmDyT9DTJi3NfpcYdZS
	9IKKD4fwZvHhhl7cq3mEFnXvM9J8Zlx+BdFlhFuFVUuv1i9bPmBoyNERKTsdG5a3Yv0JNJ6h5XQ
	DGAhzGGKaim481kHpmDom+p3Xwi+klLZfIUkcpYWD4TlfwpJbFrQPw9DNaezN
X-Google-Smtp-Source: AGHT+IF5qSmkeKM7taMZjBQvelayvG5SlDNuYWT1lT0bqLbe+QGtprUsA+kOQKOANGsMGdnCcQ48PQ==
X-Received: by 2002:a05:6000:1ace:b0:3a6:d93e:5282 with SMTP id ffacd0b85a97d-3b768f13349mr4834090f8f.59.1753357653037;
        Thu, 24 Jul 2025 04:47:33 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705bcb96sm18438515e9.21.2025.07.24.04.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:47:32 -0700 (PDT)
Date: Thu, 24 Jul 2025 12:47:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jimmy Tran <jtoantran@google.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Ingo Molnar
 <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, David Laight
 <david.laight@aculab.com>, x86@kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v1 0/6] Backport "x86: fix off-by-one in access_ok()" to
 6.6.y
Message-ID: <20250724124731.3c594b23@pumpkin>
In-Reply-To: <20250723163209.1929303-1-jtoantran@google.com>
References: <20250723163209.1929303-1-jtoantran@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 16:32:03 +0000
Jimmy Tran <jtoantran@google.com> wrote:

> This patch series backports a critical security fix, identified as
> CVE-2020-12965 ("Transient Execution of Non-Canonical Accesses"), to the
> 6.6.y stable kernel tree.

You probably want to pick up the 'cmov' variant of:

+static inline void __user *mask_user_address(const void __user *ptr)
+{
+       unsigned long mask;
+
+       asm("cmp %1,%0\n\t"
+           "sbb %0,%0"
+                : "=r" (mask)
+                : "r" (ptr),
+                "0" (runtime_const_ptr(USER_PTR_MAX)));
+       return (__force void __user *)(mask | (__force unsigned long)ptr);
+}

Converting kernel addresses to USER_PTR_MAX instead of ~0 means that
is isn't critical that the base address is accessed first.
(I'm not sure that x86 completely disables mapping to user address zero.)

That is more problematic for 32bit (address masking wasn't enabled last
time I looked) because not all supported cpu support cmov.

	David

> 
> commit 573f45a9f9a47fed4c7957609689b772121b33d7 upstream.
> 
> David Laight (1):
>   x86: fix off-by-one in access_ok()
> 
> Linus Torvalds (5):
>   vfs: dcache: move hashlen_hash() from callers into d_hash()
>   runtime constants: add default dummy infrastructure
>   runtime constants: add x86 architecture support
>   arm64: add 'runtime constant' support
>   x86: fix user address masking non-canonical speculation issue
> 
>  arch/arm64/include/asm/runtime-const.h | 92 ++++++++++++++++++++++++++
>  arch/arm64/kernel/vmlinux.lds.S        |  3 +
>  arch/x86/include/asm/runtime-const.h   | 61 +++++++++++++++++
>  arch/x86/include/asm/uaccess_64.h      | 45 ++++++++-----
>  arch/x86/kernel/cpu/common.c           | 10 +++
>  arch/x86/kernel/vmlinux.lds.S          |  4 ++
>  arch/x86/lib/getuser.S                 |  9 ++-
>  fs/dcache.c                            | 17 +++--
>  include/asm-generic/Kbuild             |  1 +
>  include/asm-generic/runtime-const.h    | 15 +++++
>  include/asm-generic/vmlinux.lds.h      |  8 +++
>  11 files changed, 243 insertions(+), 22 deletions(-)
>  create mode 100644 arch/arm64/include/asm/runtime-const.h
>  create mode 100644 arch/x86/include/asm/runtime-const.h
>  create mode 100644 include/asm-generic/runtime-const.h
> 
> --
> 2.50.0.727.gbf7dc18ff4-goog
> 
> 



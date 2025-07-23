Return-Path: <stable+bounces-164483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356B5B0F828
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C49F3A9383
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499ED1F4285;
	Wed, 23 Jul 2025 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjVS4M/n"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E71A0BFD
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288336; cv=none; b=pJ2UtDyqXgRqQkL4iDX7oSb4GQltH6vErOJ1x9HkZ/27QlfC86mnugnxseFTYlgiwf0cyXsjEhjF1n+2meXleyQjXLLxuvzCBUa9poB2QWBiMpN6P71B3lLmNSYGPe2lE66rKYp6amcbYOYFYiI8jb+1VR4aIInkdhUply6EKI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288336; c=relaxed/simple;
	bh=ikzDaBZRfJGI4v3MLw8sz0TElEliydTbUsHspD6HyIk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uv4EurcqDX58s+zyhlerHy3Mm5ysCq0QjdZ1SthV6UtyEuy+gNwiGC9VELqJvLtozCj5tWUROMRtkb+nE06ARHVCnkSgHuOHTedNp7uOWkiDa+PadD8NwkzGb4c86JiwdCkJuC9/VJOhdnJds/NkrT3bmblG5s5iBaSo+4MAf8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vjVS4M/n; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-315af08594fso21639a91.2
        for <stable@vger.kernel.org>; Wed, 23 Jul 2025 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753288334; x=1753893134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a2DWSB0SwFdqjDzshikhv3OH3wL5eDCTFqknA+w9uFk=;
        b=vjVS4M/n+4tsm6F0rVo66/9+zSXYj9scJge9Tjti2I0Ba/2nGkG2rCHBJRFC9AcWHb
         hBsAUsOmJ+ce0zZdRkdjuWMbO3lrrd7miP3OOoPNOnMYw+KfKwgaIaXhzIf9hgwYhIap
         ACX8QGc4PotlKF9ejebYNhOKwfMvwZQ0Ys1NQ/5hUKJ2SUaT9XvkmhnulymCUhH5TUBE
         znc7VpVV1qIuRuhlGCvVf9hOOkVY9lMjUjyQn9Lz2lIhV+R5CFXzt8xg71zOaY5slk/K
         obgiH7NfFC4wD4bXgaudXTMh9pAEV+WsIwx0ZOMGTB/eFrN4NZqL5fEdK7DZTR6iUCUg
         6MTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288334; x=1753893134;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2DWSB0SwFdqjDzshikhv3OH3wL5eDCTFqknA+w9uFk=;
        b=YMgE1oVroxVTatRwIR6d0BG198Hx0lcFnVP2X4Hq3dJm5WONZqiNZyXUxt5rei0hKa
         Vf1/KcRBTR+TiCtSJ4zMa+OEYVowTYuVNYG38W24q5BPkfFodmNDf45hNN4zp8zHGIcd
         cGCMtcfdU3Shl3GoSR7dZ9SJuqVWgCDzqHydV6lTFnYDR4uPG+pVLtBTfHVaPblYxxev
         8PlnNkbnyzdfrqYpOevoBUYlnJnc1AoJBHMOGu+Qfk2pH3dd4oqhR0gJ+1qlVSlFq2BJ
         wWt4SGxdZedNXrnphHibMOWB/Idk47dOKD9Sq4ib7C0W8xhkYvZp20ET94s5YUG7/9zq
         VYVA==
X-Gm-Message-State: AOJu0YzFJpzwuRMqZpkKU6Qdum4JA9xZJN6581/FVoBS93xPBGLKVzBy
	/tNXhrwCePep2eZkMhHh6KiCm/ZM5Zq4bjpPpNK3tKvgG658CPCvopAloXy9FutdYhycJGABLwl
	6+oOZwraalxp0j3cfDH+11Y4bvJxLgh9onZz1AgpVGv+kBGCD0DdMrlfgOT2rGlTKVnhGsiQuVF
	qFKg7zD+03AQcZQjgoPCLC/HUZ69to1/m/Y69YaZ3rb0DD3rh2gETs
X-Google-Smtp-Source: AGHT+IHsoDfQediZd9aVCm2RFt+McjIgxrEPMprJqTydUbo1QeYROVOi6NYxqLSOOs8mX/IrDVhcVUkWAljMg48=
X-Received: from pjbst4.prod.google.com ([2002:a17:90b:1fc4:b0:30e:5bd5:880d])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4fc3:b0:311:9c1f:8524 with SMTP id 98e67ed59e1d1-31e507cdde8mr5902984a91.15.1753288333872;
 Wed, 23 Jul 2025 09:32:13 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:32:03 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723163209.1929303-1-jtoantran@google.com>
Subject: [PATCH v1 0/6] Backport "x86: fix off-by-one in access_ok()" to 6.6.y
From: Jimmy Tran <jtoantran@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight@aculab.com>, x86@kernel.org, 
	Andrei Vagin <avagin@gmail.com>, Jimmy Tran <jtoantran@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series backports a critical security fix, identified as
CVE-2020-12965 ("Transient Execution of Non-Canonical Accesses"), to the
6.6.y stable kernel tree.

commit 573f45a9f9a47fed4c7957609689b772121b33d7 upstream.

David Laight (1):
  x86: fix off-by-one in access_ok()

Linus Torvalds (5):
  vfs: dcache: move hashlen_hash() from callers into d_hash()
  runtime constants: add default dummy infrastructure
  runtime constants: add x86 architecture support
  arm64: add 'runtime constant' support
  x86: fix user address masking non-canonical speculation issue

 arch/arm64/include/asm/runtime-const.h | 92 ++++++++++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S        |  3 +
 arch/x86/include/asm/runtime-const.h   | 61 +++++++++++++++++
 arch/x86/include/asm/uaccess_64.h      | 45 ++++++++-----
 arch/x86/kernel/cpu/common.c           | 10 +++
 arch/x86/kernel/vmlinux.lds.S          |  4 ++
 arch/x86/lib/getuser.S                 |  9 ++-
 fs/dcache.c                            | 17 +++--
 include/asm-generic/Kbuild             |  1 +
 include/asm-generic/runtime-const.h    | 15 +++++
 include/asm-generic/vmlinux.lds.h      |  8 +++
 11 files changed, 243 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm64/include/asm/runtime-const.h
 create mode 100644 arch/x86/include/asm/runtime-const.h
 create mode 100644 include/asm-generic/runtime-const.h

--
2.50.0.727.gbf7dc18ff4-goog



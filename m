Return-Path: <stable+bounces-164489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0D2B0F82C
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174ED18993B9
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BE51F09A8;
	Wed, 23 Jul 2025 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hAuNH3KT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42951F428C
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288346; cv=none; b=g6G/JmCWISf30oZnvCAG5hN7GUTk1Tc2KDGhyk/PSfgzyDvPRKcrgXJCj2mzHohPPcaSEPA2iJnpH/sbt5oKCPLqDFA9LRKgm3ZSYLAneaPyxf65rTyMh7/Gav7FiQwesJDnPGWr7+U4FB1XSqlJYYFHq+TmKVzkUsBajDVHJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288346; c=relaxed/simple;
	bh=sk9pmxSDONxx26Y7oBPTr9IirEf7usCJLyq2/Te0K6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MuOL0EZkkw6nsivHM8FdVQxUNdMSpi21gWo/7sCgKTFJNzIWV2/UZgaE4+jFvUEqgxtN4uTveVQYcPSKmnV+kHRe2jA+l2gCuKqlZ7OIhBTpmqOVg+4cI2z1NQkxr6Z8K0IeBDidPepJGuz/xWtP/dHlNz3Ljx8ay5+mU1mPZFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hAuNH3KT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74928291bc3so97848b3a.0
        for <stable@vger.kernel.org>; Wed, 23 Jul 2025 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753288344; x=1753893144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7HD50GK22TvRMoqPqydaxxbuQ2fzAoYmEOfBVREPdQ=;
        b=hAuNH3KTc6uHXPWpn+v9DKrLgR75LTbeiq0xznvG45E5B6pFuSIAnDbT2L17IKQVvX
         rpEDV5T/74iKZPkbgIs4z/QhygYn5a5IHGOtcnQr4OsMZ7Nnkg74499TAJ7/rFqG4LTl
         dwrco3XtxzOLBJwy3rVbqJn6XSFlQ0NcO33tCZz/mFzegmRI/+T7XuZU/gp4jfcgBo5L
         ZqkCCPBsE6yPSHO1kHbhaWnAus+m2r7WmDQdmKU0761PsGDoAqkdCmUJNn3Pe0GYs4DJ
         9xTybtyb00fDz/eX4y+ds/s4Q47mLmN8EyimHxOCwi+S9S58TfpryBIS8I50SrZNhbeY
         EFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288344; x=1753893144;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V7HD50GK22TvRMoqPqydaxxbuQ2fzAoYmEOfBVREPdQ=;
        b=WnhmCUZg2NIyjLqfjQ0eS1vRb/IrT1A36mWKgZbT4BUFMPco3Ybz7dhJ07Ri0A9fk2
         8b7wx7TlQrgZhM7tOU2yzLQ8nQGi/ENxm3jQ/GSFLNov+w5JFiCAnMkRXRzGkaylI9ss
         PkQ60+Cx4lnDUyuSzzGLHQDDp1op4F0Uy0baWEOg1ca8P9vKW4iDKposjGJmegfEjkac
         YNy6odC2hExaxShnDPcrFXoFwtSnJ9/yg77csn9wSdwDJOYgOs+QyKEVVIq2W0RQW2ji
         PlnpJ1ztKtgWxG8BQLm86X7KbXN2Q0QgL6FiliomDoPdOV+t7imMsxtpMN31A+tS1pA6
         cuFg==
X-Gm-Message-State: AOJu0YyLphUW0IK8N1Vocyz9ZQmn7tkkG+b+b91BRdxq3Spg19RAp0PZ
	7fSFe0BWt2R1UyRUj2UwxlkBvLetl+coo2hyrb9KzAn4uzqn36TNpovxHMKiEQWZur7GQsdRa8i
	K+Tp+3FByAH53q7JPW7TF1ePqj//8c6FphVjqc3wRVt9mvvEYgD8iWFjduItY1sLiUT/f0R4sC2
	+VGO5ZETX7KZWlmhNZ0LDFCmfnvBWAYhi//NJoWP6fTbTvDNDj5F9D
X-Google-Smtp-Source: AGHT+IEZ815jNGECNTOdO1GV9e+0l2oVbhZze4SzXNT7qjYI6QdfEJJ114saoJbIiedWHKeChFU1vmm8qvyiNDI=
X-Received: from pgar22.prod.google.com ([2002:a05:6a02:2e96:b0:b34:f43b:1cec])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:244c:b0:235:c9fe:5929 with SMTP id adf61e73a8af0-23d4916df61mr5337332637.42.1753288343955;
 Wed, 23 Jul 2025 09:32:23 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:32:09 +0000
In-Reply-To: <20250723163209.1929303-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723163209.1929303-7-jtoantran@google.com>
Subject: [PATCH v1 6/6] x86: fix off-by-one in access_ok()
From: Jimmy Tran <jtoantran@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight@aculab.com>, x86@kernel.org, 
	Andrei Vagin <avagin@gmail.com>, David Laight <David.Laight@ACULAB.COM>, 
	Jimmy Tran <jtoantran@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Laight <David.Laight@ACULAB.COM>

commit 573f45a9f9a47fed4c7957609689b772121b33d7 upstream.

When the size isn't a small constant, __access_ok() will call
valid_user_address() with the address after the last byte of the user
buffer.

It is valid for a buffer to end with the last valid user address so
valid_user_address() must allow accesses to the base of the guard page.

[ This introduces an off-by-one in the other direction for the plain
  non-sized accesses, but since we have that guard region that is a
  whole page, those checks "allowing" accesses to that guard region
  don't really matter. The access will fault anyway, whether to the
  guard page or if the address has been masked to all ones - Linus ]

Cc: <stable@vger.kernel.org> # 6.12.x: 86e6b15: x86: fix user address maski=
ng non-canonical speculation issue
Cc: <stable@vger.kernel.org> # 6.10.x: e60cc61: vfs: dcache: move hashlen_h=
ash() from callers into d_hash()
Cc: <stable@vger.kernel.org> # 6.10.x: e782985: runtime constants:=C2=A0add=
 default dummy infrastructure
Cc: <stable@vger.kernel.org> # 6.10.x: e3c92e8: runtime constants: add x86 =
architecture support
Fixes: 86e6b1547b3d0 ("x86: fix user address masking non-canonical speculat=
ion issue")
Signed-off-by: David Laight <david.laight@aculab.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jimmy Tran <jtoantran@google.com>
---
 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2369e85055c0e..6c69dea644ffc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2491,12 +2491,12 @@ void __init arch_cpu_finalize_init(void)
 	alternative_instructions();
=20
 	if (IS_ENABLED(CONFIG_X86_64)) {
-		unsigned long USER_PTR_MAX =3D TASK_SIZE_MAX-1;
+		unsigned long USER_PTR_MAX =3D TASK_SIZE_MAX;
=20
 		/*
 		 * Enable this when LAM is gated on LASS support
 		if (cpu_feature_enabled(X86_FEATURE_LAM))
-			USER_PTR_MAX =3D (1ul << 63) - PAGE_SIZE - 1;
+			USER_PTR_MAX =3D (1ul << 63) - PAGE_SIZE;
 		 */
 		runtime_const_init(ptr, USER_PTR_MAX);
=20
--=20
2.50.0.727.gbf7dc18ff4-goog



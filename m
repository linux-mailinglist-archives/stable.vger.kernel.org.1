Return-Path: <stable+bounces-166725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E83A8B1C9AD
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E7B189BD0E
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5428CF64;
	Wed,  6 Aug 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2fx6Ehr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D6C28C2D8
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497220; cv=none; b=bwGyIULEOwJP7FH0nuxS9QnhNWL97gCf9KLTn7CxEZpIVDFkCDLqOmDJ11moz8kwS0qz0R7LWa+J5HNlt2AdrxTy5gGFiBMsEhxzkReLsguS92mxKIKWrpispTiDPheZ6RgpNPkVY0BEDL6yZX68sWGcoIAkmwdi4Xx3057gfiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497220; c=relaxed/simple;
	bh=NXmKqGeoqW0HROS2Srv/PiJAePy64j/hjzIPyARiHJU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NKJwBXKSxCEeygAMTqwIMI/60ldq23cokkoMUH9opXYikAsjF59JnprIQpdAnJI0KRfAwW72e+KG59pRJa7x4bCSfJ+/V290S9bK00okxWVKkuFaP0+AOZHEPgNrA8jYkNc/bQUGDDOESFbPaUFHb3UkpMIHjhhQHVirAZcpJk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2fx6Ehr; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3beafa8d60so9437913a12.3
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 09:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754497218; x=1755102018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mx8DvbGzit5IZkHXHj0j5BlFANu3M7t2Ru4Wnf2fZVo=;
        b=V2fx6EhrhX+TI397UAuktBF189hwmHAryhPk6I1gXSD5ui8BG/1X78LUhho0OhG0ai
         ZFxLj3OxQ7LGwTVgDoiBTAXes1qlRnHI5OnorqNmb9AqXbp79CYf9qDl0xutLnqb7JNb
         dFvJmdXPK8dJLyGtSPEJiRYIt96KVDqfEoO7OlwOrF1CC9BBxkLXRkJ+nPgebH3bvIjW
         jy0kJxNx8+ELJfPU9yp7Y7jbZOS3HjuR4fcxkUK22+PBtoDE5s1sCwGHqDXddmkMOBL/
         AxqIzNFwBd1uA66cu7DvdhpgrLZ7uq7Zw32ICBppuX58n8LyLUldE3rxoi/8vIfnsCLx
         hdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497218; x=1755102018;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mx8DvbGzit5IZkHXHj0j5BlFANu3M7t2Ru4Wnf2fZVo=;
        b=ctfOV74+OqoTAebjZqAO9vFhqlqZMg8yB9H/OXzczmbzDp2WkVT4THu3GZ8NAgw0AA
         4Z3y1OOU2k8w89WCMnZzvJ3iCqLdHOAS+ndQsEQYef4O2DnWd5J3SaBchN92Mo9vQB9e
         9WZ+GjPbTNpoo7i2Rz8WmQuAX4h9m4SZ7zFVE4ma2Gm6m1Y+4vh7wutXQHldp5PZy0si
         ThYja6ifdopkF4TBnhN43BTlRU6n3xzQKba4bYn3y6i3msnMRkgecBEBuRhAwq/8n9Lc
         u+ORi9BkEcqE3ftLCfSXtN6tN2/LspPcU6O9jHDnX0U0h5XXwLSi/Eizbb48N1wRCqXR
         MvyQ==
X-Gm-Message-State: AOJu0YxJXMaZwmP5XShPzIRFzac6CMLMtKDo5ap/WHQar9CV0YxzBuqb
	I4Dq3Kp7aJChK/uMZyivhxFi+RaAm2lN6u0vS08om2UGwiteo7IikRqFLpXBiWKoHqTGlip3C3l
	ubjNk9w5HU3H/0pEUv/B/YF6bKfuNy7/JtdsOu9JOqkQn/KrsWVZOx0vVpJHXMCN3wt8wHSxEK4
	P8PxQAzJvqr2UqsaZfEwaZt05aXwDKxj3lhX1mcq9+QxOPpCYCCw4J
X-Google-Smtp-Source: AGHT+IFUMvMDMn2+QLQGjlVJhKsnW1g7OJqu+dcVjwQwTIrnOsx+D13MmlXxp7o+hh6KiCex6jag73zOaqQJ3so=
X-Received: from pjbqi10.prod.google.com ([2002:a17:90b:274a:b0:311:c5d3:c7d0])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:950:b0:242:9bca:863c with SMTP id d9443c01a7336-2429f583a0cmr49689405ad.54.1754497217939;
 Wed, 06 Aug 2025 09:20:17 -0700 (PDT)
Date: Wed,  6 Aug 2025 16:20:02 +0000
In-Reply-To: <20250806162003.1134886-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806162003.1134886-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806162003.1134886-7-jtoantran@google.com>
Subject: [PATCH v2 6/7] x86: fix off-by-one in access_ok()
From: Jimmy Tran <jtoantran@google.com>
To: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	David Laight <david.laight@aculab.com>, Andrei Vagin <avagin@gmail.com>, 
	David Laight <David.Laight@ACULAB.COM>, Jimmy Tran <jtoantran@google.com>
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
2.50.1.470.g6ba607880d-goog



Return-Path: <stable+bounces-165008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B03B141A8
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 20:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4131618C304F
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 18:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E15127990C;
	Mon, 28 Jul 2025 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSBCDSbK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF0E277C90
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725459; cv=none; b=WGAXQtu96JwZ1A9ePdzN7YecIIWimRF7wXa57buQvZrCHG+z+Km7e+SnA1Ud3wns61p+mSvpIYjuDt7KjDk3XoMH32JhEg4YP00bAH7YI8RHySHLIPXUGFzCo8D38PILy/MLnWwdgqVTI9Ch3uxrIeQvpJjutdiTlLdXYg54I7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725459; c=relaxed/simple;
	bh=NXmKqGeoqW0HROS2Srv/PiJAePy64j/hjzIPyARiHJU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L8gb+45AoUBV4C3+cDs9vf5VY0akcdkNPfelRmVRSA8nokDxMxFpFQk6JUzVDVHW5LhvhQXRqKd+t8nPgeoGinEPNEYRiNBQYBlHRPrr7CHOcSTow7w88Q5fnnHGmnMy+30Ec4RngloPQDXxM3O2Dy/QCW4azzbBhmlSGtQeP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wSBCDSbK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31ed9a17f22so2231189a91.0
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725456; x=1754330256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mx8DvbGzit5IZkHXHj0j5BlFANu3M7t2Ru4Wnf2fZVo=;
        b=wSBCDSbKyHyNBOKJV4oe5FNKdDItwzcIbj3EBdKz3ZBM8CrGxJmKSDtj5/vP21F3Gt
         UapUCynagQ938lt4XMIIF4IV5qqzknLW459lRvxYyk62yf9nw9EwQCgzqoGZHlyQ7Vy9
         K3zntuegUTRXdngGnBPeMCft3UAF/KlYFUvuGCTzYYSpsJPIDO3L3vcR1RcvhB+3d249
         xqNh+G3umruxYRT67JGkLeuKZ/xtsoyRRBeyUr0d6iS3g4SKx/Piule+RT5XG8KoJDsA
         osHN9Jd8zapGYMqi7l2J+CTSCeiqu277Os/KP4fDGyw7fG48h1fd6UNzYsVpI4o1du/s
         er9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725456; x=1754330256;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mx8DvbGzit5IZkHXHj0j5BlFANu3M7t2Ru4Wnf2fZVo=;
        b=Lnz4w3S6TcAWou1m1ZtsBLRsdEvAskZxoJ3Bfx4RfQP5RAWu2UE2dhon/zorxH2sVw
         47y1py8C7JOK0U94DZQsHLtwYryfCXw0fs2U462aIh2WSID5eh4ax0l0+NyPackVSTle
         i6DrPSn7o4VeGcr4hsi0ghwtrHhoCdaPHeMBKv5hGky3uhOzlCmnAgINOSFi/c3t2UI0
         nDjT3nODLWpLl9ZJJWqhVIiUO5W2+VcR3XqAH/mHldB+KesRqh4Mnygz3IVnT58uXxUM
         aTa5IPw8z5dJGsuigr2mRx45zvh89in9B5V0xSsx2EM3piuiS/AjuGG+V1LnCi4WeODR
         GRZw==
X-Gm-Message-State: AOJu0YxZkWjOsv0qzpgUSWNhrkvFJLcQIdhEbWUE/DavSxufbxo1noeN
	eVdTnYrmLgw0TXNPytLXedr6p0k54MtrDIKi6kKyYd5OBsoDXEslrAEhdSYAWZ/2Z9Bs9uHHOx/
	jfNZGjQ8BrugUMemOVVvTrp7p0XTfcBSymTibldIlHfvKSmblfElAzI9A84AdGdJ+iktg2mncNP
	rfD7bS1R7hwpdHcG/XDYan2yUwof1V2iZrKlrnEJOfZwkMeMLm89mm
X-Google-Smtp-Source: AGHT+IHOZdJhyGXTQAnN7AqN5YudqnciqmWtQDUn8xdtkiC0/nQmX3CoQ0RobOugLl7EuK3NQIO/IYDbBlfebOs=
X-Received: from pjvv12.prod.google.com ([2002:a17:90b:588c:b0:2fb:fa85:1678])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5845:b0:30e:3718:e9d with SMTP id 98e67ed59e1d1-31e77a45a43mr18187553a91.35.1753725454522;
 Mon, 28 Jul 2025 10:57:34 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:56:59 +0000
In-Reply-To: <20250728175701.3286764-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com> <20250728175701.3286764-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175701.3286764-7-jtoantran@google.com>
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



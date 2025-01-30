Return-Path: <stable+bounces-111729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E59DA233A7
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 19:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305033A5F5F
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 18:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9DA1EC00D;
	Thu, 30 Jan 2025 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NmTqDmph";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b8gk1SG7"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97919DFAB;
	Thu, 30 Jan 2025 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738261129; cv=none; b=njm2n+LdTlHqbRY0S/X0u5lUCdaIvu/0t3fDxoSewCnNMD+GulDiMapG5ei5PJAKhV+KlEKl3soGAF8/5MkDcHLjHM4LYlks5Ut53GI/atGt2ZwAUyPZdWyzLliCorKdIL2oLagJUTe4MQrkpB8w+t8cgKL+Yqk82AywKb8wUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738261129; c=relaxed/simple;
	bh=KJUTP6Ek1Gc0jGJVkkYqdf/IY+6rz2K7560qZXdsZEM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=JJNSlWWaU7haKtGx6WwMM6mhU1KHf9Q+QxSej0VB1JUQVqJ+l3UhT5ZOyPNVTsWhC3UJuErhxzs63UVgGyZl32iLeD5Q9A/niAsCHcCeiw7OixHcmTz+jRx2P50zP2wf1Md/emaVf/dStVAnRW18EBWScSbLcvwt1Yx116H/DbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NmTqDmph; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b8gk1SG7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 30 Jan 2025 18:18:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738261121;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rhdwdOeCylo2ySDmBC79sqPq7Y07CQQKD/YoUmULl7w=;
	b=NmTqDmphZv8G9D6Yw+OHBjYQL11Je4vqtUm2hAn1Lj17PWC9oU/lv5C2Q93UA2VqXnzdpM
	ysxoCgbk0ySRT/sIK5ZjS6iYtvgsGDkBVxvjCqig/KOwCGiX5xQVjj/NduGtKUhWtZLSaU
	vQDLLvKgR32Qeuatr5hm00MfEVdZpEC+s3kC3LLFKaUzakxDyRjwfahlCAR6LGq04Lk87X
	R0PsBj07rEWg5G4h450r6kDlkt3Q5CF2I4p56hwy/fUBhs9WA2T7ztiBwqWMcGuNdwMAiV
	h9E/PrKK1R/lvIDTQX8IZMWHdiui5ObSYJbqaOr0hAEdymKwqlDzzNsHXXTYCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738261121;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rhdwdOeCylo2ySDmBC79sqPq7Y07CQQKD/YoUmULl7w=;
	b=b8gk1SG73yEGJ1j12zZ0FOAn963vpyyv+Bc+OPZ9KhTmYGkZp2vmVvGAlaeisqSMNrAZF0
	C9edhYgpZPZPSHAw==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot: Use '-std=gnu11' to fix build with GCC 15
Cc: Kostadin Shishmanov <kostadinshishmanov@protonmail.com>,
 Jakub Jelinek <jakub@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173826111721.31546.13704348787528502062.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ee2ab467bddfb2d7f68d996dbab94d7b88f8eaf7
Gitweb:        https://git.kernel.org/tip/ee2ab467bddfb2d7f68d996dbab94d7b88f=
8eaf7
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Tue, 21 Jan 2025 18:11:33 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 30 Jan 2025 09:59:24 -08:00

x86/boot: Use '-std=3Dgnu11' to fix build with GCC 15

GCC 15 changed the default C standard version to C23, which should not
have impacted the kernel because it requests the gnu11 standard via
'-std=3D' in the main Makefile. However, the x86 compressed boot Makefile
uses its own set of KBUILD_CFLAGS without a '-std=3D' value (i.e., using
the default), resulting in errors from the kernel's definitions of bool,
true, and false in stddef.h, which are reserved keywords under C23.

  ./include/linux/stddef.h:11:9: error: expected identifier before =E2=80=98f=
alse=E2=80=99
     11 |         false   =3D 0,
  ./include/linux/types.h:35:33: error: two or more data types in declaration=
 specifiers
     35 | typedef _Bool                   bool;

Set '-std=3Dgnu11' in the x86 compressed boot Makefile to resolve the
error and consistently use the same C standard version for the entire
kernel.

Closes: https://lore.kernel.org/4OAhbllK7x4QJGpZjkYjtBYNLd_2whHx9oFiuZcGwtVR4=
hIzvduultkgfAIRZI3vQpZylu7Gl929HaYFRGeMEalWCpeMzCIIhLxxRhq4U-Y=3D@protonmail.=
com/
Closes: https://lore.kernel.org/Z4467umXR2PZ0M1H@tucnak/
Reported-by: Kostadin Shishmanov <kostadinshishmanov@protonmail.com>
Reported-by: Jakub Jelinek <jakub@redhat.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250121-x86-use-std-consistently-gcc-15-v1=
-1-8ab0acf645cb%40kernel.org
---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Mak=
efile
index f205164..606c74f 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -25,6 +25,7 @@ targets :=3D vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin=
.bz2 vmlinux.bin.lzma \
 # avoid errors with '-march=3Di386', and future flags may depend on the targ=
et to
 # be valid.
 KBUILD_CFLAGS :=3D -m$(BITS) -O2 $(CLANG_FLAGS)
+KBUILD_CFLAGS +=3D -std=3Dgnu11
 KBUILD_CFLAGS +=3D -fno-strict-aliasing -fPIE
 KBUILD_CFLAGS +=3D -Wundef
 KBUILD_CFLAGS +=3D -DDISABLE_BRANCH_PROFILING


Return-Path: <stable+bounces-52186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F6908ACA
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 13:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099682815E1
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 11:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB6F194A48;
	Fri, 14 Jun 2024 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="PilTGbc7"
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E95193064
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364484; cv=none; b=cM/cYZrvR79Pg5eG5Eoe6Y/rzq9RPwY3QJge7zGOusxAFCTsCp0iJJJN27Vby+HkBz4KNtk/A6ufQqY4XjP34mS8IhxW7VmZeg7faH2p7Cqm4mijS/Tg5Mh72yAxda7mLyssvehghGMEugQFzr1S6mdlB4pozS7yTVY9ENYaTwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364484; c=relaxed/simple;
	bh=kzt+P29xnZNp+taR4beO6gV/WyPkAP4aSvhUsm8J1vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDv1xOz7aDvjCsKV+cZvBCrv4g1ggKq2CkwdlqaeIQvb2x86uc87SyCYKuaZQaSfcy4c+TQOaWNTA5tfFtNWdFDePyEZO9gR1DcE/IFzHhc8Dr1ldWWwuRfdZam//1zLtTHBrDj5WpM/HMRprwwEUkcyD9FZ/xZxunDroV8sOek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=PilTGbc7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718364480;
	bh=7QvapBUZMia0j8j9NgqwjdVQPcasgkaRydVGXAQi2zQ=;
	h=From:To:Cc:Subject:Date:From;
	b=PilTGbc7A9QGyO6tlyCrOXj4aXtQP3U3SRmXW5ZFpnV9O1Ru/Ouiu9g8AIAGv5jrN
	 PW9hQUGz4hcepQZLFyy1XtLk0vyaNDClu1zU/gw93BD5us/RtbaziJLYJQyLFmf1F2
	 Q2iTdNy1CLWPD0H6/FS7ntOgkk4iqjmMd/+fowVdw9vX9cJcqObbiNdwunicK4jmHu
	 gLdQaWIbX8Fkxe5ElLv2LIqWuIcPvsmUezPOg7R812PGqa6+RBdKUG50X2As+wvNEo
	 /8xTUZm6zv0n1++nFBzKuvpvT6z9MHHuz9RxMbap2UpDX5cw1k5KkYCSR4GRQVt4f+
	 IKmE8cqXl6A3Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W0xpm2KN7z4wcC;
	Fri, 14 Jun 2024 21:28:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <stable@vger.kernel.org>
Cc: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v6.1] powerpc/uaccess: Fix build errors seen with GCC 13/14
Date: Fri, 14 Jun 2024 21:27:49 +1000
Message-ID: <20240614112749.3482975-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 2d43cc701b96f910f50915ac4c2a0cae5deb734c upstream.

Building ppc64le_defconfig with GCC 14 fails with assembler errors:

    CC      fs/readdir.o
  /tmp/ccdQn0mD.s: Assembler messages:
  /tmp/ccdQn0mD.s:212: Error: operand out of domain (18 is not a multiple of 4)
  /tmp/ccdQn0mD.s:226: Error: operand out of domain (18 is not a multiple of 4)
  ... [6 lines]
  /tmp/ccdQn0mD.s:1699: Error: operand out of domain (18 is not a multiple of 4)

A snippet of the asm shows:

  # ../fs/readdir.c:210:         unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
         ld 9,0(29)       # MEM[(u64 *)name_38(D) + _88 * 1], MEM[(u64 *)name_38(D) + _88 * 1]
  # 210 "../fs/readdir.c" 1
         1:      std 9,18(8)     # put_user       # *__pus_addr_52, MEM[(u64 *)name_38(D) + _88 * 1]

The 'std' instruction requires a 4-byte aligned displacement because
it is a DS-form instruction, and as the assembler says, 18 is not a
multiple of 4.

A similar error is seen with GCC 13 and CONFIG_UBSAN_SIGNED_WRAP=y.

The fix is to change the constraint on the memory operand to put_user(),
from "m" which is a general memory reference to "YZ".

The "Z" constraint is documented in the GCC manual PowerPC machine
constraints, and specifies a "memory operand accessed with indexed or
indirect addressing". "Y" is not documented in the manual but specifies
a "memory operand for a DS-form instruction". Using both allows the
compiler to generate a DS-form "std" or X-form "stdx" as appropriate.

Unfortunately clang doesn't support the "Y" constraint so that has to be
behind an ifdef.

Although the build error is only seen with GCC 13/14, that appears
to just be luck. The constraint has been incorrect since it was first
added.

Fixes: c20beffeec3c ("powerpc/uaccess: Use flexible addressing with __put_user()/__get_user()")
Suggested-by: Kewen Lin <linkw@gcc.gnu.org>
[mpe: Drop CONFIG_PPC_KERNEL_PREFIXED ifdef for backport]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240529123029.146953-1-mpe@ellerman.id.au
---
 arch/powerpc/include/asm/uaccess.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 45d4c9cf3f3a..661046150e49 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -80,9 +80,20 @@ __pu_failed:							\
 		:						\
 		: label)
 
+#ifdef CONFIG_CC_IS_CLANG
+#define DS_FORM_CONSTRAINT "Z<>"
+#else
+#define DS_FORM_CONSTRAINT "YZ<>"
+#endif
+
 #ifdef __powerpc64__
-#define __put_user_asm2_goto(x, ptr, label)			\
-	__put_user_asm_goto(x, ptr, label, "std")
+#define __put_user_asm2_goto(x, addr, label)			\
+	asm goto ("1: std%U1%X1 %0,%1	# put_user\n"		\
+		EX_TABLE(1b, %l2)				\
+		:						\
+		: "r" (x), DS_FORM_CONSTRAINT (*addr)		\
+		:						\
+		: label)
 #else /* __powerpc64__ */
 #define __put_user_asm2_goto(x, addr, label)			\
 	asm goto(					\
-- 
2.45.1



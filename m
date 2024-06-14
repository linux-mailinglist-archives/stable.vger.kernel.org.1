Return-Path: <stable+bounces-52185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D11908AC7
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 13:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312E31F2839A
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 11:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F5B195B04;
	Fri, 14 Jun 2024 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="HDRqOyt2"
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D660913B2AD
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364467; cv=none; b=FZGlCecO3KjDA8VkW75FlaliVtXH2pYbxUzzw14yV5W3ckoeg0VFaX/q9X4KKU177ejOTHCNHX9sqL+AzYjiFBobCgn7Ai/LqycB5p5odUc2RdcAW6lHFb0Vudfbgg4f1PPL0i4UzA0bs6QV6WWo4g4MjJuw92y/ZPNmGp2S11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364467; c=relaxed/simple;
	bh=EpAe31OZ+mBC8VNhcvz9Y3ncZAwk9HfZ0CYwffftzSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4XtVevoXzpmUSfrbqVu7thppY2+IhgudVto2L5PaHlw9yeE2gvrj56bFIa8fIy+HxIQCFBzn462I9UbH7PS4n14orb24+rJiNtJcxcVPVPWNFaE3hsXWTx6oDFLYkROvOKKP+rKA1o3sahoKYF7SEd7wVD1HmWy6M6YPepJyLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=HDRqOyt2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718364463;
	bh=7gppcvHTZmlspy/+NJ1PKqP/0pbXM0SdZyYHmhfIhbs=;
	h=From:To:Cc:Subject:Date:From;
	b=HDRqOyt2f0/NjZKYa+A6N6ydYNbQyF4m2Jz+vx4ubWyiYPHmIzXuPxENs41+8OPaK
	 aqP3BBZeu4XkutieWyyfF3JUPML4HoxjEcFxiADaFA9ot/bZLOSBrCkFXliiELIgKh
	 bgzmHaP2JQcTS4OL2l1uKTuw3JOhj/aVfv8/TjdQiUiXYo9CvqRp3xG8DvOYxl9KnS
	 BYBbT/H1Yvtk55Ypl7DoTJwgGcheDWm/BIMN+v2AhzYxu0Ki+oREOklFaTmLxDrZBy
	 VvdRd2Ubw+26Zbluow66DwZc2ZIXC0h56JWB34LbixJGRNc4OmwVWIN8Za/j/FcaUT
	 Ul8VOd76XECUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W0xpR1Lx0z4wyw;
	Fri, 14 Jun 2024 21:27:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <stable@vger.kernel.org>
Cc: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v5.15] powerpc/uaccess: Fix build errors seen with GCC 13/14
Date: Fri, 14 Jun 2024 21:27:34 +1000
Message-ID: <20240614112734.3482854-1-mpe@ellerman.id.au>
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
index b2680070d65d..6013a7fc74ba 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -90,9 +90,20 @@ __pu_failed:							\
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
 	asm_volatile_goto(					\
-- 
2.45.1



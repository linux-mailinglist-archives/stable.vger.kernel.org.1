Return-Path: <stable+bounces-40241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8859B8AA9D0
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D48E8B21586
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5722B4D59F;
	Fri, 19 Apr 2024 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sFWLAZn0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04784DA0D
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514301; cv=none; b=ejNiWX6rX1PPHLs+HEBZ69zArCoD/AOzSzsrxCGlm9Y7nVKPGzdcr7+fo0/ghrqVHOrKbzxleYKtSp9pCj6zPsiLqDl14LJZ3jgtXjEUQA6aczS5/Z4c14p8kJp/eDl+FkcMiZ1g6tRCYj/RKC/c2ZgFnb3xr7QhmG+f0kwQnbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514301; c=relaxed/simple;
	bh=F4+Qqi6XLQsL/9QmIZVJUnP3MUPLiGLRgKjzal28MIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OkfEwoDxgbHrwnAG5F6YNPwdiyKeLu840cX4vn9FYf9ZKw2ALLvq7iNMR7fGB1zEGZTgWTzADyhERqzBFEek5y4ZlPiFKiQJShqviCtYNTWlJZBl5TE2vzRNaXjAZrDnyFcasF5Ksekn6QEkVIxzPaf3TVn9ZfskNJ17lowNFEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sFWLAZn0; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4165339d3a5so9921475e9.3
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514297; x=1714119097; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FR6+OhOPJAepgZ5WSg4/zCOAwzHlW7iK6WO4mZo7iz0=;
        b=sFWLAZn0pdVxM+LfvkKXWmrdBACj8yeNVLXyD3arKswwCWG7FXrE1HLmfeNzPkaJGq
         yOIq3gHx3McfrjiwVTmzYgWmOR+H5UOgkKF0wFiNZ2tf5RcLSd7bxYI/7Hh9ZPdbxS03
         2MMVpP8b6WeVOuRgHnqCuUdkv6BA/7lA47G0ETcvD/rRroPPl8q65ZNwwtUtliy+zdPR
         aORTPgFJ0TkIQTTSljsyU2GYVCUlEknwcx0Ff2W8Wh4zyJxHrb9n9Ewnz4+hmnTiyKGY
         VW4cSIeaFdY08mVpqBFrdU6OJEJ5hioiBzLfVGocBlGOKRPOdgdT3uvZb/fMCZzn9V9c
         IP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514297; x=1714119097;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FR6+OhOPJAepgZ5WSg4/zCOAwzHlW7iK6WO4mZo7iz0=;
        b=RDR3cZmcUFiN/VF+/3ZJ7KyES3P2uC2mSI5wZCQPlR3Of7FlbkTJQvSRNoZtoSDR+T
         zXrwsMAo9fpxxz5mSGLfZspNpRf/VEIakWO4AufbiSEJ4f7xgt0/plgdjhWGo/odIxrP
         72f1xxWbeNG52Qqs8ef56tpWJ0+jvvfb6HOWHKfQqEi0VM5cs4qF9BBTc0S03UlOW6cl
         DPBTzmZj6LB+LVfYuZy18fuB+GiaQXzezc3fM5TXqa7dvgxLqsTUK7xoyplTPR76hopH
         3YDU9z8pZ3Pp4jgfF5F/4juyy9SYIy29LsuSMzO+BZ0q37o4cHmL1WIczP0fqDEjIv22
         v8yQ==
X-Gm-Message-State: AOJu0Yyzw0cLFG39TwFpvVSXhemVAZNmET/1QWBhAjVpYKbWnpZIQqlU
	uB0mMvyKGSZ0JV7XOWLmvzFAadGht2TrKT8++HbcJQ2WDQ13ai1Kuftt3FdpxOiB1h8z64xDdpU
	GPQIkozfUpG+Kn3TyvGRGtcUBb5GDvbzGHF08r/5yyCJQcLQNPF4YITXbyza4hic5dH5+ID50xv
	uKTQmDxCVFvnFJ8v8LudyhfA==
X-Google-Smtp-Source: AGHT+IEZdvNT/TfMtgpiCjpXbHcvduMOkX7X/Lg075hxSD/QKKK3O0NUfmcpXrMH438hEFChZFWbQb4H
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:444e:b0:418:683d:60db with SMTP id
 v14-20020a05600c444e00b00418683d60dbmr13322wmn.6.1713514297471; Fri, 19 Apr
 2024 01:11:37 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:11 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3258; i=ardb@kernel.org;
 h=from:subject; bh=FORMdqsqrOwwtFoeASpvvueIc46ZThlLDZ+6im4TeTs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXdZw8+m3TjHmXSY61kduN96WOtP8Y1IF4+02uek/m
 8K3/ejsKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABMRd2VkmNnh7jCr/VWTOHMp
 16wtR1ZqJrVvq+r68bWRK0f+3qddrxh+s65W3zx3QXerwt6pDqVnZa/OzPe+zrz0qaisXfYd/iJ mdgA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-30-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 05/23] x86/boot: Remove the 'bugger off' message
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 768171d7ebbce005210e1cf8456f043304805c15 upstream ]

Ancient (pre-2003) x86 kernels could boot from a floppy disk straight from
the BIOS, using a small real mode boot stub at the start of the image
where the BIOS would expect the boot record (or boot block) to appear.

Due to its limitations (kernel size < 1 MiB, no support for IDE, USB or
El Torito floppy emulation), this support was dropped, and a Linux aware
bootloader is now always required to boot the kernel from a legacy BIOS.

To smoothen this transition, the boot stub was not removed entirely, but
replaced with one that just prints an error message telling the user to
install a bootloader.

As it is unlikely that anyone doing direct floppy boot with such an
ancient kernel is going to upgrade to v6.5+ and expect that this boot
method still works, printing this message is kind of pointless, and so
it should be possible to remove the logic that emits it.

Let's free up this space so it can be used to expand the PE header in a
subsequent patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://lore.kernel.org/r/20230912090051.4014114-21-ardb@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S | 49 --------------------
 arch/x86/boot/setup.ld |  7 +--
 2 files changed, 4 insertions(+), 52 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 38b611eb1a3c..b8d241e57b49 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -38,63 +38,14 @@ SYSSEG		= 0x1000		/* historical load address >> 4 */
 
 	.code16
 	.section ".bstext", "ax"
-
-	.global bootsect_start
-bootsect_start:
 #ifdef CONFIG_EFI_STUB
 	# "MZ", MS-DOS header
 	.word	MZ_MAGIC
-#endif
-
-	# Normalize the start address
-	ljmp	$BOOTSEG, $start2
-
-start2:
-	movw	%cs, %ax
-	movw	%ax, %ds
-	movw	%ax, %es
-	movw	%ax, %ss
-	xorw	%sp, %sp
-	sti
-	cld
-
-	movw	$bugger_off_msg, %si
-
-msg_loop:
-	lodsb
-	andb	%al, %al
-	jz	bs_die
-	movb	$0xe, %ah
-	movw	$7, %bx
-	int	$0x10
-	jmp	msg_loop
-
-bs_die:
-	# Allow the user to press a key, then reboot
-	xorw	%ax, %ax
-	int	$0x16
-	int	$0x19
-
-	# int 0x19 should never return.  In case it does anyway,
-	# invoke the BIOS reset code...
-	ljmp	$0xf000,$0xfff0
-
-#ifdef CONFIG_EFI_STUB
 	.org	0x3c
 	#
 	# Offset to the PE header.
 	#
 	.long	pe_header
-#endif /* CONFIG_EFI_STUB */
-
-	.section ".bsdata", "a"
-bugger_off_msg:
-	.ascii	"Use a boot loader.\r\n"
-	.ascii	"\n"
-	.ascii	"Remove disk and press any key to reboot...\r\n"
-	.byte	0
-
-#ifdef CONFIG_EFI_STUB
 pe_header:
 	.long	PE_MAGIC
 
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 49546c247ae2..b11c45b9e51e 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -10,10 +10,11 @@ ENTRY(_start)
 SECTIONS
 {
 	. = 0;
-	.bstext		: { *(.bstext) }
-	.bsdata		: { *(.bsdata) }
+	.bstext	: {
+		*(.bstext)
+		. = 495;
+	} =0xffffffff
 
-	. = 495;
 	.header		: { *(.header) }
 	.entrytext	: { *(.entrytext) }
 	.inittext	: { *(.inittext) }
-- 
2.44.0.769.g3c40516874-goog



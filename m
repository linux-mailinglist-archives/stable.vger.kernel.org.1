Return-Path: <stable+bounces-20009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2729853863
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55822B29DFC
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEB6605C7;
	Tue, 13 Feb 2024 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E4872YC2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B052605C1;
	Tue, 13 Feb 2024 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845756; cv=none; b=mX3LAa1Xx6Ta15kLG5cwZ4NRZAzww1kZi1s56kFsI1SroGpRGa06kC00HTvEctIk3HJLvC+1Eag+l95kclKzW0Z+gx6ZkpW1vNFtz19mQRWXY6fJrzqr5nIi0YhsEINlY1codIJgqHydUMcLR7AVYpbkTxgMulmcLxBvNBoAw5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845756; c=relaxed/simple;
	bh=dohQ7W3ep41G7ZgXAOaNDn8ouWcG9bxnxbnfMyecECE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzKk2VESr7BRoNLuqxhSBjKCjKr8nBzSsvxG+0QrNaq9/U6GF/BdsGeqfqMcVDeB84hurURCPesFwU3DqM/iehtuCD01u05qsx8z+Yf35WMK9xiQd5xqmRguvFTF4Kv+YyHck/jS7K/pM4sUWCMOBrhRQKxKrM/hazeB66Xkv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E4872YC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837E0C433F1;
	Tue, 13 Feb 2024 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845755;
	bh=dohQ7W3ep41G7ZgXAOaNDn8ouWcG9bxnxbnfMyecECE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4872YC2tUAzvBQ7Hs1rQ9R4j0ZAFIaQIsq0kY/zJdPIXd/wFUN3eraBCuOT+Due0
	 qERrhtvqwUTTYp2ufHRh0VrVvJA0hiVmD0Qcjeu+WeO/CnBdtd/GReugruVgq6Mq2E
	 N95RtTjXbshTo1lKJ4s2eQr/01hZjmU6lK5/kZXw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mike Beaton <mjsbeaton@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 048/124] x86/efistub: Use 1:1 file:memory mapping for PE/COFF .compat section
Date: Tue, 13 Feb 2024 18:21:10 +0100
Message-ID: <20240213171855.139118700@linuxfoundation.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213171853.722912593@linuxfoundation.org>
References: <20240213171853.722912593@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit 1ad55cecf22f05f1c884adf63cc09d3c3e609ebf ]

The .compat section is a dummy PE section that contains the address of
the 32-bit entrypoint of the 64-bit kernel image if it is bootable from
32-bit firmware (i.e., CONFIG_EFI_MIXED=y)

This section is only 8 bytes in size and is only referenced from the
loader, and so it is placed at the end of the memory view of the image,
to avoid the need for padding it to 4k, which is required for sections
appearing in the middle of the image.

Unfortunately, this violates the PE/COFF spec, and even if most EFI
loaders will work correctly (including the Tianocore reference
implementation), PE loaders do exist that reject such images, on the
basis that both the file and memory views of the file contents should be
described by the section headers in a monotonically increasing manner
without leaving any gaps.

So reorganize the sections to avoid this issue. This results in a slight
padding overhead (< 4k) which can be avoided if desired by disabling
CONFIG_EFI_MIXED (which is only needed in rare cases these days)

Fixes: 3e3eabe26dc8 ("x86/boot: Increase section and file alignment to 4k/512")
Reported-by: Mike Beaton <mjsbeaton@gmail.com>
Link: https://lkml.kernel.org/r/CAHzAAWQ6srV6LVNdmfbJhOwhBw5ZzxxZZ07aHt9oKkfYAdvuQQ%40mail.gmail.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/header.S | 14 ++++++--------
 arch/x86/boot/setup.ld |  6 +++---
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b2771710ed98..a1bbedd989e4 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -106,8 +106,7 @@ extra_header_fields:
 	.word	0				# MinorSubsystemVersion
 	.long	0				# Win32VersionValue
 
-	.long	setup_size + ZO__end + pecompat_vsize
-						# SizeOfImage
+	.long	setup_size + ZO__end		# SizeOfImage
 
 	.long	salign				# SizeOfHeaders
 	.long	0				# CheckSum
@@ -143,7 +142,7 @@ section_table:
 	.ascii	".setup"
 	.byte	0
 	.byte	0
-	.long	setup_size - salign 		# VirtualSize
+	.long	pecompat_fstart - salign 	# VirtualSize
 	.long	salign				# VirtualAddress
 	.long	pecompat_fstart - salign	# SizeOfRawData
 	.long	salign				# PointerToRawData
@@ -156,8 +155,8 @@ section_table:
 #ifdef CONFIG_EFI_MIXED
 	.asciz	".compat"
 
-	.long	8				# VirtualSize
-	.long	setup_size + ZO__end		# VirtualAddress
+	.long	pecompat_fsize			# VirtualSize
+	.long	pecompat_fstart			# VirtualAddress
 	.long	pecompat_fsize			# SizeOfRawData
 	.long	pecompat_fstart			# PointerToRawData
 
@@ -172,17 +171,16 @@ section_table:
 	 * modes this image supports.
 	 */
 	.pushsection ".pecompat", "a", @progbits
-	.balign	falign
-	.set	pecompat_vsize, salign
+	.balign	salign
 	.globl	pecompat_fstart
 pecompat_fstart:
 	.byte	0x1				# Version
 	.byte	8				# Size
 	.word	IMAGE_FILE_MACHINE_I386		# PE machine type
 	.long	setup_size + ZO_efi32_pe_entry	# Entrypoint
+	.byte	0x0				# Sentinel
 	.popsection
 #else
-	.set	pecompat_vsize, 0
 	.set	pecompat_fstart, setup_size
 #endif
 	.ascii	".text"
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 83bb7efad8ae..3a2d1360abb0 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -24,6 +24,9 @@ SECTIONS
 	.text		: { *(.text .text.*) }
 	.text32		: { *(.text32) }
 
+	.pecompat	: { *(.pecompat) }
+	PROVIDE(pecompat_fsize = setup_size - pecompat_fstart);
+
 	. = ALIGN(16);
 	.rodata		: { *(.rodata*) }
 
@@ -36,9 +39,6 @@ SECTIONS
 	. = ALIGN(16);
 	.data		: { *(.data*) }
 
-	.pecompat	: { *(.pecompat) }
-	PROVIDE(pecompat_fsize = setup_size - pecompat_fstart);
-
 	.signature	: {
 		setup_sig = .;
 		LONG(0x5a5aaa55)
-- 
2.43.0





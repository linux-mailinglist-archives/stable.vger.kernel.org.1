Return-Path: <stable+bounces-45601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B158CC8B2
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 00:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6D81C21171
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 22:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B233B147C8B;
	Wed, 22 May 2024 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="fQ5BtJb/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fiMWoFh0"
X-Original-To: stable@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F132D1474BD;
	Wed, 22 May 2024 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415350; cv=none; b=KtiSv7flzwPYy4EgtGiCWFCToHN8QR7Y7dV14Xs/zzuPARBGd3U+R+UjE4H9WNppl1fgfd3IC21uvwVhNJFvWMqa+Iu9drcGheJ2o2dEEQTItNKKEDqmE7gl8rSJFbO6gnCEIQhKeHV6RQTzx6BvD9UBApuxT5Jx+AE1G9+5tPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415350; c=relaxed/simple;
	bh=1Q2dN42Jc6XMY6IY/L+aUvZd2sXvflcnb4Ia2Z4YZuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IdZHwZjF3q1Rs8+fZPuIAgrKTflMoLY5EWJ9yxBzc71vGa9P1AVYJpzD2yKTVscwWUQw6NSQMSEnI+4AnDRRW69L2bL7v5aR/FqJay3PV1amD92XPSEvomR0e43QI6afVMrx7GtoNNd5dPomYWrqvVNpdcGepE7h1dsYV4X+bIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=fQ5BtJb/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fiMWoFh0; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 2775B1C00179;
	Wed, 22 May 2024 18:02:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 22 May 2024 18:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1716415347;
	 x=1716501747; bh=l4RdnwZLrrMJqJbIODVZeyilD98Kk2WEdlmw6Uei4v0=; b=
	fQ5BtJb/H03wvu97EskdLP6HQ5Jxnif8q/CzgOuPY1j/UeMyml0QFf1LKxU3ayDp
	RhC4+VKtT7tJb3b5fGMaul7hw4TdCjR29xLwUlrc8rC7KZeIcywcUuKvXHW9Fdwf
	QV/pZWtbP3AbD8eU9dEP8HhEfNhaxA/QVEaHnb0EPaoiFc2UGu2VVxBTkiis83W/
	9aaHlUZnreStVmDV4OVyuKaBLb0D9F/I3oe2xrl7rUfxU3rmKqRBUpyQvw3F5IfR
	1SM4alWYCzmR2R8yTJ0Fpjz6BdeYwvPpm4I4R32rKn8eOA1EkVAmuBh23HHHTOXb
	2ONU7thqPvSfG/HTSsuKAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716415347; x=
	1716501747; bh=l4RdnwZLrrMJqJbIODVZeyilD98Kk2WEdlmw6Uei4v0=; b=f
	iMWoFh04xxYK0PEBRdMxz3yP0HS8csCcovacGCR0syna1GoXySCb8nsTf2cG6pYd
	5jkxhZf9g36i/SoZAhV3g/fVY1zGPJ4ze7Tfa/LHUldLtgVItYjgEQw/PhVixQiZ
	sqmspLE4mc3ECjahweTYXhKjWofJgRNedgF7AOLhZAs5S3mduwHi3VB6acZ65OQ/
	e+s8IJGpXn0UjuGT0wxlJ/gKB9Frv746htBVijRdDXE11kJnxArkQqVEceuLQV4z
	p53ehXgaJzETjtYyLOkNcFTQD0zGg1RTNAAN7JZ+7ERUuFX/tQL3Ti0kOHtpyqPe
	iSPjFeuB1S93/aD/0oJTA==
X-ME-Sender: <xms:c2tOZut_55i438h5Ra9UxzTnnt-ur3NZZcfij_3NkOd_j0USLoVQHQ>
    <xme:c2tOZje1GBaSmUIBJt0r4OeGL76EkgAGgmDO5ghc3hY6Q-nAxWsxoEiNHrQYKoYy9
    yXybGgpS2gMD0tw1Qo>
X-ME-Received: <xmr:c2tOZpzqaFPc12EGaiJmkGjlzmdO-HagaNWyL6x5M3GFbzGqF-OgaGE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeihedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepleegffffiedvueeigeeihfevfeehhedvvddtiedujeehkeev
    jedtkeegfeffhfejnecuffhomhgrihhnpehhvggrugdrshgspdhhvggruggvrhdrohhrgh
    dprhgrmhdrohhrghdplhgushdrshgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:c2tOZpN4J5vUZTUa4B300aGwPXpNWJqNTPmwqfVSAhSDqXfGmGXGIA>
    <xmx:c2tOZu8s6mM5YMqA3xSSzkD2zUj9fuGFfFaooL2f5cuoVAORitoVTg>
    <xmx:c2tOZhV4Th4TPf-h8y7UdKInmzFczFmU5GLQKPSo4gRVnfhx8QFW0A>
    <xmx:c2tOZneQRcOt6hdI44xNor5TcJYyL-hUmfsSl40-oygcunVOrVUT6w>
    <xmx:c2tOZuy1sGPDIvg_b_63PBXFjxpRej7r7VrNbBt7rhwPsQ6P1KHEverU>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 18:02:26 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 23:02:19 +0100
Subject: [PATCH v3 3/4] LoongArch: Fix entry point in image header
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-booting-fixes-v3-3-25e77a8fc86e@flygoat.com>
References: <20240522-loongarch-booting-fixes-v3-0-25e77a8fc86e@flygoat.com>
In-Reply-To: <20240522-loongarch-booting-fixes-v3-0-25e77a8fc86e@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=1Q2dN42Jc6XMY6IY/L+aUvZd2sXvflcnb4Ia2Z4YZuA=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjS/7Jxq64gJLjukI86vDOl2slBnnsr0ONurWJ6vUy5KS
 6+Fj6ejlIVBjItBVkyRJURAqW9D48UF1x9k/YGZw8oEMoSBi1MAJlIyheGfanbeOWkj11+9m86u
 aNxg0W9wUNiM4dkn++7khJrH58SMGRlWrZnXJfK2O1RxhVjF2ya5W/K+VRHSUpFLPCXzIk5lzmE
 CAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Currently kernel entry in head.S is in DMW address range,
firmware is instructed to jump to this address after loading
the image.

However kernel should not make any assumption on firmware's
DMW setting, thus the entry point should be a physical address
falls into direct translation region.

Fix by converting entry address to physical and amend entry
calculation logic in libstub accordingly.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Fix efistub
v3: Move calculation to linker script
---
 arch/loongarch/kernel/head.S             | 2 +-
 arch/loongarch/kernel/vmlinux.lds.S      | 2 ++
 drivers/firmware/efi/libstub/loongarch.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index c4f7de2e2805..2cdc1ea808d9 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -22,7 +22,7 @@
 _head:
 	.word	MZ_MAGIC		/* "MZ", MS-DOS header */
 	.org	0x8
-	.dword	kernel_entry		/* Kernel entry point */
+	.dword	_kernel_entry_phys	/* Kernel entry point (physical address) */
 	.dword	_kernel_asize		/* Kernel image effective size */
 	.quad	PHYS_LINK_KADDR		/* Kernel image load offset from start of RAM */
 	.org	0x38			/* 0x20 ~ 0x37 reserved */
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index e8e97dbf9ca4..c6f89e51257a 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
 
 #define PAGE_SIZE _PAGE_SIZE
 #define RO_EXCEPTION_TABLE_ALIGN	4
+#define TO_PHYS_MASK			0x000fffffffffffff /* 48-bit */
 
 /*
  * Put .bss..swapper_pg_dir as the first thing in .bss. This will
@@ -142,6 +143,7 @@ SECTIONS
 
 #ifdef CONFIG_EFI_STUB
 	/* header symbols */
+	_kernel_entry_phys = kernel_entry & TO_PHYS_MASK;
 	_kernel_asize = _end - _text;
 	_kernel_fsize = _edata - _text;
 	_kernel_vsize = _end - __initdata_begin;
diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
index 684c9354637c..60c145121393 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -41,7 +41,7 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
 unsigned long __weak kernel_entry_address(unsigned long kernel_addr,
 		efi_loaded_image_t *image)
 {
-	return *(unsigned long *)(kernel_addr + 8) - VMLINUX_LOAD_ADDRESS + kernel_addr;
+	return *(unsigned long *)(kernel_addr + 8) - TO_PHYS(VMLINUX_LOAD_ADDRESS) + kernel_addr;
 }
 
 efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,

-- 
2.43.0



Return-Path: <stable+bounces-45555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302C48CBB60
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 08:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38051F2309B
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 06:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A87E0FC;
	Wed, 22 May 2024 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Sbs2rTEp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZVl3AV+Y"
X-Original-To: stable@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6CB7CF34;
	Wed, 22 May 2024 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716359430; cv=none; b=QK4m4jK3PnGfTtuLg/0PY5d3n3htoLcpFSn0R/YSoQxaV9EPWOxbcrdDKLUj6+VG+VJPGg3hA/AEgjtRg4dzbd+VoTCEDHOJaH466jmN1saGYXtsyo4gAUa+L19DdCfoa8rzGodDzRVvCeBQxJftwOW8w7bP5FujQkX65Hx/PW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716359430; c=relaxed/simple;
	bh=gTmfR3TyuSkIyI33dPFwnMQoUU/REBQal1l+rTKDhxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N/3Jfthonr0t+GvMTMlcv3Wlql7TQ/GH04Am/O5WIAHLFUOlY9BJiLG0WesdX/Ez7qrwhLXSIutBMQ1SATldC3r6gUHPHaDZS7L6zEILL9J+J7qxjsxNy8E8vk2i+rXtEReIo4fr81JiGVMJDzPUaeDUIZMXCPPtiZITLG1aA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Sbs2rTEp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZVl3AV+Y; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2E9CF11401ED;
	Wed, 22 May 2024 02:30:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 22 May 2024 02:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1716359427;
	 x=1716445827; bh=OvjxMEn+h3QhgfDTBmqSa7RU1eI0gRXkjUhWMA2M8CI=; b=
	Sbs2rTEpPHwnXO+ueozjdV8wogVpiRUQLzy6Y8vha241TwXhjJP035PgrHYpjMQd
	W1euniPLVLKDiW8PKigPCzrsd0hQD+GwMxtBW2hKmYngW48+f2RnhzyEWqMarFTQ
	V0nYlpMvHc6rKCHx0tV4KtfqFor9RevBrrQKELn0pI+EXZC9lAjdljf1g3RmFmWL
	N5XjuhEjHmSX4AJSFYzP+W+MtfAjnQoJ8OiI1q4A2ob+PYXAVohmbJ6l3D2OQroL
	RUEdz3bJoJNhlO/bPYCVkOzR+5Nw3vN+0Zzy2G/YSkU/Mdny5LjoYN4IkSWK2QK1
	U1PuitZt77Mo2PSBqwvbOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716359427; x=
	1716445827; bh=OvjxMEn+h3QhgfDTBmqSa7RU1eI0gRXkjUhWMA2M8CI=; b=Z
	Vl3AV+YD65CvfNH8uYxpabT+WolEoUwlwRr5ZZetxpQH23kroY+LcBhIl9zZGUqT
	Hyd3STJKZEaSK+lifIDYQQlTWGQATwMzu4ysKLIjAfLai53kcGNF1kbl/KGfW9El
	OA/6Yw2kGwIx9/mAfE+PsPgPv4/6TiTcult82iEGWdhGbWmyCw+7a+0ctzW2h8Y2
	9IklLroF4Vrpinu9sidNSDQXULqn30R/VevP2MRtUnoC7ixRcN2D4qBcyNtmjcNT
	FQpX/pFErjVBZD4wC1Cw/M/TcmM8otTZrKCZjbhtI0kQ3YDXT5ssV3h7jFbUqcCG
	AukCrQEOoJgnAiLOJRGmw==
X-ME-Sender: <xms:ApFNZggc_f5GQh1u1JUS5-688vO35LkDVH4Dqh79YGIoPyVMN6Euzg>
    <xme:ApFNZpA7Sghd9ikF8n13GDiJKGFfvYDlVPaS0kNpIGmAQNkucvKA_ReeUOdULZEeY
    hC8iDwg5IGUW_5wdEU>
X-ME-Received: <xmr:ApFNZoEUP_krz9zIc3NsyAY6ueb3NZTpl8rX1PMoHHTSM7Ql7qCNgmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhephefgueffudegueeiveefleelhfevhfdtudelhefgvdegvefh
    ieelveevffduvdfgnecuffhomhgrihhnpehhvggrugdrshgspdhhvggruggvrhdrohhrgh
    dprhgrmhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:A5FNZhQNF9Y326EBxjHePjkzemzOd3omFa_WAy_GMVuLdomeWIuiWQ>
    <xmx:A5FNZtxNRID7yROPw1izDFZy0cwsHH7R6lj7u2gBJl_hjjyHhx4JTQ>
    <xmx:A5FNZv5qvwru3eMcp1rY5_useqZnPHaCvuWseYnQHglCBa0GHxEkzA>
    <xmx:A5FNZqxTZubz4dZem9XnuYlrsU_iwAdqsH2KEu89DC7R9n_NM9g4mA>
    <xmx:A5FNZkmTiRed7DQw08gC7PzniFaAjy8mpbFXk1iSyB1sEsz7mTWABOx0>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 02:30:26 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 07:30:22 +0100
Subject: [PATCH v2 3/4] LoongArch: Fix entry point in image header
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-booting-fixes-v2-3-727edb96e548@flygoat.com>
References: <20240522-loongarch-booting-fixes-v2-0-727edb96e548@flygoat.com>
In-Reply-To: <20240522-loongarch-booting-fixes-v2-0-727edb96e548@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=gTmfR3TyuSkIyI33dPFwnMQoUU/REBQal1l+rTKDhxc=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTfCf8+JLza08dw5uRSr4d7ch76Vp/tzc66NCmSt2r9/
 Bn9y6PKO0pZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAintyMDPdvybLrqz1YsnOG
 Vo/fv4k3HKb/ddj2PMX7i5NI1455JxIYGdZYxW1wX2H3sa945UvhvvnBwcsc6pitdm1nmXbx+nb
 O3SwA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Currently kernel entry in head.S is in DMW address range,
firmware is instructed to jump to this address after loading
the image.

However kernel should not make any assumption on firmware's
DMW setting, thus the entry point should be a physical address
falls into direct translation region.

Fix by applying a calculation to the entry and amend entry
calculation logic in libstub accordingly.

Note that due to relocation restriction TO_PHYS can't be used
in assembly, we can only do plus and minus here.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Fix efistub
---
 arch/loongarch/kernel/head.S             | 2 +-
 drivers/firmware/efi/libstub/loongarch.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index c4f7de2e2805..1a83564023e1 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -22,7 +22,7 @@
 _head:
 	.word	MZ_MAGIC		/* "MZ", MS-DOS header */
 	.org	0x8
-	.dword	kernel_entry		/* Kernel entry point */
+	.dword	PHYS_LINK_KADDR + (kernel_entry	- _head)	/* Kernel entry point */
 	.dword	_kernel_asize		/* Kernel image effective size */
 	.quad	PHYS_LINK_KADDR		/* Kernel image load offset from start of RAM */
 	.org	0x38			/* 0x20 ~ 0x37 reserved */
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



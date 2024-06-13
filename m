Return-Path: <stable+bounces-52070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3965907874
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 18:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5881F236A6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 16:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC3E149C52;
	Thu, 13 Jun 2024 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="5vah7Otn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ck9ROGYk"
X-Original-To: stable@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C9148FFF;
	Thu, 13 Jun 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296901; cv=none; b=l3QrMrDBoN6nhQmh0X61F8L85C8juEwRYIxbLLXHY0T+PPKBgKs8Z1yHadEzmoTfPOJDCr29QzA0+GuUCoAXtEFgYLL9fZ+qlBu1VhxjkTlQLRcB7P+34DdXSQ8xFS2Bz4gyaBvKajQ51KE12Epwj0MoTxad0VyXDMA/NR3GGj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296901; c=relaxed/simple;
	bh=ylvLQTm7lYYDCejRFR9lGTs7S0TaD9j4Be9Usi3hi2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+5hm6/GpTgIRejmfo9WGQvbpDKrmS3JUAVAssJoZl3lW+WAbVvqIBJTe1caVb9CcQJMfeGXaQnydrpWiBB1oZ+UoiY3Cx3ioD7GTpIiF9bc3zw9qQ1yM0YkNM5N7rIO1gph2rIVq3lyb0/LLS9p5CQ1Qmoixe0ytJgR4g2Jmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=5vah7Otn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ck9ROGYk; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 223831140127;
	Thu, 13 Jun 2024 12:41:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 13 Jun 2024 12:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1718296899;
	 x=1718383299; bh=n6F8MEieZ+ouRp29tz+DavcsxJF3VY3gbNK6jTLLxVg=; b=
	5vah7OtnOcFwPlSrGHLS5mCc6mIZ7uUGmNLrDHp2xnEhHVZ1mRXLlJQtbP7A3PIl
	Xz5qZzBRGJHKGJWLaHkrMuwOc9GxMdSSykIXzrR3M5xi0FjDWj8+V2K/AAR38tkR
	8APjOM+bsLB9WIN1HTU1zusB+4oEW6pZf7gO+t0aDB3WAa6MD9WoW6EN9hxCioh7
	kfvyzjrGP/WlebgDVA+E53o+licCc1HxMqcBOU0oSdfCUGvtwLnaAYWD5O4BQPKf
	GsrbwI6tt4hTJ/420q9OMMSiCM/9v0pIft2WVmFjzcPnYMjcWx/FXL9kxOaR9wCK
	pSoTuBN9j11VPFIL9vo+mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718296899; x=
	1718383299; bh=n6F8MEieZ+ouRp29tz+DavcsxJF3VY3gbNK6jTLLxVg=; b=C
	k9ROGYkvfs74pfkfjRGhivTY9HhMLrmF80MV9NjYDvHNiXYZcBUeNSdGPTeAz+Zh
	HVoogrIN15YuNnlkUlozEMpXSBO+hHyOqBHo1vgnMFo+VA3sFQovtePW1AvFOFAL
	6m7HfcMqU1iSWG1o85yqYSJS6nxZBrj5SQP9pPy55WTrv8Ewtixc8QV9uz9fepk2
	oJjlpDCX27DQFOe7LAGmI5Y2sqdPsfSMQL9l/sxxKBOhYbK5mx9zitCKtjGnIfr7
	JmX1gzm/I+lvWRLO0l1fXBTXSwdKsoOt1tGWu8aeRy2nsJy4jlmyC3EVQAxdElcg
	07Ijn1XyaspQ/T/UG8IXA==
X-ME-Sender: <xms:QSFrZqmXELoH67ognmMcJv2OnRGCB231ESX_17a4hRmO3G-vx6Z7dw>
    <xme:QSFrZh2FFMeDncXZEGw2NWd2Ex_mDGp0J_kyD9LIVAPjiSAZVvC2EuzzfaQemMTh5
    7vuZ6enQo3CWZ6EDsY>
X-ME-Received: <xmr:QSFrZooTcQfuC0eQMDEVHT5EADIGbNHhH84p3FNDwuxrLB_X4eHWRbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeffvdefleehledvueejieevteevuedvleegffeikeeffeet
    veehkedtkeehvdehheenucffohhmrghinhephhgvrggurdhssgdpshhushhpvghnuggprg
    hsmhdrshgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:QiFrZum5zrZ3c7zq6h9syCE8X0mm4ihzGd8DG4ggjzBcvkeoG2Tzxw>
    <xmx:QiFrZo1CHD7eH-01FfBSX4qy-Ed_uaJ-lqgW_h58gy7xDKsNE4wbwg>
    <xmx:QiFrZlugtfakNzUi7jRANbwQR7ZnVYJk0ElprelTyAji91nxIh2eiA>
    <xmx:QiFrZkWa6GnLfd9FC4DrZ9AaQYwl3xQXMS-QGJfHaEak-2JkvPhAsA>
    <xmx:QyFrZio5ZyN_0mS446pr_UQEaqjBmuXaSzoPuPEzF1dSrNurGKdqNaxv>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 12:41:37 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 13 Jun 2024 17:41:34 +0100
Subject: [PATCH 1/2] LoongArch: Initialise unused Direct Map Windows
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-loongarch64-sleep-v1-1-a245232af5e4@flygoat.com>
References: <20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com>
In-Reply-To: <20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4178;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=ylvLQTm7lYYDCejRFR9lGTs7S0TaD9j4Be9Usi3hi2E=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRsRXulqIc/r5r375CtTP+85PpRxsoVgccWv2DmFvj0V
 Ex2Wx9TRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExk5w5Gho9Hfy7vT+I0Pi6W
 sSMs4p3V2k8fJETOxoTPnnHwUo/Zui6Gf4auM51U1X+JPfx6SLxK+s6y8pKG0o8nn+qwrX+uFK2
 rzgoA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

DMW 2 & 3 are unused by kernel, however firmware may leave
garbage in them and interfere kernel's address mapping.

Clear them as necessary.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/include/asm/loongarch.h   |  4 ++++
 arch/loongarch/include/asm/stackframe.h  | 11 +++++++++++
 arch/loongarch/kernel/head.S             | 12 ++----------
 arch/loongarch/power/suspend_asm.S       |  6 +-----
 drivers/firmware/efi/libstub/loongarch.c |  2 ++
 5 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index eb09adda54b7..3720096efcf9 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -889,6 +889,10 @@
 #define CSR_DMW1_BASE		(CSR_DMW1_VSEG << DMW_PABITS)
 #define CSR_DMW1_INIT		(CSR_DMW1_BASE | CSR_DMW1_MAT | CSR_DMW1_PLV0)
 
+/* Direct Map window 2/3 - unused */
+#define CSR_DMW2_INIT		0
+#define CSR_DMW3_INIT		0
+
 /* Performance Counter registers */
 #define LOONGARCH_CSR_PERFCTRL0		0x200	/* 32 perf event 0 config */
 #define LOONGARCH_CSR_PERFCNTR0		0x201	/* 64 perf event 0 count value */
diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index d9eafd3ee3d1..10c5dcf56bc7 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -38,6 +38,17 @@
 	cfi_restore \reg \offset \docfi
 	.endm
 
+	.macro SETUP_DMWS temp1
+	li.d	\temp1, CSR_DMW0_INIT
+	csrwr	\temp1, LOONGARCH_CSR_DMWIN0
+	li.d	\temp1, CSR_DMW1_INIT
+	csrwr	\temp1, LOONGARCH_CSR_DMWIN1
+	li.d	\temp1, CSR_DMW2_INIT
+	csrwr	\temp1, LOONGARCH_CSR_DMWIN2
+	li.d	\temp1, CSR_DMW3_INIT
+	csrwr	\temp1, LOONGARCH_CSR_DMWIN3
+	.endm
+
 /* Jump to the runtime virtual address. */
 	.macro JUMP_VIRT_ADDR temp1 temp2
 	li.d	\temp1, CACHE_BASE
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 4677ea8fa8e9..1a71fc09bfd6 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -44,11 +44,7 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
 SYM_CODE_START(kernel_entry)			# kernel entry point
 
 	/* Config direct window and set PG */
-	li.d		t0, CSR_DMW0_INIT	# UC, PLV0, 0x8000 xxxx xxxx xxxx
-	csrwr		t0, LOONGARCH_CSR_DMWIN0
-	li.d		t0, CSR_DMW1_INIT	# CA, PLV0, 0x9000 xxxx xxxx xxxx
-	csrwr		t0, LOONGARCH_CSR_DMWIN1
-
+	SETUP_DMWS	t0
 	JUMP_VIRT_ADDR	t0, t1
 
 	/* Enable PG */
@@ -124,11 +120,7 @@ SYM_CODE_END(kernel_entry)
  * function after setting up the stack and tp registers.
  */
 SYM_CODE_START(smpboot_entry)
-	li.d		t0, CSR_DMW0_INIT	# UC, PLV0
-	csrwr		t0, LOONGARCH_CSR_DMWIN0
-	li.d		t0, CSR_DMW1_INIT	# CA, PLV0
-	csrwr		t0, LOONGARCH_CSR_DMWIN1
-
+	SETUP_DMWS	t0
 	JUMP_VIRT_ADDR	t0, t1
 
 #ifdef CONFIG_PAGE_SIZE_4KB
diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/power/suspend_asm.S
index e2fc3b4e31f0..6fdd74eb219b 100644
--- a/arch/loongarch/power/suspend_asm.S
+++ b/arch/loongarch/power/suspend_asm.S
@@ -73,11 +73,7 @@ SYM_FUNC_START(loongarch_suspend_enter)
 	 * Reload all of the registers and return.
 	 */
 SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL)
-	li.d		t0, CSR_DMW0_INIT	# UC, PLV0
-	csrwr		t0, LOONGARCH_CSR_DMWIN0
-	li.d		t0, CSR_DMW1_INIT	# CA, PLV0
-	csrwr		t0, LOONGARCH_CSR_DMWIN1
-
+	SETUP_DMWS	t0
 	JUMP_VIRT_ADDR	t0, t1
 
 	/* Enable PG */
diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
index d0ef93551c44..3782d0a187d1 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -74,6 +74,8 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
 	/* Config Direct Mapping */
 	csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
 	csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
+	csr_write64(CSR_DMW2_INIT, LOONGARCH_CSR_DMWIN2);
+	csr_write64(CSR_DMW3_INIT, LOONGARCH_CSR_DMWIN3);
 
 	real_kernel_entry = (void *)kernel_entry_address(kernel_addr, image);
 

-- 
2.43.0



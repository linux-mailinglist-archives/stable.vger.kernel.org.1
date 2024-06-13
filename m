Return-Path: <stable+bounces-52071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67B7907876
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 18:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7BC1C21E67
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 16:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FD8149DF0;
	Thu, 13 Jun 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="D3ryXTgo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aU9zLKU3"
X-Original-To: stable@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4909A1494D6;
	Thu, 13 Jun 2024 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296902; cv=none; b=DMKwFKsCGY9R2pL6GtqmYoop+ZBxxJQGC44sp7cpDymXcF2x6pIeIUf2mbvMo3JJA0pgccFpaWi3TsCkU4Ys0dyAPnyxLT+ztQO2z2Yu+M/6lP0fnXz1vWeqh+cIo9gsAmmJkdmYdZOce3nz79MUzoKaJJh7VkZjRToI/XbltQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296902; c=relaxed/simple;
	bh=YmkuZ5nOlN7lTRobe6yTymBK842DdK3E0zbosM2LIRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Crgnc2nBBHOtSsxSY798Zl2trO8Dvgi3lSGS8g0Br1SfdPr7Pb6ydxrqCasFP4qCLzuWQtErc881TtubEngT8FyO2jiarVL+ehHMuaYnWuHdNEMxQGxSGf+g9CDOElBx7QurXuwfoMNn/5rMKREMCeU3yJMytJoNXkuHNffKqZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=D3ryXTgo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aU9zLKU3; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 948FB13800DC;
	Thu, 13 Jun 2024 12:41:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 13 Jun 2024 12:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1718296900;
	 x=1718383300; bh=q3BMSOZk6lkY4K+5BlAtTxK+Qw2IzmkiuHwEpbHFuP0=; b=
	D3ryXTgoNtMu9sQx05ewSRp87/hy+hD7r2s0dsMxwkwUV3jxkXhDRb9BXZlEBfCc
	6WqdFCKMYaFFSaPo6LYTAdbinSm9HKWODRXAntVV8og0dEgkc8LjuOA9kKvxADzH
	NY37NvFDVzmvHEVo8sjdwB/V0AZO5ZhRCkYyOyU/vLYIuiOSWIbMU41Xo3iMtdgZ
	dfUykBYHmjeVGNBT7Y4z2cf2IBztL07rdc5aGa6mEHaJ2b2ttDUrkgzgyepSKUch
	BgEzHEAK68/PybRxTM6SN4MJvhDTJ6EK7avRnaF8nuATkmIwa57YWEgdyuKVJjJ0
	bYP9QnkHSnC9eIdpXBolzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718296900; x=
	1718383300; bh=q3BMSOZk6lkY4K+5BlAtTxK+Qw2IzmkiuHwEpbHFuP0=; b=a
	U9zLKU37Y1qEJcuXPOnI0Bjq7WNrukkZb7kbwcVG6V1Z3ItDtdIc0QqQjfWwlkuP
	z+9c4PrZu0T5tPnsSutsM4lbZbyOQEDthqlSrbZDsXV1oqTCWzpIODAPAuUDQRDQ
	LiYT6T6N6/9qFrbSxE/g0ot8vMQ9pN888+lpTE2oeEt2jVtq5DvoVmuMAWO03QpF
	0BXqZFQ+N4hXZeFrnz8MXnVJZx5VW/4W8uhnndllT/nYqqU9pqs9Tgn6kAToAYm2
	jbL8hCdOEjp/83mGFiL03W7kRars5GAC/M2owE9H3mb5/Cf1i08KO+VB6CrKAKgp
	vCiOhfwofKJ5NF9aPi/KQ==
X-ME-Sender: <xms:RCFrZhA7YaaGsG0rauE9FK1iQmc3WKRRJMIKx95YFxivAFwu1BoANw>
    <xme:RCFrZvihLM0WjxQilwyvjWEmo61vkZsi-UmaxJe5nLwQe1mqO1AmhFIoPcVhNFWWq
    Nd5END0gO9kO48lLnI>
X-ME-Received: <xmr:RCFrZskehs3dZKhvf31XwzikUL-MhtMASbkw7KqWLubVXN5gTBBhV1o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeeuhfekvdefgfehgfetveehveeuiefhgffgkedukeduvdfh
    ueevveeigeetkeevhfenucffohhmrghinhepshhushhpvghnuggprghsmhdrshgsnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhn
    rdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:RCFrZrwd8_Wi4nI_VgaZjsh8cSbL56vUQ-LC3E4yFHI10DoWwD4p9w>
    <xmx:RCFrZmRVztJpfTz0L7bIis4mf8MQttBTtoG6Z_BaGNGwOcosAofJZg>
    <xmx:RCFrZubPqBMpmRvcQWubOtOSUx-WLB_3XHrWSM-ULCPKvbfLZkGnUg>
    <xmx:RCFrZnS6TphDw47-VUDD3i2Kdrzyw2TXfqK0PuCewfsom6t9WUqLGA>
    <xmx:RCFrZlGE02-3Pk2Z_lzETUg9OxgKuCI6v4_ta47L3q1oIbD1SYjopsJD>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 12:41:39 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 13 Jun 2024 17:41:35 +0100
Subject: [PATCH 2/2] LoongArch: Fix ACPI standard register based S3 support
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-loongarch64-sleep-v1-2-a245232af5e4@flygoat.com>
References: <20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com>
In-Reply-To: <20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2868;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=YmkuZ5nOlN7lTRobe6yTymBK842DdK3E0zbosM2LIRM=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRsRftNZkdPzC62P7/Hdrq3+TL33KMK76vaPvKKe65vC
 K97Wnm3o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACYSHsHw3/PO7o7LyTuEvj/d
 9+1DXqMdy/73nVe/nvn780+2jjDH38OMDLMend1h4nfmyq3MzE+bOJ3540Nbe/2zbzdZNywQZw3
 xZgEA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Most LoongArch 64 machines are using custom "SADR" ACPI extension
to perform ACPI S3 sleep. However the standard ACPI way to perform
sleep is to write a value to ACPI PM1/SLEEP_CTL register, and this
is never supported properly in kernel.

Fix standard S3 sleep by providing a fallback DoSuspend function
which calls ACPI's acpi_enter_sleep_state routine when SADR is
not provided by the firmware.

Also fix suspend assembly code so that ra is set properly before
go into sleep routine. (Previously linked address of jirl was set
to a0, some firmware do require return address in a0 but it's
already set with la.pcrel before).

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/power/platform.c    | 24 ++++++++++++++++++------
 arch/loongarch/power/suspend_asm.S |  2 +-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/power/platform.c b/arch/loongarch/power/platform.c
index 3ea8e07aa225..2aea41f8e3ff 100644
--- a/arch/loongarch/power/platform.c
+++ b/arch/loongarch/power/platform.c
@@ -34,22 +34,34 @@ void enable_pci_wakeup(void)
 		acpi_write_bit_register(ACPI_BITREG_PCIEXP_WAKE_DISABLE, 0);
 }
 
+static void acpi_suspend_register_fallback(void)
+{
+	acpi_enter_sleep_state(ACPI_STATE_S3);
+}
+
 static int __init loongson3_acpi_suspend_init(void)
 {
 #ifdef CONFIG_ACPI
 	acpi_status status;
 	uint64_t suspend_addr = 0;
 
-	if (acpi_disabled || acpi_gbl_reduced_hardware)
+	if (acpi_disabled)
 		return 0;
 
-	acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
+	if (!acpi_sleep_state_supported(ACPI_STATE_S3))
+		return 0;
+
+	if (!acpi_gbl_reduced_hardware)
+		acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
+
 	status = acpi_evaluate_integer(NULL, "\\SADR", NULL, &suspend_addr);
-	if (ACPI_FAILURE(status) || !suspend_addr) {
-		pr_err("ACPI S3 is not support!\n");
-		return -1;
+	if (!ACPI_FAILURE(status) && suspend_addr) {
+		loongson_sysconf.suspend_addr = (u64)phys_to_virt(PHYSADDR(suspend_addr));
+		return 0;
 	}
-	loongson_sysconf.suspend_addr = (u64)phys_to_virt(PHYSADDR(suspend_addr));
+
+	pr_info("ACPI S3 supported with hw register fallback\n");
+	loongson_sysconf.suspend_addr = (u64)acpi_suspend_register_fallback;
 #endif
 	return 0;
 }
diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/power/suspend_asm.S
index 6fdd74eb219b..fe08dbb73c87 100644
--- a/arch/loongarch/power/suspend_asm.S
+++ b/arch/loongarch/power/suspend_asm.S
@@ -66,7 +66,7 @@ SYM_FUNC_START(loongarch_suspend_enter)
 	la.pcrel	a0, loongarch_wakeup_start
 	la.pcrel	t0, loongarch_suspend_addr
 	ld.d		t0, t0, 0
-	jirl		a0, t0, 0 /* Call BIOS's STR sleep routine */
+	jirl		ra, t0, 0 /* Call BIOS's STR sleep routine */
 
 	/*
 	 * This is where we return upon wakeup.

-- 
2.43.0



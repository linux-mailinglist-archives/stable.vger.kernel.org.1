Return-Path: <stable+bounces-45536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C94FF8CB492
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 22:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6958FB21CEA
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BA1149C5D;
	Tue, 21 May 2024 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="GPtqFbEz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OYYzxXhb"
X-Original-To: stable@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063114831E;
	Tue, 21 May 2024 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716322343; cv=none; b=L5l5pam8korRKldTOCN8DRXwmLXOGK8+vdISxYWJj+S5ltb9NDnzwNxWrPv3uyR9Aqii8f13GxlP6IlLnfkLR5EK9CWMafRt43uVmU7z2qAbFTO288IZQpRs+mOXBI8gmLlArmpBVwsXdHFNiIAK56AH3Hdz0KRU+xIR+jq/JH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716322343; c=relaxed/simple;
	bh=xXIJHAJOc6onemD12GizOeep+GRhVclxjz9KYi4R0ZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hCw69qKhfBgUBu5rT+lckYdpPzkmn9D0LbUfvPZmUVCw8XXZ16GYODFIs0R0hndZQVpIaAb3ztD7l7cvzypijk5E8zDD9jWKxMPsjrUWeDHvNU9va4yB0Xy0ZJnR3H6JUahxRO0VPDNWFCxzxd8NxRsjP0o21mTA2btar/BCFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=GPtqFbEz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OYYzxXhb; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id F338A1C000EF;
	Tue, 21 May 2024 16:12:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 21 May 2024 16:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1716322339;
	 x=1716408739; bh=eTTfNISa1AvyB5+NKyzaR4LUuaJMzDBXdrMDNNsuz0c=; b=
	GPtqFbEzys+1djPR1hiQM1mABmXNhWXHmbryVmCTJJ8qWMGKVJbsL56EO2r5EPxd
	YuyMFdbyTd9tjJfpjpI/YuypQqQZJfcFj8cH2XB1U4632/skXr02n9aNKsPBopt/
	ROd5ATCGjIyWtUO+MQlvS/sUHwozr2UDQ3EjmQ3+dj24oY0b+ts3BhlCT6P0NVRj
	58p5a51niINw2zoEaEcGbb1f0CoNuEucrchgI5W6awEN3MAzlWp+2EoaiP3fYjS1
	8POVPVk/sYvYEnz9ERDSUKrcyiBa3ST11TatWJ83wzw91gT+ormza5LgPzSIDHz1
	9zn11ghXl3drA6Od6vSTyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716322339; x=
	1716408739; bh=eTTfNISa1AvyB5+NKyzaR4LUuaJMzDBXdrMDNNsuz0c=; b=O
	YYzxXhbR7hXW6LiuVmJzvGQw22LdNaGj8q/3dHIg0oLIoqLbOl6vV96Yv5Yf0SuM
	brBtcAJhc4cRCm/2GjA7S1oicRQCIKacAMLID6FWEUeBn/DsjnRpk3B35FKOKQFW
	HkWckK4o8fzfeW3S0gcjCEGH9stanCL/MPEMouWTW3++pvWYMUXFVZWe1U9BNmVc
	Rpduy6SmLx4a8fa4Y7BjRdnpWYNUNg0qAy+RAUzE2wP93fixRJuDCRz6u5ug9aMi
	gk76sc+WVysCAY+0ZbeCpvrSO/cdnA8fuJOEO2XQwFahDQWnM+XxAimZx9N7gy25
	lEt4fdJHTtEIWEwmD9Xww==
X-ME-Sender: <xms:IwBNZu0oAUesEHrPX0rvzMtvWgfcKNp7Rcxxjj6M6nb1EP0RPGPzHw>
    <xme:IwBNZhF3tc4Y7Xqh9TZylNyVqG07MvUm3rJajLUatvI4zjn5mQ6_MO6jnV8Jmbc4m
    zPrQcehoBiSAo442gE>
X-ME-Received: <xmr:IwBNZm5QSYVsTlJPeFPkgx3l0QXi-YLyQJuWA4eHD_loqFpoWQNy9ds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeivddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
    ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:IwBNZv1-xWzfqn0m_2e3CihjZ1dE8FAlNJIcstKLC7lpT0CIlkP69w>
    <xmx:IwBNZhEkrnNS6qlwt-gaFP5qq0xl37dq6e0FfLGUjkUXxbLFcvImAw>
    <xmx:IwBNZo89HzTs9SNG6-982AYjzaSuvRiIsrx0WTefwmsqSHqAswzAzg>
    <xmx:IwBNZmlBDXfxJcE9ddjueJnwpQAVPkoR7q28BtCoOBO4uLU2k8ueVg>
    <xmx:IwBNZm6jbiAeznjb4cTwN_nPiQwx2LCYrp2H40nlj5aUb_JffYOLMNx7>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 16:12:18 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 21 May 2024 21:12:12 +0100
Subject: [PATCH 1/4] LoongArch: Fix built-in DTB detection
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-loongarch-booting-fixes-v1-1-659c201c0370@flygoat.com>
References: <20240521-loongarch-booting-fixes-v1-0-659c201c0370@flygoat.com>
In-Reply-To: <20240521-loongarch-booting-fixes-v1-0-659c201c0370@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=xXIJHAJOc6onemD12GizOeep+GRhVclxjz9KYi4R0ZU=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjRfBgXx53MP/fBMKai9v3RdxAXtF3av8m5zvirtFXuhy
 GaqF7Cvo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACYyfS/DfxffAN24VVy/srij
 jk+5EnPSYo795JDQHU+OVhyYbjCnbC8jw87ly3O3aIlVvyg0Mg9lKV+uauM8S5qBc/PtRKZbmpM
 6+QA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

fdt_check_header(__dtb_start) will always success because kernel
provided a dummy dtb here, thus fdt passed from firmware will
never be taken.

Fix by trying to utilise __dtb_start only when CONFIG_BUILTIN_DTB
is enabled.

Fixes: 5f346a6e5970 ("LoongArch: Allow device trees be built into the kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/kernel/setup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 60e0fe97f61a..ea6d5db6c878 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -275,16 +275,18 @@ static void __init arch_reserve_crashkernel(void)
 static void __init fdt_setup(void)
 {
 #ifdef CONFIG_OF_EARLY_FLATTREE
-	void *fdt_pointer;
+	void *fdt_pointer = NULL;
 
 	/* ACPI-based systems do not require parsing fdt */
 	if (acpi_os_get_root_pointer())
 		return;
 
+#ifdef CONFIG_BUILTIN_DTB
 	/* Prefer to use built-in dtb, checking its legality first. */
 	if (!fdt_check_header(__dtb_start))
 		fdt_pointer = __dtb_start;
-	else
+#endif
+	if (!fdt_pointer)
 		fdt_pointer = efi_fdt_pointer(); /* Fallback to firmware dtb */
 
 	if (!fdt_pointer || fdt_check_header(fdt_pointer))

-- 
2.43.0



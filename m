Return-Path: <stable+bounces-54813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27457912627
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 14:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D651C25A00
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C6C1422CF;
	Fri, 21 Jun 2024 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="DgLsni8E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KUqbMLpt"
X-Original-To: stable@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1AB153828
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974737; cv=none; b=c4zSAVlTE9VnIbqwYi0s9k9JZUOlTXagvawATww7Z6UqLnMBRmBxHWUBvkxYHK1P8V/9BJzCtcO/ScDDsSb52atniVEw/y02dV0661wr/emJIyi7fZVHdpetChU16N4ZxKRpMNLlDt9OkAkJ1AIDq60yGZH+BjtnpU0Xyf6KoK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974737; c=relaxed/simple;
	bh=g3k3nWcLqtTiZ2wMMOFp6to4dK8fiS1Lxyx+pASHj8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Arm7Z5C+ZdtYAmmb4Sczp1t2H/WyFIUvbScS0xaDWE5yA/7BeKbOCZn6DMIsrCz9msiEGIi+5lh2mIC921LZOLxb86lLDousOncbJlBWoy0OCKnVwaecDMyd+hInfNE6zWHbQRocXQ5LblafRGdQlxt+cBmbVyQbtGXX+LSLYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=DgLsni8E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KUqbMLpt; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2F76913801CA;
	Fri, 21 Jun 2024 08:58:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 21 Jun 2024 08:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1718974735;
	 x=1719061135; bh=gT2jLym9c6kJFJ+5mmTK3eAZwFetlVf+TwMnw12Lex4=; b=
	DgLsni8E5ia0IiiCB95PNetLn34LXf+bvh+rI1Uk9PBE1Z7na1WStTaZTNHmxCh4
	cUm3fUjtMBDwgydXOSKRpjFH2My5sFt0ltTslG8B0FdVvR/YADI7yTcLjoKYbT5d
	gj/BTGXKbPxFSn38pB37IZ4TrisjPqsfgDj8sMYtfUNp2P86Gf2YkIeQjpTwk1Y3
	wATn/m0Q5k4MVpneuqg3Di7dDONIuFyn8gPC8q8KEESmcodcQ42AUrBVpgZYJw1l
	7PhsoVlIJjINuSLa13NPyR2FDey7ZjM3X6lZ286pxs8wxJQF43CM+2d9uqze7eIO
	86YIji2t7Zfb1xsUvm1hNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718974735; x=
	1719061135; bh=gT2jLym9c6kJFJ+5mmTK3eAZwFetlVf+TwMnw12Lex4=; b=K
	UqbMLptVBw85uzN5pou2ci/Igivf0Nex/P7yCUk9Eh2I7JSmgmcVz6be0YRACByt
	VvZguJ/9EQM8tomwkK9EIFILVypTwfFTzXkMys0BhkkgxrIvIJJeQtPKwUf8/L4l
	SKNMEBzJ25ZThkOcyGx8/ZikL6vkusNJIeRiORji21hOB01GHStixzX4cZ9mRsJn
	RcPx/tXtz6Hz6kuJjzQiPLkJ/z2azG9LhUFo3IHM+bFtDba2i5xnJzyaO6KQzxuB
	fFXWvdByZBveD/QtotkbSGnEMdHfVC8G+HeSd95QbelK9KBUTzbQyu6EcUiXFEMp
	ga/9o3Xlap3PZguoA9Diw==
X-ME-Sender: <xms:Dnl1Zsq1sKeKSyLTyIMfm2bMNYRoYhKWZAIe4eOGVkPTQyz9DBkkXA>
    <xme:Dnl1Zir_vjPL_ubv2xu9g3qX9cYP5t2jkbE8POMsOt4RmEZxsvvq1yU0kwUuI1phE
    fNfjQFGTBCfRH75GNs>
X-ME-Received: <xmr:Dnl1ZhO5qj9CLlxFTJy-M1a1BwFuvPlHSIme_MxBLWh7Vlx75CKfV_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:D3l1Zj5LX9puHgh8fdFZfDDIrH4J4MIHyHFwbdIP3xFKO_EEh5oATQ>
    <xmx:D3l1Zr6BmPWgdLUDBDsTuKuZQU_QYYlI2EH_CWKBUI-zvI82UGpq-A>
    <xmx:D3l1ZjiOjnYobgxOzRGYZJSMLs2cNErC6qzPaNiKd3DNtmMrRQxOHg>
    <xmx:D3l1Zl5vtqzz3vo3JgXB_CRWTm6V3nCTLhVGdLOgb-4uSZP3lDlwDQ>
    <xmx:D3l1ZoshP8BFWhuZ6Lczn6Uf1Qvi-nrQmvLhWuySjTjneUOowiVyOAsG>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jun 2024 08:58:54 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 21 Jun 2024 13:58:43 +0100
Subject: [PATCH 3/3] linux-user/mips64: Use MIPS64R2-generic as default CPU
 type
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-loongson3-ipi-follow-v1-3-c6e73f2b2844@flygoat.com>
References: <20240621-loongson3-ipi-follow-v1-0-c6e73f2b2844@flygoat.com>
In-Reply-To: <20240621-loongson3-ipi-follow-v1-0-c6e73f2b2844@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=844;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=g3k3nWcLqtTiZ2wMMOFp6to4dK8fiS1Lxyx+pASHj8Y=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTSSi6ez3d7Uu/nHj7EMr/H6rCYlG9dZEprx5RZ/QXxW
 Z/nX9vVUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABNpYmBk2GJ90zO+1X51U8WU
 46fkffwNPGbv+MVfM1dMUf/73ES+v4wMG37amlyqeNutc1g/6uMxjTkiF0Q9c2NtIzY0tzE8bdj
 CCQA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

5KEf is some what not standard compliant by having non-functional
FCSR condition fields. This is causing glibc test failure in
qemu-user.

Use MIPS64R2-generic as our default type, which have maximum CPU
features.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 linux-user/mips64/target_elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 5f2f2df29f7f..82bb7e8b1cbf 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -15,6 +15,6 @@ static inline const char *cpu_get_model(uint32_t eflags)
     if ((eflags & EF_MIPS_MACH) == EF_MIPS_MACH_5900) {
         return "R5900";
     }
-    return "5KEf";
+    return "MIPS64R2-generic";
 }
 #endif

-- 
2.43.0



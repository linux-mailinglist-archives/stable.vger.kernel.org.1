Return-Path: <stable+bounces-45538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65B18CB496
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 22:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99F21C2194E
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7915149E19;
	Tue, 21 May 2024 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="n/cgO1Fo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KnoH1UtI"
X-Original-To: stable@vger.kernel.org
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE67149C7B;
	Tue, 21 May 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716322347; cv=none; b=qSP1C39hb+OBRXSvl8FHzwjsBqxrPm1s0IBjB/B8cJb84hxYzY1GxJE32NIAS+JecqiXLMn9rzlVx0ZF3Zy/TwpFyrEFrBYiUxHNbqCXWnwd4JkeUeyEhan/Do4j+gO92J/ZyA1EzCeCw4kyqJZs2+NoZDbJQr6NeRMNn2m+BF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716322347; c=relaxed/simple;
	bh=VkPWDIMyMkF8CH/V1HlgyS/GkNbF6V6iQ/qLTwf17fE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c64naOhTuMF7zlZnO91umLR+xnfUs1d4qZnRr/x20lQvvT2EOdGRN0jMW73qsyWcRkd21z8wB+BE6mHMNKGVRsxZQ+rUVGNmTY5YlncqdFMmr7A3lih04gki1FkihGvvBVVawKNhI/N0X83Zl1u8u+eqNWbLgKVG4j13wLIZS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=n/cgO1Fo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KnoH1UtI; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 318D51800107;
	Tue, 21 May 2024 16:12:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 21 May 2024 16:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1716322343;
	 x=1716408743; bh=iItfwyatQhlxt0H+NrF1YH5otFKvGeFUgxF05vMBPgw=; b=
	n/cgO1FoEgCjEVWerYjHHXBkTTPNXSdA0Zf6E9EXznVZXXHyvmPXSSNcHPsw1R7G
	IGsP9havV4TOK1nowRkE61thRIj2Bo1E+k8e7LWfhOf74nUoBXRlUI4XUyC4fc0S
	AJbG5KhLdqJTRDr7CQ98V+8K0G3MLMG9W8zpD9iSXLWX8oP4kjcMCxnPFm4qaX+w
	STmCDOZGfdQar/P9W4P9h93uNIhYwLd3CcbQFqdfC0ilgbDJPch53jJ+lvzVLx7Q
	TxBWJVxtZRsF4iPI4KO77UfnWAIUAAmGUGnnu2HATqS6Afvrf+MDAVhHqa+eCK8u
	t1vTHR/YoRE0L6G5WcfwPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716322343; x=
	1716408743; bh=iItfwyatQhlxt0H+NrF1YH5otFKvGeFUgxF05vMBPgw=; b=K
	noH1UtI358WiL7PVlZyeVwMMu6sxXjv+LNKdAq1a9uIJTbKbWEkoOut6LPmY7+V2
	zivsVJeDEHz2zXIOb1Oph+yHHi9Zk6t8k26fAJtlIEB67y20Ab5uBgzBxcM0Mg9Y
	uKEhC13gVM9EgawXsImT/7yjk0+Ga7QJB3Zjg/FaWpSVA+Q2Vf4bGp/BvLx1EMGY
	3yOvZlGcvBISXf90ycr39HeFMn7C/sdjsZ4cIz4pvyHSWHntARRDdgBGeRtOjY1c
	3e1MbOJckV5ureC2VaTEvD95LT2qa6JVLYG8821zxJHvT2Drcf8ULNZjy7FEE/Te
	5pJ8xguMRgAYDNUNj3YZg==
X-ME-Sender: <xms:JwBNZsE6OkACr6OAM7VRQE8eDy6GW1i--cWDWozGGmtCIQ65PsefEw>
    <xme:JwBNZlWGdnmHDidF4CiWQwP7uWIoiOtZB6wb7gQZS6Vn6RoYR5MBKZHrDF-TzQDiD
    RGF8SEZXhT_rUNlwqo>
X-ME-Received: <xmr:JwBNZmLo47fTRrr0tkz0GV74ci2ywJB3Uw8sjLfPQthPPxjt2o7AHkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeivddgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeehgfeuffdugeeuieevfeellefhvefhtdduleehgfdvgeev
    hfeileevveffuddvgfenucffohhmrghinhephhgvrggurdhssgdphhgvrgguvghrrdhorh
    hgpdhrrghmrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:JwBNZuFpDYokslOu-pVywVNkRT3bJlGkurwdyzYGcxhJmfVws_z3qg>
    <xmx:JwBNZiX_hcoTlIl_cOgoT-tyhGznm8l1FXxb-c5myj8X_5p7L79lpg>
    <xmx:JwBNZhN9S2uiZudwGWFf-qV9Ge8du02xpXu0dD44H4ElPyJrHlOHhg>
    <xmx:JwBNZp3kpLvfV5L8cb6AqlKjXrhaua-jpk0DnbbjzFivluN6HvYTzQ>
    <xmx:JwBNZkLSH25fCsQ-nylL4BPUFdG1E7dasWId0jFMf7LM96X267CIoixN>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 16:12:22 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 21 May 2024 21:12:14 +0100
Subject: [PATCH 3/4] LoongArch: Fix entry point in image header
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-loongarch-booting-fixes-v1-3-659c201c0370@flygoat.com>
References: <20240521-loongarch-booting-fixes-v1-0-659c201c0370@flygoat.com>
In-Reply-To: <20240521-loongarch-booting-fixes-v1-0-659c201c0370@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=VkPWDIMyMkF8CH/V1HlgyS/GkNbF6V6iQ/qLTwf17fE=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjRfBoXi3zbfTuuZOzPsUHaVZ1khFJ6t6XkoX3aXXsX5n
 UrH5JZ3lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwERWxzP8L1tvr897w3T2ZWO+
 r0zHtvjerXSc/fTTxRddZfrHBOIqDjP8L9yyIW7rpFatLOaYq6eWXuLWyGk4vTvlnsb8w9ETDnv
 5swEA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Currently kernel entry in head.S is in DMW address range,
firmware is instructed to jump to this address after loading
the image.

However kernel should not make any assumption on firmware's
DMW setting, thus the entry point should be a physical address
falls into direct translation region.

Fix by applying a calculation to the entry. Note that due
to relocation restriction TO_PHYS can't be used, we can
only do plus and minus here.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

-- 
2.43.0



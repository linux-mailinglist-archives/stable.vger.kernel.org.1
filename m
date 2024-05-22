Return-Path: <stable+bounces-45553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A08738CBB56
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 08:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1009A1F22FFE
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 06:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BE07C6CE;
	Wed, 22 May 2024 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="szvRktf/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EzsOzcR3"
X-Original-To: stable@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF18075802;
	Wed, 22 May 2024 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716359427; cv=none; b=pclrtPDjPY0coJp9z+JogEF20v1TqiuXmip0pheaphmCKZb/dUFlg6dosxN5JdJd2hEo1P5c3gZEtMXsqyS6NjbTTISkHKkaYhmey9jfA8ZVaqqEROywAkUc862x6SKgo8bPsKTvvLAOpRYENKXpcWI92eeEgC3tvo0UAftI/ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716359427; c=relaxed/simple;
	bh=xXIJHAJOc6onemD12GizOeep+GRhVclxjz9KYi4R0ZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TC7nYBH86DZoSUzdOYhZNAkqi7PJMMq+EaxdzWBfjTE+BA4DrriOo3/JRJcVlXFgWcYMWHbpIx4KMiivd8tBGQ8bb3SX959PSTz2dJ0+puzgzo4o/wmzAHBzgbdb/VLYnAe5laFNCIljZ2XnclV9DIuETqL78h5sJPQbYaITXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=szvRktf/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EzsOzcR3; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id BDB5E1380101;
	Wed, 22 May 2024 02:30:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 22 May 2024 02:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1716359424;
	 x=1716445824; bh=eTTfNISa1AvyB5+NKyzaR4LUuaJMzDBXdrMDNNsuz0c=; b=
	szvRktf/zQm81a81EArLjk1aYrk9e+sE7xY/1DEwlLCkZGZBqttdgPSyy5yi/F5R
	djH0dhkwNWwblCyIbxuj7iNa8j3XQDV6A8862cBHX1+r/gViF2EhhBV92rfE/XPj
	5bLOgnN/J6+EzGAfdmJCy2fiKb5ASM46KieIV75+Yh6g9GhA0bleYoNyhOBd7wgg
	wJxw+AotqA9FcKCcsHARGB0a6+LGzM9Xly386pLPGrytB76lxTsifsh30Qqfv0Jd
	GL+ZhazfPY6Znl2DhcIzs7MdsEr3XPodmc5LiRU2pJ31L+nIimTFwptWUYNwC4iZ
	OVtwO2Cn5zHTSs8WUkheww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716359424; x=
	1716445824; bh=eTTfNISa1AvyB5+NKyzaR4LUuaJMzDBXdrMDNNsuz0c=; b=E
	zsOzcR3M9FyoJ0IxhT5AAsEGdMfPVy5uwVKgP0tPp/bHYdj354Yngs2GNOFnDCmE
	9RhVsdOHofiPqsJMDWJq4OtUW/y5uilV/H5UquvyeVCF4sTQ+IdFu9vwEnWRVEAx
	FqUdS4zWoy82Civ05Mlkj2Y4DdIBIOcePaWJTqpVZzBcjWPHvxfVkrt4Lg7/0pka
	315SBm9oGuM98LdbFWZAnTMw+CaU5SBC743gvZNnbjok8QO86zhDx89hHVdmTklJ
	mSqn9QZT1pZ1LOTgrHQtLSwR6dtUs6N9ZTKnrkwxN9iiYCzdkg5v11NBdlo2OxZQ
	XZH5Es9whke3iysqTA6Bg==
X-ME-Sender: <xms:AJFNZryg8uvLRI5sEcuUnHWcyKPjoiD9yoxc1If8rES0U3hGDc4QlQ>
    <xme:AJFNZjR0_e8de15kiRVVgrmqjHkSf5rffBxFU9_MWrLNJtb6ka-17p6lUGTrXBvAC
    VpWnMa_gp-QZ2nVs9w>
X-ME-Received: <xmr:AJFNZlWKoRS_7gn9Wjz7iKW5f0rZb2rVd91HGrDmuW5hW9bAleAowDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:AJFNZliwT2xsyfmlE5F61dvTz7LLLDi-aSzSo5Hq-7K4nZSvdpnPSg>
    <xmx:AJFNZtDpwNOJhW5per_hSnbfWoT3ur3Juw6iv8HMQc4Z9a5tttkmwA>
    <xmx:AJFNZuIJ2-dbXoDTgXKSEMovM6yseX0ZW-UTrsJBiS94gJfvgJNSbg>
    <xmx:AJFNZsDSGQ7Mb23GYIiE94TE3QgkS1zPiwKWgQxyyFx-qwsDKhIljg>
    <xmx:AJFNZv2sec5VJIr75ly66OqWhL_8V-FyeEtSCWUJDGk5meOdgceUOmsy>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 02:30:23 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 07:30:20 +0100
Subject: [PATCH v2 1/4] LoongArch: Fix built-in DTB detection
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-booting-fixes-v2-1-727edb96e548@flygoat.com>
References: <20240522-loongarch-booting-fixes-v2-0-727edb96e548@flygoat.com>
In-Reply-To: <20240522-loongarch-booting-fixes-v2-0-727edb96e548@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=xXIJHAJOc6onemD12GizOeep+GRhVclxjz9KYi4R0ZU=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTfCf/ywt8wbr/2+qDjngdndXPK5m78L9S8sz9ppYbes
 9/XNu161FHKwiDGxSArpsgSIqDUt6Hx4oLrD7L+wMxhZQIZwsDFKQAT8X7EyDA1yLFYNXvWmu/d
 5R9yBTyTfgvx1iZUrQk6/uL3i0YmLVtGhqMKCn9+Pa6uXyugssZOjqFiq+4C7i/c8rOfy7yoX/b
 BkgkA
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



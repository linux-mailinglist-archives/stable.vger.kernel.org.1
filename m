Return-Path: <stable+bounces-45599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41B68CC8AE
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 00:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C42D1F21A73
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 22:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B27E146A9C;
	Wed, 22 May 2024 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="s8zM7Rg1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ExhHPk39"
X-Original-To: stable@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245D56452;
	Wed, 22 May 2024 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415346; cv=none; b=IodtstH8u++udWQzvjbX05VaFTiE99PW46MngsdnFnZA4RqkfbfRQ0v5aA+irAYokSEIKUXGSNSfk5gqQZZtIWEhXCZ6K6G082Y9N03q7n3qGl//PjmoUMEkSgCWOzYi7WpLD7qD4uCJM0Q+ol2wwMnchF53/vYgIXaG59YWc6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415346; c=relaxed/simple;
	bh=+ZkFOOEzPJ9R8rASkmEVkeYaiXTIikAfh4ZoUZH4DP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ovvhN+bLy85Q+0GKXcjj8rwJ1Maffi03v+XHm7cMIDnRFGBc8By69iTq8Hv+zez3NnZoZ+K9KRKG1hQJWR5/ciQSJ3i9krr18X4TCn8lAhQt9woN72g+nH/uStckl1L0IJZ7SLAbZARiAXN2qK6zAnH23BQNHZM/vWGvs1Qn/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=s8zM7Rg1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ExhHPk39; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id DF39C1C00180;
	Wed, 22 May 2024 18:02:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 22 May 2024 18:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1716415343;
	 x=1716501743; bh=U8JuBi3PiTbDpXQpVISnqe5gsrf64wIswzQg2DS+gq0=; b=
	s8zM7Rg1AqFT9uQxsthDiFncrnGpX92gxABQDnutw6CkqmL1uYGWPHKviPpwlkBa
	OD/mDfI0BP0niTYrArA7oUapJdZk1mrOXmQVMgQSOBi0yQCpoZdhHAr3iCql/Gqg
	8iBAnuWRD/ZRZxgGLRyIE++vg8rv4xk3cWaIHav1eKp5d04u457H6E/M5xBFqsrw
	GcPMbcXagCFvsXEAwnF9pCdz6VRtIn3cutEOvaZfsdWmpBafMwXf4WJMieM6meOh
	IQjTxMJddslXUUkVhm6MZUgfEMaNNV4QL3YwJql32xfmNUUVFl1yLKfXi8QLQRqu
	rBGXAiUV6shCp3jCAXrzDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716415343; x=
	1716501743; bh=U8JuBi3PiTbDpXQpVISnqe5gsrf64wIswzQg2DS+gq0=; b=E
	xhHPk39rG/IiEN+DuKA3NjQY6Voz64wqGcriKhgTg33lBct/UUV+C4NMkZX4why3
	uz0gvpt0HUwkP6hlwEy+jByxCiVvx6Urlnk+6E/k52ZeBMVZ2PDECEaAm4qNsTJI
	XldXc3HTUsfaXbn6xy5cpDyiRXxS/pIts01OFq0i8lczQ7t7Ey3iYQWfs3rEXiYO
	J/ZfZ1F/apgjyiLuPhOSBbxlGRmh+QWEVeve3zfcXop3C9OoA3CkqgrElGMD9F9I
	AsipGN32fIoCdjlAbK4Km7Sp1Ti3ruVx74lbaCdzsFAqu1fEtoQ3MEWO4JP6i0J8
	3APAwjtLxpH4D9+iz1gGw==
X-ME-Sender: <xms:b2tOZiwPc_ntUbC645jnVX2IYXidrGn6SChlx4pxIALRPvI-cRzcJw>
    <xme:b2tOZuQZJQJJ2m3m1V4Kgfs6iBT5xg-Qwc3hL6Zx2Wm5Dy3eVfp9vbXU52dSK_lPf
    IHVTyxpLlnI0XAiifc>
X-ME-Received: <xmr:b2tOZkU2n8yT1rqahqc3IQXmEnr6JoMcF6SfWpYg4GU5Tq2lm8Aypps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeihedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:b2tOZoiFC03QQjMj8N8vZTDOBjXbjGM85vsaud4QGazODP_ypEFcSQ>
    <xmx:b2tOZkDPg21ZIJY5L0vG0Y_-_wsXmUZp3J2CZM2BKK88sH-96N3__Q>
    <xmx:b2tOZpJaOR01FJTBG-xgcKYEfPZ-flXb4H9kz6X740jqwNrMUliY7A>
    <xmx:b2tOZrBNAIZh546xCzzuBmY6TrdNdqdV95JmcR-UJVhmTLAqa58-tQ>
    <xmx:b2tOZm2XskfSp4-64B2k_CHV5zi83__PYS14o_CSTOn5nG8Di8qV7eMT>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 18:02:22 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 23:02:17 +0100
Subject: [PATCH v3 1/4] LoongArch: Fix built-in DTB detection
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-booting-fixes-v3-1-25e77a8fc86e@flygoat.com>
References: <20240522-loongarch-booting-fixes-v3-0-25e77a8fc86e@flygoat.com>
In-Reply-To: <20240522-loongarch-booting-fixes-v3-0-25e77a8fc86e@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=+ZkFOOEzPJ9R8rASkmEVkeYaiXTIikAfh4ZoUZH4DP8=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjS/7JxvDx3in+xkvqjqtLrTvtNUKkvQPSKHqc4uPmC13
 YqaqfYdpSwMYlwMsmKKLCECSn0bGi8uuP4g6w/MHFYmkCEMXJwCMJHCewz/K5+5OX2c7qm9b0mv
 XOefqYoC85qSX7ruMjzhf1VOUTrXi+EPT4OmBO+6hqlXvfofnYy+Fx6a8yDWc3a5QXZ5z0QJX1Z
 uAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

fdt_check_header(__dtb_start) will always success because kernel
provided a dummy dtb, and by coincidence __dtb_start clashed with
entry of this dummy dtb. The consequence is fdt passed from
firmware will never be taken.

Fix by trying to utilise __dtb_start only when CONFIG_BUILTIN_DTB
is enabled.

Cc: stable@vger.kernel.org
Fixes: 7b937cc243e5 ("of: Create of_root if no dtb provided by firmware")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v3: Better reasoning in commit message, thanks Binbin and Huacai!
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



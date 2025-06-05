Return-Path: <stable+bounces-151488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DA6ACE966
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 07:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1B61897803
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 05:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684C31EF397;
	Thu,  5 Jun 2025 05:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="BDMRmr5e"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E254C1DDC22;
	Thu,  5 Jun 2025 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749102535; cv=none; b=T6Cy/NQ7+52top0Za5E8wTmFbmxe8YAu0IC/AbBInpCFqyziFTqiDpHrpQFDodJEh/ali9o3zrtRWXl/Xlu2jBsTSzBTTuDtCiqHawUeuVekmmW/jg798ka7kzNjf2QGT75M4m7cuPDzyNr/cnzPaJr4YJWRcqOTfaCtQaVp+hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749102535; c=relaxed/simple;
	bh=i7Lj9tfu5NAQfMbyaPdpkBbDZUvI5+SMvlElgB75CI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pmu19KBegPPT7FdAq7rqhlr9KKyJeQch0WKZorJNl/MMpJd0xqRKpqcOMHgYQXkPwBNaeY8FDEVBuURGc7zSPlExaiDKYcpOLONN3aH+Wr914XvOafVM++IJGbtmWdgq/YOExjG6ALqMirtSU3TzIgisKp5EJaHihMH1ThS8R8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=BDMRmr5e; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 71CED260B0;
	Thu,  5 Jun 2025 07:48:51 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6IFpYv2bA_xj; Thu,  5 Jun 2025 07:48:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1749102530; bh=i7Lj9tfu5NAQfMbyaPdpkBbDZUvI5+SMvlElgB75CI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BDMRmr5eXNBGMSorzdB5BFXakNR12aprNezRo8j7hFAeFrKI9c5LNNA0m8aUGiT9l
	 dTMf3OKHkccJiuUPWnie7wNEZGvMJuqnN1uEEOUNReuNR60M2dDP7RdxDoSY1qUioF
	 X4oL6lwllNVHjN9h7zDfqlc5o5pp4wOMTn2nM3ACMrC2Le2R6Cyf9lG3YwMykj9qHL
	 /v4GIWEMuMei0Z1+BeJnp5EWCELLZtMmNbnONHpKEsxnoG8DYtn0/53oKHCat38vD8
	 G1R2xC58bl29LcHugHeuWAtV6qHhichRvcHttrWYroWqm+ZzMk/FBNntem1sLYSB6s
	 636z8lfl0HFGA==
From: Yao Zi <ziyao@disroot.org>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <ziyao@disroot.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] platform/loongarch: laptop: Get brightness setting from EC on probe
Date: Thu,  5 Jun 2025 05:48:27 +0000
Message-ID: <20250605054828.15093-2-ziyao@disroot.org>
In-Reply-To: <20250605054828.15093-1-ziyao@disroot.org>
References: <20250605054828.15093-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously during probe, 1 is unconditionally taken as current
brightness value and set to props.brightness, which will be considered
as the brightness before suspend and restored to EC on resume. Since a
brightness value of 1 almost never matches EC's state on coldboot (my
laptop's EC defaults to 80), this causes surprising changes of screen
brightness on the first time of resume after coldboot.

Let's get brightness from EC and take it as the current brightness on
probe of the laptop driver to avoid the surprising behavior. Tested on
TongFang L860-T2 3A5000 laptop.

Cc: stable@vger.kernel.org
Fixes: 6246ed09111f ("LoongArch: Add ACPI-based generic laptop driver")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/platform/loongarch/loongson-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
index 99203584949d..828bd62e3596 100644
--- a/drivers/platform/loongarch/loongson-laptop.c
+++ b/drivers/platform/loongarch/loongson-laptop.c
@@ -392,7 +392,7 @@ static int laptop_backlight_register(void)
 	if (!acpi_evalf(hotkey_handle, &status, "ECLL", "d"))
 		return -EIO;
 
-	props.brightness = 1;
+	props.brightness = ec_get_brightness();
 	props.max_brightness = status;
 	props.type = BACKLIGHT_PLATFORM;
 
-- 
2.49.0



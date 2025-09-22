Return-Path: <stable+bounces-181328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59DAB930A4
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE52163E91
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39CA31194D;
	Mon, 22 Sep 2025 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d+oaTG5J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F02F1FE3;
	Mon, 22 Sep 2025 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570264; cv=none; b=hWj5J8I1epVKm1PayEN28UCP1QFkpvAB4fdXqI/yG1eNAJQCTjRSNLZwL22l8pNv9+lA+m7RK6GcihjJzkOHZ7s+QgipecmzndtBTEWjZFnhWTkh4w0ybHYcXiMzekeM55NJWA9+jMc84NaIDVafPIUhfe9ewgqX664H+xiljJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570264; c=relaxed/simple;
	bh=YS/Ss4awfFQQCkggH5AOhAHYjJhn6fM6ULX4SDUvdTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxaU4OBr5UFFA4igNWs3NnBw1KBJ2VmfztbuI1MpQx236gf4HQKQezZ8bLib87dpsnqC79+f6ez/2zkzQaefyfhSpyw9sC+dgnHwjz408zrgwyy/TYK+KCau4mURZvrOXgydpNRiBh59+rK/DMeIT9ogoP8m1gxj182Uc2lB+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d+oaTG5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C42C4CEF5;
	Mon, 22 Sep 2025 19:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570264;
	bh=YS/Ss4awfFQQCkggH5AOhAHYjJhn6fM6ULX4SDUvdTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+oaTG5J8FSomok6oxHrG1tNTyquDWgslGfANONOeVI+Nt4z8UUWPH+5p/YRZseDh
	 rvs0Rb3nqbP+zO33bwnPoz1yKj3kcBdZYMlVy6rPaH80PdtRIfViY5wICK+bLv2f8U
	 aupACXVYBs/BshJlZCwElgW0tEzMs/FR2ZQEoEO8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.16 069/149] LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN enabled
Date: Mon, 22 Sep 2025 21:29:29 +0200
Message-ID: <20250922192414.627820625@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit a9d13433fe17be0e867e51e71a1acd2731fbef8d upstream.

ARCH_STRICT_ALIGN is used for hardware without UAL, now it only control
the -mstrict-align flag. However, ACPI structures are packed by default
so will cause unaligned accesses.

To avoid this, define ACPI_MISALIGNMENT_NOT_SUPPORTED in asm/acenv.h to
align ACPI structures if ARCH_STRICT_ALIGN enabled.

Cc: stable@vger.kernel.org
Reported-by: Binbin Zhou <zhoubinbin@loongson.cn>
Suggested-by: Xi Ruoyao <xry111@xry111.site>
Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/include/asm/acenv.h |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/arch/loongarch/include/asm/acenv.h
+++ b/arch/loongarch/include/asm/acenv.h
@@ -10,9 +10,8 @@
 #ifndef _ASM_LOONGARCH_ACENV_H
 #define _ASM_LOONGARCH_ACENV_H
 
-/*
- * This header is required by ACPI core, but we have nothing to fill in
- * right now. Will be updated later when needed.
- */
+#ifdef CONFIG_ARCH_STRICT_ALIGN
+#define ACPI_MISALIGNMENT_NOT_SUPPORTED
+#endif /* CONFIG_ARCH_STRICT_ALIGN */
 
 #endif /* _ASM_LOONGARCH_ACENV_H */




Return-Path: <stable+bounces-134438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDBBA92B11
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64E84A7B63
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA9A256C97;
	Thu, 17 Apr 2025 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R8UZnRtn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DDA256C61;
	Thu, 17 Apr 2025 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916127; cv=none; b=bQLB/F2HhU2Ka+yybyCTYuakV4xTpawjdLbPHchra9dzSU+6viK3ZB6K5MSzgb9BS5jytUvjuYNh6SkjpNjm4Dsk0FAqcw66tIjHjsx/1cWSL5TPOqY9fQrATKjdzV5hCchfOBrRnbhlnVsrY1BNd7/q5X5qNShIJIH8ZxLA9hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916127; c=relaxed/simple;
	bh=cr3LQVicr0Z+u0FfsNwIFkQgSl5nMol+sQY7hhhVINQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlGL7YIgQyTgNpsPuL3XJUrQTMh9cvvxRjBoE6E3jH5hGMGYdwjKsBszcDOUl+Oj30/EZqfjDgrEQGbvrMD+D82kx643otrHsmQ2pLFRkUOtkh6Muu/ki/FmWvH+OzT3ehzfJM8lpFHz/tWttzurTeaCmf8nibGMhmRksdglOtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R8UZnRtn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B842C4CEE4;
	Thu, 17 Apr 2025 18:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744916126;
	bh=cr3LQVicr0Z+u0FfsNwIFkQgSl5nMol+sQY7hhhVINQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R8UZnRtn40Nsac/aG8RJccitNo7f+deCmp6AP+Qm5sad6VVeOmZqdRk2YhCpADOIk
	 aNqwnHL/WCAnDeHfAF1DmZETGKWEn0dmIf4hNhklyg6D/ir25C2/A9YpjGmhf20OqP
	 QdRBz8gJ4uXSbec8u2vXONG5uev64Q1gRtCXyW3M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hien Huynh <hien.huynh.px@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6.12 322/393] clk: renesas: r9a07g043: Fix HP clock source for RZ/Five
Date: Thu, 17 Apr 2025 19:52:11 +0200
Message-ID: <20250417175120.568527205@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 7f22a298d926664b51fcfe2f8ea5feb7f8b79952 upstream.

According to the Rev.1.20 hardware manual for the RZ/Five SoC, the clock
source for HP is derived from PLL6 divided by 2.  Correct the
implementation by configuring HP as a fixed clock source instead of a
MUX.

The `CPG_PL6_ETH_SSEL' register, which is available on the RZ/G2UL SoC,
is not present on the RZ/Five SoC, necessitating this change.

Fixes: 95d48d270305ad2c ("clk: renesas: r9a07g043: Add support for RZ/Five SoC")
Cc: stable@vger.kernel.org
Reported-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250127173159.34572-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/renesas/r9a07g043-cpg.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -89,7 +89,9 @@ static const struct clk_div_table dtable
 
 /* Mux clock tables */
 static const char * const sel_pll3_3[] = { ".pll3_533", ".pll3_400" };
+#ifdef CONFIG_ARM64
 static const char * const sel_pll6_2[]	= { ".pll6_250", ".pll5_250" };
+#endif
 static const char * const sel_sdhi[] = { ".clk_533", ".clk_400", ".clk_266" };
 
 static const u32 mtable_sdhi[] = { 1, 2, 3 };
@@ -137,7 +139,12 @@ static const struct cpg_core_clk r9a07g0
 	DEF_DIV("P2", R9A07G043_CLK_P2, CLK_PLL3_DIV2_4_2, DIVPL3A, dtable_1_32),
 	DEF_FIXED("M0", R9A07G043_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
 	DEF_FIXED("ZT", R9A07G043_CLK_ZT, CLK_PLL3_DIV2_4_2, 1, 1),
+#ifdef CONFIG_ARM64
 	DEF_MUX("HP", R9A07G043_CLK_HP, SEL_PLL6_2, sel_pll6_2),
+#endif
+#ifdef CONFIG_RISCV
+	DEF_FIXED("HP", R9A07G043_CLK_HP, CLK_PLL6_250, 1, 1),
+#endif
 	DEF_FIXED("SPI0", R9A07G043_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
 	DEF_FIXED("SPI1", R9A07G043_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
 	DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, SEL_SDHI0, SEL_SDHI0_STS, sel_sdhi,




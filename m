Return-Path: <stable+bounces-154143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C43ADD9E7
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408CC5A0346
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746072ED84B;
	Tue, 17 Jun 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E5NFDN1T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4752FA64D;
	Tue, 17 Jun 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178239; cv=none; b=Fqpn3RknOgTJikbIhIjYNSSOhmtb54Zctw7AsdlaPnuhjxxIxuMwqO/KiwJVN0cMW2c/7NmYfsQEvH0InasO7Kims4piXz69ncxNgK8AugiQtdMIiHetVT1FeoNF9DZPjJvQtQUI8jFXspqHL6loSbbS+j897iwfSZHehCvd5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178239; c=relaxed/simple;
	bh=HBWWqgapv+rjYa3EeRXzOlIWMTRHWeD8/GpWWQuRzPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZoa5X8cp5YraSrs2deRWD8/JVlyKI/oIWx5SvXHOT8Rfhs24wNLKAYlOTIF/ceKX3MsP1BHW6P22NJGlnVlsVdmmMsr86ZFD1H1kojpnNafsdlC/iBJZtf5tKWFA8/udhqx+AVFbCiD57n/U3o//902Z5JVbeQUi80NrgQv+do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E5NFDN1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85486C4CEE3;
	Tue, 17 Jun 2025 16:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178239;
	bh=HBWWqgapv+rjYa3EeRXzOlIWMTRHWeD8/GpWWQuRzPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E5NFDN1TwqjIBVgXaiN/XjfzPD+SPcy5ROGSMWYHp5q7hiNzW8X04gsu2W3FY1F3V
	 Mr725tZ1sBCOhZ1dEzVPz1bsMezzfJgnArMkBf+QK/CGvy8Zn6/a6SrUrNAmgcOclY
	 H0ZP2dqmKOk1/348NHr2QBgPoB5LAQvvRAIsVkjQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?F=C3=A9lix=20Pi=C3=A9dallu?= <felix.piedallu@non.se.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 439/512] spi: omap2-mcspi: Disable multi-mode when the previous message kept CS asserted
Date: Tue, 17 Jun 2025 17:26:45 +0200
Message-ID: <20250617152437.358775593@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Félix Piédallu <felix.piedallu@non.se.com>

[ Upstream commit 10c24e0d2f7cd2bc8a847cf750f01301ce67dbc8 ]

When the last transfer of a SPI message has the cs_change flag, the CS is kept
asserted after the message.
The next message can't use multi-mode because the CS will be briefly deasserted
before the first transfer.

Remove the early exit of the list_for_each_entry because the last transfer
actually needs to be always checked.

Fixes: d153ff4056cb ("spi: omap2-mcspi: Add support for MULTI-mode")
Signed-off-by: Félix Piédallu <felix.piedallu@non.se.com>
Link: https://patch.msgid.link/20250606-cs_change_fix-v1-2-27191a98a2e5@non.se.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 05766b98de36f..4c5f12b76de6a 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -134,6 +134,7 @@ struct omap2_mcspi {
 	size_t			max_xfer_len;
 	u32			ref_clk_hz;
 	bool			use_multi_mode;
+	bool			last_msg_kept_cs;
 };
 
 struct omap2_mcspi_cs {
@@ -1269,6 +1270,10 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 	 * multi-mode is applicable.
 	 */
 	mcspi->use_multi_mode = true;
+
+	if (mcspi->last_msg_kept_cs)
+		mcspi->use_multi_mode = false;
+
 	list_for_each_entry(tr, &msg->transfers, transfer_list) {
 		if (!tr->bits_per_word)
 			bits_per_word = msg->spi->bits_per_word;
@@ -1289,22 +1294,17 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 
 		if (list_is_last(&tr->transfer_list, &msg->transfers)) {
 			/* Check if transfer asks to keep the CS status after the whole message */
-			if (tr->cs_change)
+			if (tr->cs_change) {
 				mcspi->use_multi_mode = false;
+				mcspi->last_msg_kept_cs = true;
+			} else {
+				mcspi->last_msg_kept_cs = false;
+			}
 		} else {
 			/* Check if transfer asks to change the CS status after the transfer */
 			if (!tr->cs_change)
 				mcspi->use_multi_mode = false;
 		}
-
-		/*
-		 * If at least one message is not compatible, switch back to single mode
-		 *
-		 * The bits_per_word of certain transfer can be different, but it will have no
-		 * impact on the signal itself.
-		 */
-		if (!mcspi->use_multi_mode)
-			break;
 	}
 
 	omap2_mcspi_set_mode(ctlr);
-- 
2.39.5





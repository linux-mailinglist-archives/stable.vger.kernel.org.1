Return-Path: <stable+bounces-154087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3850ADD808
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25863AA505
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F7F2FA659;
	Tue, 17 Jun 2025 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dqPXEnPG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E7B2FA656;
	Tue, 17 Jun 2025 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178059; cv=none; b=bWQUVhdO9/NB5pMyGixL0rCdIu3CNXesiIqtFTX91YeVlKC6ECp0FtJGtHPcoPjczq3CBLs+aev88d+925ENcPRQHicGk5Hu0NcaYH3WELIH6QYliT08MknmOY4dauNYbouGWNgumdlJ/4TV4X6BaZvQTwNBq/F4iUXMFBh3erw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178059; c=relaxed/simple;
	bh=bR8HequTPWmhYxzOb38sw/b0x6A3B5Sp3cTipEhWzQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjz6bQfrdqnx8DW9Kki9eKYjX9lGkHO32YziLPf6Q96KqqoBUX6B+AlyC0hIw0pS0Z0AoIieA6zGn9pVKbsC6rGHMwbrzkLeEFEAuH2h62m7lEQOyRYGcNDlxkTozr47JW8eJLhUM6X5TFKwUwyEG94nzsTdJWGl1DAAaoipyis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dqPXEnPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B271DC4CEE3;
	Tue, 17 Jun 2025 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178059;
	bh=bR8HequTPWmhYxzOb38sw/b0x6A3B5Sp3cTipEhWzQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dqPXEnPG2+F1/X7xJa0t94JnvyXn3JQ3JvG1eopbqpSmBk+3BDGuu642EWiG/6Tt0
	 NWTbbEbtgE5dBzxOdq43/iNT18MmT+hm6RaFQNjNsVq0zd6PsjAuS3uUJjD+PsWHCs
	 /1PqV39nD9Oge5aOxqdgDQVo/Fem4lEUswB/V9nA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?F=C3=A9lix=20Pi=C3=A9dallu?= <felix.piedallu@non.se.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 438/512] spi: omap2-mcspi: Disable multi mode when CS should be kept asserted after message
Date: Tue, 17 Jun 2025 17:26:44 +0200
Message-ID: <20250617152437.317708431@linuxfoundation.org>
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

[ Upstream commit a5bf5272295d3f058adeee025d2a0b6625f8ba7b ]

When the last transfer of a SPI message has the cs_change flag, the CS is kept
asserted after the message.
Multi-mode can't respect this as CS is deasserted by the hardware at the end of
the message.

Disable multi-mode when not applicable to the current message.

Fixes: d153ff4056cb ("spi: omap2-mcspi: Add support for MULTI-mode")
Signed-off-by: Félix Piédallu <felix.piedallu@non.se.com>
Link: https://patch.msgid.link/20250606-cs_change_fix-v1-1-27191a98a2e5@non.se.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 532b2e9c31d0d..05766b98de36f 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1287,9 +1287,15 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 			mcspi->use_multi_mode = false;
 		}
 
-		/* Check if transfer asks to change the CS status after the transfer */
-		if (!tr->cs_change)
-			mcspi->use_multi_mode = false;
+		if (list_is_last(&tr->transfer_list, &msg->transfers)) {
+			/* Check if transfer asks to keep the CS status after the whole message */
+			if (tr->cs_change)
+				mcspi->use_multi_mode = false;
+		} else {
+			/* Check if transfer asks to change the CS status after the transfer */
+			if (!tr->cs_change)
+				mcspi->use_multi_mode = false;
+		}
 
 		/*
 		 * If at least one message is not compatible, switch back to single mode
-- 
2.39.5





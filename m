Return-Path: <stable+bounces-98684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEEB9E49F7
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1571882359
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B98212B31;
	Wed,  4 Dec 2024 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbsB5HLg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC3212B1A;
	Wed,  4 Dec 2024 23:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355329; cv=none; b=dIjEZopfUEGcFB7lB3eUiCr7E5R9JZk7Uq9IMiG7CRP22UckETyu5vonwrwmODW/7a2taBbpTedvowieYcC0ifgfrsBWbSbYDFeki1f6q0L8WhcAFOVe/2nyUpApLB0S7clgIWROMFlzIYbgrd1+cncpP8/9WQXj6cvw301IJTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355329; c=relaxed/simple;
	bh=nXLeo5Lvnrbx7/XuHNCN/7+mLimUxnLn37cF4/DCK+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lISbSy6+uvUz4HGYVWSJ2n9dWRqjZ/2dE4x4Ycq2xysPf2d8BorLG5jQCuAmZcYAiNOjF8jYJ6ccPqcwpvKBXF8dBY/T865oGj2C07czRYWi4PXFOHw0DE6DY7UpFIdKVR/y0TxmfbSrHNvE+38Y3mCS8JBjahhE2yRWwMoCKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbsB5HLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA2CC4CED6;
	Wed,  4 Dec 2024 23:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355325;
	bh=nXLeo5Lvnrbx7/XuHNCN/7+mLimUxnLn37cF4/DCK+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RbsB5HLgEGQG7gxSo+AyRbgY9PEvgVNMo9qYhNnGdHPsHcz6ajWwmFcp0PSeLwttA
	 wJxS02SNKCbj7on0MLgQjic/VKC0gcR01qYCwKCn+j+fZQ+LU1EoALvwYrnOGac1Q8
	 9oa1p8l13ubHV4TDL/RHGS5bHiFUQqV5emUHtWsqzjQbzONINRgazj496HZy5m8I15
	 DmISXK4EvwFXuEk1cjjGA4BCXdzLDu4SdVwk2zyU/IpxNQSrZET1qnGPiPDz817bkz
	 edwoesKyBp+D0S/9BpK6wa/ju0XDjL6oqhCz/tBZCq92wk0T2ztGCLTGAPt/eULXQW
	 rUhBVYRRs4jbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	jirislaby@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 3/7] serial: 8250_dw: Add Sophgo SG2044 quirk
Date: Wed,  4 Dec 2024 17:23:45 -0500
Message-ID: <20241204222402.2249702-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204222402.2249702-1-sashal@kernel.org>
References: <20241204222402.2249702-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Inochi Amaoto <inochiama@gmail.com>

[ Upstream commit cad4dda82c7eedcfc22597267e710ccbcf39d572 ]

SG2044 relys on an internal divisor when calculating bitrate, which
means a wrong clock for the most common bitrates. So add a quirk for
this uart device to skip the set rate call and only relys on the
internal UART divisor.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Link: https://lore.kernel.org/r/20241024062105.782330-4-inochiama@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_dw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index ab9e7f2042602..51894c93c8a31 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -750,7 +750,7 @@ static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
 	.quirks = DW_UART_QUIRK_CPR_VALUE | DW_UART_QUIRK_IS_DMA_FC,
 };
 
-static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
+static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
 	.usr_reg = DW_UART_USR,
 	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
 };
@@ -760,7 +760,8 @@ static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
 	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
-	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
+	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_skip_set_rate_data },
+	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dw8250_of_match);
-- 
2.43.0



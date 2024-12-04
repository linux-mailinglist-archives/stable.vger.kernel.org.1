Return-Path: <stable+bounces-98696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE4F9E4A07
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F7028DF57
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EE7226ECD;
	Wed,  4 Dec 2024 23:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV2zR0Ek"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF82226EC1;
	Wed,  4 Dec 2024 23:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355368; cv=none; b=rzSYgLFIRBA3StIJVt6Ow5xVuigtrqkFoEMWphBCXDG+wl2jY2XttdrQCVLWxfZ1OtuBxAY0uiPoq7oQ2HlJUuijthOPZ6RTWla19fulCohWlQtATwsEmm8CpMmxUmUbOYZZeuzbO19eClyknOW4ki3FKFufxLEhPLKERmYLM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355368; c=relaxed/simple;
	bh=Rm/MIvVBWlETnetubNF/S/6ivRcUw/2qry7QLyjvVNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjUeJbCoiuD1oRxfUwcFRnkmof8IqtG/we+PKN/o71Q77r+OBZwf61sSWBh32fHvzNm3JcRj9u9N7On/Q/Y/SAFxi+VF5klR2WhvENrpifEL3m/Wmlzq8a6sPWvAAk46WMUGmO2K3yppx1F80vYRcLq2npTpRmC4JJmDx/rphZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV2zR0Ek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8E6C4CED6;
	Wed,  4 Dec 2024 23:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355367;
	bh=Rm/MIvVBWlETnetubNF/S/6ivRcUw/2qry7QLyjvVNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DV2zR0Ek0D20SmbB3UW+/iTcludKr1NRcGrtdH9EsVkovq8NdlJ4xlu6TKEuCp94N
	 C4HIixHKHxEgx897JLg8YMGxVwdavlszo02Ghun+c3JQPdeqk5b5JUhwg0khLNC/Ez
	 NlLjjsEgIJ9h+tLm5Ics5fjXuSEFeZoBjd9e1ks3zWG0E4H2x91YwkS+FdxpYpxB92
	 CUX8jxC7RNApx4Hhc/JK9jnX5mCz8Lp2KSBmx425oCs4YWsfx5AtXCOpGawKoXCa3B
	 WpJvvQt+SeGNjL09z1/xMU5tbHLBx7ty4OmQTLtpLEpUdqHy927XufDaoK5jGXebMt
	 1Ek0w2FkzXzag==
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
Subject: [PATCH AUTOSEL 6.1 3/4] serial: 8250_dw: Add Sophgo SG2044 quirk
Date: Wed,  4 Dec 2024 17:24:35 -0500
Message-ID: <20241204222444.2250332-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204222444.2250332-1-sashal@kernel.org>
References: <20241204222444.2250332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index a1f2259cc9a98..72f9aab75ab12 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -770,7 +770,7 @@ static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
 	.quirks = DW_UART_QUIRK_IS_DMA_FC,
 };
 
-static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
+static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
 	.usr_reg = DW_UART_USR,
 	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
 };
@@ -780,7 +780,8 @@ static const struct of_device_id dw8250_of_match[] = {
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



Return-Path: <stable+bounces-98690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479C29E4A02
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622FC161AB9
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C68215F51;
	Wed,  4 Dec 2024 23:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5MkavW1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD712215F49;
	Wed,  4 Dec 2024 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355348; cv=none; b=awY8juF/uu90Q5A3u8y1Io73ArSpvCIjTmFuQ6pvhvy6KBTMXxLPBw9+74WG2HJNKWte/h8D43xcPpN6KdWp3iqDjvg6nyjFmghGNb8QLJMdF4f3sNf1i94DSSnv3qtJR+Uit/60yQZplA0jbW9gpTH8M7yCORxl8l7PCisvLG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355348; c=relaxed/simple;
	bh=334qt/j7qYLk4mEYTYpVdCFHGSuiH7C3EuTPiPIgl6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdtGeCYgue9dMWZsuAB1wBW5YGiRVexyKaj7QJoHmIkll0kpV6OgLxhdn+oqnD/1VNWgbvgbx9UkpJVHgWpn6ENgoURPR30CXa4qGgS2Lx6rB6BMR5NyV5tVkbbzCVWl0WrVVldHD+rTmMvZ+Epj2ZJY/JBu+Qyxv1zElJXGftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5MkavW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B75AC4CED6;
	Wed,  4 Dec 2024 23:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355348;
	bh=334qt/j7qYLk4mEYTYpVdCFHGSuiH7C3EuTPiPIgl6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5MkavW18GD5ueA1W1L97iCVNKR0QDyCB5yMmRKZlEZY6B94jaymkHsT55HJn3plO
	 5gbR+/56VsHcd2hGOMhSqNWAWj0+PQo/aqyiuE5cMQfLgjXKgEwiIgwr5dS7Kb2pkX
	 V6BHauqFuNbtfP/FAsYZECvS8Lt2V49w4QrkpFnINS7B5Rase0DhtUaLoKY/1yVlGy
	 iZRa3SUf+M06xnc34gHzpISZ+EReEkJ6P6VF+5VnxkY9XcPZWg48Y1rzUjqta0JJ5+
	 G8tTbkShRYFNewHsu0OVAmkz9PiB4/3XP+0wMz+cizGbaK4YBozjLjQ7dxkMIrJETz
	 vi7/L51SafQ3Q==
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
Subject: [PATCH AUTOSEL 6.6 3/6] serial: 8250_dw: Add Sophgo SG2044 quirk
Date: Wed,  4 Dec 2024 17:24:12 -0500
Message-ID: <20241204222425.2250046-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204222425.2250046-1-sashal@kernel.org>
References: <20241204222425.2250046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 8aed33be2ebf4..eaf4a907380aa 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -785,7 +785,7 @@ static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
 	.quirks = DW_UART_QUIRK_CPR_VALUE | DW_UART_QUIRK_IS_DMA_FC,
 };
 
-static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
+static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
 	.usr_reg = DW_UART_USR,
 	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
 };
@@ -795,7 +795,8 @@ static const struct of_device_id dw8250_of_match[] = {
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



Return-Path: <stable+bounces-215377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOxcAf33iWl7FAAAu9opvQ
	(envelope-from <stable+bounces-215377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:06:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A068111874
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8E60311E7D7
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C312DB7B4;
	Mon,  9 Feb 2026 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MEwu60jZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265BD28725B;
	Mon,  9 Feb 2026 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648595; cv=none; b=riapssRPFJaTVfPbW2VgJxY9TlFzFyrsV8wIrbcSNdjccGI/a2DCJwZ87sbb6i0KI8U3yTz4WB7Rp9H66iLsaUU5+XoCuPcCF8Nx/JePzjZNmERJGknWxodnk0f6pB/RHDwgrcmAw7wi6N1gIxOqX85Yc0N5qL2bq4GTmNEBeUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648595; c=relaxed/simple;
	bh=vjsddN6s04Kxl6OfbVWr0c2QmBlag6SRnU9sMKSnKcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxyavnosFAixiIY64VlcDS0XLyK/kAmLg3ffWcsBdEfleneLUsolxAYSdcuSAw8HnTqwbVIvfc9wJneccXMRHskA9xBviZz5Pq2aXSUQELYrDcPZGzXqzYhy6MzFST1oOLv9wcb7TFG9f4Q1nndnbBwJBByBVlRgQPkCPqHN2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MEwu60jZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0DAC116C6;
	Mon,  9 Feb 2026 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648595;
	bh=vjsddN6s04Kxl6OfbVWr0c2QmBlag6SRnU9sMKSnKcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEwu60jZx8Vpt3d/oXRnkD7ddaFYWVgEas6jl9qUerc/WjwXQPgRMng1BtlxICEKF
	 h4hsYq7xYpL+d7QQKychsGy/OWi9ZXAZsmmbnklfayjPzyjofE/B8a2YS/D/C9qsbg
	 UCyleVDz6AXhZa27xJlNxmaexcykRUJ/64Ox34nw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vishwaroop A <va@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 85/86] spi: tegra114: Preserve SPI mode bits in def_command1_reg
Date: Mon,  9 Feb 2026 15:24:48 +0100
Message-ID: <20260209142307.845376962@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
References: <20260209142304.770150175@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215377-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A068111874
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vishwaroop A <va@nvidia.com>

[ Upstream commit a0a75b40c919b9f6d3a0b6c978e6ccf344c1be5a ]

The COMMAND1 register bits [29:28] set the SPI mode, which controls
the clock idle level. When a transfer ends, tegra_spi_transfer_end()
writes def_command1_reg back to restore the default state, but this
register value currently lacks the mode bits. This results in the
clock always being configured as idle low, breaking devices that
need it high.

Fix this by storing the mode bits in def_command1_reg during setup,
to prevent this field from always being cleared.

Fixes: f333a331adfa ("spi/tegra114: add spi driver")
Signed-off-by: Vishwaroop A <va@nvidia.com>
Link: https://patch.msgid.link/20260204141212.1540382-1-va@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra114.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 8d7ce4c556aa1..c99f72c9ab176 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -978,11 +978,14 @@ static int tegra_spi_setup(struct spi_device *spi)
 	if (spi_get_csgpiod(spi, 0))
 		gpiod_set_value(spi_get_csgpiod(spi, 0), 0);
 
+	/* Update default register to include CS polarity and SPI mode */
 	val = tspi->def_command1_reg;
 	if (spi->mode & SPI_CS_HIGH)
 		val &= ~SPI_CS_POL_INACTIVE(spi_get_chipselect(spi, 0));
 	else
 		val |= SPI_CS_POL_INACTIVE(spi_get_chipselect(spi, 0));
+	val &= ~SPI_CONTROL_MODE_MASK;
+	val |= SPI_MODE_SEL(spi->mode & 0x3);
 	tspi->def_command1_reg = val;
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 	spin_unlock_irqrestore(&tspi->lock, flags);
-- 
2.51.0





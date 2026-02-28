Return-Path: <stable+bounces-220226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF30JgYyo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C221C5B12
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2FFB31AA7F3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038F4F7966;
	Sat, 28 Feb 2026 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PR76CM5A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DE047CC85;
	Sat, 28 Feb 2026 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300131; cv=none; b=MiW0/1XSzQYNhDtXs9HQ8nG8aaoeP8dQDLFSW/o13fSqrerBtU9Anx7ZV3FIOb5CtKQcUKa33X6as3ECARijvoEKw0+EfF6Ho2gOWkZ/CIFNsri9OiDAgU3VD0sbOlJpoG/U6742ba+lOvI5tTLbBwz2edOXRSZUjD6kFoYRmQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300131; c=relaxed/simple;
	bh=IsQH2GK7lrSZDfrhWKcM5PD+4pD16JHIZmz5ZCPkWUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCZ+PJEUat01fsu7gB7priuIlyWdh/8ZStUs8hNlTLlWZXwJ2J7vIXOr0BUzHJYaj+kWalX9RTpHagA3Z3ysAWDL7pUtGyyTS5uhJl5693J7aUs+ghpjzB5ZPAgTfdYm5Digp1J1LfQw2XDjRsQs2aoyrYo6KVJw5F6CgwBDj1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PR76CM5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF27C19423;
	Sat, 28 Feb 2026 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300131;
	bh=IsQH2GK7lrSZDfrhWKcM5PD+4pD16JHIZmz5ZCPkWUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PR76CM5AMDRcp01G/gOZbePaWjpH6C5+u4/9INLmF8M/jPS8pnc7m5h43H+mlra4n
	 FFEzkk5nN0Rhu7TQ6v4W9FHwdW/oeCrycIgUNhx0YUxPzpnOKwHQaU/x0spxPRr7Kn
	 N8jCKyBjH3mdVA7NaZBmRB0Bwms+iSONJ73TVhZNoINtrkheHSKn35Lhz0nbHDZjai
	 EljZQq1QbF1abF68lU0F12S6lgAmXlA2DSh36+8u0tKuUIJIMah/M6qyYZFiAWXS2d
	 +o75GyRWGzqh9k2erBoOp44z/Mgj+rLmYeC3BfgRIieP0P1NkmNFL/wt+GC2UcPNnJ
	 sy04OYFzBbrHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Deepak Kumar <deepak.kumar01@st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 148/844] spi: stm32: fix Overrun issue at < 8bpw
Date: Sat, 28 Feb 2026 12:21:01 -0500
Message-ID: <20260228173244.1509663-149-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220226-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05C221C5B12
X-Rspamd-Action: no action

From: Deepak Kumar <deepak.kumar01@st.com>

[ Upstream commit 1ac3be217c01d5df55ec5052f81e4f1708f46552 ]

When SPI communication is suspended by hardware automatically, it could
happen that few bits of next frame are already clocked out due to
internal synchronization delay.

To achieve a safe suspension, we need to ensure that each word must be
at least 8 SPI clock cycles long. That's why, if bpw is less than 8
bits, we need to use midi to reach 8 SPI clock cycles at least.

This will ensure that each word achieve safe suspension and prevent
overrun condition.

Signed-off-by: Deepak Kumar <deepak.kumar01@st.com>
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Link: https://patch.msgid.link/20251218-stm32-spi-enhancements-v2-2-3b69901ca9fe@foss.st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-stm32.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 2c804c1aef989..80986bd251d29 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1906,11 +1906,12 @@ static void stm32h7_spi_data_idleness(struct stm32_spi *spi, struct spi_transfer
 	cfg2_clrb |= STM32H7_SPI_CFG2_MIDI;
 	if ((len > 1) && (spi->cur_midi > 0)) {
 		u32 sck_period_ns = DIV_ROUND_UP(NSEC_PER_SEC, spi->cur_speed);
-		u32 midi = min_t(u32,
-				 DIV_ROUND_UP(spi->cur_midi, sck_period_ns),
-				 FIELD_GET(STM32H7_SPI_CFG2_MIDI,
-				 STM32H7_SPI_CFG2_MIDI));
+		u32 midi = DIV_ROUND_UP(spi->cur_midi, sck_period_ns);
 
+		if ((spi->cur_bpw + midi) < 8)
+			midi = 8 - spi->cur_bpw;
+
+		midi = min_t(u32, midi, FIELD_MAX(STM32H7_SPI_CFG2_MIDI));
 
 		dev_dbg(spi->dev, "period=%dns, midi=%d(=%dns)\n",
 			sck_period_ns, midi, midi * sck_period_ns);
-- 
2.51.0



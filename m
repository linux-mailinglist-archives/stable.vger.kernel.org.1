Return-Path: <stable+bounces-268180-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mp8tDLv1O2o+gggAu9opvQ
	(envelope-from <stable+bounces-268180-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 17:20:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEEF6BF942
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 17:20:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=O9tX6pV0;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=IzAxwnba;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268180-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268180-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C999230117B6
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74D03DA5AC;
	Wed, 24 Jun 2026 15:20:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F323DA5A0;
	Wed, 24 Jun 2026 15:20:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782314417; cv=none; b=L6jAScneTTdUJHtXZoY+UZqQZfTwHuzi2NdDyTUxj6RU9R+0lBp9aH+vl3EuYvkqHzRgpb/ol5VkMsGXa/fn9dFbRQtZ22uONzWjpsTWgGANMQ28lhI/LTh9hr4aj+gvid3tsmozeHd7gQU2cwa1Cp2dWrayAdHo9XoJZChVoDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782314417; c=relaxed/simple;
	bh=i8fRLo5LYOvfrJBpdpoaACvdd+LXf/b95GMHNF/iCOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAAgPJTiUQnUsoktaJ2lpCl4p6OYRWo16me3U5B3Kh9PigQZJsGMZFyyyh4Oe4NIjlryOBxFFgFrixGMwGDVA4U2pX2gyzK67Yjp0Mg7zFTPWfstCbVvVpr7RcSoVeS5LBkEv45CCdNKovj4jbKcK/gkRyJbyq8/XdaKQ4JnSMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O9tX6pV0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IzAxwnba; arc=none smtp.client-ip=193.142.43.55
From: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782314414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=spgZE5DVRE3AVvzfElFMQQANIXP+yeQwZcb1XoUbe5M=;
	b=O9tX6pV0wktZmIpN+CncnqgZWeMBK4Lh4d/wB9jj/zXVMzXA3cqBRyI+0OsQQTJJkQERqH
	sLjU1BAI/NNvGFIXqnIltSBF2nLP13bePTTO5mFBSWKX1gA80VkgSuh25c9P18+Om3YDzx
	d8SZ7/jGMeeGoYgczeNBRA8VUPGE8JAOt3udFHGQfFj76WdlhmM1yukcMWONTla49c5uK6
	DOUGfCrDlGt4FNiHZ1P28aBUFh4n4cKKD8auNILF3IKeAWOm3MRafquLBkfo/M2y2Klvsc
	wU21xQ/YDVyu3TvNjNUASaP/w67B2czopx6Que4NakoraUWxNSp8hzVwf8FosA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782314414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=spgZE5DVRE3AVvzfElFMQQANIXP+yeQwZcb1XoUbe5M=;
	b=IzAxwnbagHEsqEK6p/mcyrs2/vaHPgY3vYtHlbjB1OlmLygna0e8Dy+wXWLkzZJpI2gTU6
	72SNLIUTqoKfwEBw==
To: Mark Brown <broonie@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Carlos Song <carlos.song@nxp.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: javier.pastrana@linutronix.de,
	stable@vger.kernel.org
Subject: [PATCH v2] spi: imx: reconfigure for PIO when DMA cannot be started
Date: Wed, 24 Jun 2026 17:19:58 +0200
Message-ID: <20260624151958.18626-1-javier.pastrana@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268180-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:broonie@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:carlos.song@nxp.com,m:linux-spi@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:javier.pastrana@linutronix.de,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javier.pastrana@linutronix.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javier.pastrana@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDEEF6BF942

When spi_imx_can_dma() selects DMA, the ECSPI is configured for DMA:
spi_imx_setupxfer() sets CTRL.SMC and clears dynamic_burst, and
spi_imx_dma_transfer() programs the dynamic-burst BURST_LENGTH and the
SDMA watermarks.

If the DMA descriptor cannot be prepared (dmaengine_prep_slave_single()
returns NULL), the transfer is failed with SPI_TRANS_FAIL_NO_START and
falls back to PIO. The dynamic-burst DMA path uses its own bounce
buffers instead of the SPI core's mapping, so xfer->{tx,rx}_sg_mapped
are not set and the core's DMA->PIO retry is skipped; the driver falls
back to PIO internally. But none of the DMA-mode configuration is
undone, so the PIO transfer runs with CTRL.SMC set, the wrong burst
length and dynamic_burst cleared, and the transferred data is corrupted.

This is easily hit on i.MX8MP boards that describe ECSPI DMA in the
device tree but run SDMA on ROM firmware (no external sdma-imx7d.bin):
every ECSPI DMA prepare fails. An Infineon SLB9670 TPM on ECSPI1 then
returns shifted TPM2_GetCapability data, is flagged "field failure
mode", /dev/tpmrm0 is never created.

Set controller->fallback before re-running spi_imx_setupxfer() so the
ECSPI is reconfigured exactly like a normal PIO transfer. With
controller->fallback set, spi_imx_setupxfer() sees spi_imx_can_dma()
return false, so it clears spi_imx->usedma and reprograms the controller
(clears CTRL.SMC, restores dynamic_burst and the PIO burst length). No
explicit spi_imx->usedma =3D false is needed: setupxfer() already updates
it from the can_dma() result.

Fixes: faa8e404ad8e ("spi: imx: support dynamic burst length for ECSPI DMA =
mode")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
---
v2: drop redundant spi_imx->usedma =3D false; spi_imx_setupxfer() already
    clears it via spi_imx_can_dma() (Carlos Song)

 drivers/spi/spi-imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 480d1e8b281f..1837cc7b0b96 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -2152,7 +2152,8 @@ static int spi_imx_transfer_one(struct spi_controller=
 *controller,
 	if (spi_imx->usedma) {
 		ret =3D spi_imx_dma_transfer(spi_imx, transfer);
 		if (transfer->error & SPI_TRANS_FAIL_NO_START) {
-			spi_imx->usedma =3D false;
+			controller->fallback =3D true;
+			spi_imx_setupxfer(spi, transfer);
 			if (spi_imx->target_mode)
 				return spi_imx_pio_transfer_target(spi, transfer);
 			else
--=20
2.47.3



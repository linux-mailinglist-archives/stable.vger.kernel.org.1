Return-Path: <stable+bounces-215227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDxlJ/byiWl+EwAAu9opvQ
	(envelope-from <stable+bounces-215227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:45:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A613110D9D
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 556923016891
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B6037BE8F;
	Mon,  9 Feb 2026 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BbdxdV/W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F8F37BE93;
	Mon,  9 Feb 2026 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648099; cv=none; b=QEmKri4Vj7W0iGRqJJ5B2dKxVYqwVptav8E+9dTA5t152FJfZjmjduKRUq3x33IZgaLikpFWNkAHsr3mRA+wcvpszK4VFgs0tpEIPkS+MRs4XPmMvrJ76CPGhcm+bX83X73y9M07EytyReN+AcSknnWkaMLzLXmzQfeXc2T7Ou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648099; c=relaxed/simple;
	bh=qwmSXtAWSdmigiMpMDKg15o3SxDuHupE9tiLbqBwSPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gs/HbCu5ZQovDgj90esSrEiAsHC/kvbX/LwcXdEGLc9EV+c5G/FhCFJW2RFG9anzWw1eVeT5YqOb4qpAKC8VEpK47cWsgiU0+4FWnyn3pUV+quXlm16frF3eR6aVJXmwCibrG9d3DZgxTbAODmfLdSnuitL8ogoCYRZDOgQCCkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BbdxdV/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C735DC16AAE;
	Mon,  9 Feb 2026 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648099;
	bh=qwmSXtAWSdmigiMpMDKg15o3SxDuHupE9tiLbqBwSPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BbdxdV/WVr5I2HD0g5gsS837pP/kXCp7lVoDIgc+pvTTD69gccNGfcqkMW7EBvfTz
	 QDKPlz0325n5/0N6mCh26SCrrXmQIZDGyGgn25c8ydv0VeE2x01qEQEBQTnPeTousP
	 UsmNVPPi6yesSnfHsHZZXpWQ3fvx4ZowLYHgRxE8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 106/113] spi: tegra210-quad: Return IRQ_HANDLED when timeout already processed transfer
Date: Mon,  9 Feb 2026 15:24:15 +0100
Message-ID: <20260209142313.982827603@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215227-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,debian.org,gmail.com,nvidia.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A613110D9D
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit aabd8ea0aa253d40cf5f20a609fc3d6f61e38299 ]

When the ISR thread wakes up late and finds that the timeout handler
has already processed the transfer (curr_xfer is NULL), return
IRQ_HANDLED instead of IRQ_NONE.

Use a similar approach to tegra_qspi_handle_timeout() by reading
QSPI_TRANS_STATUS and checking the QSPI_RDY bit to determine if the
hardware actually completed the transfer. If QSPI_RDY is set, the
interrupt was legitimate and triggered by real hardware activity.
The fact that the timeout path handled it first doesn't make it
spurious. Returning IRQ_NONE incorrectly suggests the interrupt
wasn't for this device, which can cause issues with shared interrupt
lines and interrupt accounting.

Fixes: b4e002d8a7ce ("spi: tegra210-quad: Fix timeout handling")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://patch.msgid.link/20260126-tegra_xfer-v2-1-6d2115e4f387@debian.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra210-quad.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 39aa0f1485686..24f92af780188 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1444,15 +1444,30 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 {
 	struct tegra_qspi *tqspi = context_data;
+	u32 status;
+
+	/*
+	 * Read transfer status to check if interrupt was triggered by transfer
+	 * completion
+	 */
+	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
 
 	/*
 	 * Occasionally the IRQ thread takes a long time to wake up (usually
 	 * when the CPU that it's running on is excessively busy) and we have
 	 * already reached the timeout before and cleaned up the timed out
 	 * transfer. Avoid any processing in that case and bail out early.
+	 *
+	 * If no transfer is in progress, check if this was a real interrupt
+	 * that the timeout handler already processed, or a spurious one.
 	 */
-	if (!tqspi->curr_xfer)
-		return IRQ_NONE;
+	if (!tqspi->curr_xfer) {
+		/* Spurious interrupt - transfer not ready */
+		if (!(status & QSPI_RDY))
+			return IRQ_NONE;
+		/* Real interrupt, already handled by timeout path */
+		return IRQ_HANDLED;
+	}
 
 	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
 
-- 
2.51.0





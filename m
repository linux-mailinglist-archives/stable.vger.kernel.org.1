Return-Path: <stable+bounces-215109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N3fNp3wiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:35:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D931107A2
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75E403004CA5
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135AB2C2360;
	Mon,  9 Feb 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vDgZNneN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEA523D291;
	Mon,  9 Feb 2026 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647704; cv=none; b=tFUCPxq4cMK5YRYtmseTqQ7iE/ZZnm09gLggoy5cZqAg88LiGRMgKfq4Uul54JTgyQlCeNT7hscT1cDAwRoK7r5hTHaK69fweU2MVCSgpGlSIURP6DYYvhnlJ2Ah6YdnLUFMG6CnfzGc5vxiBMk/dPOnlRPf95SmdxN95bGcuxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647704; c=relaxed/simple;
	bh=q/rulri0cBWMGM74d+0cS51dhnskfpzsmI8Vky/vsY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aa4LqEAuuy2viNDbjTNp8jJZHAI7hq+deokhNA/4tKGyCiJbOTHTYo3eFl8bZ3nqnVoRSoteh1EDwFSgGYYfTav7jFIw0i/nxLJdhPIhQIcef4GV1o8AhyF2ElDxnkkFeiIrub9MyfToC4rSpzJDoLbvzZ6rTfW1XGCW55O4aJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vDgZNneN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F14C116C6;
	Mon,  9 Feb 2026 14:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647704;
	bh=q/rulri0cBWMGM74d+0cS51dhnskfpzsmI8Vky/vsY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDgZNneN2ef6UU2Na1ir/1jXRs0fUSVATJpEZrnU2809UAaeHDSFavinhV5kGGW1w
	 PN09d2mPG7kOWRc1vtBkUEJ6U+suH3nlg/CPqswJFeF95AU8vddQFLns0T8s7NscOz
	 qlS3ztA94g6ftB7O/9ZiLLJjH2CodtUIkcrmL500=
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
Subject: [PATCH 6.18 165/175] spi: tegra210-quad: Return IRQ_HANDLED when timeout already processed transfer
Date: Mon,  9 Feb 2026 15:23:58 +0100
Message-ID: <20260209142326.423174431@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215109-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11D931107A2
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index d9ca3d7b082f2..c6c05e6f48994 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1488,15 +1488,30 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
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





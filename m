Return-Path: <stable+bounces-234445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGK7LGSg1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:37:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDC73C1169
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F3730D95BD
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A795D3D6674;
	Wed,  8 Apr 2026 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c2p6xg0l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C888E3D8906;
	Wed,  8 Apr 2026 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672878; cv=none; b=iAvUC+qHO1kAzh/GH25DvQo8pq3PP9fGbAHqw+X0c8P9n4bHBH0ChsLW5LOzMxR1z3Ev7oM2E8+n62UpZZ9Wj1gwevjHXBcCjpjGYifjWy3iJpq9uhaL5QC1AgKPLpwKuLC8bVkZQAwEuEHh4XfLe5cWtcvjrkIECKqLEsMkCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672878; c=relaxed/simple;
	bh=0QIOsRLHHlLPT5UG5o/0/L9fMhK9brXHBJ6D26N7DI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjSkwFWuh+eV3NdLQY17m7YgIUZugnRgub7SHC2A/d6jbZYoLPuBotCK7v7moPkUD40DaCQ9pD3YSrPy3Yv1se7df+XETB9z8eq19tUsC4v7+lxcoR79tvpfv6ghPgiAnuknQ5LXfv95HeSpCn54KrOZuOuBrO8YociclYsvPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c2p6xg0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D441BC19421;
	Wed,  8 Apr 2026 18:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672878;
	bh=0QIOsRLHHlLPT5UG5o/0/L9fMhK9brXHBJ6D26N7DI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c2p6xg0laN245uwsTRY9VM5lEgrAhGzJSXvfVZGPJ8PtY8Yd1nQX2Z3dLfvPo6wOs
	 Pe1BMBnw10hza1tmenemnfMcHlfauDAUzlnA2/cR1Yo7HqPrMFR21uOG1INc5qz/wn
	 aw27l+zC1/kmel2TwEFNyv73qVyFX5kLAdsBm2CY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 016/277] spi: geni-qcom: Check DMA interrupts early in ISR
Date: Wed,  8 Apr 2026 20:00:01 +0200
Message-ID: <20260408175934.455808924@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234445-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FDC73C1169
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Praveen Talari <praveen.talari@oss.qualcomm.com>

[ Upstream commit 8c89a077ca796a2fe248c584e9d7e66cff0388c8 ]

The current interrupt handler only checks the GENI main IRQ status
(m_irq) before deciding to return IRQ_NONE. This can lead to spurious
IRQ_NONE returns when DMA interrupts are pending but m_irq is zero.

Move the DMA TX/RX status register reads to the beginning of the ISR,
right after reading m_irq. Update the early return condition to check
all three status registers (m_irq, dma_tx_status, dma_rx_status) before
returning IRQ_NONE.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20260313-spi-geni-qcom-fix-dma-irq-handling-v1-1-0bd122589e02@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index acfcf870efd84..736120107184f 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -958,10 +958,13 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	struct spi_controller *spi = data;
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	struct geni_se *se = &mas->se;
-	u32 m_irq;
+	u32 m_irq, dma_tx_status, dma_rx_status;
 
 	m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
-	if (!m_irq)
+	dma_tx_status = readl_relaxed(se->base + SE_DMA_TX_IRQ_STAT);
+	dma_rx_status = readl_relaxed(se->base + SE_DMA_RX_IRQ_STAT);
+
+	if (!m_irq && !dma_tx_status && !dma_rx_status)
 		return IRQ_NONE;
 
 	if (m_irq & (M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN |
@@ -1009,8 +1012,6 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		}
 	} else if (mas->cur_xfer_mode == GENI_SE_DMA) {
 		const struct spi_transfer *xfer = mas->cur_xfer;
-		u32 dma_tx_status = readl_relaxed(se->base + SE_DMA_TX_IRQ_STAT);
-		u32 dma_rx_status = readl_relaxed(se->base + SE_DMA_RX_IRQ_STAT);
 
 		if (dma_tx_status)
 			writel(dma_tx_status, se->base + SE_DMA_TX_IRQ_CLR);
-- 
2.53.0





Return-Path: <stable+bounces-10309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE79C827458
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCDC2875BF
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2F051037;
	Mon,  8 Jan 2024 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P/DAffsa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D5F52F86;
	Mon,  8 Jan 2024 15:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063CEC433C7;
	Mon,  8 Jan 2024 15:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728641;
	bh=Dc12QuQwVd1SLrcHUDSDXjQyMnto4uiczw36iBhTQWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/DAffsa3/HslcAE3WOomwsW1ChcwSMQQ03SmQntP6Phx0XBcUYcHtAlQfvzL6Xpe
	 /Qe3UNGXFOGKbF3uXukKBxOSxYjKd/FxJqHEeHuk3SrG/yiVAMLShvnsqoDTp4YoXa
	 qWdm/Aq2kFc5kyUW5h1hrVbFcOqCD5JcU4vqrJtM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenchao Chen <wenchao.chen@unisoc.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.1 141/150] mmc: sdhci-sprd: Fix eMMC init failure after hw reset
Date: Mon,  8 Jan 2024 16:36:32 +0100
Message-ID: <20240108153517.701288613@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenchao Chen <wenchao.chen@unisoc.com>

commit 8abf77c88929b6d20fa4f9928b18d6448d64e293 upstream.

Some eMMC devices that do not close the auto clk gate after hw reset will
cause eMMC initialization to fail. Let's fix this.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
Fixes: ff874dbc4f86 ("mmc: sdhci-sprd: Disable CLK_AUTO when the clock is less than 400K")
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231204064934.21236-1-wenchao.chen@unisoc.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-sprd.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -228,15 +228,19 @@ static inline void _sdhci_sprd_set_clock
 	div = ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
 	sdhci_enable_clk(host, div);
 
+	val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
+	mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN | SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
 	/* Enable CLK_AUTO when the clock is greater than 400K. */
 	if (clk > 400000) {
-		val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
-		mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN |
-			SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
 		if (mask != (val & mask)) {
 			val |= mask;
 			sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
 		}
+	} else {
+		if (val & mask) {
+			val &= ~mask;
+			sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
+		}
 	}
 }
 




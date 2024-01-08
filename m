Return-Path: <stable+bounces-10158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FC48272BC
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D959FB22750
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945316D6DC;
	Mon,  8 Jan 2024 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DdPXlj0e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB926D6E4;
	Mon,  8 Jan 2024 15:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC14AC433C7;
	Mon,  8 Jan 2024 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726942;
	bh=TaTGbs/tTZyP8AKA/4ZoV/iJ93ASN88qsTS0oL4mrRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DdPXlj0e5PHj/VZeJA3vGlJO0kvGS0HZkZO+ZMBnBiF4GtXwgEIkpbMZXtx1otghi
	 OR20tvwdekAs9Zq17DIi5SbUROcvjBwezRTTYSxX8XwB1G1yl0SqJ0d+7lkgS+izI1
	 LhwwjsQhhwfcIz1aEdY4EpB6vIDAZcxiyG4u+rwk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenchao Chen <wenchao.chen@unisoc.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6 120/124] mmc: sdhci-sprd: Fix eMMC init failure after hw reset
Date: Mon,  8 Jan 2024 16:09:06 +0100
Message-ID: <20240108150608.488359689@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -239,15 +239,19 @@ static inline void _sdhci_sprd_set_clock
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
 




Return-Path: <stable+bounces-37217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD5389C3E4
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6DC1C2223F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A91913AA23;
	Mon,  8 Apr 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0XacnP0B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD88E13A89D;
	Mon,  8 Apr 2024 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583591; cv=none; b=XaZkNQwpk47O/nOBa8VgPg3wTByfzIGJ3aJmKPO1flfD9S1gWY9mCIghBNEPRPLCG29rUB5UogBeGrPXcnWwsQ+S7S/GS1flwElI9IoxSfX549LDq1zzVRMRMemPlP8fxeyvFiCxicGd4dxkL2dPl/gTfmm3DBet0oJbdUE3jMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583591; c=relaxed/simple;
	bh=ZD2YBmbQDfdamRk4s89S4T2I1KtAQ/k2KqQZiVf8rIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6SnMo9CEZbuIxmcgFbj/uC8Nlb9Ft1ovh+v+O+Kx+j3iiuIr6nQh5Wye+zt3FhEO+Xhi0qtf9ziTXbALFewtgAO0Ouooox8eY5j5GKPjxfGutlL3QPBVngG92jdo6pYDt3+UcyAjwCyaNkzfzP6cfVeOIxdFTLo5N2aiLHB5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0XacnP0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673AEC433F1;
	Mon,  8 Apr 2024 13:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583590;
	bh=ZD2YBmbQDfdamRk4s89S4T2I1KtAQ/k2KqQZiVf8rIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0XacnP0BpZoV7OaM/3JLkYDmMSp/yumMtSJOsWv4X/ZKVCBdzBDbpn/5xovr3pe8d
	 4tmM2WkzxOMX+yQD7HNy2dXJ3nkwt6oDCGymBnOAuTIsNFTnsVY7FgYlyFctRbchX3
	 PwW/3u8BVMf2v6gBSewQGeuw7eHvb9/AZroD/YJw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 168/273] spi: s3c64xx: define a magic value
Date: Mon,  8 Apr 2024 14:57:23 +0200
Message-ID: <20240408125314.481098547@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tudor Ambarus <tudor.ambarus@linaro.org>

[ Upstream commit ff8faa8a5c0f4c2da797cd22a163ee3cc8823b13 ]

Define a magic value, it will be used in the next patch as well.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://msgid.link/r/20240216070555.2483977-3-tudor.ambarus@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: a3d3eab627bb ("spi: s3c64xx: Use DMA mode from fifo size")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 29e99410c9716..3da940e6299f0 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -76,6 +76,7 @@
 #define S3C64XX_SPI_INT_RX_FIFORDY_EN		(1<<1)
 #define S3C64XX_SPI_INT_TX_FIFORDY_EN		(1<<0)
 
+#define S3C64XX_SPI_ST_TX_FIFO_LVL_SHIFT	6
 #define S3C64XX_SPI_ST_RX_OVERRUN_ERR		(1<<5)
 #define S3C64XX_SPI_ST_RX_UNDERRUN_ERR		(1<<4)
 #define S3C64XX_SPI_ST_TX_OVERRUN_ERR		(1<<3)
@@ -106,7 +107,8 @@
 #define FIFO_LVL_MASK(i) ((i)->port_conf->fifo_lvl_mask[i->port_id])
 #define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & \
 				(1 << (i)->port_conf->tx_st_done)) ? 1 : 0)
-#define TX_FIFO_LVL(v, i) (((v) >> 6) & FIFO_LVL_MASK(i))
+#define TX_FIFO_LVL(v, i) (((v) >> S3C64XX_SPI_ST_TX_FIFO_LVL_SHIFT) &	\
+			   FIFO_LVL_MASK(i))
 #define RX_FIFO_LVL(v, i) (((v) >> (i)->port_conf->rx_lvl_offset) & \
 					FIFO_LVL_MASK(i))
 #define FIFO_DEPTH(i) ((FIFO_LVL_MASK(i) >> 1) + 1)
-- 
2.43.0





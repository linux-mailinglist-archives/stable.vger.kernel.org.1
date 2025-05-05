Return-Path: <stable+bounces-140430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4211DAAA89D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA53717BC9E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ACD351838;
	Mon,  5 May 2025 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uK91PWci"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC89351830;
	Mon,  5 May 2025 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484837; cv=none; b=XTIxE+0LL7aoHAccOAq1KlmGm+XUJPiFMxy16BaOWyiBrW4WhttIvR9nWVXxs3eO1LEtruSqM3Gh1PlaZW2h/aXLIOkg3C5N9HpacNi8Y20Dj7Dce1zI0Rx6NVU8xsON9Poq1tWE3cM9uErAXtheZxpQL/LuqDhEugWIH23pXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484837; c=relaxed/simple;
	bh=bvXbAwZuQg22ns0JxMDE41OePW9+9SN2J/jJtCw8lVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tH90eGJnDifim/J7FqUtgGvt39ZvlwZ8iELntiXHwTqDvSg7kaRMx9AlG3BJGttW7qAGMPcp95fDx+wEQrdPKhKmTB+3Pa6hS3PRYKKVL7Rvbmm4NvIaG5rSMt4ruSWRxbpToqZhsJStRyVZkucH/Eanc8MyAZ6Vl6kqM/NtvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uK91PWci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D41C4CEEF;
	Mon,  5 May 2025 22:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484837;
	bh=bvXbAwZuQg22ns0JxMDE41OePW9+9SN2J/jJtCw8lVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uK91PWci/810fdqb6BtneZ4X9u+2pcfR7RbRkbShgcJgjuKfkgaWwd4zMWbdD+TGL
	 fy+G6KKfvh5zskXrWs+duS1c+pGSVcGqZKM6cVG59tVBynEHlwQpv5DyXycUdsG065
	 tJP5UrpCvxBddtuIjyudAvsMwb6OzlKNF1O6r9wvf+UdHyUqbkduLAZHBaJyN6WGN7
	 pSJCgnAoZSvvOv+BN/PjeCu3P8cYdb6YCsOn2DbCUFruvHIVDg9uUTGrBJ4ZPu1ek3
	 mzI5MiNqpz/XZ3nLjSsH+HLROM5eq0d1WZzoGcQs8N5/BxBvp3aJk9y51dFPFH0IL3
	 gnkjuN6QUZHiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Wang <sean.wang@mediatek.com>,
	Pedro Tsai <pedro.tsai@mediatek.com>,
	Felix Freimann <felix.freimann@mediatek.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-bluetooth@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 039/486] Bluetooth: btmtksdio: Prevent enabling interrupts after IRQ handler removal
Date: Mon,  5 May 2025 18:31:55 -0400
Message-Id: <20250505223922.2682012-39-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit 6ac4233afb9a389a7629b7f812395d1d1eca5a83 ]

Ensure interrupts are not re-enabled when the IRQ handler has already been
removed. This prevents unexpected IRQ handler execution due to stale or
unhandled interrupts.

Modify btmtksdio_txrx_work to check if bdev->func->irq_handler exists
before calling sdio_writel to enable interrupts.

Co-developed-by: Pedro Tsai <pedro.tsai@mediatek.com>
Signed-off-by: Pedro Tsai <pedro.tsai@mediatek.com>
Co-developed-by: Felix Freimann <felix.freimann@mediatek.com>
Signed-off-by: Felix Freimann <felix.freimann@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btmtksdio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 11d33cd7b08fc..d4ea1ff07b3e7 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -610,7 +610,8 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 	} while (int_status || time_is_before_jiffies(txrx_timeout));
 
 	/* Enable interrupt */
-	sdio_writel(bdev->func, C_INT_EN_SET, MTK_REG_CHLPCR, NULL);
+	if (bdev->func->irq_handler)
+		sdio_writel(bdev->func, C_INT_EN_SET, MTK_REG_CHLPCR, NULL);
 
 	sdio_release_host(bdev->func);
 
-- 
2.39.5



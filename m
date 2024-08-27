Return-Path: <stable+bounces-70473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AF0960E4C
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789A61C22E42
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13DA1C57A3;
	Tue, 27 Aug 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OQBchLxt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768B51C57BD;
	Tue, 27 Aug 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770023; cv=none; b=OMzbumPhMHmU9q0B0ROE/PDV1dHJz+Nd9gdzgTMEfNo5nDqOmW0VN0aGYROdtiSB10EF8s6BXGDCpGHfy8wxVxW5tkCa6s4izQKJwkh+e29WOcLuy5utQFw9FFNF0Z3XOOD9jga6l8plWxeVJzOU+IvN9HmbWvOcchWoAA2Axh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770023; c=relaxed/simple;
	bh=mSGf9Pw80X4T6/EystohwKCTrjjK5xoDBAXc0kmpPss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQU/OclIKvIfmLEyzAzY4ekuQDRdK+hcHYS0ZhOpO3+XZf/0NAe+yT3h0+kFJyc9m3xFNVmQgn9mhfwRRaHrKcYED1uK4HbUcOhuJTRl/TB+C7XboH65jUOJfBhHCJy5qZ5rRuSV4fHPTY8EeoTDr8ScudCgelF4Z0pz2dPtZS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OQBchLxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6858EC6106D;
	Tue, 27 Aug 2024 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770023;
	bh=mSGf9Pw80X4T6/EystohwKCTrjjK5xoDBAXc0kmpPss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQBchLxtjKNJ20pUpeKYoy8U0ZtqYRYrJEu0L6suSdnrU5zW3fcIayWwmQ0boiva6
	 FGHFKd+p2DZ49JbkQqv7259vZbvFYckhBR4xo/C+se7ESXHTpK+FS8Nqevc7WjBSFJ
	 iLtqOz8M+w/FcnGuRiTwMUIAUSWVl2Xfy7gwSqi0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 104/341] i3c: mipi-i3c-hci: Do not unmap region not mapped for transfer
Date: Tue, 27 Aug 2024 16:35:35 +0200
Message-ID: <20240827143847.366279457@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit b8806e0c939f168237593af0056c309bf31022b0 ]

Fix following warning (with CONFIG_DMA_API_DEBUG) which happens with a
transfer without a data buffer.

	DMA-API: i3c mipi-i3c-hci.0: device driver tries to free DMA memory it has not allocated [device address=0x0000000000000000] [size=0 bytes]

For those transfers the hci_dma_queue_xfer() doesn't create a mapping and
the DMA address pointer xfer->data_dma is not set.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20230921055704.1087277-10-jarkko.nikula@linux.intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/mipi-i3c-hci/dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index a28ff177022ce..337c95d43f3f6 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -345,6 +345,8 @@ static void hci_dma_unmap_xfer(struct i3c_hci *hci,
 
 	for (i = 0; i < n; i++) {
 		xfer = xfer_list + i;
+		if (!xfer->data)
+			continue;
 		dma_unmap_single(&hci->master.dev,
 				 xfer->data_dma, xfer->data_len,
 				 xfer->rnw ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
-- 
2.43.0





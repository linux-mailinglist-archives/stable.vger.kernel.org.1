Return-Path: <stable+bounces-95608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 243399DA4DD
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 10:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2A6283ABB
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A5E193435;
	Wed, 27 Nov 2024 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="oPslwh63"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AD917DE2D;
	Wed, 27 Nov 2024 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700172; cv=none; b=LucuB8efZagC5Lo7C51iF7gwhkqVYpEYoVUuaIhrEdAftb6Xe2XqyCErtAs3Zt9H4ighvFBB2Sy1IMtK1Eqb5MER7vIxsmMvOHcBUJoWXcvkL1VLMTwXP0t2Wh3tI6Ojy6OsfwDPQtB0r7H8udDkmER5PWHcylRq3DSB4WReXKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700172; c=relaxed/simple;
	bh=1u4uIdQ2/rmajlvwyy7unnQa+t/pVj8ruCo/2BXNkEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oDT5xRVXvjhOIm7scKhUoO1ky4Ghw2WQnEhJo4DgOsxE4B5uO5OyMO7TiebG/tYX5Vv4SARRTXPFDQtxTOMlPL4QMRTe5PVfE5okcq42HGLDl9tiMgQlopI1my4deOQW+8tBWpCXeGQcPkf/VIEjh4FMkuKjit3ZiZ0B9LkjaIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=oPslwh63; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id F3A40518E779;
	Wed, 27 Nov 2024 09:35:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru F3A40518E779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1732700160;
	bh=Jb0Y1dF2tosHQGPB8IaDnTH85DqetT79SPymVo0PUi8=;
	h=From:To:Cc:Subject:Date:From;
	b=oPslwh63qVaA7aCPQfka1iCGuSGyXsC1IwVnOuBP4i5TpiiEaxdqDpuFeCsgASzMh
	 wjVP+6g3Comis+VZ/8sQmdV1vFtaFtlLy5mrRTQaP6eHXuawTUGOnmg0cyCRzTpXlB
	 VCaPaqGLLj854fBYFPem/bqgYdn4h6xvoX95e+Ak=
From: Vitalii Mordan <mordan@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>,
	stable@vger.kernel.org
Subject: [PATCH] usb: aspeed-vhub: fix call balance of vhub->clk handling routines
Date: Wed, 27 Nov 2024 12:35:47 +0300
Message-Id: <20241127093547.3000267-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the clock vhub->clk was not enabled in ast_vhub_probe,
vhub->clk will contain a non-NULL value leading to the clock being
incorrectly disabled later in ast_vhub_remove().

Use the devm_clk_get_enabled helper function to ensure proper call
balance for vhub->clk.

Found by Linux Verification Center (linuxtesting.org) with Klever.

Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
Cc: stable@vger.kernel.org
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 drivers/usb/gadget/udc/aspeed-vhub/core.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index f60a019bb173..7566594fc447 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -277,9 +277,6 @@ static void ast_vhub_remove(struct platform_device *pdev)
 	       VHUB_CTRL_PHY_RESET_DIS,
 	       vhub->regs + AST_VHUB_CTRL);
 
-	if (vhub->clk)
-		clk_disable_unprepare(vhub->clk);
-
 	spin_unlock_irqrestore(&vhub->lock, flags);
 
 	if (vhub->ep0_bufs)
@@ -337,14 +334,10 @@ static int ast_vhub_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, vhub);
 
-	vhub->clk = devm_clk_get(&pdev->dev, NULL);
+	vhub->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(vhub->clk)) {
 		rc = PTR_ERR(vhub->clk);
-		goto err;
-	}
-	rc = clk_prepare_enable(vhub->clk);
-	if (rc) {
-		dev_err(&pdev->dev, "Error couldn't enable clock (%d)\n", rc);
+		dev_err(&pdev->dev, "Error couldn't get and enable clock (%d)\n", rc);
 		goto err;
 	}
 
-- 
2.25.1



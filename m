Return-Path: <stable+bounces-90788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFE79BEB05
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DB81F25F30
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CA71E1C0B;
	Wed,  6 Nov 2024 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZgYZRu9Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D4202648;
	Wed,  6 Nov 2024 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896815; cv=none; b=GdpphIrwktG1JdYUtWkkx3X+QpwV4wmWiMzT//Va0CoS5AfTyjv0QqFbxV5rK/wVtkXmZea0yaGDLtwosietrBq5IQChD9JFdd73iWZaiVue/IYaaSE8LLiAJZrHf72TAYrolyJXK3OaYApnf6pphKnuvpUQqyoz4UYzcOUseBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896815; c=relaxed/simple;
	bh=crMCxQ2Y6rpRSBCPGfLq6Dlik+Ad2GMtZfOBMjVhNbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBxyzbZV65NT9HIdKF5QNuNgN139MPRAst3SDCmIJoY8jei7QSva4RmkyeQL3CH1SnVh8vVDlA/Jj73u6nJjvwPD8XWgEz/dCaED/L9VxtxYPa2nIo9tSfXmMCi9/Kl79zHvC/HHiKt4LG8KCUt9XpI5W5cJqvlZaf0ojEO1byQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZgYZRu9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AFBC4CED8;
	Wed,  6 Nov 2024 12:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896815;
	bh=crMCxQ2Y6rpRSBCPGfLq6Dlik+Ad2GMtZfOBMjVhNbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZgYZRu9ZyDndZkAXQ5dvaMGIzEg5wEg1Qj6mn8HA9tsW+ginDrJl7emXQXLTdG0Kl
	 I2CBRkT53fYqFrVq69IrPR/rxAFSME6YylO2TLyTYA9cxU9tfF4RP+evuKySHzHRG9
	 QbgKFKdpKoC5xVmAZWDVGO4t2KPetmX9OJpsgrK4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Palmer <daniel@0x0f.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 082/110] net: amd: mvme147: Fix probe banner message
Date: Wed,  6 Nov 2024 13:04:48 +0100
Message-ID: <20241106120305.452167963@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120303.135636370@linuxfoundation.org>
References: <20241106120303.135636370@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Palmer <daniel@0x0f.com>

[ Upstream commit 82c5b53140faf89c31ea2b3a0985a2f291694169 ]

Currently this driver prints this line with what looks like
a rogue format specifier when the device is probed:
[    2.840000] eth%d: MVME147 at 0xfffe1800, irq 12, Hardware Address xx:xx:xx:xx:xx:xx

Change the printk() for netdev_info() and move it after the
registration has completed so it prints out the name of the
interface properly.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/mvme147.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/mvme147.c b/drivers/net/ethernet/amd/mvme147.c
index 3f2e4cdd0b83e..133fe0f1166b0 100644
--- a/drivers/net/ethernet/amd/mvme147.c
+++ b/drivers/net/ethernet/amd/mvme147.c
@@ -106,10 +106,6 @@ struct net_device * __init mvme147lance_probe(int unit)
 	address = address >> 8;
 	dev->dev_addr[3] = address&0xff;
 
-	printk("%s: MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
-	       dev->name, dev->base_addr, MVME147_LANCE_IRQ,
-	       dev->dev_addr);
-
 	lp = netdev_priv(dev);
 	lp->ram = __get_dma_pages(GFP_ATOMIC, 3);	/* 32K */
 	if (!lp->ram) {
@@ -139,6 +135,9 @@ struct net_device * __init mvme147lance_probe(int unit)
 		return ERR_PTR(err);
 	}
 
+	netdev_info(dev, "MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
+		    dev->base_addr, MVME147_LANCE_IRQ, dev->dev_addr);
+
 	return dev;
 }
 
-- 
2.43.0





Return-Path: <stable+bounces-1636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949B47F80A6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECFB282239
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FB333CD1;
	Fri, 24 Nov 2023 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SFZWWOtV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5174A2E64F;
	Fri, 24 Nov 2023 18:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A66C433C8;
	Fri, 24 Nov 2023 18:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851896;
	bh=VIktLqAZF96gJuvy+bEc2YTWs7qRlJ3HnKDhAg+VR20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFZWWOtV0CDhUb8C1Jr+hVq9OoFgoGASikXEAyOWG74m/079SjJ4XrjtnQfKpzhAi
	 XsGX2016B7PCtwwKjEPgz+C0oG0m2eKq3slkj8quhsNSud2vtrYnOuLeEFNe9PQaY3
	 Ln8w+yKfG4gfep0bETvYsMsCzF4unS1jhIhxXKQc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yi Yang <yiyang13@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 114/372] mtd: rawnand: tegra: add missing check for platform_get_irq()
Date: Fri, 24 Nov 2023 17:48:21 +0000
Message-ID: <20231124172014.289489363@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

From: Yi Yang <yiyang13@huawei.com>

[ Upstream commit 0a1166c27d4e53186e6bf9147ea6db9cd1d65847 ]

Add the missing check for platform_get_irq() and return error code
if it fails.

Fixes: d7d9f8ec77fe ("mtd: rawnand: add NVIDIA Tegra NAND Flash controller driver")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230821084046.217025-1-yiyang13@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/tegra_nand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index a9b9031ce6167..d33030b68ac44 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -1197,6 +1197,10 @@ static int tegra_nand_probe(struct platform_device *pdev)
 	init_completion(&ctrl->dma_complete);
 
 	ctrl->irq = platform_get_irq(pdev, 0);
+	if (ctrl->irq < 0) {
+		err = ctrl->irq;
+		goto err_put_pm;
+	}
 	err = devm_request_irq(&pdev->dev, ctrl->irq, tegra_nand_irq, 0,
 			       dev_name(&pdev->dev), ctrl);
 	if (err) {
-- 
2.42.0





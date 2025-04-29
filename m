Return-Path: <stable+bounces-138186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAEAAA1742
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2F33A57B0
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394DF2528EC;
	Tue, 29 Apr 2025 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mO2sBazp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E75253327;
	Tue, 29 Apr 2025 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948445; cv=none; b=N4NZQjg8igpRIPPnpLCSAA8lSjajjrkEtRionq2fpsS7wb7nq+2H86ODdya9tCWIO27pBoT03ZijmVpJgiS7KVgSGbbMa340Qa8BQM7I1XcGsS8dlrWhPpPCg+RN6FkdehAJFRSnXFKssh2+pAsLqWjfzXQCCUefk1qs6FUgLaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948445; c=relaxed/simple;
	bh=LK3ndlAQ+ZFKCnfDbWGNDz2j/AOJTOg+CG7ImEMFtr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGZVWSooocghyv2qjzmJ7Dh4V7uV7fGARUB6BfIEe59LTAt9n9ldmzPCn6/0B6aeoB88sxW1qtgNcwhSuLzP8lajN0d7UHQUlhe0lAPlFV/ou2pFfE+cu53IDJxGWJ8eBZXFvbG8y+qAJM+yGu0oSgdLx1Rp0WE+27Ddrw4K6XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mO2sBazp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A1DC4CEE9;
	Tue, 29 Apr 2025 17:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948444;
	bh=LK3ndlAQ+ZFKCnfDbWGNDz2j/AOJTOg+CG7ImEMFtr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mO2sBazp/ZUS4qlK6L9nVFwCtACZKcrYPo+hD0f47HTRb4li8Wzi1kEy98muyr6Hr
	 thy2x2w7vc9DbMMgoBOtnFKsy6z7xz1jf0x8TRWzGEW6qFHThNwPHQYxSsNj7Lp5yN
	 hKFi61VceY83KF0Wt98jYKfgQPk/1tOefPz6lu0Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Henry Martin <bsdhenrymartin@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 001/373] ata: pata_pxa: Fix potential NULL pointer dereference in pxa_ata_probe()
Date: Tue, 29 Apr 2025 18:37:58 +0200
Message-ID: <20250429161123.187704166@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Henry Martin <bsdhenrymartin@gmail.com>

[ Upstream commit ad320e408a8c95a282ab9c05cdf0c9b95e317985 ]

devm_ioremap() returns NULL on error. Currently, pxa_ata_probe() does
not check for this case, which can result in a NULL pointer dereference.

Add NULL check after devm_ioremap() to prevent this issue.

Fixes: 2dc6c6f15da9 ("[ARM] pata_pxa: DMA-capable PATA driver")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/pata_pxa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 41430f79663c1..3502bfb03c56c 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -223,10 +223,16 @@ static int pxa_ata_probe(struct platform_device *pdev)
 
 	ap->ioaddr.cmd_addr	= devm_ioremap(&pdev->dev, cmd_res->start,
 						resource_size(cmd_res));
+	if (!ap->ioaddr.cmd_addr)
+		return -ENOMEM;
 	ap->ioaddr.ctl_addr	= devm_ioremap(&pdev->dev, ctl_res->start,
 						resource_size(ctl_res));
+	if (!ap->ioaddr.ctl_addr)
+		return -ENOMEM;
 	ap->ioaddr.bmdma_addr	= devm_ioremap(&pdev->dev, dma_res->start,
 						resource_size(dma_res));
+	if (!ap->ioaddr.bmdma_addr)
+		return -ENOMEM;
 
 	/*
 	 * Adjust register offsets
-- 
2.39.5





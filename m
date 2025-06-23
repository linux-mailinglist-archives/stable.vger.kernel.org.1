Return-Path: <stable+bounces-156061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5404AE44DE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DF4172953
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29342522A8;
	Mon, 23 Jun 2025 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bi5D2mUr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39E347DD;
	Mon, 23 Jun 2025 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686040; cv=none; b=lFBCzwVJZZDk5okvyVnDmVczZAztYGBywKg1fgVwBAfV+uIlGq6DhObRvCxyxleYAM69tg5doB4nw3n36SxA9SvbBJTL+ZK+NzmN2SU4jlLKe1HbYVFRnLof7sh0dZcqboqARpOSfUL5gho17p2xaidjvPddGvD1vZslDqYGNPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686040; c=relaxed/simple;
	bh=2IeKjg8l+4NPVIkkIVvAgkMbYjeVqn/9Y6fdnpoTy0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lux6DT6geMCpttemo6/b4qS0ZueeqS1crspgtzEKWDsw8Qwi/WF0h41+Bz4SKk1otykq72O1DTfAqtLpX4wtQSghz+/XseTj8nk5CT3tD82iu8D5cTzf35lAUplkhnOI6zUy9qidBrfMkA7w0xZQMcyIGuU+SpY7wrpJXYOd+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bi5D2mUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E5FC4CEEA;
	Mon, 23 Jun 2025 13:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750686040;
	bh=2IeKjg8l+4NPVIkkIVvAgkMbYjeVqn/9Y6fdnpoTy0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bi5D2mUr4kI3WBlVhM9iXfHYRQCNjWT83efSoKRnA7UbEkJzmsSONX/z86BYJevCC
	 GHF2T8XxYixf5jvzG5C17Xgad2s8bpR6vcFWRXcDkp5tgzhCEl4tcrHDzMOr+YbJJA
	 dD4NI7jABM5gCFFdLO2Ojxn09CoPZvHlgGlsGnbk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Henry Martin <bsdhenrymartin@gmail.com>,
	Nathan Lynch <nathan.lynch@amd.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 087/355] dmaengine: ti: Add NULL check in udma_probe()
Date: Mon, 23 Jun 2025 15:04:48 +0200
Message-ID: <20250623130629.420543363@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Henry Martin <bsdhenrymartin@gmail.com>

[ Upstream commit fd447415e74bccd7362f760d4ea727f8e1ebfe91 ]

devm_kasprintf() returns NULL when memory allocation fails. Currently,
udma_probe() does not check for this case, which results in a NULL
pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Reviewed-by: Nathan Lynch <nathan.lynch@amd.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Link: https://lore.kernel.org/r/20250402023900.43440-1-bsdhenrymartin@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ti/k3-udma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 1f01bd483c6ba..cade321095d20 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3672,7 +3672,8 @@ static int udma_probe(struct platform_device *pdev)
 		uc->config.dir = DMA_MEM_TO_MEM;
 		uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
 					  dev_name(dev), i);
-
+		if (!uc->name)
+			return -ENOMEM;
 		vchan_init(&uc->vc, &ud->ddev);
 		/* Use custom vchan completion handling */
 		tasklet_setup(&uc->vc.task, udma_vchan_complete);
-- 
2.39.5





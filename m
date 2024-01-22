Return-Path: <stable+bounces-12367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8B88363E6
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 14:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9658B289099
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 13:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABAF3C07B;
	Mon, 22 Jan 2024 13:02:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5F03D39B
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928567; cv=none; b=Fcwb26wohl+0YV5lLsw7C8pVQH0TS5dVWTdqrB+fJXd+MvL4LExyVeb65CNwSr+vBirK3pMMTDb9NchR5oQKwQzT3wEDvGTmWlEQZjyDMk9VXdY1VM2QSTXSxXIs8CnPpUqSi+xFJaQLEk/OJNVCge0TWs0TJbvUslF9+fPd5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928567; c=relaxed/simple;
	bh=Y57zoRHqZte8vsPPbWrJnLrPGmjRhS1RG2j14uP8wGA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oc+FD3goC6Gkqi7s2ecmut12inqEKR4MY7calZaJPB3ok7Y/A7e47fLm0ooeZGlDBB4fqIxVm1davuRZzEU1eg8zKb38hi7IrMOAChwkvCb/zNC9w9KvGdYHk41mlplLD2AFw3Y20/3/l+l2sge5TxeCHd6+FJwj+MFXN7gJJ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [119.122.215.52])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id E90558000BC;
	Mon, 22 Jan 2024 21:02:22 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 5.10.y 1/1] net: ethernet: mtk_eth_soc: remove duplicate if statements
Date: Mon, 22 Jan 2024 21:02:19 +0800
Message-Id: <20240122130219.220316-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDH0lPVk1PThpNTx0eQkIeSVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKQlVKSUlVSUpOVU5JWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++
X-HM-Tid: 0a8d3143cb63b03akuuue90558000bc
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kww6SAw*MTwZUQ5RHDU1TQk1
	Ay4wCT5VSlVKTEtOQklDTk9ITENDVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVU5JWVdZCAFZQUpNT0k3Bg++

It seems that there was something wrong with backport,
causing `if (err)` to appear twice in the same place.

Fixes: da86a63479e ("net: ethernet: mtk_eth_soc: fix error handling in mtk_open()")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index aa9e616cc1d5..011210e6842d 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2302,7 +2302,6 @@ static int mtk_open(struct net_device *dev)
 	if (!refcount_read(&eth->dma_refcnt)) {
 		int err = mtk_start_dma(eth);
 
-		if (err)
 		if (err) {
 			phylink_disconnect_phy(mac->phylink);
 			return err;
-- 
2.25.1



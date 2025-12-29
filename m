Return-Path: <stable+bounces-203557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B31BCE6E11
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EBB430081A8
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F9A3164B7;
	Mon, 29 Dec 2025 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ifBOWKPo"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA37308F3A;
	Mon, 29 Dec 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767014738; cv=none; b=NzjWS9A/IEaaJe5wT1f6c3PP4nJje1DGb7AS3JzffCulzmU8izzhX1gXfLE+/D6dMw9Zk/eNfTTMWE5psC/cP4CnNCkmoNuHqClbnmUU0e6X9Qu5bF13CidPIWtC9NfywI1YkLnwstudUh0PAD1m5KDCgwb/tiNabwIfFziURkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767014738; c=relaxed/simple;
	bh=rovJJRr6Rqy/J8Fg7F75D7C3o93sa/mJnnmwo+LrAOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PyKI52dwxFkUcG7KRagCchIlGRbGi0BdHoWaQHr3P0zlOFgZwPn+38hD9EkUn97ogEHS/malpM/WNH7EpNBOHc5L7FPAc9vY6ac6QY5FIZgrXxR0S9Vwx6PJgalnhZQOeKJG+4VocmuGaKElDX353bVE9dqrO+xeYhqxp6SX3nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ifBOWKPo; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ee89fb04;
	Mon, 29 Dec 2025 21:25:29 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: matthias.bgg@gmail.com
Cc: angelogioacchino.delregno@collabora.com,
	roger.lu@mediatek.com,
	khilman@baylibre.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zilin Guan <zilin@seu.edu.cn>,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v3] soc: mediatek: svs: Fix memory leak in svs_enable_debug_write()
Date: Mon, 29 Dec 2025 13:25:26 +0000
Message-Id: <20251229132526.394235-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b6a4906f403a1kunm8cb5e653122881
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSR8dVh1JQ0NMTElDGUxOS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=ifBOWKPoF0mrhMpkCAiPvhD7cHmFG1D6shyEtW+2hPVjfpca/q7xr7+y3jiSWlApgUCz6bVgd4rA+Se5405mW+6xrVUkp4ITwBVYrOzUoFB45Ul45UOWSwGYOIBf1BclHgW8tv27fsjSKZNg2z/UY+gOnlYKM3TuROSe8bnpsJk=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=jAEBrcKEP2Dkgcler2NsQJFg8gU3aJUCTBDJKE8d+Pc=;
	h=date:mime-version:subject:message-id:from;

In svs_enable_debug_write(), the buf allocated by memdup_user_nul()
is leaked if kstrtoint() fails.

Fix this by using __free(kfree) to automatically free buf, eliminating
the need for explicit kfree() calls and preventing leaks.

Fixes: 13f1bbcfb582 ("soc: mediatek: SVS: add debug commands")
Cc: stable@vger.kernel.org
Co-developed-by: Jianhao Xu <jianhao.xu@seu.edu.cn>
Signed-off-by: Jianhao Xu <jianhao.xu@seu.edu.cn>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
Changes in v3:
- Reduce the scope of the involved local variable.
- Add Cc to stable.

Changes in v2:
- Use __free(kfree) to simplify memory management.

 drivers/soc/mediatek/mtk-svs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index f45537546553..475926a606fd 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -789,12 +789,11 @@ static ssize_t svs_enable_debug_write(struct file *filp,
 	struct svs_bank *svsb = file_inode(filp)->i_private;
 	struct svs_platform *svsp = dev_get_drvdata(svsb->dev);
 	int enabled, ret;
-	char *buf = NULL;
 
 	if (count >= PAGE_SIZE)
 		return -EINVAL;
 
-	buf = (char *)memdup_user_nul(buffer, count);
+	char *buf __free(kfree) = (char *)memdup_user_nul(buffer, count);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -807,8 +806,6 @@ static ssize_t svs_enable_debug_write(struct file *filp,
 		svsb->mode_support = SVSB_MODE_ALL_DISABLE;
 	}
 
-	kfree(buf);
-
 	return count;
 }
 
-- 
2.34.1



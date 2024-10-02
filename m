Return-Path: <stable+bounces-79746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5361898DA01
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855E81C23405
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2EE1D042F;
	Wed,  2 Oct 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dk1eeMed"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED41D12E8;
	Wed,  2 Oct 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878349; cv=none; b=KtQYmjBPTojQKg+aqsRvy4zyJAT6oWMd2eXWg5hAIbITyirDU28vrKOcoHjCGJr8CCXz3Ly2cpaQFhMATjPwQQ9aUuJI9ysgUMnNJ0C75qNzG1xLih7ciWRyHiT+ozpD3qnzR4o+mkCE/99vrBaacKU+VASrw93Wx05A7CojtRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878349; c=relaxed/simple;
	bh=XCmg7CNMBFuRF8qymsLDyI5tLp04LJSexfMkt7E3c14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbAoFUmLtJC0e6cRxsRxsT5xZ1NNNGVyecJYm7eQdUayDmBLXeNcPjUIs7Phx6WwE6s7ZbyyYyz03ulTIursRNiOq+WsZDZPGXqXRd3VFDGiLvzXa0piTjHMISnbjS6uSXtViOrTNMXBKmYBO6ijN6xqc6Mx9/hZ+njNc0mrRDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dk1eeMed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B2AC4CECD;
	Wed,  2 Oct 2024 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878349;
	bh=XCmg7CNMBFuRF8qymsLDyI5tLp04LJSexfMkt7E3c14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dk1eeMedSWK3PR1VDugrSkNY8OLxXBqZ6l9YspIo5bBxVNHLEvhVlIJMXtr+kGqP9
	 opyPPDO9piaChk3WYRuad3H8ZjuKqkL0P0UK0qAY1RdePVrP94jYpHe3goyRE+xrm8
	 8JodTepqQPx29OvMWj8NMrcOo1FkO8dLTOZ4jNPs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 384/634] RDMA/hns: Fix ah error counter in sw stat not increasing
Date: Wed,  2 Oct 2024 14:58:04 +0200
Message-ID: <20241002125826.259646183@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junxian Huang <huangjunxian6@hisilicon.com>

[ Upstream commit 39c047d4047a1242aeefa87513174b56a91080ab ]

There are several error cases where hns_roce_create_ah() returns
directly without jumping to sw stat path, thus leading to a problem
that the ah error counter does not increase.

Fixes: ee20cc17e9d8 ("RDMA/hns: Support DSCP")
Fixes: eb7854d63db5 ("RDMA/hns: Support SW stats with debugfs")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://patch.msgid.link/20240912115700.2016443-1-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 3e02c474f59fe..4fc5b9d5fea87 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -64,8 +64,10 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	u8 tc_mode = 0;
 	int ret;
 
-	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08 && udata)
-		return -EOPNOTSUPP;
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08 && udata) {
+		ret = -EOPNOTSUPP;
+		goto err_out;
+	}
 
 	ah->av.port = rdma_ah_get_port_num(ah_attr);
 	ah->av.gid_index = grh->sgid_index;
@@ -83,7 +85,7 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		ret = 0;
 
 	if (ret && grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
-		return ret;
+		goto err_out;
 
 	if (tc_mode == HNAE3_TC_MAP_MODE_DSCP &&
 	    grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
@@ -91,8 +93,10 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	else
 		ah->av.sl = rdma_ah_get_sl(ah_attr);
 
-	if (!check_sl_valid(hr_dev, ah->av.sl))
-		return -EINVAL;
+	if (!check_sl_valid(hr_dev, ah->av.sl)) {
+		ret = -EINVAL;
+		goto err_out;
+	}
 
 	memcpy(ah->av.dgid, grh->dgid.raw, HNS_ROCE_GID_SIZE);
 	memcpy(ah->av.mac, ah_attr->roce.dmac, ETH_ALEN);
-- 
2.43.0





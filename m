Return-Path: <stable+bounces-128999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1389A7FD97
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F0719E0220
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E9726A0EE;
	Tue,  8 Apr 2025 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hvl/YRN/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB5E267B77;
	Tue,  8 Apr 2025 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109845; cv=none; b=epvfIIJI9D5I311wcrR9UVkB9xMRdUU4wVMpZLR+xZ6O6cn0lEFB8VHrLtK7TfYlL9kLtFYLFgUkx6uEhs/bKiD88QJdm/5Admo0zw0FmOCsFymQ4+Cm/b6baS3RGxGF08W/lpfQbjW+z/NF1q1D/CEY9oRMrKLz0n79MHXXlS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109845; c=relaxed/simple;
	bh=g9spkogedmOzCghAQIpCeQE94pRk6E9MfxMHeDDSuno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/CQUaRauzPe2RJL7Ij7bJG1fT5KmwFSwhM87NPgp/MkERsFgsAxNcQT8RY+R6V1LUhrmU00L9EqZNboWm9Ajs73VyJNKY66m1/JXSZByR9CTZzj/IG7CY2GPJIWfjoUToGmjsAQzldTcFPMdMJMMTEksRXUix0BVeVKqLMaqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hvl/YRN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FD1C4CEE5;
	Tue,  8 Apr 2025 10:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744109845;
	bh=g9spkogedmOzCghAQIpCeQE94pRk6E9MfxMHeDDSuno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hvl/YRN/xzRuahSy+8Mj/C6W3ppi3zMiyI+iSPkoV+5tJ3AW8sueuYe+Bg4Ha5s+l
	 DWA1gHcsx9LIeZh8I8DMpo/id52n4pzek+rgZgJBlFO8Weq7XR6rBl+kgPTY0mM1aC
	 rg/cFO4/4xyLrXLeeLSVDfLEcIh43CpZV4nx0WKk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengchang Tang <tangchengchang@huawei.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Haoyue Xu <xuhaoyue1@hisilicon.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 073/227] RDMA/hns: Remove redundant phy_addr in hns_roce_hem_list_find_mtt()
Date: Tue,  8 Apr 2025 12:47:31 +0200
Message-ID: <20250408104822.585219907@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
References: <20250408104820.353768086@linuxfoundation.org>
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

From: Chengchang Tang <tangchengchang@huawei.com>

[ Upstream commit 5f652387c5423a82453c5cb446a88834bf41a94b ]

This parameter has never been used. Remove it to simplify the function.

Link: https://lore.kernel.org/r/20220922123315.3732205-8-xuhaoyue1@hisilicon.com
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Stable-dep-of: 25655580136d ("RDMA/hns: Fix soft lockup during bt pages loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 7 +------
 drivers/infiniband/hw/hns/hns_roce_hem.h | 2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c  | 4 ++--
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 61ec96b3a89d5..d4169dc584ed7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1462,19 +1462,17 @@ void hns_roce_hem_list_init(struct hns_roce_hem_list *hem_list)
 
 void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
 				 struct hns_roce_hem_list *hem_list,
-				 int offset, int *mtt_cnt, u64 *phy_addr)
+				 int offset, int *mtt_cnt)
 {
 	struct list_head *head = &hem_list->btm_bt;
 	struct hns_roce_hem_item *hem, *temp_hem;
 	void *cpu_base = NULL;
-	u64 phy_base = 0;
 	int nr = 0;
 
 	list_for_each_entry_safe(hem, temp_hem, head, sibling) {
 		if (hem_list_page_is_in_range(hem, offset)) {
 			nr = offset - hem->start;
 			cpu_base = hem->addr + nr * BA_BYTE_LEN;
-			phy_base = hem->dma_addr + nr * BA_BYTE_LEN;
 			nr = hem->end + 1 - offset;
 			break;
 		}
@@ -1483,8 +1481,5 @@ void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
 	if (mtt_cnt)
 		*mtt_cnt = nr;
 
-	if (phy_addr)
-		*phy_addr = phy_base;
-
 	return cpu_base;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index 5b2162a2b8cef..ecf5159aba9fa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -131,7 +131,7 @@ void hns_roce_hem_list_release(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_hem_list *hem_list);
 void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
 				 struct hns_roce_hem_list *hem_list,
-				 int offset, int *mtt_cnt, u64 *phy_addr);
+				 int offset, int *mtt_cnt);
 
 static inline void hns_roce_hem_first(struct hns_roce_hem *hem,
 				      struct hns_roce_hem_iter *iter)
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index b062301258683..66098d25cb49e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -649,7 +649,7 @@ static int mtr_map_region(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	while (offset < end && npage < max_count) {
 		count = 0;
 		mtts = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
-						  offset, &count, NULL);
+						  offset, &count);
 		if (!mtts)
 			return -ENOBUFS;
 
@@ -923,7 +923,7 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		mtt_count = 0;
 		mtts = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
 						  start_index + total,
-						  &mtt_count, NULL);
+						  &mtt_count);
 		if (!mtts || !mtt_count)
 			goto done;
 
-- 
2.39.5





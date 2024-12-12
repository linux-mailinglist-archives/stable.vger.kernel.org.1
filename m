Return-Path: <stable+bounces-102762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D7A9EF47E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A29170EF2
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798BE22655F;
	Thu, 12 Dec 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0SzJHdMN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526A222D57;
	Thu, 12 Dec 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022398; cv=none; b=Uh0eQ3AgsHzF289YmGKJinY9koGr8FtmX3/Iu8InD5s+ykc2gqlzMGmlXvmXosIKowrO4YNqFeQVsJ1TajnOI9iQmWOuBJ417K8j7CM3snMre2bxBGte71gzGyViF9KOx4umR7khZn2yrzwhnQa81f2GtVsgFyHtO9rfXam+fZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022398; c=relaxed/simple;
	bh=pQMe52D0Wg/0GWTxakisyEbgxvX12A4YcYq6rdic3fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZyJbHaO8b5dGTy7+znJyl7F1uLRoeMUm4jEF7tD4OL9HrbWLCSt1aBVkW4mD1imD91Nfk9cmfzwwJJZ5eY4KWPj2YJvWXpCzAGQlp+erfQr+CsHpM03mVJEpL0wMah666J13HTETgQWe4/vqEgHPF+o+GFKVgttP/0BCoFAIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0SzJHdMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE49C4CED3;
	Thu, 12 Dec 2024 16:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022398;
	bh=pQMe52D0Wg/0GWTxakisyEbgxvX12A4YcYq6rdic3fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0SzJHdMN9wdyXpH9wiuz2rKwP7wozIWafPD1C7IVkCDlabLb9lwb7sZkpIq9r+yNc
	 0zbb9ip52o9GsB3IHf23xUmPTmpq1+PyjIthrgf58tMaoAkCNCWH2leUgwLzef02h6
	 bIjbd2lnkVSJbisF/gTB1Yh62jmCAEKwrja9lL4A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 231/565] RDMA/hns: Fix NULL pointer derefernce in hns_roce_map_mr_sg()
Date: Thu, 12 Dec 2024 15:57:06 +0100
Message-ID: <20241212144320.617344055@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junxian Huang <huangjunxian6@hisilicon.com>

[ Upstream commit 6b526d17eed850352d880b93b9bf20b93006bd92 ]

ib_map_mr_sg() allows ULPs to specify NULL as the sg_offset argument.
The driver needs to check whether it is a NULL pointer before
dereferencing it.

Fixes: d387d4b54eb8 ("RDMA/hns: Fix missing pagesize and alignment check in FRMR")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://patch.msgid.link/20241108075743.2652258-3-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 938db3f5aabe6..79a59d5180ccc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -438,15 +438,16 @@ static int hns_roce_set_page(struct ib_mr *ibmr, u64 addr)
 }
 
 int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
-		       unsigned int *sg_offset)
+		       unsigned int *sg_offset_p)
 {
+	unsigned int sg_offset = sg_offset_p ? *sg_offset_p : 0;
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibmr->device);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
 	struct hns_roce_mtr *mtr = &mr->pbl_mtr;
 	int ret, sg_num = 0;
 
-	if (!IS_ALIGNED(*sg_offset, HNS_ROCE_FRMR_ALIGN_SIZE) ||
+	if (!IS_ALIGNED(sg_offset, HNS_ROCE_FRMR_ALIGN_SIZE) ||
 	    ibmr->page_size < HNS_HW_PAGE_SIZE ||
 	    ibmr->page_size > HNS_HW_MAX_PAGE_SIZE)
 		return sg_num;
@@ -457,7 +458,7 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	if (!mr->page_list)
 		return sg_num;
 
-	sg_num = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
+	sg_num = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset_p, hns_roce_set_page);
 	if (sg_num < 1) {
 		ibdev_err(ibdev, "failed to store sg pages %u %u, cnt = %d.\n",
 			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, sg_num);
-- 
2.43.0





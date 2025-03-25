Return-Path: <stable+bounces-126372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF37A700F6
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227243B2086
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35645269B18;
	Tue, 25 Mar 2025 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KhdgGNhT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B52571AC;
	Tue, 25 Mar 2025 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906102; cv=none; b=GYHVXtt/q0tQ+fIuMAFUg7kFKeJPN9ddhF985FJMSnsBy+JmmtzUN8mGXXwEkVLnUaODuanIMBr2tul1hmOdRTkGAdLTNpppP8xLTUIhAsCzONXz05qcG2Q085pQBoUGmV/eAHPFZLB8CheEylImkSKggcUjBuZ2omBtrHmq3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906102; c=relaxed/simple;
	bh=FhVwOX8TSfFTAZEU+tXTZWxIFULehn1hjx+FVLrBfpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBSIiGoGOBpsK+/QmdyAGDCHxABpBhlBHVIsQo7rxDZ1hk3IyWRtNiXh3KQOIDhYfZUrn87S3L0NlPkC9E+iTLg/czReqYY36tSvh8NkxC4g57nVed3ZhXwO1ZWu9YdfMniemqc/72bKfw6Z1+zOejzxgqVcgwHDWn1WOrJOdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KhdgGNhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B55C4CEE9;
	Tue, 25 Mar 2025 12:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906101;
	bh=FhVwOX8TSfFTAZEU+tXTZWxIFULehn1hjx+FVLrBfpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KhdgGNhTQ9D+lhD235i9i1/sn3lJnwdFTBpja6Mixwm7SesxqbTr2+0z1vLU6kQzw
	 BkJvXMbX7hpKo1r7Gg4LgtoZHdy2V5vS3/j7XYw6RoplFD+DwWSHP80qN+JWYe8HPe
	 cvizFatk5vhZ3zK7wRYwiAvLkR8G1OoRIM2qmW6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 16/77] RDMA/hns: Fix unmatched condition in error path of alloc_user_qp_db()
Date: Tue, 25 Mar 2025 08:22:11 -0400
Message-ID: <20250325122144.766763582@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122144.259256924@linuxfoundation.org>
References: <20250325122144.259256924@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junxian Huang <huangjunxian6@hisilicon.com>

[ Upstream commit b9f59a24ba35a7d955a9f8e148dd9f85b7b40a01 ]

Currently the condition of unmapping sdb in error path is not exactly
the same as the condition of mapping in alloc_user_qp_db(). This may
cause a problem of unmapping an unmapped db in some case, such as
when the QP is XRC TGT. Unified the two conditions.

Fixes: 90ae0b57e4a5 ("RDMA/hns: Combine enable flags of qp")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://patch.msgid.link/20250311084857.3803665-4-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 97d79c8d5cd06..0b054b708d515 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -860,12 +860,14 @@ static int alloc_user_qp_db(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_ib_create_qp *ucmd,
 			    struct hns_roce_ib_create_qp_resp *resp)
 {
+	bool has_sdb = user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd);
 	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(udata,
 		struct hns_roce_ucontext, ibucontext);
+	bool has_rdb = user_qp_has_rdb(hr_dev, init_attr, udata, resp);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
-	if (user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd)) {
+	if (has_sdb) {
 		ret = hns_roce_db_map_user(uctx, ucmd->sdb_addr, &hr_qp->sdb);
 		if (ret) {
 			ibdev_err(ibdev,
@@ -876,7 +878,7 @@ static int alloc_user_qp_db(struct hns_roce_dev *hr_dev,
 		hr_qp->en_flags |= HNS_ROCE_QP_CAP_SQ_RECORD_DB;
 	}
 
-	if (user_qp_has_rdb(hr_dev, init_attr, udata, resp)) {
+	if (has_rdb) {
 		ret = hns_roce_db_map_user(uctx, ucmd->db_addr, &hr_qp->rdb);
 		if (ret) {
 			ibdev_err(ibdev,
@@ -890,7 +892,7 @@ static int alloc_user_qp_db(struct hns_roce_dev *hr_dev,
 	return 0;
 
 err_sdb:
-	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_SQ_RECORD_DB)
+	if (has_sdb)
 		hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
 err_out:
 	return ret;
-- 
2.39.5





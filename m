Return-Path: <stable+bounces-126464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55653A70106
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93AA843F36
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8694525D52C;
	Tue, 25 Mar 2025 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dmjPIAjM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4203225B69D;
	Tue, 25 Mar 2025 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906273; cv=none; b=GrVkArb0T73tCKNv1waMabHeyMV5KkWBn9XxsQGxi2po487HFQAOEF/FFSfmrjXVPL17FGL8WA908bxoI5rmEn24H19SVcYYY94dgqJltTppUg6gd3aX8rr53y5nnuuR3svxJxSUtS/F3FXmPa5iWVf3kv4P5NqW+9EceM9Z8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906273; c=relaxed/simple;
	bh=FeNPbcgvfLwXS/uxqolQTIAWVTHM+DkymjRHcwszzSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCWmxs8ghLbc6Qo5YTJ463V2IbES/E14IOnJ0L1k1sxybdbRgIcjC9gm4laJ0VBxL02cgLy4GMzm0ZIk85XFn1/pTv2BTSIAUvU6thfYCnWYEylXQRFsa8lOvnoqL5qHiEy4mUqM1LN6PWZqTT6gSZYsF6QQR6RE6KFufSHZnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dmjPIAjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB516C4CEE4;
	Tue, 25 Mar 2025 12:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906273;
	bh=FeNPbcgvfLwXS/uxqolQTIAWVTHM+DkymjRHcwszzSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dmjPIAjMiS97rS/9FkZ8w7G10KTgLl6lIgaRRMcKnizsmvIvtdUEkSipWdnM2uJ+j
	 1v+NC1fzpur1N2KpCJr4d1PczbcpClGQD7AVhuNLheECFDK1S/yvwE638tofSqFiaT
	 FiN5wpwaUYhP2sGZFPCUlHVRFmOLl0ww+QNoNGkk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 029/116] RDMA/hns: Fix wrong value of max_sge_rd
Date: Tue, 25 Mar 2025 08:21:56 -0400
Message-ID: <20250325122149.959503889@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122149.207086105@linuxfoundation.org>
References: <20250325122149.207086105@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junxian Huang <huangjunxian6@hisilicon.com>

[ Upstream commit 6b5e41a8b51fce520bb09bd651a29ef495e990de ]

There is no difference between the sge of READ and non-READ
operations in hns RoCE. Set max_sge_rd to the same value as
max_send_sge.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://patch.msgid.link/20250311084857.3803665-8-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index ae24c81c9812d..cf89a8db4f64c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -183,7 +183,7 @@ static int hns_roce_query_device(struct ib_device *ib_dev,
 				  IB_DEVICE_RC_RNR_NAK_GEN;
 	props->max_send_sge = hr_dev->caps.max_sq_sg;
 	props->max_recv_sge = hr_dev->caps.max_rq_sg;
-	props->max_sge_rd = 1;
+	props->max_sge_rd = hr_dev->caps.max_sq_sg;
 	props->max_cq = hr_dev->caps.num_cqs;
 	props->max_cqe = hr_dev->caps.max_cqes;
 	props->max_mr = hr_dev->caps.num_mtpts;
-- 
2.39.5





Return-Path: <stable+bounces-50590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52E9906B60
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65211C2183F
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31E142E99;
	Thu, 13 Jun 2024 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p2Ch0C07"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE35ADDB1;
	Thu, 13 Jun 2024 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278810; cv=none; b=D31VUMupvdxvEitQe/I5qB7fvN2s+TbAFfH+HEmX7b/V6INJoGzq/Z17DOcCeIFAwjQVAJKCI8pqD4p2Rtn8Umc8ahT2Xi4ZulJbnqnOIdOxMAS/MHTTpINpZ9d8lrdvVWQlcNezwAmirPHzF0qB+LVcGnXOB8A/d/gskNJcQWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278810; c=relaxed/simple;
	bh=FW8uVkitN5bIt145iAS2v3rneuY80S/QPPs7Dklh9Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+dwxZxLSJJyFieCQwCEsDqaayuyvqdhz8sKZl9bUG/ZsEtYH3aBX9HqaOsT6SK4xrn/zLDHNmD0pFDa3LUAVo3pDXPKEDPQWr62OSyPptXxT4vSOSim0VgYdGFChRlKXS08Vqc1u/+twRy2X1Mxk4oXYJp7T7I0I5jM6pXGJRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p2Ch0C07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0BEC2BBFC;
	Thu, 13 Jun 2024 11:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718278810;
	bh=FW8uVkitN5bIt145iAS2v3rneuY80S/QPPs7Dklh9Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2Ch0C07NIIkL61m8xU9II0nVRtPk95j/XScoNfSP7eSTXG9Qjpp403LwE5N/je+0
	 2gxFO3kJyYE4mQGKFzOMcqalefSDlLeJTmI+I8smeYwckxJFbmUlKsrNF9x6UMYczc
	 FIxHzynEjKbwmaWFgHDI9TdKDjH6bQY5QytcGPAw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 076/213] RDMA/hns: Use complete parentheses in macros
Date: Thu, 13 Jun 2024 13:32:04 +0200
Message-ID: <20240613113230.941839330@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengchang Tang <tangchengchang@huawei.com>

[ Upstream commit 4125269bb9b22e1d8cdf4412c81be8074dbc61ca ]

Use complete parentheses to ensure that macro expansion does
not produce unexpected results.

Fixes: a25d13cbe816 ("RDMA/hns: Add the interfaces to support multi hop addressing for the contexts in hip08")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20240412091616.370789-10-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hem.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index a94444db3045a..265706811f23a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -57,16 +57,16 @@ enum {
 	 (sizeof(struct scatterlist) + sizeof(void *)))
 
 #define check_whether_bt_num_3(type, hop_num) \
-	(type < HEM_TYPE_MTT && hop_num == 2)
+	((type) < HEM_TYPE_MTT && (hop_num) == 2)
 
 #define check_whether_bt_num_2(type, hop_num) \
-	((type < HEM_TYPE_MTT && hop_num == 1) || \
-	(type >= HEM_TYPE_MTT && hop_num == 2))
+	(((type) < HEM_TYPE_MTT && (hop_num) == 1) || \
+	((type) >= HEM_TYPE_MTT && (hop_num) == 2))
 
 #define check_whether_bt_num_1(type, hop_num) \
-	((type < HEM_TYPE_MTT && hop_num == HNS_ROCE_HOP_NUM_0) || \
-	(type >= HEM_TYPE_MTT && hop_num == 1) || \
-	(type >= HEM_TYPE_MTT && hop_num == HNS_ROCE_HOP_NUM_0))
+	(((type) < HEM_TYPE_MTT && (hop_num) == HNS_ROCE_HOP_NUM_0) || \
+	((type) >= HEM_TYPE_MTT && (hop_num) == 1) || \
+	((type) >= HEM_TYPE_MTT && (hop_num) == HNS_ROCE_HOP_NUM_0))
 
 enum {
 	 HNS_ROCE_HEM_PAGE_SHIFT = 12,
-- 
2.43.0





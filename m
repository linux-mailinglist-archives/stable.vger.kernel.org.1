Return-Path: <stable+bounces-36457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0388489C063
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C568B294DF
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D8E7E0FF;
	Mon,  8 Apr 2024 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H5c5MJqk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E120F7350E;
	Mon,  8 Apr 2024 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581382; cv=none; b=PFgHA2kjXF5KgXcIaXfaNw/uCKamndxOSsdnMh/VpCxlBoSswoHE15ESdWqX/WgEbWwB4dSAcn/klMWQZqnGZVb8DTYLG7rVr5+s1dF1mk3ohqL4TiHpoGstRY6E+KX4sJfBh0RvbRSL9L3Hq5Y4LjcoBFF8SabKa3EhCT/K5VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581382; c=relaxed/simple;
	bh=hx+ZReYAu8WNJafOoPvrC1pFlcLA2eJ8A+8rS/v2/2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bohMp35JuAlYlnYGSBxVotPPaaAOb/N9fMdbcyweUm/PVhzPNRLAoANpwImhYTWK6wNy2JEMQoKGf2/U68AzXpyY5Gnv8sxAKrlMeUGA1nwMKX22bmxoIG2msiHAg6AOWtOxPUM4BR2HXDsijLn0YAl+5YO+WVbXxkRD9SFZseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H5c5MJqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F69C433C7;
	Mon,  8 Apr 2024 13:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581381;
	bh=hx+ZReYAu8WNJafOoPvrC1pFlcLA2eJ8A+8rS/v2/2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5c5MJqkOhJH3mHVIK8rF7TrQ2EbkZnyZm/Bxy/0hovTrEHfbGAaOq1GZZiOhv4Er
	 YrGuvvdTyX+AmjyI9U6wMSgCvksFpOzDCic7RMHC7UpeqQkGpnukBxyp1oWS4O3ivc
	 3wzOp900C5PbAIy9ydAN/yMy2pgedR5ZfdBV8KD0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jie Wang <wangjie125@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 011/138] net: hns3: fix index limit to support all queue stats
Date: Mon,  8 Apr 2024 14:57:05 +0200
Message-ID: <20240408125256.581745686@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jie Wang <wangjie125@huawei.com>

[ Upstream commit 47e39d213e09c6cae0d6b4d95e454ea404013312 ]

Currently, hns hardware supports more than 512 queues and the index limit
in hclge_comm_tqps_update_stats is wrong. So this patch removes it.

Fixes: 287db5c40d15 ("net: hns3: create new set of common tqp stats APIs for PF and VF reuse")
Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
index f3c9395d8351c..618f66d9586b3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
@@ -85,7 +85,7 @@ int hclge_comm_tqps_update_stats(struct hnae3_handle *handle,
 		hclge_comm_cmd_setup_basic_desc(&desc, HCLGE_OPC_QUERY_TX_STATS,
 						true);
 
-		desc.data[0] = cpu_to_le32(tqp->index & 0x1ff);
+		desc.data[0] = cpu_to_le32(tqp->index);
 		ret = hclge_comm_cmd_send(hw, &desc, 1);
 		if (ret) {
 			dev_err(&hw->cmq.csq.pdev->dev,
-- 
2.43.0





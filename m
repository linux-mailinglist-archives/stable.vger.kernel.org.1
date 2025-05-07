Return-Path: <stable+bounces-142740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85F0AAEBFC
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 21:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C941C9E3DFC
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CED28DF1F;
	Wed,  7 May 2025 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aVvLDG5Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4440214813;
	Wed,  7 May 2025 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645183; cv=none; b=jm503uH09k72bHUo9cUUdJqYW7SsDzfCv/NolE2a3ulPmjrR3T9w/C4y6uD3YHrBVCe9rm9SUZPSwUSGDPZp8NF64dcuLeVtki6wVd/OE5aRZARW5PRZp8zvq1EUVchjEYN1pGBExO54+PC7j1kk5LBL5ifbwUSnN/nBgjWqOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645183; c=relaxed/simple;
	bh=Hyaw3DHIHfOO7N9bNYSCL2n1L6Xxk2SRFYvYG+c03Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGjP4K+/rkcty77bMlKR/0OWY4G2jRGfoxvrv6oYzc1bdwCrcLzFmwtvx1fz4XUAAezZHUz/OLz6Cx9jqsB4F6Xl78K9BfePUjPd2+ZDCZeNKHNl5zJtYLS2tWAicXNBfx9sK8R2xZIg0GJxnmIKpW8yDED5u0mv5bOB1wmhJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aVvLDG5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F2DC4CEE2;
	Wed,  7 May 2025 19:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746645183;
	bh=Hyaw3DHIHfOO7N9bNYSCL2n1L6Xxk2SRFYvYG+c03Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVvLDG5QLtRtBRs7GoHebMrneMgAGg+ua6WyqCLsTXBB+1W60pMA1zNUPV2Rgmdym
	 tvVC1IPw1agfH8EfS/P/gZjdhoF1VXFPYJCuemO855jRtDG4WiO5XTYgjkTQeG5jw4
	 6puJWsS6/EKIR7ZUHVk+SglES6FBYZaZW96eph6c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hao Lan <lanhao@huawei.com>,
	Peiyang Wang <wangpeiyang1@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 090/129] net: hns3: fixed debugfs tm_qset size
Date: Wed,  7 May 2025 20:40:26 +0200
Message-ID: <20250507183817.148869403@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183813.500572371@linuxfoundation.org>
References: <20250507183813.500572371@linuxfoundation.org>
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

From: Hao Lan <lanhao@huawei.com>

[ Upstream commit e317aebeefcb3b0c71f2305af3c22871ca6b3833 ]

The size of the tm_qset file of debugfs is limited to 64 KB,
which is too small in the scenario with 1280 qsets.
The size needs to be expanded to 1 MB.

Fixes: 5e69ea7ee2a6 ("net: hns3: refactor the debugfs process")
Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Link: https://patch.msgid.link/20250430093052.2400464-4-shaojijie@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 4f385a18d288e..36206273453f3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -60,7 +60,7 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.name = "tm_qset",
 		.cmd = HNAE3_DBG_CMD_TM_QSET,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
+		.buf_len = HNS3_DBG_READ_LEN_1MB,
 		.init = hns3_dbg_common_file_init,
 	},
 	{
-- 
2.39.5





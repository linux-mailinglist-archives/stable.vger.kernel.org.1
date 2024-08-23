Return-Path: <stable+bounces-69988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE72F95CEDA
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281FC1C22E15
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77059193062;
	Fri, 23 Aug 2024 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4ohKI6d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AF2188A21;
	Fri, 23 Aug 2024 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421746; cv=none; b=M5VwEsDE4Mp+0aol7mNcPhrLByIqAM4Wk9h4tZCOH9y+yL5U+5rQwo1bFhIzsbwIjaHpqI9u9nvUNHMIY8PlogGhBHbzOB2KBALt2EW9vSgLlNuySwtDwiLclehVrcm4Kv8LRev7EqbwMnytME6LtIqyS+GE8HAVytk0iPqbvHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421746; c=relaxed/simple;
	bh=lTxri48lra60IkHNA/9pjwYqhDnuSpKoAtbNRat6aQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/Sxo54OgA4yNaMfUq4n7+5/wmPTLCUZeRTU5MYNQ6KjklWANf9Bc5YImQR1Jp3dvZ7BTe0tPDulqRxdCEvklw4o6Keg2bc8mImYSkRKXBl/b/TUmHO961x5h98SM9hS1Y2Mfvzx0cr3qUnzRH658PuzLLCmJgce01xqEiu/+0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4ohKI6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC88C4AF0E;
	Fri, 23 Aug 2024 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421745;
	bh=lTxri48lra60IkHNA/9pjwYqhDnuSpKoAtbNRat6aQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4ohKI6dgr2bh3H9YfKBqkaIJZ0AQb7BAdR5yw3RpI/QdAKQfuOh4n3H+1TYwT2zg
	 +xCeZP5LEaZKa1t9x65EEyd5YZJ0H/qL5O1gpzNFvM3DMA7IShf1OA5a9hhnl+G54D
	 6ys3nzXDnc10EHMNtD6p9AGSc/uy8CuFKa1P2y49s0loq1vlHNVAcEra++8tqCbg0g
	 JPA5zOpz744AtvmJDZkS0pm+pGjqbmCXUbbIW258P53ABdfjZoeOYumpshBCJ7m9vH
	 kJODC9U3eONgkFoM5CxLynRq1+s37b71nDy1D30s7nqeifxl2Y8pHZ31AkBETDchts
	 dm3Fuh5dKKOng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peiyang Wang <wangpeiyang1@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	yisen.zhuang@huawei.com,
	salil.mehta@huawei.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	wangjie125@huawei.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 21/24] net: hns3: void array out of bound when loop tnl_num
Date: Fri, 23 Aug 2024 10:00:43 -0400
Message-ID: <20240823140121.1974012-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
Content-Transfer-Encoding: 8bit

From: Peiyang Wang <wangpeiyang1@huawei.com>

[ Upstream commit 86db7bfb06704ef17340eeae71c832f21cfce35c ]

When query reg inf of SSU, it loops tnl_num times. However, tnl_num comes
from hardware and the length of array is a fixed value. To void array out
of bound, make sure the loop time is not greater than the length of array

Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index e132c2f095609..cc7f46c0b35ff 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -1598,8 +1598,7 @@ static void hclge_query_reg_info_of_ssu(struct hclge_dev *hdev)
 {
 	u32 loop_para[HCLGE_MOD_MSG_PARA_ARRAY_MAX_SIZE] = {0};
 	struct hclge_mod_reg_common_msg msg;
-	u8 i, j, num;
-	u32 loop_time;
+	u8 i, j, num, loop_time;
 
 	num = ARRAY_SIZE(hclge_ssu_reg_common_msg);
 	for (i = 0; i < num; i++) {
@@ -1609,7 +1608,8 @@ static void hclge_query_reg_info_of_ssu(struct hclge_dev *hdev)
 		loop_time = 1;
 		loop_para[0] = 0;
 		if (msg.need_para) {
-			loop_time = hdev->ae_dev->dev_specs.tnl_num;
+			loop_time = min(hdev->ae_dev->dev_specs.tnl_num,
+					HCLGE_MOD_MSG_PARA_ARRAY_MAX_SIZE);
 			for (j = 0; j < loop_time; j++)
 				loop_para[j] = j + 1;
 		}
-- 
2.43.0



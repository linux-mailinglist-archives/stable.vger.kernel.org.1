Return-Path: <stable+bounces-49299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3AC8FECB3
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324DDB28565
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF1F19B599;
	Thu,  6 Jun 2024 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qgUsGXM0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDE319B3F2;
	Thu,  6 Jun 2024 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683398; cv=none; b=h4O5z0/wiQ0ZgKfvOnN82aUqz6clP9INa3+POPIhSpNREYCrLQmpisQWKQgxHDekvgs5KfxKygJd09Qy8bezmgMN7vcvo1ROEQgjEmT++yY//+Jm7cYDqy4l0Aux/gzMQsxFNTIOxjII2VKNu7SgPcumtcaIhiu46jdQExoQ8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683398; c=relaxed/simple;
	bh=tYlpcMEo+j2ApdmiiWyAVP5HMNAvvAtWz60skTgOLQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGCezPvom0KKh57jhDoM0WGzglR0dcmPWwiOLv8ezxXlitSLRE4Op+Bv+rAzWjsKSfMd7J+8yUg3JAT82MBL0Mnexb4ZTqeN6J1ZhZFZ+yJScl70R/+K9XMkzyFIGTbrzwb8K6xSeR5m7iWoguAKY9pvJ0XqWI9Y3bBIAp/mQXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qgUsGXM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0C7C2BD10;
	Thu,  6 Jun 2024 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683398;
	bh=tYlpcMEo+j2ApdmiiWyAVP5HMNAvvAtWz60skTgOLQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qgUsGXM0wMiTJHt56/WKUP2SpLcNostQ2udelU93K6osGSBlgsp0BtzOB39DzWZt3
	 /e0WSfhtwbJU2DGYuJUp432m6DbB0bcLXq+ExHRcydZgzCyhyVb6ELqPsMHR60LZ8C
	 T1PFEWygk39cDto/IousgX29IZHmnmdzIDRYEOQ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 342/744] RDMA/hns: Fix GMV table pagesize
Date: Thu,  6 Jun 2024 16:00:14 +0200
Message-ID: <20240606131743.440975211@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengchang Tang <tangchengchang@huawei.com>

[ Upstream commit ee045493283403969591087bd405fa280103282a ]

GMV's BA table only supports 4K pages. Currently, PAGESIZE is used to
calculate gmv_bt_num, which will cause an abnormal number of gmv_bt_num
in a 64K OS.

Fixes: d6d91e46210f ("RDMA/hns: Add support for configuring GMV table")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20240412091616.370789-8-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b4799c83282e2..2f88e7853abff 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2088,7 +2088,7 @@ static void apply_func_caps(struct hns_roce_dev *hr_dev)
 		caps->gid_table_len[0] = caps->gmv_bt_num *
 					(HNS_HW_PAGE_SIZE / caps->gmv_entry_sz);
 
-		caps->gmv_entry_num = caps->gmv_bt_num * (PAGE_SIZE /
+		caps->gmv_entry_num = caps->gmv_bt_num * (HNS_HW_PAGE_SIZE /
 							  caps->gmv_entry_sz);
 	} else {
 		u32 func_num = max_t(u32, 1, hr_dev->func_num);
-- 
2.43.0





Return-Path: <stable+bounces-207479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9B2D09F4F
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62E9930963DA
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BB8358D30;
	Fri,  9 Jan 2026 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jaoBBA3D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8D231ED6D;
	Fri,  9 Jan 2026 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962172; cv=none; b=t31ZLDQb22ohzYLwJENolnaE77ZLJN3IMjHLBs9pthL++A3O4DXhHQnrLgPrpklCnYGNlO2xmkFY5bXx/0zndP2EqT7p2mnxa4DhObPkqJ3BiEBWa6kMPPDwPKEE9jfONUJyrYdLSEjkHKsypxasiPNBjgHkXhqxTyrCY4OYFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962172; c=relaxed/simple;
	bh=af9y6kQGyURp6aXLVvRbyytMQ4J+MasBAGlBsEXqXVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSz9Sbogx9K/sTzlkP6Kfe1uJj90Fat+fofS2nh01UWnGfsx93b4xnC4rX58ltb+rCLmopTNCRzX21W/WB9FyjZkTqJGF3qJldfb0xAVOsnLnZkKk0zLN3mno72Z5w4FmvQ1Ip8ea5jYqpYyG2Y31G1e8oYr/xXNRJkD/MJqZdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jaoBBA3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4C9C4CEF1;
	Fri,  9 Jan 2026 12:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767962171;
	bh=af9y6kQGyURp6aXLVvRbyytMQ4J+MasBAGlBsEXqXVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jaoBBA3DE0kfoqqXsLafaSloQXg2yVww2qftJxZnr2u28JHjAQdGF6eBeqM7ayIFF
	 u2Ncg0U+lu/RdVxjjTqL/X+eIG3tC1koAlM/8OcvXSSoo4Z8pi50KcIySFkXvQf1aP
	 5sYGTJHTvYR/RRGyfIHqOoEhlQyTbvr1u9ivmD+4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 270/634] net: hns3: using the num_tqps to check whether tqp_index is out of range when vf get ring info from mbx
Date: Fri,  9 Jan 2026 12:39:08 +0100
Message-ID: <20260109112127.695431012@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit d180c11aa8a6fa735f9ac2c72c61364a9afc2ba7 ]

Currently, rss_size = num_tqps / tc_num. If tc_num is 1, then num_tqps
equals rss_size. However, if the tc_num is greater than 1, then rss_size
will be less than num_tqps, causing the tqp_index check for subsequent TCs
using rss_size to always fail.

This patch uses the num_tqps to check whether tqp_index is out of range,
instead of rss_size.

Fixes: 326334aad024 ("net: hns3: add a check for tqp_index in hclge_get_ring_chain_from_mbx()")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20251211023737.2327018-3-shaojijie@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 61e155c4d441e..a961e90a85a67 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -193,10 +193,10 @@ static int hclge_get_ring_chain_from_mbx(
 		return -EINVAL;
 
 	for (i = 0; i < ring_num; i++) {
-		if (req->msg.param[i].tqp_index >= vport->nic.kinfo.rss_size) {
+		if (req->msg.param[i].tqp_index >= vport->nic.kinfo.num_tqps) {
 			dev_err(&hdev->pdev->dev, "tqp index(%u) is out of range(0-%u)\n",
 				req->msg.param[i].tqp_index,
-				vport->nic.kinfo.rss_size - 1U);
+				vport->nic.kinfo.num_tqps - 1U);
 			return -EINVAL;
 		}
 	}
-- 
2.51.0





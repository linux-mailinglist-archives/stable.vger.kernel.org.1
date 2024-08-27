Return-Path: <stable+bounces-70826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE9961037
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55B11C20919
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F391C2DB1;
	Tue, 27 Aug 2024 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W6KN40/m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5A519F485;
	Tue, 27 Aug 2024 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771188; cv=none; b=Dbyo1oKF2woDKsspo1ZeUwZvwqX38uJ/p4XAMCgbY3xGllEAlF5XK6reT5b1ZTWlSiPWEUSa/3z1j1wIKtMvnfWEowFLd/XS1u53n3e+10GI1dxyB3vIcGwSjhMknh/pQdEs9C+ow8hfBM6BuLQyxSR9lg0iXtx4h7ZJ5gWmXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771188; c=relaxed/simple;
	bh=9nsEIzb+uwktQLlq5kVasOSWOBHwY3vUSQXxKAni6P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hL+7pZQcpV7vKHrZ6UiEhOg7GxBRZtw+lx06Zpv2vFJnZr9Gy1yuPSKXX+FKCwRbDKpFG3SPORlwSpaNS+DjJhA0bFXOhTbJwIPVZ4UBcmYu42eqVZVJ8bg5vG1WAYVpnKxoBIw2c76ZJ7HR0IgFZBh8vsys1GYxOYNPlu0RocY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W6KN40/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCD8C4AF55;
	Tue, 27 Aug 2024 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771187;
	bh=9nsEIzb+uwktQLlq5kVasOSWOBHwY3vUSQXxKAni6P4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6KN40/m2LefcCeuLAEnNcKzYs6R34JQDldxNvIg05GvQ65ClZL5WgMTmZ8LMaNlv
	 y1/lmcrTqILO4LkZTv7ik0uUpIGpbCGX4JUFdkMD8Y7f7iojj9cqdbA2r0itXIHsnT
	 8F2aevb78D4DfRQr3BLVdXNrAaXVuDKQ398A5uOA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peiyang Wang <wangpeiyang1@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 114/273] net: hns3: use the users cfg after reset
Date: Tue, 27 Aug 2024 16:37:18 +0200
Message-ID: <20240827143837.747700647@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peiyang Wang <wangpeiyang1@huawei.com>

[ Upstream commit 30545e17eac1f50c5ef49644daf6af205100a965 ]

Consider the followed case that the user change speed and reset the net
interface. Before the hw change speed successfully, the driver get old
old speed from hw by timer task. After reset, the previous speed is config
to hw. As a result, the new speed is configed successfully but lost after
PF reset. The followed pictured shows more dirrectly.

+------+              +----+                 +----+
| USER |              | PF |                 | HW |
+---+--+              +-+--+                 +-+--+
    |  ethtool -s 100G  |                      |
    +------------------>|   set speed 100G     |
    |                   +--------------------->|
    |                   |  set successfully    |
    |                   |<---------------------+---+
    |                   |query cfg (timer task)|   |
    |                   +--------------------->|   | handle speed
    |                   |     return 200G      |   | changing event
    |  ethtool --reset  |<---------------------+   | (100G)
    +------------------>|  cfg previous speed  |<--+
    |                   |  after reset (200G)  |
    |                   +--------------------->|
    |                   |                      +---+
    |                   |query cfg (timer task)|   |
    |                   +--------------------->|   | handle speed
    |                   |     return 100G      |   | changing event
    |                   |<---------------------+   | (200G)
    |                   |                      |<--+
    |                   |query cfg (timer task)|
    |                   +--------------------->|
    |                   |     return 200G      |
    |                   |<---------------------+
    |                   |                      |
    v                   v                      v

This patch save new speed if hw change speed successfully, which will be
used after reset successfully.

Fixes: 2d03eacc0b7e ("net: hns3: Only update mac configuation when necessary")
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 24 ++++++++++++++-----
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  3 +++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 125e04434611d..465f0d5822837 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2653,8 +2653,17 @@ static int hclge_cfg_mac_speed_dup_h(struct hnae3_handle *handle, int speed,
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
+	int ret;
+
+	ret = hclge_cfg_mac_speed_dup(hdev, speed, duplex, lane_num);
 
-	return hclge_cfg_mac_speed_dup(hdev, speed, duplex, lane_num);
+	if (ret)
+		return ret;
+
+	hdev->hw.mac.req_speed = speed;
+	hdev->hw.mac.req_duplex = duplex;
+
+	return 0;
 }
 
 static int hclge_set_autoneg_en(struct hclge_dev *hdev, bool enable)
@@ -2956,17 +2965,20 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 	if (!test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
 		hdev->hw.mac.duplex = HCLGE_MAC_FULL;
 
-	ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.speed,
-					 hdev->hw.mac.duplex, hdev->hw.mac.lane_num);
-	if (ret)
-		return ret;
-
 	if (hdev->hw.mac.support_autoneg) {
 		ret = hclge_set_autoneg_en(hdev, hdev->hw.mac.autoneg);
 		if (ret)
 			return ret;
 	}
 
+	if (!hdev->hw.mac.autoneg) {
+		ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
+						 hdev->hw.mac.req_duplex,
+						 hdev->hw.mac.lane_num);
+		if (ret)
+			return ret;
+	}
+
 	mac->link = 0;
 
 	if (mac->user_fec_mode & BIT(HNAE3_FEC_USER_DEF)) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 85fb11de43a12..80079657afebe 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -191,6 +191,9 @@ static void hclge_mac_adjust_link(struct net_device *netdev)
 	if (ret)
 		netdev_err(netdev, "failed to adjust link.\n");
 
+	hdev->hw.mac.req_speed = (u32)speed;
+	hdev->hw.mac.req_duplex = (u8)duplex;
+
 	ret = hclge_cfg_flowctrl(hdev);
 	if (ret)
 		netdev_err(netdev, "failed to configure flow control.\n");
-- 
2.43.0





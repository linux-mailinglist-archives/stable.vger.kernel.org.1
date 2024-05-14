Return-Path: <stable+bounces-43985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B94438C509A
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46744B20C2C
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F1B13DDA7;
	Tue, 14 May 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vjbulS+F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A4313DDA3;
	Tue, 14 May 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683506; cv=none; b=TmHJ9QmTv83DMhYPgam0gwqasN2vp2ZkQjcqhXxxrJN6rZLWcGripttW998K4adzAO4MC9vPp2QFOVR9dYYsLYZHZNjLAEy753JufV+A0/S/gePA43CHeaI/5XzHhPYUMpMw+TCwU6M2NNDjf6TY4Spdwvg9BK2iqtKQVb43+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683506; c=relaxed/simple;
	bh=5CiHR4Fben+FQVYHH1UYYoD+tlNt2VyzVygZS7cPFm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThDkjK7g1AVHT6bcUKBLgWgWtnYimDSmafZiw4vRPS/buai63IChegq1Kk2PPBy+/sMnDSyC+BltnoCCeKavofsAM0eg6UQXnGfGbIMXRiQcKSoMcVfDZb13tPnNebimehXizvXDwrySWJFutQ1c3pPMej8Ma8e1PuWc0zyB6i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vjbulS+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A4AC2BD10;
	Tue, 14 May 2024 10:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683506;
	bh=5CiHR4Fben+FQVYHH1UYYoD+tlNt2VyzVygZS7cPFm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vjbulS+FNxF6U0s/L0vCUcPcZ4XXXpHKipTfxw6W/ANEzpjJB5HvdRCrUxU5eMjdW
	 D77nNseoHD2+JQnykZAjeipP+SJNXvqu8xD61winuX03Odm+Ld/3oMjso+ab45xZ1H
	 m6IGKC/YhU6yTSVs9iurImzU71lBpBihurkr1akw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peiyang Wang <wangpeiyang1@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 229/336] net: hns3: release PTP resources if pf initialization failed
Date: Tue, 14 May 2024 12:17:13 +0200
Message-ID: <20240514101047.260398055@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peiyang Wang <wangpeiyang1@huawei.com>

[ Upstream commit 950aa42399893a170d9b57eda0e4a3ff91fd8b70 ]

During the PF initialization process, hclge_update_port_info may return an
error code for some reason. At this point,  the ptp initialization has been
completed. To void memory leaks, the resources that are applied by ptp
should be released. Therefore, when hclge_update_port_info returns an error
code, hclge_ptp_uninit is called to release the corresponding resources.

Fixes: eaf83ae59e18 ("net: hns3: add querying fec ability from firmware")
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 6b84c1313f9bd..a5e63655fd88d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -11751,7 +11751,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 	ret = hclge_update_port_info(hdev);
 	if (ret)
-		goto err_mdiobus_unreg;
+		goto err_ptp_uninit;
 
 	INIT_KFIFO(hdev->mac_tnl_log);
 
@@ -11802,6 +11802,8 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	devl_unlock(hdev->devlink);
 	return 0;
 
+err_ptp_uninit:
+	hclge_ptp_uninit(hdev);
 err_mdiobus_unreg:
 	if (hdev->hw.mac.phydev)
 		mdiobus_unregister(hdev->hw.mac.mdio_bus);
-- 
2.43.0





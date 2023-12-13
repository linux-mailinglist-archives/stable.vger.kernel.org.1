Return-Path: <stable+bounces-5626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE5E80D5B5
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B10F4B20E1A
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A715102D;
	Mon, 11 Dec 2023 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LatnrcN8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834AC5101B;
	Mon, 11 Dec 2023 18:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0036AC433C7;
	Mon, 11 Dec 2023 18:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319229;
	bh=NnnYYjFmeC9F3Gy3yzMUvbsrcQWYxhex/KLXZVzPqhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LatnrcN84aALDzVVvat67rw5+YE/LkLNVt7/E0Yv1kJ+XGQTp4ytRZ8YPTySdYx0W
	 2KJoBA4Us/FvzASPLVrfHvXzc6X04A9TrYI2Vae4xzyD2ZEw2nl+RjpqKQ3cCDt/V5
	 bYmnUtRPIBIpEcDuY0GqvuAJechvvPeJK9Hk6/zM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 028/244] octeontx2-pf: Add missing mutex lock in otx2_get_pauseparam
Date: Mon, 11 Dec 2023 19:18:41 +0100
Message-ID: <20231211182047.061212921@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
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

From: Subbaraya Sundeep <sbhatta@marvell.com>

[ Upstream commit 9572c949385aa2ef10368287c439bcb7935137c8 ]

All the mailbox messages sent to AF needs to be guarded
by mutex lock. Add the missing lock in otx2_get_pauseparam
function.

Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 9efcec549834e..53f6258a973c2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -334,9 +334,12 @@ static void otx2_get_pauseparam(struct net_device *netdev,
 	if (is_otx2_lbkvf(pfvf->pdev))
 		return;
 
+	mutex_lock(&pfvf->mbox.lock);
 	req = otx2_mbox_alloc_msg_cgx_cfg_pause_frm(&pfvf->mbox);
-	if (!req)
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
 		return;
+	}
 
 	if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
 		rsp = (struct cgx_pause_frm_cfg *)
@@ -344,6 +347,7 @@ static void otx2_get_pauseparam(struct net_device *netdev,
 		pause->rx_pause = rsp->rx_pause;
 		pause->tx_pause = rsp->tx_pause;
 	}
+	mutex_unlock(&pfvf->mbox.lock);
 }
 
 static int otx2_set_pauseparam(struct net_device *netdev,
-- 
2.42.0





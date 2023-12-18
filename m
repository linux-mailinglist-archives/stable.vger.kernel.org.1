Return-Path: <stable+bounces-7162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202B9817137
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C9528176A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257C615AC0;
	Mon, 18 Dec 2023 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pJyRuKUF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08BA129EE3;
	Mon, 18 Dec 2023 13:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6542AC433C7;
	Mon, 18 Dec 2023 13:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907727;
	bh=t96KsVuLM1wGf+WYIGauakb1ERC43+2O/d8d548EX/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJyRuKUFeveKxn5LQoeGrLaZFveIdl5nHwb+mD4ynGvnF9dF2LXg24CcCrSRkgW+Z
	 EViRVbRSP47s56IhNKRtj6uUsTa0i7MxJk3JCEfHiODkq867bCAWUr9XmsXs8w10Ux
	 TTPStWHWnwBMO9KEPRMpLhJcB7CCkevKl6Nx1+Ck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hariprasad Kelam <hkelam@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 024/106] octeontx2-pf: Fix promisc mcam entry action
Date: Mon, 18 Dec 2023 14:50:38 +0100
Message-ID: <20231218135055.976721726@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

From: Hariprasad Kelam <hkelam@marvell.com>

[ Upstream commit dbda436824ded8ef6a05bb82cd9baa8d42377a49 ]

Current implementation is such that, promisc mcam entry action
is set as multicast even when there are no trusted VFs. multicast
action causes the hardware to copy packet data, which reduces
the performance.

This patch fixes this issue by setting the promisc mcam entry action to
unicast instead of multicast when there are no trusted VFs. The same
change is made for the 'allmulti' mcam entry action.

Fixes: ffd2f89ad05c ("octeontx2-pf: Enable promisc/allmulti match MCAM entries.")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 55807e2043edf..a2d8ac6204054 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1638,6 +1638,21 @@ static void otx2_free_hw_resources(struct otx2_nic *pf)
 	mutex_unlock(&mbox->lock);
 }
 
+static bool otx2_promisc_use_mce_list(struct otx2_nic *pfvf)
+{
+	int vf;
+
+	/* The AF driver will determine whether to allow the VF netdev or not */
+	if (is_otx2_vf(pfvf->pcifunc))
+		return true;
+
+	/* check if there are any trusted VFs associated with the PF netdev */
+	for (vf = 0; vf < pci_num_vf(pfvf->pdev); vf++)
+		if (pfvf->vf_configs[vf].trusted)
+			return true;
+	return false;
+}
+
 static void otx2_do_set_rx_mode(struct otx2_nic *pf)
 {
 	struct net_device *netdev = pf->netdev;
@@ -1670,7 +1685,8 @@ static void otx2_do_set_rx_mode(struct otx2_nic *pf)
 	if (netdev->flags & (IFF_ALLMULTI | IFF_MULTICAST))
 		req->mode |= NIX_RX_MODE_ALLMULTI;
 
-	req->mode |= NIX_RX_MODE_USE_MCE;
+	if (otx2_promisc_use_mce_list(pf))
+		req->mode |= NIX_RX_MODE_USE_MCE;
 
 	otx2_sync_mbox_msg(&pf->mbox);
 	mutex_unlock(&pf->mbox.lock);
@@ -2634,11 +2650,14 @@ static int otx2_ndo_set_vf_trust(struct net_device *netdev, int vf,
 	pf->vf_configs[vf].trusted = enable;
 	rc = otx2_set_vf_permissions(pf, vf, OTX2_TRUSTED_VF);
 
-	if (rc)
+	if (rc) {
 		pf->vf_configs[vf].trusted = !enable;
-	else
+	} else {
 		netdev_info(pf->netdev, "VF %d is %strusted\n",
 			    vf, enable ? "" : "not ");
+		otx2_set_rx_mode(netdev);
+	}
+
 	return rc;
 }
 
-- 
2.43.0





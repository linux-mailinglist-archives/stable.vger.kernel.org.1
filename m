Return-Path: <stable+bounces-3301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3847FF4F4
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682392816F5
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0679154F96;
	Thu, 30 Nov 2023 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2OlWxHsb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB4495C2;
	Thu, 30 Nov 2023 16:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC11C433C8;
	Thu, 30 Nov 2023 16:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361483;
	bh=0hL5HU/GhR7gOlOG/8unorEWPiXJ/3plwU3+Agf+RHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2OlWxHsbUqQRDM4DzH9Auej0cZOz9pHDIwow8+rzxX/apKpLbJpfhOeJjK/oCoUV9
	 EROUlZXKoBw29B38KXQP0UHKKOK2hzO06HuU7ez6SeBu+DCerwT6lHZF8wlQIhVJcj
	 6P+Prv8Yg7FgcnLMmWgSwuDttOvmsPKymbIbehQI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suman Ghosh <sumang@marvell.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 041/112] octeontx2-pf: Fix ntuple rule creation to direct packet to VF with higher Rx queue than its PF
Date: Thu, 30 Nov 2023 16:21:28 +0000
Message-ID: <20231130162141.622394760@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
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

From: Suman Ghosh <sumang@marvell.com>

[ Upstream commit 4aa1d8f89b10cdc25a231dabf808d8935e0b137a ]

It is possible to add a ntuple rule which would like to direct packet to
a VF whose number of queues are greater/less than its PF's queue numbers.
For example a PF can have 2 Rx queues but a VF created on that PF can have
8 Rx queues. As of today, ntuple rule will reject rule because it is
checking the requested queue number against PF's number of Rx queues.
As a part of this fix if the action of a ntuple rule is to move a packet
to a VF's queue then the check is removed. Also, a debug information is
printed to aware user that it is user's responsibility to cross check if
the requested queue number on that VF is a valid one.

Fixes: f0a1913f8a6f ("octeontx2-pf: Add support for ethtool ntuple filters")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20231121165624.3664182-1-sumang@marvell.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../marvell/octeontx2/nic/otx2_flows.c        | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 4762dbea64a12..97a71e9b85637 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -1088,6 +1088,7 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
 	struct ethhdr *eth_hdr;
 	bool new = false;
 	int err = 0;
+	u64 vf_num;
 	u32 ring;
 
 	if (!flow_cfg->max_flows) {
@@ -1100,7 +1101,21 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
 	if (!(pfvf->flags & OTX2_FLAG_NTUPLE_SUPPORT))
 		return -ENOMEM;
 
-	if (ring >= pfvf->hw.rx_queues && fsp->ring_cookie != RX_CLS_FLOW_DISC)
+	/* Number of queues on a VF can be greater or less than
+	 * the PF's queue. Hence no need to check for the
+	 * queue count. Hence no need to check queue count if PF
+	 * is installing for its VF. Below is the expected vf_num value
+	 * based on the ethtool commands.
+	 *
+	 * e.g.
+	 * 1. ethtool -U <netdev> ... action -1  ==> vf_num:255
+	 * 2. ethtool -U <netdev> ... action <queue_num>  ==> vf_num:0
+	 * 3. ethtool -U <netdev> ... vf <vf_idx> queue <queue_num>  ==>
+	 *    vf_num:vf_idx+1
+	 */
+	vf_num = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
+	if (!is_otx2_vf(pfvf->pcifunc) && !vf_num &&
+	    ring >= pfvf->hw.rx_queues && fsp->ring_cookie != RX_CLS_FLOW_DISC)
 		return -EINVAL;
 
 	if (fsp->location >= otx2_get_maxflows(flow_cfg))
@@ -1182,6 +1197,9 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
 		flow_cfg->nr_flows++;
 	}
 
+	if (flow->is_vf)
+		netdev_info(pfvf->netdev,
+			    "Make sure that VF's queue number is within its queue limit\n");
 	return 0;
 }
 
-- 
2.42.0





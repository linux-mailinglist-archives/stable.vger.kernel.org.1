Return-Path: <stable+bounces-171328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 958FAB2A93E
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF054687DB3
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DB8322744;
	Mon, 18 Aug 2025 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GjoyOvOu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A881D88D7;
	Mon, 18 Aug 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525554; cv=none; b=E0P3/LYIK4Pg2ztcZnInxqgkps1tNNx90+iXcS0/VknlBprJHthB5uGgaGfPi5X6w7ZdqlZ9LLD7g2PBCtNxVS8UQJ5CfF0ERSQ9ZcqPeWtH7QFLCR/qK/aSiDuFJ0NajCaZqdVRCfi0CQgptRB0h3Suom66piyZvV5nHLW/Vds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525554; c=relaxed/simple;
	bh=DQQCjDj0Y0izkGtaeppQjbo6L3LH6AjgohxE692+TZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KadMSFzBSnIFQQmk5254JTUSRIC9Y9wjfNVIXX1j2jW/x/x58bTalcbnXjBGbL9Rna+lGfKtKsOANDzh64tEfn3HViTHuiF+Yv3tAVby7t2/ioR3tAzvYV64rfrcDU63VN3KYchEUjUTpNhtZrrLkk81f+5pCW4E51n+u4lG6XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GjoyOvOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD4EC4CEEB;
	Mon, 18 Aug 2025 13:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755525553;
	bh=DQQCjDj0Y0izkGtaeppQjbo6L3LH6AjgohxE692+TZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjoyOvOuL0t/ukBJUbYA6e8K8l9+X5mbERAyaOobBMxmgnB65WYSG6VBYliQSRBxw
	 99kwdu52EC6t/o0cQtnlK8ZNZZJx9wKi/IQTu+uWfebN4gP+vYDb+uC+h3t1gqhzjQ
	 4KiLgf9sb1MRUQuufy/fDFx7ue8Ej+q/c+6iVMW0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sarika Sharma <quic_sarishar@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 297/570] wifi: ath12k: Add memset and update default rate value in wmi tx completion
Date: Mon, 18 Aug 2025 14:44:44 +0200
Message-ID: <20250818124517.292144773@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sarika Sharma <quic_sarishar@quicinc.com>

[ Upstream commit 9903c0986f782dfc511d7638b6f15fb6e8600cd3 ]

When both AP/STA and monitor interfaces are enabled, ieee80211_tx_status()
is invoked from two paths: the TX completion handler for data frames
and the WMI TX completion handler for management frames.
In the data path, the skb->cb is properly zeroed using memset, but in
the WMI path, this step is missing.

As a result, mac80211 encountered uninitialized (junk) values in
skb->cb when generating the radiotap header for monitor mode, leading
to invalid radiotap lengths.

Hence, explicitly zero the status field in the skb->cb using memset
in WMI TX completion path to ensure consistent and correct behavior
during WMI tx completion path.

Additionally, set info->status.rates[0].idx = -1 to indicate that
no valid rate information is available, avoiding misinterpretation of
garbage values.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20250603063512.1887652-1-quic_sarishar@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 745d017c5aa8..1d0d4a668946 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6140,6 +6140,11 @@ static int wmi_process_mgmt_tx_comp(struct ath12k *ar, u32 desc_id,
 	dma_unmap_single(ar->ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 
 	info = IEEE80211_SKB_CB(msdu);
+	memset(&info->status, 0, sizeof(info->status));
+
+	/* skip tx rate update from ieee80211_status*/
+	info->status.rates[0].idx = -1;
+
 	if ((!(info->flags & IEEE80211_TX_CTL_NO_ACK)) && !status)
 		info->flags |= IEEE80211_TX_STAT_ACK;
 
-- 
2.39.5





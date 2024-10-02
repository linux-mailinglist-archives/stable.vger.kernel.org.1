Return-Path: <stable+bounces-79361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6C298D7D7
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6382835A1
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7381B1D0493;
	Wed,  2 Oct 2024 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RxC8Hna5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325331D0438;
	Wed,  2 Oct 2024 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877218; cv=none; b=NhNa4WNLfLcQB0XJJhFzwn7StO/ahwTAO/NOmurqzssQPOJyavqjRN/3ubtqUhvDIdFk44CLrhp97f+1PlapBGV3yUIvXLKgfprR8EHstFCHdZsHRqBYehJddZ8Z9MWjIyZqFrqSBGraJI8qtEJeoLLbkUIiYge54CaDsyHpk04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877218; c=relaxed/simple;
	bh=FVVogudkkw9VJRSYyZKUGrwPdCsLMvqXSIxNiFA0e2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQPmGYnUWBO3ytkQcRns7es5Q7O/DTzvKXQjdfJY1tuYgdv5eqfrADnNcm0AsQdKAUaaAQ8eokexc+s3YbpiMKwLjV383pdwZm9fvOFCnwmacnQZkdLD308USyV86lEXv7+W+YgnucTR2Q5bQKoPMFewAwnVh2iiuoTwqaTbdpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RxC8Hna5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0275C4CEC2;
	Wed,  2 Oct 2024 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877218;
	bh=FVVogudkkw9VJRSYyZKUGrwPdCsLMvqXSIxNiFA0e2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxC8Hna51JR/N9c++Rpebe4Q9TZaoPSIJMFVzw0bj2aBGqtFtjxxShLtkP0IhkJTb
	 1g2ANEBnenlUxPBh4pdwtFoYHHiO9bkODNY7JQo9B+L5pOaI5lu1jL8PtZiFN2dpzu
	 eKmEVQ8SE0AvIk5PS0V853NFpGV9oCj/tgO5QwSE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kang Yang <quic_kangyang@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 001/634] wifi: ath11k: use work queue to process beacon tx event
Date: Wed,  2 Oct 2024 14:51:41 +0200
Message-ID: <20241002125811.138111377@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kang Yang <quic_kangyang@quicinc.com>

[ Upstream commit 177b49dbf9c1d8f9f25a22ffafa416fc2c8aa6a3 ]

Commit 3a415daa3e8b ("wifi: ath11k: add P2P IE in beacon template")
from Feb 28, 2024 (linux-next), leads to the following Smatch static
checker warning:

drivers/net/wireless/ath/ath11k/wmi.c:1742 ath11k_wmi_p2p_go_bcn_ie()
warn: sleeping in atomic context

The reason is that ath11k_bcn_tx_status_event() will directly call might
sleep function ath11k_wmi_cmd_send() during RCU read-side critical
sections. The call trace is like:

ath11k_bcn_tx_status_event()
-> rcu_read_lock()
-> ath11k_mac_bcn_tx_event()
	-> ath11k_mac_setup_bcn_tmpl()
	……
		-> ath11k_wmi_bcn_tmpl()
			-> ath11k_wmi_cmd_send()
-> rcu_read_unlock()

Commit 886433a98425 ("ath11k: add support for BSS color change") added the
ath11k_mac_bcn_tx_event(), commit 01e782c89108 ("ath11k: fix warning
of RCU usage for ath11k_mac_get_arvif_by_vdev_id()") added the RCU lock
to avoid warning but also introduced this BUG.

Use work queue to avoid directly calling ath11k_mac_bcn_tx_event()
during RCU critical sections. No need to worry about the deletion of vif
because cancel_work_sync() will drop the work if it doesn't start or
block vif deletion until the running work is done.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Fixes: 3a415daa3e8b ("wifi: ath11k: add P2P IE in beacon template")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/2d277abd-5e7b-4da0-80e0-52bd96337f6e@moroto.mountain/
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240626053543.1946-1-quic_kangyang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 12 ++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c  |  4 +++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 141ba4487cb42..9d2d3a86abf17 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -396,6 +396,7 @@ struct ath11k_vif {
 	u8 bssid[ETH_ALEN];
 	struct cfg80211_bitrate_mask bitrate_mask;
 	struct delayed_work connection_loss_work;
+	struct work_struct bcn_tx_work;
 	int num_legacy_stations;
 	int rtscts_prot_mode;
 	int txpower;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index eaa53bc39ab2c..74719cb78888b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6599,6 +6599,16 @@ static int ath11k_mac_vdev_delete(struct ath11k *ar, struct ath11k_vif *arvif)
 	return ret;
 }
 
+static void ath11k_mac_bcn_tx_work(struct work_struct *work)
+{
+	struct ath11k_vif *arvif = container_of(work, struct ath11k_vif,
+						bcn_tx_work);
+
+	mutex_lock(&arvif->ar->conf_mutex);
+	ath11k_mac_bcn_tx_event(arvif);
+	mutex_unlock(&arvif->ar->conf_mutex);
+}
+
 static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
@@ -6637,6 +6647,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	arvif->vif = vif;
 
 	INIT_LIST_HEAD(&arvif->list);
+	INIT_WORK(&arvif->bcn_tx_work, ath11k_mac_bcn_tx_work);
 	INIT_DELAYED_WORK(&arvif->connection_loss_work,
 			  ath11k_mac_vif_sta_connection_loss_work);
 
@@ -6879,6 +6890,7 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	int i;
 
 	cancel_delayed_work_sync(&arvif->connection_loss_work);
+	cancel_work_sync(&arvif->bcn_tx_work);
 
 	mutex_lock(&ar->conf_mutex);
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 6ff01c45f1659..f50a4c0d4b2ba 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7404,7 +7404,9 @@ static void ath11k_bcn_tx_status_event(struct ath11k_base *ab, struct sk_buff *s
 		rcu_read_unlock();
 		return;
 	}
-	ath11k_mac_bcn_tx_event(arvif);
+
+	queue_work(ab->workqueue, &arvif->bcn_tx_work);
+
 	rcu_read_unlock();
 }
 
-- 
2.43.0





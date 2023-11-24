Return-Path: <stable+bounces-1305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B747F7F03
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F34CB218A2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA133E9;
	Fri, 24 Nov 2023 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QIt64ic+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B759835EE6;
	Fri, 24 Nov 2023 18:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BB8C433C7;
	Fri, 24 Nov 2023 18:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851068;
	bh=Y+TaBrh35AW57b/D5TKK5X96AhG5y+JSveGPAqwLADs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QIt64ic+uN1OUsF1AVc9jPStxjWcRr5I6Hp6mxWjX+zyudZdnoqNslEEb44pP7Sqx
	 iSIxFGsirNc4opoybE+1jCf5ly2V4ByhblKq00KaQbNkwyeZhOF9VUyQN6fs1MpTPi
	 ss4rfuo+8ZhdjczVYdstZ15ovUj2xJ1HFDbd9OMI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Carl Huang <quic_cjhuang@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>
Subject: [PATCH 6.5 276/491] wifi: ath11k: fix gtk offload status event locking
Date: Fri, 24 Nov 2023 17:48:32 +0000
Message-ID: <20231124172032.871025895@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit 1dea3c0720a146bd7193969f2847ccfed5be2221 upstream.

The ath11k active pdevs are protected by RCU but the gtk offload status
event handling code calling ath11k_mac_get_arvif_by_vdev_id() was not
marked as a read-side critical section.

Mark the code in question as an RCU read-side critical section to avoid
any potential use-after-free issues.

Compile tested only.

Fixes: a16d9b50cfba ("ath11k: support GTK rekey offload")
Cc: stable@vger.kernel.org      # 5.18
Cc: Carl Huang <quic_cjhuang@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20231019155342.31631-1-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8619,12 +8619,13 @@ static void ath11k_wmi_gtk_offload_statu
 		return;
 	}
 
+	rcu_read_lock();
+
 	arvif = ath11k_mac_get_arvif_by_vdev_id(ab, ev->vdev_id);
 	if (!arvif) {
 		ath11k_warn(ab, "failed to get arvif for vdev_id:%d\n",
 			    ev->vdev_id);
-		kfree(tb);
-		return;
+		goto exit;
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI, "event gtk offload refresh_cnt %d\n",
@@ -8641,6 +8642,8 @@ static void ath11k_wmi_gtk_offload_statu
 
 	ieee80211_gtk_rekey_notify(arvif->vif, arvif->bssid,
 				   (void *)&replay_ctr_be, GFP_ATOMIC);
+exit:
+	rcu_read_unlock();
 
 	kfree(tb);
 }




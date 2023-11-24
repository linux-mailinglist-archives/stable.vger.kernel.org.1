Return-Path: <stable+bounces-2266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4854B7F8374
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0459928819E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29563381D4;
	Fri, 24 Nov 2023 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0qwkMKM0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51502C1A2;
	Fri, 24 Nov 2023 19:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D7BC433C9;
	Fri, 24 Nov 2023 19:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853463;
	bh=AIvr32vQnv3Kqd0ZLyCSqni5vi/AIGnvZAquxB6yEgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0qwkMKM0auEXaQ6HVi0ZegCxKX28kIUOGqCdKu0AMltipKMyVZ6FT17+MkDDg6pp4
	 IU2lEMvggwJUd3AW+yKPmTHr86q2HhwDbb1iJb7GJHbj7tSnWUIrtkLRjqQQWCZiJq
	 YxtDOH3h3ocWE+zM7dxd+4s4JA9a4nCuVyJC6uqI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>
Subject: [PATCH 5.15 199/297] wifi: ath11k: fix temperature event locking
Date: Fri, 24 Nov 2023 17:54:01 +0000
Message-ID: <20231124172007.171970462@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit 1a5352a81b4720ba43d9c899974e3bddf7ce0ce8 upstream.

The ath11k active pdevs are protected by RCU but the temperature event
handling code calling ath11k_mac_get_ar_by_pdev_id() was not marked as a
read-side critical section as reported by RCU lockdep:

	=============================
	WARNING: suspicious RCU usage
	6.6.0-rc6 #7 Not tainted
	-----------------------------
	drivers/net/wireless/ath/ath11k/mac.c:638 suspicious rcu_dereference_check() usage!

	other info that might help us debug this:

	rcu_scheduler_active = 2, debug_locks = 1
	no locks held by swapper/0/0.
	...
	Call trace:
	...
	 lockdep_rcu_suspicious+0x16c/0x22c
	 ath11k_mac_get_ar_by_pdev_id+0x194/0x1b0 [ath11k]
	 ath11k_wmi_tlv_op_rx+0xa84/0x2c1c [ath11k]
	 ath11k_htc_rx_completion_handler+0x388/0x510 [ath11k]

Mark the code in question as an RCU read-side critical section to avoid
any potential use-after-free issues.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Fixes: a41d10348b01 ("ath11k: add thermal sensor device support")
Cc: stable@vger.kernel.org      # 5.7
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20231019153115.26401-2-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6855,15 +6855,19 @@ ath11k_wmi_pdev_temperature_event(struct
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
 		   "pdev temperature ev temp %d pdev_id %d\n", ev->temp, ev->pdev_id);
 
+	rcu_read_lock();
+
 	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
 	if (!ar) {
 		ath11k_warn(ab, "invalid pdev id in pdev temperature ev %d", ev->pdev_id);
-		kfree(tb);
-		return;
+		goto exit;
 	}
 
 	ath11k_thermal_event_temperature(ar, ev->temp);
 
+exit:
+	rcu_read_unlock();
+
 	kfree(tb);
 }
 




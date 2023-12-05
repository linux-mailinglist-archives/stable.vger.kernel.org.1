Return-Path: <stable+bounces-4317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D9F8046FB
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2B11C20DA9
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719E179F2;
	Tue,  5 Dec 2023 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x5iP57Tt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293CD6FB1;
	Tue,  5 Dec 2023 03:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FDDC433C7;
	Tue,  5 Dec 2023 03:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747218;
	bh=LRgqrEcPEr+78UTqC11IoE/fLC5lPF62E0o9wkk7hkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x5iP57TtQ7K4A1RNCAwJAh2qnH03UYpwuVItQAnToT56Q/+6J6wJPftiPx1mn3ymD
	 ZEYAmnOldf6iaP68RAXrTpsFPI8SStjq5ndClNmI7fzIrgNgwv81eZ0jc3n5pmWdeX
	 Ro4aMOSywGQ13TOsrIlxjqqCe7bwxKpLXAhXfMUM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Chen <free122448@hotmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 103/107] r8169: fix deadlock on RTL8125 in jumbo mtu mode
Date: Tue,  5 Dec 2023 12:17:18 +0900
Message-ID: <20231205031538.213032083@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
References: <20231205031531.426872356@linuxfoundation.org>
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

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 59d395ed606d8df14615712b0cdcdadb2d962175 ]

The original change results in a deadlock if jumbo mtu mode is used.
Reason is that the phydev lock is held when rtl_reset_work() is called
here, and rtl_jumbo_config() calls phy_start_aneg() which also tries
to acquire the phydev lock. Fix this by calling rtl_reset_work()
asynchronously.

Fixes: 621735f59064 ("r8169: fix rare issue with broken rx after link-down on RTL8125")
Reported-by: Ian Chen <free122448@hotmail.com>
Tested-by: Ian Chen <free122448@hotmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/caf6a487-ef8c-4570-88f9-f47a659faf33@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 7cb09ba14533c..abfa375b08878 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -576,6 +576,7 @@ struct rtl8169_tc_offsets {
 enum rtl_flag {
 	RTL_FLAG_TASK_ENABLED = 0,
 	RTL_FLAG_TASK_RESET_PENDING,
+	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
 	RTL_FLAG_TASK_TX_TIMEOUT,
 	RTL_FLAG_MAX
 };
@@ -4559,6 +4560,8 @@ static void rtl_task(struct work_struct *work)
 reset:
 		rtl_reset_work(tp);
 		netif_wake_queue(tp->dev);
+	} else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
+		rtl_reset_work(tp);
 	}
 out_unlock:
 	rtnl_unlock();
@@ -4592,7 +4595,7 @@ static void r8169_phylink_handler(struct net_device *ndev)
 	} else {
 		/* In few cases rx is broken after link-down otherwise */
 		if (rtl_is_8125(tp))
-			rtl_reset_work(tp);
+			rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE);
 		pm_runtime_idle(d);
 	}
 
-- 
2.42.0





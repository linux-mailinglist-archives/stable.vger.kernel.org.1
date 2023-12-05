Return-Path: <stable+bounces-4110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A603480460B
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AAB1F213B2
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40316FB8;
	Tue,  5 Dec 2023 03:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ojFLZMZp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A76FAF;
	Tue,  5 Dec 2023 03:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB621C433C7;
	Tue,  5 Dec 2023 03:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746644;
	bh=UdD6aXPOwv0MgBXjM3ZHp3ob7TFvzBIolb9bD/d5IX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ojFLZMZpblSwAkQ0Rj3UPo1xhtj8+m/5SQnG8wP77x/rk19RbW+59Zwjefl2M0I+5
	 tOjPRiW/fWw4rkHJeO3XaeVI1eZPAMOp5HskQDQ6wFonDXSsheD+vi8Hlg4vAKoDxb
	 /SjVRf5X/7H9tuqZ1IqPfzGM1xRUyYckqi5pzuIE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 102/134] ravb: Fix races between ravb_tx_timeout_work() and net related ops
Date: Tue,  5 Dec 2023 12:16:14 +0900
Message-ID: <20231205031541.874752866@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
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

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 9870257a0a338cd8d6c1cddab74e703f490f6779 ]

Fix races between ravb_tx_timeout_work() and functions of net_device_ops
and ethtool_ops by using rtnl_trylock() and rtnl_unlock(). Note that
since ravb_close() is under the rtnl lock and calls cancel_work_sync(),
ravb_tx_timeout_work() should calls rtnl_trylock(). Otherwise, a deadlock
may happen in ravb_tx_timeout_work() like below:

CPU0			CPU1
			ravb_tx_timeout()
			schedule_work()
...
__dev_close_many()
// Under rtnl lock
ravb_close()
cancel_work_sync()
// Waiting
			ravb_tx_timeout_work()
			rtnl_lock()
			// This is possible to cause a deadlock

If rtnl_trylock() fails, rescheduling the work with sleep for 1 msec.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20231127122420.3706751-1-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0ef0b88b71459..de12c02c55cbc 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1874,6 +1874,12 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 	struct net_device *ndev = priv->ndev;
 	int error;
 
+	if (!rtnl_trylock()) {
+		usleep_range(1000, 2000);
+		schedule_work(&priv->work);
+		return;
+	}
+
 	netif_tx_stop_all_queues(ndev);
 
 	/* Stop PTP Clock driver */
@@ -1907,7 +1913,7 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 		 */
 		netdev_err(ndev, "%s: ravb_dmac_init() failed, error %d\n",
 			   __func__, error);
-		return;
+		goto out_unlock;
 	}
 	ravb_emac_init(ndev);
 
@@ -1917,6 +1923,9 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 		ravb_ptp_init(ndev, priv->pdev);
 
 	netif_tx_start_all_queues(ndev);
+
+out_unlock:
+	rtnl_unlock();
 }
 
 /* Packet transmit function for Ethernet AVB */
-- 
2.42.0





Return-Path: <stable+bounces-26599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DE6870F4D
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA80B20EA0
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3722C78B4C;
	Mon,  4 Mar 2024 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TxRNng4Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69181C6AB;
	Mon,  4 Mar 2024 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589190; cv=none; b=qYSsLauyI99ym/XehOX+u3nz3zXGNQXEl9Wm6p5og1apzVni2/h2OUPThQij4tUYz1OqFKaRawMLu1UxP8jRr/G7q3ealzrfWKBCxlX5RsDC34k/S+FckcvY2cFhYir8O6VwqdfmTw7YCFXh7qjDYkR4BJQxK8TBX2BZO8bJ5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589190; c=relaxed/simple;
	bh=bYa5oSCTxZ6CZYnKQdQVTdw1X68k/2PR17RQUQHayfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tckwg8iUiSpEQ6k41DHf3eGSngrH5hs9gRtofveWRKfiPm57BRC7h8/1khOTNyoyB1ngzc9q7ykm71kL+CLsRSqkN6lqrf0UjnVXsNUfI6h3dYUIc9iepxS+JixagrMiyDB78yq8p3aM1Ab/CBRXCTzWGh+r7LWYHhPCm0quBqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TxRNng4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC1FC433F1;
	Mon,  4 Mar 2024 21:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709589189;
	bh=bYa5oSCTxZ6CZYnKQdQVTdw1X68k/2PR17RQUQHayfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TxRNng4Zr369E8jzqTpRhdjRJON8bPdPfK34bcWnUh80/RmSM0qAvbi73vP+Yx7n8
	 3s8B5K8KNclcUG4SXeRvV0nZ9mq/mECNBGGMjk75JU7n5K6upS6zEi0LyWgC9v7U2E
	 4LfDWXbyc6UzQkvSUN+qGyJUdXP0Q8bRQ9UintCE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Raczynski <j.raczynski@samsung.com>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 14/84] stmmac: Clear variable when destroying workqueue
Date: Mon,  4 Mar 2024 21:23:47 +0000
Message-ID: <20240304211542.819742853@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211542.332206551@linuxfoundation.org>
References: <20240304211542.332206551@linuxfoundation.org>
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

From: Jakub Raczynski <j.raczynski@samsung.com>

[ Upstream commit 8af411bbba1f457c33734795f024d0ef26d0963f ]

Currently when suspending driver and stopping workqueue it is checked whether
workqueue is not NULL and if so, it is destroyed.
Function destroy_workqueue() does drain queue and does clear variable, but
it does not set workqueue variable to NULL. This can cause kernel/module
panic if code attempts to clear workqueue that was not initialized.

This scenario is possible when resuming suspended driver in stmmac_resume(),
because there is no handling for failed stmmac_hw_setup(),
which can fail and return if DMA engine has failed to initialize,
and workqueue is initialized after DMA engine.
Should DMA engine fail to initialize, resume will proceed normally,
but interface won't work and TX queue will eventually timeout,
causing 'Reset adapter' error.
This then does destroy workqueue during reset process.
And since workqueue is initialized after DMA engine and can be skipped,
it will cause kernel/module panic.

To secure against this possible crash, set workqueue variable to NULL when
destroying workqueue.

Log/backtrace from crash goes as follows:
[88.031977]------------[ cut here ]------------
[88.031985]NETDEV WATCHDOG: eth0 (sxgmac): transmit queue 1 timed out
[88.032017]WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:477 dev_watchdog+0x390/0x398
           <Skipping backtrace for watchdog timeout>
[88.032251]---[ end trace e70de432e4d5c2c0 ]---
[88.032282]sxgmac 16d88000.ethernet eth0: Reset adapter.
[88.036359]------------[ cut here ]------------
[88.036519]Call trace:
[88.036523] flush_workqueue+0x3e4/0x430
[88.036528] drain_workqueue+0xc4/0x160
[88.036533] destroy_workqueue+0x40/0x270
[88.036537] stmmac_fpe_stop_wq+0x4c/0x70
[88.036541] stmmac_release+0x278/0x280
[88.036546] __dev_close_many+0xcc/0x158
[88.036551] dev_close_many+0xbc/0x190
[88.036555] dev_close.part.0+0x70/0xc0
[88.036560] dev_close+0x24/0x30
[88.036564] stmmac_service_task+0x110/0x140
[88.036569] process_one_work+0x1d8/0x4a0
[88.036573] worker_thread+0x54/0x408
[88.036578] kthread+0x164/0x170
[88.036583] ret_from_fork+0x10/0x20
[88.036588]---[ end trace e70de432e4d5c2c1 ]---
[88.036597]Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004

Fixes: 5a5586112b929 ("net: stmmac: support FPE link partner hand-shaking procedure")
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a1c1e353ca072..b0ab8f6986f8b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3825,8 +3825,10 @@ static void stmmac_fpe_stop_wq(struct stmmac_priv *priv)
 {
 	set_bit(__FPE_REMOVING, &priv->fpe_task_state);
 
-	if (priv->fpe_wq)
+	if (priv->fpe_wq) {
 		destroy_workqueue(priv->fpe_wq);
+		priv->fpe_wq = NULL;
+	}
 
 	netdev_info(priv->dev, "FPE workqueue stop");
 }
-- 
2.43.0





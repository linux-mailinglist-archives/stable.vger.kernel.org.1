Return-Path: <stable+bounces-58357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85A492B691
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB77285DCE
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1218158205;
	Tue,  9 Jul 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dMlTpeGY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B2F157E61;
	Tue,  9 Jul 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523695; cv=none; b=PBOlS4tZzXxAUVaOoZ1+rDKP2DAzwbHYovxV60McA5Fi068grW7LNVRwhzx411ZDXxnW/fO9qaIQCMvAVMCOD5cXE3Gvqzad0tbIz0hDkE7RVqtlS4juj3PgI36l7vDXEB/gJf/ZoTpYYRhe/9FfwFqZrSlkUha3qNPS2y0bjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523695; c=relaxed/simple;
	bh=reWQ8nfFn2msKkdj0q3ck+DzTVNLjgagfFu7VbNplmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJoCIpkyh/Oljh92XDuHmxpWoKvp10xD1na/i5V0mH21OkbSURtEXsqQFNEeaBLlJu2Fj3KrNX5ngbiuVNVMin2YpDMUiMj7LipPsJVAM5pKziSChsxxVS1In2ECiIcmPkUpuOAiPizGhgc3VZd6FA6vHHQjdCTZUdTBcZGUEG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dMlTpeGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9451C3277B;
	Tue,  9 Jul 2024 11:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720523695;
	bh=reWQ8nfFn2msKkdj0q3ck+DzTVNLjgagfFu7VbNplmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dMlTpeGYQFG/G8f03w0gvbiHTsrLb5EWO2E9B5S0R0QDcpmq+twnmmPSmZ/as+Sow
	 0fMjH44nkhIfH1SPiZBKjksZiMxvWgd8lUf6cwy0PYtVX5GpwYxzmhBZUVkIiJteHX
	 UB2smHIlKwuewhqjT0+P5Un3u4JZaOM3TTvw6IzY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jerry Dai <jerry.dai@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 076/139] net: ntb_netdev: Move ntb_netdev_rx_handler() to call netif_rx() from __netif_rx()
Date: Tue,  9 Jul 2024 13:09:36 +0200
Message-ID: <20240709110701.114292410@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
References: <20240709110658.146853929@linuxfoundation.org>
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

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit e15a5d821e5192a3769d846079bc9aa380139baf ]

The following is emitted when using idxd (DSA) dmanegine as the data
mover for ntb_transport that ntb_netdev uses.

[74412.546922] BUG: using smp_processor_id() in preemptible [00000000] code: irq/52-idxd-por/14526
[74412.556784] caller is netif_rx_internal+0x42/0x130
[74412.562282] CPU: 6 PID: 14526 Comm: irq/52-idxd-por Not tainted 6.9.5 #5
[74412.569870] Hardware name: Intel Corporation ArcherCity/ArcherCity, BIOS EGSDCRB1.E9I.1752.P05.2402080856 02/08/2024
[74412.581699] Call Trace:
[74412.584514]  <TASK>
[74412.586933]  dump_stack_lvl+0x55/0x70
[74412.591129]  check_preemption_disabled+0xc8/0xf0
[74412.596374]  netif_rx_internal+0x42/0x130
[74412.600957]  __netif_rx+0x20/0xd0
[74412.604743]  ntb_netdev_rx_handler+0x66/0x150 [ntb_netdev]
[74412.610985]  ntb_complete_rxc+0xed/0x140 [ntb_transport]
[74412.617010]  ntb_rx_copy_callback+0x53/0x80 [ntb_transport]
[74412.623332]  idxd_dma_complete_txd+0xe3/0x160 [idxd]
[74412.628963]  idxd_wq_thread+0x1a6/0x2b0 [idxd]
[74412.634046]  irq_thread_fn+0x21/0x60
[74412.638134]  ? irq_thread+0xa8/0x290
[74412.642218]  irq_thread+0x1a0/0x290
[74412.646212]  ? __pfx_irq_thread_fn+0x10/0x10
[74412.651071]  ? __pfx_irq_thread_dtor+0x10/0x10
[74412.656117]  ? __pfx_irq_thread+0x10/0x10
[74412.660686]  kthread+0x100/0x130
[74412.664384]  ? __pfx_kthread+0x10/0x10
[74412.668639]  ret_from_fork+0x31/0x50
[74412.672716]  ? __pfx_kthread+0x10/0x10
[74412.676978]  ret_from_fork_asm+0x1a/0x30
[74412.681457]  </TASK>

The cause is due to the idxd driver interrupt completion handler uses
threaded interrupt and the threaded handler is not hard or soft interrupt
context. However __netif_rx() can only be called from interrupt context.
Change the call to netif_rx() in order to allow completion via normal
context for dmaengine drivers that utilize threaded irq handling.

While the following commit changed from netif_rx() to __netif_rx(),
baebdf48c360 ("net: dev: Makes sure netif_rx() can be invoked in any context."),
the change should've been a noop instead. However, the code precedes this
fix should've been using netif_rx_ni() or netif_rx_any_context().

Fixes: 548c237c0a99 ("net: Add support for NTB virtual ethernet device")
Reported-by: Jerry Dai <jerry.dai@intel.com>
Tested-by: Jerry Dai <jerry.dai@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/20240701181538.3799546-1-dave.jiang@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ntb_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 536bd6564f8b8..dade51cf599c6 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -119,7 +119,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb->ip_summed = CHECKSUM_NONE;
 
-	if (__netif_rx(skb) == NET_RX_DROP) {
+	if (netif_rx(skb) == NET_RX_DROP) {
 		ndev->stats.rx_errors++;
 		ndev->stats.rx_dropped++;
 	} else {
-- 
2.43.0





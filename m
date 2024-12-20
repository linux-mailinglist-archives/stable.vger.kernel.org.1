Return-Path: <stable+bounces-105397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667269F8D82
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 08:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350DC164761
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 07:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FA7189BB3;
	Fri, 20 Dec 2024 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LAoiwnCa"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2FB17333D;
	Fri, 20 Dec 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734681404; cv=none; b=DaqMuHpRbPYI7itzWCU9NApZbDb2BkUMNdboSLSdLuuLF/p1SiJU/5g9qsXduihlt4Lr8vg1YD2FsV7Lv6sT4Xl2frRtsDB2ZmPQ7kE7+j1+zxKBQfsT5jyb8FdpImp2+uRSRnWAxtuiGem+cE2wyEA0J4bR+yc28aLv4ALqCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734681404; c=relaxed/simple;
	bh=L07KuzN1YDEdwpAUdA0s0itwegnBc//dmFKVTJ8Q+oQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SiC+4DQZV0B2+716rJe7oy5SsHLJcJlKySAiJQeYoFpkRfuxYOBKvLqbrXAbXD4ndidKdQEnN+5S+wZVWB0vScX72NO2B8zpmSFy81wNj2sCUZ3HtbFMriwDJ4MsfOMhr0bjNtK+rvyTsh78d/KcL3kQdNs5tpQWbnNmgfi05Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LAoiwnCa; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BK7uP75131959
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Dec 2024 01:56:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734681385;
	bh=2Bt4m09KXbqu6J6J7KVBHJ7tDcVAz605f/h9bU/fv88=;
	h=From:To:CC:Subject:Date;
	b=LAoiwnCaRBfMvDjpmf3HwaEo5No+5F+pLKXtPLWbM7B8xG4R7zDYcZvR/ofwC5BMz
	 IMAFle+3HuhYbeQEPAJn8sQG7TLH3hmK7f8b3Et8V0V8tcz7PKegE+aWdgZuTGSjPt
	 MEBSR1kC/5HG2cqYlpCvRUbT367PSyGd6WTWE4ig=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BK7uPa2008642;
	Fri, 20 Dec 2024 01:56:25 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Dec 2024 01:56:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Dec 2024 01:56:24 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BK7uJg3057628;
	Fri, 20 Dec 2024 01:56:20 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <rogerq@kernel.org>,
        <horms@kernel.org>, <dan.carpenter@linaro.org>, <c-vankar@ti.com>,
        <jpanis@baylibre.com>, <npitre@baylibre.com>
CC: <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH net] net: ethernet: ti: am65-cpsw: default to round-robin for host port receive
Date: Fri, 20 Dec 2024 13:26:14 +0530
Message-ID: <20241220075618.228202-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The Host Port (i.e. CPU facing port) of CPSW receives traffic from Linux
via TX DMA Channels which are Hardware Queues consisting of traffic
categorized according to their priority. The Host Port is configured to
dequeue traffic from these Hardware Queues on the basis of priority i.e.
as long as traffic exists on a Hardware Queue of a higher priority, the
traffic on Hardware Queues of lower priority isn't dequeued. An alternate
operation is also supported wherein traffic can be dequeued by the Host
Port in a Round-Robin manner.

Until [0], the am65-cpsw driver enabled a single TX DMA Channel, due to
which, unless modified by user via "ethtool", all traffic from Linux is
transmitted on DMA Channel 0. Therefore, configuring the Host Port for
priority based dequeuing or Round-Robin operation is identical since
there is a single DMA Channel.

Since [0], all 8 TX DMA Channels are enabled by default. Additionally,
the default "tc mapping" doesn't take into account the possibility of
different traffic profiles which various users might have. This results
in traffic starvation at the Host Port due to the priority based dequeuing
which has been enabled by default since the inception of the driver. The
traffic starvation triggers NETDEV WATCHDOG timeout for all TX DMA Channels
that haven't been serviced due to the presence of traffic on the higher
priority TX DMA Channels.

Fix this by defaulting to Round-Robin dequeuing at the Host Port, which
shall ensure that traffic is dequeued from all TX DMA Channels irrespective
of the traffic profile. This will address the NETDEV WATCHDOG timeouts.
At the same time, users can still switch from Round-Robin to Priority
based dequeuing at the Host Port with the help of the "p0-rx-ptype-rrobin"
private flag of "ethtool". Users are expected to setup an appropriate
"tc mapping" that suits their traffic profile when switching to priority
based dequeuing at the Host Port.

[0] commit be397ea3473d ("net: ethernet: am65-cpsw: Set default TX channels to maximum")
Fixes: be397ea3473d ("net: ethernet: am65-cpsw: Set default TX channels to maximum")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
8faabc041a00 Merge tag 'net-6.13-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
of Mainline Linux.

Regards,
Siddharth.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 14e1df721f2e..5465bf872734 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -3551,7 +3551,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 	init_completion(&common->tdown_complete);
 	common->tx_ch_num = AM65_CPSW_DEFAULT_TX_CHNS;
 	common->rx_ch_num_flows = AM65_CPSW_DEFAULT_RX_CHN_FLOWS;
-	common->pf_p0_rx_ptype_rrobin = false;
+	common->pf_p0_rx_ptype_rrobin = true;
 	common->default_vlan = 1;
 
 	common->ports = devm_kcalloc(dev, common->port_num,
-- 
2.43.0



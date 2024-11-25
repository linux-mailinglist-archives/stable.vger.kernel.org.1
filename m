Return-Path: <stable+bounces-95361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E499D8216
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 10:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2C1B2896B
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 09:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD913190692;
	Mon, 25 Nov 2024 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="a3wafdpP"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2F76026;
	Mon, 25 Nov 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526217; cv=none; b=aO6Wpnnj/p9fnIpdReSKmDkpUFGGtyfiHlrLLHLCO1UZONyQsWUa4K+DNPnILarS8kQYnwRCw14TCTvIXcY3w0xqGnZm/xczpqW8rThsaH/VeNAuVgePjM4cKaWOF+HavznzZqbty8iC/eC3jW4+I75FDvu60oj4mHXSvsORu54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526217; c=relaxed/simple;
	bh=Y74p5h63B8YlHWDy/ce7uQvyoMJg/1MjVN+VyHmPi+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jT4hbaj/1V9Fowi3rsOWutx1ZmhMWKXmy8AsdJ8G4BgEfDW7wbFeSM+oVszfsypctbKEuGryyTEhThtPZ7liP+FHwRsWTC0gGVQMpRyTptb4uJ4c8zbC1es0kwwVFVmytljl15MlLfxKwm8RxuVW+gvNpgDb+CmFMtZnrTOfuBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=a3wafdpP; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 54A4AA0895;
	Mon, 25 Nov 2024 10:16:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=BcIfIIITBoL48mjUW8ky
	myP9kexR3fKyrefe9Pm6zM8=; b=a3wafdpPiYdb5SyROAT/mIqgwPgTql325lQB
	7RWgp1bsT0Z3bZlsNyVkVmOFk/YY/LxwqA+LYp8TAiTQ+BbLK2XYIoO9RFR0FM/0
	sKGYRKiEYd4ToUUBXM0CmVs1X7sVHMYY/JaiIdKN7dfbEgawHgxOXYnQ2ZbUlji+
	Qn2ZTzn7It+Z21eE3tGvSplqNmw2sd87D1abT97DuDObeRUYuhhwPQNZM8IbYp+4
	s5WA8esSy1XjzHWVqTndjlvODpvJkJm1NMaTT1+c/n0T27IuIH0g86KBVMPXnFgG
	/zY5oNTwmNM9GjYMXD4b3j6kSe4wDQoW/aBkIzxtMfiSzp+zIZSrpIpIiSPvAnmm
	QsELPzCxqhGxyesVmbjd+85NoQ8TGkbMQKbTSlY20w5xpF8mDqGHPcOMIJH49lDQ
	tEHtPyOPRE0AxS670XbPOBAVKTi5QDlW/3ZmxmHtZJMAbg2uNKGKZbTXiq/oPBiC
	/mYx2nfTQNSULFelqcNt6cpj/x2kN7SDslCpIJNOLRBvuSNiTPnWpAZO07N57hJ6
	z74EtXc/jbEP05dvnlXDjvISxVJWW95g+IlgVgXRUE+zRL+G2idiN2nZl8ko2Epv
	mPef7033HWSyMsl0kW/VPbmxYDDOAWnVRypX+rSPMuIUWyxuB6zE+fQeFer9jALm
	epEXCB4=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Frank
 Li" <Frank.Li@nxp.com>, Rafael Beims <rafael.beims@toradex.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Paolo Abeni
	<pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team
	<linux-imx@nxp.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>
Subject: [PATCH 6.6 3/3] net: fec: make PPS channel configurable
Date: Mon, 25 Nov 2024 10:16:39 +0100
Message-ID: <20241125091639.2729916-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125091639.2729916-1-csokas.bence@prolan.hu>
References: <20241125091639.2729916-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732526207;VERSION=7980;MC=1988830740;ID=94030;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855607C67

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Depending on the SoC where the FEC is integrated into the PPS channel
might be routed to different timer instances. Make this configurable
from the devicetree.

When the related DT property is not present fallback to the previous
default and use channel 0.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Rafael Beims <rafael.beims@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

(cherry picked from commit 566c2d83887f0570056833102adc5b88e681b0c7)
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 37e1c895f1b8..7f6b57432071 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -523,8 +523,6 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 	unsigned long flags;
 	int ret = 0;
 
-	fep->pps_channel = DEFAULT_PPS_CHANNEL;
-
 	if (rq->type == PTP_CLK_REQ_PPS) {
 		fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
 
@@ -706,12 +704,16 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct device_node *np = fep->pdev->dev.of_node;
 	int irq;
 	int ret;
 
 	fep->ptp_caps.owner = THIS_MODULE;
 	strscpy(fep->ptp_caps.name, "fec ptp", sizeof(fep->ptp_caps.name));
 
+	fep->pps_channel = DEFAULT_PPS_CHANNEL;
+	of_property_read_u32(np, "fsl,pps-channel", &fep->pps_channel);
+
 	fep->ptp_caps.max_adj = 250000000;
 	fep->ptp_caps.n_alarm = 0;
 	fep->ptp_caps.n_ext_ts = 0;
-- 
2.34.1




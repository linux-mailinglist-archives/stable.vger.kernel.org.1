Return-Path: <stable+bounces-105030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FA19F5566
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15998177C59
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FC61F8938;
	Tue, 17 Dec 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="aWu94mcL"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7951F709A
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457860; cv=none; b=kx1Ch8rGqdQ0hb3Au7kRhNHUdRjBKgZhdGrIDVRjgf5jOKBAOoifaAfPuPskGdNZgbvL/ijY+RUQ4uQyWot0tA428RtnFgZb5H2ot9HqC14fwUE3Zfza1Nqf/l2PNIAQjgiSE1/TNpeiFiDrLRFfT1zrtuNUxAyNEbuXdGh2/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457860; c=relaxed/simple;
	bh=SO2/6RdTJZQ4nWgovKQYC9cxzKtOymQ4yQuG2Ycp80I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqOEeJMlOVW+Y/FKx3/fJMsB8m/tJUfhPRetfoyAl6M2OtN82ERldI2xbbKDaF9HJKna4CX1V0hPM3Z4kAQpB3ivYMlADc+08Fub4nO+Nk0WopOo3hatY8dR7skp81kr5WIMWGWBpGvS89iT9W/DUZzDs5gqTRsgRYKoeZEcM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=aWu94mcL; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0D366A0EA7;
	Tue, 17 Dec 2024 18:50:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=KFwwISF3N2I9Nwpx1P/a
	QoASwk1XWgtZt8HzJy20fiw=; b=aWu94mcLxRmY6y/hrfNz/zkLBAVtQIJ9d26X
	HnBrDZkgKY6onGsAXWUp/DY8dlQYpn0AeeTCHlkfNbMJtanXSr4/+czJHZq33LxG
	2kkxmZvNP35TsiAtZHJFK7Es7lENmIkwZbt/ygQBtQ36QoDQ7A2j5sjZM7r47Owv
	dRhl2lrscCDnOtNSFejKtnZObGtX5mC6IHxLP/j0q5jSoPyUbU1lfDmpGWTzKrD+
	u99t7o2qa5miCETLPjJ+QW86x77pcXDwUiZhu3wpieaEt3roZry5ru5YLlcEJGA0
	XTm89bk0r6zqC4vdBmJ6pXxKkc2fmCQvLfKnaxdtysBr6rdPLtssOdNA/pYWbDNu
	660VZLsR1aCSljUa9GNZBtk/x9oCIaSH+Pam3rVp6z9rydhHW++DfJMASSAJNkYg
	KBzEuCtEvo9jhWz/83c8chxE768hhKRwApqvVFm/zvLtihZCnSMEMPITi5Sp/A/d
	FNdA6saH1ie/vL2FWRWdiR4VJr90un68vZGE27dzWPiBBeZREY/fU3gNS4HdWFT5
	nGP5SfbUPu0sab3mFgeN0YDs+bcODr4Q7pL1kHJ3UOIhCeSpBJOV29WY3bDLHtxZ
	W1d/Gad5+GzfmXW/ER+gxHf3RUxfcxR4gP6N3eUHgRSfwFTqMPcWsuK0yLkxb7PR
	0/Cb+oo=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Frank Li
	<Frank.Li@nxp.com>, Rafael Beims <rafael.beims@toradex.com>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH 6.6 3/3] net: fec: make PPS channel configurable
Date: Tue, 17 Dec 2024 18:50:42 +0100
Message-ID: <20241217175042.284122-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217175042.284122-1-csokas.bence@prolan.hu>
References: <20241217175042.284122-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734457850;VERSION=7982;MC=2423810478;ID=67967;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD948556D766B

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




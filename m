Return-Path: <stable+bounces-96318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6129E1ED4
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1F1282D0D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAEE1CF8B;
	Tue,  3 Dec 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="rLoa0fnG"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1E71F470C
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235369; cv=none; b=jy4M6uqDVEK2m3mPufjlReClpPZUEUWeEZp54LBejG8mqk1dr0C+Vd/KdcrJrG8Td173EYmeq3P5zdsoySaBAroKnERdi49FsDn7qZMuEUNnCC8DxRYazjUhpTu5ypKLQQpKI7VjNBU8RLDm+a4iNovUJP6fQlTpSsdOqQhF5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235369; c=relaxed/simple;
	bh=SO2/6RdTJZQ4nWgovKQYC9cxzKtOymQ4yQuG2Ycp80I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgvZgzKFrN8FGZxfGG9OBpilhz+HZk2fcP01QRKdohgNysfMUY0EgTu6TVD7TwnPt7zVcnNEsa27ULvb69aHwlk8UFv2ys6mPCz30rd5LwiHrlSeMjmqd/1FPe3DOZ72HXO/mZQ8CqyUy93z5NFsT37yX2pRxu4IYVlm8ez3vu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=rLoa0fnG; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 99E75A0BB9;
	Tue,  3 Dec 2024 15:16:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=KFwwISF3N2I9Nwpx1P/a
	QoASwk1XWgtZt8HzJy20fiw=; b=rLoa0fnG2BMyGiAt1jzIhH/6OluR2DzcgMKl
	lp1CrI6TmBgEheLdffED9PGn+SqbtmPJeczmwiR/G6bHw/LXmv70vg9HKD602Ggh
	/sdgxe2ZximykZsFgyZwDXoERV1A9+UElZ7cKClZYymAkZSQ5rWvSVKFzoPVuVGk
	REYavgCSIukdRySRhQwFyNmd68yY8Tk4Nrr4VWJ9BcNg+RdBjBdQnaoltDJsfL2l
	inDafgHKWrZtS3VE33Gl2HTHuyY9/D3syeya3RsH1q/XVsHtY9OAd6jjRQ0EM1IA
	opSiZhgEPGpowWR1i3WS0wuRnrouKP/+IMR8yWTZLdTeVBYTBngtvmWBDCcPJmxJ
	tqRgzyiesmM2QfMfg09TFMUw9jzF0DT16PlKhyOgNCwCw5miX61e2ILpMLzXy59a
	uGNe6UIGtmqKAtjMD6AqARziXG0r17Wbeq5m4Vk45Hy4J68YKFw6vYOonyKgqq2q
	grrFonk/ArAZXrq7LpW0mbJyU/gydkNARWoqvG4AQnn/ogL7l+o0vRI/Cwa3mZCv
	VW6jJdSqOtmh5tiP/uR1cn5yzz5YSmokHVDiFMF8Sjyhg+7uLml4bGv6XAJQGJXu
	PCe66v8a/m44D/sp9rQdKfX04ylFYWX36qSLaQfAehQgbn92RK/93ICX2cpHbloj
	ispoHMQ=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Frank Li
	<Frank.Li@nxp.com>, Rafael Beims <rafael.beims@toradex.com>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH 6.11 v4 3/3] net: fec: make PPS channel configurable
Date: Tue, 3 Dec 2024 15:16:00 +0100
Message-ID: <20241203141600.3600561-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203141600.3600561-1-csokas.bence@prolan.hu>
References: <20241203141600.3600561-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733235363;VERSION=7982;MC=2483758140;ID=166217;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637D67

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




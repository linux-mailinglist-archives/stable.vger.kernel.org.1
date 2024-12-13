Return-Path: <stable+bounces-104018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6369F0B06
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5341620C3
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59D41DCB09;
	Fri, 13 Dec 2024 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Ts1VESye"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB7E1DEFC1
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089405; cv=none; b=rlDI9TncsVqQUqHfJI77HMJDmJn55LGc8kV2XvOgQOWvRMsgxK0CzAbftCYqwjSPJQecHo2642kqkUWn1qhRD15jYx+e8Qi4RdLjtUHTGm41HZevWYFq1gLhYWjf6KrbkJxJTQahVaNgsAGVDyHjgilklvE9NsSgFZ3A1UsZ7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089405; c=relaxed/simple;
	bh=SO2/6RdTJZQ4nWgovKQYC9cxzKtOymQ4yQuG2Ycp80I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgL5LqRdoaXDqQXEnBi9zQriHSRT8yNhWHUbidD1ViWS0It/izESMG8yC5z8v8EOw0A54yjXPQUcmmqxis8/UV6gyfbG0mrzLHcPNh9iCocnWPPyVuogrzURUznmZ0ecjiqU4GPqfxFlIvySKqLwudwYinikZtyYvrFQOnXhd3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Ts1VESye; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 3CDB7A0B13;
	Fri, 13 Dec 2024 12:30:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=KFwwISF3N2I9Nwpx1P/a
	QoASwk1XWgtZt8HzJy20fiw=; b=Ts1VESyewshNp60ZtoyqdF8IEzHa+jx3T2Cz
	a2XLWEcWg8T9ePB3vi103NLm6z6gplqX3D09LSD9A/ZhfgO6vt3m2somQmThwwRg
	WIHfLLHLu3lwaXGYW25WqCIm1qRHnUrPBFMiCscc2iGr7Zi94wHHBrPwSOyR2t5R
	BtvPG7gqxGOP/W5Fzl+dSSJWInUAi8VxbkFrnXh303VBhvuqZ5vvV5mfjLXp0Ir0
	80Ng6hpgs4Zk7znVFD9c7yYnPY9pvVVub3c87Rv/eGKBeqZzFYI3UcVfHMElfL/l
	Zh1bYzUWV2dJ00xKd5RAR+GWuG3cYNIMrO/QnIBDK8XyfIoF8PsRqPHorwP24i1n
	RqcJRYNoGZyUMB/RtcCj/QXs2/CMkVFDvmN75PTn82Nz8APPHcMPzMKRYsabIST5
	rSWz1q6+5c8FBjAuTq8P3nCnY/TeODvQdNK/samdZMklkQAdH7EXy4oSn27uiKy+
	d81lVB0lmRiPqp6sBlNrxBq+e3PZlINI31c2yBKf25yaLIcsVlEREkiDObuZHAPw
	B6IUv3nfy29GymFttIlmyWP56MJNkkH4OKaJw8yj+wbKPwXDSHJLFOfiWq0lMwmC
	OSeFissG+FuG9305nHnwwARROZOJqynE2MIhZ6VA94lyL/KClGF1+fhEXLa0X8Dc
	iDJiyx8=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Frank Li
	<Frank.Li@nxp.com>, Rafael Beims <rafael.beims@toradex.com>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH 6.11 v4 3/3] net: fec: make PPS channel configurable
Date: Fri, 13 Dec 2024 12:29:26 +0100
Message-ID: <20241213112926.44468-8-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213112926.44468-1-csokas.bence@prolan.hu>
References: <20241213112926.44468-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734089399;VERSION=7982;MC=3811687430;ID=408622;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855627C65

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




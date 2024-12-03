Return-Path: <stable+bounces-96275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B499E1A01
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A51B350D9
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC641E1C3E;
	Tue,  3 Dec 2024 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Tv54ZrA5"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6401E0B6C
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221784; cv=none; b=thsIVrLdxU62W+LkwEQQXDu94wtEpIWIunrpUcscKXPgRdx4TkAS+x9kNEvK/BmHPDum51yQY2gax3afXXbVE8tglZEICp4qof8Udm4Xv1YUs1RWQISXZIJJTLAIBhIsmRDW0I75b7X5CB5i5GFu6r6XqB0oVG5G8aMj9JHsw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221784; c=relaxed/simple;
	bh=SO2/6RdTJZQ4nWgovKQYC9cxzKtOymQ4yQuG2Ycp80I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWbGsuNFhVJyzA7mCMMRCnx32x6aGFwtoz4BRWNOBz1sELE+D2iD5CxkceBGKEtG9n0TTlM1j/M4hAScWFxTLSlBdqLsn5v++VxV+PfN5tLLhTIwmdlBcaQVDC8nrCMXvvJo8FWajAEfl6x83twYxTLh3ScQFOXNywv2cW14cqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Tv54ZrA5; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id BE242A0029;
	Tue,  3 Dec 2024 11:29:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=KFwwISF3N2I9Nwpx1P/a
	QoASwk1XWgtZt8HzJy20fiw=; b=Tv54ZrA5DxEadGJTqWiNvmBuZv8RwH5PXayZ
	4iD5fWP2QYjYUpd+O7H4XW5UUeXfUoCFL7s5nwn9Gjk7Tf9oc5tmMuAmsRjK/qLN
	oX5FXZkLm4F/sA1GfaL9P09hsJoe7ljLhznRZLF/kli9au3Ll4h6GHViI3TqE/3w
	uSJPxxk0s85Tv+k+cLaJz4GEVQZIiiDQXN8ASzD7tsUrq//+E6NVaYjxcOGc1fjb
	sn5C+HE9H1R0n04GYGH3900y62O5grAmIHjP9lN7bvb8yg6HT+XWrUwdjyruojba
	+6oArMBqD6GgTheXRz3QfSdPYOqpX/6M7hucdi25yt7hK30GOFeEHCpuKrlEaiP3
	RTwud72EHDrFzjWCle+0rcAwFnArs3B9G1+CGVT/EIuVl9asPh64JVkMNAsAsJrP
	zP9muB3mW4VGW++4aktDhvvvZ7+5/0BT0o8pf90JVV36l8sP1bvG9FGDZmaKELbj
	imSAvtWhBzVlfKIbyY3BBDAzxt3Xe3Uyp0hlt6yYhI17NLEUxQrZ7IjpcBwpVNui
	jsXu6YAROIRlAlplkR97hN5V9FBx/zTHR3neRJVnSi4HQlmumjZl4CZuwiJT28no
	SUH2gG7kvnwj4IThraXnhXyWM0IQekNNLkjMaV6n+0Tg6Pl/2EB9r9WIVj4VJ8Z0
	WcJ0Zio=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Frank Li
	<Frank.Li@nxp.com>, Rafael Beims <rafael.beims@toradex.com>
Subject: [PATCH 6.12 v4 3/3] net: fec: make PPS channel configurable
Date: Tue, 3 Dec 2024 11:29:32 +0100
Message-ID: <20241203102932.3581093-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203102932.3581093-1-csokas.bence@prolan.hu>
References: <20241203102932.3581093-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733221773;VERSION=7982;MC=1818435781;ID=156228;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855637D61

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




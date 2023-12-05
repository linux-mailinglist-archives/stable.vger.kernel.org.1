Return-Path: <stable+bounces-4215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8623680468B
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 193A9B20C9F
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810D879F2;
	Tue,  5 Dec 2023 03:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YFT2tIrr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4134D6FAF;
	Tue,  5 Dec 2023 03:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4848C433C7;
	Tue,  5 Dec 2023 03:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746936;
	bh=7cDzQRqrVgMWrSabKq25RjFf9dWUtFswEHqpBw2Q1A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFT2tIrrTrBcFrF/EYIeIn6CyJVwezAYf3v+XikiQE2XlBoc6lo2WYl2QSQYlaMCM
	 BJPHw+J2VIjJ8bLonYhuOH8cBURkBercrKbIr/Da7XFORrCmJRuE9J/fx9Sfdv8Eje
	 EvhD17H2ftGUyzBwkmJpfjvTUQjO1zU7Hr3dfQHc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 48/71] net: ravb: Start TX queues after HW initialization succeeded
Date: Tue,  5 Dec 2023 12:16:46 +0900
Message-ID: <20231205031520.648091440@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031517.859409664@linuxfoundation.org>
References: <20231205031517.859409664@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit 6f32c086602050fc11157adeafaa1c1eb393f0af ]

ravb_phy_start() may fail. If that happens, the TX queues will remain
started. Thus, move the netif_tx_start_all_queues() after PHY is
successfully initialized.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e3eedb3e72156..d70c82c926ea1 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1392,13 +1392,13 @@ static int ravb_open(struct net_device *ndev)
 	if (priv->chip_id == RCAR_GEN2)
 		ravb_ptp_init(ndev, priv->pdev);
 
-	netif_tx_start_all_queues(ndev);
-
 	/* PHY control start */
 	error = ravb_phy_start(ndev);
 	if (error)
 		goto out_ptp_stop;
 
+	netif_tx_start_all_queues(ndev);
+
 	return 0;
 
 out_ptp_stop:
-- 
2.42.0





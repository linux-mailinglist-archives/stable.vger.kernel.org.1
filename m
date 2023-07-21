Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D5875D416
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjGUTRo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjGUTRn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:17:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757AE30ED
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:17:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCD6761D70
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9E2C433C8;
        Fri, 21 Jul 2023 19:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967058;
        bh=FIE3/D9OrZ5uH+sU0DI4Nm49GNzophq9am5GziQGifQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=skFyqWooX9Ceh0kJ/9JnDyh+WJCbG99Vr1akqTm3rKx0gaw21rnwk6LdClTvXiUVk
         2WRF7SxkUHWSet19E+vc707Qoj0Hxgix1z+airFMb42uGCqYpXfpkf9WsLHp8STGfM
         2cLYV6Oaa1A76BtbG1l3DXsTorzvK/kxtBx7w6Wk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Naveen Mamindlapalli <naveenm@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Sai Krishna <saikrishnag@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 030/223] octeontx2-af: Move validation of ptp pointer before its usage
Date:   Fri, 21 Jul 2023 18:04:43 +0200
Message-ID: <20230721160522.153919080@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sai Krishna <saikrishnag@marvell.com>

[ Upstream commit 7709fbd4922c197efabda03660d93e48a3e80323 ]

Moved PTP pointer validation before its use to avoid smatch warning.
Also used kzalloc/kfree instead of devm_kzalloc/devm_kfree.

Fixes: 2ef4e45d99b1 ("octeontx2-af: Add PTP PPS Errata workaround on CN10K silicon")
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/ptp.c   | 19 +++++++++----------
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
index 3411e2e47d46b..0ee420a489fc4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -208,7 +208,7 @@ struct ptp *ptp_get(void)
 	/* Check driver is bound to PTP block */
 	if (!ptp)
 		ptp = ERR_PTR(-EPROBE_DEFER);
-	else
+	else if (!IS_ERR(ptp))
 		pci_dev_get(ptp->pdev);
 
 	return ptp;
@@ -388,11 +388,10 @@ static int ptp_extts_on(struct ptp *ptp, int on)
 static int ptp_probe(struct pci_dev *pdev,
 		     const struct pci_device_id *ent)
 {
-	struct device *dev = &pdev->dev;
 	struct ptp *ptp;
 	int err;
 
-	ptp = devm_kzalloc(dev, sizeof(*ptp), GFP_KERNEL);
+	ptp = kzalloc(sizeof(*ptp), GFP_KERNEL);
 	if (!ptp) {
 		err = -ENOMEM;
 		goto error;
@@ -428,20 +427,19 @@ static int ptp_probe(struct pci_dev *pdev,
 	return 0;
 
 error_free:
-	devm_kfree(dev, ptp);
+	kfree(ptp);
 
 error:
 	/* For `ptp_get()` we need to differentiate between the case
 	 * when the core has not tried to probe this device and the case when
-	 * the probe failed.  In the later case we pretend that the
-	 * initialization was successful and keep the error in
+	 * the probe failed.  In the later case we keep the error in
 	 * `dev->driver_data`.
 	 */
 	pci_set_drvdata(pdev, ERR_PTR(err));
 	if (!first_ptp_block)
 		first_ptp_block = ERR_PTR(err);
 
-	return 0;
+	return err;
 }
 
 static void ptp_remove(struct pci_dev *pdev)
@@ -449,16 +447,17 @@ static void ptp_remove(struct pci_dev *pdev)
 	struct ptp *ptp = pci_get_drvdata(pdev);
 	u64 clock_cfg;
 
-	if (cn10k_ptp_errata(ptp) && hrtimer_active(&ptp->hrtimer))
-		hrtimer_cancel(&ptp->hrtimer);
-
 	if (IS_ERR_OR_NULL(ptp))
 		return;
 
+	if (cn10k_ptp_errata(ptp) && hrtimer_active(&ptp->hrtimer))
+		hrtimer_cancel(&ptp->hrtimer);
+
 	/* Disable PTP clock */
 	clock_cfg = readq(ptp->reg_base + PTP_CLOCK_CFG);
 	clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
 	writeq(clock_cfg, ptp->reg_base + PTP_CLOCK_CFG);
+	kfree(ptp);
 }
 
 static const struct pci_device_id ptp_id_table[] = {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 873f081c030de..733add3a9dc6b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3244,7 +3244,7 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rvu->ptp = ptp_get();
 	if (IS_ERR(rvu->ptp)) {
 		err = PTR_ERR(rvu->ptp);
-		if (err == -EPROBE_DEFER)
+		if (err)
 			goto err_release_regions;
 		rvu->ptp = NULL;
 	}
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B793A72C1E5
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbjFLLBP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbjFLLBA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:01:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7EC468A
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:47:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 099AE624AA
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5E8C433EF;
        Mon, 12 Jun 2023 10:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566877;
        bh=eUhqsSmzggIrKPDcKi1Xno3HKSVOEd0zIZdAa5NolRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z0pccIF2CDyyO2eW0G+TDXRMBPPmhXFPpLvm+CM5ytPsCvQNPneUZ34hgG4IZrgM2
         XBCTi5JBElMx8vWRAvSqmb2s2HwxtpE0122zURAAbpL0RrffzwcbhURpuKt5Y556Yc
         8HjY1j6CgrqxGSLkeGE8oJRui/nMr0p6sJiMxuCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 066/160] bnxt_en: Skip firmware fatal error recovery if chip is not accessible
Date:   Mon, 12 Jun 2023 12:26:38 +0200
Message-ID: <20230612101718.030516618@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vikas Gupta <vikas.gupta@broadcom.com>

[ Upstream commit 83474a9b252ab23e6003865c2775024344cb9c09 ]

Driver starts firmware fatal error recovery by detecting
heartbeat failure or fw reset count register changing.  But
these checks are not reliable if the device is not accessible.
This can happen while DPC (Downstream Port containment) is in
progress.  Skip firmware fatal recovery if pci_device_is_present()
returns false.

Fixes: acfb50e4e773 ("bnxt_en: Add FW fatal devlink_health_reporter.")
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d974cfdbc9378..48753ebe79c37 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11628,6 +11628,7 @@ static void bnxt_tx_timeout(struct net_device *dev, unsigned int txqueue)
 static void bnxt_fw_health_check(struct bnxt *bp)
 {
 	struct bnxt_fw_health *fw_health = bp->fw_health;
+	struct pci_dev *pdev = bp->pdev;
 	u32 val;
 
 	if (!fw_health->enabled || test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
@@ -11641,7 +11642,7 @@ static void bnxt_fw_health_check(struct bnxt *bp)
 	}
 
 	val = bnxt_fw_health_readl(bp, BNXT_FW_HEARTBEAT_REG);
-	if (val == fw_health->last_fw_heartbeat) {
+	if (val == fw_health->last_fw_heartbeat && pci_device_is_present(pdev)) {
 		fw_health->arrests++;
 		goto fw_reset;
 	}
@@ -11649,7 +11650,7 @@ static void bnxt_fw_health_check(struct bnxt *bp)
 	fw_health->last_fw_heartbeat = val;
 
 	val = bnxt_fw_health_readl(bp, BNXT_FW_RESET_CNT_REG);
-	if (val != fw_health->last_fw_reset_cnt) {
+	if (val != fw_health->last_fw_reset_cnt && pci_device_is_present(pdev)) {
 		fw_health->discoveries++;
 		goto fw_reset;
 	}
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB07B87BC
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbjJDSIn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243861AbjJDSIn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:08:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3AAA6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:08:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13120C433C9;
        Wed,  4 Oct 2023 18:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442919;
        bh=/A0e/x31ER1OE7lRVHaKKPyhf10z4MOpxiJCaRAEhdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Es+P27bumq/AEqWmVsUkTZcJ1UGVZYK1mQYbmxHIKAQ/aLp61SeNFLlKSr8JT5XiI
         VkqK5BmDg0clCTZVelkkrwkGxyBaQoNrTBCnURFvaiAGynfvCw1bVheYcVbmUUUdBS
         Caal0wRaED+2p3PDhZupF+DQwY5EC7yWLzqTQQwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michal Grzedzicki <mge@meta.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 127/183] scsi: pm80xx: Use phy-specific SAS address when sending PHY_START command
Date:   Wed,  4 Oct 2023 19:55:58 +0200
Message-ID: <20231004175209.273501240@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Grzedzicki <mge@meta.com>

[ Upstream commit 71996bb835aed58c7ec4967be1d05190a27339ec ]

Some cards have more than one SAS address. Using an incorrect address
causes communication issues with some devices like expanders.

Closes: https://lore.kernel.org/linux-kernel/A57AEA84-5CA0-403E-8053-106033C73C70@fb.com/
Signed-off-by: Michal Grzedzicki <mge@meta.com>
Link: https://lore.kernel.org/r/20230913155611.3183612-1-mge@meta.com
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 32fc450bf84b4..352705e023c83 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4402,7 +4402,7 @@ pm8001_chip_phy_start_req(struct pm8001_hba_info *pm8001_ha, u8 phy_id)
 	payload.sas_identify.dev_type = SAS_END_DEVICE;
 	payload.sas_identify.initiator_bits = SAS_PROTOCOL_ALL;
 	memcpy(payload.sas_identify.sas_addr,
-		pm8001_ha->sas_addr, SAS_ADDR_SIZE);
+		&pm8001_ha->phy[phy_id].dev_sas_addr, SAS_ADDR_SIZE);
 	payload.sas_identify.phy_id = phy_id;
 	ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opcode, &payload,
 			sizeof(payload), 0);
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 04746df26c6c9..ea305d093c871 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -4814,7 +4814,7 @@ pm80xx_chip_phy_start_req(struct pm8001_hba_info *pm8001_ha, u8 phy_id)
 	payload.sas_identify.dev_type = SAS_END_DEVICE;
 	payload.sas_identify.initiator_bits = SAS_PROTOCOL_ALL;
 	memcpy(payload.sas_identify.sas_addr,
-	  &pm8001_ha->sas_addr, SAS_ADDR_SIZE);
+		&pm8001_ha->phy[phy_id].dev_sas_addr, SAS_ADDR_SIZE);
 	payload.sas_identify.phy_id = phy_id;
 	ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opcode, &payload,
 			sizeof(payload), 0);
-- 
2.40.1




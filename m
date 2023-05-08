Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4A26FA505
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjEHKFV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjEHKFU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:05:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28062EB3F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FE5062330
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C93EC433D2;
        Mon,  8 May 2023 10:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540318;
        bh=OhNI5HEa+rGIUEheh2coeEnfiuQZ0gvqR6VgGIFhOtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=csAuQ6dqe4PP+N8f1K3Mzl0f8bhdtVsYT0zNPMkV/ZHQZO62zlsT5yOc95Ddt7uR+
         TknVRQqmQiT3z/t13QwZuDxtq4/Vsrg7lKO8nWMb6Z611/FlJ7IV4oVRLSA3F5QXkj
         XfSckJj69omMV3O+sBU5MQtUKMa1qQiV+tS+33F0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 312/611] scsi: libsas: Add sas_ata_device_link_abort()
Date:   Mon,  8 May 2023 11:42:34 +0200
Message-Id: <20230508094432.575868945@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: John Garry <john.garry@huawei.com>

[ Upstream commit 44112922674b94a7d699dfff6307fc830018df7c ]

Similar to how AHCI handles NCQ errors in ahci_error_intr() ->
ata_port_abort() -> ata_do_link_abort(), add an NCQ error handler for LLDDs
to call to initiate a link abort.

This will mark all outstanding QCs as failed and kick-off EH.

Note:

A "force reset" argument is added for drivers which require the ATA error
handling to always reset the device.

A driver may require this feature for when SATA device per-SCSI cmnd
resources are only released during reset for ATA EH. As such, we need an
option to force reset to be done, regardless of what any EH autopsy
decides.

The SATA device FIS fields are set to indicate a device error from
ata_eh_analyze_tf().

Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Suggested-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Link: https://lore.kernel.org/r/1665998435-199946-2-git-send-email-john.garry@huawei.com
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Tested-by: Niklas Cassel <niklas.cassel@wdc.com> # pm80xx
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: bb544224da77 ("scsi: hisi_sas: Handle NCQ error when IPTT is valid")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libsas/sas_ata.c | 15 +++++++++++++++
 include/scsi/sas_ata.h        |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 2fd55ef9ffca5..a34d06fd47f06 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -886,6 +886,21 @@ void sas_ata_wait_eh(struct domain_device *dev)
 	ata_port_wait_eh(ap);
 }
 
+void sas_ata_device_link_abort(struct domain_device *device, bool force_reset)
+{
+	struct ata_port *ap = device->sata_dev.ap;
+	struct ata_link *link = &ap->link;
+
+	device->sata_dev.fis[2] = ATA_ERR | ATA_DRDY; /* tf status */
+	device->sata_dev.fis[3] = ATA_ABORTED; /* tf error */
+
+	link->eh_info.err_mask |= AC_ERR_DEV;
+	if (force_reset)
+		link->eh_info.action |= ATA_EH_RESET;
+	ata_link_abort(link);
+}
+EXPORT_SYMBOL_GPL(sas_ata_device_link_abort);
+
 int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
 {
 	struct sas_tmf_task tmf_task = {};
diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
index ec646217e7f6e..e7d466df81576 100644
--- a/include/scsi/sas_ata.h
+++ b/include/scsi/sas_ata.h
@@ -32,6 +32,7 @@ void sas_probe_sata(struct asd_sas_port *port);
 void sas_suspend_sata(struct asd_sas_port *port);
 void sas_resume_sata(struct asd_sas_port *port);
 void sas_ata_end_eh(struct ata_port *ap);
+void sas_ata_device_link_abort(struct domain_device *dev, bool force_reset);
 int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
 			int force_phy_id);
 int sas_ata_wait_after_reset(struct domain_device *dev, unsigned long deadline);
@@ -88,6 +89,11 @@ static inline void sas_ata_end_eh(struct ata_port *ap)
 {
 }
 
+static inline void sas_ata_device_link_abort(struct domain_device *dev,
+					     bool force_reset)
+{
+}
+
 static inline int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
 				      int force_phy_id)
 {
-- 
2.39.2




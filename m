Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF266FA651
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbjEHKS3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbjEHKSL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01452D2DA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:18:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBF4E61035
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0790C433D2;
        Mon,  8 May 2023 10:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541089;
        bh=QvDiN8d/mMGJ07zgJtp6pyLoUdXXmYRuk4pUB9u+l6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VpOJFCFfbRT4T9/K8qLHsfVgfM5fR9sXK2JtYZH1rasf2TRESgIXnXtTKDJRQ4u+b
         0e4Wr5Xd6WjBh0/QClioBW5GNW10nDP0vqD6Iruu6Rkq2sh7r1+IQGNpV1pl23FF6E
         +mn5jD0s3rxLPRJMU9XTTMmtUTEBEm9YYd7oOk3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xingui Yang <yangxingui@huawei.com>,
        John Garry <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 611/611] scsi: libsas: Grab the ATA port lock in sas_ata_device_link_abort()
Date:   Mon,  8 May 2023 11:47:33 +0200
Message-Id: <20230508094441.766917233@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xingui Yang <yangxingui@huawei.com>

commit a67aad57d9aee41180aff36e54cb72fe4b8d5a5a upstream.

Grab the ATA port lock in sas_ata_device_link_abort() before calling
ata_link_abort() as outlined in this function's locking requirements.

Fixes: 44112922674b ("scsi: libsas: Add sas_ata_device_link_abort()")
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/libsas/sas_ata.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -890,7 +890,9 @@ void sas_ata_device_link_abort(struct do
 {
 	struct ata_port *ap = device->sata_dev.ap;
 	struct ata_link *link = &ap->link;
+	unsigned long flags;
 
+	spin_lock_irqsave(ap->lock, flags);
 	device->sata_dev.fis[2] = ATA_ERR | ATA_DRDY; /* tf status */
 	device->sata_dev.fis[3] = ATA_ABORTED; /* tf error */
 
@@ -898,6 +900,7 @@ void sas_ata_device_link_abort(struct do
 	if (force_reset)
 		link->eh_info.action |= ATA_EH_RESET;
 	ata_link_abort(link);
+	spin_unlock_irqrestore(ap->lock, flags);
 }
 EXPORT_SYMBOL_GPL(sas_ata_device_link_abort);
 



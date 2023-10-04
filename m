Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD267B8A4D
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244091AbjJDSeK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243557AbjJDSeJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:34:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921F198
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:34:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D789FC433C7;
        Wed,  4 Oct 2023 18:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444445;
        bh=oU9TWetjfJmo7F1IAxTabdG6fyCQGgTwWSKZtXkqU/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b/W/34NE6WKhSBOQJPXysnlTT8nHFN/eeYEsC+ZyHALAVs6EPYqjvK6w7UC+RI5Va
         fjzc46jM8qRtSBCWmc0NqClHVUpgz8uGX1JMwUCaBp8KiAPozyKWQr+BsMf6mxKAhu
         M84VJ7a4zflaYqcOxuGYvD584hxtTfFB6qTDnrJc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John David Anglin <dave.anglin@bell.net>,
        Damien Le Moal <dlemoal@kernel.org>,
        David Gow <david@davidgow.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.5 253/321] scsi: core: ata: Do no try to probe for CDL on old drives
Date:   Wed,  4 Oct 2023 19:56:38 +0200
Message-ID: <20231004175240.982498492@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit 2132df16f53b4f01ab25f5d404f36a22244ae342 upstream.

Some old drives (e.g. an Ultra320 SCSI disk as reported by John) do not
seem to execute MAINTENANCE_IN / MI_REPORT_SUPPORTED_OPERATION_CODES
commands correctly and hang when a non-zero service action is specified
(one command format with service action case in scsi_report_opcode()).

Currently, CDL probing with scsi_cdl_check_cmd() is the only caller using a
non zero service action for scsi_report_opcode(). To avoid issues with
these old drives, do not attempt CDL probe if the device reports support
for an SPC version lower than 5 (CDL was introduced in SPC-5). To keep
things working with ATA devices which probe for the CDL T2A and T2B pages
introduced with SPC-6, modify ata_scsiop_inq_std() to claim SPC-6 version
compatibility for ATA drives supporting CDL.

SPC-6 standard version number is defined as Dh (= 13) in SPC-6 r09. Fix
scsi_probe_lun() to correctly capture this value by changing the bit mask
for the second byte of the INQUIRY response from 0x7 to 0xf.
include/scsi/scsi.h is modified to add the definition SCSI_SPC_6 with the
value 14 (Dh + 1). The missing definitions for the SCSI_SPC_4 and
SCSI_SPC_5 versions are also added.

Reported-by: John David Anglin <dave.anglin@bell.net>
Fixes: 624885209f31 ("scsi: core: Detect support for command duration limits")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20230915022034.678121-1-dlemoal@kernel.org
Tested-by: David Gow <david@davidgow.net>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-scsi.c |    3 +++
 drivers/scsi/scsi.c       |   11 +++++++++++
 drivers/scsi/scsi_scan.c  |    2 +-
 include/scsi/scsi.h       |    3 +++
 4 files changed, 18 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1892,6 +1892,9 @@ static unsigned int ata_scsiop_inq_std(s
 		hdr[2] = 0x7; /* claim SPC-5 version compatibility */
 	}
 
+	if (args->dev->flags & ATA_DFLAG_CDL)
+		hdr[2] = 0xd; /* claim SPC-6 version compatibility */
+
 	memcpy(rbuf, hdr, sizeof(hdr));
 	memcpy(&rbuf[8], "ATA     ", 8);
 	ata_id_string(args->id, &rbuf[16], ATA_ID_PROD, 16);
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -613,6 +613,17 @@ void scsi_cdl_check(struct scsi_device *
 	bool cdl_supported;
 	unsigned char *buf;
 
+	/*
+	 * Support for CDL was defined in SPC-5. Ignore devices reporting an
+	 * lower SPC version. This also avoids problems with old drives choking
+	 * on MAINTENANCE_IN / MI_REPORT_SUPPORTED_OPERATION_CODES with a
+	 * service action specified, as done in scsi_cdl_check_cmd().
+	 */
+	if (sdev->scsi_level < SCSI_SPC_5) {
+		sdev->cdl_supported = 0;
+		return;
+	}
+
 	buf = kmalloc(SCSI_CDL_CHECK_BUF_LEN, GFP_KERNEL);
 	if (!buf) {
 		sdev->cdl_supported = 0;
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -822,7 +822,7 @@ static int scsi_probe_lun(struct scsi_de
 	 * device is attached at LUN 0 (SCSI_SCAN_TARGET_PRESENT) so
 	 * non-zero LUNs can be scanned.
 	 */
-	sdev->scsi_level = inq_result[2] & 0x07;
+	sdev->scsi_level = inq_result[2] & 0x0f;
 	if (sdev->scsi_level >= 2 ||
 	    (sdev->scsi_level == 1 && (inq_result[3] & 0x0f) == 1))
 		sdev->scsi_level++;
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -157,6 +157,9 @@ enum scsi_disposition {
 #define SCSI_3          4        /* SPC */
 #define SCSI_SPC_2      5
 #define SCSI_SPC_3      6
+#define SCSI_SPC_4	7
+#define SCSI_SPC_5	8
+#define SCSI_SPC_6	14
 
 /*
  * INQ PERIPHERAL QUALIFIERS



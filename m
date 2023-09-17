Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7658D7A3CCA
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbjIQUfQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbjIQUfB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:35:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D271B123
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:34:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16639C433C8;
        Sun, 17 Sep 2023 20:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982895;
        bh=ogEtWjvrdfWo0ldh6UDAKQUH07MceBo0WZEep1qGW80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lq9/MlRyMAb9XnlJbjvuw/0mIcVsLxJ3rj79lMza53l03z533CW51rHX7lXmvvMzN
         6wKp1aN7bgQjAYSbVc/KqXlrg9T7j+Bcqqqi/ENa13XneGb+VRtRvcxsLYm0m9Zf54
         qeR7Xv4mNa20y4PmuUf5KKnd7iP9GGJyJcUm6gGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Manish Rangankar <mrangankar@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.15 385/511] scsi: qla2xxx: Remove unsupported ql2xenabledif option
Date:   Sun, 17 Sep 2023 21:13:32 +0200
Message-ID: <20230917191123.094927266@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

From: Manish Rangankar <mrangankar@marvell.com>

commit e9105c4b7a9208a21a9bda133707624f12ddabc2 upstream.

User accidently passed module parameter ql2xenabledif=1 which is
unsupported. However, driver still initialized which lead to guard tag
errors during device discovery.

Remove unsupported ql2xenabledif=1 option and validate the user input.

Cc: stable@vger.kernel.org
Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230821130045.34850-7-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_attr.c |    2 --
 drivers/scsi/qla2xxx/qla_dbg.c  |    2 +-
 drivers/scsi/qla2xxx/qla_os.c   |    9 +++++++--
 3 files changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -3084,8 +3084,6 @@ qla24xx_vport_create(struct fc_vport *fc
 			vha->flags.difdix_supported = 1;
 			ql_dbg(ql_dbg_user, vha, 0x7082,
 			    "Registered for DIF/DIX type 1 and 3 protection.\n");
-			if (ql2xenabledif == 1)
-				prot = SHOST_DIX_TYPE0_PROTECTION;
 			scsi_host_set_prot(vha->host,
 			    prot | SHOST_DIF_TYPE1_PROTECTION
 			    | SHOST_DIF_TYPE2_PROTECTION
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -18,7 +18,7 @@
  * | Queue Command and IO tracing |       0x3074       | 0x300b         |
  * |                              |                    | 0x3027-0x3028  |
  * |                              |                    | 0x303d-0x3041  |
- * |                              |                    | 0x302d,0x3033  |
+ * |                              |                    | 0x302e,0x3033  |
  * |                              |                    | 0x3036,0x3038  |
  * |                              |                    | 0x303a		|
  * | DPC Thread                   |       0x4023       | 0x4002,0x4013  |
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3252,6 +3252,13 @@ qla2x00_probe_one(struct pci_dev *pdev,
 	host->max_id = ha->max_fibre_devices;
 	host->cmd_per_lun = 3;
 	host->unique_id = host->host_no;
+
+	if (ql2xenabledif && ql2xenabledif != 2) {
+		ql_log(ql_log_warn, base_vha, 0x302d,
+		       "Invalid value for ql2xenabledif, resetting it to default (2)\n");
+		ql2xenabledif = 2;
+	}
+
 	if (IS_T10_PI_CAPABLE(ha) && ql2xenabledif)
 		host->max_cmd_len = 32;
 	else
@@ -3485,8 +3492,6 @@ skip_dpc:
 			base_vha->flags.difdix_supported = 1;
 			ql_dbg(ql_dbg_init, base_vha, 0x00f1,
 			    "Registering for DIF/DIX type 1 and 3 protection.\n");
-			if (ql2xenabledif == 1)
-				prot = SHOST_DIX_TYPE0_PROTECTION;
 			if (ql2xprotmask)
 				scsi_host_set_prot(host, ql2xprotmask);
 			else



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAD27BE175
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377522AbjJINuk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376883AbjJINui (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:50:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5808D6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:50:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158D2C433C9;
        Mon,  9 Oct 2023 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859420;
        bh=QYdwNQqpQLDcpB3cPuWEEG273N1yV56mTB7lNQvhF8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/hopFk0ZDpxZ4v2tu3O/bLmtgyI0PLvt7bbaPhNdhq4QeULKUi/beGZm8W5fMH1H
         xxwRkBxWnatIKb1EmrQgLW4ba/kSVwb9v6L+jB1P1LXZsR8O3lAsGpEVUdQa5wC1+v
         Cn5rfgSkcpnEVAP1EA47U4e4dwyHHoXuEC2hA8Ro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 16/91] scsi: qla2xxx: Add protection mask module parameters
Date:   Mon,  9 Oct 2023 15:05:48 +0200
Message-ID: <20231009130112.099874427@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin K. Petersen <martin.petersen@oracle.com>

[ Upstream commit 7855d2ba1172d716d96a628af7c5bafa5725ac57 ]

Allow user to selectively enable/disable DIF/DIX protection
capabilities mask.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: e9105c4b7a92 ("scsi: qla2xxx: Remove unsupported ql2xenabledif option")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 36 +++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 4580774b2c3e7..27514d0abe845 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -277,6 +277,20 @@ MODULE_PARM_DESC(qla2xuseresexchforels,
 		 "Reserve 1/2 of emergency exchanges for ELS.\n"
 		 " 0 (default): disabled");
 
+int ql2xprotmask;
+module_param(ql2xprotmask, int, 0644);
+MODULE_PARM_DESC(ql2xprotmask,
+		 "Override DIF/DIX protection capabilities mask\n"
+		 "Default is 0 which sets protection mask based on "
+		 "capabilities reported by HBA firmware.\n");
+
+int ql2xprotguard;
+module_param(ql2xprotguard, int, 0644);
+MODULE_PARM_DESC(ql2xprotguard, "Override choice of DIX checksum\n"
+		 "  0 -- Let HBA firmware decide\n"
+		 "  1 -- Force T10 CRC\n"
+		 "  2 -- Force IP checksum\n");
+
 /*
  * SCSI host template entry points
  */
@@ -3293,13 +3307,16 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			    "Registering for DIF/DIX type 1 and 3 protection.\n");
 			if (ql2xenabledif == 1)
 				prot = SHOST_DIX_TYPE0_PROTECTION;
-			scsi_host_set_prot(host,
-			    prot | SHOST_DIF_TYPE1_PROTECTION
-			    | SHOST_DIF_TYPE2_PROTECTION
-			    | SHOST_DIF_TYPE3_PROTECTION
-			    | SHOST_DIX_TYPE1_PROTECTION
-			    | SHOST_DIX_TYPE2_PROTECTION
-			    | SHOST_DIX_TYPE3_PROTECTION);
+			if (ql2xprotmask)
+				scsi_host_set_prot(host, ql2xprotmask);
+			else
+				scsi_host_set_prot(host,
+				    prot | SHOST_DIF_TYPE1_PROTECTION
+				    | SHOST_DIF_TYPE2_PROTECTION
+				    | SHOST_DIF_TYPE3_PROTECTION
+				    | SHOST_DIX_TYPE1_PROTECTION
+				    | SHOST_DIX_TYPE2_PROTECTION
+				    | SHOST_DIX_TYPE3_PROTECTION);
 
 			guard = SHOST_DIX_GUARD_CRC;
 
@@ -3307,7 +3324,10 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			    (ql2xenabledif > 1 || IS_PI_DIFB_DIX0_CAPABLE(ha)))
 				guard |= SHOST_DIX_GUARD_IP;
 
-			scsi_host_set_guard(host, guard);
+			if (ql2xprotguard)
+				scsi_host_set_guard(host, ql2xprotguard);
+			else
+				scsi_host_set_guard(host, guard);
 		} else
 			base_vha->flags.difdix_supported = 0;
 	}
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF336FADE1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjEHLjT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbjEHLjC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA3E3F2DF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59FA06341B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B89EC433EF;
        Mon,  8 May 2023 11:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545896;
        bh=lqas/Bm4A/EC+wYIVMHpUYYDHGlXN2VpMmPEe9h9yzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsZkUqsttU2tusDz4MZTu9oNhw2qywTgpTw9nQEyCDniozMXeMDbcvnpsX0TMCHgK
         Ji24ofeq6JgbicIu9X+RpoiKsI43M7d8WJU+MA7uctD0XW0FA77xfWvPzb/XNTm0GS
         +H9qCLUH6Ddr2R1jYLCwv5L6qA1yvWrRH28BhyCg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shuchang Li <lishuchang@hust.edu.cn>,
        Justin Tee <justin.tee@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 188/371] scsi: lpfc: Fix ioremap issues in lpfc_sli4_pci_mem_setup()
Date:   Mon,  8 May 2023 11:46:29 +0200
Message-Id: <20230508094819.589633745@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Shuchang Li <lishuchang@hust.edu.cn>

[ Upstream commit 91a0c0c1413239d0548b5aac4c82f38f6d53a91e ]

When if_type equals zero and pci_resource_start(pdev, PCI_64BIT_BAR4)
returns false, drbl_regs_memmap_p is not remapped. This passes a NULL
pointer to iounmap(), which can trigger a WARN() on certain arches.

When if_type equals six and pci_resource_start(pdev, PCI_64BIT_BAR4)
returns true, drbl_regs_memmap_p may has been remapped and
ctrl_regs_memmap_p is not remapped. This is a resource leak and passes a
NULL pointer to iounmap().

To fix these issues, we need to add null checks before iounmap(), and
change some goto labels.

Fixes: 1351e69fc6db ("scsi: lpfc: Add push-to-adapter support to sli4")
Signed-off-by: Shuchang Li <lishuchang@hust.edu.cn>
Link: https://lore.kernel.org/r/20230404072133.1022-1-lishuchang@hust.edu.cn
Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_init.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index f79299f6178cd..2ca4cf1b58c4f 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -11738,7 +11738,7 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 				goto out_iounmap_all;
 		} else {
 			error = -ENOMEM;
-			goto out_iounmap_all;
+			goto out_iounmap_ctrl;
 		}
 	}
 
@@ -11756,7 +11756,7 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 			dev_err(&pdev->dev,
 			   "ioremap failed for SLI4 HBA dpp registers.\n");
 			error = -ENOMEM;
-			goto out_iounmap_ctrl;
+			goto out_iounmap_all;
 		}
 		phba->pci_bar4_memmap_p = phba->sli4_hba.dpp_regs_memmap_p;
 	}
@@ -11781,9 +11781,11 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 	return 0;
 
 out_iounmap_all:
-	iounmap(phba->sli4_hba.drbl_regs_memmap_p);
+	if (phba->sli4_hba.drbl_regs_memmap_p)
+		iounmap(phba->sli4_hba.drbl_regs_memmap_p);
 out_iounmap_ctrl:
-	iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
+	if (phba->sli4_hba.ctrl_regs_memmap_p)
+		iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
 out_iounmap_conf:
 	iounmap(phba->sli4_hba.conf_regs_memmap_p);
 
-- 
2.39.2




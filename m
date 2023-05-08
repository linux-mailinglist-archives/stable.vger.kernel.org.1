Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8486FA65D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjEHKSq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjEHKSn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:18:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2ABD2C3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:18:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11EEF624F1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25070C433EF;
        Mon,  8 May 2023 10:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541120;
        bh=8XlNvxFe8J9MElTonJQu/vF4gtbvlLAZtiQOh98u3T4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kLnbbUv4/C7fNtWXqMFd8tKxDqkeVwOSKbzMflZD+U3spTxFcUZykeSn6GrWS5iMY
         s/vYQ6shs3oCLbScrbs9QzZgti9taeJ+kx4aW3K7Ukbhlxy0ErLkk57PO+VilOjQMX
         yZwdkI2y0J2I8EDzihPxlK2O0jlI8qYYhfVGD7+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ranjan Kumar <ranjan.kumar@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 012/663] scsi: mpi3mr: Handle soft reset in progress fault code (0xF002)
Date:   Mon,  8 May 2023 11:37:18 +0200
Message-Id: <20230508094428.817304757@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Ranjan Kumar <ranjan.kumar@broadcom.com>

[ Upstream commit a3d27dfdcfc27ac3f46de5391bb6d24f04af7941 ]

The driver is exiting from the fault watchdog thread if it sees the 0xF002
(Soft reset in progress) fault code.

If the driver initiates the soft reset, then the driver restarts the
watchdog at the end of the soft reset completion.  However, if the soft
reset is initiated by the firmware asynchronously, then the driver will
never restart the watchdog and never re-initialize the controller after the
asynchronous soft reset completion.

Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Link: https://lore.kernel.org/r/20230331122317.11391-1-ranjan.kumar@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index a565817aa56d4..d109a4ceb72b1 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -2526,7 +2526,7 @@ static void mpi3mr_watchdog_work(struct work_struct *work)
 		mrioc->unrecoverable = 1;
 		goto schedule_work;
 	case MPI3_SYSIF_FAULT_CODE_SOFT_RESET_IN_PROGRESS:
-		return;
+		goto schedule_work;
 	case MPI3_SYSIF_FAULT_CODE_CI_ACTIVATION_RESET:
 		reset_reason = MPI3MR_RESET_FROM_CIACTIV_FAULT;
 		break;
-- 
2.39.2




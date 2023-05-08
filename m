Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314226FA3CC
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjEHJvu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjEHJvt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:51:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24346A2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA505621D8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC17C433D2;
        Mon,  8 May 2023 09:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539506;
        bh=bu8vS+mCAOz4URE9Wdvm46xUj8MlgItfn6idQuIEVNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0HAbXpPRJlJdQWw6zCWIQomS/gfb2R2AYmSqtm1APJFqgvhSvKBHAkR0qpS4l0pWP
         ofFxI2K1LIavCiRU/yXoGQogKJbcbC3goEp0ft+NS2qb/RK+5mR0u8AUaKjZBboPg/
         +VaMs2OA2O2bg7Feb+RxSp1b5GLmZGuSeETrKl5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ranjan Kumar <ranjan.kumar@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 011/611] scsi: mpi3mr: Handle soft reset in progress fault code (0xF002)
Date:   Mon,  8 May 2023 11:37:33 +0200
Message-Id: <20230508094422.013931658@linuxfoundation.org>
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
index ea9e69fb62826..64355d0baa5fb 100644
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




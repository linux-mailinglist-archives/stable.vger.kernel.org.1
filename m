Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5557E2402
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjKFNRH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjKFNRG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:17:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C4E91
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:17:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83E2C433C7;
        Mon,  6 Nov 2023 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276624;
        bh=dNfjOnPJw7WUHezcdtTXWnUgzj8y/hrvahxpymRNugo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cqgFR6Vli9c/AWP6m1SLvWrh4pD7VmrGUap/PynXvYAFEm/EUdyZLNtVGef3aqE7s
         aoLXHLzF/xF7u86ExUcuoYFy4f6dK/CW00vB+BruEcWnHNAHhtuYWCJZmBdRi9sF+L
         uJll8zILEn4c+5gFkdm1cL8uj+/RbqNEGrFpPIEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tomas Henzl <thenzl@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 42/88] scsi: mpt3sas: Fix in error path
Date:   Mon,  6 Nov 2023 14:03:36 +0100
Message-ID: <20231106130307.395667987@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Henzl <thenzl@redhat.com>

[ Upstream commit e40c04ade0e2f3916b78211d747317843b11ce10 ]

The driver should be deregistered as misc driver after PCI registration
failure.

Signed-off-by: Tomas Henzl <thenzl@redhat.com>
Link: https://lore.kernel.org/r/20231015114529.10725-1-thenzl@redhat.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index c3c1f466fe01d..605013d3ee83a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -12913,8 +12913,10 @@ _mpt3sas_init(void)
 	mpt3sas_ctl_init(hbas_to_enumerate);
 
 	error = pci_register_driver(&mpt3sas_driver);
-	if (error)
+	if (error) {
+		mpt3sas_ctl_exit(hbas_to_enumerate);
 		scsih_exit();
+	}
 
 	return error;
 }
-- 
2.42.0




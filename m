Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C3970C5EA
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjEVTN2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjEVTN1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:13:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E322B0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:13:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C9C861F63
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBF8C433D2;
        Mon, 22 May 2023 19:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684782805;
        bh=9cHJoxwPwMaoa5mCxHNXA7YdZzP9gyYISNAZzlZpBzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gNAvzEbOrLSuD7RX7xWIROVP9LyrKDrVdRcENQ7hJjUHGvaj9L9G/L2EGWxhTITyL
         t5ouQRyAulFM1ynlWZ4xNtQf8mZzdXtgVU3NpF9qcAugtmHp1quVfTY0PUZUW0RQRw
         tC5O07w3qfjYHK6Zm5TnSTVIh8gLl0qQKgkHds24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Keoseong Park <keosung.park@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 004/203] scsi: ufs: core: Fix I/O hang that occurs when BKOPS fails in W-LUN suspend
Date:   Mon, 22 May 2023 20:07:08 +0100
Message-Id: <20230522190355.058446013@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Keoseong Park <keosung.park@samsung.com>

[ Upstream commit 1a7edd041f2d252f251523ba3f2eaead076a8f8d ]

Even when urgent BKOPS fails, the consumer will get stuck in runtime
suspend status. Like commit 1a5665fc8d7a ("scsi: ufs: core: WLUN suspend
SSU/enter hibern8 fail recovery"), trigger the error handler and return
-EBUSY to break the suspend.

Fixes: b294ff3e3449 ("scsi: ufs: core: Enable power management for wlun")
Signed-off-by: Keoseong Park <keosung.park@samsung.com>
Link: https://lore.kernel.org/r/20230425031721epcms2p5d4de65616478c967d466626e20c42a3a@epcms2p5
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index bc2b16701a116..d00d263705e15 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8756,8 +8756,16 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 			 * that performance might be impacted.
 			 */
 			ret = ufshcd_urgent_bkops(hba);
-			if (ret)
+			if (ret) {
+				/*
+				 * If return err in suspend flow, IO will hang.
+				 * Trigger error handler and break suspend for
+				 * error recovery.
+				 */
+				ufshcd_force_error_recovery(hba);
+				ret = -EBUSY;
 				goto enable_scaling;
+			}
 		} else {
 			/* make sure that auto bkops is disabled */
 			ufshcd_disable_auto_bkops(hba);
-- 
2.39.2




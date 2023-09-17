Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFBA7A3A73
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbjIQUDU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbjIQUDC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:03:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B7A100
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:02:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E30C433C8;
        Sun, 17 Sep 2023 20:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980974;
        bh=N2s72jbADtJb90ooRw/sk9+v3vC8j8H+AT4z63nmZtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oTuG8nKVXygWH/HP+3I7J+FeEtRaZXwwu3nVFnW7PHK564OTVZyedoPhZSpa6OmKe
         E6tFmTb2sJjSydQ3BqmXok0sBREqqcGBIig8LhffZu+7moYHQA5rGK2uPKccQSflzy
         TjXGENTdLB1YpEH8Fwrspe1RuhZpA5J8q7WK/38E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeff LaBundy <jeff@labundy.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 063/219] Input: iqs7222 - configure power mode before triggering ATI
Date:   Sun, 17 Sep 2023 21:13:10 +0200
Message-ID: <20230917191043.282095577@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff LaBundy <jeff@labundy.com>

[ Upstream commit 2e00b8bf5624767f6be7427b6eb532524793463e ]

If the device drops into ultra-low-power mode before being placed
into normal-power mode as part of ATI being triggered, the device
does not assert any interrupts until the ATI routine is restarted
two seconds later.

Solve this problem by adopting the vendor's recommendation, which
calls for the device to be placed into normal-power mode prior to
being configured and ATI being triggered.

The original implementation followed this sequence, but the order
was inadvertently changed as part of the resolution of a separate
erratum.

Fixes: 1e4189d8af27 ("Input: iqs7222 - protect volatile registers")
Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Link: https://lore.kernel.org/r/ZKrpHc2Ji9qR25r2@nixie71
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/iqs7222.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/iqs7222.c b/drivers/input/misc/iqs7222.c
index e47ab6c1177f5..f24b174c72667 100644
--- a/drivers/input/misc/iqs7222.c
+++ b/drivers/input/misc/iqs7222.c
@@ -1381,9 +1381,6 @@ static int iqs7222_ati_trigger(struct iqs7222_private *iqs7222)
 	if (error)
 		return error;
 
-	sys_setup &= ~IQS7222_SYS_SETUP_INTF_MODE_MASK;
-	sys_setup &= ~IQS7222_SYS_SETUP_PWR_MODE_MASK;
-
 	for (i = 0; i < IQS7222_NUM_RETRIES; i++) {
 		/*
 		 * Trigger ATI from streaming and normal-power modes so that
@@ -1561,8 +1558,11 @@ static int iqs7222_dev_init(struct iqs7222_private *iqs7222, int dir)
 			return error;
 	}
 
-	if (dir == READ)
+	if (dir == READ) {
+		iqs7222->sys_setup[0] &= ~IQS7222_SYS_SETUP_INTF_MODE_MASK;
+		iqs7222->sys_setup[0] &= ~IQS7222_SYS_SETUP_PWR_MODE_MASK;
 		return 0;
+	}
 
 	return iqs7222_ati_trigger(iqs7222);
 }
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB63F7A39B7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbjIQTxL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbjIQTxD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:53:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6D79F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:52:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9186DC433C7;
        Sun, 17 Sep 2023 19:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980378;
        bh=VhaUDfkEwSMloKhp8Rp2ZIuk8+GkIjfPp2aWUzAEGmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cwwl4g9593QzSQUZCIvcKPQqPRTWJ7RCAfpvRugbJdSsF+igYNwU8pLhMj7r3ViqO
         kIrxJAyW8E4QWvkfOj6SVum0wCyFTwA3bnbFttMRoXtOd1+TCopsLl8V3Dm0JOwJbd
         n/TvA3LTc2gnZPSs+hyvsqfGrEeMIwU321HHznyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Duoming Zhou <duoming@zju.edu.cn>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 175/285] sh: push-switch: Reorder cleanup operations to avoid use-after-free bug
Date:   Sun, 17 Sep 2023 21:12:55 +0200
Message-ID: <20230917191057.691406198@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 246f80a0b17f8f582b2c0996db02998239057c65 ]

The original code puts flush_work() before timer_shutdown_sync()
in switch_drv_remove(). Although we use flush_work() to stop
the worker, it could be rescheduled in switch_timer(). As a result,
a use-after-free bug can occur. The details are shown below:

      (cpu 0)                    |      (cpu 1)
switch_drv_remove()              |
 flush_work()                    |
  ...                            |  switch_timer // timer
                                 |   schedule_work(&psw->work)
 timer_shutdown_sync()           |
 ...                             |  switch_work_handler // worker
 kfree(psw) // free              |
                                 |   psw->state = 0 // use

This patch puts timer_shutdown_sync() before flush_work() to
mitigate the bugs. As a result, the worker and timer will be
stopped safely before the deallocate operations.

Fixes: 9f5e8eee5cfe ("sh: generic push-switch framework.")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://lore.kernel.org/r/20230802033737.9738-1-duoming@zju.edu.cn
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/drivers/push-switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/drivers/push-switch.c b/arch/sh/drivers/push-switch.c
index c95f48ff3f6fb..6ecba5f521eb6 100644
--- a/arch/sh/drivers/push-switch.c
+++ b/arch/sh/drivers/push-switch.c
@@ -101,8 +101,8 @@ static int switch_drv_remove(struct platform_device *pdev)
 		device_remove_file(&pdev->dev, &dev_attr_switch);
 
 	platform_set_drvdata(pdev, NULL);
-	flush_work(&psw->work);
 	timer_shutdown_sync(&psw->debounce);
+	flush_work(&psw->work);
 	free_irq(irq, pdev);
 
 	kfree(psw);
-- 
2.40.1




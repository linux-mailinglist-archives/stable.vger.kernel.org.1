Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802907ECE67
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjKOTmz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjKOTmx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:42:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DBC19E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:42:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2927FC433C7;
        Wed, 15 Nov 2023 19:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077369;
        bh=wRQEHcI5zqIb+u7UH/u8A9tB2TLiqNIWj2OA4Yiw+fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nl/kwFGxnkog6MEFQAd4gOn9tB7U4xCEllDUH9XZIXuQYXK9YLBSJByeHagG+qS25
         QKwK31MrYYjcC4CAFOyyJ/v9gnoomJ82/HEmtAnwrxUWgRsvZlYsxNT/GukvVPYNYI
         5Yj/sxi0qidvggI7eb7p4Ft6erbJqp2eg933xV5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 259/603] drm/bridge: lt9611uxc: fix the race in the error path
Date:   Wed, 15 Nov 2023 14:13:24 -0500
Message-ID: <20231115191631.234438832@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 15fe53be46eaf4f6339cd433972ecc90513e3076 ]

If DSI host attachment fails, the LT9611UXC driver will remove the
bridge without ensuring that there is no outstanding HPD work being
done. In rare cases this can result in the warnings regarding the mutex
being incorrect. Fix this by forcebly freing IRQ and flushing the work.

DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 10 at kernel/locking/mutex.c:582 __mutex_lock+0x468/0x77c
Modules linked in:
CPU: 0 PID: 10 Comm: kworker/0:1 Tainted: G     U             6.6.0-rc5-next-20231011-gd81f81c2b682-dirty #1206
Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
Workqueue: events lt9611uxc_hpd_work
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock+0x468/0x77c
lr : __mutex_lock+0x468/0x77c
sp : ffff8000800a3c70
x29: ffff8000800a3c70 x28: 0000000000000000 x27: ffffd595fe333000
x26: ffff7c2f0002c005 x25: ffffd595ff1b3000 x24: ffffd595fccda5a0
x23: 0000000000000000 x22: 0000000000000002 x21: ffff7c2f056d91c8
x20: 0000000000000000 x19: ffff7c2f056d91c8 x18: fffffffffffe8db0
x17: 000000040044ffff x16: 005000f2b5503510 x15: 0000000000000000
x14: 000000000006efb8 x13: 0000000000000000 x12: 0000000000000037
x11: 0000000000000001 x10: 0000000000001470 x9 : ffff8000800a3ae0
x8 : ffff7c2f0027f8d0 x7 : ffff7c2f0027e400 x6 : ffffd595fc702b54
x5 : 0000000000000000 x4 : ffff8000800a0000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff7c2f0027e400
Call trace:
 __mutex_lock+0x468/0x77c
 mutex_lock_nested+0x24/0x30
 drm_bridge_hpd_notify+0x2c/0x5c
 lt9611uxc_hpd_work+0x6c/0x80
 process_one_work+0x1ec/0x51c
 worker_thread+0x1ec/0x3e4
 kthread+0x120/0x124
 ret_from_fork+0x10/0x20
irq event stamp: 15799
hardirqs last  enabled at (15799): [<ffffd595fc702ba4>] finish_task_switch.isra.0+0xa8/0x278
hardirqs last disabled at (15798): [<ffffd595fd5a1580>] __schedule+0x7b8/0xbd8
softirqs last  enabled at (15794): [<ffffd595fc690698>] __do_softirq+0x498/0x4e0
softirqs last disabled at (15771): [<ffffd595fc69615c>] ____do_softirq+0x10/0x1c

Fixes: bc6fa8676ebb ("drm/bridge/lontium-lt9611uxc: move HPD notification out of IRQ handler")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231011220002.382422-1-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 22c84d29c2bc5..6f33bb0dd32aa 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -929,9 +929,9 @@ static int lt9611uxc_probe(struct i2c_client *client)
 	init_waitqueue_head(&lt9611uxc->wq);
 	INIT_WORK(&lt9611uxc->work, lt9611uxc_hpd_work);
 
-	ret = devm_request_threaded_irq(dev, client->irq, NULL,
-					lt9611uxc_irq_thread_handler,
-					IRQF_ONESHOT, "lt9611uxc", lt9611uxc);
+	ret = request_threaded_irq(client->irq, NULL,
+				   lt9611uxc_irq_thread_handler,
+				   IRQF_ONESHOT, "lt9611uxc", lt9611uxc);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
 		goto err_disable_regulators;
@@ -967,6 +967,8 @@ static int lt9611uxc_probe(struct i2c_client *client)
 	return lt9611uxc_audio_init(dev, lt9611uxc);
 
 err_remove_bridge:
+	free_irq(client->irq, lt9611uxc);
+	cancel_work_sync(&lt9611uxc->work);
 	drm_bridge_remove(&lt9611uxc->bridge);
 
 err_disable_regulators:
@@ -983,7 +985,7 @@ static void lt9611uxc_remove(struct i2c_client *client)
 {
 	struct lt9611uxc *lt9611uxc = i2c_get_clientdata(client);
 
-	disable_irq(client->irq);
+	free_irq(client->irq, lt9611uxc);
 	cancel_work_sync(&lt9611uxc->work);
 	lt9611uxc_audio_exit(lt9611uxc);
 	drm_bridge_remove(&lt9611uxc->bridge);
-- 
2.42.0




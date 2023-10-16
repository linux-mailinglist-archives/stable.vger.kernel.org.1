Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217607CAC5B
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjJPOxb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjJPOxa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:53:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AA0EA
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:53:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3C7C433C9;
        Mon, 16 Oct 2023 14:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468007;
        bh=AsgX9uviDWVHczM8NppvEPOpv9cpzQK5bMc5YqBAytg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KKJcTV2HhS+cHYH0yKma0XfOq7CkrZ2JogyN5wJW56NcUOkKngItrJX4nzO7I6aN6
         z8AU61ubijCSiHBsVTcdEe7BG0JDFOhmAJgcbFVZ3rLgGQXC37lD92mixr7FpZJlz7
         8aPEQMf9/gqIHntVrB4AZM+8j3je9Kdp5aQVJHFk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maximilian Luz <luzmaximilian@gmail.com>,
        stable <stable@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 6.5 133/191] serial: core: Fix checks for tx runtime PM state
Date:   Mon, 16 Oct 2023 10:41:58 +0200
Message-ID: <20231016084018.496334320@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

commit 81a61051e0ce5fd7e09225c0d5985da08c7954a7 upstream.

Maximilian reported that surface_serial_hub serdev tx does not work during
system suspend. During system suspend, runtime PM gets disabled in
__device_suspend_late(), and tx is unable to wake-up the serial core port
device that we use to check if tx is safe to start. Johan summarized the
regression noting that serdev tx no longer always works as earlier when the
serdev device is runtime PM active.

The serdev device and the serial core controller devices are siblings of
the serial port hardware device. The runtime PM usage count from serdev
device does not propagate to the serial core device siblings, it only
propagates to the parent.

In addition to the tx issue for suspend, testing for the serial core port
device can cause an unnecessary delay in enabling tx while waiting for the
serial core port device to wake-up. The serial core port device wake-up is
only needed to flush pending tx when the serial port hardware device was
in runtime PM suspended state.

To fix the regression, we need to check the runtime PM state of the parent
serial port hardware device for tx instead of the serial core port device.

As the serial port device drivers may or may not implement runtime PM, we
need to also add a check for pm_runtime_enabled().

Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
Cc: stable <stable@kernel.org>
Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20231005075644.25936-1-tony@atomide.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/serial_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -157,7 +157,7 @@ static void __uart_start(struct tty_stru
 	 * enabled, serial_port_runtime_resume() calls start_tx() again
 	 * after enabling the device.
 	 */
-	if (pm_runtime_active(&port_dev->dev))
+	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(port->dev))
 		port->ops->start_tx(port);
 	pm_runtime_mark_last_busy(&port_dev->dev);
 	pm_runtime_put_autosuspend(&port_dev->dev);



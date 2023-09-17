Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3951D7A39BD
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbjIQTxh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbjIQTxU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:53:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC8B9F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:53:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EDDC433C8;
        Sun, 17 Sep 2023 19:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980394;
        bh=l6MUDYFxAPPd4qUPaiSmClt5O45iMhT3e/BuS6jejHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1pFbAbQNQ91YOTohsaue3b0Th2WMUzojTUVig37ZwkCoh/ezXrxShnTx4zQ5ILBBw
         09ZgbjE7r2abilJnH/PdWhEwqGxyNuGyUSLXLaa8bT7hhgRsvlgHtivJ3ACvmGPYNA
         7+DvJp0L/LMjdsHkoeig1xYVCS2aCZ7SX6DFWgtE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Walter Chang <walter.chang@mediatek.com>,
        Marc Zyngier <maz@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 6.5 180/285] clocksource/drivers/arm_arch_timer: Disable timer before programming CVAL
Date:   Sun, 17 Sep 2023 21:13:00 +0200
Message-ID: <20230917191057.857648153@linuxfoundation.org>
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

From: Walter Chang <walter.chang@mediatek.com>

commit e7d65e40ab5a5940785c5922f317602d0268caaf upstream.

Due to the fact that the use of `writeq_relaxed()` to program CVAL is
not guaranteed to be atomic, it is necessary to disable the timer before
programming CVAL.

However, if the MMIO timer is already enabled and has not yet expired,
there is a possibility of unexpected behavior occurring: when the CPU
enters the idle state during this period, and if the CPU's local event
is earlier than the broadcast event, the following process occurs:

tick_broadcast_enter()
  tick_broadcast_oneshot_control(TICK_BROADCAST_ENTER)
    __tick_broadcast_oneshot_control()
      ___tick_broadcast_oneshot_control()
        tick_broadcast_set_event()
          clockevents_program_event()
            set_next_event_mem()

During this process, the MMIO timer remains enabled while programming
CVAL. To prevent such behavior, disable timer explicitly prior to
programming CVAL.

Fixes: 8b82c4f883a7 ("clocksource/drivers/arm_arch_timer: Move MMIO timer programming over to CVAL")
Cc: stable@vger.kernel.org
Signed-off-by: Walter Chang <walter.chang@mediatek.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230717090735.19370-1-walter.chang@mediatek.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clocksource/arm_arch_timer.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -792,6 +792,13 @@ static __always_inline void set_next_eve
 	u64 cnt;
 
 	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+
+	/* Timer must be disabled before programming CVAL */
+	if (ctrl & ARCH_TIMER_CTRL_ENABLE) {
+		ctrl &= ~ARCH_TIMER_CTRL_ENABLE;
+		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+	}
+
 	ctrl |= ARCH_TIMER_CTRL_ENABLE;
 	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
 



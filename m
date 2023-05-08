Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75A06FABFA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjEHLTX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbjEHLTU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C835F37C5C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:19:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 613C062C56
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7804FC4339B;
        Mon,  8 May 2023 11:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544758;
        bh=GTcoM28+YmVEY1ibPIHCTMBozK+q8C1dPhkwsLNL7l4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/mi6qnOfbNNz2c0K6bmhyTtUuQvj5ijxWHYCAE7RdjwQSB9pYAGFe4pTnlob2SFX
         SptfGlJE/G8LEKatyEz0GFgTfBSGRl2iI8l6IZlsHQgNqkvlJkGYEmlQzPha0ZBYBe
         NnVC6irFRvcIWRqvGJ+wcFU/YyUcDiWk8T146b4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Duoming Zhou <duoming@zju.edu.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 485/694] drivers: staging: rtl8723bs: Fix locking in _rtw_join_timeout_handler()
Date:   Mon,  8 May 2023 11:45:20 +0200
Message-Id: <20230508094449.658099618@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 215792eda008f6a1e7ed9d77fa20d582d22bb114 ]

Commit 041879b12ddb ("drivers: staging: rtl8192bs: Fix deadlock in
rtw_joinbss_event_prehandle()") besides fixing the deadlock also
modified _rtw_join_timeout_handler() to use spin_[un]lock_irq()
instead of spin_[un]lock_bh().

_rtw_join_timeout_handler() calls rtw_do_join() which takes
pmlmepriv->scanned_queue.lock using spin_[un]lock_bh(). This
spin_unlock_bh() call re-enables softirqs which triggers an oops in
kernel/softirq.c: __local_bh_enable_ip() when it calls
lockdep_assert_irqs_enabled():

[  244.506087] WARNING: CPU: 2 PID: 0 at kernel/softirq.c:376 __local_bh_enable_ip+0xa6/0x100
...
[  244.509022] Call Trace:
[  244.509048]  <IRQ>
[  244.509100]  _rtw_join_timeout_handler+0x134/0x170 [r8723bs]
[  244.509468]  ? __pfx__rtw_join_timeout_handler+0x10/0x10 [r8723bs]
[  244.509772]  ? __pfx__rtw_join_timeout_handler+0x10/0x10 [r8723bs]
[  244.510076]  call_timer_fn+0x95/0x2a0
[  244.510200]  __run_timers.part.0+0x1da/0x2d0

This oops is causd by the switch to spin_[un]lock_irq() which disables
the IRQs for the entire duration of _rtw_join_timeout_handler().

Disabling the IRQs is not necessary since all code taking this lock
runs from either user contexts or from softirqs, switch back to
spin_[un]lock_bh() to fix this.

Fixes: 041879b12ddb ("drivers: staging: rtl8192bs: Fix deadlock in rtw_joinbss_event_prehandle()")
Cc: Duoming Zhou <duoming@zju.edu.cn>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230221145326.7808-1-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index c6fd6cf741ef6..ea2a6566e51bf 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1549,7 +1549,7 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 		return;
 
-	spin_lock_irq(&pmlmepriv->lock);
+	spin_lock_bh(&pmlmepriv->lock);
 
 	if (rtw_to_roam(adapter) > 0) { /* join timeout caused by roaming */
 		while (1) {
@@ -1577,7 +1577,7 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 
 	}
 
-	spin_unlock_irq(&pmlmepriv->lock);
+	spin_unlock_bh(&pmlmepriv->lock);
 }
 
 /*
-- 
2.39.2




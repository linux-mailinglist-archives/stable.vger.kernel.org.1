Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276266FA561
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjEHKIv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbjEHKIv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:08:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591093292B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:08:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E390762385
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0590CC433EF;
        Mon,  8 May 2023 10:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540529;
        bh=rM7iOUOjL7wHzvU0ZkSjt72Y8tsGv96YPyomOXdROBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddIW45K8jqJ6Rrs7RLGgmamFGC5Oo95Lc4qYR77V3AhZkQCAEkn9YzIq91/RzYq9B
         1YH4Updi2SVX5XEbfmH7oKfQtsQyM1sj0yxdz/LdZ4o5luy5Ad2YOco7I7F4hRjXmD
         u/Fx8S/ySJRtp8bL9ofb/Z3D7gZZsDeLnSqmU+H4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Duoming Zhou <duoming@zju.edu.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 399/611] drivers: staging: rtl8723bs: Fix locking in _rtw_join_timeout_handler()
Date:   Mon,  8 May 2023 11:44:01 +0200
Message-Id: <20230508094435.244453134@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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
index 6498fd17e1d3e..9f4f032c22aec 100644
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




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D776FAE1D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbjEHLlf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjEHLlO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:41:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73964032F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:40:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCC2A63572
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6D2C4339B;
        Mon,  8 May 2023 11:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546042;
        bh=vf3+MhxK/DkrC9glH6gyN6Qnbfbiel3nOPoAe15lMd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8PAJf8qDJ51sDrgbzgsOQQ1wqNOvXyyrkEijW1a+znG+WG1DgDUXQ2zJPxuOYPVO
         m1P1URhvjSm4KSmazKHPhVYv39WuhQ4O36yx0C0cPDHUnhq5erhIhSuZy+YJ9VGLiA
         4U9CydA1wWepjRBzms8CqtWbLMhYe+icHJ5iLHNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Duoming Zhou <duoming@zju.edu.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 238/371] drivers: staging: rtl8723bs: Fix locking in rtw_scan_timeout_handler()
Date:   Mon,  8 May 2023 11:47:19 +0200
Message-Id: <20230508094821.514323191@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

[ Upstream commit 3f467036093fedd7e231924327455fc609b5ef02 ]

Commit cc7ad0d77b51 ("drivers: staging: rtl8723bs: Fix deadlock in
rtw_surveydone_event_callback()") besides fixing the deadlock also
modified rtw_scan_timeout_handler() to use spin_[un]lock_irq()
instead of spin_[un]lock_bh().

Disabling the IRQs is not necessary since all code taking this lock
runs from either user contexts or from softirqs

rtw_scan_timeout_handler() is the only function taking pmlmepriv->lock
which uses spin_[un]lock_irq() for this. Switch back to
spin_[un]lock_bh() to make it consistent with the rest of the code.

Fixes: cc7ad0d77b51 ("drivers: staging: rtl8723bs: Fix deadlock in rtw_surveydone_event_callback()")
Cc: Duoming Zhou <duoming@zju.edu.cn>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230221145326.7808-2-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index f85ef7dd61b24..5b64980e8522f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1588,11 +1588,11 @@ void rtw_scan_timeout_handler(struct timer_list *t)
 						  mlmepriv.scan_to_timer);
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	spin_lock_irq(&pmlmepriv->lock);
+	spin_lock_bh(&pmlmepriv->lock);
 
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 
-	spin_unlock_irq(&pmlmepriv->lock);
+	spin_unlock_bh(&pmlmepriv->lock);
 
 	rtw_indicate_scan_done(adapter, true);
 }
-- 
2.39.2




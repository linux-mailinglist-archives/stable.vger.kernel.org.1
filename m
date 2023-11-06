Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC67E2432
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjKFNTV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjKFNTU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:19:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1C094
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:19:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC582C433C9;
        Mon,  6 Nov 2023 13:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276757;
        bh=mJpb9rnxGppv9TQxA0xuRzXea0iceEYToht9h1La4IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0uiTf355/+f3FxIuxyFCQJ9z6tLZTvreExuHIBTkl5PasL9CtOCgtSAAk9Z6s9SEm
         3wIBwr8V7x+vSpUxHyxiqRCmEfHLvswbSsBhU8V9pgpHUMX8yi6JryYEgLbK5HYUfK
         lNUcgYowRtigrJNFqKSlfwwIT043043qYMXRchFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Mikko Rapeli <mikko.rapeli@linaro.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy MacLeod <randy.macleod@windriver.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6.5 86/88] serial: core: Fix runtime PM handling for pending tx
Date:   Mon,  6 Nov 2023 14:04:20 +0100
Message-ID: <20231106130308.979479321@linuxfoundation.org>
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

From: Tony Lindgren <tony@atomide.com>

commit 6f699743aebf07538e506a46c5965eb8bdd2c716 upstream.

Richard reported that a serial port may end up sometimes with tx data
pending in the buffer for long periods of time.

Turns out we bail out early on any errors from pm_runtime_get(),
including -EINPROGRESS. To fix the issue, we need to ignore -EINPROGRESS
as we only care about the runtime PM usage count at this point. We check
for an active runtime PM state later on for tx.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Cc: stable <stable@kernel.org>
Reported-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Randy MacLeod <randy.macleod@windriver.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Link: https://lore.kernel.org/r/20231023074856.61896-1-tony@atomide.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/serial_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -147,7 +147,7 @@ static void __uart_start(struct tty_stru
 
 	/* Increment the runtime PM usage count for the active check below */
 	err = pm_runtime_get(&port_dev->dev);
-	if (err < 0) {
+	if (err < 0 && err != -EINPROGRESS) {
 		pm_runtime_put_noidle(&port_dev->dev);
 		return;
 	}



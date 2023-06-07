Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADA5726DB4
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjFGUoq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbjFGUok (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:44:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FED26B9
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16F5B64660
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ABAC433D2;
        Wed,  7 Jun 2023 20:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170637;
        bh=New+Lk9rMHD7GQVrepLkvruOIKxv6AWS/GCZfh7FeLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y2HmK/wksBkFChfOLzr2yYSw9+MQo00J7CDGNrWOjMo1RKuzTSV1TgX/Zw7D5H84F
         nlfdip/1peR7/6TZWprPL1+1y9LvMw/KZXgISc+HGehYBbwt/nzWvo4mKj/zNO7ZdK
         YSbyMDol+06gu//WUTxHXPMqeK/NgNgdo0lydl3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6.1 161/225] misc: fastrpc: reject new invocations during device removal
Date:   Wed,  7 Jun 2023 22:15:54 +0200
Message-ID: <20230607200919.667091976@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Richard Acayan <mailingradian@gmail.com>

commit 46248400d81e2aa0b65cd659d6f40188192a58b6 upstream.

The channel's rpmsg object allows new invocations to be made. After old
invocations are already interrupted, the driver shouldn't try to invoke
anymore. Invalidating the rpmsg at the end of the driver removal
function makes it easy to cause a race condition in userspace. Even
closing a file descriptor before the driver finishes its cleanup can
cause an invocation via fastrpc_release_current_dsp_process() and
subsequent timeout.

Invalidate the channel before the invocations are interrupted to make
sure that no invocations can be created to hang after the device closes.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable <stable@kernel.org>
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230523152550.438363-5-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2162,7 +2162,9 @@ static void fastrpc_rpmsg_remove(struct
 	struct fastrpc_user *user;
 	unsigned long flags;
 
+	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
+	cctx->rpdev = NULL;
 	list_for_each_entry(user, &cctx->users, user)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -2175,7 +2177,6 @@ static void fastrpc_rpmsg_remove(struct
 
 	of_platform_depopulate(&rpdev->dev);
 
-	cctx->rpdev = NULL;
 	fastrpc_channel_ctx_put(cctx);
 }
 



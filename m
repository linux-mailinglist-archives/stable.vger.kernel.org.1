Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27B4726C0C
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjFGUaa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjFGUaS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:30:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1867826A9
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:29:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F65F644D0
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70DDC433EF;
        Wed,  7 Jun 2023 20:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169792;
        bh=JTuV9J12uZeQ1p9e5CwGKlzb45AIfzLcveympf9JIh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uGzWK3Jo2Vl01Gj7RdI19QiCzyPmCnsoiR68GNfQnXC4LE3DcfHun3rz5zatKDYqf
         JSR7KKZXoV19LXao+aaMQHjlWc5ZEZmH9tmMJeqB9X7ujuuiEYp2yaBPMxiLzZVHRf
         5kXjgi11r3MJ43i6B/tMgHDQHHF2K2shjH+XWG7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6.3 215/286] misc: fastrpc: reject new invocations during device removal
Date:   Wed,  7 Jun 2023 22:15:14 +0200
Message-ID: <20230607200930.283419814@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -2351,7 +2351,9 @@ static void fastrpc_rpmsg_remove(struct
 	struct fastrpc_user *user;
 	unsigned long flags;
 
+	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
+	cctx->rpdev = NULL;
 	list_for_each_entry(user, &cctx->users, user)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -2370,7 +2372,6 @@ static void fastrpc_rpmsg_remove(struct
 
 	of_platform_depopulate(&rpdev->dev);
 
-	cctx->rpdev = NULL;
 	fastrpc_channel_ctx_put(cctx);
 }
 



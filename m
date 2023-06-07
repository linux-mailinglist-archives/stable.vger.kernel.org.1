Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4419726DA5
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjFGUoR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbjFGUoQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:44:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B1C2121
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 777A564647
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8FAC433EF;
        Wed,  7 Jun 2023 20:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170634;
        bh=xguGYtrYFQqynReCB7SGBJJtA9VBenBMo5u+lfjAKq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zlq01O/U8urI0UsVK46vcfDyUpM0TqvoPl+jb3kKYH1/KZPf5GWC0JCRwh0R9sBjr
         JJFSgUe3hG0HZSjacLnqYgSS1w0gVuyDhV/GceA8NvXK6t5NfMOILhrrHT5TUO+ShS
         HRCaXXbUlPWDxNONZC4UHHgbuJG6Oq0X3yZweksw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6.1 160/225] misc: fastrpc: return -EPIPE to invocations on device removal
Date:   Wed,  7 Jun 2023 22:15:53 +0200
Message-ID: <20230607200919.636209306@linuxfoundation.org>
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

commit b6a062853ddf6b4f653af2d8b75ba45bb9a036ad upstream.

The return value is initialized as -1, or -EPERM. The completion of an
invocation implies that the return value is set appropriately, but
"Permission denied" does not accurately describe the outcome of the
invocation. Set the invocation's return value to a more appropriate
"Broken pipe", as the cleanup breaks the driver's connection with rpmsg.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable <stable@kernel.org>
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230523152550.438363-4-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2149,8 +2149,10 @@ static void fastrpc_notify_users(struct
 	struct fastrpc_invoke_ctx *ctx;
 
 	spin_lock(&user->lock);
-	list_for_each_entry(ctx, &user->pending, node)
+	list_for_each_entry(ctx, &user->pending, node) {
+		ctx->retval = -EPIPE;
 		complete(&ctx->work);
+	}
 	spin_unlock(&user->lock);
 }
 



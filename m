Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B1F726AF1
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjFGUVO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjFGUVE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:21:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82130268F
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:20:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 614B664367
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3DEC433D2;
        Wed,  7 Jun 2023 20:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169242;
        bh=AIbABzyTHD7AnBP4JE7Y1/B2zgdqwOA73Bxjgmug+D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozL+DX0O0I6m5aBcjI4u/svTCobxQI0dg5wFa7p6PesJJ/qvU26R4yF8GhVp1lkav
         hcUcpUWmzcqCY3z6ZLBXQUNlA5yn9oeTTdk7p2gNPAYUy+miedIkK1fwmyDH94bymt
         9mX10gBogC8Pci8GEenssvq2GiAODSb/GNJOYRyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
Subject: [PATCH 4.14 39/61] usb: gadget: f_fs: Add unbind event before functionfs_unbind
Date:   Wed,  7 Jun 2023 22:15:53 +0200
Message-ID: <20230607200848.860240752@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200835.310274198@linuxfoundation.org>
References: <20230607200835.310274198@linuxfoundation.org>
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

From: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>

commit efb6b535207395a5c7317993602e2503ca8cb4b3 upstream.

While exercising the unbind path, with the current implementation
the functionfs_unbind would be calling which waits for the ffs->mutex
to be available, however within the same time ffs_ep0_read is invoked
& if no setup packets are pending, it will invoke function
wait_event_interruptible_exclusive_locked_irq which by definition waits
for the ev.count to be increased inside the same mutex for which
functionfs_unbind is waiting.
This creates deadlock situation because the functionfs_unbind won't
get the lock until ev.count is increased which can only happen if
the caller ffs_func_unbind can proceed further.

Following is the illustration:

	CPU1				CPU2

ffs_func_unbind()		ffs_ep0_read()
				mutex_lock(ffs->mutex)
				wait_event(ffs->ev.count)
functionfs_unbind()
  mutex_lock(ffs->mutex)
  mutex_unlock(ffs->mutex)

ffs_event_add()

<deadlock>

Fix this by moving the event unbind before functionfs_unbind
to ensure the ev.count is incrased properly.

Fixes: 6a19da111057 ("usb: gadget: f_fs: Prevent race during ffs_ep0_queue_wait")
Cc: stable <stable@kernel.org>
Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
Link: https://lore.kernel.org/r/20230525092854.7992-1-quic_uaggarwa@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3500,6 +3500,7 @@ static void ffs_func_unbind(struct usb_c
 	/* Drain any pending AIO completions */
 	drain_workqueue(ffs->io_completion_wq);
 
+	ffs_event_add(ffs, FUNCTIONFS_UNBIND);
 	if (!--opts->refcnt)
 		functionfs_unbind(ffs);
 
@@ -3524,7 +3525,6 @@ static void ffs_func_unbind(struct usb_c
 	func->function.ssp_descriptors = NULL;
 	func->interfaces_nums = NULL;
 
-	ffs_event_add(ffs, FUNCTIONFS_UNBIND);
 }
 
 static struct usb_function *ffs_alloc(struct usb_function_instance *fi)



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753AC733F9C
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 10:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjFQI0m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 17 Jun 2023 04:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjFQI0l (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Jun 2023 04:26:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E171FF6
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 01:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FB7A611C0
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 08:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C60C433C8;
        Sat, 17 Jun 2023 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686990399;
        bh=CfpTlndASjlBsAy7VxBBmcPRA8Q30rGBLpU68LJOU18=;
        h=Subject:To:Cc:From:Date:From;
        b=CzeVZ+95soUeWRmbnjI+bun1H+PegmPIyIJdqhtQe3w8EalfH9hONOUPqCxlVzhFW
         Gm/3A0tTVVjFrtklozHBopQGN4MhwvJF5W0DdT1uA+5BcbCDYSoW4zu6IYUevnEejK
         gigyf/2LarqFFUHOjRrivrts0aEFoW0U+NuYfTFE=
Subject: FAILED: patch "[PATCH] epoll: ep_autoremove_wake_function should use" failed to apply to 5.4-stable tree
To:     bsegall@google.com, akpm@linux-foundation.org, brauner@kernel.org,
        stable@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 17 Jun 2023 10:26:37 +0200
Message-ID: <2023061737-smartness-mummify-9865@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2192bba03d80f829233bfa34506b428f71e531e7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061737-smartness-mummify-9865@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2192bba03d80f829233bfa34506b428f71e531e7 Mon Sep 17 00:00:00 2001
From: Benjamin Segall <bsegall@google.com>
Date: Tue, 30 May 2023 11:32:28 -0700
Subject: [PATCH] epoll: ep_autoremove_wake_function should use
 list_del_init_careful

autoremove_wake_function uses list_del_init_careful, so should epoll's
more aggressive variant.  It only doesn't because it was copied from an
older wait.c rather than the most recent.

[bsegall@google.com: add comment]
  Link: https://lkml.kernel.org/r/xm26bki0ulsr.fsf_-_@google.com
Link: https://lkml.kernel.org/r/xm26pm6hvfer.fsf@google.com
Fixes: a16ceb139610 ("epoll: autoremove wakers even more aggressively")
Signed-off-by: Ben Segall <bsegall@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 980483455cc0..266d45c7685b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1805,7 +1805,11 @@ static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
 {
 	int ret = default_wake_function(wq_entry, mode, sync, key);
 
-	list_del_init(&wq_entry->entry);
+	/*
+	 * Pairs with list_empty_careful in ep_poll, and ensures future loop
+	 * iterations see the cause of this wakeup.
+	 */
+	list_del_init_careful(&wq_entry->entry);
 	return ret;
 }
 


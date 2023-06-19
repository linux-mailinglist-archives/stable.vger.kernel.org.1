Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164B6735501
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjFSLAe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjFSLAG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:00:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89CFE7D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:59:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8647760B7F
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2E7C433C8;
        Mon, 19 Jun 2023 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172345;
        bh=g2ZYV9KCYxiVNg+5jigN6Fmz6y2BPzx0k9teME637kU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bIQKoivzbClKCkhPqCYf5ECjqoKf+9B4e0xI+LR/G1ZsY8ECW3LUR2XfMTVLTUYIl
         GFawYVZg7mCOm1rLTNVj5QgeEmCmrqUtx2orrzpm/xbGU1ZlNkLHcLEtNRCKRBmfOB
         QtZnJo9w96160kNieYCaKoOyNRDbMqpEpEZYBh40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Segall <bsegall@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 035/107] epoll: ep_autoremove_wake_function should use list_del_init_careful
Date:   Mon, 19 Jun 2023 12:30:19 +0200
Message-ID: <20230619102143.199096884@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
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

From: Benjamin Segall <bsegall@google.com>

commit 2192bba03d80f829233bfa34506b428f71e531e7 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/eventpoll.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1753,7 +1753,11 @@ static int ep_autoremove_wake_function(s
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
 



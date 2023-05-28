Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1421D713FC0
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjE1Tsh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjE1Tsg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:48:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51829C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7326D6103F
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92974C433D2;
        Sun, 28 May 2023 19:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303314;
        bh=wRHBaeDhawOPG5Ib5RCrD356vYPyA33SmBx6wdrBBSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DF/0La94k63NTXOTnisD8ss1TA8O60oeT8wg0JUToMaUo1JhaNIyl3rFfGifZI7Ez
         F2E146OHN35iNYXoEzA9YYIyePTuyArSb3bzTD8w0zafJLm9qXZszHbt8uv98jo3CO
         E2N6tMW9BnEZtyOuyRodnl7+r9fXcwbL+vCWL9fU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.15 28/69] debugobjects: Dont wake up kswapd from fill_pool()
Date:   Sun, 28 May 2023 20:11:48 +0100
Message-Id: <20230528190829.421780799@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit eb799279fb1f9c63c520fe8c1c41cb9154252db6 upstream.

syzbot is reporting a lockdep warning in fill_pool() because the allocation
from debugobjects is using GFP_ATOMIC, which is (__GFP_HIGH | __GFP_KSWAPD_RECLAIM)
and therefore tries to wake up kswapd, which acquires kswapd_wait::lock.

Since fill_pool() might be called with arbitrary locks held, fill_pool()
should not assume that acquiring kswapd_wait::lock is safe.

Use __GFP_HIGH instead and remove __GFP_NORETRY as it is pointless for
!__GFP_DIRECT_RECLAIM allocation.

Fixes: 3ac7fe5a4aab ("infrastructure to debug (dynamic) objects")
Reported-by: syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/6577e1fa-b6ee-f2be-2414-a2b51b1c5e30@I-love.SAKURA.ne.jp
Closes: https://syzkaller.appspot.com/bug?extid=fe0c72f0ccbb93786380
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/debugobjects.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -129,7 +129,7 @@ static const char *obj_states[ODEBUG_STA
 
 static void fill_pool(void)
 {
-	gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
+	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
 	struct debug_obj *obj;
 	unsigned long flags;
 



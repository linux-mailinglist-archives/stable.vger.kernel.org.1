Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B96078AD1D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjH1Kpy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjH1Kp2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:45:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0775ECD8
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB84F6412D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF766C433C8;
        Mon, 28 Aug 2023 10:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219509;
        bh=cdahRb1tpXp5jTwBQI8+WcVN9Iqfnf1SiFFbWw/gQD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zGLRiZIddcBE8nD1+FqWZthjtTQudjHa+kIj2/ENzRvTlDUE+8AS+y9HgZUkPN3+p
         tyS8SlRcMbSU7lMsqgZeltVH/IkymfFAbX2nmBPK7qqmu3c2PqOHKKrGc/hDF7YHRn
         8QIQXCTfI1xRx/U+4OWXMX+zqy88VR8Uwt/cMWoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Rong Tao <rongtao@cestc.cn>, Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 62/89] radix tree: remove unused variable
Date:   Mon, 28 Aug 2023 12:14:03 +0200
Message-ID: <20230828101152.272681053@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit d59070d1076ec5114edb67c87658aeb1d691d381 upstream.

Recent versions of clang warn about an unused variable, though older
versions saw the 'slot++' as a use and did not warn:

radix-tree.c:1136:50: error: parameter 'slot' set but not used [-Werror,-Wunused-but-set-parameter]

It's clearly not needed any more, so just remove it.

Link: https://lkml.kernel.org/r/20230811131023.2226509-1-arnd@kernel.org
Fixes: 3a08cd52c37c7 ("radix tree: Remove multiorder support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: Rong Tao <rongtao@cestc.cn>
Cc: Tom Rix <trix@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/radix-tree.c |    1 -
 1 file changed, 1 deletion(-)

--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1134,7 +1134,6 @@ static void set_iter_tags(struct radix_t
 void __rcu **radix_tree_iter_resume(void __rcu **slot,
 					struct radix_tree_iter *iter)
 {
-	slot++;
 	iter->index = __radix_tree_iter_add(iter, 1);
 	iter->next_index = iter->index;
 	iter->tags = 0;



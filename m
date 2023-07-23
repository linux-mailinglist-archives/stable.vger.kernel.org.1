Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1BA75E228
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 15:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjGWNyJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 09:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWNyI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 09:54:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1EDE40
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 06:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 210BD60D2E
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 13:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDF2C433C8;
        Sun, 23 Jul 2023 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690120446;
        bh=8QMX+zbHcHtO5ZjZ0gMGiAb2OKFwvmQQq5XwEnZywa0=;
        h=Subject:To:Cc:From:Date:From;
        b=DImsejDloCqZJ1ovhi+bdHqOdIbVz9oDogwZHR8ELEb/WZ73GaATCJH9GL2SzMCaE
         gYN54lz5P6mXW261YDcTqsRqhsiZgq7hDxLzv70HpTZTq1v7t2g5IFsSAxkJCKehB9
         spkBgCABRIwag8qldTeHvmC5Fn+B4O5IyPkaIGY0=
Subject: FAILED: patch "[PATCH] maple_tree: fix 32 bit mas_next testing" failed to apply to 6.4-stable tree
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        geert@linux-m68k.org, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 15:54:03 +0200
Message-ID: <2023072303-possible-backwash-4c0f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 7a93c71a6714ca1a9c03d70432dac104b0cfb815
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072303-possible-backwash-4c0f@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7a93c71a6714ca1a9c03d70432dac104b0cfb815 Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Wed, 12 Jul 2023 13:39:15 -0400
Subject: [PATCH] maple_tree: fix 32 bit mas_next testing

The test setup of mas_next is dependent on node entry size to create a 2
level tree, but the tests did not account for this in the expected value
when shifting beyond the scope of the tree.

Fix this by setting up the test to succeed depending on the node entries
which is dependent on the 32/64 bit setup.

Link: https://lkml.kernel.org/r/20230712173916.168805-1-Liam.Howlett@oracle.com
Fixes: 120b116208a0 ("maple_tree: reorganize testing to restore module testing")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
  Closes: https://lore.kernel.org/linux-mm/CAMuHMdV4T53fOw7VPoBgPR7fP6RYqf=CBhD_y_vOg53zZX_DnA@mail.gmail.com/
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 9939be34e516..8d4c92cbdd0c 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1898,13 +1898,16 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 						   725};
 	static const unsigned long level2_32[] = { 1747, 2000, 1750, 1755,
 						   1760, 1765};
+	unsigned long last_index;
 
 	if (MAPLE_32BIT) {
 		nr_entries = 500;
 		level2 = level2_32;
+		last_index = 0x138e;
 	} else {
 		nr_entries = 200;
 		level2 = level2_64;
+		last_index = 0x7d6;
 	}
 
 	for (i = 0; i <= nr_entries; i++)
@@ -2011,7 +2014,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 
 	val = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, val != NULL);
-	MT_BUG_ON(mt, mas.index != 0x7d6);
+	MT_BUG_ON(mt, mas.index != last_index);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
 
 	val = mas_prev(&mas, 0);


Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A627898F5
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 22:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjHZUPu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 16:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjHZUPZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 16:15:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CCF1AD
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 13:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB4D0613C5
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 20:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD497C433C8;
        Sat, 26 Aug 2023 20:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693080922;
        bh=E6K3FqQFL2TdIjEnOJr1TbAtIZhVJEk9sTdBTtbTgOU=;
        h=Subject:To:Cc:From:Date:From;
        b=d0vQDdtv6iokMSwx5QBiSxxswIGZ1D1fop7i2JkP+f7TXfszBD8CzJ9ex2h613jF5
         bZHrIluM2B8jkLwLjS3+oD51HI2xCjv0nGE0J4xnv+W9PAw0jPafUOjlCa/2MHLA11
         gVTsz3ERYI2bdOEqbPJBevukLEQ7805SgqnhMOz4=
Subject: FAILED: patch "[PATCH] mm: memory-failure: fix unexpected return value in" failed to apply to 5.10-stable tree
To:     linmiaohe@huawei.com, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 26 Aug 2023 22:15:19 +0200
Message-ID: <2023082619-rocky-strobe-5ad9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e2c1ab070fdc81010ec44634838d24fce9ff9e53
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082619-rocky-strobe-5ad9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

e2c1ab070fdc ("mm: memory-failure: fix unexpected return value in soft_offline_page()")
7adb45887c8a ("mm: memory-failure: kill soft_offline_free_page()")
2a57d83c78f8 ("mm/hwpoison: clear MF_COUNT_INCREASED before retrying get_any_page()")
dad4e5b39086 ("mm: fix page reference leak in soft_offline_page()")
8295d535e2aa ("mm,hwpoison: refactor get_any_page")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e2c1ab070fdc81010ec44634838d24fce9ff9e53 Mon Sep 17 00:00:00 2001
From: Miaohe Lin <linmiaohe@huawei.com>
Date: Tue, 27 Jun 2023 19:28:08 +0800
Subject: [PATCH] mm: memory-failure: fix unexpected return value in
 soft_offline_page()

When page_handle_poison() fails to handle the hugepage or free page in
retry path, soft_offline_page() will return 0 while -EBUSY is expected in
this case.

Consequently the user will think soft_offline_page succeeds while it in
fact failed.  So the user will not try again later in this case.

Link: https://lkml.kernel.org/r/20230627112808.1275241-1-linmiaohe@huawei.com
Fixes: b94e02822deb ("mm,hwpoison: try to narrow window race for free pages")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 139b31fdb678..fe121fdb05f7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2741,10 +2741,13 @@ int soft_offline_page(unsigned long pfn, int flags)
 	if (ret > 0) {
 		ret = soft_offline_in_use_page(page);
 	} else if (ret == 0) {
-		if (!page_handle_poison(page, true, false) && try_again) {
-			try_again = false;
-			flags &= ~MF_COUNT_INCREASED;
-			goto retry;
+		if (!page_handle_poison(page, true, false)) {
+			if (try_again) {
+				try_again = false;
+				flags &= ~MF_COUNT_INCREASED;
+				goto retry;
+			}
+			ret = -EBUSY;
 		}
 	}
 


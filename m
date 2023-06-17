Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99631733F90
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 10:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjFQISC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 17 Jun 2023 04:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346111AbjFQISB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Jun 2023 04:18:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005B81FF6
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 01:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A7B960C96
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 08:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B25DC433C0;
        Sat, 17 Jun 2023 08:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686989880;
        bh=NMHsrtg/jBuC8AJtV17bgAG9k3dEEvx/WjNZaJEFNv0=;
        h=Subject:To:Cc:From:Date:From;
        b=yOP9nvBi95NoB3DzN/rSX/Wx0kCajaX0AoGtt32m0lHlF20XrZychlx4c9Y6BP5Xl
         sfn7QTU2EGQrrYNArqkHKl0XpPiEDM+1mMmWGYusJUSer+FZRMCaoEkNx3pSjiLplB
         yPR6G//zjaV+AjLRwtQSxFDIOYxkLBz9UdWxzOzU=
Subject: FAILED: patch "[PATCH] mm/gup_test: fix ioctl fail for compat task" failed to apply to 5.4-stable tree
To:     haibo.li@mediatek.com, akpm@linux-foundation.org,
        angelogioacchino.delregno@collabora.com, david@redhat.com,
        jhubbard@nvidia.com, matthias.bgg@gmail.com, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 17 Jun 2023 10:17:52 +0200
Message-ID: <2023061752-reprint-almighty-b42b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 4f572f0074b8be8a70bd150d96a749aa94c8d85f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061752-reprint-almighty-b42b@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f572f0074b8be8a70bd150d96a749aa94c8d85f Mon Sep 17 00:00:00 2001
From: Haibo Li <haibo.li@mediatek.com>
Date: Fri, 26 May 2023 10:21:25 +0800
Subject: [PATCH] mm/gup_test: fix ioctl fail for compat task

When tools/testing/selftests/mm/gup_test.c is compiled as 32bit, then run
on arm64 kernel, it reports "ioctl: Inappropriate ioctl for device".

Fix it by filling compat_ioctl in gup_test_fops

Link: https://lkml.kernel.org/r/20230526022125.175728-1-haibo.li@mediatek.com
Signed-off-by: Haibo Li <haibo.li@mediatek.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/gup_test.c b/mm/gup_test.c
index 8ae7307a1bb6..c0421b786dcd 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -381,6 +381,7 @@ static int gup_test_release(struct inode *inode, struct file *file)
 static const struct file_operations gup_test_fops = {
 	.open = nonseekable_open,
 	.unlocked_ioctl = gup_test_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.release = gup_test_release,
 };
 


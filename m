Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF177A117
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 18:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjHLQgC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 12:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHLQgC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 12:36:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AC11702
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 09:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEA4E61EF4
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 16:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F6FC433C7;
        Sat, 12 Aug 2023 16:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691858164;
        bh=/sF9/l2izlVkPGHhY/47pQ7WGBOfWgO2L9pW+H/9r/M=;
        h=Subject:To:Cc:From:Date:From;
        b=dpBgwszMTQlhpjyRpbc8/jMASmYDI2B+cyMlJ4u4CETfoEdea9gfgOI++DQGQJl0O
         Y++rnf13JoHY3ozoe/Ttn/Js6TZFdDfEFbOmhL0QF4LtYhAQF6WpG2KV6Q/EbB5SZs
         qP9WFcYaP81KtQOgEWnrPBV+xbPPVqalTTeetkbs=
Subject: FAILED: patch "[PATCH] binder: fix memory leak in binder_init()" failed to apply to 4.14-stable tree
To:     zhengqi.arch@bytedance.com, cmllamas@google.com,
        gregkh@linuxfoundation.org, stable@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 18:36:01 +0200
Message-ID: <2023081201-exhale-bonelike-1800@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x adb9743d6a08778b78d62d16b4230346d3508986
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081201-exhale-bonelike-1800@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From adb9743d6a08778b78d62d16b4230346d3508986 Mon Sep 17 00:00:00 2001
From: Qi Zheng <zhengqi.arch@bytedance.com>
Date: Sun, 25 Jun 2023 15:49:37 +0000
Subject: [PATCH] binder: fix memory leak in binder_init()

In binder_init(), the destruction of binder_alloc_shrinker_init() is not
performed in the wrong path, which will cause memory leaks. So this commit
introduces binder_alloc_shrinker_exit() and calls it in the wrong path to
fix that.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Carlos Llamas <cmllamas@google.com>
Fixes: f2517eb76f1f ("android: binder: Add global lru shrinker to binder")
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20230625154937.64316-1-qi.zheng@linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 486c8271cab7..d720f93d8b19 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6617,6 +6617,7 @@ static int __init binder_init(void)
 
 err_alloc_device_names_failed:
 	debugfs_remove_recursive(binder_debugfs_dir_entry_root);
+	binder_alloc_shrinker_exit();
 
 	return ret;
 }
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 662a2a2e2e84..e3db8297095a 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1087,6 +1087,12 @@ int binder_alloc_shrinker_init(void)
 	return ret;
 }
 
+void binder_alloc_shrinker_exit(void)
+{
+	unregister_shrinker(&binder_shrinker);
+	list_lru_destroy(&binder_alloc_lru);
+}
+
 /**
  * check_buffer() - verify that buffer/offset is safe to access
  * @alloc: binder_alloc for this proc
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 138d1d5af9ce..dc1e2b01dd64 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -129,6 +129,7 @@ extern struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 						  int pid);
 extern void binder_alloc_init(struct binder_alloc *alloc);
 extern int binder_alloc_shrinker_init(void);
+extern void binder_alloc_shrinker_exit(void);
 extern void binder_alloc_vma_close(struct binder_alloc *alloc);
 extern struct binder_buffer *
 binder_alloc_prepare_to_free(struct binder_alloc *alloc,


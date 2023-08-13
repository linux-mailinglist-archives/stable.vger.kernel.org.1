Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9238C77ADAC
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjHMVug (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjHMVt0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:49:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE86230CA
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:48:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D39C63E8B
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443BDC433C8;
        Sun, 13 Aug 2023 21:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963294;
        bh=eJIGWN3tjneuP36zsd0VF25VoMxas/P2/Gg0YEBUJnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=II/NEdPhA40+CwXkg8XfOx3vZuOWOYQzmc1xdHUBmWFoj/EJZORHCV11R+EUEmm6b
         ZCs/SjhQLesqB2tq4BAQO/tvjL2HmVm7LDVsmFg6N1g0C9fj7P1AtupG9bWhiCbiMJ
         PK08Yu/UdzwZQwfgFOeKjCIVA1jfClHAjmjnW8tg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>,
        Carlos Llamas <cmllamas@google.com>, stable <stable@kernel.org>
Subject: [PATCH 5.4 09/39] binder: fix memory leak in binder_init()
Date:   Sun, 13 Aug 2023 23:20:00 +0200
Message-ID: <20230813211705.151097946@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211704.796906808@linuxfoundation.org>
References: <20230813211704.796906808@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

commit adb9743d6a08778b78d62d16b4230346d3508986 upstream.

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
---
 drivers/android/binder.c       |    1 +
 drivers/android/binder_alloc.c |    6 ++++++
 drivers/android/binder_alloc.h |    1 +
 3 files changed, 8 insertions(+)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6555,6 +6555,7 @@ err_init_binder_device_failed:
 
 err_alloc_device_names_failed:
 	debugfs_remove_recursive(binder_debugfs_dir_entry_root);
+	binder_alloc_shrinker_exit();
 
 	return ret;
 }
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1037,6 +1037,12 @@ int binder_alloc_shrinker_init(void)
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
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -122,6 +122,7 @@ extern struct binder_buffer *binder_allo
 						  int is_async);
 extern void binder_alloc_init(struct binder_alloc *alloc);
 extern int binder_alloc_shrinker_init(void);
+extern void binder_alloc_shrinker_exit(void);
 extern void binder_alloc_vma_close(struct binder_alloc *alloc);
 extern struct binder_buffer *
 binder_alloc_prepare_to_free(struct binder_alloc *alloc,



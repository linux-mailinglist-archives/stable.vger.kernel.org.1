Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE32977AB80
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjHMVWo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjHMVWj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1276D10D0
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:22:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A53BA62805
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE96C433C9;
        Sun, 13 Aug 2023 21:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961761;
        bh=7mu/si+ElL7c1IyxH0FcP4Ip2pyV83iJYbrmGIKc0ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sF8366mSqcGyqj6lTCNmrbLGC4HQUmDP9/ANQGs+yA0Vybwhj8J3sFAHDj+DGUwB1
         InSK8Ws84UP99hj5evdNog904m7xHZlits+oXnFx2sbSRfTm3HO2CkXScoea5HNpM5
         Kgl+fya+is7o2r+P5ZBaYjXVgQ185v/bgS5AjwQE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>,
        Carlos Llamas <cmllamas@google.com>, stable <stable@kernel.org>
Subject: [PATCH 4.19 09/33] binder: fix memory leak in binder_init()
Date:   Sun, 13 Aug 2023 23:19:03 +0200
Message-ID: <20230813211704.268520428@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211703.915807095@linuxfoundation.org>
References: <20230813211703.915807095@linuxfoundation.org>
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
@@ -5742,6 +5742,7 @@ err_init_binder_device_failed:
 
 err_alloc_device_names_failed:
 	debugfs_remove_recursive(binder_debugfs_dir_entry_root);
+	binder_alloc_shrinker_exit();
 
 	return ret;
 }
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1033,6 +1033,12 @@ static struct shrinker binder_shrinker =
 	.seeks = DEFAULT_SEEKS,
 };
 
+void binder_alloc_shrinker_exit(void)
+{
+	unregister_shrinker(&binder_shrinker);
+	list_lru_destroy(&binder_alloc_lru);
+}
+
 /**
  * binder_alloc_init() - called by binder_open() for per-proc initialization
  * @alloc: binder_alloc for this proc
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -130,6 +130,7 @@ extern struct binder_buffer *binder_allo
 						  int is_async);
 extern void binder_alloc_init(struct binder_alloc *alloc);
 extern int binder_alloc_shrinker_init(void);
+extern void binder_alloc_shrinker_exit(void);
 extern void binder_alloc_vma_close(struct binder_alloc *alloc);
 extern struct binder_buffer *
 binder_alloc_prepare_to_free(struct binder_alloc *alloc,



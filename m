Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1338C7554EC
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjGPUf1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjGPUfY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:35:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41A79F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:35:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A74660E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D95AC433C8;
        Sun, 16 Jul 2023 20:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539722;
        bh=FMffp9bl6w3AoUWCJamGOlX7wj1LoFlONsrbGrNd/iM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYUfIWPKuYMYB0+hPLeiKfoCnvtnd1cxCHVePfDzYesgulRmiHO88gk02bxIXJk6K
         fy/TPIyRGraHVPbaScJXtaYmrgd1gBNNK/B3+tO3x8gblscwJLzuWwWu9nVjScAmcU
         GUUWMkZgq9Mvn9FCKg1CuH/WeMjlWQ9JCgXy8dKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yafang Shao <laoar.shao@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <song@kernel.org>, Jiri Olsa <olsajiri@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 081/591] bpf: Remove bpf trampoline selector
Date:   Sun, 16 Jul 2023 21:43:40 +0200
Message-ID: <20230716194925.977502131@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>

[ Upstream commit 47e79cbeea4b3891ad476047f4c68543eb51c8e0 ]

After commit e21aa341785c ("bpf: Fix fexit trampoline."), the selector is only
used to indicate how many times the bpf trampoline image are updated and been
displayed in the trampoline ksym name. After the trampoline is freed, the
selector will start from 0 again. So the selector is a useless value to the
user. We can remove it.

If the user want to check whether the bpf trampoline image has been updated
or not, the user can compare the address. Each time the trampoline image is
updated, the address will change consequently. Jiri also pointed out another
issue that perf is still using the old name "bpf_trampoline_%lu", so this
change can fix the issue in perf.

Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Song Liu <song@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>
Link: https://lore.kernel.org/bpf/ZFvOOlrmHiY9AgXE@krava
Link: https://lore.kernel.org/bpf/20230515130849.57502-3-laoar.shao@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h     |  1 -
 kernel/bpf/trampoline.c | 11 ++++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 942f9ac9fa7b6..8cef9ec3a89c2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -933,7 +933,6 @@ struct bpf_trampoline {
 	int progs_cnt[BPF_TRAMP_MAX];
 	/* Executable image of trampoline */
 	struct bpf_tramp_image *cur_image;
-	u64 selector;
 	struct module *mod;
 };
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f1504cb5b6e19..91d8de938a3dd 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -372,7 +372,7 @@ static void bpf_tramp_image_put(struct bpf_tramp_image *im)
 	call_rcu_tasks_trace(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
 }
 
-static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, u32 idx)
+static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key)
 {
 	struct bpf_tramp_image *im;
 	struct bpf_ksym *ksym;
@@ -399,7 +399,7 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, u32 idx)
 
 	ksym = &im->ksym;
 	INIT_LIST_HEAD_RCU(&ksym->lnode);
-	snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%llu_%u", key, idx);
+	snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%llu", key);
 	bpf_image_ksym_add(image, ksym);
 	return im;
 
@@ -429,11 +429,10 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		err = unregister_fentry(tr, tr->cur_image->image);
 		bpf_tramp_image_put(tr->cur_image);
 		tr->cur_image = NULL;
-		tr->selector = 0;
 		goto out;
 	}
 
-	im = bpf_tramp_image_alloc(tr->key, tr->selector);
+	im = bpf_tramp_image_alloc(tr->key);
 	if (IS_ERR(im)) {
 		err = PTR_ERR(im);
 		goto out;
@@ -471,8 +470,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	set_memory_ro((long)im->image, 1);
 	set_memory_x((long)im->image, 1);
 
-	WARN_ON(tr->cur_image && tr->selector == 0);
-	WARN_ON(!tr->cur_image && tr->selector);
+	WARN_ON(tr->cur_image && total == 0);
 	if (tr->cur_image)
 		/* progs already running at this address */
 		err = modify_fentry(tr, tr->cur_image->image, im->image, lock_direct_mutex);
@@ -502,7 +500,6 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (tr->cur_image)
 		bpf_tramp_image_put(tr->cur_image);
 	tr->cur_image = im;
-	tr->selector++;
 out:
 	/* If any error happens, restore previous flags */
 	if (err)
-- 
2.39.2




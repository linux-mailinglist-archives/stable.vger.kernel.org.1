Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED4F7A39A8
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbjIQTxF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240136AbjIQTwq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:52:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F25CCC4
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:52:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D711C433CD;
        Sun, 17 Sep 2023 19:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980337;
        bh=pU0p9780dtn6CnZNE+9uIF67WFRb4UcUtb72quRvovk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SRMMYlQKR2pDGdUFbiSqraEq0yKQzxx8KEjCp/9ZEtQtBuMEyrzbsqqtHCr+qf5LT
         OnaBwg106+9z7++oQ1UjJKzjCUd6Zo4wjpu/VJNiGh/eTNGcKqXjOU7Wp1B6ORLQoI
         TFEMBTaePSozTknR9XfO3vqAZTKRhLcPB7L50go8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin KaFai Lau <martin.lau@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 161/285] bpf: bpf_sk_storage: Fix the missing uncharge in sk_omem_alloc
Date:   Sun, 17 Sep 2023 21:12:41 +0200
Message-ID: <20230917191057.241079311@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit 55d49f750b1cb1f177fb1b00ae02cba4613bcfb7 ]

The commit c83597fa5dc6 ("bpf: Refactor some inode/task/sk storage functions
for reuse"), refactored the bpf_{sk,task,inode}_storage_free() into
bpf_local_storage_unlink_nolock() which then later renamed to
bpf_local_storage_destroy(). The commit accidentally passed the
"bool uncharge_mem = false" argument to bpf_selem_unlink_storage_nolock()
which then stopped the uncharge from happening to the sk->sk_omem_alloc.

This missing uncharge only happens when the sk is going away (during
__sk_destruct).

This patch fixes it by always passing "uncharge_mem = true". It is a
noop to the task/inode/cgroup storage because they do not have the
map_local_storage_(un)charge enabled in the map_ops. A followup patch
will be done in bpf-next to remove the uncharge_mem argument.

A selftest is added in the next patch.

Fixes: c83597fa5dc6 ("bpf: Refactor some inode/task/sk storage functions for reuse")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230901231129.578493-3-martin.lau@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 37ad47d52dc55..146824cc96893 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -760,7 +760,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		 * of the loop will set the free_cgroup_storage to true.
 		 */
 		free_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, false, true);
+			local_storage, selem, true, true);
 	}
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
-- 
2.40.1




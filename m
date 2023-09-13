Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A498879F386
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 23:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjIMVNI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 17:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjIMVNH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 17:13:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC951727
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 14:13:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b50b45481so3300937b3.1
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 14:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694639583; x=1695244383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jlwwRYKolGdaJq97Bj9Gajw/WIXHBB+JTw0vVnL2jRo=;
        b=Ef7l180mIOl1QdYzG9SQESfKETyYh6J8Nkf2o9Kza1LUQm8a0Uql1X5vIGciustMxg
         IWq89Hm0A2uOzSbuYNLqnpUslS+F22wtFW8Nv8PF2R/v+N2ub44IYXT+t0sctcxTYYZL
         RkMmPIxqePueZ/zcrv9K38ZPzEPkeOdqVdg5XTuUwfb8sWi2jt/4APUyhlbbzK/iXuTF
         qexVVBHW3gErC6LMkfduk93yBW58OlrdqOMd7kDlfLqylP8jtryLJRjw7PuvQTV7t7vD
         SuX+eaUdqmsN+qR07/TyNbA1Wd3WgY7xuLQc0CrNV2LOAUR+VPIuvmlUUPfA/N6Rw+uH
         8nWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694639583; x=1695244383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlwwRYKolGdaJq97Bj9Gajw/WIXHBB+JTw0vVnL2jRo=;
        b=rqdN4zFDF5ZB9K1WLtqqeVNEhaAquhSYooC1l1NhbDBjU/a5kE+BUm35ZXWJf6YVDR
         dto7dWizBeaZOnR7OOCqq2X+RSUw4GIW8ur2PhIYmW/MbHgmz3avysCS+ZHJoBp/yQml
         ptvMbTl9NgIrJ96bTDub/QXlkx7trU7n0MV2DcnpkLmz+dr6W2GLeLlilabSC1a/X6vN
         Ld7zi+E+sXhpe9/RxdaH4W0u+tHPkat3uN+eaYmZq/MBehnuyAP1F/XyB13xDO3MdSVY
         8dywh/mot9RycVx0CrhQgEjdxaj0Wca3sFQRfcN/wpIKghFhnbE4a8CfA2NLppH84UNQ
         YGxA==
X-Gm-Message-State: AOJu0YyMY+wV2C58VI1tzqATzp27ZFQ3/D0yaYh4iaE42afd/2heRFV5
        Uf32CkEhCmU1WAAbaNzd+qtaRNt4dv/HdIS+ko53F4Z6PQSIZYZAfQ9glWhp5Uk++aIo/LuDav1
        0eNQYlH4NTSux/ZvlOcrmKpk7MSV6J4KK2PfyQkm1wVIsPiyvRht3sGKGMBbUukzgUZMfxaTuuu
        k=
X-Google-Smtp-Source: AGHT+IHFvrmWQiQS91JyW5gmknEk/mpqLqz9cmSgnu1zNarIiSNCV2wA9ODBLcV3fUVMxGRgvm92gleJsXepoKQ7xw==
X-Received: from kalesh.mtv.corp.google.com ([2620:15c:211:201:e754:398c:6102:c530])
 (user=kaleshsingh job=sendgmr) by 2002:a81:c107:0:b0:584:3d8f:a425 with SMTP
 id f7-20020a81c107000000b005843d8fa425mr110034ywi.10.1694639582448; Wed, 13
 Sep 2023 14:13:02 -0700 (PDT)
Date:   Wed, 13 Sep 2023 14:12:56 -0700
In-Reply-To: <2023091354-atom-tinderbox-b9be@gregkh>
Mime-Version: 1.0
References: <2023091354-atom-tinderbox-b9be@gregkh>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913211256.2552031-1-kaleshsingh@google.com>
Subject: [PATCH 6.1.y] Multi-gen LRU: avoid race in inc_min_seq()
From:   Kalesh Singh <kaleshsingh@google.com>
To:     stable@vger.kernel.org
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Yu Zhao <yuzhao@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Barry Song <baohua@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

inc_max_seq() will try to inc_min_seq() if nr_gens == MAX_NR_GENS. This
is because the generations are reused (the last oldest now empty
generation will become the next youngest generation).

inc_min_seq() is retried until successful, dropping the lru_lock
and yielding the CPU on each failure, and retaking the lock before
trying again:

        while (!inc_min_seq(lruvec, type, can_swap)) {
                spin_unlock_irq(&lruvec->lru_lock);
                cond_resched();
                spin_lock_irq(&lruvec->lru_lock);
        }

However, the initial condition that required incrementing the min_seq
(nr_gens == MAX_NR_GENS) is not retested. This can change by another
call to inc_max_seq() from run_aging() with force_scan=true from the
debugfs interface.

Since the eviction stalls when the nr_gens == MIN_NR_GENS, avoid
unnecessarily incrementing the min_seq by rechecking the number of
generations before each attempt.

This issue was uncovered in previous discussion on the list by Yu Zhao
and Aneesh Kumar [1].

[1] https://lore.kernel.org/linux-mm/CAOUHufbO7CaVm=xjEb1avDhHVvnC8pJmGyKcFf2iY_dpf+zR3w@mail.gmail.com/

Link: https://lkml.kernel.org/r/20230802025606.346758-2-kaleshsingh@google.com
Fixes: d6c3af7d8a2b ("mm: multi-gen LRU: debugfs interface")
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> [mediatek]
Tested-by: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
Cc: Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Steven Barrett <steven@liquorix.net>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit bb5e7f234eacf34b65be67ebb3613e3b8cf11b87)
---
 mm/vmscan.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d18296109aa7..251e7b8a0bc0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4331,6 +4331,7 @@ static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_scan)
 	int type, zone;
 	struct lru_gen_struct *lrugen = &lruvec->lrugen;
 
+restart:
 	spin_lock_irq(&lruvec->lru_lock);
 
 	VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
@@ -4341,11 +4342,12 @@ static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_scan)
 
 		VM_WARN_ON_ONCE(!force_scan && (type == LRU_GEN_FILE || can_swap));
 
-		while (!inc_min_seq(lruvec, type, can_swap)) {
-			spin_unlock_irq(&lruvec->lru_lock);
-			cond_resched();
-			spin_lock_irq(&lruvec->lru_lock);
-		}
+		if (inc_min_seq(lruvec, type, can_swap))
+			continue;
+
+		spin_unlock_irq(&lruvec->lru_lock);
+		cond_resched();
+		goto restart;
 	}
 
 	/*
-- 
2.42.0.283.g2d96d420d3-goog


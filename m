Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B6F79F1B5
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjIMTHD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjIMTHC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:07:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31CC170F
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:06:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6C4C433C7;
        Wed, 13 Sep 2023 19:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694632018;
        bh=xU1pWsxABY4YXbOyPOjw40p6xyVAahYm7ilSEqjip3E=;
        h=Subject:To:Cc:From:Date:From;
        b=NWUP02Qqw/Era6SLBAXDCUZOQMtSEAMaYhzVbQIj5S4avPYqCdpQsyR9P2rk5R+B2
         COKGWeLcpmwlTikq6dXDq/J6QWD/v7WPlzVCyvwB3kGPK1bB5nzXAYA7FADwjWOrpu
         06SyHyAGq0K6fSRyxABWsUgQ6iubyPyCNpxx1wF8=
Subject: FAILED: patch "[PATCH] Multi-gen LRU: avoid race in inc_min_seq()" failed to apply to 6.1-stable tree
To:     kaleshsingh@google.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com,
        angelogioacchino.delregno@collabora.com, baohua@kernel.org,
        bgeffon@google.com, heftig@archlinux.org,
        lecopzer.chen@mediatek.com, matthias.bgg@gmail.com,
        oleksandr@natalenko.name, quic_charante@quicinc.com,
        stable@vger.kernel.org, steven@liquorix.net, suleiman@google.com,
        surenb@google.com, yuzhao@google.com, zhengqi.arch@bytedance.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:06:54 +0200
Message-ID: <2023091354-atom-tinderbox-b9be@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x bb5e7f234eacf34b65be67ebb3613e3b8cf11b87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091354-atom-tinderbox-b9be@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

bb5e7f234eac ("Multi-gen LRU: avoid race in inc_min_seq()")
391655fe08d1 ("mm: multi-gen LRU: rename lru_gen_struct to lru_gen_folio")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bb5e7f234eacf34b65be67ebb3613e3b8cf11b87 Mon Sep 17 00:00:00 2001
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 1 Aug 2023 19:56:03 -0700
Subject: [PATCH] Multi-gen LRU: avoid race in inc_min_seq()

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

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 489a4fc7d9b1..6eecd291756c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4439,7 +4439,7 @@ static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_scan)
 	int prev, next;
 	int type, zone;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
-
+restart:
 	spin_lock_irq(&lruvec->lru_lock);
 
 	VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
@@ -4450,11 +4450,12 @@ static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_scan)
 
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


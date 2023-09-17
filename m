Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF1C7A3A41
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjIQUBl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbjIQUAr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:00:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FFA1A1
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B46AC433CA;
        Sun, 17 Sep 2023 20:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980825;
        bh=qTzgIdDGu0jVRANRX61rnfgmaBmjwEMyiU5PLxusJjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQ3+Le2Hr2AbqgbvkdirTqP+3IS+BVPO5eVR7wD42XXoTwOW7DNZ0IODtvDtJ6djg
         hLq5OCjJOBuypu3pUB7eFSNxfLCIlOTzX+p8iqYEiWXwqSNbuUgli1KRrjWxNPbFe8
         lUjfdqO1XHuRvbaGpu0IuH04kizGo26ssXrbRE8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kalesh Singh <kaleshsingh@google.com>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Yu Zhao <yuzhao@google.com>, Barry Song <baohua@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 6.1 003/219] Multi-gen LRU: fix per-zone reclaim
Date:   Sun, 17 Sep 2023 21:12:10 +0200
Message-ID: <20230917191041.085728494@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kalesh Singh <kaleshsingh@google.com>

commit 669281ee7ef731fb5204df9d948669bf32a5e68d upstream.

MGLRU has a LRU list for each zone for each type (anon/file) in each
generation:

	long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];

The min_seq (oldest generation) can progress independently for each
type but the max_seq (youngest generation) is shared for both anon and
file. This is to maintain a common frame of reference.

In order for eviction to advance the min_seq of a type, all the per-zone
lists in the oldest generation of that type must be empty.

The eviction logic only considers pages from eligible zones for
eviction or promotion.

    scan_folios() {
	...
	for (zone = sc->reclaim_idx; zone >= 0; zone--)  {
	    ...
	    sort_folio(); 	// Promote
	    ...
	    isolate_folio(); 	// Evict
	}
	...
    }

Consider the system has the movable zone configured and default 4
generations. The current state of the system is as shown below
(only illustrating one type for simplicity):

Type: ANON

	Zone    DMA32     Normal    Movable    Device

	Gen 0       0          0        4GB         0

	Gen 1       0        1GB        1MB         0

	Gen 2     1MB        4GB        1MB         0

	Gen 3     1MB        1MB        1MB         0

Now consider there is a GFP_KERNEL allocation request (eligible zone
index <= Normal), evict_folios() will return without doing any work
since there are no pages to scan in the eligible zones of the oldest
generation. Reclaim won't make progress until triggered from a ZONE_MOVABLE
allocation request; which may not happen soon if there is a lot of free
memory in the movable zone. This can lead to OOM kills, although there
is 1GB pages in the Normal zone of Gen 1 that we have not yet tried to
reclaim.

This issue is not seen in the conventional active/inactive LRU since
there are no per-zone lists.

If there are no (not enough) folios to scan in the eligible zones, move
folios from ineligible zone (zone_index > reclaim_index) to the next
generation. This allows for the progression of min_seq and reclaiming
from the next generation (Gen 1).

Qualcomm, Mediatek and raspberrypi [1] discovered this issue independently.

[1] https://github.com/raspberrypi/linux/issues/5395

Link: https://lkml.kernel.org/r/20230802025606.346758-1-kaleshsingh@google.com
Fixes: ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
Reported-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> [mediatek]
Tested-by: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Steven Barrett <steven@liquorix.net>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmscan.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4728,7 +4728,8 @@ void lru_gen_look_around(struct page_vma
  *                          the eviction
  ******************************************************************************/
 
-static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
+static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_control *sc,
+		       int tier_idx)
 {
 	bool success;
 	int gen = folio_lru_gen(folio);
@@ -4779,6 +4780,13 @@ static bool sort_folio(struct lruvec *lr
 		return true;
 	}
 
+	/* ineligible */
+	if (zone > sc->reclaim_idx) {
+		gen = folio_inc_gen(lruvec, folio, false);
+		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
+		return true;
+	}
+
 	/* waiting for writeback */
 	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
 	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
@@ -4831,7 +4839,8 @@ static bool isolate_folio(struct lruvec
 static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 		       int type, int tier, struct list_head *list)
 {
-	int gen, zone;
+	int i;
+	int gen;
 	enum vm_event_item item;
 	int sorted = 0;
 	int scanned = 0;
@@ -4847,9 +4856,10 @@ static int scan_folios(struct lruvec *lr
 
 	gen = lru_gen_from_seq(lrugen->min_seq[type]);
 
-	for (zone = sc->reclaim_idx; zone >= 0; zone--) {
+	for (i = MAX_NR_ZONES; i > 0; i--) {
 		LIST_HEAD(moved);
 		int skipped = 0;
+		int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
 		struct list_head *head = &lrugen->folios[gen][type][zone];
 
 		while (!list_empty(head)) {
@@ -4863,7 +4873,7 @@ static int scan_folios(struct lruvec *lr
 
 			scanned += delta;
 
-			if (sort_folio(lruvec, folio, tier))
+			if (sort_folio(lruvec, folio, sc, tier))
 				sorted += delta;
 			else if (isolate_folio(lruvec, folio, sc)) {
 				list_add(&folio->lru, list);



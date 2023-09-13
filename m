Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC55D79DEB2
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 05:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjIMDk4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 23:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjIMDkz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 23:40:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845D51719
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 20:40:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d80256afb63so1050801276.0
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 20:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694576450; x=1695181250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L8UjFdK9obY570gjbekKcFr5bvZgcNDhQUatGZtomTY=;
        b=nhGlXX5CZ06FpwIVfrPA3CajkKKt9s+ZjsfVr8KTHuJ5dxPVVW55QMco+YqA1492DH
         jA7GYhiTwr+43ic+vloOrML86s5u1HGLtvqX90aaZD84kC6UfRIqt2vAD+vKNw0ofGak
         10CwltlNfowVP2j32hdhnVYqTYByVh4KWyw/FY4rlhFzbyLX8VfVaNZvx8rrd4nybZd8
         ZI+HL9EbtaAaXg1/znHSwtc96XudkFz7mOCqBAPOTPAKA4s/EZKLhxi1Xpjvwq3cSfk8
         oK0oLbNfrLa7NuVuLegE7rgvTE4E215miZRwF2iaYStOtTXr5CKm2P0MEvhGZ09h1+vm
         zQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694576450; x=1695181250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8UjFdK9obY570gjbekKcFr5bvZgcNDhQUatGZtomTY=;
        b=fZedepfJmRf5NU0wKFFHiwhYVjvbYgZBY7ib3aOCrWmzMhz1Ua1f8ydZSckiKYWlW5
         AWHcbFr5GE65cMSRwyjWvUNAQhn2IgudBHG1/BRkXY6cQUmeVxxWgSY/nbvg8nHcDUSl
         cQxB8lo7pkCsHlCpfc4Q43eKrgAleRY+wKGrYian38jgYLEPm9q3yYcXN7pLRInuSEnS
         SFbDplWzr23g6XlH5WXGFtNER1xz4f4AX0pbedNPrGZE/5G+nX8fyCoLXXQwzIDFAXhy
         CiiqXhp8VplVsZ37PKuUJk8j+XPmmcnV4+lBIbyAydVzXHenwz0MVrpSElpgbdQe+iXJ
         LSNA==
X-Gm-Message-State: AOJu0YzMVZ7zrJW3YAPa46klm0GkW4ONhfcIQEsKB+nIF0lpAWszOZax
        u81XBAW4UcRL2OVFYHOU4gu1cKXgcI8u1G0h+GA2Zs/tCKTUSHhxzoGs555rvulJ7QFVmZIwE6w
        6ZlF6zQWe4CV9m5W/wlYMR7LQ1OKwrTm8Bl0VUf+uqdZkS90tCJWN/2hUmFYsEO14huTyjyf+Mq
        M=
X-Google-Smtp-Source: AGHT+IHzcOjhiNASkmGMw72MBTwzER0a2lM9tIXLUtfURWh7MtLGVGKmXri+eXSRBDRS7xLsZ60y3uwdu1ohXFeFTA==
X-Received: from kalesh.mtv.corp.google.com ([2620:15c:211:201:c927:b01c:7e95:9e57])
 (user=kaleshsingh job=sendgmr) by 2002:a25:ec0d:0:b0:d80:8aa6:5ac0 with SMTP
 id j13-20020a25ec0d000000b00d808aa65ac0mr135101ybh.4.1694576450169; Tue, 12
 Sep 2023 20:40:50 -0700 (PDT)
Date:   Tue, 12 Sep 2023 20:40:29 -0700
In-Reply-To: <2023090959-mothproof-scarf-6195@gregkh>
Mime-Version: 1.0
References: <2023090959-mothproof-scarf-6195@gregkh>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913034029.1652087-1-kaleshsingh@google.com>
Subject: [PATCH 6.1.y] Multi-gen LRU: fix per-zone reclaim
From:   Kalesh Singh <kaleshsingh@google.com>
To:     stable@vger.kernel.org
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yu Zhao <yuzhao@google.com>, Barry Song <baohua@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
(cherry picked from commit 669281ee7ef731fb5204df9d948669bf32a5e68d)
[ Kalesh Singh - Fix conflicts caused by rename of  lrugen->lists to
  lrugen->folios ]
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/vmscan.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d18296109aa7..d7016fdb7c14 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4728,7 +4728,8 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
  *                          the eviction
  ******************************************************************************/
 
-static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
+static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_control *sc,
+		       int tier_idx)
 {
 	bool success;
 	int gen = folio_lru_gen(folio);
@@ -4779,6 +4780,13 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
 		return true;
 	}
 
+	/* ineligible */
+	if (zone > sc->reclaim_idx) {
+		gen = folio_inc_gen(lruvec, folio, false);
+		list_move_tail(&folio->lru, &lrugen->lists[gen][type][zone]);
+		return true;
+	}
+
 	/* waiting for writeback */
 	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
 	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
@@ -4831,7 +4839,8 @@ static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, struct sca
 static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 		       int type, int tier, struct list_head *list)
 {
-	int gen, zone;
+	int i;
+	int gen;
 	enum vm_event_item item;
 	int sorted = 0;
 	int scanned = 0;
@@ -4847,9 +4856,10 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 
 	gen = lru_gen_from_seq(lrugen->min_seq[type]);
 
-	for (zone = sc->reclaim_idx; zone >= 0; zone--) {
+	for (i = MAX_NR_ZONES; i > 0; i--) {
 		LIST_HEAD(moved);
 		int skipped = 0;
+		int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
 		struct list_head *head = &lrugen->lists[gen][type][zone];
 
 		while (!list_empty(head)) {
@@ -4863,7 +4873,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 
 			scanned += delta;
 
-			if (sort_folio(lruvec, folio, tier))
+			if (sort_folio(lruvec, folio, sc, tier))
 				sorted += delta;
 			else if (isolate_folio(lruvec, folio, sc)) {
 				list_add(&folio->lru, list);
-- 
2.42.0.283.g2d96d420d3-goog


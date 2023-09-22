Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985ED7AB643
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 18:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjIVQnc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 12:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjIVQna (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 12:43:30 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29D511A7;
        Fri, 22 Sep 2023 09:43:18 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: [PATCH -stable,5.15 00/17] Netfilter stable fixes for 5.15
Date:   Fri, 22 Sep 2023 18:42:56 +0200
Message-Id: <20230922164313.151564-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg, Sasha,

The following list shows the backported patches, this batch is targeting
at garbage collection (GC) / set timeout fixes that address possible UaF
and memleaks. I am using original commit IDs for reference:

1) 24138933b97b ("netfilter: nf_tables: don't skip expired elements during walk")

2) 5f68718b34a5 ("netfilter: nf_tables: GC transaction API to avoid race with control plane")

3) f6c383b8c31a ("netfilter: nf_tables: adapt set backend to use GC transaction API")

4) c92db3030492 ("netfilter: nft_set_hash: mark set element as dead when deleting from packet path")

5) a2dd0233cbc4 ("netfilter: nf_tables: remove busy mark and gc batch API")

6) 7845914f45f0 ("netfilter: nf_tables: don't fail inserts if duplicate has expired")

7) 6a33d8b73dfa ("netfilter: nf_tables: fix GC transaction races with netns and netlink event exit path")

8) 02c6c24402bf ("netfilter: nf_tables: GC transaction race with netns dismantle")

9) 720344340fb9 ("netfilter: nf_tables: GC transaction race with abort path")

10) 8357bc946a2a ("netfilter: nf_tables: use correct lock to protect gc_list")

11) 8e51830e29e1 ("netfilter: nf_tables: defer gc run if previous batch is still pending")

12) 2ee52ae94baa ("netfilter: nft_set_rbtree: skip sync GC for new elements in this transaction")

13) 96b33300fba8 ("netfilter: nft_set_rbtree: use read spinlock to avoid datapath contention")

14) 4a9e12ea7e70 ("netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall GC")

15) 6d365eabce3c ("netfilter: nft_set_pipapo: stop GC iteration if GC transaction allocation fails")

16) b079155faae9 ("netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration")

17) cf5000a7787c ("netfilter: nf_tables: fix memleak when more than 255 elements expired")

Please, apply.

Thanks.

Florian Westphal (4):
  netfilter: nf_tables: don't skip expired elements during walk
  netfilter: nf_tables: don't fail inserts if duplicate has expired
  netfilter: nf_tables: defer gc run if previous batch is still pending
  netfilter: nf_tables: fix memleak when more than 255 elements expired

Pablo Neira Ayuso (13):
  netfilter: nf_tables: GC transaction API to avoid race with control plane
  netfilter: nf_tables: adapt set backend to use GC transaction API
  netfilter: nft_set_hash: mark set element as dead when deleting from packet path
  netfilter: nf_tables: remove busy mark and gc batch API
  netfilter: nf_tables: fix GC transaction races with netns and netlink event exit path
  netfilter: nf_tables: GC transaction race with netns dismantle
  netfilter: nf_tables: GC transaction race with abort path
  netfilter: nf_tables: use correct lock to protect gc_list
  netfilter: nft_set_rbtree: skip sync GC for new elements in this transaction
  netfilter: nft_set_rbtree: use read spinlock to avoid datapath contention
  netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall GC
  netfilter: nft_set_pipapo: stop GC iteration if GC transaction allocation fails
  netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration

 include/net/netfilter/nf_tables.h | 126 +++++-----
 net/netfilter/nf_tables_api.c     | 369 ++++++++++++++++++++++++------
 net/netfilter/nft_set_hash.c      |  87 ++++---
 net/netfilter/nft_set_pipapo.c    |  67 +++---
 net/netfilter/nft_set_rbtree.c    | 161 +++++++------
 5 files changed, 547 insertions(+), 263 deletions(-)

-- 
2.30.2


Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1256C7485BC
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 16:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGEOOS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 10:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGEOOS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 10:14:18 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D77AE70;
        Wed,  5 Jul 2023 07:14:17 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: [PATCH -stable,5.15 0/2] stable fixes for 5.15
Date:   Wed,  5 Jul 2023 16:14:09 +0200
Message-Id: <20230705141411.53123-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg, Sasha,

The following list shows the backported patches, I am using original
commit IDs for reference:

1) 628bd3e49cba ("netfilter: nf_tables: drop map element references from preparation phase")

2) 3e70489721b6 ("netfilter: nf_tables: unbind non-anonymous set if rule construction fails")

Please, apply.
Thanks.

Pablo Neira Ayuso (2):
  netfilter: nf_tables: drop map element references from preparation phase
  netfilter: nf_tables: unbind non-anonymous set if rule construction fails

 include/net/netfilter/nf_tables.h |   5 +-
 net/netfilter/nf_tables_api.c     | 147 ++++++++++++++++++++++++++----
 net/netfilter/nft_set_bitmap.c    |   5 +-
 net/netfilter/nft_set_hash.c      |  23 ++++-
 net/netfilter/nft_set_pipapo.c    |  14 ++-
 net/netfilter/nft_set_rbtree.c    |   5 +-
 6 files changed, 168 insertions(+), 31 deletions(-)

-- 
2.30.2


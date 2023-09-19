Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA267A6916
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 18:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjISQoz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 12:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjISQoz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 12:44:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FDD90
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 09:44:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A316CC433C9;
        Tue, 19 Sep 2023 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695141889;
        bh=uLtQgydnTcgdqmk+c1pTnm5Mc4Fc/mY9Q5SwGtxNX0k=;
        h=From:To:Cc:Subject:Date:From;
        b=lhHkwC1j9bR53BgzyMLOsuE/y8dhyi7ixy8Owi0cUUVfdblJUsV6O9SFc2Yf7DNpn
         /XPHssh6vSxoOBJP5VKySU3stmAQccfK+mM1Ke38ZhaBTSV3EH2O0/6dqHtrpvh9yV
         UVYiZ0XMOpEyn2wlw77MwJ9rfGQqbuR10zwAXMcpK3XQ2iaDhSZ2bGJaRdsqDQNsfm
         FQaX0GzBSey/0bkLZd4CVa1QfgDTwluMknkin6vsdikPjus1SRvcmGW0XNV0kFl+4A
         U7cWWDBJfz0bL+Dr+yfTZyqr9q4U1wuTCIzRKxnixDQOCMYF2U3HZ/ulkhANVVlLRH
         VAxctm8Q42Ikg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, stable@vger.kernel.org
Cc:     pablo@netfilter.org, fw@strlen.de
Subject: [PATCH 0/5] netfilter: Reinstate dropped Stable patches
Date:   Tue, 19 Sep 2023 17:44:28 +0100
Message-ID: <20230919164437.3297021-1-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dropped in August:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=da9e96b4de57f6621f21e682bad92b5ffed0eeee
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=8d1dbdfdd7612a9ea73b005f75a3b2b8b0610d4e

Only re-applied and build tested against v6.1.53.

If they do apply and test well against linux-5.{4,10,15}, all the better.

Florian Westphal (1):
  netfilter: nf_tables: don't skip expired elements during walk

Pablo Neira Ayuso (4):
  netfilter: nf_tables: GC transaction API to avoid race with control
    plane
  netfilter: nf_tables: adapt set backend to use GC transaction API
  netfilter: nft_set_hash: mark set element as dead when deleting from
    packet path
  netfilter: nf_tables: remove busy mark and gc batch API

 include/net/netfilter/nf_tables.h | 120 +++++-------
 net/netfilter/nf_tables_api.c     | 307 ++++++++++++++++++++++++------
 net/netfilter/nft_set_hash.c      |  85 +++++----
 net/netfilter/nft_set_pipapo.c    |  66 +++++--
 net/netfilter/nft_set_rbtree.c    | 146 ++++++++------
 5 files changed, 476 insertions(+), 248 deletions(-)

-- 
2.42.0.459.ge4e396fd5e-goog


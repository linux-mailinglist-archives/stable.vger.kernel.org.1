Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC177A493D
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 14:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241873AbjIRMHd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 08:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241963AbjIRMHS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 08:07:18 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59576F7;
        Mon, 18 Sep 2023 05:07:01 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: [PATCH -stable,4.19 0/2] netfilter stable fixes for 4.19
Date:   Mon, 18 Sep 2023 14:06:54 +0200
Message-Id: <20230918120656.218135-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg, Sasha,

This batch contains a fixes for 4.19:

1) Missing fix in 4.19, you can cherry-pick it from
   8ca79606cdfd ("netfilter: nft_flow_offload: fix underflow in flowtable reference counter")

2) Oneliner that includes missing chunk in 4.19 backport.
   Fixes: 1df28fde1270 ("netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain") in 4.19
   This patch you have to manually apply it.

Thanks.

Pablo Neira Ayuso (1):
  netfilter: nf_tables: missing NFT_TRANS_PREPARE_ERROR in flowtable deactivatation

wenxu (1):
  netfilter: nft_flow_offload: fix underflow in flowtable reference counter

 net/netfilter/nf_tables_api.c    | 1 +
 net/netfilter/nft_flow_offload.c | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.30.2


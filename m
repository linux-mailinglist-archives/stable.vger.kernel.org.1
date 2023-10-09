Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212F87BE10B
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377429AbjJINqs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377518AbjJINqg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:46:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160B6FC
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:46:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50238C433CA;
        Mon,  9 Oct 2023 13:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859181;
        bh=sWccsbyFE7f7e5n1mTu+znwueUSHj0sOBwKO6uQbFN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHOLqxjYxAinJoq7bmTLdnslLgEvUlpyAa0S5Dl0zeFcBU93fzU8R/TGkqwC5D3CT
         pSYMKGRZ2MAf3dPEVWkCevu0rgWmDo5ukHLFe04VSrCqlRg+dQCsNcFPEmniZG+C2s
         /qNtjrlX0oMIx3IDd2uBXZUOmst2M8yL9cFdMd00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH 5.10 225/226] netfilter: nf_tables: fix kdoc warnings after gc rework
Date:   Mon,  9 Oct 2023 15:03:06 +0200
Message-ID: <20231009130132.389569864@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 08713cb006b6f07434f276c5ee214fb20c7fd965 upstream.

Jakub Kicinski says:
  We've got some new kdoc warnings here:
  net/netfilter/nft_set_pipapo.c:1557: warning: Function parameter or member '_set' not described in 'pipapo_gc'
  net/netfilter/nft_set_pipapo.c:1557: warning: Excess function parameter 'set' description in 'pipapo_gc'
  include/net/netfilter/nf_tables.h:577: warning: Function parameter or member 'dead' not described in 'nft_set'

Fixes: 5f68718b34a5 ("netfilter: nf_tables: GC transaction API to avoid race with control plane")
Fixes: f6c383b8c31a ("netfilter: nf_tables: adapt set backend to use GC transaction API")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20230810104638.746e46f1@kernel.org/
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/netfilter/nf_tables.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -439,6 +439,7 @@ struct nft_set_type {
  *	@expr: stateful expression
  * 	@ops: set ops
  * 	@flags: set flags
+ *	@dead: set will be freed, never cleared
  *	@genmask: generation mask
  * 	@klen: key length
  * 	@dlen: data length



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8846878AD01
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjH1Kov (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjH1Kol (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:44:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36129198
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74E4F64114
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559A6C433C8;
        Mon, 28 Aug 2023 10:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219448;
        bh=Re7iBJlUCZW1cxkET19SFF2UVVXIwMtK2VoN/txjNOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AEdjVxC9g2zLqSFbDdCt2a2B+cb39DLj7BcDTSbHDQIhdH8sPTk/CkPtAtf/hS89a
         Zi0/C8wo9iu+oO2Os2eq4toYlE/iXl/geO/1xV9ecDb/4vrwfTtYTLpJTzV9SU2VZJ
         /hcEYTeAWY391rRFTrA7AR7hmT/IEJNm7sfHFdjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Stefano Brivio <sbrivio@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 39/89] netfilter: nf_tables: fix out of memory error handling
Date:   Mon, 28 Aug 2023 12:13:40 +0200
Message-ID: <20230828101151.503809456@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 5e1be4cdc98c989d5387ce94ff15b5ad06a5b681 ]

Several instances of pipapo_resize() don't propagate allocation failures,
this causes a crash when fault injection is enabled for gfp_kernel slabs.

Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 32cfd0a84b0e2..8c16681884b7e 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -901,12 +901,14 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 static int pipapo_insert(struct nft_pipapo_field *f, const uint8_t *k,
 			 int mask_bits)
 {
-	int rule = f->rules++, group, ret, bit_offset = 0;
+	int rule = f->rules, group, ret, bit_offset = 0;
 
-	ret = pipapo_resize(f, f->rules - 1, f->rules);
+	ret = pipapo_resize(f, f->rules, f->rules + 1);
 	if (ret)
 		return ret;
 
+	f->rules++;
+
 	for (group = 0; group < f->groups; group++) {
 		int i, v;
 		u8 mask;
@@ -1051,7 +1053,9 @@ static int pipapo_expand(struct nft_pipapo_field *f,
 			step++;
 			if (step >= len) {
 				if (!masks) {
-					pipapo_insert(f, base, 0);
+					err = pipapo_insert(f, base, 0);
+					if (err < 0)
+						return err;
 					masks = 1;
 				}
 				goto out;
@@ -1234,6 +1238,9 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 		else
 			ret = pipapo_expand(f, start, end, f->groups * f->bb);
 
+		if (ret < 0)
+			return ret;
+
 		if (f->bsize > bsize_max)
 			bsize_max = f->bsize;
 
-- 
2.40.1




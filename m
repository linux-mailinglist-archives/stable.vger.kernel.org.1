Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0573D78AA38
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjH1KUL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjH1KTs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:19:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A4CCC1
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2456463841
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AF9C433C7;
        Mon, 28 Aug 2023 10:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217966;
        bh=gpHcxNeJIrE/fxyR99Mo7FtDGn96C587qYfBXnhFPo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nOf4ULkVFECPrV4ks/jp/ncan/ZCbqrGRBjlt4/qmqUtgBCaQ60szyfiHu/XyxKxl
         WCjMsSS2uhjM0+b5XtbwV3CNUt28Zm7bEn3wOERDwpFaA2W/VIv93bjpq+7TsoBpR5
         Dr8pIIInkd98ekZ+//DZ7nCI1se2kCmm46y8W50U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Stefano Brivio <sbrivio@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 047/129] netfilter: nf_tables: fix out of memory error handling
Date:   Mon, 28 Aug 2023 12:12:06 +0200
Message-ID: <20230828101158.941656303@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

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
index 352180b123fc7..58bd514260b90 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -902,12 +902,14 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
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
@@ -1052,7 +1054,9 @@ static int pipapo_expand(struct nft_pipapo_field *f,
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
@@ -1235,6 +1239,9 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 		else
 			ret = pipapo_expand(f, start, end, f->groups * f->bb);
 
+		if (ret < 0)
+			return ret;
+
 		if (f->bsize > bsize_max)
 			bsize_max = f->bsize;
 
-- 
2.40.1




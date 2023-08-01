Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF276AD19
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjHAJ0T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjHAJ0D (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:26:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F61349D5
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DA7D61506
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378B8C433C7;
        Tue,  1 Aug 2023 09:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881888;
        bh=/TxF209rKHZHs9+r8S9347W8bTErflIoDYGy7VWdAWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPJJuh+4AA1o5R/R/X9xWtsL7A2+0j8TL/LUNrQn5VhZNRhHGfmdCSk+Yv7QxXhIy
         fNx45+fYI4eZ123imDpnhJDh0Mp/zwT4FrLm25W40TLuOShhmcqyaFeT4ud79ranfy
         /ZcO0a1VaS3mAA4hFOi3ZgyxcrmSpRfoYsoUCSNk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stewart Smith <trawets@amazon.com>,
        Samuel Mendoza-Jonas <samjonas@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 066/155] tcp: Reduce chance of collisions in inet6_hashfn().
Date:   Tue,  1 Aug 2023 11:19:38 +0200
Message-ID: <20230801091912.551742318@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stewart Smith <trawets@amazon.com>

[ Upstream commit d11b0df7ddf1831f3e170972f43186dad520bfcc ]

For both IPv4 and IPv6 incoming TCP connections are tracked in a hash
table with a hash over the source & destination addresses and ports.
However, the IPv6 hash is insufficient and can lead to a high rate of
collisions.

The IPv6 hash used an XOR to fit everything into the 96 bits for the
fast jenkins hash, meaning it is possible for an external entity to
ensure the hash collides, thus falling back to a linear search in the
bucket, which is slow.

We take the approach of hash the full length of IPv6 address in
__ipv6_addr_jhash() so that all users can benefit from a more secure
version.

While this may look like it adds overhead, the reality of modern CPUs
means that this is unmeasurable in real world scenarios.

In simulating with llvm-mca, the increase in cycles for the hashing
code was ~16 cycles on Skylake (from a base of ~155), and an extra ~9
on Nehalem (base of ~173).

In commit dd6d2910c5e0 ("netfilter: conntrack: switch to siphash")
netfilter switched from a jenkins hash to a siphash, but even the faster
hsiphash is a more significant overhead (~20-30%) in some preliminary
testing.  So, in this patch, we keep to the more conservative approach to
ensure we don't add much overhead per SYN.

In testing, this results in a consistently even spread across the
connection buckets.  In both testing and real-world scenarios, we have
not found any measurable performance impact.

Fixes: 08dcdbf6a7b9 ("ipv6: use a stronger hash for tcp")
Signed-off-by: Stewart Smith <trawets@amazon.com>
Signed-off-by: Samuel Mendoza-Jonas <samjonas@amazon.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230721222410.17914-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ipv6.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index e3ab99f4edab7..20930086b2288 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -664,12 +664,8 @@ static inline u32 ipv6_addr_hash(const struct in6_addr *a)
 /* more secured version of ipv6_addr_hash() */
 static inline u32 __ipv6_addr_jhash(const struct in6_addr *a, const u32 initval)
 {
-	u32 v = (__force u32)a->s6_addr32[0] ^ (__force u32)a->s6_addr32[1];
-
-	return jhash_3words(v,
-			    (__force u32)a->s6_addr32[2],
-			    (__force u32)a->s6_addr32[3],
-			    initval);
+	return jhash2((__force const u32 *)a->s6_addr32,
+		      ARRAY_SIZE(a->s6_addr32), initval);
 }
 
 static inline bool ipv6_addr_loopback(const struct in6_addr *a)
-- 
2.39.2




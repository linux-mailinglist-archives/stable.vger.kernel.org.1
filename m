Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66813775D3D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjHILfN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbjHILfN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:35:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74786173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:35:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B97F60D24
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E968C433C7;
        Wed,  9 Aug 2023 11:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580909;
        bh=5rKkfLKPUSTN/DIvAIKog5KyPq3/0EhyhSD58ZMZzAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TM/VhHxNot6TvNWk3CKb4YR4MQt0u7lsMvF1duHyUdgp25enezCrVts2qSLLX2N4z
         yEidx8EmfXFFe/T8Y1pyTmmWzOH7DMqDxJt9kO9eMzAFS40D5fq9Lf239MrLNYKr0e
         I9/YI8gDAG9H6yzvlEpTm1mKXJQsWkuSMKbcpky4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stewart Smith <trawets@amazon.com>,
        Samuel Mendoza-Jonas <samjonas@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 037/201] tcp: Reduce chance of collisions in inet6_hashfn().
Date:   Wed,  9 Aug 2023 12:40:39 +0200
Message-ID: <20230809103645.089542156@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 8879c0ab0b89d..4c8f97a6da5a7 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -663,12 +663,8 @@ static inline u32 ipv6_addr_hash(const struct in6_addr *a)
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




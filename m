Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D523E77259B
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 15:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjHGN0u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 09:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjHGN0f (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 09:26:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF0A4C3B
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 06:25:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4A2061A5A
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 13:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9D8C433C7;
        Mon,  7 Aug 2023 13:24:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fq0Ns74s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1691414665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rcicnn3ynTAB6IFLFNRyVdMCpVfvSQ8Rr0HQSIv6cqk=;
        b=fq0Ns74s1vrhuuCLvS2+dSB77YSGER8h0UpJvsNBOebMIWcmNEAPelAZNVBhmJkqRxESd4
        CA7N/soEiDPkDaYOIC+BiCBgD7BQs4Juu67r0gzxNsez+LUPKpJ0b2Ald9/kr3estkOkx+
        SZW2eYFcvDaIIFgnU89yEZkO9r6ovKw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9573abe4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 7 Aug 2023 13:24:24 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, stable@vger.kernel.org
Subject: [PATCH net 1/1] wireguard: allowedips: expand maximum node depth
Date:   Mon,  7 Aug 2023 15:21:27 +0200
Message-ID: <20230807132146.2191597-2-Jason@zx2c4.com>
In-Reply-To: <20230807132146.2191597-1-Jason@zx2c4.com>
References: <20230807132146.2191597-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

In the allowedips self-test, nodes are inserted into the tree, but it
generated an even amount of nodes, but for checking maximum node depth,
there is of course the root node, which makes the total number
necessarily odd. With two few nodes added, it never triggered the
maximum depth check like it should have. So, add 129 nodes instead of
128 nodes, and do so with a more straightforward scheme, starting with
all the bits set, and shifting over one each time. Then increase the
maximum depth to 129, and choose a better name for that variable to
make it clear that it represents depth as opposed to bits.

Cc: stable@vger.kernel.org
Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/allowedips.c          |  8 ++++----
 drivers/net/wireguard/selftest/allowedips.c | 16 ++++++++++------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
index 5bf7822c53f1..0ba714ca5185 100644
--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -6,7 +6,7 @@
 #include "allowedips.h"
 #include "peer.h"
 
-enum { MAX_ALLOWEDIPS_BITS = 128 };
+enum { MAX_ALLOWEDIPS_DEPTH = 129 };
 
 static struct kmem_cache *node_cache;
 
@@ -42,7 +42,7 @@ static void push_rcu(struct allowedips_node **stack,
 		     struct allowedips_node __rcu *p, unsigned int *len)
 {
 	if (rcu_access_pointer(p)) {
-		if (WARN_ON(IS_ENABLED(DEBUG) && *len >= MAX_ALLOWEDIPS_BITS))
+		if (WARN_ON(IS_ENABLED(DEBUG) && *len >= MAX_ALLOWEDIPS_DEPTH))
 			return;
 		stack[(*len)++] = rcu_dereference_raw(p);
 	}
@@ -55,7 +55,7 @@ static void node_free_rcu(struct rcu_head *rcu)
 
 static void root_free_rcu(struct rcu_head *rcu)
 {
-	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_BITS] = {
+	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_DEPTH] = {
 		container_of(rcu, struct allowedips_node, rcu) };
 	unsigned int len = 1;
 
@@ -68,7 +68,7 @@ static void root_free_rcu(struct rcu_head *rcu)
 
 static void root_remove_peer_lists(struct allowedips_node *root)
 {
-	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_BITS] = { root };
+	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_DEPTH] = { root };
 	unsigned int len = 1;
 
 	while (len > 0 && (node = stack[--len])) {
diff --git a/drivers/net/wireguard/selftest/allowedips.c b/drivers/net/wireguard/selftest/allowedips.c
index 78ebe2892a78..3d1f64ff2e12 100644
--- a/drivers/net/wireguard/selftest/allowedips.c
+++ b/drivers/net/wireguard/selftest/allowedips.c
@@ -593,16 +593,20 @@ bool __init wg_allowedips_selftest(void)
 	wg_allowedips_remove_by_peer(&t, a, &mutex);
 	test_negative(4, a, 192, 168, 0, 1);
 
-	/* These will hit the WARN_ON(len >= MAX_ALLOWEDIPS_BITS) in free_node
+	/* These will hit the WARN_ON(len >= MAX_ALLOWEDIPS_DEPTH) in free_node
 	 * if something goes wrong.
 	 */
-	for (i = 0; i < MAX_ALLOWEDIPS_BITS; ++i) {
-		part = cpu_to_be64(~(1LLU << (i % 64)));
-		memset(&ip, 0xff, 16);
-		memcpy((u8 *)&ip + (i < 64) * 8, &part, 8);
+	for (i = 0; i < 64; ++i) {
+		part = cpu_to_be64(~0LLU << i);
+		memset(&ip, 0xff, 8);
+		memcpy((u8 *)&ip + 8, &part, 8);
+		wg_allowedips_insert_v6(&t, &ip, 128, a, &mutex);
+		memcpy(&ip, &part, 8);
+		memset((u8 *)&ip + 8, 0, 8);
 		wg_allowedips_insert_v6(&t, &ip, 128, a, &mutex);
 	}
-
+	memset(&ip, 0, 16);
+	wg_allowedips_insert_v6(&t, &ip, 128, a, &mutex);
 	wg_allowedips_free(&t, &mutex);
 
 	wg_allowedips_init(&t);
-- 
2.41.0


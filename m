Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5BD77AE0A
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 00:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjHMWAQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 18:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjHMV7G (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E6C2682
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9877661B60
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD49BC433C8;
        Sun, 13 Aug 2023 21:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963017;
        bh=amwjw9XamkyBWuFCZmLa0aWzXafwZbMjz29nSRQUV0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZqe0RvdETsWHSObSXgFDKm2KpEavIR8TqQZyEIbVXPzW0sUdyAvYqy6UGYwBceOk
         PvPtFUQcnHRsE7jy+tIeb1iFIvXFW2nA+ccEOpAfdqg1gFTezFuukFECfFsKYbpcQs
         IeS0hW6YGZyOIxlhoWWN5kAJy/usaAXkSjT0rbh4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 03/89] wireguard: allowedips: expand maximum node depth
Date:   Sun, 13 Aug 2023 23:18:54 +0200
Message-ID: <20230813211710.888507789@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 46622219aae2b67813fe31a7b8cb7da5baff5c8a upstream.

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
Link: https://lore.kernel.org/r/20230807132146.2191597-2-Jason@zx2c4.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireguard/allowedips.c          |    8 ++++----
 drivers/net/wireguard/selftest/allowedips.c |   16 ++++++++++------
 2 files changed, 14 insertions(+), 10 deletions(-)

--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -6,7 +6,7 @@
 #include "allowedips.h"
 #include "peer.h"
 
-enum { MAX_ALLOWEDIPS_BITS = 128 };
+enum { MAX_ALLOWEDIPS_DEPTH = 129 };
 
 static struct kmem_cache *node_cache;
 
@@ -42,7 +42,7 @@ static void push_rcu(struct allowedips_n
 		     struct allowedips_node __rcu *p, unsigned int *len)
 {
 	if (rcu_access_pointer(p)) {
-		if (WARN_ON(IS_ENABLED(DEBUG) && *len >= MAX_ALLOWEDIPS_BITS))
+		if (WARN_ON(IS_ENABLED(DEBUG) && *len >= MAX_ALLOWEDIPS_DEPTH))
 			return;
 		stack[(*len)++] = rcu_dereference_raw(p);
 	}
@@ -55,7 +55,7 @@ static void node_free_rcu(struct rcu_hea
 
 static void root_free_rcu(struct rcu_head *rcu)
 {
-	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_BITS] = {
+	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_DEPTH] = {
 		container_of(rcu, struct allowedips_node, rcu) };
 	unsigned int len = 1;
 
@@ -68,7 +68,7 @@ static void root_free_rcu(struct rcu_hea
 
 static void root_remove_peer_lists(struct allowedips_node *root)
 {
-	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_BITS] = { root };
+	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_DEPTH] = { root };
 	unsigned int len = 1;
 
 	while (len > 0 && (node = stack[--len])) {
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



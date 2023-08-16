Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B122377E6A2
	for <lists+stable@lfdr.de>; Wed, 16 Aug 2023 18:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbjHPQkh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344800AbjHPQkY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 12:40:24 -0400
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4765A2727;
        Wed, 16 Aug 2023 09:40:21 -0700 (PDT)
Received: from kero.packetmixer.de (p200300fa272a67000Bb2D6Dcaf57D46e.dip0.t-ipconnect.de [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.simonwunderlich.de (Postfix) with ESMTPSA id ACD51FB5B9;
        Wed, 16 Aug 2023 18:33:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
        s=09092022; t=1692203602; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZjjQV+SPnIxJqc/lGGTrg5mUdnawkPeZwsQkkVOCao=;
        b=hjw7m+GR09JyvrKxjhm8C/608O/cA22xYCwadFlFVpzmheJVck2M/oSh/hFPQcjkB46pD/
        v5PY3BPUXbyrRXP5sSWNSotHt/PCQYLyMqJu1MffwimLCEDAztAIW6Hch5PpLybMtGfJaN
        CesWd+pn3Tp7gtu1KPqKsVvk1FmVmrSnAsQBwwcQ53nCxUMCOyvqwFlQTEol1+mmcgUDZO
        Fs4lJFsAbWa0d3Se0poliwlukRxAp3Es2HzG9DCW0k7jNQrhkmHAd4M33/tDkwD3kEagDg
        n2f8YYyrWhus7+gJFPNfYkyaQgW6yGEcnNfhlK4TwbgD6NG6PFTB9jbbjx8r3A==
From:   Simon Wunderlich <sw@simonwunderlich.de>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
        Remi Pommarel <repk@triplefau.lt>, stable@vger.kernel.org,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4/5] batman-adv: Fix TT global entry leak when client roamed back
Date:   Wed, 16 Aug 2023 18:33:17 +0200
Message-Id: <20230816163318.189996-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816163318.189996-1-sw@simonwunderlich.de>
References: <20230816163318.189996-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simonwunderlich.de; s=09092022; t=1692203602;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZjjQV+SPnIxJqc/lGGTrg5mUdnawkPeZwsQkkVOCao=;
        b=RSwip81jc5JV9h43E5g+bgPgw1dhHISygSzpxVzV+68lxgIfDkOroxCuou2DMI0O0cW7AM
        1PRtFlCuMvjhW7HQR2SdjdaAbG3mqpWc5v6/LnaAz3G5agwcsrYnY9da14TvvD8o6Ixkby
        DtZ5GKitY/xG6BhYlrXj/kjjKNsjXCF4YkcwnUjNniLrJlB7OiQFI8+rgs4lw1vHLXkVMt
        UQy87oZp4c2x6yy3lDSZV2pU8Bf8tbAK+UafM6cTI5I1Wr7bgeW4AA22/qUEIm9dpk1zQ0
        SKJbWF6S8mrZGaLlmyzw/8gglmeAtIDYBvinkD+Z3Ql4xkZ1YNr5AQxldeje9g==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692203602; a=rsa-sha256;
        cv=none;
        b=rsZBlwlQhRmPLYbvjgl+Do8/BzgSFOgKfD8pXt/t7a4CMgb59Fwg+PQ85j2jRm2J8v52aSfPJcGE+4LQPcDlk7hmqpMp/NyIQU3AnL4MEcz21rd5NNIEKKcVsC7IDYWkLKnxcxo7rPa7U1HSEhCZ+HzR+K8E/Wh5vLABaobfM7OEZ5bnyEy1gkY9ylR/eYVM3sPlLGD3/vLVITswZyqS0h/W9wDRQueuKRXQspplReRnqtVriZgzjqCZhdmW5qiK4OGRvpj1NYMVmc8dCjkjpQxeaTTlrwsjTf3tqTPRY2gwD6p2m0z3yZDAv/pm2EG6lihqrmFPZgYbL+fsxUQAqQ==
ARC-Authentication-Results: i=1;
        mail.simonwunderlich.de;
        auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Remi Pommarel <repk@triplefau.lt>

When a client roamed back to a node before it got time to destroy the
pending local entry (i.e. within the same originator interval) the old
global one is directly removed from hash table and left as such.

But because this entry had an extra reference taken at lookup (i.e using
batadv_tt_global_hash_find) there is no way its memory will be reclaimed
at any time causing the following memory leak:

  unreferenced object 0xffff0000073c8000 (size 18560):
    comm "softirq", pid 0, jiffies 4294907738 (age 228.644s)
    hex dump (first 32 bytes):
      06 31 ac 12 c7 7a 05 00 01 00 00 00 00 00 00 00  .1...z..........
      2c ad be 08 00 80 ff ff 6c b6 be 08 00 80 ff ff  ,.......l.......
    backtrace:
      [<00000000ee6e0ffa>] kmem_cache_alloc+0x1b4/0x300
      [<000000000ff2fdbc>] batadv_tt_global_add+0x700/0xe20
      [<00000000443897c7>] _batadv_tt_update_changes+0x21c/0x790
      [<000000005dd90463>] batadv_tt_update_changes+0x3c/0x110
      [<00000000a2d7fc57>] batadv_tt_tvlv_unicast_handler_v1+0xafc/0xe10
      [<0000000011793f2a>] batadv_tvlv_containers_process+0x168/0x2b0
      [<00000000b7cbe2ef>] batadv_recv_unicast_tvlv+0xec/0x1f4
      [<0000000042aef1d8>] batadv_batman_skb_recv+0x25c/0x3a0
      [<00000000bbd8b0a2>] __netif_receive_skb_core.isra.0+0x7a8/0xe90
      [<000000004033d428>] __netif_receive_skb_one_core+0x64/0x74
      [<000000000f39a009>] __netif_receive_skb+0x48/0xe0
      [<00000000f2cd8888>] process_backlog+0x174/0x344
      [<00000000507d6564>] __napi_poll+0x58/0x1f4
      [<00000000b64ef9eb>] net_rx_action+0x504/0x590
      [<00000000056fa5e4>] _stext+0x1b8/0x418
      [<00000000878879d6>] run_ksoftirqd+0x74/0xa4
  unreferenced object 0xffff00000bae1a80 (size 56):
    comm "softirq", pid 0, jiffies 4294910888 (age 216.092s)
    hex dump (first 32 bytes):
      00 78 b1 0b 00 00 ff ff 0d 50 00 00 00 00 00 00  .x.......P......
      00 00 00 00 00 00 00 00 50 c8 3c 07 00 00 ff ff  ........P.<.....
    backtrace:
      [<00000000ee6e0ffa>] kmem_cache_alloc+0x1b4/0x300
      [<00000000d9aaa49e>] batadv_tt_global_add+0x53c/0xe20
      [<00000000443897c7>] _batadv_tt_update_changes+0x21c/0x790
      [<000000005dd90463>] batadv_tt_update_changes+0x3c/0x110
      [<00000000a2d7fc57>] batadv_tt_tvlv_unicast_handler_v1+0xafc/0xe10
      [<0000000011793f2a>] batadv_tvlv_containers_process+0x168/0x2b0
      [<00000000b7cbe2ef>] batadv_recv_unicast_tvlv+0xec/0x1f4
      [<0000000042aef1d8>] batadv_batman_skb_recv+0x25c/0x3a0
      [<00000000bbd8b0a2>] __netif_receive_skb_core.isra.0+0x7a8/0xe90
      [<000000004033d428>] __netif_receive_skb_one_core+0x64/0x74
      [<000000000f39a009>] __netif_receive_skb+0x48/0xe0
      [<00000000f2cd8888>] process_backlog+0x174/0x344
      [<00000000507d6564>] __napi_poll+0x58/0x1f4
      [<00000000b64ef9eb>] net_rx_action+0x504/0x590
      [<00000000056fa5e4>] _stext+0x1b8/0x418
      [<00000000878879d6>] run_ksoftirqd+0x74/0xa4

Releasing the extra reference from batadv_tt_global_hash_find even at
roam back when batadv_tt_global_free is called fixes this memory leak.

Cc: stable@vger.kernel.org
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Signed-off-by; Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 36ca31252a73..b95c36765d04 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -774,7 +774,6 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 		if (roamed_back) {
 			batadv_tt_global_free(bat_priv, tt_global,
 					      "Roaming canceled");
-			tt_global = NULL;
 		} else {
 			/* The global entry has to be marked as ROAMING and
 			 * has to be kept for consistency purpose
-- 
2.39.2


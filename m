Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A9E78AD94
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjH1Kte (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjH1KtM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:49:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39B5CD8
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:48:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6049164399
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C454C433C7;
        Mon, 28 Aug 2023 10:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219730;
        bh=K86Cz2TelavRkUBp1ukhtB3sklwRhN0lDK2s0Y3KPvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zmxoWVd3uI6Z0CNLLpbUglRb38n4Ja7cCssfy3zIHPOEiM7MDpkZT0Yt0//XQL/3G
         kVo1YkDQsdVVVHAlkBZGr1wOHx1+MJgpkzUG7+3cqJRWzOmMMskH0R2mV7bfF82W9C
         ES9euitDTAdQh/pVNKbNoIj9KwMzpllApVEMaAX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5.10 52/84] batman-adv: Fix TT global entry leak when client roamed back
Date:   Mon, 28 Aug 2023 12:14:09 +0200
Message-ID: <20230828101151.032787623@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
References: <20230828101149.146126827@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Remi Pommarel <repk@triplefau.lt>

commit d25ddb7e788d34cf27ff1738d11a87cb4b67d446 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/translation-table.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -775,7 +775,6 @@ check_roaming:
 		if (roamed_back) {
 			batadv_tt_global_free(bat_priv, tt_global,
 					      "Roaming canceled");
-			tt_global = NULL;
 		} else {
 			/* The global entry has to be marked as ROAMING and
 			 * has to be kept for consistency purpose



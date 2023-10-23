Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D667D3105
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjJWLEi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjJWLEh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:04:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC9B10CB
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:04:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA4DC433C9;
        Mon, 23 Oct 2023 11:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059074;
        bh=oYF+6LoYrMZN7de1IynkkjsAoSRfRFYlknvh9viTn0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IhySvIJ/XPZT0Va97qvB/2MRMwfgoQoNxeifI6kNnIxJQywi5tUUYx6iMasrOBT5K
         0Y4klmoUzNVdPJm9g5B4cMG9uO20yc81IwVhcTn0TRGFeHkM+BZ7u98PIOxhOYoev2
         miizo0TjCRszyHKr9GhaW/tb0SJI5MkxDmGcutKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 6.5 054/241] xfrm: fix a data-race in xfrm_lookup_with_ifid()
Date:   Mon, 23 Oct 2023 12:54:00 +0200
Message-ID: <20231023104835.223924384@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit de5724ca38fd5e442bae9c1fab31942b6544012d upstream.

syzbot complains about a race in xfrm_lookup_with_ifid() [1]

When preparing commit 0a9e5794b21e ("xfrm: annotate data-race
around use_time") I thought xfrm_lookup_with_ifid() was modifying
a still private structure.

[1]
BUG: KCSAN: data-race in xfrm_lookup_with_ifid / xfrm_lookup_with_ifid

write to 0xffff88813ea41108 of 8 bytes by task 8150 on cpu 1:
xfrm_lookup_with_ifid+0xce7/0x12d0 net/xfrm/xfrm_policy.c:3218
xfrm_lookup net/xfrm/xfrm_policy.c:3270 [inline]
xfrm_lookup_route+0x3b/0x100 net/xfrm/xfrm_policy.c:3281
ip6_dst_lookup_flow+0x98/0xc0 net/ipv6/ip6_output.c:1246
send6+0x241/0x3c0 drivers/net/wireguard/socket.c:139
wg_socket_send_skb_to_peer+0xbd/0x130 drivers/net/wireguard/socket.c:178
wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
process_one_work kernel/workqueue.c:2630 [inline]
process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
worker_thread+0x525/0x730 kernel/workqueue.c:2784
kthread+0x1d7/0x210 kernel/kthread.c:388
ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

write to 0xffff88813ea41108 of 8 bytes by task 15867 on cpu 0:
xfrm_lookup_with_ifid+0xce7/0x12d0 net/xfrm/xfrm_policy.c:3218
xfrm_lookup net/xfrm/xfrm_policy.c:3270 [inline]
xfrm_lookup_route+0x3b/0x100 net/xfrm/xfrm_policy.c:3281
ip6_dst_lookup_flow+0x98/0xc0 net/ipv6/ip6_output.c:1246
send6+0x241/0x3c0 drivers/net/wireguard/socket.c:139
wg_socket_send_skb_to_peer+0xbd/0x130 drivers/net/wireguard/socket.c:178
wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
process_one_work kernel/workqueue.c:2630 [inline]
process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
worker_thread+0x525/0x730 kernel/workqueue.c:2784
kthread+0x1d7/0x210 kernel/kthread.c:388
ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

value changed: 0x00000000651cd9d1 -> 0x00000000651cd9d2

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 15867 Comm: kworker/u4:58 Not tainted 6.6.0-rc4-syzkaller-00016-g5e62ed3b1c8a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: wg-kex-wg2 wg_packet_handshake_send_worker

Fixes: 0a9e5794b21e ("xfrm: annotate data-race around use_time")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_policy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3215,7 +3215,7 @@ no_transform:
 	}
 
 	for (i = 0; i < num_pols; i++)
-		pols[i]->curlft.use_time = ktime_get_real_seconds();
+		WRITE_ONCE(pols[i]->curlft.use_time, ktime_get_real_seconds());
 
 	if (num_xfrms < 0) {
 		/* Prohibit the flow */



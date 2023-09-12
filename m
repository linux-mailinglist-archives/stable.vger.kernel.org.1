Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9395C79B01A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378678AbjIKWgb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbjIKP2D (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:28:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06DEE4
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:27:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CA8C433C8;
        Mon, 11 Sep 2023 15:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694446078;
        bh=Ee7VVOQKB94UosNSKdvs+QT/MWt+55Quy+mjrzDR+xQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mU06nTVGkTVc1Ifl5k9kwAEQCvz84XcntEnqG6TZUzXH2y8aJkQtwaFUnBathjzGo
         Y8hL9rZL0HBfB84z171PjX3L49D8/zmJNriBm7fR7tDrUY7dWNGOxRL/6arm5Ph83Q
         qtr3SaQ9vvwKGSLNwAmc4QKWc3/DGIF5Ea+9yHo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
        syzbot+4a9f9820bd8d302e22f7@syzkaller.appspotmail.com,
        Will Deacon <will@kernel.org>
Subject: [PATCH 6.1 545/600] arm64: csum: Fix OoB access in IP checksum code for negative lengths
Date:   Mon, 11 Sep 2023 15:49:38 +0200
Message-ID: <20230911134649.707769460@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will@kernel.org>

commit 8bd795fedb8450ecbef18eeadbd23ed8fc7630f5 upstream.

Although commit c2c24edb1d9c ("arm64: csum: Fix pathological zero-length
calls") added an early return for zero-length input, syzkaller has
popped up with an example of a _negative_ length which causes an
undefined shift and an out-of-bounds read:

 | BUG: KASAN: slab-out-of-bounds in do_csum+0x44/0x254 arch/arm64/lib/csum.c:39
 | Read of size 4294966928 at addr ffff0000d7ac0170 by task syz-executor412/5975
 |
 | CPU: 0 PID: 5975 Comm: syz-executor412 Not tainted 6.4.0-rc4-syzkaller-g908f31f2a05b #0
 | Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
 | Call trace:
 |  dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 |  show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 |  __dump_stack lib/dump_stack.c:88 [inline]
 |  dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 |  print_address_description mm/kasan/report.c:351 [inline]
 |  print_report+0x174/0x514 mm/kasan/report.c:462
 |  kasan_report+0xd4/0x130 mm/kasan/report.c:572
 |  kasan_check_range+0x264/0x2a4 mm/kasan/generic.c:187
 |  __kasan_check_read+0x20/0x30 mm/kasan/shadow.c:31
 |  do_csum+0x44/0x254 arch/arm64/lib/csum.c:39
 |  csum_partial+0x30/0x58 lib/checksum.c:128
 |  gso_make_checksum include/linux/skbuff.h:4928 [inline]
 |  __udp_gso_segment+0xaf4/0x1bc4 net/ipv4/udp_offload.c:332
 |  udp6_ufo_fragment+0x540/0xca0 net/ipv6/udp_offload.c:47
 |  ipv6_gso_segment+0x5cc/0x1760 net/ipv6/ip6_offload.c:119
 |  skb_mac_gso_segment+0x2b4/0x5b0 net/core/gro.c:141
 |  __skb_gso_segment+0x250/0x3d0 net/core/dev.c:3401
 |  skb_gso_segment include/linux/netdevice.h:4859 [inline]
 |  validate_xmit_skb+0x364/0xdbc net/core/dev.c:3659
 |  validate_xmit_skb_list+0x94/0x130 net/core/dev.c:3709
 |  sch_direct_xmit+0xe8/0x548 net/sched/sch_generic.c:327
 |  __dev_xmit_skb net/core/dev.c:3805 [inline]
 |  __dev_queue_xmit+0x147c/0x3318 net/core/dev.c:4210
 |  dev_queue_xmit include/linux/netdevice.h:3085 [inline]
 |  packet_xmit+0x6c/0x318 net/packet/af_packet.c:276
 |  packet_snd net/packet/af_packet.c:3081 [inline]
 |  packet_sendmsg+0x376c/0x4c98 net/packet/af_packet.c:3113
 |  sock_sendmsg_nosec net/socket.c:724 [inline]
 |  sock_sendmsg net/socket.c:747 [inline]
 |  __sys_sendto+0x3b4/0x538 net/socket.c:2144

Extend the early return to reject negative lengths as well, aligning our
implementation with the generic code in lib/checksum.c

Cc: Robin Murphy <robin.murphy@arm.com>
Fixes: 5777eaed566a ("arm64: Implement optimised checksum routine")
Reported-by: syzbot+4a9f9820bd8d302e22f7@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/000000000000e0e94c0603f8d213@google.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/lib/csum.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/lib/csum.c
+++ b/arch/arm64/lib/csum.c
@@ -24,7 +24,7 @@ unsigned int __no_sanitize_address do_cs
 	const u64 *ptr;
 	u64 data, sum64 = 0;
 
-	if (unlikely(len == 0))
+	if (unlikely(len <= 0))
 		return 0;
 
 	offset = (unsigned long)buff & 7;



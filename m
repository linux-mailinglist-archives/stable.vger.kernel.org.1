Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D4E7A3A0E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbjIQT54 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240272AbjIQT5t (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:57:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709D2EE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:57:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24A7C433C8;
        Sun, 17 Sep 2023 19:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980663;
        bh=jN+IicPruRospwHvB2lRxnl7vJMNQhqiZT+iDE685/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1IMNwUByOm64NXHZBsg9TolJ2j6UGjaW+73xMRUu/iShDuE5QSXV2J3qtmZY1BFSe
         zQXZ5FgjaQ7B9R+Hx2LD/cBFBaw2vtaSeMMpY6oPqg1+CyZKFeIq5bPp5E9E+MRR4b
         5xA3wRIS+JyZB2ai/5QFDMY7GdJBSKVFDTW/WeLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+bf7e6250c7ce248f3ec9@syzkaller.appspotmail.com,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 257/285] hsr: Fix uninit-value access in fill_frame_info()
Date:   Sun, 17 Sep 2023 21:14:17 +0200
Message-ID: <20230917191100.165452583@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ziyang Xuan <william.xuanziyang@huawei.com>

[ Upstream commit 484b4833c604c0adcf19eac1ca14b60b757355b5 ]

Syzbot reports the following uninit-value access problem.

=====================================================
BUG: KMSAN: uninit-value in fill_frame_info net/hsr/hsr_forward.c:601 [inline]
BUG: KMSAN: uninit-value in hsr_forward_skb+0x9bd/0x30f0 net/hsr/hsr_forward.c:616
 fill_frame_info net/hsr/hsr_forward.c:601 [inline]
 hsr_forward_skb+0x9bd/0x30f0 net/hsr/hsr_forward.c:616
 hsr_dev_xmit+0x192/0x330 net/hsr/hsr_device.c:223
 __netdev_start_xmit include/linux/netdevice.h:4889 [inline]
 netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 xmit_one net/core/dev.c:3544 [inline]
 dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3560
 __dev_queue_xmit+0x34d0/0x52a0 net/core/dev.c:4340
 dev_queue_xmit include/linux/netdevice.h:3082 [inline]
 packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3087 [inline]
 packet_sendmsg+0x8b1d/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 __sys_sendto+0x781/0xa30 net/socket.c:2176
 __do_sys_sendto net/socket.c:2188 [inline]
 __se_sys_sendto net/socket.c:2184 [inline]
 __ia32_sys_sendto+0x11f/0x1c0 net/socket.c:2184
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
 kmalloc_reserve+0x148/0x470 net/core/skbuff.c:559
 __alloc_skb+0x318/0x740 net/core/skbuff.c:644
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6299
 sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2794
 packet_alloc_skb net/packet/af_packet.c:2936 [inline]
 packet_snd net/packet/af_packet.c:3030 [inline]
 packet_sendmsg+0x70e8/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 __sys_sendto+0x781/0xa30 net/socket.c:2176
 __do_sys_sendto net/socket.c:2188 [inline]
 __se_sys_sendto net/socket.c:2184 [inline]
 __ia32_sys_sendto+0x11f/0x1c0 net/socket.c:2184
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

It is because VLAN not yet supported in hsr driver. Return error
when protocol is ETH_P_8021Q in fill_frame_info() now to fix it.

Fixes: 451d8123f897 ("net: prp: add packet handling support")
Reported-by: syzbot+bf7e6250c7ce248f3ec9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bf7e6250c7ce248f3ec9
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_forward.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 629daacc96071..b71dab630a873 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -594,6 +594,7 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 		proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
 		/* FIXME: */
 		netdev_warn_once(skb->dev, "VLAN not yet supported");
+		return -EINVAL;
 	}
 
 	frame->is_from_san = false;
-- 
2.40.1




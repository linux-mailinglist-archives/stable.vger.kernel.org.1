Return-Path: <stable+bounces-93109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A489CD75E
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E517281F20
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C4518B470;
	Fri, 15 Nov 2024 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l8FC9wew"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD918A92D;
	Fri, 15 Nov 2024 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652835; cv=none; b=hIfm0tGtTfI3UfHuDupKj3qcjQEvlOeVPHq2GuUD/+u4GkxGr4EHNiqGMWBpMU/3/IH074xSWxLIHSkfoc9X8TnkP7jUhAANxuynzJiOCWOSZk0AEX8F7t7EwR6Ml7SQFKBlyDso/AN2yWPrDJNQx5b0wG3m1gXgnxJPweFNh58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652835; c=relaxed/simple;
	bh=G2pCQXqngg0GTD69TZa9KPl9XE5k1qy7mFarN1yQpDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lo98YCouAtPQkUdm8euoD2Ej0+cKtUxJ3EkvC5SQO33yWSmZk8g5UuvraJ0bbLxQVqC79N+dXWZPVBf8VwZsDL7lMRzuhNOxZxxazEzTxQZA8z7ktJJScTtfV6XuUmGBrDHyQcITDELUPsjLkvHJQ1+f34FzkVfGTsK6LIzruJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l8FC9wew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48791C4CECF;
	Fri, 15 Nov 2024 06:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731652834;
	bh=G2pCQXqngg0GTD69TZa9KPl9XE5k1qy7mFarN1yQpDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l8FC9wewWpO2VSV3059dDdL/kxmcZC4cAbU9tmW//oY9xTeKln2iM2x5OqvRp5JqF
	 rgRSQoQQ3zruKFNR1VDC5q6KUYXmlVTdQG3taf42vEMfvfUjgEscuAFSZqVIkDoDjH
	 oBsT8dp4k7wwHmXFVobIVCW/IKHn/jo6DvJrgQds=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+a63a1f6a062033cf0f40@syzkaller.appspotmail.com,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Randy MacLeod <Randy.MacLeod@windriver.com>
Subject: [PATCH 4.19 28/52] net: bridge: xmit: make sure we have at least eth header len bytes
Date: Fri, 15 Nov 2024 07:37:41 +0100
Message-ID: <20241115063723.875638846@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.845867306@linuxfoundation.org>
References: <20241115063722.845867306@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Aleksandrov <razor@blackwall.org>

commit 8bd67ebb50c0145fd2ca8681ab65eb7e8cde1afc upstream.

syzbot triggered an uninit value[1] error in bridge device's xmit path
by sending a short (less than ETH_HLEN bytes) skb. To fix it check if
we can actually pull that amount instead of assuming.

Tested with dropwatch:
 drop at: br_dev_xmit+0xb93/0x12d0 [bridge] (0xffffffffc06739b3)
 origin: software
 timestamp: Mon May 13 11:31:53 2024 778214037 nsec
 protocol: 0x88a8
 length: 2
 original length: 2
 drop reason: PKT_TOO_SMALL

[1]
BUG: KMSAN: uninit-value in br_dev_xmit+0x61d/0x1cb0 net/bridge/br_device.c:65
 br_dev_xmit+0x61d/0x1cb0 net/bridge/br_device.c:65
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3547
 __dev_queue_xmit+0x34db/0x5350 net/core/dev.c:4341
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 __bpf_tx_skb net/core/filter.c:2136 [inline]
 __bpf_redirect_common net/core/filter.c:2180 [inline]
 __bpf_redirect+0x14a6/0x1620 net/core/filter.c:2187
 ____bpf_clone_redirect net/core/filter.c:2460 [inline]
 bpf_clone_redirect+0x328/0x470 net/core/filter.c:2432
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2238
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_test_run+0x499/0xc30 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0x14ea/0x1f20 net/bpf/test_run.c:1058
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4269
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5678
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5765
 x64_sys_call+0x96b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+a63a1f6a062033cf0f40@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a63a1f6a062033cf0f40
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Randy MacLeod <Randy.MacLeod@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_device.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -41,6 +41,11 @@ netdev_tx_t br_dev_xmit(struct sk_buff *
 	const unsigned char *dest;
 	u16 vid = 0;
 
+	if (unlikely(!pskb_may_pull(skb, ETH_HLEN))) {
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
 
 	rcu_read_lock();




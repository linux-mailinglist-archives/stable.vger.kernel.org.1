Return-Path: <stable+bounces-93412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A509CD923
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3178EB27CE9
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DF71885BF;
	Fri, 15 Nov 2024 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WAubJD8I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0615FD13;
	Fri, 15 Nov 2024 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653840; cv=none; b=FbcD7Up83BXjo3ZrlDTo2zAxK62iHG6wUkuse85bc8NxC9NUr7TvPKr8G7X2hDKWuEPzY8EGzAjguKwmOt/zoHR1FQakqaWgT20VnN2cpaiQOaYhdxk/l7vOpD0sZu2W+yE6CgT8gMeIA5VACH5zYvrVRJe/kI9ANHg7am3eRjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653840; c=relaxed/simple;
	bh=ARR9RtuJvzUWzgW4qp1seEzEa3iZY/uiOl8I24x6pck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQjIp4Xycx9wzxDRGRAmOhMDsROsWmbRD3V1iBJLDdH8j0dk37ecgmKKmoDO9wYi/UR+W8LhmsCrFp8wAWkhNIqNnvPATfcPBtqGpgKbs5eCUy1XH1Vz4CElmK43N3WC9MQH+ES2wgcIVh0mbPDsejZpZuD4sYQbYxXit3DGMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WAubJD8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73496C4CECF;
	Fri, 15 Nov 2024 06:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653839;
	bh=ARR9RtuJvzUWzgW4qp1seEzEa3iZY/uiOl8I24x6pck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WAubJD8IIUpwTqr4QNEg0qyn/EGbzhMvLCHNMtm54wdTrw+Y5rAJ9HmbVTrJeBtwz
	 ozDFEYc4F+KpUmk2op8dpJvsyprU5+NhNWwpy45sVmRG57T9NZt5dvKMc5Rk6/T5OS
	 RVDFgQ/gotdrgyV/wOqesSMeNEG78aclnOvj/Mxk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+a63a1f6a062033cf0f40@syzkaller.appspotmail.com,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Randy MacLeod <Randy.MacLeod@windriver.com>
Subject: [PATCH 5.10 50/82] net: bridge: xmit: make sure we have at least eth header len bytes
Date: Fri, 15 Nov 2024 07:38:27 +0100
Message-ID: <20241115063727.362864868@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063725.561151311@linuxfoundation.org>
References: <20241115063725.561151311@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -36,6 +36,11 @@ netdev_tx_t br_dev_xmit(struct sk_buff *
 	const unsigned char *dest;
 	u16 vid = 0;
 
+	if (unlikely(!pskb_may_pull(skb, ETH_HLEN))) {
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
 
 	rcu_read_lock();




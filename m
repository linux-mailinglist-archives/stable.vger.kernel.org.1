Return-Path: <stable+bounces-82969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBD6994FB2
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4272E1F22B7C
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873AA1DF97B;
	Tue,  8 Oct 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VqJwB3uz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464F21DF254;
	Tue,  8 Oct 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394041; cv=none; b=LMUkPn5p9YE/jFwSlj9oE/ffOjz3e6KZrkSeM61jbxqO6OtCnvXk6jTg4URFij0Csy7VGoexGP8JXZRKHgU1lsh4DpzPuh+wOude0b0stSFn9ck/0wACNTrIoz4bLqWMtpUudFRv0lKyEXDjV0Gt86976pUcnfBDvgComFQaHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394041; c=relaxed/simple;
	bh=znrQcowjjeI7d2ohEiAqz/e+zbWYeOqg/dWojRLJysM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T270vcSUqywkJtFtFFc46OY58rdYnOypulGQEwY1zbKEOJxzymqQ/w+NJfvvteO81vYISoqZYwTf/NAdMvjkcYEazJKSjBmlvEy748N1Kr2hmmzibAUr2+f8g4hNXC2hgbMhqU47hyXNlEnWsnZzSAWViU19G2LIYWCUdzU9pf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VqJwB3uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A836DC4CEC7;
	Tue,  8 Oct 2024 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728394041;
	bh=znrQcowjjeI7d2ohEiAqz/e+zbWYeOqg/dWojRLJysM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VqJwB3uzLDDqoJdvQDCpVzSdv69/jBO6lCq2IP29zOpiZNSVe0eOHaIigUGVK2T9l
	 khLyhUy4lbjUivY6Nc2+qLabwCNSHj76qfR5F2MVdD+GX7hwdDloTGa0XEz04MKFXu
	 1CNfopP4cqk9X2YsgwalB/9QW9C+xR1xMkRLd3Ec=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Greear <greearb@candelatech.com>,
	Willem de Bruijn <willemb@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 298/386] vrf: revert "vrf: Remove unnecessary RCU-bh critical section"
Date: Tue,  8 Oct 2024 14:09:03 +0200
Message-ID: <20241008115641.113661666@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

commit b04c4d9eb4f25b950b33218e33b04c94e7445e51 upstream.

This reverts commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853.

dev_queue_xmit_nit is expected to be called with BH disabled.
__dev_queue_xmit has the following:

        /* Disable soft irqs for various locks below. Also
         * stops preemption for RCU.
         */
        rcu_read_lock_bh();

VRF must follow this invariant. The referenced commit removed this
protection. Which triggered a lockdep warning:

	================================
	WARNING: inconsistent lock state
	6.11.0 #1 Tainted: G        W
	--------------------------------
	inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
	btserver/134819 [HC0[0]:SC0[0]:HE1:SE1] takes:
	ffff8882da30c118 (rlock-AF_PACKET){+.?.}-{2:2}, at: tpacket_rcv+0x863/0x3b30
	{IN-SOFTIRQ-W} state was registered at:
	  lock_acquire+0x19a/0x4f0
	  _raw_spin_lock+0x27/0x40
	  packet_rcv+0xa33/0x1320
	  __netif_receive_skb_core.constprop.0+0xcb0/0x3a90
	  __netif_receive_skb_list_core+0x2c9/0x890
	  netif_receive_skb_list_internal+0x610/0xcc0
          [...]

	other info that might help us debug this:
	 Possible unsafe locking scenario:

	       CPU0
	       ----
	  lock(rlock-AF_PACKET);
	  <Interrupt>
	    lock(rlock-AF_PACKET);

	 *** DEADLOCK ***

	Call Trace:
	 <TASK>
	 dump_stack_lvl+0x73/0xa0
	 mark_lock+0x102e/0x16b0
	 __lock_acquire+0x9ae/0x6170
	 lock_acquire+0x19a/0x4f0
	 _raw_spin_lock+0x27/0x40
	 tpacket_rcv+0x863/0x3b30
	 dev_queue_xmit_nit+0x709/0xa40
	 vrf_finish_direct+0x26e/0x340 [vrf]
	 vrf_l3_out+0x5f4/0xe80 [vrf]
	 __ip_local_out+0x51e/0x7a0
          [...]

Fixes: 504fc6f4f7f6 ("vrf: Remove unnecessary RCU-bh critical section")
Link: https://lore.kernel.org/netdev/20240925185216.1990381-1-greearb@candelatech.com/
Reported-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Cc: stable@vger.kernel.org
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20240929061839.1175300-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vrf.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -628,7 +628,9 @@ static void vrf_finish_direct(struct sk_
 		eth_zero_addr(eth->h_dest);
 		eth->h_proto = skb->protocol;
 
+		rcu_read_lock_bh();
 		dev_queue_xmit_nit(skb, vrf_dev);
+		rcu_read_unlock_bh();
 
 		skb_pull(skb, ETH_HLEN);
 	}




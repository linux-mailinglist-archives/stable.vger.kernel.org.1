Return-Path: <stable+bounces-78204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A103989342
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 08:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2E91C22ECD
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 06:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7DF43172;
	Sun, 29 Sep 2024 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuhkQd4P"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF57B65C;
	Sun, 29 Sep 2024 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727590726; cv=none; b=aQDJOr2Ry21TTr1EqEcSLCWCCuRY+W6F25nsyELgxfXV0IDMIXMyz8vYFJsK3JjVi8M8fCjTmwtA1GxdKQh2SxEA/9QjoJluoFLP80sfuy7FdqoCd+wgx+/jIWhCPBtzMr+Q6fS9TYeY+EldGCvDAa+sfJzBq/Oa3FRGd3wWGO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727590726; c=relaxed/simple;
	bh=xO6ysQFEQSU8GQuLwhaYGu4B1cQcmCxn8wOY7WiKZVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G2b0/GgOipsynXIr3vy30Q7uDGfsiZBKUcCnSYNp5AvWcPdsBQRxoUCmNA5pEYezs+6Rd1dcVZoMdzOr/ljUjueJ8ZWtM5NpcA/Wcb7VkobdpAHjqwv+ufc0AcT571hU8eVqt0Z4XSdqygMXvsOJWbIvcg1jZX+l5IL3cWo2ZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuhkQd4P; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cb2458774dso25084026d6.3;
        Sat, 28 Sep 2024 23:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727590724; x=1728195524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6prHHvVXufFaX5cL74jbezatyZL1UkIMWvI9U1k34I=;
        b=WuhkQd4P507+Nx3OCqRnuWeaTNQ96y5dXK4d0jQwGVGtB+yh6dFo1J5PaQz+RM/3Fq
         9uycxwm6VDPoHXbRZVYgob19eqTLoEbJ9P8wuUV3IZgv0rcEsJF/yHtOgMcp7FRb40jD
         QJUtYjxBKJR+P3hjeAes1RHgUX4QCQgUgqpr7VqzyjAV4xyXckEIsyBR+5B2N7YXxc5e
         7UJHY+wCDj3e/7kAjZUrMc9ne+pi5ITamSS7p9K3KNaumQy5x9rS7S26AabURvSMGobt
         0Moz4zySoP2RgoM8Q8JpXYcOAR4L2dR63kP6akrC2oVV5E2RudNmcZkmEKqZEfeWl7EB
         LSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727590724; x=1728195524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6prHHvVXufFaX5cL74jbezatyZL1UkIMWvI9U1k34I=;
        b=mQwkEXlWgWgdrO36lnI2nmJd1u2kLttdXXOxh802owIZ9HVx5LpAonspE3orQnHHP6
         tqpXJzIurjFYtqi9Jr5xTQ2cGNc5fXUzOEhQDAHlP8UN4ICOUh28+EA+u4x5HCgSc1Rp
         EqNpddjlaXvH/mNw/QXTmtu3AVrP+0cBDE2fc+aJNFflX+51e4oT9UkiPh9hHn4X9h8f
         btT3Wkb8b76PP+nUbJe3awfPPgQTQVXFuEml4Oxc9wEN9cgap8SKrcce6dAag01Xj3ji
         oa50UmwoSLvCqYGzfuuaxXko4qhK6NBYvGKoi8J72gcQrYW4/hyS+6LUvqA7g+Y7DY/E
         ViWg==
X-Forwarded-Encrypted: i=1; AJvYcCXQLmFiCx5phhuPcuBZ/B3Ou8qrDAPa7YVIOOetCqHgCQDPF7bfnXEo8+9a8BZXqi6yKsrQpts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+fK6f2hrvN5iRQimwj5T0WL352O5pk/lJIBUQE/9t0zl9qj9I
	di0t61jjGUY6aPm2pl++r+1zTJ3efv+Wn8JUBfy0MgsrjovDfycFlPQLAQ==
X-Google-Smtp-Source: AGHT+IEh6OYV60gvxV/QcKhGx64139+NULnzFQ4/DGTc7+pvF0x8XVmowiDXLyNHQlSX5USY5QA8Vg==
X-Received: by 2002:a05:6214:460b:b0:6cb:6089:eb83 with SMTP id 6a1803df08f44-6cb6089ef29mr7076966d6.28.1727590723676;
        Sat, 28 Sep 2024 23:18:43 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b62c057sm26470016d6.60.2024.09.28.23.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 23:18:42 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	greearb@candelatech.com,
	fw@strlen.de,
	dsahern@kernel.org,
	idosch@nvidia.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] vrf: revert "vrf: Remove unnecessary RCU-bh critical section"
Date: Sun, 29 Sep 2024 02:18:20 -0400
Message-ID: <20240929061839.1175300-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

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
---
 drivers/net/vrf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 4d8ccaf9a2b4..4087f72f0d2b 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -608,7 +608,9 @@ static void vrf_finish_direct(struct sk_buff *skb)
 		eth_zero_addr(eth->h_dest);
 		eth->h_proto = skb->protocol;
 
+		rcu_read_lock_bh();
 		dev_queue_xmit_nit(skb, vrf_dev);
+		rcu_read_unlock_bh();
 
 		skb_pull(skb, ETH_HLEN);
 	}
-- 
2.46.1.824.gd892dcdcdd-goog



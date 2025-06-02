Return-Path: <stable+bounces-150017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBA4ACB62D
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB6D9E4A40
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAD4225A24;
	Mon,  2 Jun 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mOW0I27j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90F71E3772;
	Mon,  2 Jun 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875771; cv=none; b=qq6F5StGdjpyJYJRNjaPug5N4yxwBROk9mnv+WnI5L8A9MbZoT0FVDdMwygghE6dsmIV3lrmcC9Uo19yY44VDLuhDuOUcu5MprKJR8O4fLFgpC8BLsLloDsKdAk2avpipmUWh2UYjSPdFF0KwyGt+kPMUc/guqK8p/hMqhnv3Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875771; c=relaxed/simple;
	bh=KgzTB55ZxbUP3BUGKtpj+t+Db13LFyHJnr1O2iTgMoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1cjXkUqy3oqxbKvbCFS+FrByGfJrVACqNVkE1uyAC5pQ4gAqko91qsu3mxdubqV391+DIvsZHdb1se8bgKFLp3uOPCwgfPkweS0Tjpgi3DqOHEOei7Bi9s4Y6GW3R6R4L9ncixCHqT6GGdcPbL4HP/k0Na2JgPedZGHRceOdIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mOW0I27j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4640EC4CEEB;
	Mon,  2 Jun 2025 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875770;
	bh=KgzTB55ZxbUP3BUGKtpj+t+Db13LFyHJnr1O2iTgMoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mOW0I27j86iCFHzQKnhGJ9P1CtYq0uzKSw5Z3/aiOD33htcYzz8qq8oW0kEf66jWD
	 osYvcLurhMB2IbIaTv4gIDp+iFpUKI10ry1OvLmnx178Cu8E5ilHBh/8mGSjuUM/Ce
	 65cLimNx/PN5NIsbbtTbG2vwbJhpN8Of3AQti3FM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+55c12726619ff85ce1f6@syzkaller.appspotmail.com,
	Wang Liang <wangliang74@huawei.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 239/270] net/tipc: fix slab-use-after-free Read in tipc_aead_encrypt_done
Date: Mon,  2 Jun 2025 15:48:44 +0200
Message-ID: <20250602134317.090961630@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Wang Liang <wangliang74@huawei.com>

[ Upstream commit e279024617134c94fd3e37470156534d5f2b3472 ]

Syzbot reported a slab-use-after-free with the following call trace:

  ==================================================================
  BUG: KASAN: slab-use-after-free in tipc_aead_encrypt_done+0x4bd/0x510 net/tipc/crypto.c:840
  Read of size 8 at addr ffff88807a733000 by task kworker/1:0/25

  Call Trace:
   kasan_report+0xd9/0x110 mm/kasan/report.c:601
   tipc_aead_encrypt_done+0x4bd/0x510 net/tipc/crypto.c:840
   crypto_request_complete include/crypto/algapi.h:266
   aead_request_complete include/crypto/internal/aead.h:85
   cryptd_aead_crypt+0x3b8/0x750 crypto/cryptd.c:772
   crypto_request_complete include/crypto/algapi.h:266
   cryptd_queue_worker+0x131/0x200 crypto/cryptd.c:181
   process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231

  Allocated by task 8355:
   kzalloc_noprof include/linux/slab.h:778
   tipc_crypto_start+0xcc/0x9e0 net/tipc/crypto.c:1466
   tipc_init_net+0x2dd/0x430 net/tipc/core.c:72
   ops_init+0xb9/0x650 net/core/net_namespace.c:139
   setup_net+0x435/0xb40 net/core/net_namespace.c:343
   copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
   create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
   unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
   ksys_unshare+0x419/0x970 kernel/fork.c:3323
   __do_sys_unshare kernel/fork.c:3394

  Freed by task 63:
   kfree+0x12a/0x3b0 mm/slub.c:4557
   tipc_crypto_stop+0x23c/0x500 net/tipc/crypto.c:1539
   tipc_exit_net+0x8c/0x110 net/tipc/core.c:119
   ops_exit_list+0xb0/0x180 net/core/net_namespace.c:173
   cleanup_net+0x5b7/0xbf0 net/core/net_namespace.c:640
   process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231

After freed the tipc_crypto tx by delete namespace, tipc_aead_encrypt_done
may still visit it in cryptd_queue_worker workqueue.

I reproduce this issue by:
  ip netns add ns1
  ip link add veth1 type veth peer name veth2
  ip link set veth1 netns ns1
  ip netns exec ns1 tipc bearer enable media eth dev veth1
  ip netns exec ns1 tipc node set key this_is_a_master_key master
  ip netns exec ns1 tipc bearer disable media eth dev veth1
  ip netns del ns1

The key of reproduction is that, simd_aead_encrypt is interrupted, leading
to crypto_simd_usable() return false. Thus, the cryptd_queue_worker is
triggered, and the tipc_crypto tx will be visited.

  tipc_disc_timeout
    tipc_bearer_xmit_skb
      tipc_crypto_xmit
        tipc_aead_encrypt
          crypto_aead_encrypt
            // encrypt()
            simd_aead_encrypt
              // crypto_simd_usable() is false
              child = &ctx->cryptd_tfm->base;

  simd_aead_encrypt
    crypto_aead_encrypt
      // encrypt()
      cryptd_aead_encrypt_enqueue
        cryptd_aead_enqueue
          cryptd_enqueue_request
            // trigger cryptd_queue_worker
            queue_work_on(smp_processor_id(), cryptd_wq, &cpu_queue->work)

Fix this by holding net reference count before encrypt.

Reported-by: syzbot+55c12726619ff85ce1f6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=55c12726619ff85ce1f6
Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
Link: https://patch.msgid.link/20250520101404.1341730-1-wangliang74@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/crypto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index bf384bd126963..159d891b81c59 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -821,12 +821,16 @@ static int tipc_aead_encrypt(struct tipc_aead *aead, struct sk_buff *skb,
 		goto exit;
 	}
 
+	/* Get net to avoid freed tipc_crypto when delete namespace */
+	get_net(aead->crypto->net);
+
 	/* Now, do encrypt */
 	rc = crypto_aead_encrypt(req);
 	if (rc == -EINPROGRESS || rc == -EBUSY)
 		return rc;
 
 	tipc_bearer_put(b);
+	put_net(aead->crypto->net);
 
 exit:
 	kfree(ctx);
@@ -864,6 +868,7 @@ static void tipc_aead_encrypt_done(struct crypto_async_request *base, int err)
 	kfree(tx_ctx);
 	tipc_bearer_put(b);
 	tipc_aead_put(aead);
+	put_net(net);
 }
 
 /**
-- 
2.39.5





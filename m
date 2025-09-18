Return-Path: <stable+bounces-169167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE265B2385E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AECE5A14AA
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ADF2D3A94;
	Tue, 12 Aug 2025 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NtvFQlvz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CED28505A;
	Tue, 12 Aug 2025 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026604; cv=none; b=Fq6n/AWviHY2vAVW0udCkk8CkCSdMcd5vMvIgdGPc8Fx1u2NCWxzU44k4SIc5enhvLFTCYc5UBnNu4dwb4KHjBbCJsENLhMz511eDeojNkmeNMwCgozgST6TxnRyYIc78rp1Cxbd9R9vb3TfjFDKUZ+AOHmEJtEiu1Qf9nkuRbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026604; c=relaxed/simple;
	bh=kBT7yEU/nA6gN9fa04/oKJ3k3359LbZHqsqLpkKrpJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GP9VAJKtaqcJ3pIc3Q3d4I4yFV05IictNlSF6ET9XBNrNt1Tb9hvkJXdBEv3w2gghNQhj02QxTe6/K0Bh/PKDcDgIsA1yi4USOKTlTrwR7rG2Ou6TDL02JVHznMqF9PfIK4VbvmgbfMVYibhmFx5x28xj7q2v1aPoQxztlOXOXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NtvFQlvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F95AC4CEFD;
	Tue, 12 Aug 2025 19:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026604;
	bh=kBT7yEU/nA6gN9fa04/oKJ3k3359LbZHqsqLpkKrpJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtvFQlvzXZdjNwdZkerXLChCsGN6eFwVn0rmjb06zbO06kWA16Q2n+9iVvscEnu0f
	 ZZZ5wmrK0MPMtvc7s6dB195NGAmopDR5wC2t5L9k7q5fPOVrvZNIAS2M5uA8eGiH8o
	 hU0G2LnL9ejGZgqSs6WuZpCHTP+4Nnaj/B/qwvk8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 386/480] netpoll: prevent hanging NAPI when netcons gets enabled
Date: Tue, 12 Aug 2025 19:49:54 +0200
Message-ID: <20250812174413.357120350@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 2da4def0f487f24bbb0cece3bb2bcdcb918a0b72 ]

Paolo spotted hangs in NIPA running driver tests against virtio.
The tests hang in virtnet_close() -> virtnet_napi_tx_disable().

The problem is only reproducible if running multiple of our tests
in sequence (I used TEST_PROGS="xdp.py ping.py netcons_basic.sh \
netpoll_basic.py stats.py"). Initial suspicion was that this is
a simple case of double-disable of NAPI, but instrumenting the
code reveals:

 Deadlocked on NAPI ffff888007cd82c0 (virtnet_poll_tx):
   state: 0x37, disabled: false, owner: 0, listed: false, weight: 64

The NAPI was not in fact disabled, owner is 0 (rather than -1),
so the NAPI "thinks" it's scheduled for CPU 0 but it's not listed
(!list_empty(&n->poll_list) => false). It seems odd that normal NAPI
processing would wedge itself like this.

Better suspicion is that netpoll gets enabled while NAPI is polling,
and also grabs the NAPI instance. This confuses napi_complete_done():

  [netpoll]                                   [normal NAPI]
                                        napi_poll()
                                          have = netpoll_poll_lock()
                                            rcu_access_pointer(dev->npinfo)
                                              return NULL # no netpoll
                                          __napi_poll()
					    ->poll(->weight)
  poll_napi()
    cmpxchg(->poll_owner, -1, cpu)
      poll_one_napi()
        set_bit(NAPI_STATE_NPSVC, ->state)
                                              napi_complete_done()
                                                if (NAPIF_STATE_NPSVC)
                                                  return false
                                           # exit without clearing SCHED

This feels very unlikely, but perhaps virtio has some interactions
with the hypervisor in the NAPI ->poll that makes the race window
larger?

Best I could to to prove the theory was to add and trigger this
warning in napi_poll (just before netpoll_poll_unlock()):

      WARN_ONCE(!have && rcu_access_pointer(n->dev->npinfo) &&
                napi_is_scheduled(n) && list_empty(&n->poll_list),
                "NAPI race with netpoll %px", n);

If this warning hits the next virtio_close() will hang.

This patch survived 30 test iterations without a hang (without it
the longest clean run was around 10). Credit for triggering this
goes to Breno's recent netconsole tests.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Link: https://patch.msgid.link/20250726010846.1105875-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netpoll.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 6ad84d4a2b46..63477a6dd6e9 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -831,6 +831,13 @@ int netpoll_setup(struct netpoll *np)
 	if (err)
 		goto flush;
 	rtnl_unlock();
+
+	/* Make sure all NAPI polls which started before dev->npinfo
+	 * was visible have exited before we start calling NAPI poll.
+	 * NAPI skips locking if dev->npinfo is NULL.
+	 */
+	synchronize_rcu();
+
 	return 0;
 
 flush:
-- 
2.39.5





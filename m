Return-Path: <stable+bounces-59463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96054932900
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76DD1C22D6C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFF71AA353;
	Tue, 16 Jul 2024 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pA+k9Fj8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446E1AA34D;
	Tue, 16 Jul 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140124; cv=none; b=OqMXoRam44Uhj5k4qwQbJLrRHJyDh66U0mMnTMSqzQvyFqR40kX7lbtYCFgG+4l/6O6aLvQG35ZlpdaSCpDEnOZR0+HQU/hoytS/QAaTm+o6gGXXDK3rtCFMJYkTdiBUpT9CS9tdpNc76/lzMgW41/eNAFXLSyWiH+HacptB+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140124; c=relaxed/simple;
	bh=iIFPtRAdeRy9UJ0sJcPyGR8mF1Vg9bj/x0X3T0Eq1PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrTZlO6dlDpg+ET7Xj6ty7mUAQ7Xbetm3NcX01mapxCLL2vKVu4TslhVseFAw77MtjxkomLVFG6h7SAUoLg4iX92fILJGo7IHLfPbOHtqk0DUt58D4LPcrnKBMv64zYClXhdCP68Bj4SFqaXi6vs7OcUspweeyQo+jVKU3zp0OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pA+k9Fj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71259C116B1;
	Tue, 16 Jul 2024 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140123;
	bh=iIFPtRAdeRy9UJ0sJcPyGR8mF1Vg9bj/x0X3T0Eq1PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pA+k9Fj8mvLDMPhqzy3L13jQx/D0tkz9tBxzkmZq5TiA6JWxIMqOkZBBW3kroiE6s
	 B1Z8H9pmRUjxn5CQAIXWdAps1HVO0p/ptiYJw599ldkzrMU7kT0Rit4Du+yr55KDzp
	 M2Anq8S2Q42y+0ftVM/ErqXSbPkNfU+0UlNUPNTT35kC+zYt5Jykjb+Hu2oPod7UbI
	 UZaw7nNZksdOin9+L71VfqdZIoFWoyr+1PHhC8H7ZT2tvqFKvxjuz8ghZ+P0e0tnD6
	 +98wmrVPO92YvA42SVsmYK7Hl1T10qlEvE+K4T76pAXsoMkODyjVM7n9wYYiYOXZ2X
	 dHThw7+fC1PWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/15] bluetooth/l2cap: sync sock recv cb and release
Date: Tue, 16 Jul 2024 10:28:04 -0400
Message-ID: <20240716142825.2713416-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142825.2713416-1-sashal@kernel.org>
References: <20240716142825.2713416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.99
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 89e856e124f9ae548572c56b1b70c2255705f8fe ]

The problem occurs between the system call to close the sock and hci_rx_work,
where the former releases the sock and the latter accesses it without lock protection.

           CPU0                       CPU1
           ----                       ----
           sock_close                 hci_rx_work
	   l2cap_sock_release         hci_acldata_packet
	   l2cap_sock_kill            l2cap_recv_frame
	   sk_free                    l2cap_conless_channel
	                              l2cap_sock_recv_cb

If hci_rx_work processes the data that needs to be received before the sock is
closed, then everything is normal; Otherwise, the work thread may access the
released sock when receiving data.

Add a chan mutex in the rx callback of the sock to achieve synchronization between
the sock release and recv cb.

Sock is dead, so set chan data to NULL, avoid others use invalid sock pointer.

Reported-and-tested-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_sock.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index af6d4e3b8c065..b9e87c6bea235 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1273,6 +1273,10 @@ static void l2cap_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
+	/* Sock is dead, so set chan data to NULL, avoid other task use invalid
+	 * sock pointer.
+	 */
+	l2cap_pi(sk)->chan->data = NULL;
 	/* Kill poor orphan */
 
 	l2cap_chan_put(l2cap_pi(sk)->chan);
@@ -1515,12 +1519,25 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct sock *sk = chan->data;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sock *sk;
+	struct l2cap_pinfo *pi;
 	int err;
 
-	lock_sock(sk);
+	/* To avoid race with sock_release, a chan lock needs to be added here
+	 * to synchronize the sock.
+	 */
+	l2cap_chan_hold(chan);
+	l2cap_chan_lock(chan);
+	sk = chan->data;
 
+	if (!sk) {
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
+		return -ENXIO;
+	}
+
+	pi = l2cap_pi(sk);
+	lock_sock(sk);
 	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
 		goto done;
@@ -1569,6 +1586,8 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 done:
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 	return err;
 }
-- 
2.43.0



Return-Path: <stable+bounces-59425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D6F932875
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7881F237AE
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48FE1A01C8;
	Tue, 16 Jul 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHj4BRsM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7E41A01BF;
	Tue, 16 Jul 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139942; cv=none; b=IdmoHgrtGJbuQL74bb/5hsl50Y228Zm8ko3JKoS2aThAUisabSpe5i8TeZdLdj4FoLgOvCK2CSAHDnmsYIQERpzw4AcSrC8gsXvK5x3WizXdvbMHL/21kTmuWuQ4HsL0p12iqn4mFh57X9eicCx8x5dJGOtky/WHARiTQWSAOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139942; c=relaxed/simple;
	bh=blrVXDEK7quFM1ljWZZCF+v5P3B1qo7c70vCTCo6/y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9ZKSstPWD48JB6pbcmma1gRxpXHZEVreYiVfVMxKEmuaTbmRQ8oymXj0J7HqY1oh2gXNF5k3teEjK2NqopgevylDY8+dbjMUKWh44mwUEEjd6Tgu3HzaQw5hkBm/ghoONq5y0NSPhyYwuzGxhTk9DoB36ofK2ysSXpanuryV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHj4BRsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6831CC4AF0D;
	Tue, 16 Jul 2024 14:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721139942;
	bh=blrVXDEK7quFM1ljWZZCF+v5P3B1qo7c70vCTCo6/y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHj4BRsMK3L5ORGnYyzNiBUST01ueo2qjeIeT4g6ZkWqAcmLy2JDNpgRf8WBrhf8d
	 /HjwRXUXqxnW4aYBCNB2k+LlosytZMdULfc46Sju7N7t2Nik+iOIKZXOygK6NseBdZ
	 qy4suq8ndsqM9ESN9eco3RzkOPvACl7NpuGwVCeBsAZPN2Ifwdk/TPLs25lBWJbp7B
	 T1+d9Ic9FbEx5O50iNYvdY314SL983sn1nqueKv6qYrA3B+NptfblK0q3y5ATMfQKn
	 k1A0WBg7T/o+MZAZZVQwOhCdyGcYe6kaw5anwHRs9avTpx+yI1ufbHZvqLojvjDUPP
	 qjYvVPoZ6p6JQ==
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
Subject: [PATCH AUTOSEL 6.9 09/22] bluetooth/l2cap: sync sock recv cb and release
Date: Tue, 16 Jul 2024 10:24:16 -0400
Message-ID: <20240716142519.2712487-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142519.2712487-1-sashal@kernel.org>
References: <20240716142519.2712487-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
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
index 8645461d45e81..64827e553d638 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1239,6 +1239,10 @@ static void l2cap_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
+	/* Sock is dead, so set chan data to NULL, avoid other task use invalid
+	 * sock pointer.
+	 */
+	l2cap_pi(sk)->chan->data = NULL;
 	/* Kill poor orphan */
 
 	l2cap_chan_put(l2cap_pi(sk)->chan);
@@ -1481,12 +1485,25 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
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
@@ -1535,6 +1552,8 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 done:
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 	return err;
 }
-- 
2.43.0



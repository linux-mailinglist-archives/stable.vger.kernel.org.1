Return-Path: <stable+bounces-23701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0344A86768F
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 14:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554D2B2276F
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 13:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F39128818;
	Mon, 26 Feb 2024 13:29:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0960604BF
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954142; cv=none; b=T6GcQOYC+b/QRxMbWT6A9EGw1+jqNP8F6Q8yQYTVUIe/t/8b1tuiRYACcMp+1BFAZm6yNxp8HMXxZlprQjyJxG56DWDtiXMR/YiegaqdhyIbYlFgEhwEUnk7UFLSkgfcaiGRfte3lNP1OMy2Nv7q7SqFmmyWOR1xzUsezgxDLMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954142; c=relaxed/simple;
	bh=5n1l5WoCSd2bLkuYv/Qn4nnSPPPcHCIRqEJp8WUow2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KtyO1/YMuENKirJkMREJ0qc69RR6okpuZGRZOQfA3YIwagGFtD6KvHtJddo1lFZ9Ewg3lN3LmltFn2jcu9EzJ0j/+Io6dS0xCYt8U2pYNR/ABbi/Ooo6JQOvwbiIxITuspSfrnQQ9aCYDfoMmj+qkBCRV5jCThCkoGNFuDnEEcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 1BED22F20254; Mon, 26 Feb 2024 13:28:58 +0000 (UTC)
X-Spam-Level: 
Received: from taut9powder.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 0106C2F2024D;
	Mon, 26 Feb 2024 13:28:54 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: oficerovas@altlinux.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	kovalev@altlinux.org,
	nickel@altlinux.org,
	dutyrok@altlinux.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: SCO: fix sco_conn related locking and validity issues
Date: Mon, 26 Feb 2024 16:28:37 +0300
Message-Id: <20240226132837.8404-3-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240226132837.8404-1-oficerovas@altlinux.org>
References: <20240226132837.8404-1-oficerovas@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pauli Virtanen <pav@iki.fi>

commit 3dcaa192ac21 ("Bluetooth: SCO: fix sco_conn related locking and validity issues")

Operations that check/update sk_state and access conn should hold
lock_sock, otherwise they can race.

The order of taking locks is hci_dev_lock > lock_sock > sco_conn_lock,
which is how it is in connect/disconnect_cfm -> sco_conn_del ->
sco_chan_del.

Fix locking in sco_connect to take lock_sock around updating sk_state
and conn.

sco_conn_del must not occur during sco_connect, as it frees the
sco_conn. Hold hdev->lock longer to prevent that.

sco_conn_add shall return sco_conn with valid hcon. Make it so also when
reusing an old SCO connection waiting for disconnect timeout (see
__sco_sock_close where conn->hcon is set to NULL).

This should not reintroduce the issue fixed in the earlier
commit 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking
dependency on sco_connect_cfm"), the relevant fix of releasing lock_sock
in sco_sock_connect before acquiring hdev->lock is retained.

These changes mirror similar fixes earlier in ISO sockets.

Fixes: 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
Cc: stable@vger.kernel.org
---
 net/bluetooth/sco.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 0e1f5dde7bfec..99b149261949a 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -126,8 +126,11 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 	struct hci_dev *hdev = hcon->hdev;
 	struct sco_conn *conn = hcon->sco_data;
 
-	if (conn)
+	if (conn) {
+		if (!conn->hcon)
+			conn->hcon = hcon;
 		return conn;
+	}
 
 	conn = kzalloc(sizeof(struct sco_conn), GFP_KERNEL);
 	if (!conn)
@@ -268,21 +271,21 @@ static int sco_connect(struct sock *sk)
 		goto unlock;
 	}
 
-	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	conn = sco_conn_add(hcon);
 	if (!conn) {
 		hci_conn_drop(hcon);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto unlock;
 	}
 
-	err = sco_chan_add(conn, sk, NULL);
-	if (err)
-		return err;
-
 	lock_sock(sk);
 
+	err = sco_chan_add(conn, sk, NULL);
+	if (err) {
+		release_sock(sk);
+		goto unlock;
+	}
+
 	/* Update source addr of the socket */
 	bacpy(&sco_pi(sk)->src, &hcon->src);
 
@@ -296,8 +299,6 @@ static int sco_connect(struct sock *sk)
 
 	release_sock(sk);
 
-	return err;
-
 unlock:
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
-- 
2.42.1



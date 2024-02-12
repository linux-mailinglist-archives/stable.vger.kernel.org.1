Return-Path: <stable+bounces-19470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7666685142C
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 14:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AA41F21F8B
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 13:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B503B3A8C6;
	Mon, 12 Feb 2024 13:10:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31AA3A1CB;
	Mon, 12 Feb 2024 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743421; cv=none; b=FaNCrJ4/PHyvTO4jYooh/W/38fbdRb6XaRePFb0mDbg5qFBcd3ASUU4c0qzJOW0ldmwTvJkhxPEldo9jZ5LyTa8K7VV3a/xCSx5fjkfOdBZHkxVXEpobohmrdFI8YYkKSHTYmp0+fUd9Awqq0ROHkOPv/+NZtWfmJB0wfp6ef0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743421; c=relaxed/simple;
	bh=DnGC0CwNjZhsWkEnYbpja1u3lY2fDdY275sfxdNKvrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHgYYtdZkRgIwZX01KEN2tY6mv6NfepF/4bGiZAS0KYxrNwZLynos/UeoDG4gBKNFOEoSQhyyDx3uH1UNFmoKb33g3czdEFf1vUj/3gsIdNPe83nPujJJtCy3PLi6F68o0RUWwBdEw+e/9B22BSxg+hD2uy14JJnSoOXICRrEfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 191522F2023F; Mon, 12 Feb 2024 13:10:11 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id 50A862F20241;
	Mon, 12 Feb 2024 13:10:03 +0000 (UTC)
From: oficerovas@altlinux.org
To: oficerovas@altlinux.org,
	stable@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	kovalev@altlinux.org,
	nickel@altlinux.org,
	dutyrok@altlinux.org
Subject: [PATCH 2/2] Bluetooth: SCO: fix sco_conn related locking and validity issues
Date: Mon, 12 Feb 2024 16:09:33 +0300
Message-ID: <20240212130933.3856081-3-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240212130933.3856081-1-oficerovas@altlinux.org>
References: <20240212130933.3856081-1-oficerovas@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Ofitserov <oficerovas@altlinux.org>

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



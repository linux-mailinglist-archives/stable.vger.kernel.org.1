Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FADC76123F
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjGYLA2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjGYLAM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:00:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987144214
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:57:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DBB261680
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F765C433C8;
        Tue, 25 Jul 2023 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282647;
        bh=LNTUQo6jXyGJ8KvlpAvR+Nm3VauaFYg2n12xssM6Eqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dU0yAW06nhKsL0jB/p7tMn8KQ1TLfnX+g5LXJDnyU/SqdQGZQrijUJyAT0Vn5xX3S
         UWb2aWbbzu7sDhACWfcukD0vAIgaVCzEQJRVr8XF2BD68pD99U79wNEYyIBqORzRQo
         oYujMDDQjcc3M+wPGVBu90ei2rYvprh58FBr35wQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pauli Virtanen <pav@iki.fi>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 205/227] Bluetooth: SCO: fix sco_conn related locking and validity issues
Date:   Tue, 25 Jul 2023 12:46:12 +0200
Message-ID: <20230725104523.249596124@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit 3dcaa192ac2159193bc6ab57bc5369dcb84edd8e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/sco.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index cd1a27ac555d0..7762604ddfc05 100644
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
2.39.2




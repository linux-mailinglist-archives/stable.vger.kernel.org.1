Return-Path: <stable+bounces-245238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AzfGC7qAWpHmQEAu9opvQ
	(envelope-from <stable+bounces-245238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:39:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ED251055F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA32B3083CAC
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23FF3FE37C;
	Mon, 11 May 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgyXpWtA"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8BA3FE37B
	for <stable@vger.kernel.org>; Mon, 11 May 2026 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510070; cv=none; b=Zdckc0lkZvD8oNNXlTmv+ch0NK3272HZa2MQCF79jxNWQFM7A+Tp3Vfqvghid5c9hZVcdtckbyPDc+Gw+kjSWrX/Fswi+4t1saHzBHuvflHgvOWdFdLYN3YzNw5ndqdWKCxzQzSaz0u/EEpFhi+lf9Y/LxauJCVPbcZcGn0WiGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510070; c=relaxed/simple;
	bh=YfQBPQevPYy6KNEQoGGylmuoML0doP9gf/WL6NN7rD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jghzuKWrGM+u+yW2I7JOb6vKaT2LW3ijPWrb0J1tq0/u04xt7OCV9e31vm93gtxosQ3LfNQAMsrUVMKPSLVZzZEmDe6iK0G1T4UqJt3SFSHJcrAZy75eoqH5Aeajm4L4hv8Tux5OHpmneqvk+pGyUkeTFU/XQbimxZifQz/0GEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgyXpWtA; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d876329bbso41799341cf.2
        for <stable@vger.kernel.org>; Mon, 11 May 2026 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510067; x=1779114867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9wLQan2nN7eJ+L05d+IVGFJIfDrs/6xj1WgA6VgIXY=;
        b=mgyXpWtAZItRMUrplVrjLGFLAbdt1IiVgETfNpAp5ZYavJAZfJD4rlQhtgAT/7fU6w
         LgENAPsX1AEXjTGRN+jG5D/nbxPIjQZhgyy+KnakR98ik5JUziBhLllmvaZXEqc7D/bq
         e8lGfsP632l3lNguCtwroEqWkCeEp58xNWzYZ+ADAbI9A1yuCmsBe74JiR5NNoH9PByk
         OuhGZNQNpqiuK308yDBNUNYWcNhC6Kl1QZo7+unHQw+h0AxaNx+EOB+58MfoeplWdZM8
         cswM4kCaQsigdj56XE4eYFPeM6SbhzfEh7WxY1usNUEJI2Z+G3GhJeqsrmquuEW+oPaQ
         N1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510067; x=1779114867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H9wLQan2nN7eJ+L05d+IVGFJIfDrs/6xj1WgA6VgIXY=;
        b=XEEr41qDbA5bB0vKSlnaAuCilZb7Y9r/HSKt/KaKxjrFI/wsVnwAPOZgC9+WtqdnfG
         4050wUKZM5Cp05QaIZ2YP8UQuPpIF5/zVs8bZ6vm1hL479bUGp3DM4Hd2uco6D1WtK07
         c0lN/FmN93ComBuK7/rgli1AKar1/URxdEIolDSGusprIUJ5QAdY48qLkijjsdnlkF6x
         MIB2y2JMxxQRGPE9YE5J/i4bsJAS7QHckAZloaFXXnMQatZ+sqEQ8yr579vhiF4J+kAk
         pJ/x1UAmXO0aZDBC9MYIpDNr/zjrYXxr3+uR05Nb9iDeAYwPmK5OtggBZPJ2wHgitV2t
         emYA==
X-Forwarded-Encrypted: i=1; AFNElJ9qpUMPYp/o0ZwtSYYlPiS9jiY2VGaG3/fKOm+mm2M71SHffg0byYaRtl7zgqsrLu7QtdeXJFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsumOph4ZWa7rp2OeX2UDag2pfVfym+tyqbUMzmQdtbYIdlW6g
	GTcOyyBgyErEHuFveEKflz1VCLNL/9uf9+dAmVMNfJFAktNWcXWsb7Tp
X-Gm-Gg: Acq92OESKKw9PPDWpyIvZBE8pFMOE/uxCGC+RIbEduptNPnSfpZ9WE/7/qgn9n0prxi
	p0rT3CoIa01dAH//pYWtWtipmpRgghYAPOSVUOeOp38stnZb99JlmiBAyoBgrQIApxBBJ+N7MlY
	s1X9e51HQEcgKtp7dyzmeZbDepbM7DyOxMbqNTDVWmG4kG8i7eVcJUo6LftZb8cE0E6PvBrFur7
	vppl8vOvABkmHGymwokrIjt841LZnvTghEvID7fg4Z2aOiniIWqlwn28b7/VLKcP/wt/565ElAy
	yqJ3wTxGMRvT2qObhNwxFeBCsSzBiMVrgSC/bIhWZTXtBQqbC1zIxssx0kf3041fIxEEbKY8wAB
	YL8LV0Zq6Y11fYODkyFxqefCZ/gpoov7MIxsOrjlt9k/7Dw5NPv0iXVprAqS9XSRdjSguqWbi23
	vpmhnZvJl8Yp8gPReTD+7Ua05FArHKvzQjhPD9LeHHmHwkaFeBkBP8Wl5P0FfnHvHS0s2ikRpcS
	r0QeWkslMhhzUaeAhY2Wam6WVNmgBt6sAhdl/qOpGiiA6I5IFmv2A==
X-Received: by 2002:a05:622a:48:b0:50e:a1aa:2cd9 with SMTP id d75a77b69052e-51461c04ebbmr342766301cf.15.1778510066287;
        Mon, 11 May 2026 07:34:26 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83aa2bsm90605371cf.28.2026.05.11.07.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:34:25 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mat Martineau <martineau@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>,
	Aaron Esau <git@aaronesau.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH 1/4] Bluetooth: hci_sync: pin conn across hci_le_create_conn_sync
Date: Mon, 11 May 2026 10:34:01 -0400
Message-ID: <490e228dd02983fb1530fb114d4174148f810261.1778506829.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778506829.git.michael.bommarito@gmail.com>
References: <cover.1778506829.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00ED251055F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-245238-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iki.fi,aaronesau.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.923];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

hci_le_create_conn_sync() runs from the cmd_sync workqueue with a
struct hci_conn pointer it interprets out of the work item's void
*data argument. The hci_conn_valid() check at function entry is a
TOCTOU: nothing prevents hci_disconn_complete_evt() (executing on
hdev->workqueue rx_work) from running between the
hci_conn_hash_lookup walk in hci_conn_valid() and the body's first
deref. hci_disconn_complete_evt() -> hci_conn_del() -> hci_conn_cleanup()
unregisters the device and drops the final kref, which kfrees the
hci_conn slot. The cmd_sync callback then writes through the freed
pointer (clear_bit on conn->flags, conn->state, the four
le_conn_*_interval fields).

A KASAN slab-use-after-free splat in cache kmalloc-8k confirms the
bug on linux-next tip commit bee6ea30c487 ("Add linux-next specific
files for 20260421") under UML+KASAN, matching the slab geometry of
the syzbot trace fixed in commit 035c25007c9e ("Bluetooth: hci_sync:
Fix UAF in le_read_features_complete").

Follow the reference-pinning pattern from commit 035c25007c9e
("Bluetooth: hci_sync: Fix UAF in le_read_features_complete") and
commit 0beddb0c380b ("Bluetooth: hci_conn: fix potential UAF in
create_big_sync"): the queue site takes a reference via
hci_conn_get() so the slot is not freed between
hci_disconn_complete_evt() retiring the conn and the cmd_sync
callback / completion handler returning. The completion handler
drops the reference on every exit path, including the -ECANCELED
short-circuit.

Introduce a static helper hci_cmd_sync_queue_conn_once() so the
get/put pair is not open-coded at every queue site. See the
helper's kerneldoc for the -EEXIST contract.

The hci_conn_valid() check in the callback body is retained: a
logically-deleted-but-still-referenced conn has stale
hdev->conn_hash.list state, and continuing to drive a connection
attempt on it would be a logic bug even though the memory is safe.

Pauli Virtanen posted a series-wide variant of this fix as
https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/
(PATCH v2 8/8, 2025-11-02). KASAN reproducer captured under
UML+KASAN (linux-next tip bee6ea30c487).

Fixes: 881559af5f5c ("Bluetooth: hci_sync: Attempt to dequeue connection attempt")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/bluetooth/hci_sync.c | 41 ++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512..b20e07474257 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -786,6 +786,31 @@ int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 }
 EXPORT_SYMBOL(hci_cmd_sync_queue_once);
 
+/* Queue an HCI command entry once, pinning a hci_conn for the duration.
+ *
+ * On success, the cmd_sync queue owns one hci_conn_get() reference;
+ * the supplied destroy callback must hci_conn_put() to balance.
+ *
+ * On any failure return (including -EEXIST, where
+ * hci_cmd_sync_queue_once() neither invokes destroy nor consumes the
+ * data pointer because an existing entry already owns the slot), the
+ * helper releases the reference before returning, so callers do not
+ * need to discriminate failure codes to keep the refcount balanced.
+ */
+static int hci_cmd_sync_queue_conn_once(struct hci_dev *hdev,
+					hci_cmd_sync_work_func_t func,
+					struct hci_conn *conn,
+					hci_cmd_sync_work_destroy_t destroy)
+{
+	int err;
+
+	err = hci_cmd_sync_queue_once(hdev, func, hci_conn_get(conn), destroy);
+	if (err)
+		hci_conn_put(conn);
+
+	return err;
+}
+
 /* Run HCI command:
  *
  * - hdev must be running
@@ -6982,36 +7007,38 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
 
 	hci_dev_lock(hdev);
 
 	if (!hci_conn_valid(hdev, conn))
-		goto done;
+		goto unlock;
 
 	if (!err) {
 		hci_connect_le_scan_cleanup(conn, 0x00);
-		goto done;
+		goto unlock;
 	}
 
 	/* Check if connection is still pending */
 	if (conn != hci_lookup_le_connect(hdev))
-		goto done;
+		goto unlock;
 
 	/* Flush to make sure we send create conn cancel command if needed */
 	flush_delayed_work(&conn->le_conn_timeout);
 	hci_conn_failed(conn, bt_status(err));
 
-done:
+unlock:
 	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_create_conn_sync, conn,
-				      create_le_conn_complete);
+	err = hci_cmd_sync_queue_conn_once(hdev, hci_le_create_conn_sync, conn,
+					   create_le_conn_complete);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.53.0



Return-Path: <stable+bounces-245241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HMGIXPqAWpamQEAu9opvQ
	(envelope-from <stable+bounces-245241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:40:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F935105F7
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12F133093912
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731E83FF8B1;
	Mon, 11 May 2026 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxmlJzf0"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE163F0761
	for <stable@vger.kernel.org>; Mon, 11 May 2026 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510073; cv=none; b=NrYxg7rlTzAisBCBFtMIdbxU3Zdy0MMSo2uKg7kLwrNvlYsgguJLdQcovy+auNMoDW0Q/h8bP8JE3o2tWZdsbppYLrGkVACpHoQiArJkhUpYbs6Ax9NphR0wL1CV3oGUkS+GGTVLVavdK/kv9C/AYhhg0J0jcPlKrnHfNYCICWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510073; c=relaxed/simple;
	bh=e2R8DBscIk19IhJxMXZPQpQwLfnAMEQ7rmfH0FSfdQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQrNAWnl2jfopSPxia/VqVEArb8cfEpKPWNMkbiF2o6AGniiPzQP0t2XJrJ1f/G9ckRZyIqbja5anzWd2t4UqM9TR/7hDB8UkWkCGaQGJR1WmbPvq2gofCLPrbSxwEjZtyUrUEksjs9rkC0Rk7MKY2lJBXcbtrL/SiQNi8WKfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxmlJzf0; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e63771d91so45287381cf.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510069; x=1779114869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCibvydRPttcdEiskE4PpFNMkbJQi5uTd3rinfvp+sU=;
        b=oxmlJzf0xewfTMPsqupr+ly44IVcQ+TzJLytQe5KFk2ER+2d7xrGPmI7DKSd/Rqm9c
         +gK+2SU7HdXIQSmBGELR8T66XJvoyL9DYA0rQXvpMlLGb/+Zf69BeQNTLofSMPXhs+3s
         ulCJCJN7kPc3hQxcJE/eOLY/swQsyaJxt+wPmFYLFTvx/dZF3c7dkvmC8r648OSJuCtq
         Kl4U7Mga9XKEUCFhEynyWoqCX4+j5mxIATj2mCaVRW9XggTL2DpcwBOD1eh9A9aBEME8
         tn/RtMzizgaWbj4JM7UgRECUTTbGdRk6tRiZcU7rGAiWPuGxkzxlw1T2DqdY9OoRtHEx
         ZW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510069; x=1779114869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCibvydRPttcdEiskE4PpFNMkbJQi5uTd3rinfvp+sU=;
        b=Z9GPLLwUlTqsD5RzcGuL2PqoJAMQrpY6ICYBc3FYVwzdmS/QRio4nFyUB7l7O6X92e
         sXXx/xVlKW/u64Fogwc4cpzC/jtX3QuVvoFKPKbaSDdFQJVD1MP9X631pGGoRbyhuwCp
         laQfWJHjyJ/SFtGkcqQmSE1AxlZD6A3PPk0px60vG4FrmSADnggl7hica69jLlZaMiLm
         kLpC10gHH0kFPk+wLjVFwy91GlFw3vDC2EKuPuZBjwx3hF59mkPOGbEJRrha2dgYhrus
         7C5QNKg+0Hd7bVpx7Wfb7ltdrV9h8A++ffcpgEBCIvnf3cRye7UbMQtMrFpXIObimHvQ
         vN+g==
X-Forwarded-Encrypted: i=1; AFNElJ+HZ6+zFarAjFrSw/ntKvB150dhCxNXpNkkjwup17Wh85DwPEu1M7ZFFm8d1ZvMUYaSltmIv5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPY5GRjVqGwGBcUT9KJ5+cJ6fQx8FL/zBBrlmt0eNxaFfLbOox
	Cdnd+UbAO51ol2FYTf9vViRWbjDuR9mhnGdZh0i+/PFr7rLsDrB4HuZd
X-Gm-Gg: Acq92OFsSwjIs3dh4lTnZky9D6hiF4igg7s0wzSufQCo5q/RpTPQoslNCqCKcql/zKL
	yQLLoyKR9j+qL5E+eGP4JTvKEFrkDDHCP0fe0iNB5blMtv2OdFX4DSelEwx+6K3T3e6FQBgeUwG
	OPSjTAQ/OYR5wUt+hxFqncljqzvHyfuDk+tokCzN7UHKMDd/MNoC6jKVpVGy9vB3svoaRkdtnLA
	bwVt4bfzwaSyvsfZr/wXn5j60/zridiPpqii9FV2wshBbP7kwCE8WfOGy5Jajfgmgelk/ZbT0Lm
	0uSRq7hkDgYoBal5CXW8vZpcpdWNTgdYb+CgocHvg0ocud7jXgWTGKHn2k6MzGDyetGQWtsahpG
	9byCtd/fUez+8EIVHZfmmJuUygnglpots/HcCcZAmHmHfa9FCMlvH9/s8KOarTZtVWadRWgDNF1
	h+/j+Urax4ekdWGsr7xWZ8u+Ku/trlDQvlHEM0lBUEmY9WNvMriExP6dH9UvBwQavdWrdd4tWxO
	LiNvKv72Hp+nvhG9IS8m/xzlMDHY3GxEsExeI9L6FyGaYIpXlAnzA==
X-Received: by 2002:ac8:5783:0:b0:50e:6054:b4 with SMTP id d75a77b69052e-514a0a2a3b1mr143979381cf.7.1778510069079;
        Mon, 11 May 2026 07:34:29 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83aa2bsm90605371cf.28.2026.05.11.07.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:34:28 -0700 (PDT)
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
Subject: [PATCH 3/4] Bluetooth: hci_sync: pin conn across hci_le_big_create_sync
Date: Mon, 11 May 2026 10:34:03 -0400
Message-ID: <745aa080da109c4a698a3f1478b3f08e53f2d4d8.1778506829.git.michael.bommarito@gmail.com>
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
X-Rspamd-Queue-Id: 00F935105F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-245241-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.939];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

hci_le_big_create_sync() interprets its void *data argument as a
struct hci_conn pointer and dereferences conn->iso_qos,
conn->sync_handle, conn->num_bis, conn->bis, and conn->conn_timeout
after the entry hci_conn_valid() check. As with the sibling
cmd_sync callbacks, hci_disconn_complete_evt() can retire the conn
between the validity check and the body's first deref, and the
blocking wait for HCI_EVT_LE_BIG_SYNC_ESTABLISHED extends the
race window to seconds.

A KASAN slab-use-after-free splat in cache kmalloc-8k at conn->flags
(set_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags)) confirms the bug
on linux-next tip commit bee6ea30c487 ("Add linux-next specific
files for 20260421").

Convert hci_connect_big_sync() to the hci_cmd_sync_queue_conn_once()
helper and balance the conn pin in create_big_complete()'s
-ECANCELED short-circuit. Promote create_big_complete()'s
hci_conn_valid() + clear_bit() pair to run under hci_dev_lock so
that hci_disconn_complete_evt() cannot remove conn from
hdev->conn_hash.list between the check and the write.

Prior art: Pauli Virtanen's PATCH v2 8/8 at
https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/.

Fixes: 024421cf3992 ("Bluetooth: hci_conn: Fix not setting timeout for BIG Create Sync")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/bluetooth/hci_sync.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 43779375209b..47ce9ba63fe2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7265,10 +7265,16 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
+
+	hci_dev_lock(hdev);
 
 	if (hci_conn_valid(hdev, conn))
 		clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+
+	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
@@ -7320,8 +7326,8 @@ int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
-				      create_big_complete);
+	err = hci_cmd_sync_queue_conn_once(hdev, hci_le_big_create_sync, conn,
+					   create_big_complete);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.53.0



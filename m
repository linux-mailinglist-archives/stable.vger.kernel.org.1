Return-Path: <stable+bounces-235853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ5gM8cA3GmFKwkAu9opvQ
	(envelope-from <stable+bounces-235853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 22:29:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4C83E5E2A
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 22:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA9F030131C9
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 20:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6090E37F8D2;
	Sun, 12 Apr 2026 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OocIG0p7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0737F012
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776025764; cv=none; b=i4bWRaXjeY0IUWJXr5ni+X49zwTH7cR3+rxhxZDqIurhwU1rD2buoCHhh3VKOFc0C5CTSE8GKhSkW+C7fTAeV5HikCGQWTgtWg0vdBZZaRwwoqN4wJ+mMe/VbqT3sjL2zA7AfBEH/DFljs7B1pmhSEeIvpAiXe6toJ4o+OEwtX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776025764; c=relaxed/simple;
	bh=3rqtvqqZTGtxKH38oOYjEvWW5C96W0zbTJWPHwN4xk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A33s1qksIHxi0kJL5gTPBLNPCqGTJFVFqmmHM6MGWmAHPpSvIMuzcuULgagsI8kYZ6v9rUWLXF9uR0pUr0OjytrNOLDxddNaYBRC8Tk88NtECyVZpKDpYg4J8nipStRcxrbriNZcg5vVFCgjI72iD33MkMjDC7l8ncDeOOUdA+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OocIG0p7; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d572f7437so2411793f8f.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776025760; x=1776630560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Id0UBUp6u8lf/UjsSjAE4ozbDe+gUA5wuiQY3ynuDI=;
        b=OocIG0p7aC5kRfRhxgeD3Vsh+UwI/7SPAYzgDpHG/r773+jDcRxzVj4R2r/lMEZLSi
         W6lyWeSuQOHQHVZIoYrN18O5LRk4uC1gJz/h18KMh42UBIH7wmISfUipKxSrV1RodkU5
         ONRqYN66YN7GzIUwGSiLzEW/M6MHn0SpSdYpCPkyLyZZKQMP6Nsnd/NTvqlV75LOMoV5
         K3vF41vtWneAIJakbaMT+G7gfds8m0BZbWE0uBTHilIEjCXbUdnLqknSUptz9QAM4mXa
         qhoJBlhF/eG/E4uAaVX9SND3SI5RnYOb93lpgsgZGKAMaEpjwC5hyG5FGWjkfjurdWK4
         FVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776025760; x=1776630560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Id0UBUp6u8lf/UjsSjAE4ozbDe+gUA5wuiQY3ynuDI=;
        b=Dp+IBTO+H39W87BWo/Ddu5rVVkmJDQDyHFRKBpQq4uQvAoX2tKCvvFgdJepF0ls/GH
         ukFnlb/5HOoAjTazGQFULD2IJI7RKm0GWr5xDiQ7gyUWRXI1/zfYkFcgddTW+H3y8GnU
         Kn2NaHlQYBE37+4/ledNSRN6oicdv8TOu3oZS0Cu0JgenN9MwAf/48f889iiuL2G+jGt
         UbVENl++BZ1kRgh30tM0D3pS6Pl9ebYelZqF5SBMSSNP95+Lhqu+N32VhGYrhZMWEcaW
         t3Hmjc9FYEZXnzjyBU7H7drQ0X8XkQIaA1uDkQ8tGQ9idKBgqn83zKkQ4Egri5ZmX5CC
         KSaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gGi4U6jL6bHgNIwVaFJuedLgMO5cyFBdQY0q1p63n41jOUunjLgCwFaN4Gn3sfgPE1yx7ctU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKoERpH32T0aP51CvbscXmbdvKQ9nmsAMYgY888B8JqcHa87fZ
	R56jWMFT7c17BSZ1pb8A68qfDFd1/oB+zLyU6fIet7hEcMknlAGxbldq
X-Gm-Gg: AeBDiesWKMvLTEzSSS4il5MHvsCa2JbVVZ75Tg0WWdAHgVQY+stduH8Yk6o3ApCCaAB
	WLlXe9URs7zUuJoRJxIhmtcBsPmrYbuk4K2x7MX94YAoJwR53NVFCEYzu8MH9kC5wlpVXi5snkX
	YMu2WeXmgITVtnnxIoa7Csl5wVB9ZPpw96aoMVmrsj81qtWrSyeZnXR/yEye0vWt+CxsE1MEQQT
	gJOxxK6HnJTKqKvIp68BErdSqnB+T1cYln8Kdmpqqgkq4sLw5zbCoDq+Rofqsdt0/9/6SOxE31I
	oqLcwk+x2yUzRGxi8lsFyBg9z3Oib5PNuQMQB4vwynoUkqcvMni+p3cMHTUrqtJW8bh6Rs6JaS2
	VHriVsbHEFiCIf90nu94Zs3hlrGryoW1d1mlJaAc88deVmSWfFyEXW9FnI2maj4ALne+yCG+lwx
	IgNJUCjp7/xlcwMYtTT/g9paZcaf4vWAO28ZsmayOQ1LR1cdU4Ww4KmNZCj1HPsmkhqV/2aarpt
	TCCj6vk9Fxg
X-Received: by 2002:a5d:5d10:0:b0:43d:1bf6:930 with SMTP id ffacd0b85a97d-43d642dd09bmr16220327f8f.47.1776025759377;
        Sun, 12 Apr 2026 13:29:19 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a69sm27240736f8f.4.2026.04.12.13.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 13:29:18 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH v4] Bluetooth: hci_conn: fix potential UAF in create_big_sync
Date: Sun, 12 Apr 2026 21:29:16 +0100
Message-ID: <20260412202916.196282-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	FREEMAIL_CC(0.00)[iki.fi,vger.kernel.org,gmail.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235853-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 5C4C83E5E2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add hci_conn_valid() check in create_big_sync() to detect stale
connections before proceeding with BIG creation. Handle the
resulting -ECANCELED in create_big_complete() and re-validate the
connection under hci_dev_lock() before dereferencing, matching the
pattern used by create_le_conn_complete() and create_pa_complete().

Keep the hci_conn object alive across the async boundary by taking
a reference via hci_conn_get() when queueing create_big_sync(), and
dropping it in the completion callback. The refcount and the lock
are complementary: the refcount keeps the object allocated, while
hci_dev_lock() serializes hci_conn_hash_del()'s list_del_rcu() on
hdev->conn_hash, as required by hci_conn_del().

hci_conn_put() is called outside hci_dev_unlock() so the final put
(which resolves to kfree() via bt_link_release) does not run under
hdev->lock, though the release path would be safe either way.

Without this, create_big_complete() would unconditionally
dereference the conn pointer on error, causing a use-after-free
via hci_connect_cfm() and hci_conn_del().

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Cc: stable@vger.kernel.org
Co-developed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---

v3 -> v4: combine v2's hci_dev_lock() wrapping in
  create_big_complete() with v3's refcount. hci_conn_del() now runs
  under hdev->lock as required by hci_conn_hash_del()'s
  list_del_rcu() on hdev->conn_hash (Pauli Virtanen review).
  hci_conn_put() is placed outside hci_dev_unlock() via a two-label
  unlock/done pattern so the final put (which resolves to kfree()
  via bt_link_release) does not nest under hdev->lock.
v2 -> v3 (Luiz): keep object alive across the async boundary via
  hci_conn_get() at the queue site and hci_conn_put() in the
  completion callback.
v1 -> v2: handle -ECANCELED and validate conn under hci_dev_lock()
  in create_big_complete().
v3: https://lore.kernel.org/r/20260410201343.229470-1-luiz.dentz@gmail.com
v1: https://lore.kernel.org/r/20260408155638.95927-1-devnexen@gmail.com
 net/bluetooth/hci_conn.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 11d3ad8d2551..9fa6901aae9f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2130,6 +2130,9 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 	u32 flags = 0;
 	int err;
 
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
 	if (qos->bcast.out.phys == BIT(1))
 		flags |= MGMT_ADV_FLAG_SEC_2M;
 
@@ -2204,11 +2207,24 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	if (err == -ECANCELED)
+		goto done;
+
+	hci_dev_lock(hdev);
+
+	if (!hci_conn_valid(hdev, conn))
+		goto unlock;
+
 	if (err) {
 		bt_dev_err(hdev, "Unable to create BIG: %d", err);
 		hci_connect_cfm(conn, err);
 		hci_conn_del(conn);
 	}
+
+unlock:
+	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
@@ -2336,10 +2352,11 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 BT_BOUND, &data);
 
 	/* Queue start periodic advertising and create BIG */
-	err = hci_cmd_sync_queue(hdev, create_big_sync, conn,
+	err = hci_cmd_sync_queue(hdev, create_big_sync, hci_conn_get(conn),
 				 create_big_complete);
 	if (err < 0) {
 		hci_conn_drop(conn);
+		hci_conn_put(conn);
 		return ERR_PTR(err);
 	}
 
-- 
2.53.0



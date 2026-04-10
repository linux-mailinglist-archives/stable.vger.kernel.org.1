Return-Path: <stable+bounces-235653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F49AOM02WmjnQgAu9opvQ
	(envelope-from <stable+bounces-235653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 19:35:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5973DB1B3
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 19:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11F073029628
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E073DB65F;
	Fri, 10 Apr 2026 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qlrp1ZP8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D708E3BE161
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842498; cv=none; b=Pb0pAd9L40qx4hGvwb4EpY93a4KZxuHgs9WJFf7m6yye+5FJgjD1abXgz9uuKRzc0Wbn0AL6WHwumB0uT1kJjsUKwbA7oh2Uz6QLJmcpxtPRZB/27zDCnaTvt2sb+meOc84TLTi1Of9WYoPhrOLCs+akqMjj+c8GvdcIcRenWnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842498; c=relaxed/simple;
	bh=DYw7oNNqEGz4ESlBhGL7OiIoItzBIY1f9AUIG+wjyw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b6rB86u0kp0PKN77ATLhNdwrBea2YTxdaYb+59mQ7C3QTutYSj8e7wCYPtJYgmkTar+/uHN7ROS7vCQLf/WZVAbhmjzPAnPXLSLHoby3MsQZYxjiCxEVYS27kIkaH4c9CPIWsH0wsFvJL6xFEbMnBuNINYrBXPb1wH7c5G2nhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qlrp1ZP8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4888375f735so22808725e9.3
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 10:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775842495; x=1776447295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/pLuXGk4XEx5958UjMrbFYUUsyqqJwTgYTzxJrMDu/k=;
        b=Qlrp1ZP87eQvFJUtSeKn0aBF76hRL/Wg6vLuntEvoQZ4IOpH5aFSSwxtEfzCyr/nFi
         /8aVSMunWwTOrwNDyDJ/PiNfnoN8uPRo2Qs+7z9qZm4/yFi08GuiMfUTyD0TzPGwufuv
         UIZVDUy9vftJkJlkKZsg0tUCnfu/AwdEaQXRS0gToUF/yXN2qAuhYOoMdbNzknz1kDtg
         Yy+DVd5KEX9g+HePRNRWrC2fmwN/dWiOqwL9+9j90d9/o4RJ2olSDJp88VWjubT1viOL
         RFgGiOus6uIbiTCEEdE+r9vXokIthR5+bdFPqFP2N9fioTedXfwO5eE/suthgfMW2tst
         s1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775842495; x=1776447295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pLuXGk4XEx5958UjMrbFYUUsyqqJwTgYTzxJrMDu/k=;
        b=C+PnCWQQTvqLYlhr4fWwN1JXpWb8T9Bcw+IVwknJoYznzZCVFq5FxRfqWUW6zNVxs2
         uyGHY61XYijSVvY++fhT7eii6rPxU5/51S36T2xeShtUHMUxtdwSz0YX/nzDWpQjDtLz
         WvizHSkf1hAaIlCIq/Wix0/ExxF2N5KAjNA+WAc5EOvcbeciL3/v0nghh6Q6hheK2jgM
         DcawbxPFKw8rvPRZ+/0m7DwtU0Lnykcwtc8A0jnw2Bu3ZNWQTtmdDtZTIYWMNYuQVQF1
         a8IGCZQEFXU/sIbhEEuaVwTERt2QjOx3GnhFDRua/5bviROZtBVurjrklkxfQUw1myGc
         64Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWudW/NwjKT37hPlFOQZLqRy3ekBX2hQqjNfbLH6xbl0P2Msd5ZYJ998XQh6CZzC3AcDvGCfIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxax7bafxRUuWKnAhcud1dY7MFXA942y5SYvFOq7gpfuLZSU4kL
	sfjj1ZdJsXJKhJ9dzhdiGVibRU9GLK33rdg7XwQXQhyBiR2WuC6i7/zq6MbAORhm5FA=
X-Gm-Gg: AeBDiesc4YmKIp31VxsKpCzuD7cY4supOVjbwvSKEMSUrBeBgc/KXpyU3NsAZD5PehV
	TVLyRLKVZs92j1TXsPNGRrFnAa/bHygD9/iTb64Acp2YEslK8QZ6K/LRpqPU6Wcs5Ty1EMUZ0IY
	wcIwpcMTBnMo50a1PoYcZ0mgJJG9AEccFoZQvd8c0cPl3fPkHzDqKmTGSu3G43JpHFvvdVs6C7O
	B6QXNewreR9hjwc7OnU8KI3fr0KaqNeAeb0VUaSDtq0RnzO7HLw6J65y2QoeOJ9cDrNnvQ4uNCS
	UUoX6htLnDLH0uMfkQqh4JAOK2lJ/4O8e+EaBfdaBbU6JJLCUFV2/mVOSvl0s2JeDJXsc8N4VoH
	zLHGozqJG7jrX6ee+l5dCENEV7yF05yWzGhtQTUXfmRh2AojXW02UQMgheDpJVghaeYf4JkHHPK
	fqjjC5E2MeJBGKnXjga6GtvQKt++bC2Gx6gyYMhkvj1SyDDOgHLkQu0XwS8MvlcvaBQ+t/zAgL1
	J9bXCZL+BhO
X-Received: by 2002:a05:600c:8709:b0:488:945a:ed63 with SMTP id 5b1f17b1804b1-488d6655adfmr58259555e9.0.1775842494835;
        Fri, 10 Apr 2026 10:34:54 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d531f229sm119327525e9.3.2026.04.10.10.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:34:54 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 net-next] Bluetooth: hci_conn: fix potential UAF in create_big_sync
Date: Fri, 10 Apr 2026 18:34:51 +0100
Message-ID: <20260410173451.4797-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235653-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E5973DB1B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add hci_conn_valid() check in create_big_sync() to detect stale
connections before proceeding with BIG creation. Fix
create_big_complete() to handle the resulting -ECANCELED error
and validate the connection under hci_dev_lock() before
dereferencing, following the established pattern used by
create_le_conn_complete() and create_pa_complete().

Without this, create_big_complete() would unconditionally
dereference the stale conn pointer on error, causing a
use-after-free via hci_connect_cfm() and hci_conn_del().

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---

v1 -> v2: fix create_big_complete() to handle -ECANCELED and
  validate conn under hci_dev_lock(), matching the pattern in
  create_le_conn_complete() and create_pa_complete().
v1: https://lore.kernel.org/r/20260408155638.95927-1-devnexen@gmail.com
 net/bluetooth/hci_conn.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 11d3ad8d2551..feebe933efc8 100644
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
 
@@ -2204,11 +2207,22 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	if (err == -ECANCELED)
+		return;
+
+	hci_dev_lock(hdev);
+
+	if (!hci_conn_valid(hdev, conn))
+		goto done;
+
 	if (err) {
 		bt_dev_err(hdev, "Unable to create BIG: %d", err);
 		hci_connect_cfm(conn, err);
 		hci_conn_del(conn);
 	}
+
+done:
+	hci_dev_unlock(hdev);
 }
 
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
-- 
2.53.0



Return-Path: <stable+bounces-254181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNeQFs53FGokNgcAu9opvQ
	(envelope-from <stable+bounces-254181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 18:24:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D45CCD58
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 18:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2011B3005594
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F7B3F20E7;
	Mon, 25 May 2026 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="YOM3YRRw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D77330662
	for <stable@vger.kernel.org>; Mon, 25 May 2026 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726283; cv=none; b=sR0Opg+3sMjlj3pNL/tmL9m0gmf4q8o2UAwYrppPQmENM3VC3Sy500vfSRM7HEo4rlZVYqZ9MtQaWuiv+MaDq76yUZoXrlvQRVMUHT93QmnXpG/e05jPhb9or73dyvaqFv6njqTK04M2boHDd2EShR72szr1iJYu2L5zuWUx2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726283; c=relaxed/simple;
	bh=S4rxq3l4Wng2W5fVWWjrnjFgVqgExMdH6guqhx0+R30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKFrcCr0wWquucPJnb7/SZQrPD/adaDcZQjjZe0h2F6BGsbkmBgl7EYX11e114fx25foi1Ymm9l9qQJW2wcKnIyjvQQ5cEjgu0UHlFU3E8up1OVswrwG05i3yl2lgkjr7KDleIUTXuMC3otEPiopvEB/tAB170Jp2HBn6G3kePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=YOM3YRRw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so5513641f8f.2
        for <stable@vger.kernel.org>; Mon, 25 May 2026 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1779726281; x=1780331081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CD2km52FcQoeNC6X1ictk/ljETOFDj0WJ4N8Yv++Si4=;
        b=YOM3YRRw9DJLeZTBVs9Wu0FgYvbwtMxipEm013QWxCZHdmUgRJTB7h6WvZqyOo90rl
         XtNcQNyyGFWMXVYK15c0dF+uyLIdrMeRX44H1WI8OJrtGxSYrCKn9EgcSZZK8nNhtr4Z
         bb1Eny9eSxmUPwf5Zpv6K7luGOvd+rA289W1Ky3YifwDmJl9ZsRib8v19DBYHfOBQdkC
         XNGqTvSmFQkkZmUsdSWQixxXYzRLZZBkPHRHXz+8lXMK6cYRyMY08rV8sfkRzm/evbrJ
         HYFjRIfSjzfJZdN9XUjrqGsKW6g4hRKerl+z9McYUfPGFoc3DAWFXrd+rZZaOzlpOHHN
         9fRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779726281; x=1780331081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD2km52FcQoeNC6X1ictk/ljETOFDj0WJ4N8Yv++Si4=;
        b=Tg+AZcAUd9L+/PUcQsz3AoEmPFvvHFsajLNKH4Nw1oETM9H41EbJ365CWLwf3F79aP
         yMT92qDfFUF8cD49P8/pMyGxJgr/qoO4qexyIy826KS5GWwxuYUcEcMq581hY9nrwdWe
         a98xus2tdDRkHHtBUAExHPkbgkk/YdqFonJSNDu7A8nH222gLUEM7wMfLqW1lYQRBPYS
         3hHIwXT4YtnEEVnAVpTX3ItCZR2WjQhsmjck2RjZKdV0xLngSqctF6UYVcLsPHk4uiV2
         q4NQ8D7n/T00xQM1+hDARIZNbT9WtY4SWDAOGbeotF1U5va8z646E/jBhY/zZk1okpss
         F6/A==
X-Forwarded-Encrypted: i=1; AFNElJ+FVSBcCtQ/7zYVAEpieTj08GSgHR/tXNKR6IhDkaOhnZmiBceFJIbU7M79WIlGb+1f/BjOlxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJFlU5UaoIy3XNOTCLT0ITLf1eYs52G7niQk5V0GHUJeHoR2V6
	Xo9ZO/U3ORHrceKtGzoMR/KbHPekBqmU/GdsAe+upZ6enWkz1nY/qZgaj8ROwhQEQL9M
X-Gm-Gg: Acq92OFDHYxrj8i3BHN1n9F+IS81WZe0sa65002BW+OE+Z6G2pp+OZFdPOiysoIkTmb
	up8agiWZHexfa2+R1SOMvE/z1Tomheu2ahxPTEtUEvpCyQIZMR1sr/6mKthglrT0n94/KYnQD2A
	LX4D66AiiOIMrrX5IERloFwkZ+MgXFsUjCJZrTgNRpjneBGXxf+9KGQSOv6FYvGtpq5JZtu+6Ph
	9hmD/Zyl4CpYiG5SlXUWXje3bVzJjMYp/5SBH8aVZygBT2DAis8URpUnd/Lqy31O2oxWPPBk2hN
	g4FcxfX67VaCy67QpCmHMqyPxgMY6u+KQ6F7BHqTX0Jj5ViayZBpKb30mITusGcLk1pjjR08OUw
	ZkS3r58Qb6PvtE3CiotaOFnZ/Rbg/xMXvag2C4RqldgTqEl8McbdTQYNW0OFCGc9x5WRYLIV9It
	tSTJOsPA1eEU68ycYbOucfsbTeKfPbbsnERTUHYdYSs8yYKwv9GEmqOfzpAor8cvvF3IEpFeZM9
	CC8hmFa9osYgPhhE9+ywJdi4X9fHIMerpI26XV91dAW/GD5UISjSTU=
X-Received: by 2002:a05:6000:468c:b0:43b:5b25:67f8 with SMTP id ffacd0b85a97d-45eb38b392bmr17953156f8f.20.1779726280391;
        Mon, 25 May 2026 09:24:40 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d6ebf0sm29201800f8f.34.2026.05.25.09.24.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 May 2026 09:24:39 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	security@kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync
Date: Mon, 25 May 2026 18:24:38 +0200
Message-ID: <20260525162438.96881-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[0sec.ai:s=google];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	TAGGED_FROM(0.00)[bounces-254181-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_SPAM(0.00)[0.129];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:-];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,0sec.ai:mid,0sec.ai:email]
X-Rspamd-Queue-Id: B33D45CCD58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hci_le_create_cis_sync() dereferences conn->conn_timeout after releasing
both rcu_read_lock() and hci_dev_lock(hdev).  The conn pointer was
obtained from an RCU-protected iteration over hdev->conn_hash.list and
is not valid once these locks are dropped.  A concurrent disconnect can
free the hci_conn between the unlock and the dereference, causing a
use-after-free read.

The cancellation mechanism in hci_conn_del() cannot prevent this because
hci_le_create_cis_pending() queues hci_create_cis_sync with data=NULL:

    hci_cmd_sync_queue(hdev, hci_create_cis_sync, NULL, NULL);

While hci_conn_del() dequeues with data=conn:

    hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);

Since NULL != conn, the lookup in _hci_cmd_sync_lookup_entry() never
matches, and the pending work item is not cancelled.

Fix this by saving conn->conn_timeout into a local variable while the
locks are still held, so the stale conn pointer is never dereferenced
after unlock.

This is the same class of bug as the one fixed by commit 035c25007c9e
("Bluetooth: hci_sync: Fix UAF on le_read_features_complete") which
addressed the identical pattern in a different function.

This vulnerability was identified using 0sec.ai, an open-source
automated security auditing platform (https://github.com/0sec-labs).

Fixes: c09b80be6ffc ("Bluetooth: hci_conn: Consolidate code for LE Create CIS")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/bluetooth/hci_sync.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index XXXXXXX..XXXXXXX 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6700,6 +6700,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 	DEFINE_FLEX(struct hci_cp_le_create_cis, cmd, cis, num_cis, 0x1f);
 	size_t aux_num_cis = 0;
 	struct hci_conn *conn;
+	u16 timeout = 0;
 	u8 cig = BT_ISO_QOS_CIG_UNSET;

 	/* The spec allows only one pending LE Create CIS command at a time. If
@@ -6773,6 +6774,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 		set_bit(HCI_CONN_CREATE_CIS, &conn->flags);
 		cis->acl_handle = cpu_to_le16(conn->parent->handle);
 		cis->cis_handle = cpu_to_le16(conn->handle);
+		timeout = conn->conn_timeout;
 		aux_num_cis++;

 		if (aux_num_cis >= cmd->num_cis)
@@ -6791,7 +6793,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CIS,
 					struct_size(cmd, cis, cmd->num_cis),
 					cmd, HCI_EVT_LE_CIS_ESTABLISHED,
-					conn->conn_timeout, NULL);
+					timeout, NULL);
 }

 int hci_le_remove_cig_sync(struct hci_dev *hdev, u8 handle)
--
2.45.0


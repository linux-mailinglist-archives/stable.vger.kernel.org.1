Return-Path: <stable+bounces-249412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGB1OqqrC2omLAUAu9opvQ
	(envelope-from <stable+bounces-249412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:15:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B13857573E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A8AB302AD3A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 00:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC301DE8AE;
	Tue, 19 May 2026 00:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOWjfrd5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE31B1C84AB
	for <stable@vger.kernel.org>; Tue, 19 May 2026 00:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149731; cv=none; b=ivDNsgcTqolPuMXaGDfALtfYJvzrXxwW66JptBQorrleBze68k72/EX0QD5sv5kJICdjMBAAcpfXpc1wZlLDSZOstZRxNr0rEEb4PChw6r99AuKueKlTONqXxpzd60eblQyTUtUcxhCwVTQQzJ0UXoDXVXf/awXfNzeXMlIppMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149731; c=relaxed/simple;
	bh=NyIbHuU6R+yIwoMZVJ9F9DKeztvTHmSN6ksFFbFDxXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqZidTopUnDEXMOuQVD+NS00XAz8l2nuXTOt/g2PULA7+2OY1FVpxSINgLfIJAPecsMxp/h4D/977zlA2dHMgcRoWcKYdO2lZj1euswlDqX2F6FgRvR/M2Krt6IVHWIMGWBa7taG8iHMGzRkG5tOCZATs7nYCjFCnx+nQCjuohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOWjfrd5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba17c8cfacso28203725ad.2
        for <stable@vger.kernel.org>; Mon, 18 May 2026 17:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779149729; x=1779754529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yDUdM1L7Kp6XBqCU+DT1wcZI0PaukiQ8/jCeHRabPc=;
        b=cOWjfrd5coSRbBYC6BfA2yGyiFZFSwMTAztAQkdDmUw7iBI96tNKEYSv2q4xWBUHqG
         Y0PMS9fn/f2y1VnwSF7u1LazYbyistiLlH8W7fSyQouJB2WaL1TXONQVLKg5F7xIHqqz
         oiGxeVgqA/oJ/OR82iDjB+Ryq8uTBgy0Zi0KW81Gkmd4zxfg8mc3mFGMuGVIlDq05mrw
         TYlumByt0DRBHTaLvcrWpqUl5P9N2yEFgOjq67RsYIX/HWxJIMZrdwFmBBT51/rHUxem
         7Jjo9OnEkF8dqCVvaoC9ZOVyp4xfnQBpCxC2OGbXgSzTaboGFkg7iA5dhztBXAfvAbSY
         xRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779149729; x=1779754529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yDUdM1L7Kp6XBqCU+DT1wcZI0PaukiQ8/jCeHRabPc=;
        b=rUt4zep67j0oDXsA4T5pKW5YdE7I9X270vC6Lo5xAs5R0x3MVgb/c4u5Le3XUox328
         UwecxIhZi6LaxHlfb3OTG8HwHQDhXtqL9/8bc7J9QadPK2a9mXywmWHNsLbIaPNDZuya
         JjCSRV9ZgW9mCNuVMWqj/GciFwhvsWJAgYb3SBIHYiMKbPK2qNE6Bhm23THEIhTK6qiK
         wVmi1yy46VBjm50qjT1oLTg1qWWE4f1qNUXBs2+YbZa9x8JK46yHfS09A0tPyOIQ4qHc
         vvZj4A/IWcGDN8XKXW6K5Bg+ir/8EaWVy5WjSHyQe8GptKlTbH6ThQpvE0rlDZhwNhEN
         m/UA==
X-Forwarded-Encrypted: i=1; AFNElJ9KBG8xzQznnXvHL5ID3YVQcouhDrOraDkPi1DvelwdUNTlyc5WWZbNAZEr/vufQjprpsVAIpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6TxjfKJ/vWzdPgBbu6h8TUhcS/W9yp9SneZwUMBsbjK4yM/b
	qv0ztRPbPyvDd7qPrz+fC+sdrkC81r//PV5e2jMeWbvraiJYjZc48tW7
X-Gm-Gg: Acq92OERMINDbCQHfcM2vP019t/f5sEIAWDvInzPmYPTtUeDj79VJlLnZBz6OcmSGv7
	ixEWgGa8rRZb5gYQ5jtkJUJnqnLeRi8N8iXv2/cTK6ad1w1l5DiQgjFaKOCHG3OeneVhhMImdhs
	ZYB0g1zzwC/aW1QYbgklEt+LWLXyiDk7Gc9hiZMMvK2fkJHFT6DvkjiUwiBE1/+LSJZvht51ZW2
	vG15P094rS0iwUrQ0Dd3kNotueNpPkiSZt1oi0xotqQmx9QE4E1ByGMbnx3W+MlKOmKTUS17hNi
	lXYjMcHBNJ45U2dHFuw/fbP5+cBByRFASXRFr2lJamQTD/KatcZldqOnrtxsqNC3IAoQyXeuDmd
	+5fqDWzefZmvUa8YMD813o7q9aFBo7ik+e/K/3k9drVd9VoikEsqq7YYkpY+HiZvJwV5E2pPLK9
	US+Gzul61UkQeq6kgeobchA41Dgp6jmhQt0tmiWJGIisRtOve6Yjl4jlgxxJFTk4tJz9YOzl3I2
	A==
X-Received: by 2002:a17:902:ce0b:b0:2bc:a577:70c2 with SMTP id d9443c01a7336-2bd7e931f22mr191320255ad.31.1779149729207;
        Mon, 18 May 2026 17:15:29 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f36fsm199132645ad.21.2026.05.18.17.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:15:28 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	pmenzel@molgen.mpg.de,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2] Bluetooth: SMP: add missing skb len check in smp_cmd_keypress_notify
Date: Mon, 18 May 2026 20:14:37 -0400
Message-ID: <20260519001437.156400-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517145417.31910-1-meatuni001@gmail.com>
References: <20260517145417.31910-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,molgen.mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249412-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5B13857573E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

smp_cmd_keypress_notify() accesses the received payload as
struct smp_cmd_keypress_notify without verifying that skb->len
contains enough data.

smp_sig_channel() removes the opcode byte before dispatching to
command handlers, so a SMP_CMD_KEYPRESS_NOTIFY packet without a
payload leaves skb->len equal to zero on entry to the handler,
causing a 1-byte out-of-bounds read from the heap.

Use skb_pull_data() to safely consume the payload; it performs
a bounds check internally and returns NULL when the packet is too
short.  Add a ratelimited warning in that path to aid debugging
of malformed packets, matching the pattern used by hci_event.c.

Fixes: 1408bb6efb04 ("Bluetooth: Add dummy handler for LE SC keypress notification")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/smp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 98f1da4f5..1b237e623 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2930,7 +2930,15 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 static int smp_cmd_keypress_notify(struct l2cap_conn *conn,
 				   struct sk_buff *skb)
 {
-	struct smp_cmd_keypress_notify *kp = (void *) skb->data;
+	struct smp_cmd_keypress_notify *kp;
+
+	kp = skb_pull_data(skb, sizeof(struct smp_cmd_keypress_notify));
+	if (!kp) {
+		bt_dev_warn_ratelimited(conn->hcon->hdev,
+					"Too small packet: skb->len %u < %zu",
+					skb->len, sizeof(struct smp_cmd_keypress_notify));
+		return SMP_INVALID_PARAMS;
+	}
 
 	bt_dev_dbg(conn->hcon->hdev, "value 0x%02x", kp->value);
 
-- 
2.54.0



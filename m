Return-Path: <stable+bounces-249155-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPWlHyNUCmrxzwQAu9opvQ
	(envelope-from <stable+bounces-249155-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 01:49:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D07AF5646CD
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 01:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12E8830221FF
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 23:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66D931F9AD;
	Sun, 17 May 2026 23:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbYGiYS8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B42263C9F
	for <stable@vger.kernel.org>; Sun, 17 May 2026 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779061774; cv=none; b=aE97f64vfIAA+jTqQkT10mBNtui3jGqX0vn5t2ujfjxrpE/Up7yiq2j2QjyYsDxDF0rO/xILUEikkHLbtVwU5loILJsn6wleoEG+Phw3qzVs23lyyuXxaqlkvYAhl/irsakSX8nSNdYTlEaXLR4XmFbziAK+t6JAz0fmBymj0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779061774; c=relaxed/simple;
	bh=18r8WGr0sLy2v2ONuN/uyQDOzOFcYvt1CAOLrZySO8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AX5UIMS9ROesmzRwb70bBA+R5XxMhVe62/fujjElnm3RM0v4/fGcD1+VsjnEYKGt17bWApcJD9i6stYLbQQKzPbjppLxWdUnsQFAivLoP8VenMmNFi+q4u9wrY9JRDe7uHFRZ8IX0qodnOobOY0uMLTAtfSwPskJveheTKj32S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbYGiYS8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so14088145e9.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 16:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779061771; x=1779666571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q4JPW1ddnaHfBwPTUg/aODR+UFy3JRdz5SXqJfspXx8=;
        b=AbYGiYS8nkbo+JbSnshL6H+aBDgClnztbe+pd/QC8uUrJRU+dnJFtiIPFfAyfVjiui
         47tpix7Zk/1Tp68LaGFvzZnrE6TUaTFQv9DemY3TeVSKCSasJkGwIqEG9U5xJOmRYTjN
         X/6Fyop7+EzgCBrukGNDBCkLZnq2PQrRMkDyirPg/olp1e57olXRqVd/xYdmllEoxesn
         V4+N3VyL4jeVMnuS76ua3BGCYEvfHv9FXhuNaqIK+Wdu20edGbbSp7vh8AEbmJ/QQ9+6
         Jlpzv/dro3z/TNYU5v+o1ITHfZ+Kp3sKbTiEVW0YQywqLXFX0VXI/mqRU7mi8E2ple5o
         qkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779061771; x=1779666571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4JPW1ddnaHfBwPTUg/aODR+UFy3JRdz5SXqJfspXx8=;
        b=fgh8dFQzDSdp4JxnOKwzyYQSGAZoSYHBoty1aYF0rLK6bYUF3kjsdjQBCKVd6E6Dr4
         KVSNV1fI0PomgLiuFmXKLd0+ZpPNxpwklrztD2eZVwznVt1fP3ltWrbjFkOOZLXYDDLN
         DCOp5oCGNserEdjjjUKqp4ptQFItXYZP9u25j/sEXT22WwUUQzqg+Z88G9EXJ5dA+Ymi
         ko//nC132EvVBU/Gi7raJRScV8hnAgawcIEgYU7qWqv+5AFF6rJy/lZ/hbfXVA2M6x9X
         V8ny3HSmVtmUy6u1Qh/05zfVTmIvGOujDu9Gd5iDrb81Mez4+wDcR1WhRF1SXtCT0J2p
         4fEA==
X-Forwarded-Encrypted: i=1; AFNElJ/FhVaw2AMc6X0DBjRLPIoIaO79e+RvLeHa4VJzs6oiWGAnAW8iTvOcY4ioPqVVsGE84u47Lq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+bY1kAw1R6EvCKz4o4zsdW0syCbXofYj4JYvlSUR6aKlOdhq
	1N78htvMpgg5kK0aQfNLUwKqVeeN2wJpqdOobRzGHOrHqdC/lTIdkY6V
X-Gm-Gg: Acq92OFH9KuAzfkkhpIWsKwsjpJXeBehpAU5IKZkJd2Dq+9J0uSWhJJ2FFPwJ59vJDP
	CM73OWRDiheeIoQpD0Czh3Lb2S8hdvRXKADLds3EhWns9N3yYhLqi2eMg2UaSvtAEvo7oFbWyOh
	CFkFNSzr6GpXhKlId7ROS46qKSWuNPiSz/CZqKmzqTntcYsPeACi+J/Bo6Na1uz4JEEasL0KhqI
	yGrHHaNSMsLe88OmzXmLDz1UjJQtmQ5qo9yI9mBQRH0JCnp+Ks4VC/yU7ziVLNcLrCgKCUXMLom
	BTGFBAKwHUZaDAyC7WbC2nGWuj/75VZMCO6IqWQ2Tban+SA888wcfkdt6LoMgBx0uYggW2RlVf5
	CiseWyJ/BGfOOl+h1SE3RhyQF0dLmc9UjaBMiUVLzvKsq+IPhiBHNPh5U8YXwaH2atUUz2wbgke
	dTjxL89kLCmhfgXEhu8RU4bKKgxC4Z4qCsKGOMZ0nqOrzezStoJM6Tb5Gh1cdBGYfryfmfRpGI5
	hy9OM571s6Z
X-Received: by 2002:a05:600c:a406:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48fe4fa1902mr154323275e9.6.1779061771345;
        Sun, 17 May 2026 16:49:31 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febf86db7sm100133505e9.6.2026.05.17.16.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 16:49:30 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] Bluetooth: HIDP: fix missing length checks in hidp_input_report()
Date: Sun, 17 May 2026 19:48:05 -0400
Message-ID: <20260517234805.116570-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D07AF5646CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249155-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

hidp_input_report() reads keyboard and mouse payload data from an skb
without first verifying that skb->len contains enough data.

hidp_recv_intr_frame() pulls the 1-byte HIDP header before dispatching
to hidp_input_report(). If a paired device sends a truncated packet,
the handler reads beyond the valid skb data, resulting in
an out-of-bounds read of skb data.
The OOB bytes may be interpreted as phantom key presses or
spurious mouse movement.

Add a check that skb->len is non-zero before the type switch, and
per-report-type minimum length checks before accessing the payload.

Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/hidp/core.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 976f91eeb..03838a6ff 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -179,12 +179,22 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 {
 	struct input_dev *dev = session->input;
 	unsigned char *keys = session->keys;
-	unsigned char *udata = skb->data + 1;
-	signed char *sdata = skb->data + 1;
-	int i, size = skb->len - 1;
+	unsigned char *udata;
+	signed char *sdata;
+	int i, size;
+
+	if (!skb->len)
+		return;
+
+	udata = skb->data + 1;
+	sdata = skb->data + 1;
+	size = skb->len - 1;
 
 	switch (skb->data[0]) {
 	case 0x01:	/* Keyboard report */
+		if (size < 8)
+			break;
+
 		for (i = 0; i < 8; i++)
 			input_report_key(dev, hidp_keycode[i + 224], (udata[0] >> i) & 1);
 
@@ -213,6 +223,9 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 		break;
 
 	case 0x02:	/* Mouse report */
+		if (size < 3)
+			break;
+
 		input_report_key(dev, BTN_LEFT,   sdata[0] & 0x01);
 		input_report_key(dev, BTN_RIGHT,  sdata[0] & 0x02);
 		input_report_key(dev, BTN_MIDDLE, sdata[0] & 0x04);
-- 
2.54.0



Return-Path: <stable+bounces-253393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD2xAqYqDmpq6gUAu9opvQ
	(envelope-from <stable+bounces-253393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:41:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B8359B351
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E00CD3028B54
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2643C395D8F;
	Wed, 20 May 2026 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQZxUipI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9678733EB1B
	for <stable@vger.kernel.org>; Wed, 20 May 2026 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313314; cv=none; b=s0uMmswaRx3x+QTwxouf248XCqIkOQsrQkHVsVdz0jFovQCSkMsrUxCTGKKRX0lLFOSRFFE0tRyEnyJWJ7tbAU34SyJ59JLFwWond3Zw+ibZPx0/MyWXfpTDVDa7OQLe5/XgGXLiXZ2ATRu3KGIzzoxXGhPdDdAI5AGHIWsJWaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313314; c=relaxed/simple;
	bh=q8FoWYVLPlkL+kH1MsFlOIr4cXjQCeHlCbdbANhazyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUEM/I22wJA2gmW7CF3nn5bxzxW7vDMqDV6lTYaG1jnsX0nkqWzBlAKNr/gm4ZYK+D95+BwIRFHkt8xGOkR53jKi65csahxXiR3HFJuRUm8xF9w3Sq78QcjPoCshNdrjfd9A80n50Gjw9s0k5s31Z3PAyveGy9QlyvIT/muJxaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQZxUipI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6802f9c5debso11927673a12.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779313312; x=1779918112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5t5r4M2iJCMhY9Y3g5BpbaSaxYN98wLxatFgP2FtCk=;
        b=YQZxUipIL3ZA2ejuNDHIE56BWxfIY+R8uUG57g9rLJbtSnMdABJFAUoySHBqN5VXJ4
         yNvOspgMF2wU5INT9InKDCkY1g+3/04zfl2RNfWQBfeM+rKBpZ6dP9IQR1VA1GohhjAT
         otx7yWDrVP0/pMHSDr6O4g5C30AkRmvCVxJAftPX+bYyl8PpzyJ2q6JLz32jrPAlQSBk
         E2kilWioQ1hUTz3qfl0iZW9Bbg9RnuqG+QGycIXJuKF6KQZQFrqcwoU+cKDXBOOxP44q
         VKbl1OV5dWH0bjQ75tXhsYy8cC3vOGPKssNA2UcmVgb2lnh/MPbOj353K/OD6rg9MBm8
         asVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779313312; x=1779918112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h5t5r4M2iJCMhY9Y3g5BpbaSaxYN98wLxatFgP2FtCk=;
        b=fiD+HG/9EREtLa7eaLxcxr9HlqF4rDU0tHaLAQK+dHkFyUtWNUJf9STRJh4vf+WcZ/
         PNS/CnS2PWZEo9C0iy0HaFkbioGplTmRQuP5X3hfPuCGrmeXV4/MbkxhSN0MslnMwcYA
         NMESZqZjLDyDhZzjZlgvQhdu65QPBrm2prXBoTtwwH8LTtLeH1fItBuISzVcfaL2Q+rL
         uGjRnZaOcqV7y4P+ZWm03P6FxU6NqR5nIxOS9fh4atPJFVZX0UIVX+YwGgmBNQFXmzGf
         RemRKjUusHcnktYKPs5Fbiw+HRZi9qlqHxPbMIKCWC+3FXlTuPFiToZ1G+ZW1fbZ3LK+
         JAwg==
X-Forwarded-Encrypted: i=1; AFNElJ+2UFQ9J3PFdR7bxRFhTwJaA45IWLDlUDJGnIppqZ/EW8acXu9wATjWCHQczd1Qg7dbzJl6lM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwartEHFCBrHUXKCnqA7GiBqBF2Nw5jc8Przz3owGCl3oj4ZFDp
	MQUxnyvcAd8thblLVWPLhnzH8pNHgSizBqiGiEWyiP7jLEWpKWdm5lRm
X-Gm-Gg: Acq92OG3MxCow5cvOJ0w1rnnbVWJ0TU3UM9VIGTdp+2Dc15oo3mTV2XjiLrzy+R8z+y
	554MdC7MjlUEvrH6+ylAafphzYJbZ5/wAUrsmtMia5PLC96gRcUFI9hkorHFCDYJGte3n8NtGXf
	ZEdkvn3A+Oz0BOjmF/7aRky4tat6kgRgCwn10q0XH+asN5D5wzO5Y1EDGf7pvCUe+Uqh9NGEbNd
	vMiwYB9Yq5682P5p71K4LCR/AT+/7iO+DL2+HOGaJ22fLJ6/XLV0u6gAEjIKv1Q98LZ6SQzanCC
	sE3TOlx9ipJOjvHZFL7UHohDSyPKoO/LnCXCZ7Kurl9WTNsVonMAGxks8ex7kbSwxU1mt+ZSIRs
	G69Gfhs8cl9losFEPB6PmLmExqgVlN3OnilyCZkWpPKMNTMO/M0xGcww6YgeCyR3WEJhmce57DQ
	jEY5Ql8nFoa0mgG+0RHTnqu5M36nqWROUrzs6sRAAJAbDUT/afPLi4ceMTcIPvLAgtXDynB0eQm
	A==
X-Received: by 2002:a05:6402:358e:b0:682:d56d:1de8 with SMTP id 4fb4d7f45d1cf-683bcd9f01emr13077801a12.14.1779313311894;
        Wed, 20 May 2026 14:41:51 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6882442b03fsm114869a12.12.2026.05.20.14.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:41:51 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: HIDP: fix missing length checks in hidp_input_report()
Date: Wed, 20 May 2026 17:41:33 -0400
Message-ID: <20260520214133.27746-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517234805.116570-1-meatuni001@gmail.com>
References: <20260517234805.116570-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253393-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A6B8359B351
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hidp_input_report() reads keyboard and mouse payload data from an skb
without first verifying that skb->len contains enough data.

hidp_recv_intr_frame() pulls the 1-byte HIDP header before dispatching
to hidp_input_report(). If a paired device sends a truncated packet,
the handler reads beyond the valid skb data, resulting in an
out-of-bounds read of skb data. The OOB bytes may be interpreted as
phantom key presses or spurious mouse movement.

Add a check that skb->len is non-zero before the type switch, and
per-report-type minimum length checks before accessing the payload.

Cc: stable@vger.kernel.org
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



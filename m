Return-Path: <stable+bounces-230815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAvPE6Y1yGn/iAUAu9opvQ
	(envelope-from <stable+bounces-230815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 21:10:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C035F34FE8D
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 21:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6D403018439
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 20:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5E2341050;
	Sat, 28 Mar 2026 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnTRzqQP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B533A9F3
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728599; cv=none; b=qwOEVa9eJOeuCJlN7Hx1H9h4TTMrfk8wUnTrWZjVvXg4kuDluNbvQuKV7Ft2FFQBpSk/oWZfHjaPpYCLeqDiq0tAdg65h6GdFU4YNb6HhHJOXDKOOnVrWlomA53f8bWZJmBc3ptJ7njfv2BlbsboLYl50aVSfSlPa2mjcaNP8HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728599; c=relaxed/simple;
	bh=GxviuNMaKLLkHWLE6NwvP8CHcnvy5HbE2KoMTrTrxeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvwRfRfEMJCBZ/uuzul0ef2VA+sx5Xeyon7+PhYi/NoehshztUIamWIbWAps7NLhDECMPaqoGZf855FUgfRIh57j4BJqZ6jeW3vR17aUBkpCHpjJM18SS4N9nfMs0U6HiVFaSjEyU6WYNzCYwQeevbdyeDiL/BnHoV5iST7/dxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnTRzqQP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82735a41920so1150369b3a.2
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 13:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728597; x=1775333397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ne6ohxmFK8CKmixyfoQQWL+dvvk4ukAUm4iPHOxaK4=;
        b=hnTRzqQPvdz94ZiFhhEetc5ordP88h1yuT3HziiIlX+vk3gUzaGZclYNZsp3ccO9Wy
         CNeqLInrS3hSiZbLCNbQIpUoJq0xGhbBFG+oQRwgfwWz8fxkt1O3A+uKHCbECCpLmmO2
         d/SLGG4uhAQcNByNSZ4l1/fCsVBnnB/64ZREwx0byFZaD/TlSRqyGstwF7Zz5Jqjk/5m
         cvWr42xk9XLB22F6oAr/6Is5CWN+dhw1fDduPtETbI46oPThUNTCTcZhoKHfPyIGMYmD
         yMrxmG0h3nMxni45lzUtCM3lvUW7rTPcCYUSoBeanunWXprtBVD5CNGjFx2A7k93LfX0
         R9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728597; x=1775333397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ne6ohxmFK8CKmixyfoQQWL+dvvk4ukAUm4iPHOxaK4=;
        b=sK8guqBYpLuiIlkeMdSQ9FHMlVniX3BC97w6m/WmZ3c88R2Zpy8Mn9GOe/QttU5eoq
         VKG//0YbvnkFu3XNmpTecMqQaOUd2ERvVVtUMHJLI4LApN2Ljj/Lq/21SKGfw9RujaPi
         +BLgoMUC/r4dP2oK5o9HejcIlLzzo8G5USxUQhdrRKRZIwq5RUbU/3qp8luIVTOuYEVE
         mpxigcHz1aZVfC03IJDvXA4GRGS/2q3q8fTL9laH2COFQji/Yp3db9jIJG5lmYCq+Ckh
         nQqos0Y5FymdzIT+czr9pzvWAwqor++1ukKGFAnVOu+infQRa6HgJNlXyWJ/rdV7PBD8
         k03g==
X-Forwarded-Encrypted: i=1; AJvYcCWo4qnfyIcx1UX1Ys6VKTjg+yuh6U1Rz5CCzZZxAHbfANGdnXHnkzzaE599lsX4xrKJhdBVExE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUu97MW4g3YMOkyaj3B0y3KkGZ6XhJCoy1LJajs/CpWmBW90Bs
	wvy3R2lFKDFOUBcIp8yCl6qH5j3C4SV2aa1SeiAOQN7CQksih1Fxu5Pn
X-Gm-Gg: ATEYQzx5kkn671CGDXNEwnOOEBpBUrSE4bv2qeMq3gA6N7eaMyIP05Ot199OZDahgtH
	+lYhaRu2ZI78eLB/cgduYJsE9wRHOvN5bm4cgLBwiTddAZkXkYRxZbAEtrXpqlnWcW6nuR67kCN
	/UHGeXxvm7kuqQASPJgiHEoNfYwQ+/+VHsDMLKC1RVHW16+gyELKdDtfuX33+BHVLrMBT6u+AXy
	DQCbaxcYnp/c804GKJQwGM/wif9qXRK2q1TbirN5xmvzEJgYhSEPEw+NFnijbdYAKitrXCsyWvC
	gxxkLCyIamAlWvnv/sY+Xx7iI46+ykYTIb6BDDFd30dvtPYiysx3viPWqbDCA5f9ej6JxROfi87
	E6s2j4Xl6ksy2biU9d93wb6nIhU19MKmbkXDIlAwqYjtXU6BdmQ+ghe3oTTRY/WEfPX0raNBacT
	oyqHiJK5tYmOewoiIc2A==
X-Received: by 2002:a05:6a00:1a89:b0:81f:be3c:9c9e with SMTP id d2e1a72fcca58-82c9600659cmr6163581b3a.33.1774728597308;
        Sat, 28 Mar 2026 13:09:57 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caa8be173sm2329605b3a.55.2026.03.28.13.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:09:56 -0700 (PDT)
From: Kangzheng Gu <xiaoguai0992@gmail.com>
To: gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	xiaoguai0992@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: validate ISO_END fragments
Date: Sat, 28 Mar 2026 20:09:38 +0000
Message-ID: <20260328200938.140528-1-xiaoguai0992@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAKvcANPiqdO_Re3+06DWhb7uyKP+gCODJpo35sq5-x62gYJUPw@mail.gmail.com>
References: <CAKvcANPiqdO_Re3+06DWhb7uyKP+gCODJpo35sq5-x62gYJUPw@mail.gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-230815-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,holtmann.org,gmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoguai0992@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C035F34FE8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A malformed ISO_END fragment can trigger a NULL pointer dereference
due to missing validation before processing. An oversized end fragment
should also be rejected.

Add the same validation for ISO_END as for ISO_CONT, and reset the
in-progress reassembly state when malformed input is detected.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Signed-off-by: Kangzheng Gu <xiaoguai0992@gmail.com>
---
 net/bluetooth/iso.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index be145e2736b7..8707f3c4b103 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2587,6 +2587,27 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 		break;
 
 	case ISO_END:
+		BT_DBG("End: frag len %d (expecting %d)", skb->len,
+		       conn->rx_len);
+
+		if (!conn->rx_len) {
+			BT_ERR("Unexpected end frame (len %d)",
+			       skb->len);
+			kfree_skb(conn->rx_skb);
+			conn->rx_skb = NULL;
+			conn->rx_len = 0;
+			goto drop;
+		}
+
+		if (skb->len > conn->rx_len) {
+			BT_ERR("Fragment is too long (len %d, expected %d)",
+			       skb->len, conn->rx_len);
+			kfree_skb(conn->rx_skb);
+			conn->rx_skb = NULL;
+			conn->rx_len = 0;
+			goto drop;
+		}
+
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;
-- 
2.50.1



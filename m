Return-Path: <stable+bounces-230057-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAQJM6ovwmk+aAQAu9opvQ
	(envelope-from <stable+bounces-230057-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 07:31:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AD3302FF9
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 07:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4128D3071BED
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 06:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B237C3B388C;
	Tue, 24 Mar 2026 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkLvzVpF"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C033B9611
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333471; cv=none; b=TmRMRvq5whosCLd5LpD0smkKHokUjk7O3My6Qz8fb/ohmXDwIQA3GlaUqvRhMf4czqe84PYDzOx3GjosCK44YdzqAM4IM6aeM3VmlRMQKp7daQjP/GsP4U2PfLSzvLczs7/OXwujtp+bX/WCi4XnY69tr9aNYGgFmu2yWS0fdkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333471; c=relaxed/simple;
	bh=9qdKyp5agbbjYzTy+gAniLiLFuOM6OusSwuJ6o9b6KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXM+Me16a9OQ+5cRcnybYwOOa4nJ6kAJue33IZaIfRAFN7U6XzVrww4AilkBCEE+vh7PpbaGiEpDGlqvrihFmeXCTngE4eHB9yB0ATEAz/FMH2Vk8tNjLZWXKZyTNoF/uHfYOc/V4N+oTPDZ97m6TZwrh9dqbawZWxeWJJoQdSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkLvzVpF; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56a9c5cb48bso1658021e0c.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 23:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774333469; x=1774938269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhRLd8KQvILenMrYsAiRnKYz454ZhDA5XTnLnFbyjwc=;
        b=PkLvzVpFxhm35WZ+fz3WwT3US16pp2so4VCI/LC0jJQiCaYZbOL1mq3xHf34Ah6hQk
         cO8pDPQgqMUfiRWNXrCtRChmxkamYxv0FkmUykmiQ9uqDaLbhtE6MP46O65QJVUHh+tn
         h2XClT4434n8eXHNKLVf42cBDtKiSeRTx4hVVloUgiGJ6mReCI3yQpswWaXwYLetWn/U
         wk9gXaweZ7t6wSd8SoyuuykIhQNVjF1/C3AgjnIuvZFVYh66Tz/Pv+x62/DoHq8dESJZ
         D+XDquFrbEC+X0eRlpOyQMeKczbnjOLbwFgajeiVhHgGWcNfpKcvwb2K42WVo3r8I2Nk
         C1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774333469; x=1774938269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhRLd8KQvILenMrYsAiRnKYz454ZhDA5XTnLnFbyjwc=;
        b=edBftKk76eNhJHQjLyAfzf7ZoWakb4tUHJ30jEHxwj+v6GAr0hlNumosKMCGzIZmWe
         0YKpbKC7nS0CskoU2O8ZrMQPrXjGbf64yRD++8WALF6wbVsJTepVKfhkCVmqpgIW/Dyk
         aehNfG6Ljb8D8eZM3zVjWMM1Xr2wIZ0B9UbtiQne7nPWGvbu3FYQVpk9Nl08EiXXuD3b
         oJ51zlEnViDqc6kmGQJHZCN3DSXXOGhOIXFKFa99vq8KrzmtKuXs5NORZvDzVyFXnC3X
         XwtB4Ezv9YJe8FckIuJuMXThfV3TiluRx3g96dqRETjjOjUN7rMOzEuqTGfr8K7CAC8O
         qUCg==
X-Forwarded-Encrypted: i=1; AJvYcCXcxRCnH31dcTBmUqLlloLhDmMIcrCoCngqN0frRDQnlyn3+PkXfW7W7eQyJH7ra63Fb10E/pE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8y7NCEWsrtY629WEj1wWvYFbonprgIuOjx1q7eFB0yOCJVre/
	5Bvj8uBBiZZrFKESDmMsxuaNTGudyp0TZY53JTQP4MIxkSVIfXJg48ez9sWMtdqH7CW/ug==
X-Gm-Gg: ATEYQzzyJMwrhThpqhpJMDP2SPyf1uZ4xYEGM3tBc3tbWmenymU3AFGiatOeB5/Ui+T
	vtmr3rMFrb9pO5qW4L2LgS5rVb6Y3UYTflVdKZfyUQdMYOzWq6jkCjyONm3oIpt8hj+Wnophq6l
	IQrKt6gQOeioUBmcMO+6VljcmCnuuHtdkLHbEZgoVVGMZ013pdu6mob/SZMB+P8Fdw4HZUIAgx7
	4G6nG+GzrEzyIwQmU7fMQIGaz1VBN5rYw7RVJoFyfGhxYDQQK1qc9S7noTKF/F4l8PaSk2go90O
	3vcfDiirkjF95zlOB+Sph0X2jOFbwve6pzzea2dmbFidtEgy0GXiqu+8nJsgFy/3g8HiH5H6e6g
	tiiwEUkObRx0wDlE2V8rA0P8akIzSffbwoG35IsWAlJF61Vd1QJHZONYM17ReWwwyyS1TFe/1Ix
	7P0mhQdTUEg/N0fdJlTg7ceQE/m/4=
X-Received: by 2002:a05:6122:1798:b0:56b:960a:a4b7 with SMTP id 71dfb90a1353d-56cde343441mr6514088e0c.5.1774333468983;
        Mon, 23 Mar 2026 23:24:28 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac1:7680:1048::11:161])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddcfc94dsm14996801e0c.18.2026.03.23.23.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:24:28 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: gupt21@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH] HID: mcp2221: validate report size in raw_event handler
Date: Tue, 24 Mar 2026 00:24:03 -0600
Message-ID: <20260324062403.341855-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230057-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82AD3302FF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mcp2221_raw_event() accesses the data buffer at offsets up to 55
without validating the size parameter. Since __hid_input_report()
invokes the driver's raw_event callback before
hid_report_raw_event() performs its own report-size validation, a
device sending a truncated HID report can cause out-of-bounds heap
reads in the kernel.

The most critical access is the memcpy from data[50] into
mcp->adc_values (6 bytes) when CONFIG_IIO is reachable. Other
unchecked accesses include data[20] and a memcpy at data[22].
Additionally, a memcpy with device-controlled length (data[3],
up to 60 bytes) from data[4] does not verify that size is large
enough to cover the copy.

MCP2221 devices use 64-byte HID reports. Add a check at the top of
the handler to reject any report shorter than expected.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/hid/hid-mcp2221.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index ef3b5c77c..fcac37491 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -851,6 +851,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 	u8 *buf;
 	struct mcp2221 *mcp = hid_get_drvdata(hdev);
 
+	/* MCP2221 always sends 64-byte reports */
+	if (size < 64)
+		return 0;
+
 	switch (data[0]) {
 
 	case MCP2221_I2C_WR_DATA:
-- 
2.43.0



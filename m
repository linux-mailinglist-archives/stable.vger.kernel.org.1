Return-Path: <stable+bounces-245376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DiDD06JAmrVtwEAu9opvQ
	(envelope-from <stable+bounces-245376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 03:58:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7EB518877
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 03:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 003A7301B93D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 01:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6372628F948;
	Tue, 12 May 2026 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR/7129v"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E525383329
	for <stable@vger.kernel.org>; Tue, 12 May 2026 01:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551112; cv=none; b=ApSGXFB48iKGNnz/bp3PrPtJaugV7wAJlo/eH0fIcjdOrdjLLPNPf4b6/6fD6XTOyXstKriAALLiC8wF2H1oGEsbUe7gl/6lJM0BMGdWP5l4KR2feSAXy/eHJhnA/IFWJZt5kHkqRB8BLkSzFuZJ1vDXiWIiGWtkXauuYLhrekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551112; c=relaxed/simple;
	bh=xAs7soMkHl5ZEqelkAMU+KxZY7zEQ+JNb1bToXX50h8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0q+KJ5jTaAefsL3KL+Kg+iOiiRmoD9mqDyUTnrS9huHG07hmjds8TVXlGBy6JOfuvzLyC92Wh4IGTPBxvyWzT3+z3wZMtnOG3IEr6/OhiO9x7EaXDKMxE0lraMI3EqlEmywGbIV0JcVZztjRYIlwBdd4Iqg9GgXix+GmtknKNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WR/7129v; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3683157ec13so393360a91.2
        for <stable@vger.kernel.org>; Mon, 11 May 2026 18:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778551110; x=1779155910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bv5IUYRwwH6Sa8774zC9j8VUEUymXFEHfk8vFZ4aRM8=;
        b=WR/7129vb+jWv3QWTRw9pmZzSjj346vj3/fEyUDHArsUiAfEHec9+2W6PwSOg9Ln7M
         5VDv7M8bgaa51u58vqz+cwgJcML719XAqTg5dzhtf4Esq/3lMt8lALx60uhlcim/8qyq
         7tyWASGeT8gJwf00KxeGtZzKm89BCptyr22h0+CY8hRt6Oa0mMHAHXokGhZWOKn/zire
         mA94RPjfsNlrSPuUlVuteCqpZIM3OSykADQYmobyp0HNA5h0KF0oHqF3QPFtm+Xoml4Z
         87RNG3uxJuk5UmOZZ3hXvkokUb6PHp4FSqJEkbcQdC37Cdb7OZefcRQW4b091vKLyitL
         UlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778551110; x=1779155910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv5IUYRwwH6Sa8774zC9j8VUEUymXFEHfk8vFZ4aRM8=;
        b=QcZ7QbDGF6oBj3YNT7jlGOQJ2sLDpOVWUn8US/m0QZGas/BkgzNLvgH8j+IQHT3dUL
         K4xMZOx2ikwRhOX8TWoc9KGT7TlaEr8N06cieEdcYzk1TAgLishFuxHFDgnL+6EJtTi5
         kzoxOJNXopn1iAGOw8wGnpTjTVgwatuAJ0VPzOOWf9+enZkCdUmLvow7yhTGL9c9rDi9
         4xB+uQE36LL6ZhVlH/LqtNzWtjDpvkNGBaX2c19GqrvICpQfFIG3Vty+OVZ4rdbBY9sG
         e1uQjr6l5pmMyOdFxcD0X5O0NdpOk7QSJRHiHkBkfAwI5MBX3iD8T0uiW/8eVSylNXeV
         aZMg==
X-Forwarded-Encrypted: i=1; AFNElJ/u03gkxIaLd8vOoK5qKYmTxr0cG/gC3yPxNI8zRkJjv90EMdz9hK+p4p4iO80oACOZuxJ39ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxmqBIaiczQvK1IBK4dyQu/atOscKbyK+B2bW5g4WKv3UNywO8
	I4QulKjAj9ngrfTWA13oaikmCqQREqBsI4Y2HKokXsxANiLvHaY9Iz7O8fDju5JaNmVgcw==
X-Gm-Gg: Acq92OEuSuIlo/rZ5LvsfJSCapY5x0hI+A5kUL5gJVcrhBbqcy2y/j0/UtEBz9OXPkk
	G5VH+rhf9vVa76vfqQk5SkfjLfIodTkUZzuENa2D03y26kf3LucfuUW4FCQoAAEVhzEAOPeRIeL
	vf6pjmXJ4aWm6hgDtDWrgz/a1nvy8bLSfErcwuDvt3YOeOwEcQcUuDNK1mvgEj8RA3idIx31mxJ
	LEXUoyFhzjqR3tc5/SO6lC4gIzYyqYLepb6cKh0gP0poUoZYe/gj5CGZM62v575qixqgF2yxN8+
	48mCYQCZH4xksnl4ZPk2P/32MdA4LOzrNXeIyAEuGcNpxb9YNxvmPKLHUyJ50Jr1pj2egcSXJ09
	hHrzJ259hP4+h7TPbOWyto//2Ezd4bRQNH4SuQw1zifHRBDOiihWejfW6JFYGPLBHRL4GHTEzeB
	nGkMEKsDuEIaA7kCnbaJWS5pfMzMFqtF7v21mpaM+UJtQ=
X-Received: by 2002:a17:903:457:b0:2bc:ee93:ddc1 with SMTP id d9443c01a7336-2bcee93e22amr13323735ad.4.1778551110341;
        Mon, 11 May 2026 18:58:30 -0700 (PDT)
Received: from SH-7N5RBY3.aixin-chip.com ([113.106.167.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27055sm117932915ad.6.2026.05.11.18.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:58:29 -0700 (PDT)
From: hlleng <a909204013@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hlleng <a909204013@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: quirks: Add ALWAYS_POLL quirk for SIGMACHIP USB mouse
Date: Tue, 12 May 2026 09:57:37 +0800
Message-ID: <20260512015737.8919-1-a909204013@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE7EB518877
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-245376-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a909204013@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The SIGMACHIP USB mouse with VID/PID 1c4f:0034 can disconnect and
re-enumerate repeatedly after it has been enumerated if its interrupt
endpoint is not continuously polled.

This was observed with the device reporting itself as "SIGMACHIP Usb
Mouse". Keeping the input event device open avoids the disconnects.

Add HID_QUIRK_ALWAYS_POLL for this device so the HID core keeps polling
it even when there is no userspace input consumer.

Cc: stable@vger.kernel.org
Signed-off-by: hlleng <a909204013@gmail.com>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0cf637423..c07e90dbd 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1280,6 +1280,7 @@
 
 #define USB_VENDOR_ID_SIGMA_MICRO	0x1c4f
 #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD	0x0002
+#define USB_DEVICE_ID_SIGMA_MICRO_USB_MOUSE	0x0034
 #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD2	0x0059
 
 #define USB_VENDOR_ID_SIGMATEL		0x066F
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 9e88c9d6c..800b8f76d 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -187,6 +187,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_USB_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMATEL, USB_DEVICE_ID_SIGMATEL_STMP3780), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS1030_TOUCH), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS817_TOUCH), HID_QUIRK_NOGET },
-- 
2.54.0



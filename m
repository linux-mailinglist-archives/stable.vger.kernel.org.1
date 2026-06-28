Return-Path: <stable+bounces-269565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PQYCIudQQWo9ngkAu9opvQ
	(envelope-from <stable+bounces-269565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:50:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2C16D471B
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:50:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=drAefT3a;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269565-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269565-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32462301D05F
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712D823BD1B;
	Sun, 28 Jun 2026 16:48:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79C23ED5B
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:48:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665309; cv=none; b=Blcjk2DyYjDKWhKPMUusbCsa6+KKy8uOYms9YCzLlnlky+36bL+zeCNkD2+a4C35dNyaMgX0sqQpFcdyMcoltgnJZlR6GFszkh2uwkUHx5Nf0kxKRdAQ6YIIyyyQzTlCzcA8DsvWzlrpdf0C+6liwx3bA+3OfBHICoMeZ7l8PSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665309; c=relaxed/simple;
	bh=cf6yj5xifZFmTr357rW0WbouH8QTIDIjipjpL5fIZzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HyswIhpjTbgs8Xd93JnjwVj2uwbUJCsP6dGSKOq38FsMbhmf0SbiDEJFab6DI/tR2Xw7Ghu+X2t3/mmUDdo+MnBsGZ4VCNQ9BNh8wAOEdSv4uKSyi7MInQVGFmLucKnoZFQPR9d3FyNJWXSVM6P85JB4F17JNHZLZBnzWKsljCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drAefT3a; arc=none smtp.client-ip=74.125.224.53
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664c6304683so569698d50.2
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782665307; x=1783270107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUvNQVwVpofTw7oTT69Ez1d4kozO3VZdDLOAGHgGSy4=;
        b=drAefT3aoUUPqnd0OPz4nFF4gCSGGxt2xVYxfCETmLnyrGUDpNuTt6wjZVkhaAime/
         2l/zP82VjyG1iiDHKlBw7/xfpFR32a3PtIkVhYdfjyp38aVDuFZGZpDnSNMlQLupYM9M
         TTHVdFpLFegYXi2YEaKg0ZHAQ+IX2utQHqSyi2pDc0R72+NI3xXmZbM0oKrP20kDo5sm
         6T7pI/vLvVokGOI+TKIeNvjTOq+XLTq63sGyDvlM8JMCu6VkO9YVukI5LB2KFyhXty/o
         XY0Q6Gx5tktc6S/zLHhsQfddTEzG0yYkPY3VFqYl2TzHDDPSYQWc8i1aAdTHeM85UuPa
         7i4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782665307; x=1783270107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUvNQVwVpofTw7oTT69Ez1d4kozO3VZdDLOAGHgGSy4=;
        b=i4plB6scBInj07O3q+vjNXoNLzkJ/P/JPlH0yzZ0VtE9RD75o2EDuPM8bg7Y6Pqik8
         p2Nr+2lwkuJwF2aGXNmXLg6Y+CLoPAA1ydV5oOa9gtmySCta7xAA1TusPNYE4uPSiPJ7
         kxSOqtxEoO6fg48g43Dp4XE+rkJ/3laZGQsD4pV4mKVI4L3tJOwWEdjCeZKTFbqUvGbP
         LgLUKCDuQjWGG4Ex1qVpvcLEnxrYLRQp/5TTv8F3HN2FZY9uoOrUNz96cOFt8FGnwp3T
         a6PRE5vjIw08HuaTkmHWj2w+IpB4um9ZBKOpq0Tnv3rQ4u2dsu7RBSQfSDnhafdfFkmg
         phZg==
X-Forwarded-Encrypted: i=1; AHgh+Rpf7HZ5yVWJnwDKGbHBelq0iGzww+XXzYH0RuX59S+7gmPCacG15XCko54n7dzSWBXr9PY7b+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDtHFiw+g9C/T5mYhiP4xLH/gRGYLb+brX7uGbVt5gKrIuLuy
	IEeGo0dEhQ2kSiodJgnQsR7MDj3V2r0QiyZUjBw69Vq7Uvu8JyvJJyzv
X-Gm-Gg: AfdE7clIhokZl6hjpKlQTijhXQ6MBEmadcwDQtMVaUTrXEKJ+tywA9W48as9+w+mXFi
	G/3/3pWGY8Qz9bMbrrkDS2jwnH3DoDQFRwwdZ263vuyddWLR7C7jUTgplmw9dNbk2dT/Qo/svUd
	6wqH4UnyKN+Xu7YAWHNn0yc+t+V6Ot/SQfZLBGjhRfBuVktW4Sp5HNHaSP22W53QPp9frYFef9G
	GFGQtNUbs94SdX7P7hnOip/9WA1gZPahDsAy7ASxCUsNM6k+A7lHdhl6JvsNrRAQ17clLKYaomp
	SjtBq88prVzpObt9Nf33175YZPgp9jW5oOGgpBMUFF7pzxsAClL5oTNWgBPRZh0WGgkDVZT/Ynz
	2GyWTZAPFfly6IcA52d+NEP81Gwnj+eMRENDbkPhaQ6/Y5qHNBkVhLNugAY5CXtdyMlbKBlF42W
	0aINoY4lpnZ4iJ9Oj9Cfx+VF+SebrxPTuTM2xm
X-Received: by 2002:a05:690e:120d:b0:660:5bb0:7ff0 with SMTP id 956f58d0204a3-6648801f1d4mr12732204d50.53.1782665306986;
        Sun, 28 Jun 2026 09:48:26 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6647f785f6bsm5980279d50.6.2026.06.28.09.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:48:26 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] HID: cp2112: validate input response lengths
Date: Sun, 28 Jun 2026 18:47:31 +0200
Message-ID: <20260628164731.17614-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-269565-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jikos@kernel.org,m:bentiss@kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:alhouseenyousef@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,uplogix.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B2C16D471B

cp2112_raw_event() parses transfer-status responses as a fixed seven-byte
structure without checking the report size. It also trusts the length in
data-read responses and copies that many bytes even when the received
report is shorter. A malformed USB device can use either path to trigger
out-of-bounds reads from the HID input buffer.

Reject short status responses with -EMSGSIZE. Treat truncated data
responses as zero-length reads so the waiting transfer fails instead of
timing out or copying beyond the report.

Fixes: e932d8178667 ("HID: add hid-cp2112 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-cp2112.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 04379db93571..f2988659a5cb 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1430,6 +1430,12 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	switch (data[0]) {
 	case CP2112_TRANSFER_STATUS_RESPONSE:
+		if (size < sizeof(*xfer)) {
+			dev->xfer_status = -EMSGSIZE;
+			atomic_set(&dev->xfer_avail, 1);
+			break;
+		}
+
 		hid_dbg(hdev, "xfer status: %02x %02x %04x %04x\n",
 			xfer->status0, xfer->status1,
 			be16_to_cpu(xfer->retries), be16_to_cpu(xfer->length));
@@ -1463,6 +1469,12 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 		atomic_set(&dev->xfer_avail, 1);
 		break;
 	case CP2112_DATA_READ_RESPONSE:
+		if (size < 3 || data[2] > size - 3) {
+			dev->read_length = 0;
+			atomic_set(&dev->read_avail, 1);
+			break;
+		}
+
 		hid_dbg(hdev, "read response: %02x %02x\n", data[1], data[2]);
 
 		dev->read_length = data[2];
@@ -1494,4 +1506,3 @@ module_hid_driver(cp2112_driver);
 MODULE_DESCRIPTION("Silicon Labs HID USB to SMBus master bridge");
 MODULE_AUTHOR("David Barksdale <dbarksdale@uplogix.com>");
 MODULE_LICENSE("GPL");
-
-- 
2.54.0



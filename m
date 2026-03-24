Return-Path: <stable+bounces-230060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJrKD0Y3wml+aQQAu9opvQ
	(envelope-from <stable+bounces-230060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:03:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D6D303A5D
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0556431DC7D9
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 06:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90713DDDDE;
	Tue, 24 Mar 2026 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4wrkf8/"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6075B3EAC88
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334628; cv=none; b=av7QlJjRRfECvCGJ8vTRxAQDNanUCCsfdbLFl8TxmHvbkotqasi98gNfNxM5ttaGS997JFy32b5m9tTuo8Zfohzk8qAG9R4lI/5IyZ/SS53A/zHZtLI/eQvg4vaSQXO6xdcoL+E6Q6N04U4KelJy4ldV4ImrLih5fwKd4aBSgiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334628; c=relaxed/simple;
	bh=ujc5RmR13pOdQaqezJhZ/7IcIxTg4usJF9uIGCuu/OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jK38vl4b+7FECGF6FZS7J7Bw3sgT/iQkifydwUhqImYzyyeTk3kybwGlIMoFr4pQzJjbly4EBpdnYBXc2cKcNyyU00UedkWg4VaPztwe3Lsg6vvV+eI21AdyXRynqlf/r1Ui++pPGyQ8xgYFBcIWUB3iJ/S7Biu11hR27A5NtzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4wrkf8/; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56cf45deb45so628356e0c.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774334618; x=1774939418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Wc3JY3RaoRqNFTG0M5AcX3LAUTNd7UfUccIs7JuU8E=;
        b=P4wrkf8/GMPc/sIiJAR43w3csjLzLpssQdVM3uod5glvmhlGv+BVsXmPZ1bmEEO+Nf
         x8Xv70+6Qgji9PQfTrbJC0fEgsaQw+ZuMP6ph/wjw/gGxbuPchhvpJ58c+6M9zSFOkcV
         JoO4Ll1D0QHVaKp5kmsWqDck/TFD2yyqTT1sZzUFDkw024VC0AgvNwP3Jqarje5oJv5I
         GDNR1BgishAz1m+e1XNYrTQWA3lVF8cmWILEHnuN0d7g6WWUzK78GpAZe/j/eAkND0mI
         tnn1YQUmZ9kruIejTECmhl7hojSUkbtooZuoTraJDBclajOrmufmZLupBuk8CMitfCd1
         GVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334618; x=1774939418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Wc3JY3RaoRqNFTG0M5AcX3LAUTNd7UfUccIs7JuU8E=;
        b=mMDGNvdG79K9GADYauA+ToyfXvgOQfMevTXDBLiHoyV7pvgFCPiSxG5LvrXpMWPRyC
         BM4kGJCxBbyCqP5dX6ebZiO/G6RGDq4n8w1/jiJFR0LS+IP5OZVoTyqTeq01CGfhg/jA
         3f4x24fo+zTNhdERA8mYHgc4TmGFvPtuu/iRVYBYxEYchF6i9xVtS4KzET3Ce6ZP+Qif
         IDY74OXkxW3ehbgJS8G0nuWnKM8t0CtzjhkgUGhFZBhD4jguPW0HXAQs2ClPZbKTU/1j
         Ukx/759lQT0aFMkSLwr7jdk8kZXp5YI8Mx4h5tvzo/4aL1/WFDz4bNEnDdKLDTI7vxE1
         m1iA==
X-Forwarded-Encrypted: i=1; AJvYcCV+xhZou45CMVzDKXC+l+sdimw3PARIvzy2feOVIYW9QC6L/3W+Mc1UZKIHo38CO98WVOPgpYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWfkTHZ9gk71gtxm6OZc/FdyMDLl338BX6edN4A9UDp95gMDV6
	87WOlxK9EITmuE58y83UR0p4Lhlq5nUtv/DsBboq4ZTJnhzRgaQ+NOpy
X-Gm-Gg: ATEYQzzgQWeRHOhM531FkcqHhDaEqmohNwvW2976nNG8TM2AItWR7j3V/wZsXP5EVGP
	vE6Upb1JY+IXQvXz6bTGQ3FNR+yXAtr1xX6Cc8r7hfCzZTdm47ePD7sZbeWEfNyytRa3K9AQpKe
	6tyo1a8CYeqR1GIiEvvlMpi5d7pokjQseA4IONsroTbV8Zus4f09LZ8PNXK2rrAaYoGTPQv1wPf
	o24JcV3so+46jRtNHvXMcl0D5jNbB6+MBzXgPRw9OyblzzxWozjzQzAKD+04leGZwzqfXczSrIK
	c1Ag/SO7wNsfd7YE2BdWUKzrNuNvkVd+k93vPchi5XuRMA98zPxydahAAuVUm2GJGNF2ZfFQUFm
	Cve9NBzPjL+Cqy6BnIcHXHaBeaM3eSBMLqTvcBtkJJo9FbkBBYtrXZj2w7VbgnU58/2JSfO4QZB
	fHLfFG+qM/1V5SrjpKvhGJQ3NaYDs=
X-Received: by 2002:a05:6122:e251:b0:56b:982f:1267 with SMTP id 71dfb90a1353d-56cde43cc1cmr7995444e0c.13.1774334617713;
        Mon, 23 Mar 2026 23:43:37 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac1:76e0:1048::11:161])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddb6d041sm14625744e0c.1.2026.03.23.23.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:43:37 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH] HID: cp2112: validate report size in raw_event handler
Date: Tue, 24 Mar 2026 00:43:32 -0600
Message-ID: <20260324064332.346342-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-230060-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9D6D303A5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cp2112_raw_event() casts the raw data buffer to a
cp2112_xfer_status_report struct and accesses data at offsets up to
data[3+61] without validating the size parameter. Since
__hid_input_report() invokes the driver's raw_event callback before
hid_report_raw_event() performs its own report-size validation, a
device sending a truncated HID report can cause out-of-bounds heap
reads in the kernel.

Specifically, in the CP2112_DATA_READ_RESPONSE case, data[2] is used
as a length (capped at 61 bytes) for a memcpy from data[3] into
dev->read_data. This data is subsequently accessible from userspace
through the I2C read interface. A malicious USB device could
therefore leak up to 61 bytes of kernel heap memory.

CP2112 devices use 64-byte HID reports. Add a check at the top of
the handler to reject any report shorter than expected.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/hid/hid-cp2112.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 803b883ae..b86631163 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1387,6 +1387,10 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct cp2112_device *dev = hid_get_drvdata(hdev);
 	struct cp2112_xfer_status_report *xfer = (void *)data;
 
+	/* CP2112 always sends 64-byte reports */
+	if (size < 64)
+		return 0;
+
 	switch (data[0]) {
 	case CP2112_TRANSFER_STATUS_RESPONSE:
 		hid_dbg(hdev, "xfer status: %02x %02x %04x %04x\n",
-- 
2.43.0



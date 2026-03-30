Return-Path: <stable+bounces-231222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCWpEn57ymnk9AUAu9opvQ
	(envelope-from <stable+bounces-231222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:32:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 537BF35C044
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72797301CAA3
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180543D333C;
	Mon, 30 Mar 2026 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdCtZB1l"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2C3D3CF6
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877354; cv=none; b=ecy21cNG8GVHRlW7vnlJSqPO8HdsNhCe1IwoUPtbHa4WXw0jDGsxOArr6Ofh/h3ZVnzUk0n6Lr0TynhQPkoW/JSYm2WTeJ21t0VOo7W1UV+hDFoch3FFq3cWXEHic2eL7nCq+pp8NWJwbJdX24wodxBx5QfjakTRD6Nmi01IQBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877354; c=relaxed/simple;
	bh=Dyg46i6NCc1WhVwi8ovx5dhpXtlJuvYJqgKq6QPv0Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mms/ZimUbY2KQXr6+ZpYA//pfk+MuSAZiGF9kkSDHQO4lDaMp0X48HCVR83mDEYI8UH7IEFK8QDxvkgXO5KmKmVKzMTuOyK31rf/RBHu+tTGzXXVnc6eo7RVjakvN1BJn0U32BCM0esd0SiznO+mmmUQt9pfJJL1q8yno+RAS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdCtZB1l; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94b07fddecbso2695069241.1
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774877352; x=1775482152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/LwkGsCAcMgkIjG5Z0vM08NnZ6ybKA3EObcdXRbB+Q=;
        b=RdCtZB1lmvHayomBPmZhNIOYXK8FPrrAx0Hw3t7CXUtQuqPKLK6Q3qxYududKUDbRq
         oTr53S1n5qyi0xH+orfiv3/bbuQFLWFeXRmtbPytBS+xDy/7dCMHwaIAziOj7LR8hMId
         /CV7mRCf7l6oojgYXZb6kUBU53vas+Duzw7Fxk+78KnJkMOxadHi5owHSdC7edvWcsbx
         hsks6f/MHlOm6i03hXMAqDpmu149I9uMdP6WyAgxB6z9MRcy5uO+hLAe4u+NOHoMqJdt
         V0gQx1LppEzv5ulhpCOWGlAfo35YJ7A1yJfcarWpbDm9C282FOQKV0QFVjg56a5sGEXo
         MNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774877352; x=1775482152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/LwkGsCAcMgkIjG5Z0vM08NnZ6ybKA3EObcdXRbB+Q=;
        b=SqaA8Eo1cWeg/9CzD4Td4rTXz68ndS0nS1WVnP7l12sjk+yfD9rmoPQitFnQCAeYGo
         wrCJTfjrmUgx/BiS43hLJoeHyhvOQwvhBsnTo7xMmQO09iwCB4YrwntpZalohPogPxQx
         0jrKpyUTe2iFeL+KlxNLDISSUWN+FmzrJG8CrjHIXv6fR8vOzY0TtDQY/HDjGqoy8sur
         n4G6bYHBWcR2BKertcJeWz3Fjte9gOQZqxgs2H2RI0VbpJNvp77DKUjYeiWHKa3I7bjm
         eMbJgFL5ygMw/ZCPMCEDGFvf6pYGRgqdsORuYvzXGmGpTsel4+7TfkgIvpKSSIej/Ozf
         2zwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz1pY+Ssoy76SOYI5y/pNFUvuXaVFSHeydydG+GcpS9jDz173zdxwpv2z8iLz50gIZ4Zkm4jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDb85QYeOzTDUzayl3sXB5b4XcKtUATP6Be9+YNyqeBMAd84J+
	Sa1ZxnvK9EvzmVmYSKYG45Q7uH1VV3HMa7Gg2p18IyWTyh6K1FHenG3A
X-Gm-Gg: ATEYQzykmL0Ptpv8SD+4mAf4ynweAYVu9bA+CrftBF9u0D1hoI6Ug94CMesPj41deW3
	/1fxcPsyKSOrMKmIHSLM80ujWQ1uC6r9OHqTlLOy4+RDALcrZJ6jP0dcF/NI6dUY779bRCpLk4i
	A50A3gKD1TMwgk8JEGkvHB7KSKFoGZIA9CnIWeqa6Vbr7F7maXYuNFkVmZLR30NUw63On631UtX
	ngm95bHBeUUG1PvHTD9Dw9lw7jjNYndT48sTS1AK8AeUMbRpIz06D3Ae8NL0Ki1kAP1Z54OHkhM
	6hSHCAgcx96/M1LpA5pzDmRDLSbiGd/IlpqY7rqzRTiWanq7iwOFBVjmvp4zuFif65xgNfICzy0
	sRPdswxJAO+WWw3JmhWxyA9QhLEbzukV7KYMYmCqnTt2fUXJszQFYRlQFRVXK/y3N769PmXLKB9
	CewSB8b8OU6/HY7J+Onhc86Rrfkd0=
X-Received: by 2002:a05:6102:2009:b0:605:1f22:10f1 with SMTP id ada2fe7eead31-6051f22122cmr1995118137.13.1774877347810;
        Mon, 30 Mar 2026 06:29:07 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac1:76a0:1048::11:1d6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9539e2604e4sm6998229241.1.2026.03.30.06.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:29:07 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2] HID: ft260: validate report size and payload length in raw_event
Date: Mon, 30 Mar 2026 07:28:44 -0600
Message-ID: <20260330132844.827338-1-sebasjosue84@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-231222-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 537BF35C044
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ft260_raw_event() casts the raw data buffer to a
ft260_i2c_input_report struct and accesses its fields without
validating the size parameter. Since __hid_input_report() invokes
the driver's raw_event callback before hid_report_raw_event()
performs its own report-size validation, a device sending a
truncated HID report can cause out-of-bounds heap reads.

Additionally, even with a full-sized report, a corrupted
xfer->length field can cause memcpy to read beyond the report
buffer. The existing check only validates against the destination
buffer size, not the source data available in the report.

Add two checks: reject reports shorter than FT260_REPORT_MAX_LENGTH,
and verify that xfer->length does not exceed the actual data
available in the report. Log warnings to aid debugging.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/hid/hid-ft260.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 333341e80..68008a423 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1068,6 +1068,17 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct ft260_device *dev = hid_get_drvdata(hdev);
 	struct ft260_i2c_input_report *xfer = (void *)data;
 
+	if (size < FT260_REPORT_MAX_LENGTH) {
+		hid_warn(hdev, "short report: %d\n", size);
+		return 0;
+	}
+
+	if (xfer->length > size - offsetof(struct ft260_i2c_input_report, data)) {
+		hid_warn(hdev, "payload %d exceeds report size %d\n",
+			 xfer->length, size);
+		return 0;
+	}
+
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
 		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
-- 
2.43.0



Return-Path: <stable+bounces-230228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHssG9XywmnCnQQAu9opvQ
	(envelope-from <stable+bounces-230228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 21:23:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE3A31C488
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 21:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE98A30F9291
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D7D34A3D0;
	Tue, 24 Mar 2026 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6vCoVf1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9EF3264D7
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383546; cv=none; b=JXvtUlOho0Vw+d5ZhCeVKkqQXgnbVZwHl5gPbXbqGGh7a6f1/4/nMR0+hM2j79YmUAGJDpKIEZ1Tjx58yxYMC/QdJ2wYwxjxHzO1QzJJAaoVp+geH2f9NaSbzGtnlGGAYWIxK1hsW5LNj8qX0AiiIJFAS95zuhM7thYHpH1v1WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383546; c=relaxed/simple;
	bh=Dyg46i6NCc1WhVwi8ovx5dhpXtlJuvYJqgKq6QPv0Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdVKeDgk2iJLfDn0hL4RP5K2b82MWIxbfFZOG/VbFTydduUspVviyjZuDcPoqO5H3Fv1O9Q2ieL493G2njiE3SQzyds0oubl2CbTXWXPNWOxZYNWrvI64LRs6vQVpBNRSyq4BH2LZWRDSsnk5KM8BBTOrPf78dsyqwqA9xfoYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6vCoVf1; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94ec56c6f05so841543241.3
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774383544; x=1774988344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/LwkGsCAcMgkIjG5Z0vM08NnZ6ybKA3EObcdXRbB+Q=;
        b=e6vCoVf12gK9VWthRMn61bBa/NccVDO0jp6+PjF+1gUG5lfxCW6Lloo3qiTgcbzK7o
         UWAtpQ9YKK28PesKG0rLIAedXyI/0nD1swFFk6XPzyl2mBdcb3seQOz3nEhdf4bZq9uB
         EGmF2C+5lfuGxGxTL3WIZq5wH0V092DYfTyuaYnC6oL5iXbypLgE305y0Y4m6mHrcc6f
         3nzxCMRssTptHAgaolWDwMolk+l6XgqgJFCabVIgG0i24QbVuC/oWc5Ke/tpCLlxPW3K
         24OArcrdEiHivf4LCu7yZG6D0xrVagMIRTvdogvgB6wtzFA6XroaH2xmI70oJZAU5RQC
         yaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774383544; x=1774988344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c/LwkGsCAcMgkIjG5Z0vM08NnZ6ybKA3EObcdXRbB+Q=;
        b=o2lGoKBqLnQOh9XwxzFMUQXCTkOk17i/GPNxH/xVGz19cE0ckOZvIkT7mir/Q6PS8H
         tO/VRJQE9DXJA3jGtIXzz3W8TKy53ReobB1bfj5z76+vA18e5Fjg3ZCl0I03ruq+eQKF
         PFbanq0ee8wQcH/4PaPgVXAZ3g291K8v6B8h8qxtF4sPwfYEhq+WSPbgIKgL2jops9RU
         PE6MJOEx1gU0ZhjUSGAYdE0F8E5VXzawuD3Ob8c2UK/A5B6+wSMkM1BEb3GE3SRKpQ73
         R9SLi+Bng3PUgNvG8RR4MEEZsVMdiDWNNDCqxDbwTmMUR8fty6tKi2vN8u+iAbYB+5Ua
         ALRw==
X-Forwarded-Encrypted: i=1; AJvYcCXPo6IJb5CFNQnQYn+8nxKtmqkWcT4D8eTOwzPQKQhI9z/1ybZxQqyrHep6+nY3DpGdy9FqSjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1CEj1PDUFHdrZR+dHOCuJ9ZzlwL9NnJSO283fjZDw1psnn9da
	MwN6sbjfD0J3pV5Zc7XKS4QYc8bAwBGi9zUMWWLdGKQFLb4rFx585vWT
X-Gm-Gg: ATEYQzxkgtSigB3uMzvOctkb0TT6leUwTJx7mWuMJsvAe08y8rHzR+Egc2Jcg5RR3oi
	EhqJLT6lPw3DZnxSv1bYbMN37lkO66/OSH1cZpAOVsrhcpstjbkhuTQWEv2hOJW8xzcIy9kPCsa
	HLzm3SQg0lKC/UWN0irNcP1BgDVzPAMbS1vvW56v37hXPgBWbk0R2ymB1SsfIVpDG7J12SW+Jdn
	7VQyZ/ZzOHumxOtr2Dd/Ogjcr91Nlfjgm641M1Xpivu7a5As6kp6GAwp2qNN8/gLnIbVvUOtHiW
	nLblHwNRh0mfjKdshh0W626oqkka8jzZSaKBRZB2MA1Yz0jwA7WvpKEkZQm/2+XMzlAWr4GV+vO
	F4m0FYPPxT46kaGcZm1sga4GXqmqH92/lvXNh42tkQjy/nwX3f4BGjhkW4y1A5k+4Zln3k64ozM
	o3PSOSG/WYLAE4cVXnvONxezHSRQgiVwVG2Q==
X-Received: by 2002:a05:6102:4425:b0:602:a4af:5fe with SMTP id ada2fe7eead31-603870b6353mr706587137.9.1774383543988;
        Tue, 24 Mar 2026 13:19:03 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6dd:aa::11:17b])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-602b549fff7sm11665211137.7.2026.03.24.13.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:19:03 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: michael.zaidman@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2] HID: ft260: validate report size and payload length in raw_event
Date: Tue, 24 Mar 2026 14:18:58 -0600
Message-ID: <20260324201858.46591-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324173527.11321-1-sebasjosue84@gmail.com>
References: <20260324173527.11321-1-sebasjosue84@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-230228-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0DE3A31C488
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



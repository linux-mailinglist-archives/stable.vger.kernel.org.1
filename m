Return-Path: <stable+bounces-231223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGzpBlx9ymlo9QUAu9opvQ
	(envelope-from <stable+bounces-231223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:40:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA6935C280
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1ADC530CDC0E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6D23D3D13;
	Mon, 30 Mar 2026 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwxvW0uV"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F83876D5
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877369; cv=none; b=DZMsYx35MzPKAGCloxiPX+4QaqKRMi9x18yWnwn4/VwXvEwGufzDP7GEXUCBtoOzy9LE/zMMKfdeCG5qYdIwgX3qrpSg6gZurnlqBqTeT290qb8th8MqAz37laKr+4mO5uHXzQGICXroYBXvVshYqwZQR1csxCBIBrq/OCkhPeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877369; c=relaxed/simple;
	bh=HMPY83hDOtEh2uH8sesLzoJ/Zhf64/JSuRtvJ9f2po4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQMGk5e/5RI2lbWRFSdEQ4y3M06UkyJCZ8MOMzL0X13WPOldWSinTh19V24iUb8hhWbYgX1XRyxbjh50ZEEQ1DY4PZBOdFoa8bAUdifxofxCGGtzkvYm6VeIcE+7eCSiF4EEdZkH2pESU77+HxHxvaVL3eZ5PO5pg88dO5Bo9gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwxvW0uV; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56cd71a7630so1554313e0c.2
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774877367; x=1775482167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=26QADu2V5kInSwvDprX/X5k3HI6g/YNPM7XdH9A3Fig=;
        b=pwxvW0uVskulGYZtE7CZVzUfPj3e1yDwTiMO4bFq7V0qVX3jOkLUQYljhY6K4zwCh2
         /ZuNPDjHVfnQMCldyDPhWKtFxM+Z/mrmQ/OoyBpGTo3SqL0k/d5AHdWQRS1rk7BltB8p
         /RLdGilAA+f99F+QXJavlaYM5+kkUQS4FAvnkBfO+hj025/4e+n3FkZGaoNASiDNzSeA
         nD/4g84s2oGyzTDAEt2cFdhzu59dg2t/ltggYeqlgQ/WKijNjypFnQUWxNKEpAPRtvKP
         PCUk6khYeZ77o0RrDx4fU8jKRXFrgRFC724o+gHjuNvFJOgmcKuHh6vnJpzZ0lv1A45i
         gMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774877367; x=1775482167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26QADu2V5kInSwvDprX/X5k3HI6g/YNPM7XdH9A3Fig=;
        b=CHlGEP42Cfywxs1A4iJr/i1hBm3VPK1WEcgC6jCVu/0zXvcxIX81B0CaSX0AFC5+Q4
         K1mX7CzKGMhPNibL4KalZ1FzDQTEGFe7Kmd5W0QtLoYbh4bDSH1Al1BWAuM58la8nUB/
         7Gl9eKeZxtt82oA8iCz4pmPhIfGk45l3vJf7r7YfMG7ozIsj5q+IrYaJKaJX67dBvSXt
         Mr1jFl0hTNY8obsVcKDknGbVsjb0FOBfnBF+qIRzkjx8pwDQzVyTJAf2+2+Pk0cfl3kR
         T+Q1ouWBlu0EWh2oLJZOige1iDkQGBOzBSF29rH9NDhLEuuEwcsb3HxHKoaYu0luiVPv
         m6PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFfM3WLaXcSO0mDCbpw+B1cu2lW+PrSte1u3UabbAmoYJreEn5Vm77NWGfFHrrFtWjVm8m0+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7AmBqWpY9/F8oxM0pOlcGtRUZQ+wkOka7NYYsEfdELomt5FWH
	bMmWtjm1JrzLuNlT1Rb44vWfr3vDQsyW9OpxthHym+KSMTlponQ80sSO
X-Gm-Gg: ATEYQzz18IeIfchIGfXBHHOO77uVqXfmpKUpDKGdLEmSbMNAtVs2XzE6FloKrM7ET9c
	I/U6H9SOLobLBhGooX+YH7oRZQ6OYfPuYZ5SDsydj2xmm91f+o4SAVELpwf+sb9nIK29qajsiyc
	8b6L+PywdcfULfPWSrX9Hhwm83y0SM/t941E9Bah6SlYUZ6MknHZDboj2BG4MONxzhw7KNNTl5+
	APem+t7N3GZaOv7oN9JR8YTFup183s8WufJDDZNQW/+10atEK5PCHMo1yFXO/VQ9dvdEMzYxvXH
	WR+KetQcjveNT6d7IfoJC4makO++69ckHuVAhOtFyNhRHTDiLpUIVU6Grg8xzU7fz/ykjkplIsk
	iZjFnhhNAEqvWhZAkQxauPjJHR44DRWX8+QyL8V+D41IOAH6qp5mU/pyaRWcd7ocPPKMFWyD2Rn
	GIh9ocDx9uKhdMUdV+9qESXic=
X-Received: by 2002:a05:6122:1801:b0:56a:9841:9f81 with SMTP id 71dfb90a1353d-56d4a51961cmr4233767e0c.6.1774877366946;
        Mon, 30 Mar 2026 06:29:26 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6d9:aa::11:1d6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d588c4016sm8333474e0c.8.2026.03.30.06.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:29:26 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2] HID: mcp2221: validate report size in raw_event handler
Date: Mon, 30 Mar 2026 07:29:22 -0600
Message-ID: <20260330132922.827503-1-sebasjosue84@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-231223-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: BBA6935C280
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
the handler to reject any report shorter than expected, and log a
warning to aid debugging.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/hid/hid-mcp2221.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index ef3b5c77c..770c305d8 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -850,6 +850,11 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 {
 	u8 *buf;
 	struct mcp2221 *mcp = hid_get_drvdata(hdev);
+	/* MCP2221 always sends 64-byte reports */
+	if (size < 64) {
+		hid_warn(hdev, "report too short: %d < 64\n", size);
+		return 0;
+	}
 
 	switch (data[0]) {
 
-- 
2.43.0



Return-Path: <stable+bounces-230200-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEcTMRjGwmmIlgQAu9opvQ
	(envelope-from <stable+bounces-230200-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:12:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCA0319D06
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD7AE30E28C8
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 17:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C40A3EFD1C;
	Tue, 24 Mar 2026 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPHrwHAH"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60963D34B9
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371974; cv=none; b=ILjYq1xKjdCMkYzt0OOMYtJJiHvaJZfjcoU6Nx0yTRxO1vnMZhSfiycY+T1Uu/xRUntagCC4ly4pD664IeE2bkAIzr01tapb6NCpm0y9ZoQx97TJp4xEawtZm2/+r6i8sx5o4QoaDsRqIG/v6LQBX7bOpe0HVBmJl0QcB+ZPmdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371974; c=relaxed/simple;
	bh=HMPY83hDOtEh2uH8sesLzoJ/Zhf64/JSuRtvJ9f2po4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShxIZi5pl+Ofh9KZEFhPbTboKhC84dxxBBzAsEQ+8QS950hXLf7yL/iu3z+8f/4xm7dO9XOchjSCq9G4RofN06eSJ/oVmOuXvctG4JoFa6HrojbDlcw3Vy6SdagSDAyp7w5AseIlBC0majOnuMyDWXy0la640jTEiVxCbRUxm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPHrwHAH; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56a9c5cb48bso1923271e0c.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774371972; x=1774976772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26QADu2V5kInSwvDprX/X5k3HI6g/YNPM7XdH9A3Fig=;
        b=XPHrwHAHMGgq2OLAx+Mw7ht2m9acEdS03JXFuzHT+DPBZYrjKMddKfMUIA3QlnAyDN
         TlepGO5C+nngknTjOQTrBJv7ZWyot2RKSMb/GTtuIQFrPDmMNXpthVESHrZLBXG56S9f
         5lRE0Qn1tWj5jOkA12BDiJdAdvVAVLT3QHCQt+sVLucWhrJgnotYTT+BwwhQTMPa6Ljo
         rmmDzQI/rpV6RDFW+bPRewf4WY/Z0jiO2KbQA/e0aVzsHVdSITdYEPuwYYGkWevPiOTG
         mVYni14z8wW/JyzHk7RPtdX/z49RXfRb8ijlsh9Mlqaq6IvHTK/0GhTM5QnDdBB0EjWO
         518A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774371972; x=1774976772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=26QADu2V5kInSwvDprX/X5k3HI6g/YNPM7XdH9A3Fig=;
        b=q+yrc7IFN9T3O4/yCGSj4DO2SDUMtIpZj46eBEyGGFZx24kROaGVwS/PVKJCFfNyqH
         /VP3+qPEDmgRnA6Iwu9cx1E1x/wzYsxVzvKc8iJEnIFDIDzCwNVFDjWgSkWfIkWYcHnu
         gZXMRURPhV3vXstsjqKggrow8cVE47ljCIlcj2N2AnuaItPNAHkkOXRKP5uFj+OtNq29
         hM7r0jLjYBsbWuSqr5ydN5Dfo+YxyRtmjikEan3CTlul1rfCE6bi5DlRKkIZDzfSJFW3
         y3exTOhT5XHkW5C7+ADRXbKQAxDrJQdMuoYfSZbKgcdlEYpeYXkUzEfajgdvDDcBgjpt
         3dkA==
X-Forwarded-Encrypted: i=1; AJvYcCW8wNdxHAwVZS+2SK65jafvrbhYgsK1nfPA7LHFfFPEM9JOKiPirNXq6fTI7Iv130TeOTpb5nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg8IV9SKrwpmKI45oK2lDqTUp4wlJaFhAugIaw3f6GkO5kCW9W
	wcbI+dIWvEoj8Ai4Y2/ClGvTVoJxxGoGaQzN+zIEw5ewsYTBzrEBegL8
X-Gm-Gg: ATEYQzxU2zxJeHVJLVh/cYZpgHpYYs9zligoTGrCGWsBNuNkx82mMprSka9YY472q2g
	Xsg2XuK+VTItxVP+oNFCflV/U1W2WTu4hpNa+Mz2pFGuhwBad6683ibAlJ0EGwWLJlA1sZGFez3
	BMRYMqn/6kbZmYSzDHZqBm3Gwm9fWIJoPKhueVCCOCbvLOGgy0SjkdbaEWG0JQTP2MGjXv3jiJz
	2Y6xrx6XQG0rY7zQSitcB5ZK7P73TbrNmu2BDz685EJjrbBZderMzHKMsU8F92JSEr/340xSJjn
	dq5Hoof6J3tNlcbbuN+4crg0Gr1s2pPtmS629Ru+7MAUw0+dm7fJ6FqMWoFjYDdPSg8mSYXQmaj
	CiY6ywS6w4QihFZaSae2w+7d8R/3lJdVxqJvUn8ciI2LIoFeiDdlZABgoUHliUx0B7MsqPlpv8B
	DBSQrNTmtLw5Lut/yDNJB/2eXHm5C9RlYgnw==
X-Received: by 2002:a05:6122:6311:b0:56c:d81a:5863 with SMTP id 71dfb90a1353d-56d21f7af6emr321071e0c.8.1774371971751;
        Tue, 24 Mar 2026 10:06:11 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6de:aa::11:17b])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136b4ac1fsm12420024241.3.2026.03.24.10.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 10:06:11 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: gupt21@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2] HID: mcp2221: validate report size in raw_event handler
Date: Tue, 24 Mar 2026 11:06:06 -0600
Message-ID: <20260324170606.5407-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324062403.341855-1-sebasjosue84@gmail.com>
References: <20260324062403.341855-1-sebasjosue84@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230200-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FCA0319D06
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



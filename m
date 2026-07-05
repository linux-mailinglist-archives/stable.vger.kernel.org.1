Return-Path: <stable+bounces-272041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ms7DJKJGSmodAwEAu9opvQ
	(envelope-from <stable+bounces-272041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 13:57:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC0A709E2C
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 13:57:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=zFBApqhf;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272041-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272041-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10C55300FED2
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258A937DAD0;
	Sun,  5 Jul 2026 11:56:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0337D11C
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 11:56:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783252615; cv=none; b=DaGFeW/FjRtnSehl1HVKaaBuWRQu3roHTTBk6r7tjUEHxnh6kGcpBGeIWpUP103c9dNuibeuWUAzGeotUK1OGYuHusVmCgCP5aY43nFAHe+tBUCzhq54MmjSqIcB31iSBqBqe0++aAShteFOZZ+LfeP3W416fY1jvbsGLioB7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783252615; c=relaxed/simple;
	bh=ZpBpDhRlBEf1wyNvaNZaS7fLIl4HOxR7G7oVZkBp3ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OjxArMoRGviGZKO74TzIdc+JY5dqzGK2bTJFjSH4hO2ZuVL5MrDYE6o9rFY15Onj3LGQKiZi+BQV73j884HKwW5es9BsPPaiMOMZDz7vLXX4l6T+EfhYWoXMJlmyy0ta9V5pnTtBiVx7hUboTq3ACmG2xoe9vR2QNjTZAHhQr/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=zFBApqhf; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso117486f8f.3
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 04:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783252613; x=1783857413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EV257GsPAdFkYYKujprEQlB3BUfGHubKEIdwYlwwzjs=;
        b=zFBApqhfcCUPdjzF3ejy7rU8jDn8uBJUg2ujxTYp5ImPFdGPvxgBocjuxZq1QTyTc0
         iH7pGknglUAt/Wuf3OSyaztolgF5P6EVxMVumXfLnS5KYgIbkzupKIXQZIVq4OjKAKee
         NThp8BQpdp9pT/JP2nmFrIGqI8JL34dSgoBPLrfk7h5tdrGsr4s8M0ddhUHVdxlTB5qx
         gMCugOYg53/Mvc6DUq3SJVEueKMpYj5oAzx+eMBB0ZxDBJLzLssNA+TL/jFPk8Ucn/mh
         7yqMcYydYaGpTvOWxXf0JPNf+t43/g8znsEf3cKSe4MDHRgxYilLdDxHHYgz1oIbdhTk
         JL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783252613; x=1783857413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV257GsPAdFkYYKujprEQlB3BUfGHubKEIdwYlwwzjs=;
        b=XXwpK1WVFRCPiqwVISse6Zt+lxZVPdYSxARAxxT8uFVOlEYWXfcPXn/06sGEIq69Jx
         1OPtliHJglsvwcGeLNAB0lP6RPltMhsTj13NdnHjqdggKvxSmtaJDk3QnhDbOBTcik/D
         yMqknW+YpXfBK3xtT6VzK+iJN4YPaD26Ab1gMKHnPgWHiHrqsWix41Ww+tFECWuankmt
         k5utrH1P7GqsTrd9uO0zB9mJGRtPVgIo55/L1UA2OSs+lW0QqbzDEmuN2iPuq8d9u14+
         bfnJR4DcspGh2Kz3fPEv03KV0h+cLCui1dLnRUFvByz5xFlGEfO5ciG7hZqX8n4DqH5z
         OxAA==
X-Forwarded-Encrypted: i=1; AHgh+RrUP/QzwhYMmuyeMC63ai2TMwnysd2OdWcz6Yq4XIcCoC3/vtpDSpwJa/62yUgMX7ralaOsouc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI0VbZslVYLWcWm024cQUtgRgO1+U0TCM6HchPctFxrKyc2H1c
	NRAjK5BBk2oKjuCl4bGPbkXMbL8sdBoOMGKehSM3q4nr5FwpxxEtoXgx0r72AJWhIwjB
X-Gm-Gg: AfdE7cnf3QdFW3uFfh4AfvCMlcDhF0hWSPXlmjZ+KNlpgviwwbAD08r54RSKQc8vzoe
	eX37G2/6AN1ra9UrKp8JMtyyCvccDjJag8I0bQaMlxLY5vZHypkTGasdzfSELi0kL02n6nt3Ne6
	GJCYmYpUxgenOXYBm3+ax+/pK9KsPQvk9DWFCg/8KNaHJwfB9A2sr04MaANfMYmuIZ9ZEDT+5DY
	4TAoVsrjj05VVzRh0fJCdjFmW2UuDo8mSHKUiEljmIUritkDZsfxE1c0JnC4emNM4gsl9FzjidK
	ewy71XODsBCJ+/zzSeq7zbGCrYeLeSvqPf3uNMkyIF7Nm/H0nstER9a+dqjr83nIG8Q7QWiMbUf
	bU9X/tG3mRJinwOoXqPakxfktN2rb2gIx360SsTp3TfHwxKZvBCFbwlOUeBfJRwe4mC7iwZ0YWl
	QfuU/XbbZr7/7muM5aqqKFVXOSAgW2bbtNdW5rT7HaHHPvv4ab9hGKotOXiMxVNFlgO4Q8zGVEA
	Sz26t7AZXyoHEhLTmyqLnkUpq4KqL0ykiZ9N2E/KA6dqQ==
X-Received: by 2002:a5d:5885:0:b0:45e:779a:302c with SMTP id ffacd0b85a97d-47aae2c5e12mr7467125f8f.29.1783252612919;
        Sun, 05 Jul 2026 04:56:52 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.219.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f2186bsm15364670f8f.36.2026.07.05.04.56.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 Jul 2026 04:56:52 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v1()
Date: Sun,  5 Jul 2026 13:56:50 +0200
Message-ID: <20260705115650.81724-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272041-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:luiz.dentz@gmail.com,m:marcel@holtmann.org,m:amitkumar.karwar@nxp.com,m:neeraj.sanjaykale@nxp.com,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:doruk@0sec.ai,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	DMARC_NA(0.00)[0sec.ai];
	FREEMAIL_TO(0.00)[gmail.com,holtmann.org,nxp.com];
	DKIM_TRACE(0.00)[0sec.ai:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0sec.ai:dkim,0sec.ai:mid,0sec.ai:from_mime,0sec.ai:url,0sec.ai:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBC0A709E2C

Commit 25c286d75821 ("Bluetooth: btnxpuart: Fix out-of-bounds firmware
read in nxp_recv_fw_req_v3()") bounded the v3 firmware download offset but
left an unbounded read in the v1 handler.

nxp_recv_fw_req_v1() advances a device-driven download offset
(fw_dnld_v1_offset) by fw_v1_sent_bytes on every request, and that
bookkeeping runs even when the payload write is skipped, so the offset can
walk past nxpdev->fw->size. When the controller then requests a header
(len == HDR_LEN), the driver reads the 16-byte bootloader header at

  nxp_get_data_len(nxpdev->fw->data + nxpdev->fw_dnld_v1_offset)

with no bound on the offset, reading past the end of the firmware image.
A malicious or malfunctioning NXP UART controller can drive this to read
out-of-bounds kernel memory during firmware download.

Bound the offset before the header read, and convert the payload write
guard to the overflow-safe form used by the v3 path (fw_dnld_v1_offset is
u32, so fw_dnld_v1_offset + len can wrap).

This was found by 0sec automated security-research tooling
(https://0sec.ai).

Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/bluetooth/btnxpuart.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 6a1cffe08d5f..88d9ebf25a8f 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1041,11 +1041,17 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 		 * and we need to re-send the previous header again.
 		 */
 		if (len == nxpdev->fw_v1_expected_len) {
-			if (len == HDR_LEN)
+			if (len == HDR_LEN) {
+				if (nxpdev->fw_dnld_v1_offset >= nxpdev->fw->size ||
+				    nxpdev->fw->size - nxpdev->fw_dnld_v1_offset < HDR_LEN) {
+					bt_dev_err(hdev, "FW request offset out of bounds");
+					goto free_skb;
+				}
 				nxpdev->fw_v1_expected_len = nxp_get_data_len(nxpdev->fw->data +
 									nxpdev->fw_dnld_v1_offset);
-			else
+			} else {
 				nxpdev->fw_v1_expected_len = HDR_LEN;
+			}
 		} else if (len == HDR_LEN) {
 			/* FW download out of sync. Send previous chunk again */
 			nxpdev->fw_dnld_v1_offset -= nxpdev->fw_v1_sent_bytes;
@@ -1053,7 +1059,8 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	}
 
-	if (nxpdev->fw_dnld_v1_offset + len <= nxpdev->fw->size)
+	if (nxpdev->fw_dnld_v1_offset < nxpdev->fw->size &&
+	    len <= nxpdev->fw->size - nxpdev->fw_dnld_v1_offset)
 		serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
 					nxpdev->fw_dnld_v1_offset, len);
 	nxpdev->fw_v1_sent_bytes = len;
-- 
2.43.0



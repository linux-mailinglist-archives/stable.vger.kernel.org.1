Return-Path: <stable+bounces-253896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCbdNlg2EWpeiwYAu9opvQ
	(envelope-from <stable+bounces-253896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:08:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E73A5BD38D
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1A633040693
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5771631F9BD;
	Sat, 23 May 2026 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJsLc4NI"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EBC3126CD
	for <stable@vger.kernel.org>; Sat, 23 May 2026 05:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512820; cv=none; b=O6q1x5P0hmTz3CNIPoNz/w77yHZqJWUYW6yPXxjQ6YL59ce7QQjVufciPcpUEpm8W8rSxwNrB1wr8w8QAHzpu00uAWHoSZnn4Q/dfPwUJEntdf+twOG3QnFokEesKUw8r1adLWRdwa0oaQudVzSxBjM2aWASDUfN8g0emanqb/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512820; c=relaxed/simple;
	bh=7msCFmmqPEC0bv111WI7CuSzpKcR42Z0vLrh7N3kgVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktDcO7wDTT+jv9Dl6bnsdOdXgs1InU5fK+YIvCdjwJmhZH/iVRur4YXsytm6yXp0jQ2HnNV6O+63mgHxcpBibnMj0U/6zCT8NDAGK3eeuV4HMod/VWEkGkL3MIdshjefd179mclcjy6zyfFFsNrOV6xJi4n6KIxnfcc3gu2gO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJsLc4NI; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30246cfd41aso1421432eec.1
        for <stable@vger.kernel.org>; Fri, 22 May 2026 22:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512817; x=1780117617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH+nSqGuHupA2MghGAqtpGS/yixxkoX328NYlBs9gE4=;
        b=TJsLc4NIZmqN4acmwvNaaYMe/VNS+TI9Z/8z3Y3MXsWodD/BaBjxrd1/rW3zXelImN
         rTJpVbXlQ9hrWjW8eAiUdaYDJXkSUeRNHKQtD5/aR9Zi36XbFa/UhiliPwcEcSpU7Dxk
         c4YGuY7oZDa01uXZL3od4GZhrBnnCB5gh/af6WTraHyfG1Qo9CVP0qtutSkJyBDJeVrh
         y2pbDwjpC0uaRO5hwEA4bbpyDBMfi0rle4HIUeAdkv5apRcMKZZ+PzIy12P5zolzqkfp
         F69QmE4fxCBgRmsIKy0UJDauUsonQF39VB6R/YiBY/hQNskIREF1fl+IPPlOjDHNsOex
         iBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512817; x=1780117617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TH+nSqGuHupA2MghGAqtpGS/yixxkoX328NYlBs9gE4=;
        b=kivdJiYe58NGD4fqsUVfy4y1ItlKYosKOMT7x7KzUyv6LFu9JD9Cx1DN4F4QsFL78D
         4y/tXUXGN70euJdrBV626ilcjMzptMG1S67w8oMSSB/dv/wa1MOhRfE+wY44Fp0uyze/
         k+ggEysSjw0/0GUKHWdpQxmm1bOfJ2Tm3/c/JKIJ915vSq/UsIuxgf3IMAHGKS9jQW16
         LvRqpQKki08MBjCVr4cTZM2qVdUcDTCVyvjrLVPXO2LfpKlRPfV9f6MYPSqJg9+JD1xK
         5lur4UPZb+yDAK/BYwXr8bf3DMK8CQKLZBcvWfJwSBlA3i8h96kbFiFmg06Fk7yAGpEt
         tvMg==
X-Forwarded-Encrypted: i=1; AFNElJ/vsIzSlylXosSkLkA9FALxWqBQO2m2Oujm1W9dRP+lbWtK3DWZhmBXW2goRyYz9wA9XPDdhRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVTUHzruxUI4NWywMVNIkFn3pBDxOLjDKdLyU1/EgPumulBHTc
	W3yiFRG+LWzDC7fJst2B8mUdoSH6Y8hkCeH3rwbOE2X7WzYfQis+brIh
X-Gm-Gg: Acq92OEEXT8VRKpHpTfqhHr/R+QqSlFgUV/kKKTi8KEIXfwaxk3bsuVtf9Ey8lEDnXx
	ncw7JjKvWxMYGdnGUqY6CdUBzdlOmKOvCQrYV0GHZi3T76rKfSFRTjxbG2pX+X+uTDK9KvrxFq+
	h99MHLe/JZrulcz8941BAMTnog7EXyMNwScYeeOrCkGZNZ5AukS0TAo0n44gdkY68UcRt1frdEJ
	gy6TIbBDw/dDlUf7Mjq74tgTk/y7JTFcMO3EgoZzZen7dyHw9ysLaiRhDzMXAk9YFnr+EAbvWpM
	0KIE37Fwo+XFhF/hICgVnCnoE+d7c0ZVu1KziVWQHXdLQbKHX/2MSshBmLJBnQLqOGpjh96bujD
	2nYDVHy47vOj4hppWZ7JIHPI1nnFVeCyBDANaQakkvwAvj0K8ntbRkgJdT8n+U0wF+mGIoEIHUe
	4KawPpu4fZzf3Rhi+RZ5KnkNXD5RaK7f498c5JHWc5N7k0+eB9Qhbna9+Opmxi/4hvJPH+qHkxg
	ocCB46097LJvQ==
X-Received: by 2002:a05:7300:818a:b0:2ed:e12:376e with SMTP id 5a478bee46e88-304491f21femr3174647eec.30.1779512817548;
        Fri, 22 May 2026 22:06:57 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:55 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 10/11] Input: ims-pcu - add response length checks
Date: Fri, 22 May 2026 22:06:28 -0700
Message-ID: <20260523050634.501509-10-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253896-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9E73A5BD38D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver processes response data from device buffers without verifying
that the device actually sent enough data. This can lead to
out-of-bounds reads or processing stale data.

Add checks for the expected response length before accessing the
buffers.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 53 +++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 3b119bc81c85..422b1be62303 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -406,7 +406,16 @@ static void ims_pcu_destroy_gamepad(struct ims_pcu *pcu)
 
 static void ims_pcu_report_events(struct ims_pcu *pcu)
 {
-	u32 data = get_unaligned_be32(&pcu->read_buf[3]);
+	u32 data;
+
+	/* 6-axis setting (1 byte) + button data + checksum */
+	if (pcu->read_pos < IMS_PCU_DATA_OFFSET + 1 + sizeof(data) + 1) {
+		dev_warn(pcu->dev, "Short buttons report: %d bytes\n",
+			 pcu->read_pos);
+		return;
+	}
+
+	data = get_unaligned_be32(&pcu->read_buf[IMS_PCU_DATA_OFFSET + 1]);
 
 	ims_pcu_buttons_report(pcu, data & ~IMS_PCU_GAMEPAD_MASK);
 	if (pcu->gamepad)
@@ -718,6 +727,12 @@ static int ims_pcu_get_info(struct ims_pcu *pcu)
 		return error;
 	}
 
+	if (pcu->cmd_buf_len < IMS_PCU_DATA_OFFSET + IMS_PCU_SET_INFO_SIZE + 1) {
+		dev_err(pcu->dev, "Short GET_INFO response: %d bytes\n",
+			pcu->cmd_buf_len);
+		return -EIO;
+	}
+
 	memcpy(pcu->part_number,
 	       &pcu->cmd_buf[IMS_PCU_INFO_PART_OFFSET],
 	       sizeof(pcu->part_number));
@@ -1283,6 +1298,12 @@ static int ims_pcu_read_ofn_config(struct ims_pcu *pcu, u8 addr, u8 *data)
 	if (error)
 		return error;
 
+	if (pcu->cmd_buf_len < OFN_REG_RESULT_OFFSET + 2 + 1) {
+		dev_err(pcu->dev, "Short OFN_GET_CONFIG response: %d bytes\n",
+			pcu->cmd_buf_len);
+		return -EIO;
+	}
+
 	result = (s16)get_unaligned_le16(pcu->cmd_buf + OFN_REG_RESULT_OFFSET);
 	if (result < 0)
 		return -EIO;
@@ -1843,6 +1864,12 @@ static int ims_pcu_get_device_info(struct ims_pcu *pcu)
 		return error;
 	}
 
+	if (pcu->cmd_buf_len < IMS_PCU_DATA_OFFSET + 6 + 1) {
+		dev_err(pcu->dev, "Short GET_FW_VERSION response: %d bytes\n",
+			pcu->cmd_buf_len);
+		return -EIO;
+	}
+
 	snprintf(pcu->fw_version, sizeof(pcu->fw_version),
 		 "%02d%02d%02d%02d.%c%c",
 		 pcu->cmd_buf[2], pcu->cmd_buf[3], pcu->cmd_buf[4], pcu->cmd_buf[5],
@@ -1855,6 +1882,12 @@ static int ims_pcu_get_device_info(struct ims_pcu *pcu)
 		return error;
 	}
 
+	if (pcu->cmd_buf_len < IMS_PCU_DATA_OFFSET + 6 + 1) {
+		dev_err(pcu->dev, "Short GET_BL_VERSION response: %d bytes\n",
+			pcu->cmd_buf_len);
+		return -EIO;
+	}
+
 	snprintf(pcu->bl_version, sizeof(pcu->bl_version),
 		 "%02d%02d%02d%02d.%c%c",
 		 pcu->cmd_buf[2], pcu->cmd_buf[3], pcu->cmd_buf[4], pcu->cmd_buf[5],
@@ -1867,6 +1900,12 @@ static int ims_pcu_get_device_info(struct ims_pcu *pcu)
 		return error;
 	}
 
+	if (pcu->cmd_buf_len < IMS_PCU_DATA_OFFSET + 1 + 1) {
+		dev_err(pcu->dev, "Short RESET_REASON response: %d bytes\n",
+			pcu->cmd_buf_len);
+		return -EIO;
+	}
+
 	snprintf(pcu->reset_reason, sizeof(pcu->reset_reason),
 		 "%02x", pcu->cmd_buf[IMS_PCU_DATA_OFFSET]);
 
@@ -1893,6 +1932,12 @@ static int ims_pcu_identify_type(struct ims_pcu *pcu, u8 *device_id)
 		return error;
 	}
 
+	if (pcu->cmd_buf_len < IMS_PCU_DATA_OFFSET + 1 + 1) {
+		dev_err(pcu->dev, "Short GET_DEVICE_ID response: %d bytes\n",
+			pcu->cmd_buf_len);
+		return -EIO;
+	}
+
 	*device_id = pcu->cmd_buf[IMS_PCU_DATA_OFFSET];
 	dev_dbg(pcu->dev, "Detected device ID: %d\n", *device_id);
 
@@ -1984,6 +2029,12 @@ static int ims_pcu_init_bootloader_mode(struct ims_pcu *pcu)
 		return error;
 	}
 
+	if (pcu->cmd_buf_len < IMS_PCU_DATA_OFFSET + 15 + 4 + 1) {
+		dev_err(pcu->dev, "Short QUERY_DEVICE response: %d bytes\n",
+			pcu->cmd_buf_len);
+		return -EIO;
+	}
+
 	pcu->fw_start_addr =
 		get_unaligned_le32(&pcu->cmd_buf[IMS_PCU_DATA_OFFSET + 11]);
 	pcu->fw_end_addr =
-- 
2.54.0.746.g67dd491aae-goog



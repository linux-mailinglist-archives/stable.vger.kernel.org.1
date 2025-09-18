Return-Path: <stable+bounces-174665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B8FB36457
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D41F1BA4699
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB1D321457;
	Tue, 26 Aug 2025 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xaE9pkbA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B5F33A010;
	Tue, 26 Aug 2025 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214993; cv=none; b=AimjnmbDKenA2J9+aJHnsD24o74CqB2o3PZpUUaDxEWAQiKdW+euKAZnGFcNILUtphe+1Cjrzj6OioaAQgth0z6FQEhOPR2+pQ8Eagn3USE82/jl5OA0dU0IUCJof9xCSdZ7PNwd33aLw8LeMtb+0/OqMnhivjR5KyjEgqMspBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214993; c=relaxed/simple;
	bh=JeXRW9IHqmQ5IPSBqAWXSyLaWrDIcQ4dcSEG5rS/+xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmfTh6xkCL+8f7ZCWBtFggmE/m7+VF523gHN8YfhCa6FIxlJDl/5EgWu0k/3ZNZHFJ2qDBBBrHBHZl5gfjnGfMwB1B1K/L5nQkdF2Fx4GclmZI3z0wFcSbIci6iZnwGhMmbFQwVj+0ew6ODoeErG0U5+lNKUQcCjcFRrLZPNUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xaE9pkbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F6DC16AAE;
	Tue, 26 Aug 2025 13:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214992;
	bh=JeXRW9IHqmQ5IPSBqAWXSyLaWrDIcQ4dcSEG5rS/+xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xaE9pkbAzKrNypXvTih/PMd9J1ihYEDvRNAZPCZrgXJduAz7cK7xEXPZIDfz/q2nM
	 rfph7tZ99i1ycAIDDoRrf0Hu4SKFEBkfO+VCXtpLILfPTOh9+TCUaWJbnXMT+xbcV1
	 zZdY5xdkzmzWEYjscLf4mXph9ZACmnt9ZU97GnSI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.1 319/482] media: gspca: Add bounds checking to firmware parser
Date: Tue, 26 Aug 2025 13:09:32 +0200
Message-ID: <20250826110938.688634714@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

commit aef89c0b2417da79cb2062a95476288f9f203ab0 upstream.

This sd_init() function reads the firmware.  The firmware data holds a
series of records and the function reads each record and sends the data
to the device.  The request_ihex_firmware() function
calls ihex_validate_fw() which ensures that the total length of all the
records won't read out of bounds of the fw->data[].

However, a potential issue is if there is a single very large
record (larger than PAGE_SIZE) and that would result in memory
corruption.  Generally we trust the firmware, but it's always better to
double check.

Fixes: 49b61ec9b5af ("[media] gspca: Add new vicam subdriver")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/gspca/vicam.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/media/usb/gspca/vicam.c
+++ b/drivers/media/usb/gspca/vicam.c
@@ -227,6 +227,7 @@ static int sd_init(struct gspca_dev *gsp
 	const struct ihex_binrec *rec;
 	const struct firmware *fw;
 	u8 *firmware_buf;
+	int len;
 
 	ret = request_ihex_firmware(&fw, VICAM_FIRMWARE,
 				    &gspca_dev->dev->dev);
@@ -241,9 +242,14 @@ static int sd_init(struct gspca_dev *gsp
 		goto exit;
 	}
 	for (rec = (void *)fw->data; rec; rec = ihex_next_binrec(rec)) {
-		memcpy(firmware_buf, rec->data, be16_to_cpu(rec->len));
+		len = be16_to_cpu(rec->len);
+		if (len > PAGE_SIZE) {
+			ret = -EINVAL;
+			break;
+		}
+		memcpy(firmware_buf, rec->data, len);
 		ret = vicam_control_msg(gspca_dev, 0xff, 0, 0, firmware_buf,
-					be16_to_cpu(rec->len));
+					len);
 		if (ret < 0)
 			break;
 	}




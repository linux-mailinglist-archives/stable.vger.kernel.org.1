Return-Path: <stable+bounces-136779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 897BEA9E072
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 09:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE8717EA0C
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 07:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100A41DE2CF;
	Sun, 27 Apr 2025 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwQqVh78"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E1D2459F0;
	Sun, 27 Apr 2025 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745739053; cv=none; b=aoQ1rCIIk0MU3ZMav+UByx3Zsa1CQQgndYOyfJGrV7FezbSg6vmWxo/+ZuxY4c/XE2TkJjpGvItJthFbgiG2HLSNBzto6zCtFEC8CuClnkdSV87M3ed1b22Dc5gqeG0KOyZRYMYq1pveYx05rVuWIjIqUpKsdg/dNCey6jMAsak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745739053; c=relaxed/simple;
	bh=uzVjkm7xuS851VrFWNmL0auSaJTNbIuq8hK/utJoN/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cm5S71zZHK1olm4sZYXsed7l6yQ27e3tsydkDSTAjunTLTyho6pdsaWndrJ87Z8vDOs/9VA0cTbq5VKg/Q+93Qf3L/2XewK9Jzb63KGqpJRCOJRCPWykZhPbBNzuiXzMJzEJsS+Iolbh1tLUKzLe21dkIXasTof5OWROgv/zP+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwQqVh78; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso16373575e9.3;
        Sun, 27 Apr 2025 00:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745739050; x=1746343850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzt4aSgxAuWrJytcX/gjPBd3APIFdgE8OTpFBrBgGjo=;
        b=VwQqVh78m6RR7Obqp4EY0lcR/qZjFAQSeRtgCFu8nka4ZlaYp5mY/dAliHdWVXeHLd
         Fz1pugk/I7eN/b2PvwT5ltSo8m6MyLEoTrfQkNXB32LbQfSCdjXJ2JZ36bSvuPAmYO/G
         5fGmsCMl037ZQiP3sapU1RQXIIyY56+XPDkZhzcsrZ1Xqbc/Hb7jV212tlqHe2i6lYXf
         ivMei8UCW7GQSvxGXan1DqixFCWHKGsGQdlDEtEW8czBAEgDBsMUzQ5UwlLgx6j5T8xs
         h5HNUZ3i98Ngwe14wTzBmTjvUj/BLZOhzfJ4L1erKVswiMzWQUeKDzYnykdqBN9pZSuW
         iLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745739050; x=1746343850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzt4aSgxAuWrJytcX/gjPBd3APIFdgE8OTpFBrBgGjo=;
        b=nmpJ6gvnLLpfRXG3uKv91dYkgllhhE0fjSMuoDUv71bexFM2vzVubv6Aiz5F8qJESd
         lU/U7a7MHv/u4m7OHuYcDkJ0wL61YWw3XFzKwjIoQLikVzc4l7DhX/zhXRM31EBPa3vP
         9rE2ivtcEZD9kZRV0XZES4+HIp2yCsH2qo9EwsBx2rn6GlwTqq4KPGt35ZK0hI1cIkER
         USR05cOT+Jjv68AzAY/awUUd6zI8z9FHXrp87mkwoSIcoXxIwg9TK7lIW3rZ8LfCmS0x
         KEO/cY7gcEELGGoLpZJtYtqdOT8W9Ud8nSWDpzjl/LR4KHr9f+nkmw0MEy9VppZVVGoJ
         ichA==
X-Forwarded-Encrypted: i=1; AJvYcCVfV9N0ge1GwmHJKHxn6LYWjS6+KS0d9a6SqMTei9TNuXEv8vnJ5aLofOADqL97peGdHYh6ysf2@vger.kernel.org, AJvYcCWEaxiS/4CDqrnBHeXjOZnFtm/1aNZ1MErTrJTi3nOKWSiRbuuKmYwmDW82xHKrDdWxGeu9bIQRdac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPBO0TZFtIulic8vvCMmL/2AI9zLwfZ6Ja/Mzss2yyhkLCSgz4
	zf8A+df7Xqp4GWLJcd1knPs714hoOQrxSryFBbLdrnlUWrdlFisi
X-Gm-Gg: ASbGncvHG7O/gt8nr9KEA+/eU02phMoTzLVTNIBTOCrWH8Tw4qj7WgqbgbRwBDH5jrn
	2ms7nGExgk/I/JBJzvWXjT09mslBCd9yMItovJhj08oKZxJ400pdQpeGCAB5oPJePTFl1b4l2Qg
	TSP++a0AFJmvsR7iXMApDkC9Wv6kCv/VDidEWrAx1A/tEw2gow2uKCH9X3gOfQs9m3Y8pv7+A4x
	q2FfxJ008UTYFTK/lbRKLRqbrvDXaqKVWJAz0q3g2/W/1jb4V8RnOApFoxZ14DPW3A9lp4MuOhn
	ci0YT0O0SHTwcZVo2GV8nYRdisioLyN6gJe50rRNDOokc+Kvur6dKDRHymijW92pRgBDu0QeHJE
	u
X-Google-Smtp-Source: AGHT+IFGIj4SyOW93HmptYHTXMCgPsTVJ1spoXKh8WcrgQXDedBpI8Zjc5j/BSd2cbwiVs8eBQuqUw==
X-Received: by 2002:a05:600c:1e8d:b0:43c:f597:d584 with SMTP id 5b1f17b1804b1-440ab872053mr38535405e9.29.1745739050206;
        Sun, 27 Apr 2025 00:30:50 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a531072csm83924145e9.18.2025.04.27.00.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 00:30:49 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: guido.kiener@rohde-schwarz.com,
	stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 3/3 V2] usb: usbtmc: Fix erroneous generic_read ioctl return
Date: Sun, 27 Apr 2025 09:30:15 +0200
Message-ID: <20250427073015.25950-4-dpenkler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250427073015.25950-1-dpenkler@gmail.com>
References: <20250427073015.25950-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wait_event_interruptible_timeout returns a long
The return value was being assigned to an int causing an integer overflow
when the remaining jiffies > INT_MAX which resulted in random error
returns.

Use a long return value, converting to the int ioctl return only on error.

Fixes: bb99794a4792 ("usb: usbtmc: Add ioctl for vendor specific read")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
Change V1 -> V2
  Acc cc to stable line

 drivers/usb/class/usbtmc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index b3ca89b0dab7..025a7aa795e3 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -833,6 +833,7 @@ static ssize_t usbtmc_generic_read(struct usbtmc_file_data *file_data,
 	unsigned long expire;
 	int bufcount = 1;
 	int again = 0;
+	long wait_rv;
 
 	/* mutex already locked */
 
@@ -945,19 +946,24 @@ static ssize_t usbtmc_generic_read(struct usbtmc_file_data *file_data,
 		if (!(flags & USBTMC_FLAG_ASYNC)) {
 			dev_dbg(dev, "%s: before wait time %lu\n",
 				__func__, expire);
-			retval = wait_event_interruptible_timeout(
+			wait_rv = wait_event_interruptible_timeout(
 				file_data->wait_bulk_in,
 				usbtmc_do_transfer(file_data),
 				expire);
 
-			dev_dbg(dev, "%s: wait returned %d\n",
-				__func__, retval);
+			dev_dbg(dev, "%s: wait returned %ld\n",
+				__func__, wait_rv);
+
+			if (wait_rv < 0) {
+				retval = wait_rv;
+				goto error;
+			}
 
-			if (retval <= 0) {
-				if (retval == 0)
-					retval = -ETIMEDOUT;
+			if (wait_rv == 0) {
+				retval = -ETIMEDOUT;
 				goto error;
 			}
+
 		}
 
 		urb = usb_get_from_anchor(&file_data->in_anchor);
-- 
2.49.0



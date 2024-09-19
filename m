Return-Path: <stable+bounces-76749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E3397C803
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 12:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890E91C24B0D
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 10:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF3719994D;
	Thu, 19 Sep 2024 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX76XeTl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4D93C0C;
	Thu, 19 Sep 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742053; cv=none; b=B5KhFfzBxUCru3S3xgC6t+ne72Z2isOj3Hun1fCBZIl06GVE+jIJvLaJgVXTfR9eRaAmh2BF6EaJdmJuKW7QmFGxN/oMCVfypo4+a+4f4AG6O070fIrfEyGpIxB8VP1TdqSc+Z+LGQ5u2kGpsdCuuKvsOaFtgj8cfOognr2Pnps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742053; c=relaxed/simple;
	bh=kLNoi9PeYfT8beehybcUvKc+rFcI1JgvN9vyNUUyUyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dWhhqGzFEctEqH/9jNnYZRjOZxuiaVmhRclCf8n+B/AQm7GJ2udAW8jvS9lyBLsp0x2yls3DhNSPhPfKnx0qCi/VHGj/+lZn9+gq0vxHDSLkowkbUA1uBx61BUopsKCyWXXGWh46k2Y9ibMEpG1yOo/6V0Az2D3Q6JSuay5FShI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QX76XeTl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7197970e2aeso464229b3a.2;
        Thu, 19 Sep 2024 03:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726742051; x=1727346851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W8PsRMOFT2KRjjX91OQvWnXM7VKXooK07fcRHIqQtSE=;
        b=QX76XeTl8luepMGHle+bjUkiPVWGBsoa4ZHyi9ClCf1CCLyQ/hhk4+sZuawl8gMz8r
         MrMioKEGWbfcuyh/KIyxCIuGrLJ5NI8LRKOqZQEBe8+sOXo5Wm2PdFxKU2OFKNj7b7eN
         nN9SklhI3c6cQ17NqQNVC6WuWMF6hrpwFfJMgiZo+Plh0NBiY9PTRJ52glME7A5muMEb
         Gda068HhAUXp4BY7TiP95eUnIlI23I6ht781dufwo9P/+M+Jq1CSmZMMZr8PeGzdSpDt
         1jM7Wc611K5JBnRJgNdjhrR1cHpK4+pOjNvGcwZnbdx3GJ5I4yGvOwCZ6DYHPm3gRJac
         bbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726742051; x=1727346851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8PsRMOFT2KRjjX91OQvWnXM7VKXooK07fcRHIqQtSE=;
        b=YHA4Q0e/7WVr9bP3jjjF4sDrioHToezUSHUkslRnj9kab0L76KWP3DZr3iEh9PX6Wh
         2ERCIIrKo0G/6E7ZvvmVlbBqvU5EkRXhIat4bggKnzJOLmbZ2ftS2P6FxfSCdcMa+M8o
         QBfxRCYf7vKP915OGT+KPECsk3IUI6hzm13VWxd7GhRLPI4hQnKHhxEvbWaEc2Lni2BG
         rpbW0u3hilQhYaxH2P4uxxpxioHxLVgRUQjG3EGrvupB/lmm0qUG+joGU9w0mrH2Onkg
         iMy1jyhR6UAuj/+cz+8ZFnWw+eZGonot/vitkmQnODg7F0lxxEqgk+qCHEUwCJ3lvCZ9
         E6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWQu/zxzMosoFwV07zkF5PSprQC9U0ufLz9KdFxsRAtA0G3q/eHeJiwTgAJwdvRkp+6748KAyMd@vger.kernel.org, AJvYcCWrhq0qcu4X5cmDL/iRQ8Bc359U1JRSitICZtUjQzuukmlnxCVTJujimi25Nw9FdB+pvDJVrD7Pi6L+@vger.kernel.org, AJvYcCXRfz0elGew7Rs42iU4iOqYZzCKPElrQetzPymId59IyOCwUS0mAjrzBAdpdjtv4EkIsUecCzh7fvvcDg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgg+Ih7r0OYqb/GR3f8IXmVvUXu6S4f8Ziq5W7+z1ggF758Mpp
	jRzaVnHlB3A4E34VGgaO7vdLry6kM71XJpzzefJvfdtjEhGFHAWXBfL5HWVo
X-Google-Smtp-Source: AGHT+IGHhX6h39WMZEkbI3vczVhHJZCNIaMGh+VTghScqUJK0x1mKw8GfMHsZqmKh4/8QMee0cHr4A==
X-Received: by 2002:a05:6a21:58b:b0:1d2:f0e2:4ad6 with SMTP id adf61e73a8af0-1d2f0e24f38mr7613958637.18.1726742050729;
        Thu, 19 Sep 2024 03:34:10 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b9ad0esm8232597b3a.175.2024.09.19.03.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 03:34:10 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: gregkh@linuxfoundation.org,
	oneukum@suse.com
Cc: colin.i.king@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v2] usb: using mutex lock and supporting O_NONBLOCK flag in iowarrior_read()
Date: Thu, 19 Sep 2024 19:34:03 +0900
Message-Id: <20240919103403.3986-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iowarrior_read() uses the iowarrior dev structure, but does not use any 
lock on the structure. This can cause various bugs including data-races,
so it is more appropriate to use a mutex lock to safely protect the 
iowarrior dev structure. When using a mutex lock, you should split the
branch to prevent blocking when the O_NONBLOCK flag is set.

In addition, it is unnecessary to check for NULL on the iowarrior dev 
structure obtained by reading file->private_data. Therefore, it is 
better to remove the check.

Cc: stable@vger.kernel.org
Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
v1 -> v2: Added cc tag and change log

 drivers/usb/misc/iowarrior.c | 46 ++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 6d28467ce352..a513766b4985 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -277,28 +277,45 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
 	struct iowarrior *dev;
 	int read_idx;
 	int offset;
+	int retval;
 
 	dev = file->private_data;
 
+	if (file->f_flags & O_NONBLOCK) {
+		retval = mutex_trylock(&dev->mutex);
+		if (!retval)
+			return -EAGAIN;
+	} else {
+		retval = mutex_lock_interruptible(&dev->mutex);
+		if (retval)
+			return -ERESTARTSYS;
+	}
+
 	/* verify that the device wasn't unplugged */
-	if (!dev || !dev->present)
-		return -ENODEV;
+	if (!dev->present) {
+		retval = -ENODEV;
+		goto exit;
+	}
 
 	dev_dbg(&dev->interface->dev, "minor %d, count = %zd\n",
 		dev->minor, count);
 
 	/* read count must be packet size (+ time stamp) */
 	if ((count != dev->report_size)
-	    && (count != (dev->report_size + 1)))
-		return -EINVAL;
+	    && (count != (dev->report_size + 1))) {
+		retval = -EINVAL;
+		goto exit;
+	}
 
 	/* repeat until no buffer overrun in callback handler occur */
 	do {
 		atomic_set(&dev->overflow_flag, 0);
 		if ((read_idx = read_index(dev)) == -1) {
 			/* queue empty */
-			if (file->f_flags & O_NONBLOCK)
-				return -EAGAIN;
+			if (file->f_flags & O_NONBLOCK) {
+				retval = -EAGAIN;
+				goto exit;
+			}
 			else {
 				//next line will return when there is either new data, or the device is unplugged
 				int r = wait_event_interruptible(dev->read_wait,
@@ -309,28 +326,37 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
 								  -1));
 				if (r) {
 					//we were interrupted by a signal
-					return -ERESTART;
+					retval = -ERESTART;
+					goto exit;
 				}
 				if (!dev->present) {
 					//The device was unplugged
-					return -ENODEV;
+					retval = -ENODEV;
+					goto exit;
 				}
 				if (read_idx == -1) {
 					// Can this happen ???
-					return 0;
+					retval = 0;
+					goto exit;
 				}
 			}
 		}
 
 		offset = read_idx * (dev->report_size + 1);
 		if (copy_to_user(buffer, dev->read_queue + offset, count)) {
-			return -EFAULT;
+			retval = -EFAULT;
+			goto exit;
 		}
 	} while (atomic_read(&dev->overflow_flag));
 
 	read_idx = ++read_idx == MAX_INTERRUPT_BUFFER ? 0 : read_idx;
 	atomic_set(&dev->read_idx, read_idx);
+	mutex_unlock(&dev->mutex);
 	return count;
+
+exit:
+	mutex_unlock(&dev->mutex);
+	return retval;
 }
 
 /*
--


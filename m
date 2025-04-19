Return-Path: <stable+bounces-134660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FE9A9409F
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 02:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E151B64988
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 00:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E95B1EEE9;
	Sat, 19 Apr 2025 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA+hgkZQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E1DBE4E;
	Sat, 19 Apr 2025 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745023394; cv=none; b=JcG/V8AY9GA9LW/LZn0Rm4yBQkEpbywT7KniMw9nIc/3cyjcE0E7IU1uVME1f5vEI7H9CK77C256U1bSEGj0APTJtDKlp7mqEQaUPCbpxRSejBPy1bapuTAHK9VyW21UqtrjgPl2k48dYI4vpvfQnlwjgT6SmGf9hh17ImJclA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745023394; c=relaxed/simple;
	bh=6lP0By7w/Dlk8nj5HMF+C4qxFyOplJyRe2gXUWgOqR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ebY82AUlL+wh6fRKSS6JBtzOr98QTm3eVMZbgLo1aZ80QQTiPJXun9iZqUod1PTURv5nEvATDjR3+denFRu0hjlF8EpVUPrIMTgStVf/4UCHDoCi8NGNa7i5UhlCmcCxg+EypnFCx5aH9XKXzl79by09we2Rou1Pejm6a2T/15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MA+hgkZQ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c55b53a459so221813685a.3;
        Fri, 18 Apr 2025 17:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745023391; x=1745628191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L1r3+y8b+nuSF4vGtYpP5A0uMCQW+2A3VFWO1Lw+t7M=;
        b=MA+hgkZQLZM5eQlTfPZbkvOpw0HargwnMBK+jtMYrIOvAeeJx5el+pYON/hd3wgytd
         QYAGzajjm4I9lxtMK9gKkBsllcIMoqK9kDVnr6wuz+prKKsXIL4r3MImOOVpX6wfwPc6
         gCH3DJlJ1jKQhtzw6OOFg4WHc0PNi0pkF3cKSmYaEu6Rt2PhKc9DKMTeg+xdAWRtclKo
         PYpLpqi2ttD2MUz3BMHoF97N2M6v6gF+jWObpo5J4fcYj5gWguz1p2tqlHrotd1eJ8UR
         jXTjHce5AgjSgYUQ+CDhc9q1U4bXdeaXRwsdN4EFEGQz57swsqtG1jeYqZKFaek5dzmN
         X4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745023391; x=1745628191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1r3+y8b+nuSF4vGtYpP5A0uMCQW+2A3VFWO1Lw+t7M=;
        b=HUajwadARhYK6mOLvEDgDxHXm27uyMiuxU/bwqCw7QXjBUUWt38aJbmLQhbrqJFGgM
         GPt692q8ud4KgK8UoqWMdE9J7tWpHrueI9oA9T4igaX7tVZ/0Uty58fTxAgpMDel/2EI
         KW8/A/+Jz0fNsraQ6ggvLEX1sHCrBaAaWHZxdNDndEPfnEaRJZ7vrrVZt3frdGks7m5f
         FCScIL0bcJqm0tsIv/60Sgb1DUQg9P3PAbufHrXJjU/ylAKVhVb8crSJ4E6EVJC8dXHk
         QLltrV+bEbOWasv8bmjF9GDlftobQx3Kdivq125LV7S13meNVRg6aZ1u8R821jx2ot+W
         he5A==
X-Forwarded-Encrypted: i=1; AJvYcCWHst5z6D74Ee973xf5hZSOlBsj5oQ9vZbpMiDTMASfbOAN+6ADjsmDuQibDhQndDSaoKNuUEbE@vger.kernel.org, AJvYcCXuXhxTa3d8DJkPZS7xfd7RTVSsgjRHOiunSCi7IlqIS0RSiXg/L4MtpPMEmLoLa2LsPySGTnsNo2dsims=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUawbRLjPbUavlGs2UIAomrXfOWbG5gCx92jVwzai5onfWHZ1E
	2xwZqHcDW7sfpabdafUaFXvTW22LXikAu3NpvXg6iNgjVUtqu6St
X-Gm-Gg: ASbGncsXW/0hkcrSSJtgz1I1+GsjE4w3Fo//jXxO2xifkjLoOS9ZgIofW9se4R9Gt3r
	PxTA+/5xn5aha9m2i8z1mZF5g6igXsADdu0ohD3pBjFFGTE1XKFeBZTNlfo05eptjYIEYq1xXu1
	a8UJnadFHfjLar1xF2g5wFUGriYh57lmqrq4FogbUEJjohlAonw0MgN4zh6vUb7J0zExafYkBY+
	I6D3mDCo4V4klEB6MV5eYhcD9DE14rMeSD7Yh0vmYHVnbDzljjLw7IrEA7qYFbIcSotwDq6JO3O
	S7utsYLvgZLH93o/pxivG0h/5AJsK486agfgpi6okOkaOLFffzrFFIFkdykWxWsHjpyOlbQsiVJ
	kpLZYu1Gzp2i7vnu8vUc=
X-Google-Smtp-Source: AGHT+IGlBaemLK0d9uZwZRCVUJpbqZBnnm+N+gmJMRn4W1fr/ExrH60LjkWVgPqgTD+FVqHKyXvqyw==
X-Received: by 2002:a05:620a:240c:b0:7c5:a513:1fd2 with SMTP id af79cd13be357-7c927f59459mr683764685a.6.1745023391213;
        Fri, 18 Apr 2025 17:43:11 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b69d0asm160284085a.99.2025.04.18.17.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 17:43:10 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	gshahrouzi@gmail.com,
	jacobsfeder@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	sergio.paracuellos@gmail.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] axis-fifo:  Remove hardware resets for user errors
Date: Fri, 18 Apr 2025 20:43:06 -0400
Message-ID: <20250419004306.669605-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The axis-fifo driver performs a full hardware reset (via
reset_ip_core()) in several error paths within the read and write
functions. This reset flushes both TX and RX FIFOs and resets the
AXI-Stream links.

Allow the user to handle the error without causing hardware disruption
or data loss in other FIFO paths.

Fixes: 4a965c5f89de ("staging: add driver for Xilinx AXI-Stream FIFO v4.1 IP core")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 7540c20090c78..76db29e4d2828 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -393,16 +393,14 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 
 	bytes_available = ioread32(fifo->base_addr + XLLF_RLR_OFFSET);
 	if (!bytes_available) {
-		dev_err(fifo->dt_device, "received a packet of length 0 - fifo core will be reset\n");
-		reset_ip_core(fifo);
+		dev_err(fifo->dt_device, "received a packet of length 0\n");
 		ret = -EIO;
 		goto end_unlock;
 	}
 
 	if (bytes_available > len) {
-		dev_err(fifo->dt_device, "user read buffer too small (available bytes=%zu user buffer bytes=%zu) - fifo core will be reset\n",
+		dev_err(fifo->dt_device, "user read buffer too small (available bytes=%zu user buffer bytes=%zu)\n",
 			bytes_available, len);
-		reset_ip_core(fifo);
 		ret = -EINVAL;
 		goto end_unlock;
 	}
@@ -411,8 +409,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		/* this probably can't happen unless IP
 		 * registers were previously mishandled
 		 */
-		dev_err(fifo->dt_device, "received a packet that isn't word-aligned - fifo core will be reset\n");
-		reset_ip_core(fifo);
+		dev_err(fifo->dt_device, "received a packet that isn't word-aligned\n");
 		ret = -EIO;
 		goto end_unlock;
 	}
@@ -433,7 +430,6 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 
 		if (copy_to_user(buf + copied * sizeof(u32), tmp_buf,
 				 copy * sizeof(u32))) {
-			reset_ip_core(fifo);
 			ret = -EFAULT;
 			goto end_unlock;
 		}
@@ -542,7 +538,6 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 
 		if (copy_from_user(tmp_buf, buf + copied * sizeof(u32),
 				   copy * sizeof(u32))) {
-			reset_ip_core(fifo);
 			ret = -EFAULT;
 			goto end_unlock;
 		}
-- 
2.43.0



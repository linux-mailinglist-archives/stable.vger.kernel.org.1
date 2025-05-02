Return-Path: <stable+bounces-139452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39696AA6B5A
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 09:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D4D462214
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 07:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5092676E9;
	Fri,  2 May 2025 07:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN2LMMS5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5C52676E6;
	Fri,  2 May 2025 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746169792; cv=none; b=LF+tMXEBAWScfQGc8ZGUOpT2x7Qgez6jnFCIOn7r8qCzOXyXI9nDMr3vEyZk7iEVay8FcMxvcJN9wzOOSo/S/N9Czbh/D3At74jnAlWL2fYb0+lEhluzwhNTgfWSe2KQhSD5MPwlDKIcW4gJVehBX3ToZ3BVpudRpRBT8PJ8Qek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746169792; c=relaxed/simple;
	bh=Xs8Fk7NsM7tIMnlQLra7COF0M+LwbFvlMNaKkvTfWYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxTjNDcPxyaBm0hwq82dGbsBU6bek0VLRkRSaneDdWKUQeaOp/+/hV2dDhFZxxkNYuyDzBLIVM0spWOWHj2afGC3BFyF0pV/XZoEVKBR0lRuFMgio+2zuZzM1xgVnGM6c1XQ4XkT2fOETa1ufTebBX4B+Cy3wlOzfguc1Ushfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN2LMMS5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so2514759a12.2;
        Fri, 02 May 2025 00:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746169788; x=1746774588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he0PjLi0f/fa9kPWWLvSTfkZuLEj/6CyEwfwOCJhSIU=;
        b=gN2LMMS5nu6CoxKsp47eMZMfiVjtZdX81Q5UFmOXDHUedHAWjB273N5xh+nzZWfrq8
         rgXe/mCimpPjHTISgS/qqMgN2WiL7sV8w0IQQI1ieGeqn3OFpvFlDbZo1JGLqH698oQf
         BRPsI7H78hYL9mcbs/LNfFUcJTbAX/zctf0tXwQ/2bKhVDUu2Pm8VzJTkkMgBQVORS7N
         pe2F8cW2EgtmHegHN7b9d30dSLyX/f+dPKwQhmjEeBE9zjkIVQp0iQQB2p8hdFlvzVUP
         K3lBbK69G5vPHkvOl0333FPRjL803XHmeiwU6fuMEgd68/vwHNXbKEfiCcz114SLC22Y
         caQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746169788; x=1746774588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he0PjLi0f/fa9kPWWLvSTfkZuLEj/6CyEwfwOCJhSIU=;
        b=aEdvaMo4cXWq9c9IhzsVIVEf6FtYvF9bdqn9P4Wjhw08DDXzIYmvO21Eg+Lqhp5yrP
         6Dd3hhEZllIjOhCy94eNESoQKyiZSlpdohSnlBpuGT2RUXmxh//QniU1X8EMn/gQ8P/u
         d0Y0uNyaKW9jfGoCAGDieqRYMj1QVO7AZUbYZidw+3QLnH0NNGW8Iu9CJU5NzNmXnvHs
         Tnitl7e3AnLTAc7LTt6ncfEkqT7HrOX55W0E6yjTtChVy2Lv0DYF7K2g8ewuDSbPriDL
         TXZNZs0Nk2AHy0l4g5kr7YFNNrj6Bxmd37/dAlnf2Tk4JubTnwv4Ra4ysm67fnpkCfqG
         C6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+/pVHD1IibXhGIylb/qh85hhcJAny2oKQgKWeyEURatL6tXor0F5iV2I5z9MvJEtWDTk3M0nDfPQ=@vger.kernel.org, AJvYcCVhfEKiIO6zu73RS03YT7P5kYnzL+jNaoC3R90RhX/KDaxeLmHSdyfdXUXhIf/Ulrkw9CkG8qiU@vger.kernel.org
X-Gm-Message-State: AOJu0YyPKj0N4wx1fSGJXljC6yq4HsC273zMX9CQ73St9xh8l/kobvju
	4FCs59+Bj9Kya4oiQ1FSUUBj0t1DLdiyh8eqm9T3Cdmxb0wBTylC
X-Gm-Gg: ASbGncvGXydw2Z46nBC88Kf+P7E5WDG2leKGFA3FUIOfEWEnFJ6Psg8nlgv3R7IKcX8
	g0iHBE3QvKy1iA9PlmzG6LDkVGpbZhlmPhIdNtQ+r2tqViilYLonf6Gq4khGH+MY7mOKXO1DuKl
	xixLsV/+MEar52gWBpP3v3Unoc61YFGx8h8Kqfs84zpl+zsOe7zkmqBckVGXmd4zGl7/wDglHhJ
	mPyCBJ4oto1CqYIjGTPNTKZ9ksZqtW8rKTCoWjHC8q/uHI5nLto2IifeIa24sb/3khbvRuPGVQX
	zzYK4B4YfprX/SdKGCbZxJGz/NBRMpThCBPAtDFl5TBMss5Echg=
X-Google-Smtp-Source: AGHT+IEfPbN7VawBj2HeP2QF+fXs/yng0btJZHnVv5B8noHYrBvKdbLGp8wGJ8dEa4/OhcJkjox6AQ==
X-Received: by 2002:a05:6402:510d:b0:5f8:6460:7e38 with SMTP id 4fb4d7f45d1cf-5fa78005c21mr1371307a12.11.1746169788289;
        Fri, 02 May 2025 00:09:48 -0700 (PDT)
Received: from localhost.localdomain ([178.25.124.12])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77bf3ec0sm753513a12.79.2025.05.02.00.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 00:09:47 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: guido.kiener@rohde-schwarz.com,
	stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>,
	Michael Katzmann <vk2bea@gmail.com>
Subject: [PATCH 1/3 V3] usb: usbtmc: Fix erroneous get_stb ioctl error returns
Date: Fri,  2 May 2025 09:09:39 +0200
Message-ID: <20250502070941.31819-2-dpenkler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502070941.31819-1-dpenkler@gmail.com>
References: <20250502070941.31819-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wait_event_interruptible_timeout returns a long
The return was being assigned to an int causing an integer overflow when
the remaining jiffies > INT_MAX resulting in random error returns.

Use a long return value and convert to int ioctl return only on error.

When the return value of wait_event_interruptible_timeout was <= INT_MAX
the number of remaining jiffies was returned which has no meaning for the
user. Return 0 on success.

Reported-by: Michael Katzmann <vk2bea@gmail.com>
Fixes: dbf3e7f654c0 ("Implement an ioctl to support the USMTMC-USB488 READ_STATUS_BYTE operation.")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
Change V1 -> V2
  Correct commit message wrongly stating the return value on success was from
  usb_control_msg

Change V2 -> V3
  Add cc to stable line

 drivers/usb/class/usbtmc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 34e46ef308ab..e24277fef54a 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -482,6 +482,7 @@ static int usbtmc_get_stb(struct usbtmc_file_data *file_data, __u8 *stb)
 	u8 *buffer;
 	u8 tag;
 	int rv;
+	long wait_rv;
 
 	dev_dbg(dev, "Enter ioctl_read_stb iin_ep_present: %d\n",
 		data->iin_ep_present);
@@ -511,16 +512,17 @@ static int usbtmc_get_stb(struct usbtmc_file_data *file_data, __u8 *stb)
 	}
 
 	if (data->iin_ep_present) {
-		rv = wait_event_interruptible_timeout(
+		wait_rv = wait_event_interruptible_timeout(
 			data->waitq,
 			atomic_read(&data->iin_data_valid) != 0,
 			file_data->timeout);
-		if (rv < 0) {
-			dev_dbg(dev, "wait interrupted %d\n", rv);
+		if (wait_rv < 0) {
+			dev_dbg(dev, "wait interrupted %ld\n", wait_rv);
+			rv = wait_rv;
 			goto exit;
 		}
 
-		if (rv == 0) {
+		if (wait_rv == 0) {
 			dev_dbg(dev, "wait timed out\n");
 			rv = -ETIMEDOUT;
 			goto exit;
@@ -539,6 +541,8 @@ static int usbtmc_get_stb(struct usbtmc_file_data *file_data, __u8 *stb)
 
 	dev_dbg(dev, "stb:0x%02x received %d\n", (unsigned int)*stb, rv);
 
+	rv = 0;
+
  exit:
 	/* bump interrupt bTag */
 	data->iin_bTag += 1;
-- 
2.49.0



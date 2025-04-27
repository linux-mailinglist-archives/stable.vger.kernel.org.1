Return-Path: <stable+bounces-136777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17135A9E06E
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 09:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715C8189F322
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 07:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95281CD213;
	Sun, 27 Apr 2025 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI4tU/gi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9EDBE6C;
	Sun, 27 Apr 2025 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745739047; cv=none; b=tGntCk/6aNF+G8fBzuo87oupUffQQR75Cq3DW20SZuPpZE7pPjkzZiDiZRpPOkfLyfA9MyHN4xhQxcYvyMTNsHTvI1pujPD2LgOiG1JrKCFl+TBXSzMRl0/VdR4HXX2fwDqk6IRaNhB96pyB6NIjDdcwH4IBqgrpOqlSSHpiC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745739047; c=relaxed/simple;
	bh=Xs8Fk7NsM7tIMnlQLra7COF0M+LwbFvlMNaKkvTfWYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8JTQZsJVIebBtV2gnzVdjlZQ8iwCqCg9jnet8rk2v7e5jL2gqEQ09WoiwxhUnJr/wlZ3mqNKTQTnCToLe6kzabdYDfCjDJtwQH8V7MZH57/Qml1aG7vyYxNKqZ3wrCv6hCu+6+Z9Fg+sPiBR9g1JlbDjXZ/x1YLc6OiqqAu2qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CI4tU/gi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso34780615e9.1;
        Sun, 27 Apr 2025 00:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745739044; x=1746343844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he0PjLi0f/fa9kPWWLvSTfkZuLEj/6CyEwfwOCJhSIU=;
        b=CI4tU/gibf0aGjtE4sPpsFO8/Ccg2cYgQTW67+0+/e73+3a5rJiQh6BSRvEIDZC9mA
         tyPz9IfWdA9cU5nOb+MwOi691qsBk/kFFbHY3BwT6+sxesZMDw5cetBnzXz7x4stE8LM
         Z6p4gba5zpWVrdwj/kxPjLCIsxHFPJakCONKO6EKcKy2eqUCrc29Sj7ThNOGO6F6z+3G
         WBGJsHAOFzQ3D8CKWAOFkuaNM5NZwQPc+B/L1pbl1Xt5PaRVghN487RzhEeP9CKz7DeB
         Llmx2gzsifJYHX6YNQo+gFt0ZONf5dXwu+jNWSHiXV7Irh3Ji5J0wINCspTi8ExWL8j5
         oS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745739044; x=1746343844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he0PjLi0f/fa9kPWWLvSTfkZuLEj/6CyEwfwOCJhSIU=;
        b=XSz/119tx3DieUT8z3o4NMagYoSrHAayDCz9BM9oY92gdSbBBhrsnwfr7l5cVnoz+K
         GszpUDFNqOEBO479I20lhh3iXahpUrFAltj6n6+T9CtwGtSGGLuCvINytEMt9KERoiAp
         K9ADMx0cwLqM1LF7vHLuo0Nwd2AowygYj7F3IOOIPORug2UMH8bVmjpqm4Cwc8RhYcBZ
         ndAkNVykdAzU6Bp2UUdNAZqL33OTEMkx0OQODMqwntFPGT7qvm7r2VO1a5fYSt7aypaK
         E/4/gFvvLwH2qKL2QUZhmf20n0eZwlemuaPjLvn3RCRDPVYFDWHsiXqOQQ3R0n4VjNHe
         9JwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqi6rkFeEbMVhh9pvbI+csZob2i8EsHpHp1Zm5OHT9189dMYyz3mDcreikl3CO46+SioJw1Fum9Bg=@vger.kernel.org, AJvYcCWjL11BbwS61yyBzcakYcKb5lt3aEAjuTRtpdEOiHvtF16WYhdFYC5UCDDa7UXKqyWNXZKZ0+u4@vger.kernel.org
X-Gm-Message-State: AOJu0YxaylG56kVfXOPA5/XPl3LTMbkDvEpGRuQO+izA+fWh6Of0zsgo
	cI2a+SoJWmfpS8GPF+zvweXLPE4Qk5SjX2pvSVj61pjnmjEp5iNC9yluDyH4
X-Gm-Gg: ASbGncvlAIARGB8BVJ4OEti/nw+g4onE6ZHFy+NxyftC46ni+l+gV3R8ke4m6GGAlQm
	XHbvFEzi9dzGcqxHcSzIdQQLovI9FpNTOoazZQJ3/MnHhg4iuDFJ3TrGQ/JNrBRYn7amHqprRfA
	Uyy/Di9hE0MsClSk/dJVcrs66fLXVmp8PEabxLcwN4+OHs6x0/T8vF16MXAe4+1uODc0UBJ/tdd
	D2VlLCBocoj+huqpCMWaSnkIoxJ5SZ1rq7L+Y8cA9CJOAHLvZdRVxz7wTn9jDcVpZXQG08hAtCb
	3A+bv+gyK4kF3UPbclKcL0cZCO0l8L8MqsxZgiueJkpY14++wU4B7am1kP5WiyjsNGSr10NTG3N
	RQYtpB+pPeO4=
X-Google-Smtp-Source: AGHT+IG4bhtV0WE/d5jlkEof4xCGpJS0PtpactSC7bxeHIyOtwCl3Ve6XdH8vivCnJTz9/ILB8U8bQ==
X-Received: by 2002:a05:600c:1e0f:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-440a66985dbmr62608185e9.25.1745739043866;
        Sun, 27 Apr 2025 00:30:43 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a531072csm83924145e9.18.2025.04.27.00.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 00:30:43 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: guido.kiener@rohde-schwarz.com,
	stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>,
	Michael Katzmann <vk2bea@gmail.com>
Subject: [PATCH 1/3 V3] usb: usbtmc: Fix erroneous get_stb ioctl error returns
Date: Sun, 27 Apr 2025 09:30:13 +0200
Message-ID: <20250427073015.25950-2-dpenkler@gmail.com>
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



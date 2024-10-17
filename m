Return-Path: <stable+bounces-86628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7474D9A23FE
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 15:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FA6B21746
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 13:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D201DE2DF;
	Thu, 17 Oct 2024 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btu2kLx7"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFD11D88AD;
	Thu, 17 Oct 2024 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172154; cv=none; b=CfhHzGLxoWDtv3Xjwo+d+o+QcuaIRaDikUF6e0dlbsgPp1tTGHX/8vzTOg8YB4lgB/A8O10xMCDHGF6kAcnXwIpdHtzrvi6hhEX4qEgfyx25e+zwQon6oMAOMenuyV7TrFKbuFBIH2gAQNjgl809OpyRMDZOk6I0JbwD5hY3OWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172154; c=relaxed/simple;
	bh=+r65+w1nVpxOTrFrf5c8bqIK0FWAzXBCyFXQT/ceMIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WxZ63lzotZZ02sYtT0M+nuNg5SIC+FfM6J1eSb7ucAWaf4sHAKeYAeW14K5Mqn1JJRh/a4iWET7LBiqyC1ZK+kVWrxPExXiZc3tnAPEO4RJJ9uXL+kVdzFNrV1iLt+a4dEACleTStgv8fveyyIHNl+MDuJoDTqH8TzxcrGinqm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btu2kLx7; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5eb858c4d20so18289eaf.1;
        Thu, 17 Oct 2024 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729172151; x=1729776951; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZMuuUkAY9PCNIlorKrSdPeEvdmOXXkn5HiHzeIKVJfY=;
        b=btu2kLx7vx8UjSfHGu7lcDI+AqZKSNq2XDGKNdxpFO0/yfQNrAMyHE+4+geuuULmT+
         FgLyXTnX62+Zqk0eltF2l8UOVFpHu7TZUVAG7Yw5W9JRvHoJpBirMbfUGnNkw5XpsEa/
         EYPf8n8/q+p2J3vknD4deoTsWUivz1PhKvWHbXlr16LO6DoQfXkLv3GdZHqUJ6Px9TIM
         yf90zA95W7m+Vw8gCq/Svb3hTsMR8T1RjJ/rlnDa+32OPe1jcZec+pqyY8y4Xyb7psrt
         tS9ERmfnlVMvdfC1rtlnxpuhMR6CVBl3MAUPswYdqMANAKXtxnzfSRZgeqocJ0Ylb8gG
         bYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729172151; x=1729776951;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMuuUkAY9PCNIlorKrSdPeEvdmOXXkn5HiHzeIKVJfY=;
        b=Q0OdI8CZFAmfQJk52+gTapNjVuhN7yNSSy1pmSnCaIOOAocUBeVBDR16zkDosV3+HL
         JsA07EB8/W3ou2KRQ1n0H7RjG3smELLliAWCNGBBBKqZjv9aG6lSY8+zss52I3WpY9hG
         lWLMeL5OpkVfjW/6lL6KDEGA29ZCmHb66Zj7ubZBeCIW1MypbN1HxCE99tBTZe/RTy4j
         vyq0gweseLF2nvun4KBr5rF8JTVRExQkwclcSGw6mgZCilrYW08jmka38b2FHdusVA8l
         q4nY0kUWUYUmHqnipjRUvc8y6McbqvS6Hy3k5hEs64zybrQnuqeMjuj9wnX3UdtZ0op5
         yPsw==
X-Forwarded-Encrypted: i=1; AJvYcCXIXZQRCIrgdPBYeOKMJN0BFTNvFQ7WdTfsnEUdMA68chXNZy7jYD67TIQGqgrYHkX1oFuNjg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWqj50YU4bYj2LlUHUCFK9JDq7ybzzklhNgA1CewYDPQ+Xh9h+
	KAKk1k7RlifjCxb8wAv0rOnc3OBJlWma4B0mbkBZGaK3RBdcSiHK/uhrpNfM
X-Google-Smtp-Source: AGHT+IGHOyvUp1rw4yxiA7jGCnAWxfE/5/IXKiKSmuau8z4tW79E0bKJEtzzhh/a35H6caHwdwF7eQ==
X-Received: by 2002:a05:6358:9387:b0:1c0:ce92:9090 with SMTP id e5c5f4694b2df-1c340de45b6mr644002055d.28.1729172151066;
        Thu, 17 Oct 2024 06:35:51 -0700 (PDT)
Received: from localhost.localdomain ([4.15.194.220])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4608fc783cesm16910861cf.32.2024.10.17.06.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:35:49 -0700 (PDT)
From: Vimal Agrawal <avimalin@gmail.com>
X-Google-Original-From: Vimal Agrawal <vimal.agrawal@sophos.com>
To: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	quic_jjohnson@quicinc.com,
	dan.carpenter@linaro.org
Cc: avimalin@gmail.com,
	vimal.agrawal@sophos.com,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] misc: misc_minor_alloc to use ida for all dynamic/misc dynamic minors
Date: Thu, 17 Oct 2024 13:35:32 +0000
Message-Id: <20241017133532.94509-1-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2024101722-uncharted-wages-5759@gregkh>
References: <2024101722-uncharted-wages-5759@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

misc_minor_alloc was allocating id using ida for minor only in case of
MISC_DYNAMIC_MINOR but misc_minor_free was always freeing ids
using ida_free causing a mismatch and following warn:
> > WARNING: CPU: 0 PID: 159 at lib/idr.c:525 ida_free+0x3e0/0x41f
> > ida_free called for id=127 which is not allocated.
> > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
...
> > [<60941eb4>] ida_free+0x3e0/0x41f
> > [<605ac993>] misc_minor_free+0x3e/0xbc
> > [<605acb82>] misc_deregister+0x171/0x1b3

misc_minor_alloc is changed to allocate id from ida for all minors
falling in the range of dynamic/ misc dynamic minors

Fixes: ab760791c0cf ("char: misc: Increase the maximum number of dynamic misc devices to 1048448")
Signed-off-by: Vimal Agrawal <avimalin@gmail.com>
Cc: stable@vger.kernel.org
---
v2: Added Fixes:
    added missed case for static minor in misc_minor_alloc
v3: Removed kunit changes as that will be added as second patch in this two patch series
v4: Updated Signed-off-by: to match from:

 drivers/char/misc.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 541edc26ec89..2cf595d2e10b 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -63,16 +63,30 @@ static DEFINE_MUTEX(misc_mtx);
 #define DYNAMIC_MINORS 128 /* like dynamic majors */
 static DEFINE_IDA(misc_minors_ida);
 
-static int misc_minor_alloc(void)
+static int misc_minor_alloc(int minor)
 {
-	int ret;
-
-	ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
-	if (ret >= 0) {
-		ret = DYNAMIC_MINORS - ret - 1;
+	int ret = 0;
+
+	if (minor == MISC_DYNAMIC_MINOR) {
+		/* allocate free id */
+		ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
+		if (ret >= 0) {
+			ret = DYNAMIC_MINORS - ret - 1;
+		} else {
+			ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
+					      MINORMASK, GFP_KERNEL);
+		}
 	} else {
-		ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
-				      MINORMASK, GFP_KERNEL);
+		/* specific minor, check if it is in dynamic or misc dynamic range  */
+		if (minor < DYNAMIC_MINORS) {
+			minor = DYNAMIC_MINORS - minor - 1;
+			ret = ida_alloc_range(&misc_minors_ida, minor, minor, GFP_KERNEL);
+		} else if (minor > MISC_DYNAMIC_MINOR) {
+			ret = ida_alloc_range(&misc_minors_ida, minor, minor, GFP_KERNEL);
+		} else {
+			/* case of non-dynamic minors, no need to allocate id */
+			ret = 0;
+		}
 	}
 	return ret;
 }
@@ -219,7 +233,7 @@ int misc_register(struct miscdevice *misc)
 	mutex_lock(&misc_mtx);
 
 	if (is_dynamic) {
-		int i = misc_minor_alloc();
+		int i = misc_minor_alloc(misc->minor);
 
 		if (i < 0) {
 			err = -EBUSY;
@@ -228,6 +242,7 @@ int misc_register(struct miscdevice *misc)
 		misc->minor = i;
 	} else {
 		struct miscdevice *c;
+		int i;
 
 		list_for_each_entry(c, &misc_list, list) {
 			if (c->minor == misc->minor) {
@@ -235,6 +250,12 @@ int misc_register(struct miscdevice *misc)
 				goto out;
 			}
 		}
+
+		i = misc_minor_alloc(misc->minor);
+		if (i < 0) {
+			err = -EBUSY;
+			goto out;
+		}
 	}
 
 	dev = MKDEV(MISC_MAJOR, misc->minor);
-- 
2.17.1



Return-Path: <stable+bounces-86596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3C79A205B
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 12:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5141C2146F
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 10:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15DF1D9359;
	Thu, 17 Oct 2024 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0Y2EuV2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D895478E
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162435; cv=none; b=SEzww8mZGhfyUxfIZXCWjWcEoA0KL4wmoAZkgztHbSnmFsOKbQBgI6fmZ2FRUOhNZgkUSfb3XYraQU+S7maIXHpsSmXeoemWUlTvsYZJ/Rgu3wiUTGVvfZqk+baupl1DsgabQiF7QyR6k3QBrqiZzBqKXILv6xhuaqYC8es8x4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162435; c=relaxed/simple;
	bh=1TUkqv7Gp7ZtnWJ/xeGylgVX1duGnifDUVRBhrk//po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FeOcAhwC5tDYVZwGcucXcaJGiYMXs3MqWLzGMLTnSZcN9dXPQhXEMHEnaZVvAmUjnomTy7Vb96wJRS/pc3iJMN5FxvhaIfMrG8jUDY6LSTpX1zgvOB5NO2JYnyNoGzi6jVLBFrqh/uOD2BSEyzM1l8ly+TJmW8xRlMUrDHDs5F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0Y2EuV2; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4609d8874b1so4901841cf.3
        for <stable@vger.kernel.org>; Thu, 17 Oct 2024 03:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729162431; x=1729767231; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7P+wyGAjVV69248FHlxBMSlRo73uJ0o3HnqvI2HQuCQ=;
        b=W0Y2EuV2lXsaWl22rr0TY5fbJb9VLvSubrxTq4tw5/YOLcc20wEae4heOUIh6+Du5I
         mvbK8YMX/AYaJEK5r303eKmpvdxT8qjrWkd/YlghJfq+rmJzUzWu45D/JOejw1aTbnkC
         wf+BxtgEyRsx9ZvFtPfmlhhwdpNyIYMcoQU/8L4L9i+YtKENUpOAANOD1fKWIMlAEB0l
         cu9HJDWw6SfDtdxTF6BLtgK5Yki0tyVk/6TXOdcVxkP2ty1SBEzoV0TI2NTL+91l89IU
         zdBDQanWxVUcf3djQO8tNdlJIKmPLzVuy8wWAOp9HWjIGUgWdZKIgK7RfI0M/jp1q6C+
         cR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729162431; x=1729767231;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7P+wyGAjVV69248FHlxBMSlRo73uJ0o3HnqvI2HQuCQ=;
        b=h/DYftN8YpcMDlUsbRpF8IBnDgtkwfIMugKQT5MIyM/uyOh8xgN4LrIEOhphw7xd9O
         BNP8PHzndKFqC98kvK4PXsxz3qKZksNEIYbQbdaktnVc9Okup25Ll2Syie6z8JkJGFpc
         fNOsvFj49lGqTWQWkd5kp3dXFTLj0ni61FwOmX53b7XVUFeZIYcUn98p3xCLZ6EqI25h
         rpxI+17mwWvcrfcuT8svMiBcau/ab80NPraMQjnY2n24ngEp6bYXM5FnDMw6SezNVVoc
         FZcmsEHs0QySsIPfn7I4KMxW9+UKN/ooFsGemPTzYwXd7ZNN66P1hhYKWp38RUwNBZgY
         QSRg==
X-Gm-Message-State: AOJu0YyogovQE9qfyGHTTHbqI7d/wLkdozPAlIgk4db4fu2U8DNTDdYG
	LBJLIEwPWbjWr23solbkPs+VbVuZ2SrxSW/uA+4cNtUPnEhCg29HI38F2zBB
X-Google-Smtp-Source: AGHT+IE7X9f0U4R2AR8B6MMknx28oiuuWL5gtbZJ8PFPdj4tuOvyLl6qJQlng+wFqQ8qlh3y/3d2DA==
X-Received: by 2002:a05:622a:1a09:b0:45d:920e:ce86 with SMTP id d75a77b69052e-4604ba7faa6mr293155821cf.0.1729162431267;
        Thu, 17 Oct 2024 03:53:51 -0700 (PDT)
Received: from localhost.localdomain ([66.198.16.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4609bc1f0b4sm7409081cf.50.2024.10.17.03.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 03:53:50 -0700 (PDT)
From: Vimal Agrawal <avimalin@gmail.com>
X-Google-Original-From: Vimal Agrawal <vimal.agrawal@sophos.com>
To: vimal.agrawal@sophos.com
Cc: stable@vger.kernel.org
Subject: [PATCH v3 1/2] misc: misc_minor_alloc to use ida for all dynamic/misc dynamic minors
Date: Thu, 17 Oct 2024 10:53:25 +0000
Message-Id: <20241017105325.18266-2-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017105325.18266-1-vimal.agrawal@sophos.com>
References: <20241017105325.18266-1-vimal.agrawal@sophos.com>
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
Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
Cc: stable@vger.kernel.org
---
v2: Added Fixes:
    added missed case for static minor in misc_minor_alloc
v3: removed kunit changes as that will be added as second patch in this two patch series

 drivers/char/misc.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 541edc26ec89..9d0cd3459b4f 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -63,16 +63,30 @@ static DEFINE_MUTEX(misc_mtx);
 #define DYNAMIC_MINORS 128 /* like dynamic majors */
 static DEFINE_IDA(misc_minors_ida);
 
-static int misc_minor_alloc(void)
+static int misc_minor_alloc(int minor)
 {
 	int ret;
 
-	ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
-	if (ret >= 0) {
-		ret = DYNAMIC_MINORS - ret - 1;
-	} else {
-		ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
+	if (minor == MISC_DYNAMIC_MINOR) {
+		/* allocate free id */
+		ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
+		if (ret >= 0) {
+			ret = DYNAMIC_MINORS - ret - 1;
+		} else {
+			ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
 				      MINORMASK, GFP_KERNEL);
+		}
+	} else {
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



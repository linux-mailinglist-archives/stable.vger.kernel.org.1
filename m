Return-Path: <stable+bounces-87565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FEB9A6A8E
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577771F26EC3
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 13:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381D71F893A;
	Mon, 21 Oct 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gey7bTah"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D31F9434;
	Mon, 21 Oct 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517937; cv=none; b=T/VIqYX+g8z6WVHK+/5e33R6etGLZqz4cqFaYjJ2DhLAVR1qA/GFJMwTJsGY42/uFH+8q65EmSjB+/jIWN2UuTzjDOxcNVrvyEMq6Zv5cE0Mo9r7LyGqtLKODG4AEYnPzov299kU+2RNzmVe6Z/JkFqsLCCscRkp8+O7Xkd59Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517937; c=relaxed/simple;
	bh=iSHLE6plbfk96+SH2cugxJAwojra42eWwU6P8uM0BVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uUOLajt4JajvYlVSARLmnGQWMe+JPGq2VDSPavk+I4iEQEk19cNUn1Mfp5+M29thnqGKlpTl66Qy913Q1WOdft3sWDsHsRbD+1Gjr0r2mHwkC2i1jGR7+TfHNQfYXuZpqVndVa/OSynGFgQ5Pyv3gFiGpfoOGMqUypUPuCPaVLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gey7bTah; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbf0e6414aso22244066d6.1;
        Mon, 21 Oct 2024 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729517933; x=1730122733; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L1L3Nl4I67AsUfDUqit1/x+zsIPymQ31QwezjFp1f6A=;
        b=gey7bTah62anpxFWimpT4uYErOXwWW0VbQxk4fL1J+GeaxuVwVA139oelJIh+ryfAW
         2ydZiuNk8W8hNEpNtrzL6VGKUCi4SSmoS8Kh77pReRwulLkNJqXhYc0XjuaVYD2qMw5u
         yYGhsHO54pqQFgEmfxgzYP++BXDvYd98IHvWgbUjF5W9OVxZxjHuCq4rC00Btmq8a4tt
         GUrGeANtZ3JLh8Z0w+2v7IrRmD+pbE+1QpagS65Pmonz+So39/cK2Rg99n7VnuSz3Q96
         J6+vsK/19wK/l7zFTRUrzCxfzprAvL7e0tJrAMazaS4ywIoRG1W6bbyNcT921p+7nXSB
         v4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517933; x=1730122733;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1L3Nl4I67AsUfDUqit1/x+zsIPymQ31QwezjFp1f6A=;
        b=Dw8vvFcLD2vN1GdaCW5VHV46x+frRy0xGMyFSOa2epRlqAj2fE9K1eBDlISWGX64fu
         W8n0H47ymC57q5M/DebcnFV6ClUeN/fQKvkIJhCHAqO9J9lqkaHyaRTWtnmJMgw1XT9R
         YVSR1Xq3BTyj/zfLe/RL4V0K6N+GYS+2qGBITUVxoaxST9poxpcwa6ftINGOkHQllFx1
         mnoUifYIX50o70mtPVCkDZjeJRhc0dGypeCY5SP9FuAWHP6GejWSmMBL2S8w/jCvGY8W
         nhwTsRbBDJJvOg9JpltVxpPIAIuYueKnQ2rNftnQYFgX5S0bYKrwgjqO4Fn75b5Dr2f+
         IT1g==
X-Forwarded-Encrypted: i=1; AJvYcCVEtdd4e0ZyXLMdyUWYcTJxEJmNdgLJ0gGNNOueCs16nm/FyYW+tHfBia9cL/kpfk4BfL8jivs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjPXMWYEVW+boadVSbwDLOmwm7IEjkVmQPbIgb6/e/FJ+YHwtC
	T1z3rxakOD9zbZSAyf8GeayMZNB0D3Wc0hv5DEj507dK0GGFxb7lBXlyVipm
X-Google-Smtp-Source: AGHT+IGOfWFAXHZZPNz4iIVVQsEALO7IWJnjzIiw1kF6Q2R8aZRu18TXHWhvmeyQAAlaD/iJlqrh8A==
X-Received: by 2002:a05:6214:2dc1:b0:6cb:ee7b:7ac4 with SMTP id 6a1803df08f44-6cde14c3087mr172746966d6.3.1729517933378;
        Mon, 21 Oct 2024 06:38:53 -0700 (PDT)
Received: from localhost.localdomain ([66.198.16.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00999d14sm17058616d6.81.2024.10.21.06.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:38:52 -0700 (PDT)
From: avimalin@gmail.com
X-Google-Original-From: vimal.agrawal@sophos.com
To: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	quic_jjohnson@quicinc.com,
	dan.carpenter@linaro.org,
	dirk.vandermerwe@sophos.com
Cc: vimal.agrawal@sophos.com,
	stable@vger.kernel.org
Subject: [PATCH v5 1/2] misc: misc_minor_alloc to use ida for all dynamic/misc dynamic minors
Date: Mon, 21 Oct 2024 13:38:12 +0000
Message-Id: <20241021133812.23703-1-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017141329.95508-1-vimal.agrawal@sophos.com>
References: <20241017141329.95508-1-vimal.agrawal@sophos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Vimal Agrawal <vimal.agrawal@sophos.com>

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
Reviewed-by: Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>
Cc: stable@vger.kernel.org
---
v2: Added Fixes:
    Added missed case for static minor in misc_minor_alloc
v3: Removed kunit changes as that will be added as second patch in this two patch series
v4: Updated Signed-off-by: to match from:
v5: Used corporate id in from: and Signed-off-by:

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



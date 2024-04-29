Return-Path: <stable+bounces-41760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06E68B60ED
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 20:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8A81C2111A
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9080012838D;
	Mon, 29 Apr 2024 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eje0KCDt"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5280A8614C
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414458; cv=none; b=aQXFAKA3AMN5wVRxWC3RE7eKxCkplgoIcN06Mv2TXGFXhNQIErEJE6PqamODBzFqxZSsvMAh5gZKxNC1O1JJEqTwnN47GJ5w1I2IGDs8cuFuU3187QSAP3vfoF/Py5CMzqKZOHtES741EdhoRlV/RN8+rhYwyfJ552q1fyanaKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414458; c=relaxed/simple;
	bh=YCowSaEVxz5Th4+eEyP+ngkS+IVErBSdGo7rFV+gYM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UH4btOrzuunelBNwgH9JOUiYU28+gBO1lhP7SPYUMBGg1qoetJFGZtENFnXkrox6T2gyOnMj6hKdRt3gLU2rAZTOWiYTuib1S/BsJLrUcFUUm05lbac23nLeoCGQ2RP3Yg94kLQAVEsKmcagykGTDLb3pwo/yxPnGEbKlVSDWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Eje0KCDt; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7da42137c64so204047739f.1
        for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714414455; x=1715019255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5U5Ovsd+M0JJ1E5zOP2YrAXuvUNDgcSQFNzhJAAl8DQ=;
        b=Eje0KCDtLkm5WDDkWq9uwedzpjwICh7ENWTFN3b+Ffd28RNHm3F4djae9mTfFUDR6v
         hcvaVu3KYE2UgcYF2DYOfIwcFfmLh/sqFhvh4AJfo0jw66xyV6lwqVRyrs7TO6ZcAB+B
         eMniB5z2L2P/4mkVEWJ/YEl9hfKGpeoafDAJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714414455; x=1715019255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5U5Ovsd+M0JJ1E5zOP2YrAXuvUNDgcSQFNzhJAAl8DQ=;
        b=oNQqxizJ6WPGm6aLKkhujrflR1ABRaIJYCkVz8BGvviHTsMSXoyL9h1U0OV8Gi/yXA
         D4tssmUYcxHmsUE7Uy08XlAM6fjeYhJxvqvFC72j+iJaLka6iq49nYilqt9ozAWy7AzT
         Zi1XZPhS3F2dbr5miVHvM0uXhuwCRN904ky3LDlvygqHd+qx4chKoUDX3CX9UrBnqHar
         0kLn2DPwh6aBPLh0S6KegP8S/13qyykoVRy3ZhV5mpfYOyIrCpyYTOZEF+h3zbU0RKcL
         kkBtH5zsZxTHcUEc0eD7lQx++zPcRTj+7gLH7b6LIrgPaWbIP1WmRJFh/t3MgBu6uwmg
         sUuA==
X-Forwarded-Encrypted: i=1; AJvYcCW/fsIfadGnuH9Qw8zwSn3mxVq+v2Y+MlCA1BGQ7Zj/HJWXtp52yehk2E0C2yfYASbgbHQ7w2wuSen5oSKGQ/E5omAT3nlr
X-Gm-Message-State: AOJu0YyRMcwNigTTeVLUX0U2MPssUeP1noQEuBfWDEW0J8dkP+jPY/Qp
	QGpK8a2fC/ZlT+ukQuzB2oGjoWqVrV66UJUinuAMjoTb5bcu3Zu4MzQkt9IXzg==
X-Google-Smtp-Source: AGHT+IELaJ8zCPU56vHLqlO0m0JFHKddtNX1XApb9dDhvl4jX4rekMtYaF/Fr00J+p1noZD9iNJccw==
X-Received: by 2002:a6b:5814:0:b0:7d5:c00a:7d30 with SMTP id m20-20020a6b5814000000b007d5c00a7d30mr768321iob.8.1714414455464;
        Mon, 29 Apr 2024 11:14:15 -0700 (PDT)
Received: from kramasub2.cros.corp.google.com ([100.107.108.189])
        by smtp.gmail.com with ESMTPSA id n21-20020a6b4115000000b007d05927cb31sm6068548ioa.45.2024.04.29.11.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:14:14 -0700 (PDT)
From: Karthikeyan Ramasubramanian <kramasub@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	stable@vger.kernel.org,
	Lalith Rajendran <lalithkraj@chromium.org>,
	chrome-platform@lists.linux.dev,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v2] chrome/cros_ec: Handle events during suspend after resume completion
Date: Mon, 29 Apr 2024 12:13:45 -0600
Message-ID: <20240429121343.v2.1.If2e0cef959f1f6df9f4d1ab53a97c54aa54208af@changeid>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 47ea0ddb1f56 ("platform/chrome: cros_ec_lpc: Separate host
command and irq disable") re-ordered the resume sequence. Before that
change, cros_ec resume sequence is:
1) Enable IRQ
2) Send resume event
3) Handle events during suspend

After commit 47ea0ddb1f56 ("platform/chrome: cros_ec_lpc: Separate host
command and irq disable"), cros_ec resume sequence is:
1) Enable IRQ
2) Handle events during suspend
3) Send resume event.

This re-ordering leads to delayed handling of any events queued between
items 2) and 3) with the updated sequence. Also in certain platforms, EC
skips triggering interrupt for certain events eg. mkbp events until the
resume event is received. Such events are stuck in the host event queue
indefinitely. This change puts back the original order to avoid any
delay in handling the pending events.

Fixes: 47ea0ddb1f56 ("platform/chrome: cros_ec_lpc: Separate host command and irq disable")
Cc: stable@vger.kernel.org
Cc: Lalith Rajendran <lalithkraj@chromium.org>
Cc: chrome-platform@lists.linux.dev
Signed-off-by: Karthikeyan Ramasubramanian <kramasub@chromium.org>
---

Changes in v2:
- Updated the commit message with the right problem description

 drivers/platform/chrome/cros_ec.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index badc68bbae8cc..41714df053916 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -432,6 +432,12 @@ static void cros_ec_send_resume_event(struct cros_ec_device *ec_dev)
 void cros_ec_resume_complete(struct cros_ec_device *ec_dev)
 {
 	cros_ec_send_resume_event(ec_dev);
+	/*
+	 * Let the mfd devices know about events that occur during
+	 * suspend. This way the clients know what to do with them.
+	 */
+	cros_ec_report_events_during_suspend(ec_dev);
+
 }
 EXPORT_SYMBOL(cros_ec_resume_complete);
 
@@ -442,12 +448,6 @@ static void cros_ec_enable_irq(struct cros_ec_device *ec_dev)
 
 	if (ec_dev->wake_enabled)
 		disable_irq_wake(ec_dev->irq);
-
-	/*
-	 * Let the mfd devices know about events that occur during
-	 * suspend. This way the clients know what to do with them.
-	 */
-	cros_ec_report_events_during_suspend(ec_dev);
 }
 
 /**
@@ -475,8 +475,9 @@ EXPORT_SYMBOL(cros_ec_resume_early);
  */
 int cros_ec_resume(struct cros_ec_device *ec_dev)
 {
-	cros_ec_enable_irq(ec_dev);
-	cros_ec_send_resume_event(ec_dev);
+	cros_ec_resume_early(ec_dev);
+	cros_ec_resume_complete(ec_dev);
+
 	return 0;
 }
 EXPORT_SYMBOL(cros_ec_resume);
-- 
2.44.0.769.g3c40516874-goog



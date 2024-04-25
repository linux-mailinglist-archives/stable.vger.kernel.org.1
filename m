Return-Path: <stable+bounces-41465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F2B8B29FD
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 22:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D891B222CF
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 20:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A461152503;
	Thu, 25 Apr 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VG7U1V8a"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1336EB4E
	for <stable@vger.kernel.org>; Thu, 25 Apr 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077468; cv=none; b=CXfmU1wsQDxWyfMVBG3XGHK+hFCM81sa4Nz8AztcxoxILhJkS+Qsl8yROOoLGSefwL4PYNCWd2FbKMknMK09VhQHTyH07a89M3uzKQy4PlsU5FuNo+FWP7FYYUfUl188mgsfhdMG6QexFd5tXj67yy83jyLZtGBSRKK6YwEypWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077468; c=relaxed/simple;
	bh=jAg2VLHgH1tgYvqdC05z+fR+GClul15yoSWcnQ41OgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDf3TSev2z9G+FFAQ1yx/N0a/9+Jxg12XkAOqlApO0m7UxH6eRZxTMBfMsnsT1iUIHymKp/6yWoAfBxAY0FT+IoFYjjdwpL1Wmqk9wTLUMTib2GVtoB+Gn8xgNyWAL3E5VuVAxvby7cWxCpPPIQbRvcLWAKzdl+8/0S5OPUzKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VG7U1V8a; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61ab6faf179so14627577b3.1
        for <stable@vger.kernel.org>; Thu, 25 Apr 2024 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714077465; x=1714682265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7H8fihR3flAk+5cySZQjU2neMKCr+gYXjQpgANOY1yo=;
        b=VG7U1V8aCclK4i6un3SrmcMp/odlODPFRSAZPIEyLKVjl4dnFZDD3LLfU9l8EylEkc
         og7vmoG1RYsX0taGjQWpwRpvs/Oe0rwI/ziyZhg8dDlaJxrbyvzupnofq+ooSBZ7Pmb0
         ts8P4Qkcu+70pdciV3B57JZ7PTynPD2o/pJes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714077465; x=1714682265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7H8fihR3flAk+5cySZQjU2neMKCr+gYXjQpgANOY1yo=;
        b=m6rE2PODBAs7KzZ5j5nTjZwCEItaEBY6VB5R/QP5sHwFAsH5w5fuls5vJOrRPZJc07
         HqrH3D9w+L5qc8YI5JynOOub1FQnNVlB8i7uxhR90MgCBp+czB5o5szWUOwLbaMq1sAJ
         CH8+CQrd4dU+wElTFEZij7BVw2h4hi4WnjOyv01GKw8dWrK3BC+eCisnJscy4hvNPEy9
         Ip3pE9KTwAqnSlQlwZwTyPo4rTzNdJbQiN/1sFr/Hejx3R4VJ4t0pUjvFKh8OyD7J/hV
         CeVlEGeCd0iiuxcA+wUuxTloKw2H92qEUI9ofL7uCJyuMbz9kROa7Em4UkuwDRDmHY+0
         7kLA==
X-Forwarded-Encrypted: i=1; AJvYcCUaVGzWzn6VbWBKzjw5Kk48f7iVAPhkJPlrKE6fM2rOkYIfekCj1LEClhqQIxFoIFnM8JyNjNOlVgNnvG1rwaQwtC2MWrdz
X-Gm-Message-State: AOJu0YxslxvKgaWmzW+PjXs0dAPXZK5jrjweO9lF1PyXKE6gD7FU9knA
	egVNuH3vsoosrlU9AtbHYd0JGm1ZX/+qnHNXASIPzFZjw8kAh9HyaoGI0qPkcg==
X-Google-Smtp-Source: AGHT+IHwwnnESpL5zc9UPq7mHXuKXY1TvTit2/7r6Skwh8KurCpi5AxNCfahS7Bg/lfE9pI15hgY1A==
X-Received: by 2002:a05:690c:6803:b0:61b:1e30:6362 with SMTP id id3-20020a05690c680300b0061b1e306362mr783742ywb.6.1714077465404;
        Thu, 25 Apr 2024 13:37:45 -0700 (PDT)
Received: from kramasub2.cros.corp.google.com ([100.107.108.189])
        by smtp.gmail.com with ESMTPSA id s31-20020a81451f000000b0061adfb01cc2sm3751113ywa.90.2024.04.25.13.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 13:37:44 -0700 (PDT)
From: Karthikeyan Ramasubramanian <kramasub@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	stable@vger.kernel.org,
	Lalith Rajendran <lalithkraj@chromium.org>,
	chrome-platform@lists.linux.dev,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v1] chrome/cros_ec: Handle events during suspend after resume completion
Date: Thu, 25 Apr 2024 14:37:11 -0600
Message-ID: <20240425143710.v1.1.If2e0cef959f1f6df9f4d1ab53a97c54aa54208af@changeid>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On boards where EC IRQ is not wake capable, EC does not trigger IRQ to
signal any non-wake events until EC receives host resume event.
Commit 47ea0ddb1f56 ("platform/chrome: cros_ec_lpc: Separate host
command and irq disable") separated enabling IRQ and sending resume
event host command into early_resume and resume_complete stages
respectively. This separation leads to host not handling certain events
posted during a small time window between early_resume and
resume_complete stages. This change moves handling all events that
happened during suspend after sending host resume event.

Fixes: 47ea0ddb1f56 ("platform/chrome: cros_ec_lpc: Separate host command and irq disable")
Cc: stable@vger.kernel.org
Cc: Lalith Rajendran <lalithkraj@chromium.org>
Cc: chrome-platform@lists.linux.dev
Signed-off-by: Karthikeyan Ramasubramanian <kramasub@chromium.org>
---

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



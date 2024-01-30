Return-Path: <stable+bounces-17402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C470784253F
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 13:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4A41F2428C
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 12:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DB46A03C;
	Tue, 30 Jan 2024 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUwrHZXR"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB6945BE7
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618804; cv=none; b=fCxmkyU2r6w/jtSXyO+shiJAdVZ1gxk+sgkpC/ZoAMEeFTyVnFouvkEcNdTVR48SThQ1X/S3+acfJBKF3nmyOwEt+9VJKVPkbCkUwHwLKuAwjuwj+5Iphp3Xlvghwqo2PPYpLWYfnv4CJh/Fue1kSohkrn8xVdSEWELkuuejhFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618804; c=relaxed/simple;
	bh=pPOLdBHtBk+XdayC4UT9iaM1+kY10UjwrRfCbJE3mTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NntHJNJEekZbO8m7WBcuG0o8Pu01iJKVEwEYsQHb5UczrSorcyKDv0bX3T+beNNJkatqRI2rW+z68hNm162gGnk86qgmk5AqGZ46twyAjqWg0MYheTt8MEJav2fk4Vuo3jEtI+vVp0aA284iU1Q6pGZg5RIlgJzNFIgscdB/UwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tUwrHZXR; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3beab443a63so4001b6e.3
        for <stable@vger.kernel.org>; Tue, 30 Jan 2024 04:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706618802; x=1707223602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8KWuN6H6OrLde6TdH8mqi4mgaKUUFr1u6xRlsaINZQ=;
        b=tUwrHZXRUNbaoNLW0URjxFPNYviUepdaKwzSC/pn7O3l9ZDMhmxbeWONYtSqDqxMYu
         1OKIPkQlWVeiPmStV3HVB/WHKw8nIpUbGLy8RqpFqd05NwvFWHPhUkDD94KetL8oaawT
         Sfk4Gko7iUb1cge61W47N63wJ7O5RMaY4OwBqF3H4DBTlb9Nm/zPKQD2DH51+3jvsSEZ
         WRiLjhiI0vLk4xo2HA3G5dTVrdzvO+lHj0HUdQBOdomd/lGGNcWHxobiGUzsIjnfz5D9
         y8O688QYkdiKa7s7pC80LZHD0Rl4mPEjPOBoohRJs2UjRrCaloKq8ZrYgJTv4Iiff+CW
         afig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618802; x=1707223602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8KWuN6H6OrLde6TdH8mqi4mgaKUUFr1u6xRlsaINZQ=;
        b=t5TET1r2QWXji4cS1oEp4BH3LTuCglAN6AfkTfMrA+toML7y/9ZU+uwnMw+A7t19cR
         UCXJkuxV/uvFpskM/WWbfmGxytX8gFp1dxBjVGrPTtDqowBSAUOBXW2+vu3F5YY1hp2G
         1dTbz6RjPLipt4ijoXCr5CIhhQpqOixSvS1+MulhTrKRAq4++cdgxsmHyCfNq6LWPeLL
         tS43+9VCr7cedK+wNwiCtxZjYV2nuLoRuTGjIeO60P/s0xctih1zpjA8Ty4fW6KXo3Br
         pcbiMI0tl8WsPQ9EOrotXByL5mHVmV1gab6lr9j0cn6Ju76PbBgtsojDWiDntJHju5yV
         P0aw==
X-Gm-Message-State: AOJu0YwAKHRmyOtMdabc75BotZWuD2FIx2nqUkETnQ7ge0eZw3TSMbYf
	cnXH0pFLIQ+Lb1g/8ZiQBzS840qK83m9bydvp9F3iLXMPsZTq2Drm3MiwY1gTWg=
X-Google-Smtp-Source: AGHT+IH58S4JEM1q9O9TRYyhe9tJdiJV5LhsiJtki/jB+Nj7Or6xV8x0SNFd4THIl4qPZKieesB5ow==
X-Received: by 2002:a05:6808:2014:b0:3be:a57f:9f0d with SMTP id q20-20020a056808201400b003bea57f9f0dmr386807oiw.11.1706618802136;
        Tue, 30 Jan 2024 04:46:42 -0800 (PST)
Received: from x-wing.lan ([106.51.161.37])
        by smtp.gmail.com with ESMTPSA id p3-20020aa79e83000000b006dddd3e31a8sm7658788pfq.219.2024.01.30.04.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:46:41 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Stable <stable@vger.kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH for-v5.10.y 2/3] PM: runtime: Have devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()
Date: Tue, 30 Jan 2024 18:16:29 +0530
Message-Id: <20240130124630.3867218-3-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130124630.3867218-1-amit.pundir@linaro.org>
References: <20240130124630.3867218-1-amit.pundir@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit b4060db9251f919506e4d672737c6b8ab9a84701 ]

The PM Runtime docs say:

  Drivers in ->remove() callback should undo the runtime PM changes done
  in ->probe(). Usually this means calling pm_runtime_disable(),
  pm_runtime_dont_use_autosuspend() etc.

From grepping code, it's clear that many people aren't aware of the
need to call pm_runtime_dont_use_autosuspend().

When brainstorming solutions, one idea that came up was to leverage
the new-ish devm_pm_runtime_enable() function. The idea here is that:

 * When the devm action is called we know that the driver is being
   removed. It's the perfect time to undo the use_autosuspend.

 * The code of pm_runtime_dont_use_autosuspend() already handles the
   case of being called when autosuspend wasn't enabled.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 3d07a411b4fa ("drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks")
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/base/power/runtime.c | 5 +++++
 include/linux/pm_runtime.h   | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 9d0865cbf913..f5c9e6629f0c 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1481,11 +1481,16 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
 static void pm_runtime_disable_action(void *data)
 {
+	pm_runtime_dont_use_autosuspend(data);
 	pm_runtime_disable(data);
 }
 
 /**
  * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
+ *
+ * NOTE: this will also handle calling pm_runtime_dont_use_autosuspend() for
+ * you at driver exit time if needed.
+ *
  * @dev: Device to handle.
  */
 int devm_pm_runtime_enable(struct device *dev)
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index b33d26ed7a1b..ca856e582914 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -539,6 +539,10 @@ static inline void pm_runtime_disable(struct device *dev)
  * Allow the runtime PM autosuspend mechanism to be used for @dev whenever
  * requested (or "autosuspend" will be handled as direct runtime-suspend for
  * it).
+ *
+ * NOTE: It's important to undo this with pm_runtime_dont_use_autosuspend()
+ * at driver exit time unless your driver initially enabled pm_runtime
+ * with devm_pm_runtime_enable() (which handles it for you).
  */
 static inline void pm_runtime_use_autosuspend(struct device *dev)
 {
-- 
2.25.1



Return-Path: <stable+bounces-16410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA9E8402E9
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 11:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DA3B20F14
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 10:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FBC537E2;
	Mon, 29 Jan 2024 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACLJbNpO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7574F54BC3
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524755; cv=none; b=LObXtAS0TJoh7pCXA/6fDmYdSCIEp1WT2BLch3osWQIsaP1gzbUyxyUoQVbr9Ef0TA86E3GrDpme6azx7KVAELWN0eNiGHUze2ylmPONuxfYh9VmZR2enQI8iyf2CktMSsACq9yK8l83xeuA60+gEy3qqNNxL7V+eWaUBTFl+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524755; c=relaxed/simple;
	bh=4v3QQwyXfCBEH6iESrTNz/5LgVdeuD7z3M251S+JNrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N6B8MlL0bcJno40R7DRP+dq7dOQRmbKvm1yHm4MlrpsddRZoD3whCTGeIkQrao/qYIfghIGC4ZzB7/eZrB7Bbh19jJXGT6QweFsjBpmB7Kz9ApzO3UsBZ5HFJ06Geekrv9KdS0k7yNFV0DW5cDuE3uBG7u4uEFa2BCCA1+bYMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ACLJbNpO; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2909a632e40so1135957a91.0
        for <stable@vger.kernel.org>; Mon, 29 Jan 2024 02:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706524753; x=1707129553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CCnyWOrz2k/50Kp1+EShs6Rlr5a5Oa+3oGxTZZURBs=;
        b=ACLJbNpOGNBDvuSabeWfummxi5Eb8S3uS9gWr/aLS8gh/Sczx8bVSmbpW/oHn4FOjt
         v9YB9SBf5Na4mu0dgc87OiOafbRyjoLYKUesiyVlMsKhAsTG1JqsiCQ23jbLRNkSyM4i
         vCJVXR0dWay+dBLggbtC2G6MmSDLodjhtYfdX3gDGDZDUSFKdca/AiqQuHJoGQle24K3
         1BszaCkXCv1rCWBwiGSqwUCTf/FFufMSQgmdqImVqFrr6mXYHYWOe6Dv4eQHWlkf1QYf
         25h2rzImWZTYvGZGkVIiENbRckLiK7uTceR4sofWCWvtuxCOHe03Xx8DjIAMQR9HeJB7
         acGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706524753; x=1707129553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CCnyWOrz2k/50Kp1+EShs6Rlr5a5Oa+3oGxTZZURBs=;
        b=EIWnKBpACsqYfeiV+hjQUP4Qk5A7kwV68TgOcH2LkFQM1OjddRV0Ty648ACdzPKwau
         SKeFK4EY7XjcKhwC8mU+UpE81qu1/g4vpL/HR3uzENZn6++MeMnEVg+Y0xfRTPMgJ9xG
         7JeWsjblgD0WkASxWg8JRWU/QXNbieOHKhkuCzuimIFzrVFJN7BIlOZSTM5DFqU0bBKA
         3LK3belXxRff/21qMjPQlAuKPDUT8HWxrGaImfzr8C3jhZfZvlXICxTg/n74O395nZYA
         ucn6GB+MX5ySlVsL/jSLRjtoZPQercUc0wJwg/w2CzAteJ9cS1e+BEA81BNFjrnWZicK
         5bog==
X-Gm-Message-State: AOJu0Yzh6FbJ7hsoQMLZ9JA0pKRdDWyM9yNgy74P+UWuhMluZOGTx5DE
	8ewjpuHXZlv+RqRSDzI0XVK+10oaCkQg96R+BY57fUTcjg1fM1B+8k0wazjZd2s=
X-Google-Smtp-Source: AGHT+IHZkWAqcb82G1hmLErw26zvDPIDjLIxhSr930M0VKsc3Q9chadGwo3lZmtdEY2CazKQPSFW7w==
X-Received: by 2002:a17:90b:b8a:b0:28e:72c5:ebfa with SMTP id bd10-20020a17090b0b8a00b0028e72c5ebfamr1672375pjb.47.1706524752816;
        Mon, 29 Jan 2024 02:39:12 -0800 (PST)
Received: from x-wing.lan ([106.51.161.37])
        by smtp.gmail.com with ESMTPSA id fa13-20020a17090af0cd00b0029564dec437sm2285401pjb.6.2024.01.29.02.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:39:12 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Stable <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH for-v5.4.y 2/3] PM: runtime: Have devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()
Date: Mon, 29 Jan 2024 16:09:01 +0530
Message-Id: <20240129103902.3239531-3-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240129103902.3239531-1-amit.pundir@linaro.org>
References: <20240129103902.3239531-1-amit.pundir@linaro.org>
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
 include/linux/pm_runtime.h   | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index f31609f3e7fa..a10121b05aaf 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1477,11 +1477,16 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
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
index eda6619a6358..ea0dd2c81e7f 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -296,6 +296,11 @@ static inline void pm_runtime_disable(struct device *dev)
 	__pm_runtime_disable(dev, true);
 }
 
+/**
+ * NOTE: It's important to undo this with pm_runtime_dont_use_autosuspend()
+ * at driver exit time unless your driver initially enabled pm_runtime
+ * with devm_pm_runtime_enable() (which handles it for you).
+ */
 static inline void pm_runtime_use_autosuspend(struct device *dev)
 {
 	__pm_runtime_use_autosuspend(dev, true);
-- 
2.25.1



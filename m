Return-Path: <stable+bounces-17405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E027D84259F
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 13:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3A31F26DC8
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 12:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136026A328;
	Tue, 30 Jan 2024 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hzSAQ0Hw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DECF4C66
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619537; cv=none; b=HSc5EPEhEIU8Q/Z3tEFF8rekGjlHKSa6B4y8GtRRyPHsmWLX0OO1WwredCi6vMm57yryUHECkVW2A8+p6lxQnvU9gb2YpZW/dESLcon4qyAdhOqbwi4pDLkOU+WPS7od4j4djaam97CGXdkGid5XyBsr1og4J5hXZeIHmNd1O/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619537; c=relaxed/simple;
	bh=c+dFP9HTPWjjDb8pkNXFV19k5iNLBzhpkrUs9EHqitA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bvAX/NQDxqfTQIMRFTu8qaJpnliwupt4KuiF1bkyj9euipEm62ryWTipZS0sVAIDjcdOFy8cFZV02uk1qnSSUcScVsKS+f5EM+ZICz6PYntviUc1irRgv5iix3uBDcwQ6v0ujcR04swwdYE7CztbcIYs9DC4wpDwdYAUIDfAtD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hzSAQ0Hw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ddc0c02593so1781650b3a.3
        for <stable@vger.kernel.org>; Tue, 30 Jan 2024 04:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706619535; x=1707224335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q345a9oKvrQ49VFQSg4WzTDvkB0JtUjSnqrps5U6QEE=;
        b=hzSAQ0HwP6Xzf1AEeBY+FQ7E2GJ6qEU1IDu4mrVdEMdnDxK7eN46HlPv7w3kEXcyqZ
         eSqFqkHuliVJV6yUW3hzu+qGBI+l8eo4iqJi/C/KhhZ/Lv8iO/gPnHv9VMT3gZKJzQmZ
         Ag0imDbxQ0cMuKV5LVHIujDDHBMQAk9pa9yrI/Ydl0bAyGlyD+PrSFNhUa5KXSUJZH0y
         tsAYA2EME+SLpm0MvoGmQQHxCyzBuh0S/mb8X088bxUgC3VWYvD2YgkUCwlOQszWjY+8
         CQqZ/s6MpkCUpBbc8ODxMX523QK48T0qnIlCkohlFaXe+BJ7hGFkT3T/U3WK/lRVHRov
         Z7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706619535; x=1707224335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q345a9oKvrQ49VFQSg4WzTDvkB0JtUjSnqrps5U6QEE=;
        b=Qjgkst0oCeFgx2wx2EJsTrELYH0134DkYlchux8Yh4+GnZ7AxdlaMO4vzA3Bi2mYSU
         /Y92lMhc5WbmctrfYV8RR1sEOUKUIC/6lDKbUdasAku6VYLE3H/Lx4w7R2CCNYiqpR6Q
         w4S9gKh+Qsg5w/hqsPuqho32/JSqnSBRUhjDoMHW86IG2XL8UCkf2uqbaiAKCHgLHRgI
         wTCJpa7D1i+rvZAC0SjElL3Pc5rNWHyqTZmUa9GDminu8gW1XRi8i7TSDpQUHINUbtyx
         AhmgO8fFE4BwkdyiT0KY0QdEGazUVXZHtG7JaJtKKko+sDOcwUi5yxTDwzJwTWvpJmzJ
         RKCw==
X-Gm-Message-State: AOJu0YydD0ELvmCltlvimZ390sRUwqeGnb3PQHLeECN119j5qgkpeehE
	9wZYTxwsjCPtzZ95kudnF248T0gQiIt5Co0p/2KqiVbxFYJ1/dZTEEARCc3hw3M=
X-Google-Smtp-Source: AGHT+IGsIiZC23G2Ew6meNAV9a3kYiXKczC3tDN2fcJCmGcHVxSTqnUXyS/fsrUwEPK9Q+FJfNRrGA==
X-Received: by 2002:a05:6a20:2d0f:b0:19c:a389:dd6b with SMTP id g15-20020a056a202d0f00b0019ca389dd6bmr4643178pzl.20.1706619535644;
        Tue, 30 Jan 2024 04:58:55 -0800 (PST)
Received: from x-wing.lan ([106.51.161.37])
        by smtp.gmail.com with ESMTPSA id lw8-20020a1709032ac800b001d8f82f90ccsm2432029plb.199.2024.01.30.04.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:58:55 -0800 (PST)
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
Subject: [PATCH for-v5.15.y 1/2] PM: runtime: Have devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()
Date: Tue, 30 Jan 2024 18:28:46 +0530
Message-Id: <20240130125847.3915432-2-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130125847.3915432-1-amit.pundir@linaro.org>
References: <20240130125847.3915432-1-amit.pundir@linaro.org>
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
index 5824d41a0b74..6699096ff2fa 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1479,11 +1479,16 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
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
index 90eaff8b78fc..7efb10518313 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -542,6 +542,10 @@ static inline void pm_runtime_disable(struct device *dev)
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



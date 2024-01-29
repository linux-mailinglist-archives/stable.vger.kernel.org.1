Return-Path: <stable+bounces-16409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1E38402E7
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 11:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCBC284833
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 10:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518C3537FB;
	Mon, 29 Jan 2024 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e1z9sVGX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E984537EE
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524752; cv=none; b=ruh3SqBHKo+Jhp64anDY4Itt3kvDniSNnUc2cfZpKT/ytlBRZRkEsz80duR8aAtR2AYwPMnf2XQPWA2YvSMceMGA/c5aEpTtR6eVGT6gG5BRVhiGeVbKXGpB7f/8a1rRyAFJRpq9yK0+y4OiYflVVy2U2GdiciBNrVxlmhKTWaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524752; c=relaxed/simple;
	bh=bXBwOhuZXAFv0O1LpG03TGi8CM2clW4SE3in2iGDi2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OMeCnz9vo1e5uMF4TdPCisGnnwJz89ZN0bVFb1zir8nbw8s39pqiJ8Ne0ukWIQu+l3/hpmoQfECS5/ATVU+V4npAo0//dmsHnzHzhGklTng6k3B2LvvEAF+/qqL6QTA8rhzqQe3CprA4nwAoO2lVm7Ok/eT+0WzUfraBeOgg3ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e1z9sVGX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d51ba18e1bso25279025ad.0
        for <stable@vger.kernel.org>; Mon, 29 Jan 2024 02:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706524750; x=1707129550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjA5TtX+Wm6xDULncD67izBz79MrRw2UdYFZVqQtyg0=;
        b=e1z9sVGXuEPe4SwVrlutN/xwS6N4uQrwCVeDAcn36EujJQYWeAG7J+aeehkGUz6+DR
         6XYzLmlRMoQVwzyYlzFVVFgqrFvO14kGG0AU1uFE3EvH7AtJpqGuyUn4kCM08EY4kYL5
         6nBYTlnJHqNbjNMLoQQInsWiroQehgZa2Vw7zndtvaNJl84n7F8zv2eR8YSZ0QA5Jljz
         179PvZzrWPyu9YLbltWjFDqLivC8Iv0KsS8ZCr0zwwPGuYIuutf9BZBhGWpE+793IY0v
         6wWYLcL5Go+qdZHvDdlumzp5LsNKem5kLUcPTjgpkw2wozGSSrQWKEpil6R7yNT07gA2
         aWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706524750; x=1707129550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjA5TtX+Wm6xDULncD67izBz79MrRw2UdYFZVqQtyg0=;
        b=iaHIYag/G7qFIgB4Mbwq12CQ8zcL/9pm2xAGuWa1/H3Tn/gsFlM7ID+GinyKIBtbmX
         Uw5IPIUZkjOtJLwztcmMWRnDssiogjWazd+k1tj7HFtlKC9cfJaBzU3NzLzQ71ei/Kuk
         RtrtgENZ1ZEPrVc6yxGFefv7a7ejtCLr8cFkkeWARgJsxEw6sr4f0fjI+ot1zaSLHHwM
         bp4+C4cYA9wybr/vQWndvMAmnxVC6sQ+sGjj6XXqguS9x2R14jypW8sq8NuI2keiQuK+
         HWwzATvS2QeQHrkCyh7LbygjJ9y+EU4OVIpN3RJhBaFMvCdFZZW4WvoiFTZSGzOf3Dqt
         hkZA==
X-Gm-Message-State: AOJu0YwIKbTIjeCUuM/UZBa7Vw24r36A/44HQ5ASke7F7Rmfmasl/2VG
	ICY/naUMxtHvfStmqURe9tk1GVkorFTkR9k392hXLQywrRu7Mxo4wwkR6QwfRnk=
X-Google-Smtp-Source: AGHT+IHOUeMVp65qaWAS2lhB47p6MJM2Vyc3u9KtwR5y8wEZgszYBoyg7ZkmKCLrIaJr8Ft/ucffNA==
X-Received: by 2002:a17:90b:303:b0:290:5c7b:81b6 with SMTP id ay3-20020a17090b030300b002905c7b81b6mr2941005pjb.33.1706524749774;
        Mon, 29 Jan 2024 02:39:09 -0800 (PST)
Received: from x-wing.lan ([106.51.161.37])
        by smtp.gmail.com with ESMTPSA id fa13-20020a17090af0cd00b0029564dec437sm2285401pjb.6.2024.01.29.02.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:39:09 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Stable <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH for-v5.4.y 1/3] PM: runtime: add devm_pm_runtime_enable helper
Date: Mon, 29 Jan 2024 16:09:00 +0530
Message-Id: <20240129103902.3239531-2-amit.pundir@linaro.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit b3636a3a2c51715736d3ec45f635ed03191962ce ]

A typical code pattern for pm_runtime_enable() call is to call it in the
_probe function and to call pm_runtime_disable() both from _probe error
path and from _remove function. For some drivers the whole remove
function would consist of the call to pm_remove_disable().

Add helper function to replace this bolierplate piece of code. Calling
devm_pm_runtime_enable() removes the need for calling
pm_runtime_disable() both in the probe()'s error path and in the
remove() function.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20210731195034.979084-2-dmitry.baryshkov@linaro.org
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: 3d07a411b4fa ("drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks")
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/base/power/runtime.c | 17 +++++++++++++++++
 include/linux/pm_runtime.h   |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 626f22c01f2f..f31609f3e7fa 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1475,6 +1475,23 @@ void pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
+static void pm_runtime_disable_action(void *data)
+{
+	pm_runtime_disable(data);
+}
+
+/**
+ * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_enable(struct device *dev)
+{
+	pm_runtime_enable(dev);
+
+	return devm_add_action_or_reset(dev, pm_runtime_disable_action, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
+
 /**
  * pm_runtime_forbid - Block runtime PM of a device.
  * @dev: Device to handle.
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index c7c754884cdc..eda6619a6358 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -60,6 +60,8 @@ extern void pm_runtime_put_suppliers(struct device *dev);
 extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
 
+extern int devm_pm_runtime_enable(struct device *dev);
+
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
 {
 	dev->power.ignore_children = enable;
@@ -156,6 +158,8 @@ static inline void __pm_runtime_disable(struct device *dev, bool c) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 
+static inline int devm_pm_runtime_enable(struct device *dev) { return 0; }
+
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
 static inline void pm_runtime_get_noresume(struct device *dev) {}
 static inline void pm_runtime_put_noidle(struct device *dev) {}
-- 
2.25.1



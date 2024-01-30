Return-Path: <stable+bounces-17401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8F984253E
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 13:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C96282086
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 12:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A396267E79;
	Tue, 30 Jan 2024 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iBf7hWOn"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB08845BE7
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618801; cv=none; b=b4S2jBMygagwP28mWOGmM6kAJCyY6yhqtV/TUzKJRiKA33xQcpNdk/HxHSAWm58T86BhmaPNqhfxjVq11BXZ/EdX1ul7wmnKaW9m6DboM8z25+2aB7kQUgfZEdxFvtIDFIH2mPEDHEvDvdj40Sd/EpIDHMHW3FuyfiWY+n8fUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618801; c=relaxed/simple;
	bh=eLO79UZmB14OMR3v4JQd0Uq0Bn9Kgn/+RfqFHbzgIZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VZ7I2AaDJ5rnXiKeal5YWBr7h6LAGUiN/UwmsEuY5C7ovwvBdujPAVJlJT0ihklZ/w21yZ0jr79Wp5DE1U0VhsdjCTOLWVasmBnKv/cobfeoLVu8r3tKEr7ei/VtIUzMOCFVU7X8ItGoa87emEez2Dl26DB/Ms++V9Jwd0ziOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iBf7hWOn; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-599f5e71d85so2510128eaf.3
        for <stable@vger.kernel.org>; Tue, 30 Jan 2024 04:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706618799; x=1707223599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyAgvnQ0mmKiKYxS/FoZ0JqdZh7W1foioMnyXirIDbU=;
        b=iBf7hWOnzHlkzSk+FT5zujAgv1wtih3VdXIOodWkCbCVnG6MqZsW4eb3biuvm1GPoP
         zgUFOPuNvFiy/2ZUKFTVbizHhfNScHibb62Xx5nzZIXUFVGq1MOr5diHCxlt5sVzk9lF
         Yta9ONt6KQdlR1DK/mMKdAUjXNKu6k1CHeTwp0rbO5iiJtz9i/S+ODSk7rL8vEYGmHyS
         tQPElriYnmkQOhgsBYOxCFy1gZbtLfKkbBJVWW19QVQ1ak71kme82fDWrTFD25s6Y1XS
         /+372tZecio1LUkJsQtdOEPjfgyHehdEcaOeHL3EySHZow3PyRot8k0biYSkJRmel4je
         K2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618799; x=1707223599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyAgvnQ0mmKiKYxS/FoZ0JqdZh7W1foioMnyXirIDbU=;
        b=l/qlGvpk7H4dtO4NL0J3Kj1vnV0nvbZ8codirP7b4wgcD7eAGKpWW6vM0cvVMEgLLE
         xCkbUTviQld8yFoEgx2J813/q7COuF3N9e3Zs4Ri0mzlXMqS21Nd8Gp0tQC/kQvXwLoZ
         pGIVIEs9OQ8hG4lw0PKiRwKnoC8q4QFOlxMKEgT/99FhQwE3K7szeUvB562YRea4irAT
         eiS/dkxKk1BtTw0I2UKj9g7aSGBbi3Ac1QUospx53QdfNTji6X8poDkuIoWVsv0CmrQ0
         F41U2gAMXb0/UjssQy7Azx26pg0DfIEnwpOfBnErrfp06wSjHnrhBCJKqjBubAqn4psa
         L7gg==
X-Gm-Message-State: AOJu0YzoZJcH2M6fVLPbyBrISzq8queEmx6eCWpaAB+FLgR0qGwJpcyO
	WlmPkXKOG8Xhuj/kjKMuYWKCP6Fi5SAIEUi4VknctwkJCFKfhH/5AAIjcHqIpwM=
X-Google-Smtp-Source: AGHT+IGDL9d8h5bfcGpHkiGfVgRu0ZRR3+X35YG3/3wJ0b+6OgpEPuHb1grFM5/PNV396MRqwne/mA==
X-Received: by 2002:a05:6358:2783:b0:178:76f8:e626 with SMTP id l3-20020a056358278300b0017876f8e626mr4010923rwb.6.1706618798853;
        Tue, 30 Jan 2024 04:46:38 -0800 (PST)
Received: from x-wing.lan ([106.51.161.37])
        by smtp.gmail.com with ESMTPSA id p3-20020aa79e83000000b006dddd3e31a8sm7658788pfq.219.2024.01.30.04.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:46:38 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Stable <stable@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH for-v5.10.y 1/3] PM: runtime: add devm_pm_runtime_enable helper
Date: Tue, 30 Jan 2024 18:16:28 +0530
Message-Id: <20240130124630.3867218-2-amit.pundir@linaro.org>
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
index fbbc3ed143f2..9d0865cbf913 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1479,6 +1479,23 @@ void pm_runtime_enable(struct device *dev)
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
index 718600e83020..b33d26ed7a1b 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -60,6 +60,8 @@ extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
 extern void pm_runtime_release_supplier(struct device_link *link);
 
+extern int devm_pm_runtime_enable(struct device *dev);
+
 /**
  * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
  * @dev: Target device.
@@ -254,6 +256,8 @@ static inline void __pm_runtime_disable(struct device *dev, bool c) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 
+static inline int devm_pm_runtime_enable(struct device *dev) { return 0; }
+
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
 static inline void pm_runtime_get_noresume(struct device *dev) {}
 static inline void pm_runtime_put_noidle(struct device *dev) {}
-- 
2.25.1



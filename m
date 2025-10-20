Return-Path: <stable+bounces-188102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE0EBF16CC
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3501888693
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB031C5D7D;
	Mon, 20 Oct 2025 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1g4ueMJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E49D2FE587
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965507; cv=none; b=rf6iQwXLrBnW+XFixx87troOZnyaIXcQV5Shon/89N93JoJ91nxzcdeAjVYhPmU/7+n+Wpry/hB7JlJgn/p9ul3Rx6wBHrD52Gm39DRoPMYi26tjDjbYuQhLOw+QaAyiecFvsJNhcJC8QKo9btvfA13JM4/FsdPhrBOujG4f+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965507; c=relaxed/simple;
	bh=B1DLoAhp8fyfP0n0Sj9cq/VIFgYK/knROOPky7bSsDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOcQpnHnCnMydAH7iv66a4O/uVWuBn+7BXVB9oG0dMEpuyKObmsYkhBmbrDo3elB3iCALlvRXgfeMCdvaSLaKKT+5IOuEpyArLOxmJoOT4ih/ojTFwZKE4VsgBVzZKj9y4Lqh9B7nnldihECVGRq5Ag11SLgz6JASrdmzAUto6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1g4ueMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D26CC4CEF9;
	Mon, 20 Oct 2025 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965506;
	bh=B1DLoAhp8fyfP0n0Sj9cq/VIFgYK/knROOPky7bSsDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l1g4ueMJqLZZruz1fMcpg1XPxCRJlXKBEdGMnY8SRYBZ8XotVAcu1aonUDqWlJp+1
	 5G2tUToCrYkWaO1Rqm1TTP4xOeZ3rupqOgbx7aGGd33XZDll+vi0HzHghmCT+3IXsg
	 D9yrCNHRRE+tr451QpOwJJ7eWRbOPRusnRTpy/vVFV5WyrZAXL47xYK9H3WYXvTnIB
	 PpYdRWhmfO9ttrm8npfMpAE/SlZfFE6TizhWj9n1IK24yur2VkTkmssKb46W2o+dxo
	 vnuRebbNo1ndjZiPXdW99OZ4CrQWXgwylI0X0ARsE14VXHcKxR9gQo1b8WqHsKnG2f
	 KxHPuuPUkxOIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] PM: runtime: Add new devm functions
Date: Mon, 20 Oct 2025 09:05:02 -0400
Message-ID: <20251020130503.1764881-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101603-magnetism-bonded-4bc7@gregkh>
References: <2025101603-magnetism-bonded-4bc7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bence Csókás <csokas.bence@prolan.hu>

[ Upstream commit 73db799bf5efc5a04654bb3ff6c9bf63a0dfa473 ]

Add `devm_pm_runtime_set_active_enabled()` and
`devm_pm_runtime_get_noresume()` for simplifying
common cases in drivers.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
Link: https://patch.msgid.link/20250327195928.680771-3-csokas.bence@prolan.hu
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 0792c1984a45 ("iio: imu: inv_icm42600: Simplify pm_runtime setup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/runtime.c | 44 ++++++++++++++++++++++++++++++++++++
 include/linux/pm_runtime.h   |  4 ++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7e912d2ed4270..31b77cf9cc8e0 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1479,6 +1479,32 @@ void pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
+static void pm_runtime_set_suspended_action(void *data)
+{
+	pm_runtime_set_suspended(data);
+}
+
+/**
+ * devm_pm_runtime_set_active_enabled - set_active version of devm_pm_runtime_enable.
+ *
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_set_active_enabled(struct device *dev)
+{
+	int err;
+
+	err = pm_runtime_set_active(dev);
+	if (err)
+		return err;
+
+	err = devm_add_action_or_reset(dev, pm_runtime_set_suspended_action, dev);
+	if (err)
+		return err;
+
+	return devm_pm_runtime_enable(dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_set_active_enabled);
+
 static void pm_runtime_disable_action(void *data)
 {
 	pm_runtime_dont_use_autosuspend(data);
@@ -1501,6 +1527,24 @@ int devm_pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
 
+static void pm_runtime_put_noidle_action(void *data)
+{
+	pm_runtime_put_noidle(data);
+}
+
+/**
+ * devm_pm_runtime_get_noresume - devres-enabled version of pm_runtime_get_noresume.
+ *
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_get_noresume(struct device *dev)
+{
+	pm_runtime_get_noresume(dev);
+
+	return devm_add_action_or_reset(dev, pm_runtime_put_noidle_action, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_get_noresume);
+
 /**
  * pm_runtime_forbid - Block runtime PM of a device.
  * @dev: Device to handle.
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 96e3256738e48..3f3ec089c4a4a 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -61,7 +61,9 @@ extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
 extern void pm_runtime_release_supplier(struct device_link *link);
 
+int devm_pm_runtime_set_active_enabled(struct device *dev);
 extern int devm_pm_runtime_enable(struct device *dev);
+int devm_pm_runtime_get_noresume(struct device *dev);
 
 /**
  * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
@@ -258,7 +260,9 @@ static inline void __pm_runtime_disable(struct device *dev, bool c) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 
+static inline int devm_pm_runtime_set_active_enabled(struct device *dev) { return 0; }
 static inline int devm_pm_runtime_enable(struct device *dev) { return 0; }
+static inline int devm_pm_runtime_get_noresume(struct device *dev) { return 0; }
 
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
 static inline void pm_runtime_get_noresume(struct device *dev) {}
-- 
2.51.0



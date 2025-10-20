Return-Path: <stable+bounces-188094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A861BF167E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2775034D258
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A441A245033;
	Mon, 20 Oct 2025 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYiwPngl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CF86340
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965362; cv=none; b=uPrp9YQPhxIuruI8nOpeswwS4n682cQ6XPVxWsUiyMjy1j9tt63tuROSlL7Ilqku5kA3ZLVksTqE+8HiDIHa+ItPeG7quBitj6KtRxq1yszHDLzd6hL1jhgT2YFhjZzr1qL7aofiJyStbQbC+wXxdxvNcG9bLvfeRK24T5WWkgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965362; c=relaxed/simple;
	bh=eURljFdtd4uZO2brBIVQEhRi0CtuCCnRfb78LhSgK0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpcJP273gwp9ciV0k3BQIceqXS3V9wtwdX2jqeYIk6E/O8l8tTaYDWWrc47V05AS7pvnvoy7UVOWu38QbXCSEkhZRrvRR/Tj0BFdSuEtLBlv2oR9g/duxMU6y/0Sim6zgokQ1YZ0/UMVYE9foZhZufXLzfDC12px+WKviO6XS/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYiwPngl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D48C4CEF9;
	Mon, 20 Oct 2025 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965361;
	bh=eURljFdtd4uZO2brBIVQEhRi0CtuCCnRfb78LhSgK0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYiwPnglu8frdWwrqqJ9WDBqe4QKfSpcQS3B02ldGRGXuiURzQoOcPkGQJxbQBy5z
	 1oCbYFFVpNjqaBAi64zu2JQG/bFG1i5cvNioVfCLDUcwXj3Ztr48cJqKb5ogZnBZyS
	 H5tB0X1mqBTbfoBWNuAOqcHRZKW4mgPuFaQIxroEITWxSyZEC5I+0LZzSVKYs6dC/1
	 BcvxGrJx5D+tNZRJWdoAFZwc2/UWTBrkskFoAsCyyiXt/AwK0QLR4OsWxTGRv+pfhL
	 VVqtt3dsQHmsZuvPNCBZYuqz1/dDS07sUvJJWiPEGhvQ4JlcrZX6aTiE82tNl2AimF
	 7AUJBGY67phxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] PM: runtime: Add new devm functions
Date: Mon, 20 Oct 2025 09:02:38 -0400
Message-ID: <20251020130239.1763909-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101601-manicure-opposite-4330@gregkh>
References: <2025101601-manicure-opposite-4330@gregkh>
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
index c7ec69597a955..d8aaa5b61628b 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1554,6 +1554,32 @@ void pm_runtime_enable(struct device *dev)
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
@@ -1576,6 +1602,24 @@ int devm_pm_runtime_enable(struct device *dev)
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
index d0b29cd1fd204..142ab39a3b386 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -94,7 +94,9 @@ extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
 extern void pm_runtime_release_supplier(struct device_link *link);
 
+int devm_pm_runtime_set_active_enabled(struct device *dev);
 extern int devm_pm_runtime_enable(struct device *dev);
+int devm_pm_runtime_get_noresume(struct device *dev);
 
 /**
  * pm_suspend_ignore_children - Set runtime PM behavior regarding children.
@@ -278,7 +280,9 @@ static inline void __pm_runtime_disable(struct device *dev, bool c) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 
+static inline int devm_pm_runtime_set_active_enabled(struct device *dev) { return 0; }
 static inline int devm_pm_runtime_enable(struct device *dev) { return 0; }
+static inline int devm_pm_runtime_get_noresume(struct device *dev) { return 0; }
 
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
 static inline void pm_runtime_get_noresume(struct device *dev) {}
-- 
2.51.0



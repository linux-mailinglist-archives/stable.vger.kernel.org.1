Return-Path: <stable+bounces-103287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6C39EF6BD
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDDC17C1F8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6634021766D;
	Thu, 12 Dec 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SqP7Ha8J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24137176AA1;
	Thu, 12 Dec 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024109; cv=none; b=Lz7AgnJAQeWPPCvBuPJKl3ASHdxMcNqOcIWZX9PrKht74zdvDZWpFD4OUBgliIOikIWy60NUdtXN0kY82qDXnx/wfKhWVy9DKuc5i8iKP3hqe0Nv1+MsPGSYLeAXhCM80J/IlfS5HOfTDefSAsxAn1v9VBIwmvlkAoDHR7YVFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024109; c=relaxed/simple;
	bh=LxcfUMhJho2VIDMBhbfMbPDbyGM/U0vTsX0NLOURVpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqhr+YQ4Siv/3i7f5jcp0oRzbX6yAkBjkZv4FycqdWADRmWajcNA5Ch4egs4ppQ8dFfWtgScuD0AXequZYeqGA+38ojsiU0E0Dwtci597zyD6uOVtrS3+6GXppulHfnShMcpvBdm8fe9zxgWVo2jfI53Xc5bsHOtzSFUXzsulHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SqP7Ha8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998AEC4CECE;
	Thu, 12 Dec 2024 17:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024109;
	bh=LxcfUMhJho2VIDMBhbfMbPDbyGM/U0vTsX0NLOURVpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqP7Ha8JURVJLLHPwKF0oiqGW5uOcmGnxb56jWB26FRSmgOL4zHRe7deiBICnEQVq
	 vTCXlJRnz3FosD/eE6KoLJn7i7JRqjEzVlfkfFL4BtlrcjBruKRrnfrhMT6qx9hEtX
	 adnpABN8twk7/5S6pp5/LrnRXJHIdGYbcZfEsF4I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 159/459] driver core: Introduce device_find_any_child() helper
Date: Thu, 12 Dec 2024 15:58:17 +0100
Message-ID: <20241212144259.797847629@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 82b070beae1ef55b0049768c8dc91d87565bb191 ]

There are several places in the kernel where this kind of functionality is
being used. Provide a generic helper for such cases.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20220610120219.18988-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 27aabf27fd01 ("Bluetooth: fix use-after-free in device_for_each_child()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/core.c    | 20 ++++++++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b13a60de5a863..82eb25ad1c72e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3419,6 +3419,26 @@ struct device *device_find_child_by_name(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(device_find_child_by_name);
 
+static int match_any(struct device *dev, void *unused)
+{
+	return 1;
+}
+
+/**
+ * device_find_any_child - device iterator for locating a child device, if any.
+ * @parent: parent struct device
+ *
+ * This is similar to the device_find_child() function above, but it
+ * returns a reference to a child device, if any.
+ *
+ * NOTE: you will need to drop the reference with put_device() after use.
+ */
+struct device *device_find_any_child(struct device *parent)
+{
+	return device_find_child(parent, NULL, match_any);
+}
+EXPORT_SYMBOL_GPL(device_find_any_child);
+
 int __init devices_init(void)
 {
 	devices_kset = kset_create_and_add("devices", &device_uevent_ops, NULL);
diff --git a/include/linux/device.h b/include/linux/device.h
index 9c9ce573c737f..d615719b19d4d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -834,6 +834,8 @@ struct device *device_find_child(struct device *dev, void *data,
 				 int (*match)(struct device *dev, void *data));
 struct device *device_find_child_by_name(struct device *parent,
 					 const char *name);
+struct device *device_find_any_child(struct device *parent);
+
 int device_rename(struct device *dev, const char *new_name);
 int device_move(struct device *dev, struct device *new_parent,
 		enum dpm_order dpm_order);
-- 
2.43.0





Return-Path: <stable+bounces-190058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E973C0FAB4
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E245E425235
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831493168F7;
	Mon, 27 Oct 2025 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcfCpyX2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417192D4B4B
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586351; cv=none; b=UJLqSCyHZEZ7jKPQMn7bndTsQWYAJqWgc7a/EM5wSufYHAePJFj0CX/zow/xbOakFi9dG5z67TBQ4QG8rjvfL1FTlKTXd+hJw89rm8dVFfWu6R+5caqWWr+EGuqcPqjWi56F/q6RQD1G29j8yz8YCv1mSZhus42KKEPJ0dd+DtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586351; c=relaxed/simple;
	bh=1dtwPEwyElk0RZrRl2fPV3UJcAUJrOv10T9P2LaSFa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwvuRde30nJWSDOz+b9o8ryeDEn8RV35WNTNAL6euWqfyeO/LyXq3ibjeFgMxeOOwN/1rVmHdJXtBDsjcvsw5zxqx02c9zKd+tVwti0dkhagx9lfCPhHzcccpPsboUKG1KlA69Ivd5a2bdeuxRkLWJ5LIiG7xnpljfSFV1mgW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcfCpyX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E30C16AAE;
	Mon, 27 Oct 2025 17:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761586350;
	bh=1dtwPEwyElk0RZrRl2fPV3UJcAUJrOv10T9P2LaSFa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KcfCpyX2JOzzVexWHHfC6aoGUrnZmFxYhHlmvW8khQfPOjcP7tnxnh8EHXa37iCIG
	 cg2SFtGdCxEbrHq2109gdO5vC62r5wNtP6udWjG0b4s5Ss+vA/K74DuIZdJsrb23SS
	 CEh43EQPuaeTmYCvuisfLBsxFP/3vAPWZlLsoUoWV0Ze1q5w3Lp83En6CPlggI73LM
	 2ZtjqpvmJGPZdlt0HZdtKDdmCj6xs005IodKNNFno0+CZCAtFdIGO2hztscFdaT3xT
	 0hrabP7ZK7kWE02LB6hK62iuYD0EYm2uxvJpV/vawFf9d3vzB7OriuXTRkH9CxkekY
	 j4N/0J1aDlKOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Uday M Bhat <uday.m.bhat@intel.com>,
	Samuel Jacob <samjaco@google.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/6] xhci: dbc: Allow users to modify DbC poll interval via sysfs
Date: Mon, 27 Oct 2025 13:32:23 -0400
Message-ID: <20251027173226.609057-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027173226.609057-1-sashal@kernel.org>
References: <2025102713-cucumber-persevere-aa50@gregkh>
 <20251027173226.609057-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Uday M Bhat <uday.m.bhat@intel.com>

[ Upstream commit de3edd47a18fe05a560847cc3165871474e08196 ]

xhci DbC driver polls the host controller for DbC events at a reduced
rate when DbC is enabled but there are no active data transfers.

Allow users to modify this reduced poll interval via dbc_poll_interval_ms
sysfs entry. Unit is milliseconds and accepted range is 0 to 5000.
Max interval of 5000 ms is selected as it matches the common 5 second
timeout used in usb stack.
Default value is 64 milliseconds.

A long interval is useful when users know there won't be any activity
on systems connected via DbC for long periods, and want to avoid
battery drainage due to unnecessary CPU usage.

Example being Android Debugger (ADB) usage over DbC on ChromeOS systems
running Android Runtime.

[minor changes and rewording -Mathias]

Co-developed-by: Samuel Jacob <samjaco@google.com>
Signed-off-by: Samuel Jacob <samjaco@google.com>
Signed-off-by: Uday M Bhat <uday.m.bhat@intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20240626124835.1023046-5-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: f3d12ec847b9 ("xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with stall event")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/sysfs-bus-pci-drivers-xhci_hcd    | 10 +++++
 drivers/usb/host/xhci-dbgcap.c                | 38 +++++++++++++++++++
 drivers/usb/host/xhci-dbgcap.h                |  2 +-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-drivers-xhci_hcd b/Documentation/ABI/testing/sysfs-bus-pci-drivers-xhci_hcd
index 5a775b8f65435..fc82aa4e54b00 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-drivers-xhci_hcd
+++ b/Documentation/ABI/testing/sysfs-bus-pci-drivers-xhci_hcd
@@ -75,3 +75,13 @@ Description:
 		The default value is 1  (GNU Remote Debug command).
 		Other permissible value is 0 which is for vendor defined debug
 		target.
+
+What:		/sys/bus/pci/drivers/xhci_hcd/.../dbc_poll_interval_ms
+Date:		February 2024
+Contact:	Mathias Nyman <mathias.nyman@linux.intel.com>
+Description:
+		This attribute adjust the polling interval used to check for
+		DbC events. Unit is milliseconds. Accepted values range from 0
+		up to 5000. The default value is 64 ms.
+		This polling interval is used while DbC is enabled but has no
+		active data transfers.
diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 79d70e5aaa92c..643afd3ab0988 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -1214,11 +1214,48 @@ static ssize_t dbc_bInterfaceProtocol_store(struct device *dev,
 	return size;
 }
 
+static ssize_t dbc_poll_interval_ms_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct xhci_dbc *dbc;
+	struct xhci_hcd *xhci;
+
+	xhci = hcd_to_xhci(dev_get_drvdata(dev));
+	dbc = xhci->dbc;
+
+	return sysfs_emit(buf, "%u\n", dbc->poll_interval);
+}
+
+static ssize_t dbc_poll_interval_ms_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t size)
+{
+	struct xhci_dbc *dbc;
+	struct xhci_hcd *xhci;
+	u32 value;
+	int ret;
+
+	ret = kstrtou32(buf, 0, &value);
+	if (ret || value > DBC_POLL_INTERVAL_MAX)
+		return -EINVAL;
+
+	xhci = hcd_to_xhci(dev_get_drvdata(dev));
+	dbc = xhci->dbc;
+
+	dbc->poll_interval = value;
+
+	mod_delayed_work(system_wq, &dbc->event_work, 0);
+
+	return size;
+}
+
 static DEVICE_ATTR_RW(dbc);
 static DEVICE_ATTR_RW(dbc_idVendor);
 static DEVICE_ATTR_RW(dbc_idProduct);
 static DEVICE_ATTR_RW(dbc_bcdDevice);
 static DEVICE_ATTR_RW(dbc_bInterfaceProtocol);
+static DEVICE_ATTR_RW(dbc_poll_interval_ms);
 
 static struct attribute *dbc_dev_attributes[] = {
 	&dev_attr_dbc.attr,
@@ -1226,6 +1263,7 @@ static struct attribute *dbc_dev_attributes[] = {
 	&dev_attr_dbc_idProduct.attr,
 	&dev_attr_dbc_bcdDevice.attr,
 	&dev_attr_dbc_bInterfaceProtocol.attr,
+	&dev_attr_dbc_poll_interval_ms.attr,
 	NULL
 };
 
diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index d165bafecd98f..313b5e97a4672 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -94,7 +94,7 @@ struct dbc_ep {
 #define DBC_QUEUE_SIZE			16
 #define DBC_WRITE_BUF_SIZE		8192
 #define DBC_POLL_INTERVAL_DEFAULT	64	/* milliseconds */
-
+#define DBC_POLL_INTERVAL_MAX		5000	/* milliseconds */
 /*
  * Private structure for DbC hardware state:
  */
-- 
2.51.0



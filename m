Return-Path: <stable+bounces-188194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 936E1BF26BC
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA57A3A6002
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E627287504;
	Mon, 20 Oct 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNEY6FRp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3BA27466A
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977523; cv=none; b=hTFFu6EA9B3hlLimaYJTobzBM6voXyu0Vm/snJfJwvhcJ3Ff+sBI5kjM9kcRwv/18rN6PwFqnrG5+Hm28U5zp0ikq4+Tnqm9bO4ABHJcu1k8qVgQQbfZhDRkzR04yC4/TFr4mkuAUQvV321VUkNfENpmHXW2U0nIoslcYB/ltU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977523; c=relaxed/simple;
	bh=tQfmlhF/9qUCCfo1yxLduDV7fs6BncPVpVR5jEBuuHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isgDprNhkq2glzeKCVCeuSJxPE/E6xPiRR6XkhVyxz0AiDrBNIKXygpkDwOW0jR01gKlg19n85XD9SC7gQC3WA2WRCOh7XzYm6oOFEfoIFrRjZ2/I9NQ98FCaKoJ3mHgzgDh793SL3K9tBZhdJWEgaPQbUFs2m6fg46paJyNdXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNEY6FRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF5BC4CEF9;
	Mon, 20 Oct 2025 16:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977521;
	bh=tQfmlhF/9qUCCfo1yxLduDV7fs6BncPVpVR5jEBuuHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNEY6FRpg40oE0PEOVRcweCWUVWxVIL4dwxM/1SlVxZWIDCPZvQmH1cOoHihzI+id
	 LOOOuLq97PVjXEdMdBmkOofRCse42UxYYsHuJFbmSum4qFVpI0Tot1iAdxsvO10BgG
	 SZm/liNNEZRAk9QruLI1jt8H/bObrHXeKo7drvvXET50ne1JdlteLnv+LqOCU7koGR
	 Fv7WfShr5c7PSlLCnB4ZoO7DkL4SRHd+9s43E+cCiy1SCjVXnjFVWiaIde/7jW7SjI
	 4kk1yDGDhm1b7UnYesKQh9DWXZCPKj46n8ZnQPo8fuIlTTb42I5WRw5lMAHyZ8hX1N
	 rkbaLIp8RwIyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] PCI: Add sysfs attribute for device power state
Date: Mon, 20 Oct 2025 12:25:16 -0400
Message-ID: <20251020162518.1838256-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101636-tartar-brethren-067c@gregkh>
References: <2025101636-tartar-brethren-067c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maximilian Luz <luzmaximilian@gmail.com>

[ Upstream commit 80a129afb75cba8434fc5071bd6919172442315c ]

While PCI power states D0-D3hot can be queried from user-space via lspci,
D3cold cannot.  lspci cannot provide an accurate value when the device is
in D3cold as it has to restore the device to D0 before it can access its
power state via the configuration space, leading to it reporting D0 or
another on-state. Thus lspci cannot be used to diagnose power consumption
issues for devices that can enter D3cold or to ensure that devices properly
enter D3cold at all.

Add a new sysfs device attribute for the PCI power state, showing the
current power state as seen by the kernel.

[bhelgaas: drop READ_ONCE(), see discussion at the link]
Link: https://lore.kernel.org/r/20201102141520.831630-1-luzmaximilian@gmail.com
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Stable-dep-of: 48991e493507 ("PCI/sysfs: Ensure devices are powered for config reads")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
 drivers/pci/pci-sysfs.c                 | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index da33ab66ddfe7..9d499a126e87f 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -377,3 +377,12 @@ Contact:	Heiner Kallweit <hkallweit1@gmail.com>
 Description:	If ASPM is supported for an endpoint, these files can be
 		used to disable or enable the individual power management
 		states. Write y/1/on to enable, n/0/off to disable.
+
+What:		/sys/bus/pci/devices/.../power_state
+Date:		November 2020
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		This file contains the current PCI power state of the device.
+		The value comes from the PCI kernel device state and can be one
+		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
+		The file is read only.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d27bc5a5d2f86..5a9d942198586 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -124,6 +124,15 @@ static ssize_t cpulistaffinity_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(cpulistaffinity);
 
+static ssize_t power_state_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%s\n", pci_power_name(pdev->current_state));
+}
+static DEVICE_ATTR_RO(power_state);
+
 /* show resources */
 static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -603,6 +612,7 @@ static ssize_t driver_override_show(struct device *dev,
 static DEVICE_ATTR_RW(driver_override);
 
 static struct attribute *pci_dev_attrs[] = {
+	&dev_attr_power_state.attr,
 	&dev_attr_resource.attr,
 	&dev_attr_vendor.attr,
 	&dev_attr_device.attr,
-- 
2.51.0



Return-Path: <stable+bounces-188207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8BFBF2B5D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457CB40145D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B797D32F75B;
	Mon, 20 Oct 2025 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQ5nUlC6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CA2221FC8
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981325; cv=none; b=R5zUNItqUc9zwAZlASRdOYkChdl66Oy78tRvi9JUPIkZnjsoZ8BJYPqGmXXsQlHlhA6PlSRP4WJDeDwK3C937Vw82tOoLyCtHmjUfg8/HeCjbySqIDo/qIsEIeXmVd5U/YyQklnMdbRaXP1dBmA7LZT8QmW5CFa2mG/tNj65+yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981325; c=relaxed/simple;
	bh=PK5/+yo0jaFFQBscU1Qq+jqiTEz7QPQwEBXk87iDKI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=or8RicEWDEIR7AWIoa1euPpJwIZIj1AuC3hKNtQD9NyCklttKAEpJgxrpS0M78ykN/yZarK+LR4KUUeh5ibpfqu1Hjd01HqycRy4MOQNb8Q6CSyWgtP6gVOpiSTKAZIwiV9Rxzsvr3+7oyEFGnlANnPKavQl+VGXA7Td44cCEIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQ5nUlC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AC9C4CEF9;
	Mon, 20 Oct 2025 17:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760981324;
	bh=PK5/+yo0jaFFQBscU1Qq+jqiTEz7QPQwEBXk87iDKI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQ5nUlC6DGLG4uEqoWijSulCAm/4gGSJaytY27IM4yDrWdcnABA2nYuQn+raPjFFh
	 uSOXd/Xy9aF70wSS7L/lzDlbqom6Ex0WineeiOpIhzyNdzpVkV2jgf324HkOoSQvTh
	 Jf5V0wySJwEaOecIoUKmyRRz2/X97SNkcXquTNizcWGVc7ucLLLZRD4hsD2mbkX0oA
	 CWFZXL/7khd7e2DIBfIfsQ5JA42lR7JHSJCWLNXMVsBJGNIZsI7lAAIt5mVDInCFHD
	 GKBcWtcPvUcKmdlNWLaooj0U0zv4XS4xSZgFa+RFE5QNuy0aDtTNe1cICtAnnYMin0
	 IUHg2C4Q2q5DQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] PCI: Add PCI_VDEVICE_SUB helper macro
Date: Mon, 20 Oct 2025 13:28:38 -0400
Message-ID: <20251020172841.1850940-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102050-stadium-reformer-c157@gregkh>
References: <2025102050-stadium-reformer-c157@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

[ Upstream commit 208fff3f567e2a3c3e7e4788845e90245c3891b4 ]

PCI_VDEVICE_SUB generates the pci_device_id struct layout for
the specific PCI device/subdevice. Private data may follow the
output.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: a7075f501bd3 ("ixgbevf: fix mailbox API compatibility by negotiating supported features")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pci.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6b3fef24d60e7..452a3dca28eaa 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1066,6 +1066,20 @@ struct pci_driver {
 	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0
 
+/**
+ * PCI_VDEVICE_SUB - describe a specific PCI device/subdevice in a short form
+ * @vend: the vendor name
+ * @dev: the 16 bit PCI Device ID
+ * @subvend: the 16 bit PCI Subvendor ID
+ * @subdev: the 16 bit PCI Subdevice ID
+ *
+ * Generate the pci_device_id struct layout for the specific PCI
+ * device/subdevice. Private data may follow the output.
+ */
+#define PCI_VDEVICE_SUB(vend, dev, subvend, subdev) \
+	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
+	.subvendor = (subvend), .subdevice = (subdev), 0, 0
+
 /**
  * PCI_DEVICE_DATA - macro used to describe a specific PCI device in very short form
  * @vend: the vendor name (without PCI_VENDOR_ID_ prefix)
-- 
2.51.0



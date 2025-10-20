Return-Path: <stable+bounces-188236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA3EBF34A6
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 21:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC83B4869A5
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2CB2D3EEE;
	Mon, 20 Oct 2025 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl+QHP/G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A6928C866
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990032; cv=none; b=Db/CE3FedqMQOIw+A6c149NZ+ei+7K5UTiZoo6OkuWpD7XaoN+VbzEDqXMxCMWL//MmDmszLuddkDswWYFZv8IYdlTRYA+/jpLOrNK5Qckzd3kOuiLfIUdfQMP0kSpm+Zp9uhEuQu6AQUsn5dEObnnXn93nbNQ606PS9LHi5m74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990032; c=relaxed/simple;
	bh=oru6iVxa4DQtjK63OXJK8eqQHCpLkF9JbBzmUBirhgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cG9aiEVfLe2M+/N57hqJ0bTYjDEWeL1Tu2dVdmrid1PxfUdFbgJbR7gjLvn9I94+8eI/NDJ1YDqAcb4X7YQ0J47s6Sp6lw5R0gwK0uPTSFF0+DYAzYAUtCTv3dEBTTEfJAvxXtAN8HAA0ta1DD5sDHrjiALJqxfiUUwTFL2ZdE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl+QHP/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268BFC113D0;
	Mon, 20 Oct 2025 19:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760990031;
	bh=oru6iVxa4DQtjK63OXJK8eqQHCpLkF9JbBzmUBirhgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zl+QHP/GIJgn/oI7pjjHblMky9Zt85U0qgxILjou3CuAGtsHT3Ua7Y1/7bccBV3QH
	 TWwcjfv+esTBFJgf8k7HEvceNhRSuQdP4Y4ZssexwZZr2bpyAhkB17D6LOhlJ8CH/W
	 B5BzuvCY/PXjJAUYNXSmdg2lupWrm7yQQLF7wV07GNJuWkr2THAdt682BZ2ET+98Nj
	 ErH4g1cbmJXs5UMjekdRZ7HG+rJPt5rLMXhfkhOt7UzUfg5Fx885L6/hML3UgFw/mP
	 bJ7X6lwUkLr+KjHSDYTrVOWrZPmIYPa2nR7FVrSYhXEY9B/k0OOxIYJEzOJAwL46Bo
	 eRRufnnPuoinQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] PCI: Add PCI_VDEVICE_SUB helper macro
Date: Mon, 20 Oct 2025 15:53:45 -0400
Message-ID: <20251020195348.1882212-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102053-upheld-recess-9b2f@gregkh>
References: <2025102053-upheld-recess-9b2f@gregkh>
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
index 59dfa59d6d597..ea50d050d0214 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1026,6 +1026,20 @@ static inline struct pci_driver *to_pci_driver(struct device_driver *drv)
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



Return-Path: <stable+bounces-153421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4CCADD46D
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFFD2C2828
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1080E2F548A;
	Tue, 17 Jun 2025 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jN8XLHOz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE062DFF1F;
	Tue, 17 Jun 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175907; cv=none; b=syYjYg0fK2L/2/dZc1mbhD5f2LEjK5d6Kh9hkq3y4o2GSlwn9bPD2kIcfMPx0ChWws+gjjanDC0R6vvngIQyHsosoT5zzrAlwJ3ICtIrhzb9KEESWJ5/EQ9btmsJ9/wqopYsdeldPbqf4G5VQLXH9aAMr4vz+mp+CzL60f6BCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175907; c=relaxed/simple;
	bh=ey0HWvXFQ9Y231RuplHoYp2/TMvyPbUh1yjuYoinRvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQ0/L8mY3B9OsffEQPtHf6Z16XeO5rcnzYzljfD2xNos2uxYzMZ98E/xhaAazParG9D3FdQzs48Agk7Yieh3M51xDrT+IWZmMh2c7d7DNEHVNrsmSPGO8fG979qrJqmu8T/ZIxhs6DAkcpCWZIh6yPvvEj/S6Czbdsv5hIPtjj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jN8XLHOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3366C4CEE3;
	Tue, 17 Jun 2025 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175907;
	bh=ey0HWvXFQ9Y231RuplHoYp2/TMvyPbUh1yjuYoinRvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jN8XLHOzEYmfb0iHYeWmoQlPjYOeu0P6J/uBBBsZSvUxPIz20AeNQu6nkUbq877ih
	 e6syPpW5xcf/eLHRvSAjhjzGf0rUeSDtbl6+3HxZNAIvpcgzrmMXgbzEGkn44F5Yak
	 qYSBYrUKX9Nc1FqVHiMSisLXXvIpJRzhYD5ucFaQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rolf Eike Beer <eb@emlix.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 174/512] iommu: remove duplicate selection of DMAR_TABLE
Date: Tue, 17 Jun 2025 17:22:20 +0200
Message-ID: <20250617152426.676377365@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rolf Eike Beer <eb@emlix.com>

[ Upstream commit 9548feff840a05d61783e6316d08ed37e115f3b1 ]

This is already done in intel/Kconfig.

Fixes: 70bad345e622 ("iommu: Fix compilation without CONFIG_IOMMU_INTEL")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/2232605.Mh6RI2rZIc@devpool92.emlix.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index b3aa1f5d53218..1469ad0794f28 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -199,7 +199,6 @@ source "drivers/iommu/iommufd/Kconfig"
 config IRQ_REMAP
 	bool "Support for Interrupt Remapping"
 	depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
-	select DMAR_TABLE if INTEL_IOMMU
 	help
 	  Supports Interrupt remapping for IO-APIC and MSI devices.
 	  To use x2apic mode in the CPU's which support x2APIC enhancements or
-- 
2.39.5





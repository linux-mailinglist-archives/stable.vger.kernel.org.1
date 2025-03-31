Return-Path: <stable+bounces-127192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08902A7699B
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5697A5682
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B3233134;
	Mon, 31 Mar 2025 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Upxca9Ui"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9B233120;
	Mon, 31 Mar 2025 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432909; cv=none; b=qk+t6sK4M9rLremeTjZAwZLbW6R77uDiIEYQPAG8b1IJLd1W2FJAwwe9T5Ioh/SpcWGmpoPc3jJlwXTAbgmLeNSquOxzWvWFvoxHyYD9RewU1EFki53mO/RPWPxcTAx6esuz8G5mBEpjLpefuO2TfSGyLCHXu1hQPm2+jTdknc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432909; c=relaxed/simple;
	bh=6W97gUxC1i3/IIv7TYBBVZoZFV6otn8YTHabZQR4WHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7xc5IFNQNXtxV/eKXGkIKIhimVtUFAYF5NgxfceUkDrk7jbJ8GJ+IM3ZtuX7nm8iJhaUP6wd+8KIcIRtlA7d17eSfTZmN2kIAPIsQ0ASWNyPx179ZbMh988oGT6gu7dST555JOe/gYOsCFDFQuO0PDXV8fSsWFvX10Tt/zNpLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Upxca9Ui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D061C4CEE3;
	Mon, 31 Mar 2025 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432909;
	bh=6W97gUxC1i3/IIv7TYBBVZoZFV6otn8YTHabZQR4WHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Upxca9UiXOFMRIEuE1Rv6jdV1d8Xkf6dhiaBgVHeIUA5f8k7ps9ZUqeJ88h2sTWCf
	 vF8k7CLj81fx8Tsl4iqfS7s3UTdJqB6aQnMt3yA3zHMncNgMwmN+1WBVsHBsCF1Gcm
	 qlkSwOPNFHBp44N2Jvdmv9BT28HkZHlUU3K3U5MC9XSEgmVq2oYec1d7os8V5PNV1h
	 M4k+GCsy5Meh1lOenn8k8tFGiC0Oydp59JrvgiP1VXcMClD3OsV6X5eynK0xHxP6n+
	 Ao0O0y45U/1lKElHfi2FvCvreWaZzfryhmML/DcBX0iMc0HBLvGbqaWtP6rds/kSYc
	 bIkU+UT+HRi6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	kernel test robot <lkp@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 24/24] platform/x86: x86-android-tablets: Add select POWER_SUPPLY to Kconfig
Date: Mon, 31 Mar 2025 10:54:04 -0400
Message-Id: <20250331145404.1705141-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145404.1705141-1-sashal@kernel.org>
References: <20250331145404.1705141-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 2c30357e755b087217c7643fda2b8aea6d6deda4 ]

Commit c78dd25138d1 ("platform/x86: x86-android-tablets: Add Vexia EDU
ATLA 10 EC battery driver"), adds power_supply class registering to
the x86-android-tablets code.

Add "select POWER_SUPPLY" to the Kconfig entry to avoid these errors:

ERROR: modpost: "power_supply_get_drvdata" [drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.ko] undefined!
ERROR: modpost: "power_supply_changed" [drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.ko] undefined!
ERROR: modpost: "devm_power_supply_register" [drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.ko] undefined!

When POWER_SUPPLY support is not enabled.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503231159.ga9eWMVO-lkp@intel.com/
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20250324125052.374369-1-hdegoede@redhat.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/x86-android-tablets/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/x86-android-tablets/Kconfig b/drivers/platform/x86/x86-android-tablets/Kconfig
index a67bddc430075..193da15ee01ca 100644
--- a/drivers/platform/x86/x86-android-tablets/Kconfig
+++ b/drivers/platform/x86/x86-android-tablets/Kconfig
@@ -10,6 +10,7 @@ config X86_ANDROID_TABLETS
 	depends on ACPI && EFI && PCI
 	select NEW_LEDS
 	select LEDS_CLASS
+	select POWER_SUPPLY
 	help
 	  X86 tablets which ship with Android as (part of) the factory image
 	  typically have various problems with their DSDTs. The factory kernels
-- 
2.39.5



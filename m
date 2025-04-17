Return-Path: <stable+bounces-134166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB52CA929B2
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DA34A5E5D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACA4259CA8;
	Thu, 17 Apr 2025 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kQF/Qt4e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79C31A5BBB;
	Thu, 17 Apr 2025 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915293; cv=none; b=UgAStUfvtHWoTkLVE5Oejie1TIIipowZ/uBuImI1RO3CgFIKUsutGW+77KGldbxEdext3MU9GcbkFDWgSpAlhdUhNa47wyqu70miQLbvFJwsa5V9ozHc2NVw5xLQPZ2OMX87zXBRtLIgDxyQQ4wvRC7TpmWrDmw5wUZ6yWUs6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915293; c=relaxed/simple;
	bh=9cFIAieBc34bpF7/8OC8LRRhR4Mm3k8kwHjyThNzFzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEKuTyjlKXhayPS4ZRRAzvtBDpmtFBxa+n623KpwUfRQbLKW0fRHl8+Ct2L4akGSrBczqTx/ni9tMPjnoUeIu1jJKBBfRNUeKsCOkKuoK6I6pcZLw5CUu3D2luHyMYQxB6sQc/2o0iDSqAmMwroTg2S4TjkOwzHjEGNTdiHqRiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kQF/Qt4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496E4C4CEE4;
	Thu, 17 Apr 2025 18:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915293;
	bh=9cFIAieBc34bpF7/8OC8LRRhR4Mm3k8kwHjyThNzFzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQF/Qt4e+RtnC8gHGreFbE0xHVEMx+vveWaydJlye6jxvCPThbU3tG17PyUFp+hX9
	 xZDodwpDGPBZkVx0j1ePzBcEOljmfHQFvHMF+bSbjBLXrJExQWHtC3jJI19sRX90k/
	 DczGyFnZEi2xvOFK6jyUwoRO2w1JrZ9Bka2XYDiY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 081/393] platform/x86: x86-android-tablets: Add select POWER_SUPPLY to Kconfig
Date: Thu, 17 Apr 2025 19:48:10 +0200
Message-ID: <20250417175110.862541017@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 88d9e8f2ff24e..c98dfbdfb9dda 100644
--- a/drivers/platform/x86/x86-android-tablets/Kconfig
+++ b/drivers/platform/x86/x86-android-tablets/Kconfig
@@ -8,6 +8,7 @@ config X86_ANDROID_TABLETS
 	depends on I2C && SPI && SERIAL_DEV_BUS && ACPI && EFI && GPIOLIB && PMIC_OPREGION
 	select NEW_LEDS
 	select LEDS_CLASS
+	select POWER_SUPPLY
 	help
 	  X86 tablets which ship with Android as (part of) the factory image
 	  typically have various problems with their DSDTs. The factory kernels
-- 
2.39.5





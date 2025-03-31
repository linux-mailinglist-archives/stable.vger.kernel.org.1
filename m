Return-Path: <stable+bounces-127215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAD9A76A49
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF193AF91F
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C4123C8C4;
	Mon, 31 Mar 2025 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUYhGH61"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB3C23C38C;
	Mon, 31 Mar 2025 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432960; cv=none; b=ehg6vU6j72goM9qua+VPUMyTJrht4n3cEXeF9FKwGUFV4xgBv9Idij1Wy5sIAr9UGKMzOslFta06ybPcQJM3iQcOKrXtR/NN/MBuUWJvsrhEg51/Js8C9KjpRVFeVk1M9k0YY8qQketFLdpxpMRZxTMzdCmcu59eb3hHfetBGmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432960; c=relaxed/simple;
	bh=NuQi7sGKwuKY+hUiEudtXjgQ66TKKxCP3gmGJjW7KEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLht0p31KWO535xgghxFyDvhWgI3GrXLby8vuVjnmtAGhtAi2pncupmGnWjECSxfMT49PM3Wd9Qw5reGMtsbooldgp825sofgVl08poOWD8lvKqKBdL899LXnmgjhCEnXQKoVGxSrzxpXYYVOABX2aKrK8gtVMXhmrh+iDENNYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUYhGH61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58963C4CEE4;
	Mon, 31 Mar 2025 14:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432960;
	bh=NuQi7sGKwuKY+hUiEudtXjgQ66TKKxCP3gmGJjW7KEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUYhGH61uXqB7uf9KnWvFH78Knt5h1ZtwXlBcAsSaYCl1VVmWjDi4zC3ls1owjtq0
	 VHE+5Cusb6OZVald4bZUSdmckN4+ACJ6r19YBMZKEsc6ZTuCCYZ1lEH0Fa6rZjLs2S
	 oOMs6PWOWC5Na3y43foHmfWIEHdMGSeKYPioTmJfRv5xTiDbL327o9eV7rISiC/kD3
	 97jMxyGPf/AOY/cwrwsBd+sN+9JGFkfFVkAJNvj/HPjSR38auvND/36/Y1OCyx+i4i
	 KwflmkYoK30PKG7tnP/lV5/McLE/u4IRTbp/V33N2gyHeO5D4KWrVzYdg4yPd8X739
	 Aixm2YiMVORvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	kernel test robot <lkp@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 23/23] platform/x86: x86-android-tablets: Add select POWER_SUPPLY to Kconfig
Date: Mon, 31 Mar 2025 10:55:09 -0400
Message-Id: <20250331145510.1705478-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145510.1705478-1-sashal@kernel.org>
References: <20250331145510.1705478-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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



Return-Path: <stable+bounces-127168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75181A76946
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343E716680C
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7840A22A4F2;
	Mon, 31 Mar 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI8s8ANw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452122A4EB;
	Mon, 31 Mar 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432845; cv=none; b=bgNSm40Kw+Xzu+AIvf8yJhx6uhcjKNDufTOCq/m4SR7gFB/4mtaVAnnWK7+CMpWPyGQV85V+N2ZuPdKYHqxODZtJQ3am4Ck6JWceQzrx7RJOhYNLqa67Zzjc3eBk3bNI9IS3glz+Z2HIBQvN9t0OJ2OL9gV6D5gZqP4jVCmWsEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432845; c=relaxed/simple;
	bh=6W97gUxC1i3/IIv7TYBBVZoZFV6otn8YTHabZQR4WHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXWrsHhdqDy5OkJ1lAtGA0Va/8418/+r4qqxOMYFVJeZbqVar05RWPeGcMZJRcPAAI7ZOFANsaA9KRdL468op0K7a0gpl7C69jaZdOsgEkCsQmh0MyBN4m7GjTU31FQSFrg1U/4o/cq6dXmJRehRYSFj4zqI5V50YVJbn7aGps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI8s8ANw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FBEC4CEE3;
	Mon, 31 Mar 2025 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432843;
	bh=6W97gUxC1i3/IIv7TYBBVZoZFV6otn8YTHabZQR4WHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OI8s8ANwS0oXq9aWNlcN5bCNSvl9J3v75dRgI4AOvhigAgxVra/6MNCq5CK/1H0NJ
	 BEO/Sh2mIhIqAEv3iCVzzu9aS2Xre83FA4W2fVp4nc0SK853g1eEP2Q6KrniwYTMxn
	 kj9/0eJP9HEXpeG1HLyUojE+LOHRUXDIUZOyXbhsUHG9dqNrBuFX3usePeOiRzYxxs
	 ia1T3MD9L1jCDUemwSeraJFo7eA89ulXS+dl3XI0wKjR6JalQ8AXEtkS01nJt1PsY9
	 ZIYtcmdEHCkktlvnz22Fh6eFC2kaEIFpucknxEWb3413hYEruHzg6MaXb/GE7Urg41
	 G20XiLtzN61lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	kernel test robot <lkp@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 27/27] platform/x86: x86-android-tablets: Add select POWER_SUPPLY to Kconfig
Date: Mon, 31 Mar 2025 10:52:45 -0400
Message-Id: <20250331145245.1704714-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145245.1704714-1-sashal@kernel.org>
References: <20250331145245.1704714-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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



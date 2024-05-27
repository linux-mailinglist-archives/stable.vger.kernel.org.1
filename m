Return-Path: <stable+bounces-46534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A768D0771
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8601F20F2C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ECB16D4ED;
	Mon, 27 May 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWLJMhO9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79E16D4E3;
	Mon, 27 May 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825408; cv=none; b=mqkL9NhhEgB266hJ3wrRiqE2pxg/+hG4JpFF5PuWOAgX9c6RAj2K0ARtFNV/jhMMyHGDivuaW51+U437HVaKHUaEHUsVJFviWamq6G6FehrU5Eu0BeF+ZUZIf1hjiGMTPDffzz54TczmFK9rU5mBHf83N8zn/QgyfVGq385ydxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825408; c=relaxed/simple;
	bh=RXItawyunSKwgW8TbTmkLjm06IxAaMojUWhmDVD+9Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0zKUp13poa/to7sNfvrIiE+TKUnFvqWW4pCAbESJqJGQSANUxg/SN6COHafT5qHTMjZJhwuuD/A98ErTrH+bgj2CsexrQL7qB0hCk2c54LAVKjNPQXCPxTXCWO2pv5Yqulzvp+h4zh90xcxzueK87ZnCFfbKPZpWF1z9pQ54r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWLJMhO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F144C32789;
	Mon, 27 May 2024 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825408;
	bh=RXItawyunSKwgW8TbTmkLjm06IxAaMojUWhmDVD+9Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OWLJMhO9F5MI9jhjxD2eptpYGCvZ/VWNQlfw619yyJfIgyLcHkgG/hvYoko6twILs
	 3eDlsB6LJTc08i4rKJIuLdrlyz5axbBMI5yevXVwD0v1WCXTPphCxjxJkOqSMDzuTO
	 F7fnPYdHoMKmuvixoubjGk1eknlxDJI3Xs+zyIGdcqseRQygF/W4qRrRAMX++fZfWN
	 4HoCOeCOisoRGqif9SBY+7EGRqalJzoj1qafyCLFzz+yIV+PHL4qXeaasbBU3EJPGi
	 hQK7jacliaE95QoHEnAA3KYjc54SeXZc8VExN5JJPW1v4GTcmNFHIDQt2HVuiCuaJm
	 671uA/DZcAtUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Fradella <bfradell@netapp.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Klara Modin <klarasmodin@gmail.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 16/16] platform/x86: p2sb: Don't init until unassigned resources have been assigned
Date: Mon, 27 May 2024 11:55:07 -0400
Message-ID: <20240527155541.3865428-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155541.3865428-1-sashal@kernel.org>
References: <20240527155541.3865428-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Ben Fradella <bfradell@netapp.com>

[ Upstream commit 2c6370e6607663fc5fa0fd9ed58e2e01014898c7 ]

The P2SB could get an invalid BAR from the BIOS, and that won't be fixed
up until pcibios_assign_resources(), which is an fs_initcall().

- Move p2sb_fs_init() to an fs_initcall_sync(). This is still early
  enough to avoid a race with any dependent drivers.

- Add a check for IORESOURCE_UNSET in p2sb_valid_resource() to catch
  unset BARs going forward.

- Return error values from p2sb_fs_init() so that the 'initcall_debug'
  cmdline arg provides useful data.

Signed-off-by: Ben Fradella <bfradell@netapp.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Klara Modin <klarasmodin@gmail.com>
Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/r/20240509164905.41016-1-bcfradella@proton.me
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/p2sb.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index a64f56ddd4a44..053be5c5e0cad 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -56,12 +56,9 @@ static int p2sb_get_devfn(unsigned int *devfn)
 	return 0;
 }
 
-static bool p2sb_valid_resource(struct resource *res)
+static bool p2sb_valid_resource(const struct resource *res)
 {
-	if (res->flags)
-		return true;
-
-	return false;
+	return res->flags & ~IORESOURCE_UNSET;
 }
 
 /* Copy resource from the first BAR of the device in question */
@@ -220,16 +217,20 @@ EXPORT_SYMBOL_GPL(p2sb_bar);
 
 static int __init p2sb_fs_init(void)
 {
-	p2sb_cache_resources();
-	return 0;
+	return p2sb_cache_resources();
 }
 
 /*
- * pci_rescan_remove_lock to avoid access to unhidden P2SB devices can
- * not be locked in sysfs pci bus rescan path because of deadlock. To
- * avoid the deadlock, access to P2SB devices with the lock at an early
- * step in kernel initialization and cache required resources. This
- * should happen after subsys_initcall which initializes PCI subsystem
- * and before device_initcall which requires P2SB resources.
+ * pci_rescan_remove_lock() can not be locked in sysfs PCI bus rescan path
+ * because of deadlock. To avoid the deadlock, access P2SB devices with the lock
+ * at an early step in kernel initialization and cache required resources.
+ *
+ * We want to run as early as possible. If the P2SB was assigned a bad BAR,
+ * we'll need to wait on pcibios_assign_resources() to fix it. So, our list of
+ * initcall dependencies looks something like this:
+ *
+ * ...
+ * subsys_initcall (pci_subsys_init)
+ * fs_initcall     (pcibios_assign_resources)
  */
-fs_initcall(p2sb_fs_init);
+fs_initcall_sync(p2sb_fs_init);
-- 
2.43.0



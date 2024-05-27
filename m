Return-Path: <stable+bounces-46518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD38D0740
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC101F22935
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C386C16A38D;
	Mon, 27 May 2024 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbaCyU8C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4616A387;
	Mon, 27 May 2024 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825306; cv=none; b=Gm5F7VPv32Id13ZFiJiPkZuNuIEnwwQ+jeChLFrlc1xVwldamwGmpgMG/lrphyeud59pHZEg4DXv/qnHaBScnPVZqru2EtPNQa+L4S+HfD84zoKFWVf0/9JlpyONYnrZ54GYryM4Ksbbs/Rs2sTJ7CF7I4LgtJ9OZ4Q5dljkjUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825306; c=relaxed/simple;
	bh=9O1/9N+pW9u9GQ2iwg/POokNTzd/48jaP6RProOYYSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGnUgAyeFZWPX653IiP7XGuyvS5MEKDu6o/lKYJ95wI2TgdOw95qN2wloB5uP0BC3pw8LffYCOdF4xNdzc1sJ4BIY+vuMTgexSgfzDKoMXG5NmjmKFRdjTNSjk7sUFbmjVC7MTtAjfFFmeNb/5tZ7fYhBry09OOJAYzG0SP6+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbaCyU8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FBDC4AF08;
	Mon, 27 May 2024 15:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825306;
	bh=9O1/9N+pW9u9GQ2iwg/POokNTzd/48jaP6RProOYYSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EbaCyU8CFYAegLD2d0CkQjzTNpEHjCjVYZxq+L24lnJSiwDOhAw3pPltr8hLZ0sVp
	 4b31dqPVYpoAu+mSZLJu2VM3JV+tqI56o/4UQNbitwFrHSNaMNgbM2AMtN9GjJdEML
	 i8ndNotM1XlsIEaj1NgnkterdGrLSGXo0VH0YENSVp3oD9gQCyk4WDvXZnndz5k+e0
	 9YGRKn0iI3TodUOMEEpUj7ihhppGBWvJhdumDKponBrD5BiF/pK5aOWnHMb82JC4Lx
	 YLijDS8L8TRJzIPpMRrybzr7LlZMhdvwujs7vFqW+yje/Kd+Ivxs1zu/t/5FAZ0Ojn
	 4YoVSszSU1dZA==
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
Subject: [PATCH AUTOSEL 6.8 20/20] platform/x86: p2sb: Don't init until unassigned resources have been assigned
Date: Mon, 27 May 2024 11:53:03 -0400
Message-ID: <20240527155349.3864778-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155349.3864778-1-sashal@kernel.org>
References: <20240527155349.3864778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
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
index 3d66e1d4eb1f5..1ac30034f3e59 100644
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



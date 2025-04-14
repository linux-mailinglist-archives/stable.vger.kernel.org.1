Return-Path: <stable+bounces-132475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34182A88267
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843193BC633
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8DA2820C9;
	Mon, 14 Apr 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+pxZj91"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F02820C0;
	Mon, 14 Apr 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637220; cv=none; b=FtV0/fj3hJo7Uhyam41CpUtsRm/4zDWpSPbuS4rQGBhNj8g7k951W6uj6hMh8Osh0ldy2ffUj8MEz5tay0Lqtj//HY3AVB76gjT8cJ9VD1zQ/asI9GSwMsFWESzqQlZAwsN34sI1dDQu6tNlkfArhdiCfndKrPR2h2TSDr5iaE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637220; c=relaxed/simple;
	bh=NWePQQGyiJB1lF8JMRapZucVYoCavkai+t/0v9AbqlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyUR/EAKKRAYY5Airv97IlDe/o4/9kVHnVCfJ6kQfMl1EIYTYulKDOAcrrLiQtVd6n3ueNHBRdXdKQyzwYxhuiiJkQLigZpHnHn3FPGTSinPuFG8IXPR+h9Illi7Jlo0oX17mHeDnkY5amApmLFUe6Fc10LJz9NTapY6EC0Mkcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+pxZj91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5AFC4CEE9;
	Mon, 14 Apr 2025 13:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637220;
	bh=NWePQQGyiJB1lF8JMRapZucVYoCavkai+t/0v9AbqlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+pxZj910uDVMYGVoXgeSt6ylbUY2TEQVHUEb0poqS0RrjNHnstveM/2So0R1d1QF
	 TqEdiAif+GwmH7FAL8v5pWJCYWsXfA+GeDj1Rpj/GlK4p3rBKLx7gOK9Unsl1WCdiC
	 0XESDuSesw3wtUtcBnn6kG/fdZBYAphtr1/eJhPCdHSm9xGGUtoJmGxifrZ3Jvuw0e
	 YA3NUvcqL84xwspG4Wy8faJkSkW8W/E0/lCkKLH62V/r2VzvXHusDoiYsf5Pnwwl5f
	 0JraiCnW+Jd2W/ZtJISR9EanNsAdLGcfN1uQgpgdVAnd2ilMWRgIhWQ9xKEvx3uRHb
	 jDHOzP6SHRvcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Jason Andryuk <jason.andryuk@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 6.14 21/34] x86/xen: disable CPU idle and frequency drivers for PVH dom0
Date: Mon, 14 Apr 2025 09:25:57 -0400
Message-Id: <20250414132610.677644-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
Content-Transfer-Encoding: 8bit

From: Roger Pau Monne <roger.pau@citrix.com>

[ Upstream commit 64a66e2c3b3113dc78a6124e14825d68ddc2e188 ]

When running as a PVH dom0 the ACPI tables exposed to Linux are (mostly)
the native ones, thus exposing the C and P states, that can lead to
attachment of CPU idle and frequency drivers.  However the entity in
control of the CPU C and P states is Xen, as dom0 doesn't have a full view
of the system load, neither has all CPUs assigned and identity pinned.

Like it's done for classic PV guests, prevent Linux from using idle or
frequency state drivers when running as a PVH dom0.

On an AMD EPYC 7543P system without this fix a Linux PVH dom0 will keep the
host CPUs spinning at 100% even when dom0 is completely idle, as it's
attempting to use the acpi_idle driver.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250407101842.67228-1-roger.pau@citrix.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/xen/enlighten_pvh.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 0e3d930bcb89e..9d25d9373945c 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/acpi.h>
+#include <linux/cpufreq.h>
+#include <linux/cpuidle.h>
 #include <linux/export.h>
 #include <linux/mm.h>
 
@@ -123,8 +125,23 @@ static void __init pvh_arch_setup(void)
 {
 	pvh_reserve_extra_memory();
 
-	if (xen_initial_domain())
+	if (xen_initial_domain()) {
 		xen_add_preferred_consoles();
+
+		/*
+		 * Disable usage of CPU idle and frequency drivers: when
+		 * running as hardware domain the exposed native ACPI tables
+		 * causes idle and/or frequency drivers to attach and
+		 * malfunction.  It's Xen the entity that controls the idle and
+		 * frequency states.
+		 *
+		 * For unprivileged domains the exposed ACPI tables are
+		 * fabricated and don't contain such data.
+		 */
+		disable_cpuidle();
+		disable_cpufreq();
+		WARN_ON(xen_set_default_idle());
+	}
 }
 
 void __init xen_pvh_init(struct boot_params *boot_params)
-- 
2.39.5



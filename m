Return-Path: <stable+bounces-15829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9514883CA86
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 19:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46376290254
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 18:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB07C133426;
	Thu, 25 Jan 2024 18:05:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EFC130E52
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.28.154.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205918; cv=none; b=BZbGnPzMeL+1Liv6uUtKYnroHg4mWP5S2yU/wHO9V/q+8JcimbkKLusXN+B/yREY86mlouLtLK7CZgzGzGsML/d+ws10mY6ErKaMaMn6ZGhYUODiaNud6yzHKNW81DLU0loAONs7c4juJgGh6DELDKxkki2U4frW65LfUtZEoYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205918; c=relaxed/simple;
	bh=dkFShOd0XaIzUt8vStqMYFqM5XxWJsVi2LaKYMb9kY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCmhcFbGkw1frsFMcZIfegkmJSpTL4xE0WRIIpBzAODolYBrT/YoYnuauWb8o0smNig8+ZnrPntivn3qZaCWfm1AYU9hPPXaVzuuKSOvQg2djdlApmF6+xf/iHyDvAm8Eat0AU4OcqvSL5es8QM+eXiyL3ArQfe/cPjvRpIi6qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=maciej.szmigiero.name; arc=none smtp.client-ip=37.28.154.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maciej.szmigiero.name
Received: from MUA
	by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mail@maciej.szmigiero.name>)
	id 1rT468-0000De-RQ; Thu, 25 Jan 2024 19:05:08 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH 5.4] x86/CPU/AMD: Fix disabling XSAVES on AMD family 0x17 due to erratum
Date: Thu, 25 Jan 2024 19:05:02 +0100
Message-ID: <148d36e2bb58877fe9e39c383118b76dbde02719.1706204911.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

The stable kernel version backport of the patch disabling XSAVES on AMD
Zen family 0x17 applied this change to the wrong function (init_amd_k6()),
one which isn't called for Zen CPUs.

Move the erratum to the init_amd_zn() function instead.

Add an explicit family 0x17 check to the erratum so nothing will break if
someone naively makes this kernel version call init_amd_zn() also for
family 0x19 in the future (as the current upstream code does).

Fixes: e40c1e9da1ec ("x86/CPU/AMD: Disable XSAVES on AMD family 0x17")
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 arch/x86/kernel/cpu/amd.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index b2cdf1c07e56..4e84203fc067 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -277,15 +277,6 @@ static void init_amd_k6(struct cpuinfo_x86 *c)
 		return;
 	}
 #endif
-	/*
-	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
-	 * certain circumstances on Zen1/2 uarch, and not all parts have had
-	 * updated microcode at the time of writing (March 2023).
-	 *
-	 * Affected parts all have no supervisor XSAVE states, meaning that
-	 * the XSAVEC instruction (which works fine) is equivalent.
-	 */
-	clear_cpu_cap(c, X86_FEATURE_XSAVES);
 }
 
 static void init_amd_k7(struct cpuinfo_x86 *c)
@@ -989,6 +980,17 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 		if (c->x86 == 0x19 && !cpu_has(c, X86_FEATURE_BTC_NO))
 			set_cpu_cap(c, X86_FEATURE_BTC_NO);
 	}
+
+	/*
+	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
+	 * certain circumstances on Zen1/2 uarch, and not all parts have had
+	 * updated microcode at the time of writing (March 2023).
+	 *
+	 * Affected parts all have no supervisor XSAVE states, meaning that
+	 * the XSAVEC instruction (which works fine) is equivalent.
+	 */
+	if (c->x86 == 0x17)
+		clear_cpu_cap(c, X86_FEATURE_XSAVES);
 }
 
 static bool cpu_has_zenbleed_microcode(void)


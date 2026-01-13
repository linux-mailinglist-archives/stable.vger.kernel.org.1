Return-Path: <stable+bounces-208280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B203D1A216
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 17:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B0FE303C807
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594193816F0;
	Tue, 13 Jan 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ibi8gOsP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YwyKWJx8"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27E5AD5A;
	Tue, 13 Jan 2026 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320844; cv=none; b=VPY9HovcLe4D8BbO4tR2vC2ohuUwg3ATL/VBSUg+5a70WuHbRM+rj+RmOA8AtCGKnhnp9x5w2/4Sd5vpcmg6NW0PTnbK33fX2Jsk3upTUopV1yfgxtYP/tuI/yWHRSmLxXxOnIy874QxVFId6E1JYR9obBQk8bd7UQdZEA5R6bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320844; c=relaxed/simple;
	bh=2DeOsBy0YsHCe+32DWjAHmYy3t4rh1Dh8hQmVWPcEGg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tEE/A3rh3O/DynNqCbouW8eF6w/Gkul21OBuLRbJ6+FsWbwUhkAdpWACjtMgdU0j7MD31j5vKDFZ8ZRiCaGRsx+zVKEaIIrRLAm351MOpfkeQtI0FxDgPknHXlMvoA66Ugmt3CwftLi+tuYmWS9xN4CN5SnclQtJUDLSY6z2YDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ibi8gOsP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YwyKWJx8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 16:13:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768320840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rwkkX2JjaJWNzUzffYSUIRLt8HbUjTzqSkWnL7ycWw=;
	b=Ibi8gOsPrBl9LNZntnlfwjKmU5O7liNkBzh8iFL4gm5+gFDy/sBLAutgG/JK5D7VZf9t7C
	L3PNFYDpnOlwAwxDXfBsZP0Iq4452usSOWka83GAObZl0iUv+Fq4AAYuxyQL0qUDjcxPcX
	6sQeEIP/Zqya8jm37Sc4BPO4L+sRXl4dJxHV1Zfqqp3PVtVLPwDwvwEl8u3LKZIyimxi7q
	aK7fX1vXpfKRen/8OS+EwiEsr8V641zRxQ2QGUtwsfqYtMqwjRKcP6fNjBIs631xjX/+0C
	MXXMuQ98fQziXJH4LzzZ7+Gorx/ROw7vaJIb/rVAcF9Vk/0VhsXH5ZZRZH+tOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768320840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rwkkX2JjaJWNzUzffYSUIRLt8HbUjTzqSkWnL7ycWw=;
	b=YwyKWJx84RZEVtcPjnw9sUxbq34Vr39BtSBDmzzgaWCL1tTWZ09XbZabU4xmmmwyZt7wvw
	ppbeIqJPPHMLzsAQ==
From: "tip-bot2 for Xiaochen Shen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/resctrl: Fix memory bandwidth counter width for Hygon
Cc: Xiaochen Shen <shenxiaochen@open-hieco.net>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251209062650.1536952-3-shenxiaochen@open-hieco.net>
References: <20251209062650.1536952-3-shenxiaochen@open-hieco.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176832083920.510.6826832603557460892.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7517e899e1b87b4c22a92c7e40d8733c48e4ec3c
Gitweb:        https://git.kernel.org/tip/7517e899e1b87b4c22a92c7e40d8733c48e=
4ec3c
Author:        Xiaochen Shen <shenxiaochen@open-hieco.net>
AuthorDate:    Tue, 09 Dec 2025 14:26:50 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 Jan 2026 16:44:26 +01:00

x86/resctrl: Fix memory bandwidth counter width for Hygon

The memory bandwidth calculation relies on reading the hardware counter
and measuring the delta between samples. To ensure accurate measurement,
the software reads the counter frequently enough to prevent it from
rolling over twice between reads.

The default Memory Bandwidth Monitoring (MBM) counter width is 24 bits.
Hygon CPUs provide a 32-bit width counter, but they do not support the
MBM capability CPUID leaf (0xF.[ECX=3D1]:EAX) to report the width offset
(from 24 bits).

Consequently, the kernel falls back to the 24-bit default counter width,
which causes incorrect overflow handling on Hygon CPUs.

Fix this by explicitly setting the counter width offset to 8 bits (resulting
in a 32-bit total counter width) for Hygon CPUs.

Fixes: d8df126349da ("x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_=
init helper")
Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251209062650.1536952-3-shenxiaochen@open-hie=
co.net
---
 arch/x86/kernel/cpu/resctrl/core.c     | 15 +++++++++++++--
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 10de159..6ebff44 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -1021,8 +1021,19 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
 		c->x86_cache_occ_scale =3D ebx;
 		c->x86_cache_mbm_width_offset =3D eax & 0xff;
=20
-		if (c->x86_vendor =3D=3D X86_VENDOR_AMD && !c->x86_cache_mbm_width_offset)
-			c->x86_cache_mbm_width_offset =3D MBM_CNTR_WIDTH_OFFSET_AMD;
+		if (!c->x86_cache_mbm_width_offset) {
+			switch (c->x86_vendor) {
+			case X86_VENDOR_AMD:
+				c->x86_cache_mbm_width_offset =3D MBM_CNTR_WIDTH_OFFSET_AMD;
+				break;
+			case X86_VENDOR_HYGON:
+				c->x86_cache_mbm_width_offset =3D MBM_CNTR_WIDTH_OFFSET_HYGON;
+				break;
+			default:
+				/* Leave c->x86_cache_mbm_width_offset as 0 */
+				break;
+			}
+		}
 	}
 }
=20
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index 4a916c8..79c1865 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -14,6 +14,9 @@
=20
 #define MBM_CNTR_WIDTH_OFFSET_AMD	20
=20
+/* Hygon MBM counter width as an offset from MBM_CNTR_WIDTH_BASE */
+#define MBM_CNTR_WIDTH_OFFSET_HYGON	8
+
 #define RMID_VAL_ERROR			BIT_ULL(63)
=20
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)


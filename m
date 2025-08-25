Return-Path: <stable+bounces-172790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CF0B337C3
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 09:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B6C77AD26C
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 07:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40114283FEF;
	Mon, 25 Aug 2025 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iNyDBNWi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E25215F6C
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756106850; cv=none; b=kPnzs+2QZAx+16+tFNHggqu3PyRrG0sQ0H3dz3tDULG1U78jEdQ6rm1PirYpIh0U3rf+WU7fG21Ckzh7+N5Tf3iGWtTiE2RNuUhF/CEnmgO4OfSrMYAX+R2E6IZrBbsCdPLqJW+OpJYQ1bIhYtatSkcmbcTRBF7E6bsPhyPHgXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756106850; c=relaxed/simple;
	bh=GzY39sSJwi3qrJvTOvqogMrQFz4IRbBrC6v/H04W6Qo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ICLyoS6LpfmxyIHGII1Xg2E+uW1kMxJvAQy0OLoRy/+4BDaziMoqWNd9m+/oRsN7GRInFcvViWiacRhRxfJNodu9NCi/YrY2CIeoZF3tpxXmrv9VCGcVwpu0+q4+M/SjONcWCFSaWQn7C2EluM4MbHYXL/th7/SqUzCILXdoLWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iNyDBNWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19255C4CEED;
	Mon, 25 Aug 2025 07:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756106849;
	bh=GzY39sSJwi3qrJvTOvqogMrQFz4IRbBrC6v/H04W6Qo=;
	h=Subject:To:Cc:From:Date:From;
	b=iNyDBNWiakQLoHk7/zbg/fybR1MJ/x7IzMQmJD8wCUFItyK2i1yAMTppsuK9u6uuQ
	 K8yUdciJdDvLC5sVeVvzmbjq/3zIEi9KumRiCBtAbUQLJeiTU7q6mZOVVk1LP9tnjV
	 CxvnB/pt1VYpJ+Qbw1ckGxk+wjGnQPd9isPC+EHc=
Subject: FAILED: patch "[PATCH] x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init" failed to apply to 6.6-stable tree
To: txpeng@tencent.com,bp@alien8.de,caelli@tencent.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 25 Aug 2025 09:27:16 +0200
Message-ID: <2025082516-wikipedia-entitle-8772@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d8df126349dad855cdfedd6bbf315bad2e901c2f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082516-wikipedia-entitle-8772@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d8df126349dad855cdfedd6bbf315bad2e901c2f Mon Sep 17 00:00:00 2001
From: Tianxiang Peng <txpeng@tencent.com>
Date: Mon, 23 Jun 2025 17:31:53 +0800
Subject: [PATCH] x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init
 helper

Since

  923f3a2b48bd ("x86/resctrl: Query LLC monitoring properties once during boot")

resctrl_cpu_detect() has been moved from common CPU initialization code to
the vendor-specific BSP init helper, while Hygon didn't put that call in their
code.

This triggers a division by zero fault during early booting stage on our
machines with X86_FEATURE_CQM* supported, where get_rdt_mon_resources() tries
to calculate mon_l3_config with uninitialized boot_cpu_data.x86_cache_occ_scale.

Add the missing resctrl_cpu_detect() in the Hygon BSP init helper.

  [ bp: Massage commit message. ]

Fixes: 923f3a2b48bd ("x86/resctrl: Query LLC monitoring properties once during boot")
Signed-off-by: Tianxiang Peng <txpeng@tencent.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Hui Li <caelli@tencent.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/20250623093153.3016937-1-txpeng@tencent.com

diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 2154f12766fb..1fda6c3a2b65 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -16,6 +16,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/delay.h>
 #include <asm/msr.h>
+#include <asm/resctrl.h>
 
 #include "cpu.h"
 
@@ -117,6 +118,8 @@ static void bsp_init_hygon(struct cpuinfo_x86 *c)
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << 10;
 		}
 	}
+
+	resctrl_cpu_detect(c);
 }
 
 static void early_init_hygon(struct cpuinfo_x86 *c)



Return-Path: <stable+bounces-172793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0C9B337C5
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 09:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714E8163232
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 07:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FB8283FEF;
	Mon, 25 Aug 2025 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LjufLJEU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE3215F6C
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756106858; cv=none; b=a0OWOtehMKt4wzH/6GX9cUByGzHBge5x2Q55Z8cKswdZril3EPdDZWiiT3Bi07+tylXCaLSMxO0PzO4pTSrLh94SBnjG+VXevCWmf6DN6Qen8LBwquX54rkf2WfJIl9bou5d+AltfZ+DR8ti/tW3psSOa0Ft8KW7L/jYH34MBU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756106858; c=relaxed/simple;
	bh=LMnQXv8E04iRt7xvpPkwTaNNRXMOe+i+nh5aZrd2I2w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AM7L62qzMFOJaS0rIpMc5ou5ktzyi7Gl32wdbiTv3Ku1H+pJRsVlaNmiO560kNepColKVxIf1YYTLE/Myk+Rgg/X9s0AdSeIORXtGiF8Y3z7BJRJh+3/C2xa+GRNFiQLmKMYxHKypKgMUd7FU9rIKp0r6F/LwYXzKSuplDkWcIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LjufLJEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258ADC4CEED;
	Mon, 25 Aug 2025 07:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756106857;
	bh=LMnQXv8E04iRt7xvpPkwTaNNRXMOe+i+nh5aZrd2I2w=;
	h=Subject:To:Cc:From:Date:From;
	b=LjufLJEUsYT2xJXEvOQ/PDzukFSlAWHZfeQgloABfWS6LpdD7DF76ExmBK07nfEIN
	 yYXlvGfeOrZ6KaC/57Unli56EmFVHi2H/henfEn5TaR+ES/Nne6WjRx14yygx7Ob7x
	 aNdquhV1exxz96RoStRLlhcGhvHhaoHKM9vKtm7Y=
Subject: FAILED: patch "[PATCH] x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init" failed to apply to 5.10-stable tree
To: txpeng@tencent.com,bp@alien8.de,caelli@tencent.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 25 Aug 2025 09:27:18 +0200
Message-ID: <2025082518-attest-grit-8063@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d8df126349dad855cdfedd6bbf315bad2e901c2f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082518-attest-grit-8063@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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



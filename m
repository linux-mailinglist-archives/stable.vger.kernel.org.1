Return-Path: <stable+bounces-192057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813E4C29029
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 15:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD74188D6EF
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51B01DF755;
	Sun,  2 Nov 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="woWVEOoZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AE434D3BD
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762093145; cv=none; b=sKMoeqb2h3nF4dU90K1HgYhSkQOpqXzZz0q/HVgQReVCfjwKhyy9HNifaNnyV55Tf+hCNvZrSR/w2GbKsQD3SOoay34EgM9ynme58HCS4cqJ/qLiMwmfPl7mj/riz46MKujWg/lU9OktSoLOnD79cgj9IdQ8DAISK6Zqsz8b/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762093145; c=relaxed/simple;
	bh=uJgmlknC9Cm+B20F810/nsoOKP9UM7nqkvzk01jL93k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jtQZWGwhoCg1EoUj/IAI6qA2hZUEax+7Ql12MF9JGzhDaiIab+3e3NKyid3+O5lkw7IVEdZHHame5GqwWUTsC98ZJf7d9R3a/+xbymzZKlcuQ1sEu0qy/uIz0nBgLOOCsBiSyYmrrDEE1TV05Ms1+YExj12MPkfB9tmvdE4cYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=woWVEOoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0557EC4CEF7;
	Sun,  2 Nov 2025 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762093145;
	bh=uJgmlknC9Cm+B20F810/nsoOKP9UM7nqkvzk01jL93k=;
	h=Subject:To:Cc:From:Date:From;
	b=woWVEOoZ/wAuPFrZ6Y3lcpZFAsQDNjCCmVWcwGGsO5HALK+k0VUV+/7fcow/Qqeaw
	 1idAVqFTIyVHN1PVvmOjX3RKQrEHxam43wc3dXixeMef60RC4G11dNW5Sf9fSYB2tF
	 iNx+GrEjEE7wYCwoUgs6ryJ35O5Rwwc7BjI6HmQs=
Subject: FAILED: patch "[PATCH] x86/CPU/AMD: Add RDSEED fix for Zen5" failed to apply to 6.12-stable tree
To: gourry@gourry.net,bp@alien8.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 02 Nov 2025 23:19:02 +0900
Message-ID: <2025110202-attendant-curtain-cd04@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 607b9fb2ce248cc5b633c5949e0153838992c152
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110202-attendant-curtain-cd04@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 607b9fb2ce248cc5b633c5949e0153838992c152 Mon Sep 17 00:00:00 2001
From: Gregory Price <gourry@gourry.net>
Date: Mon, 20 Oct 2025 11:13:55 +0200
Subject: [PATCH] x86/CPU/AMD: Add RDSEED fix for Zen5

There's an issue with RDSEED's 16-bit and 32-bit register output
variants on Zen5 which return a random value of 0 "at a rate inconsistent
with randomness while incorrectly signaling success (CF=1)". Search the
web for AMD-SB-7055 for more detail.

Add a fix glue which checks microcode revisions.

  [ bp: Add microcode revisions checking, rewrite. ]

Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20251018024010.4112396-1-gourry@gourry.net

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index ccaa51ce63f6..bc29be670a2a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1035,8 +1035,18 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
 	}
 }
 
+static const struct x86_cpu_id zen5_rdseed_microcode[] = {
+	ZEN_MODEL_STEP_UCODE(0x1a, 0x02, 0x1, 0x0b00215a),
+	ZEN_MODEL_STEP_UCODE(0x1a, 0x11, 0x0, 0x0b101054),
+};
+
 static void init_amd_zen5(struct cpuinfo_x86 *c)
 {
+	if (!x86_match_min_microcode_rev(zen5_rdseed_microcode)) {
+		clear_cpu_cap(c, X86_FEATURE_RDSEED);
+		msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
+		pr_emerg_once("RDSEED32 is broken. Disabling the corresponding CPUID bit.\n");
+	}
 }
 
 static void init_amd(struct cpuinfo_x86 *c)



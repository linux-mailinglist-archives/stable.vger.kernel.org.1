Return-Path: <stable+bounces-144211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CF4AB5C08
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE073461492
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D04827FB39;
	Tue, 13 May 2025 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ItQNIHdH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l73fVlEs"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A562DF68;
	Tue, 13 May 2025 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747159671; cv=none; b=M2GzoakLnaODrewR8HZuO7vGT5flnUTh7vT4buUB1NqV8kWLL6FcYqb3WSu9KZIiAQs+s02PV4ca8wBGZrmO5naSjAtuzbnR2pcvzYhZsEePIUKJTf6wuPHqmbt7jsmko4SnLLJHwqncnlutc2wrpM2d79FpwW6Yx7CuhUXizSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747159671; c=relaxed/simple;
	bh=JrgDdqxVdRWUdy8IKLD0plF2V1Ex1yMuaJ26WCozVEU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S7brvEgSzL2Tpb9SYTcolBQHy1RolLkzZpbBo+vAY50RCF6/sOEtELeGR00C6Q7X7A0oV/cKz9b+gNYmmCef875pn+xRy2ir0ZEF0Xgtj5dxSxrkXQ8KiayveusEceYZO1VGww6/cl8eqg0oervdfHkeBX+9qcI+LXVIAymOvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ItQNIHdH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l73fVlEs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 May 2025 18:07:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747159667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXinaKseiEVV1yJviAAoOn9tUohIDvpWlu0FTPrVgbs=;
	b=ItQNIHdH2uVI8P4yrDTjAKwNyMHYlM2ToUmUl1o5I+BCdP3Z1D0RGBTcG78jHMWpIP5bhI
	b257ecc/kaDTsPpOfZpQw6/92UKvwUaG7JLzzzap3CS0sywgB+NUlV3g2aSKH+3P3Fq243
	WZ3fwlvtN+hEtM6u1FFZwuivhQ1bihkbjBo/IO1wcMM9+6oIbMJLBw5YYA4GWblOfXS9zG
	3fioh+zSZwXcJMRMPvwSg3AkeBtqA4lYJRArEYtSmymyBZeLloes1ozgyAtmpGHJ4NUmXk
	5TqFBhEEmFTLb7rXeIG2wH7xdewfin58c4rDfSwU0jWUQslPKi9xiMroC8bZHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747159667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXinaKseiEVV1yJviAAoOn9tUohIDvpWlu0FTPrVgbs=;
	b=l73fVlEsNcBeIRtN8T3YjX7ovfCUck/7crRYRFTebd2wkpiomORA8f8WPw7Ji4jlh0REFx
	RbYFVuOE3z2no+Ag==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/sev: Make sure pages are not skipped during kdump
Cc: Ashish Kalra <ashish.kalra@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Srikanth Aithal <sraithal@amd.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250506183529.289549-1-Ashish.Kalra@amd.com>
References: <20250506183529.289549-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174715966675.406.16246033000717371214.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     82b7f88f2316c5442708daeb0b5ec5aa54c8ff7f
Gitweb:        https://git.kernel.org/tip/82b7f88f2316c5442708daeb0b5ec5aa54c8ff7f
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Tue, 06 May 2025 18:35:29 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 May 2025 19:47:48 +02:00

x86/sev: Make sure pages are not skipped during kdump

When shared pages are being converted to private during kdump, additional
checks are performed. They include handling the case of a GHCB page being
contained within a huge page.

Currently, this check incorrectly skips a page just below the GHCB page from
being transitioned back to private during kdump preparation.

This skipped page causes a 0x404 #VC exception when it is accessed later while
dumping guest memory for vmcore generation.

Correct the range to be checked for GHCB contained in a huge page.  Also,
ensure that the skipped huge page containing the GHCB page is transitioned
back to private by applying the correct address mask later when changing GHCBs
to private at end of kdump preparation.

  [ bp: Massage commit message. ]

Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250506183529.289549-1-Ashish.Kalra@amd.com
---
 arch/x86/coco/sev/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 41060ba..36beaac 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1101,7 +1101,8 @@ static void unshare_all_memory(void)
 			data = per_cpu(runtime_data, cpu);
 			ghcb = (unsigned long)&data->ghcb_page;
 
-			if (addr <= ghcb && ghcb <= addr + size) {
+			/* Handle the case of a huge page containing the GHCB page */
+			if (addr <= ghcb && ghcb < addr + size) {
 				skipped_addr = true;
 				break;
 			}
@@ -1213,8 +1214,8 @@ static void shutdown_all_aps(void)
 void snp_kexec_finish(void)
 {
 	struct sev_es_runtime_data *data;
+	unsigned long size, addr;
 	unsigned int level, cpu;
-	unsigned long size;
 	struct ghcb *ghcb;
 	pte_t *pte;
 
@@ -1242,8 +1243,10 @@ void snp_kexec_finish(void)
 		ghcb = &data->ghcb_page;
 		pte = lookup_address((unsigned long)ghcb, &level);
 		size = page_level_size(level);
-		set_pte_enc(pte, level, (void *)ghcb);
-		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
+		/* Handle the case of a huge page containing the GHCB page */
+		addr = (unsigned long)ghcb & page_level_mask(level);
+		set_pte_enc(pte, level, (void *)addr);
+		snp_set_memory_private(addr, (size / PAGE_SIZE));
 	}
 }
 


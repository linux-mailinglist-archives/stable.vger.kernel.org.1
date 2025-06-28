Return-Path: <stable+bounces-158819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38567AEC6B1
	for <lists+stable@lfdr.de>; Sat, 28 Jun 2025 13:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4828E4A0FC4
	for <lists+stable@lfdr.de>; Sat, 28 Jun 2025 11:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B370D24728A;
	Sat, 28 Jun 2025 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I8kq+ohB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2UJmiogp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C312185AC;
	Sat, 28 Jun 2025 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751110416; cv=none; b=bh9C4hDo/Yi0bgkktg8dbg8cKEsDlGVfD45aVxtLWmhgZ5mGn0P17E5WAPhUOBRhfcHWAABJaDF7dn13ro17+WRyyLHXwjB1h97YsJhyXyG2c2g+iBfAil2/XUMtpwabzb+Z9I+ztq6hIEfpwCGI+Vp1ovi5pCFmASFa+zFTWZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751110416; c=relaxed/simple;
	bh=16u7OuaNPXHqJuONnAOhuvO11B/SLK3UyITi5S4M1ZE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ImrpK1flJBVZW0AZ06FpD0ccqgfAdYeELBh8WlOJ+AbRo0qHKrf+j14gygOv099B6NZU+jJ0kE263UXcxBVex0/xkh+pXudihlJhH+PTDDaee+kDdxCwnm3p20mrcwz9JAGxPqlI/gE7RNYji4V5JHIhom7kvMqkSR58Htray1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I8kq+ohB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2UJmiogp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Jun 2025 11:33:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751110407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqh3z7X+ejo3GlM/NkpN6SjfNNFzgO7ETNPHrHWrrsg=;
	b=I8kq+ohBjrCF3GmobreHoYHMvQUFKb4c8t/wXRd45PobGkabRW7PQ+OOvD9uErL58QYFaa
	SaAoG9LvQb4slhswwqTIs4LYTqNGggskcK9ztDUpCqJ+qWmpV3fTnSd9Df8CwAUDNYvBcZ
	b+qJvQf5yj0nD4Zb8VTHKyQ7j4aI28JcTSNCdxa4y25pSxbF1ytLVJwflCSQLXn+Em0+nM
	qdK5LmaiHGczrVTRZ33PAGfE50dElprCmaiB/4Xvyia10HDi25u4QyxQ1mDezmdFUOe6ew
	IrLz605JdUNBzRfVpFbYrZUmCIivZMDYH6hNqjsPi7SN0wIj2oxYfTsaqbO8KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751110407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqh3z7X+ejo3GlM/NkpN6SjfNNFzgO7ETNPHrHWrrsg=;
	b=2UJmiogpcyo5Y0gHFjID3n9lRL3VN/5RUjg+JtkNzJ0mSCLI9B9w5Sh4iy91CmrCT2uK/q
	cIMshPBfxXtzIhAw==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: ras/urgent] x86/mce/amd: Add default names for MCA banks and blocks
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250624-wip-mca-updates-v4-3-236dd74f645f@amd.com>
References: <20250624-wip-mca-updates-v4-3-236dd74f645f@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175111040592.406.7571245350529428930.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/urgent branch of tip:

Commit-ID:     d66e1e90b16055d2f0ee76e5384e3f119c3c2773
Gitweb:        https://git.kernel.org/tip/d66e1e90b16055d2f0ee76e5384e3f119c3c2773
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 24 Jun 2025 14:15:58 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 27 Jun 2025 13:13:36 +02:00

x86/mce/amd: Add default names for MCA banks and blocks

Ensure that sysfs init doesn't fail for new/unrecognized bank types or if
a bank has additional blocks available.

Most MCA banks have a single thresholding block, so the block takes the same
name as the bank.

Unified Memory Controllers (UMCs) are a special case where there are two
blocks and each has a unique name.

However, the microarchitecture allows for five blocks. Any new MCA bank types
with more than one block will be missing names for the extra blocks. The MCE
sysfs will fail to initialize in this case.

Fixes: 87a6d4091bd7 ("x86/mce/AMD: Update sysfs bank names for SMCA systems")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250624-wip-mca-updates-v4-3-236dd74f645f@amd.com
---
 arch/x86/kernel/cpu/mce/amd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9d852c3..6820ebc 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1113,13 +1113,20 @@ static const char *get_name(unsigned int cpu, unsigned int bank, struct threshol
 	}
 
 	bank_type = smca_get_bank_type(cpu, bank);
-	if (bank_type >= N_SMCA_BANK_TYPES)
-		return NULL;
 
 	if (b && (bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2)) {
 		if (b->block < ARRAY_SIZE(smca_umc_block_names))
 			return smca_umc_block_names[b->block];
-		return NULL;
+	}
+
+	if (b && b->block) {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN, "th_block_%u", b->block);
+		return buf_mcatype;
+	}
+
+	if (bank_type >= N_SMCA_BANK_TYPES) {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN, "th_bank_%u", bank);
+		return buf_mcatype;
 	}
 
 	if (per_cpu(smca_bank_counts, cpu)[bank_type] == 1)


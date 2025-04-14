Return-Path: <stable+bounces-132569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4037A883A6
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574123BDBAC
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD5A2D0291;
	Mon, 14 Apr 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrRDHCO2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA82D0265;
	Mon, 14 Apr 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637433; cv=none; b=Oa6uu9E6cd3umJhY9ALsoSjOY7zWn8tCRO8QrZYq7jMetE9naWc7RpX7WlwDRwgDpiWJSVMAuQg2zF31+bMy0x2H3qtoRmghJ6CylWxMFRe6nm4b5iAABFWMcuArcDSY+O4gidu/HAmKeaJau97LqTN9XQnqut3fH5+BqYiduuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637433; c=relaxed/simple;
	bh=vJPLUNWKSaEKAOasV3y+UG3Otn8u1jhLJN4Zlvo+5jc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ndktsl1emZTdLNaEBLW/jCkkYFtJwusaBPRPKbCidy77y9/4NdqD4IZGFDSx8zu4MnKHttFoyM1JarP4skqDP7mVWqx2JtayreC7xHk8se+VGD/3NbvHYiU5OjhOrI80WyhtLK6ap3Q/LOUznloHZ7s/TH1SAjuAnBxsUw1gi54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrRDHCO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3C9C4CEED;
	Mon, 14 Apr 2025 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637431;
	bh=vJPLUNWKSaEKAOasV3y+UG3Otn8u1jhLJN4Zlvo+5jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XrRDHCO22TNKTMpIDWEkDMF18VUHm3sNAYAbwFBVHRLEeR+hO1UvP75RHV+HtTjkN
	 FEFsRqWEF4DkKd+52RJAK88f9Oi0BO0QLOP2rmj5Boialwbhmkcrs/SC/K33NV/8bV
	 ZSYHHj51hlS8R84RYk4ixHRmkahRDFH3iv+d1hfj7D5NPMhwqtzPyV9AMZKo1g6r2g
	 Rvs/nv93+t7N+M7K6kWLJSTa9jYmdA8TUd1N5ntyUyMhC1bC4RRkKS+/7bPxPbM9+L
	 oAJBEvgk7MR5PGFRVYbhe1HxIuuvSDvqaeuPiUZip8MT2iTmXwvDRnkhIHIfXiDVji
	 YB0DjLB7TWxSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Amit Shah <amit.shah@amd.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	bp@alien8.de,
	peterz@infradead.org,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: [PATCH AUTOSEL 6.6 16/24] x86/bugs: Don't fill RSB on VMEXIT with eIBRS+retpoline
Date: Mon, 14 Apr 2025 09:29:49 -0400
Message-Id: <20250414132957.680250-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 18bae0dfec15b24ec14ca17dc18603372f5f254f ]

eIBRS protects against guest->host RSB underflow/poisoning attacks.
Adding retpoline to the mix doesn't change that.  Retpoline has a
balanced CALL/RET anyway.

So the current full RSB filling on VMEXIT with eIBRS+retpoline is
overkill.  Disable it or do the VMEXIT_LITE mitigation if needed.

Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Reviewed-by: Amit Shah <amit.shah@amd.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Link: https://lore.kernel.org/r/84a1226e5c9e2698eae1b5ade861f1b8bf3677dc.1744148254.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 7df458a6553eb..a8fce2ab0f250 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1600,20 +1600,20 @@ static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_
 	case SPECTRE_V2_NONE:
 		return;
 
-	case SPECTRE_V2_EIBRS_LFENCE:
 	case SPECTRE_V2_EIBRS:
+	case SPECTRE_V2_EIBRS_LFENCE:
+	case SPECTRE_V2_EIBRS_RETPOLINE:
 		if (boot_cpu_has_bug(X86_BUG_EIBRS_PBRSB)) {
-			setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT_LITE);
 			pr_info("Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT\n");
+			setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT_LITE);
 		}
 		return;
 
-	case SPECTRE_V2_EIBRS_RETPOLINE:
 	case SPECTRE_V2_RETPOLINE:
 	case SPECTRE_V2_LFENCE:
 	case SPECTRE_V2_IBRS:
-		setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 		pr_info("Spectre v2 / SpectreRSB : Filling RSB on VMEXIT\n");
+		setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 		return;
 	}
 
-- 
2.39.5



Return-Path: <stable+bounces-246050-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF7wOKpqA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246050-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:00:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC28526783
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B97AB31946D8
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE163BB125;
	Tue, 12 May 2026 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lh0gXpRb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2783BB10B;
	Tue, 12 May 2026 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608229; cv=none; b=DKFKtYU5nYLhc+B2ebflqLsIf9UkzytqcDuRYVAUwnL9XrQfDKZ1lZbcRbh+IqEuqMD2tzO2MKlvyKB856g/CtQeiKkVbUDCdw3phW5kNYg4N0WtNfgN+I0OqhKjSeflAC6XsadPXYLZR7DFPD/rm9ddzqKXJKMEpLHZfcJkJ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608229; c=relaxed/simple;
	bh=LXvFFfxicwJyw0++38sQ0U//auBkCkDo3rF1P2pdCsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+tFnONDqLGOHhvPfSR/6gBK9+UmuMhb8CxBj80tR45XCF6aAAII1NamPlntHHHs+x3W3lvc6KJ6FMLbHEJZEFyUhpS28+dF4vqPWNXBD6n17KZZwaAvKOoy8cr8FmBz3jBJc69CWIS3Q1brNxAJr0wh78utbDEmGxj/Xgiowb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lh0gXpRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327FEC2BCB0;
	Tue, 12 May 2026 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608229;
	bh=LXvFFfxicwJyw0++38sQ0U//auBkCkDo3rF1P2pdCsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lh0gXpRbY1/L+ldN6lZRwd4wfVHQrAZeIKkud9EKs9LsSAUovtqGHa6SLw1qpVZOH
	 G0EefVlMotVXCztRFywFX5EL1Psh0sWGryPFiH6E2kco5jwbNcy2lW2iBpUOh54n5S
	 uCi2kq84X/nHlcU8amo3rC75DSq4zSnJIx49FD6c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prathyushi Nangia <prathyushi.nangia@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.12 206/206] x86/CPU/AMD: Prevent improper isolation of shared resources in Zen2s op cache
Date: Tue, 12 May 2026 19:40:58 +0200
Message-ID: <20260512173937.238604028@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6DC28526783
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246050-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prathyushi Nangia <prathyushi.nangia@amd.com>

commit c21b90f77687075115d989e53a8ec5e2bb427ab1 upstream.

Make sure resources are not improperly shared in the op cache and
cause instruction corruption this way.

Signed-off-by: Prathyushi Nangia <prathyushi.nangia@amd.com>
Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h       |    3 ++-
 arch/x86/kernel/cpu/amd.c              |    3 +++
 tools/arch/x86/include/asm/msr-index.h |    3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -734,9 +734,10 @@
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
 /* Zen4 */
-#define MSR_ZEN4_BP_CFG                 0xc001102e
+#define MSR_ZEN4_BP_CFG			0xc001102e
 #define MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT 4
 #define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
+#define MSR_ZEN2_BP_CFG_BUG_FIX_BIT	33
 
 /* Fam 19h MSRs */
 #define MSR_F19H_UMC_PERF_CTL           0xc0010800
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -989,6 +989,9 @@ static void init_amd_zen2(struct cpuinfo
 		msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
 		pr_emerg("RDSEED is not reliable on this platform; disabling.\n");
 	}
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN2_BP_CFG_BUG_FIX_BIT);
 }
 
 static void init_amd_zen3(struct cpuinfo_x86 *c)
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -717,8 +717,9 @@
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
 /* Zen4 */
-#define MSR_ZEN4_BP_CFG                 0xc001102e
+#define MSR_ZEN4_BP_CFG			0xc001102e
 #define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
+#define MSR_ZEN2_BP_CFG_BUG_FIX_BIT	33
 
 /* Fam 19h MSRs */
 #define MSR_F19H_UMC_PERF_CTL           0xc0010800




Return-Path: <stable+bounces-55610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F413916466
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C451C237B4
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE91D149E0A;
	Tue, 25 Jun 2024 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fg7+9tZ+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB954149C58;
	Tue, 25 Jun 2024 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309414; cv=none; b=E2Ofc+tHG8Kzz4MGfz2UhncEp3ZLrCO+KTX0RfTuMDmyYLNffGwcD4inypXyHL9Pj5wA5qn+W/mO5+H6+qf7XDWTDsIF/TsVD5DjS0U3jCF/zagFCFo1cDVdKevR/m5t7EPqtx5TjC1Egn+xlKxnZAHr0X0xyqtynhJCuqiK1XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309414; c=relaxed/simple;
	bh=+5JF8htbFhs6VdRBYF8vJaP+LUsuo/8I7nzCMkzBZV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3k0r1FN7CJyF7qVJbLTT8vn47CU9K4bYiDa+7vELnNm8esFfDXvZeXK8QaClanxYY9o/Q1aUdygy/7xu+T6tnYwn/7tMFu8PHjxaNxxF3PE47Nxv7aSvJ8NBgvurudanTK9mit9Dyf5xHmrhcTKXVKjRbV/cGp6mqqylXeyNX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fg7+9tZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30252C32781;
	Tue, 25 Jun 2024 09:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309414;
	bh=+5JF8htbFhs6VdRBYF8vJaP+LUsuo/8I7nzCMkzBZV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fg7+9tZ+lHxETh11ZPL8oUP1g7hDIeD5rejV/b5aGvxCcM4XlgUkOVzdbFS0Ybv2O
	 zzTG7Rg/a07P4y2waABRen17efpWiFdPiYXkdAjDk36Rh3OilrHTH3I4UIKUPqvysh
	 si3lsQ1aCGsxD6Ke57IQJkF08IEgtOClIa6R/zSg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	stable+noautosel@kernel.org
Subject: [PATCH 6.6 180/192] x86/cpu: Fix x86_match_cpu() to match just X86_VENDOR_INTEL
Date: Tue, 25 Jun 2024 11:34:12 +0200
Message-ID: <20240625085544.068866457@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit 93022482b2948a9a7e9b5a2bb685f2e1cb4c3348 ]

Code in v6.9 arch/x86/kernel/smpboot.c was changed by commit

  4db64279bc2b ("x86/cpu: Switch to new Intel CPU model defines") from:

  static const struct x86_cpu_id intel_cod_cpu[] = {
          X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X, 0),       /* COD */
          X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X, 0),     /* COD */
          X86_MATCH_INTEL_FAM6_MODEL(ANY, 1),             /* SNC */	<--- 443
          {}
  };

  static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  {
          const struct x86_cpu_id *id = x86_match_cpu(intel_cod_cpu);

to:

  static const struct x86_cpu_id intel_cod_cpu[] = {
           X86_MATCH_VFM(INTEL_HASWELL_X,   0),    /* COD */
           X86_MATCH_VFM(INTEL_BROADWELL_X, 0),    /* COD */
           X86_MATCH_VFM(INTEL_ANY,         1),    /* SNC */
           {}
   };

  static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  {
          const struct x86_cpu_id *id = x86_match_cpu(intel_cod_cpu);

On an Intel CPU with SNC enabled this code previously matched the rule on line
443 to avoid printing messages about insane cache configuration.  The new code
did not match any rules.

Expanding the macros for the intel_cod_cpu[] array shows that the old is
equivalent to:

  static const struct x86_cpu_id intel_cod_cpu[] = {
  [0] = { .vendor = 0, .family = 6, .model = 0x3F, .steppings = 0, .feature = 0, .driver_data = 0 },
  [1] = { .vendor = 0, .family = 6, .model = 0x4F, .steppings = 0, .feature = 0, .driver_data = 0 },
  [2] = { .vendor = 0, .family = 6, .model = 0x00, .steppings = 0, .feature = 0, .driver_data = 1 },
  [3] = { .vendor = 0, .family = 0, .model = 0x00, .steppings = 0, .feature = 0, .driver_data = 0 }
  }

while the new code expands to:

  static const struct x86_cpu_id intel_cod_cpu[] = {
  [0] = { .vendor = 0, .family = 6, .model = 0x3F, .steppings = 0, .feature = 0, .driver_data = 0 },
  [1] = { .vendor = 0, .family = 6, .model = 0x4F, .steppings = 0, .feature = 0, .driver_data = 0 },
  [2] = { .vendor = 0, .family = 0, .model = 0x00, .steppings = 0, .feature = 0, .driver_data = 1 },
  [3] = { .vendor = 0, .family = 0, .model = 0x00, .steppings = 0, .feature = 0, .driver_data = 0 }
  }

Looking at the code for x86_match_cpu():

  const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
  {
           const struct x86_cpu_id *m;
           struct cpuinfo_x86 *c = &boot_cpu_data;

           for (m = match;
                m->vendor | m->family | m->model | m->steppings | m->feature;
                m++) {
       		...
           }
           return NULL;

it is clear that there was no match because the ANY entry in the table (array
index 2) is now the loop termination condition (all of vendor, family, model,
steppings, and feature are zero).

So this code was working before because the "ANY" check was looking for any
Intel CPU in family 6. But fails now because the family is a wild card. So the
root cause is that x86_match_cpu() has never been able to match on a rule with
just X86_VENDOR_INTEL and all other fields set to wildcards.

Add a new flags field to struct x86_cpu_id that has a bit set to indicate that
this entry in the array is valid. Update X86_MATCH*() macros to set that bit.
Change the end-marker check in x86_match_cpu() to just check the flags field
for this bit.

Backporter notes: The commit in Fixes is really the one that is broken:
you can't have m->vendor as part of the loop termination conditional in
x86_match_cpu() because it can happen - as it has happened above
- that that whole conditional is 0 albeit vendor == 0 is a valid case
- X86_VENDOR_INTEL is 0.

However, the only case where the above happens is the SNC check added by
4db64279bc2b1 so you only need this fix if you have backported that
other commit

  4db64279bc2b ("x86/cpu: Switch to new Intel CPU model defines")

Fixes: 644e9cbbe3fc ("Add driver auto probing for x86 features v4")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable+noautosel@kernel.org> # see above
Link: https://lore.kernel.org/r/20240517144312.GBZkdtAOuJZCvxhFbJ@fat_crate.local
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/cpu_device_id.h | 5 +++++
 arch/x86/kernel/cpu/match.c          | 4 +---
 include/linux/mod_devicetable.h      | 2 ++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index dd7b9463696f5..e8e3dbe7f1730 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -53,6 +53,9 @@
 #define X86_CENTAUR_FAM6_C7_D		0xd
 #define X86_CENTAUR_FAM6_NANO		0xf
 
+/* x86_cpu_id::flags */
+#define X86_CPU_ID_FLAG_ENTRY_VALID	BIT(0)
+
 #define X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
  * X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE - Base macro for CPU matching
@@ -79,6 +82,7 @@
 	.model		= _model,					\
 	.steppings	= _steppings,					\
 	.feature	= _feature,					\
+	.flags		= X86_CPU_ID_FLAG_ENTRY_VALID,			\
 	.driver_data	= (unsigned long) _data				\
 }
 
@@ -89,6 +93,7 @@
 	.model		= _model,					\
 	.steppings	= _steppings,					\
 	.feature	= _feature,					\
+	.flags		= X86_CPU_ID_FLAG_ENTRY_VALID,			\
 	.driver_data	= (unsigned long) _data				\
 }
 
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index ad6776081e60d..ae71b8ef909c9 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -39,9 +39,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 	const struct x86_cpu_id *m;
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
-	for (m = match;
-	     m->vendor | m->family | m->model | m->steppings | m->feature;
-	     m++) {
+	for (m = match; m->flags & X86_CPU_ID_FLAG_ENTRY_VALID; m++) {
 		if (m->vendor != X86_VENDOR_ANY && c->x86_vendor != m->vendor)
 			continue;
 		if (m->family != X86_FAMILY_ANY && c->x86 != m->family)
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index b0678b093cb27..0f51bc24ae595 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -690,6 +690,8 @@ struct x86_cpu_id {
 	__u16 model;
 	__u16 steppings;
 	__u16 feature;	/* bit index */
+	/* Solely for kernel-internal use: DO NOT EXPORT to userspace! */
+	__u16 flags;
 	kernel_ulong_t driver_data;
 };
 
-- 
2.43.0





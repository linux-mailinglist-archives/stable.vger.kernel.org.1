Return-Path: <stable+bounces-217572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IiLAlBXmGncGQMAu9opvQ
	(envelope-from <stable+bounces-217572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 13:45:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B6916794E
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 13:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EEFB300A8FB
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F4C342CBA;
	Fri, 20 Feb 2026 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="duPk0HQC"
X-Original-To: stable@vger.kernel.org
Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57BD278156
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771591490; cv=none; b=lh11RZQIH/jKTC7oW9xYJA7WDP7bNOcS0zJZ7Yv22SOOhle4WGkEMWbO83R5BER8poqiNZczOhjt3dtK/ZkExvMWzcSFwcAolUM9pOkt9wSz02b3y3SKysklmxTVRcpjq8eohrUDuGMdaCdtXNFVSD9L1ASWaiD1SvyJLkeEgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771591490; c=relaxed/simple;
	bh=6u5IeIgvjbDjaxjJTuRXTmR6NGkknxCa5fR2Rwz+LWc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRBZyaH7lUstO4UkXxWLKxU12aCTMdtAogFMGk7rYioFi1vD2CCxexc42GXfXlzPdGDmz3v8QLW1KBfKYlAbb0b61RnSjbjmY308qrppIhkQ/7JbLAL7C/XikrD13vlm3guOorGAe9wJFIzpxYy8OCT7wx0cgzoM98026799GRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=duPk0HQC; arc=none smtp.client-ip=109.224.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1771591485; x=1771850685;
	bh=8dY8pcaRxOZ1sCdxB4dipkfHn87abpoNsKCXX3e6sA4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=duPk0HQCa7RpiMdt1qbkfvCrZxOHkzMtmT0R8vqy0qM/+st/6I+LVd+FcDxuflMdh
	 emSSnWcd5+85uiNTmMbix8W35Dzz+/FJNz1zmdtQM2WiPTutPZUVJKjupy8DY4Q304
	 HuL2+GZjXiApd50GvOQr+D8MTqG/hpZcyRbw+NqYBYz4+s2ydhJ9poWY9iWcNfY3CG
	 N6+vylw7tsSnFLPswizHrJ/1tBlyQzoQPwGQ8gHsvL2TWhp0KjwBs5jX2gNtR6EDF5
	 ucWNe7XGMRij5ZOq1HUHtCMSplUb/BaxeY80moFCAONYFQKQhJUOgAnS8PPMhZYbVI
	 LFuLGtFtd95mQ==
Date: Fri, 20 Feb 2026 12:44:41 +0000
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: m.wieczorretman@pm.me, Farrah Chen <farrah.chen@intel.com>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] x86/cpu: Clear feature bits disabled at compile-time
Message-ID: <b7d1fc26c8f0cca21e710360954a11be6c5d93e4.1771590895.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1771590895.git.m.wieczorretman@pm.me>
References: <cover.1771590895.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: f321113ee7ba66fe27866265a4af1d7666746fec
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[pm.me:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217572-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[pm.me:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.wieczorretman@pm.me,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pm.me:mid,pm.me:dkim]
X-Rspamd-Queue-Id: 62B6916794E
X-Rspamd-Action: no action

From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

If some config options are disabled during compile time, they still are
enumerated in macros that use the x86_capability bitmask - cpu_has() or
this_cpu_has().

The features are also visible in /proc/cpuinfo even though they are not
enabled - which is contrary to what the documentation states about the
file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
split_lock_detect, user_shstk, avx_vnni and enqcmd.

Once the cpu_caps_cleared array is initialized with the autogenerated
disabled bitmask apply_forced_caps() will clear the corresponding bits
in boot_cpu_data.x86_capability[] and other secondary cpus'
cpu_data.x86_capability[]. Thus features disabled at compile time won't
show up in /proc/cpuinfo.

Reported-by: Farrah Chen <farrah.chen@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220348
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: <stable@vger.kernel.org> # 6.18.x
---
Changelog v6:
- Remove patch message portions that are not just describing the diff.

 arch/x86/kernel/cpu/common.c       | 3 ++-
 arch/x86/tools/cpufeaturemasks.awk | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index e7ab22fce3b5..8d12c5722245 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -732,7 +732,8 @@ static const char *table_lookup_model(struct cpuinfo_x8=
6 *c)
 }
=20
 /* Aligned to unsigned long to avoid split lock in atomic bitmap ops */
-__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long=
));
+__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long=
)) =3D
+=09DISABLED_MASK_INITIALIZER;
 __u32 cpu_caps_set[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
=20
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/tools/cpufeaturemasks.awk b/arch/x86/tools/cpufeature=
masks.awk
index 173d5bf2d999..b7f4e775a365 100755
--- a/arch/x86/tools/cpufeaturemasks.awk
+++ b/arch/x86/tools/cpufeaturemasks.awk
@@ -82,6 +82,12 @@ END {
 =09=09}
 =09=09printf " 0\t\\\n";
 =09=09printf "\t) & (1U << ((x) & 31)))\n\n";
+
+=09=09printf "\n#define %s_MASK_INITIALIZER\t\t\t\\", s;
+=09=09printf "\n\t{\t\t\t\t\t\t\\";
+=09=09for (i =3D 0; i < ncapints; i++)
+=09=09=09printf "\n\t\t%s_MASK%d,\t\t\t\\", s, i;
+=09=09printf "\n\t}\n\n";
 =09}
=20
 =09printf "#endif /* _ASM_X86_CPUFEATUREMASKS_H */\n";
--=20
2.53.0




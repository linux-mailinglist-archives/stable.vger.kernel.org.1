Return-Path: <stable+bounces-217911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEWQL5OcnWnwQgQAu9opvQ
	(envelope-from <stable+bounces-217911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:41:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E3D1871AD
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93DD0304BEAD
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354ED396D05;
	Tue, 24 Feb 2026 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="q+59N3Gg"
X-Original-To: stable@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD1396B7F
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936833; cv=none; b=epQlYXjaPOaKYg8rMXFwnuutj5zGvIcdKDwSfeGh2arlgSnar9A8x0BG3hWiCB9HseJEzwSDb48y/6BztDcM7/Qm/YTFsU5rI2PH8ZUja/pIGVZMdhs5YcfIXC15VrB31rpwk0EEQLBT9bK+uzDvstYVZSlvqpffcfn6XDYMThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936833; c=relaxed/simple;
	bh=6YiO3aEEMJaPzYYMxUMPBSbOzfWX3uI2ARHdUHzLVj4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NloW1Vl8vnLvc3H6CtUrcJW30myHBxKeQsaTE4IA4fN88bdJcVVl/VD5toB+gE4Kv9XB3ukxepR8wcMqC6alZlrya/ymzyI3tTmzbhExbO7b/gpujocPrVTaV8MWRH9OnW4CHkm8fX2S7+HlNl22J7gG7qomwXxN4wBRg+91naI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=q+59N3Gg; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1771936822; x=1772196022;
	bh=QrkeH5U9fQQelEPd+SKbWGI2+T7gqRMRbmw70mxyA5Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=q+59N3GgOl54tAWVfCvfaLW8whmNB1jhv5DdMNbd3v6kD1OLwB3YL+fqxJbW2wynq
	 gAmf6UAccX4ANWaLqPh5U3Xll9CbmENh54yag8jZM2FtMQOsX+IudP9RrCvvD4qYB4
	 RQUvlNS7a2bm7x7zXKi4HZtKkBK/zgVrci1ed6OFQKSp7Dl7VFMWunn1MhiKjWHIZ1
	 8mi2N3qmV3Sl9dxHMWOnS3Pcy4O2yUOOrqXFB8wpuI/0hb7Dkdk43uCvwDvqZ3bA45
	 UmYJ1oaMeCSzRN81hW7mZwEOw5wvTOtkTLkgccWxl9afRe6LbouLplJvugJMqjVuDu
	 +H3k+P92DBI+w==
Date: Tue, 24 Feb 2026 12:40:18 +0000
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: m.wieczorretman@pm.me, Farrah Chen <farrah.chen@intel.com>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/3] x86/cpu: Clear feature bits disabled at compile-time
Message-ID: <6b042d059be8341a7122c9d7c72fd8204211de44.1771936214.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1771936214.git.m.wieczorretman@pm.me>
References: <cover.1771936214.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: d63de67c71f23d9947820f0484b3848053389134
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217911-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,pm.me:mid,pm.me:dkim]
X-Rspamd-Queue-Id: E4E3D1871AD
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
index 1c3261cae40c..9aa11224a038 100644
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




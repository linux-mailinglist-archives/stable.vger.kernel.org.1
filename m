Return-Path: <stable+bounces-215975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPM8NSzzjWlw8wAAu9opvQ
	(envelope-from <stable+bounces-215975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 16:35:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F63512F01A
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 16:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66331302DF78
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 15:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100F92C2365;
	Thu, 12 Feb 2026 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="LkvNi11u"
X-Original-To: stable@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF51F3B87
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770910502; cv=none; b=FIjIv+MdIt43Y/gZxaPiFtL0ShbWQpnpubGRQb7fRC6QqmitJhwAIP0IWcVHV3nayFfAn5oESYzRorjtENOZPLvLMjXzab1G64PMFgc18nFrEOTyqVH1Xb38siSvlcUdL+6J/84FcI1nkwhrK+e5LoCaAWHH9SAAOHwpQ2BwX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770910502; c=relaxed/simple;
	bh=GKU97sFrDJU9ubg2pcOiS88y9fxPx469uJTR7aE6ieM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsgTr4TZK3OZrCKG5n4Y9AWltqpJB6U0AqLR6KMYPb2VriwaSZ9w53yljXgk2e13jzZlM7XWkf0k7ifUDBhxxm6X1zhiLLVqOtklYK+TtEI7U7lgzj5Eyv6CbBVxIc1qbsSOSJk07lRWQBHs/6toa73dhrzwIBTf9ntJ+H50pqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=fail smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=LkvNi11u; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1770910483; x=1771169683;
	bh=4M+Owbd0HeHgku23Jntag7YvEbhLlJDH/9jpPFuXA6I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LkvNi11ucnkDX/2xnpTUxpj/bCdwE7jsGSoECQXV5bYHUB2FR14P/tWdKaT0/+meO
	 lS5AQ1VDp2eUI7fH5wPoAcuBLQ1SErjdxA8Hy01o0Pp2PWovt1lEQHPKJE9YSn0pRO
	 SdNKYKVcLZTFfTi1lSTFBdfWqUPxtc9nT9PP1m2lDjdmC93oX28oqI7uupScMmA04G
	 tFut9ZKv7RCz3pygvKsgF++U8hUJLrmjzjjEWLJcP2TNgQMuph7PVUe8InR648u3Uc
	 W63m/yOzKfq7cB59BVAzVtBKJol9RSHf+dkxQpiHDrTcngubAuEuCxjSYwGjZqUEI+
	 EJSjcEOGM87eg==
Date: Thu, 12 Feb 2026 15:34:38 +0000
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: m.wieczorretman@pm.me, pawel.chmielewski@linux.intel.com, Farrah Chen <farrah.chen@intel.com>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] x86/cpu: Clear feature bits disabled at compile-time
Message-ID: <32fbbfc16974cfed11e7d2651bce836ba9ceaccc.1770908783.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1770908783.git.m.wieczorretman@pm.me>
References: <cover.1770908783.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 13dc42a1ba63ab0ef2e91884790de5ad50f75227
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[pm.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[pm.me:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.wieczorretman@pm.me,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-215975-lists,stable=lfdr.de];
	TAGGED_RCPT(0.00)[stable];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[pm.me:+]
X-Rspamd-Queue-Id: 3F63512F01A
X-Rspamd-Action: no action

From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

If some config options are disabled during compile time, they still are
enumerated in macros that use the x86_capability bitmask - cpu_has() or
this_cpu_has().

The features are also visible in /proc/cpuinfo even though they are not
enabled - which is contrary to what the documentation states about the
file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
split_lock_detect, user_shstk, avx_vnni and enqcmd.

Through the cpufeaturemasks.awk script add a DISABLED_MASK_INITIALIZER
macro that creates an initializer list filled with DISABLED_MASKx
bitmasks.

At the same time add a REQUIRED_MASK_INITIALIZER that can be used for a
sanity check of whether all the required feature bits are set at the end
of cpu identification.

Initialize the cpu_caps_cleared array with the autogenerated disabled
bitmask. apply_forced_caps() will clear the corresponding bits in
boot_cpu_data.x86_capability[] and other secondary cpus'
cpu_data.x86_capability[]. Thus features disabled at compile time won't
show up in /proc/cpuinfo.

Reported-by: Farrah Chen <farrah.chen@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220348
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: <stable@vger.kernel.org> # 6.18.x
---
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




Return-Path: <stable+bounces-222626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN/uL4CspWmpDgAAu9opvQ
	(envelope-from <stable+bounces-222626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 16:28:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 394891DBD1F
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 16:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4683B304F4B0
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020D23FD13D;
	Mon,  2 Mar 2026 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="gI3wxZtM"
X-Original-To: stable@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D9430BB1;
	Mon,  2 Mar 2026 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465122; cv=none; b=WlMprsGdOguYM4Qb6JONRPVLZAOjP/Vy65UlKJoaGLdrtdplrE35g5QsYI9680VdsYJcu27+zmURNgOZceIGRgEuc2GccLO1FQ5K59PgrlT7AdwsrIjTXPp1Nbf/+TRI6E391ccaV9XXjmqD8ClrkSzblFWV3AonfW+8DAefejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465122; c=relaxed/simple;
	bh=6YiO3aEEMJaPzYYMxUMPBSbOzfWX3uI2ARHdUHzLVj4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBzqIZOfxr6qA1+2yK0bTiq6FAfkxJi8kKqVHusPGW6BfgrWtb74jjMXkKn23Gi4DUSyN98yXef0ZkZ+QfMnmRkMoCvsQ8AChdSTpBIyHk4rVs8W53hfWxIPIbEITbO6l8C0hcI0N/kN/aomg49csCUn1fCPLWOYIMX1QUMi8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=gI3wxZtM; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1772465113; x=1772724313;
	bh=QrkeH5U9fQQelEPd+SKbWGI2+T7gqRMRbmw70mxyA5Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gI3wxZtMJ/YHHlteofLz9tgobEzpL4Cy+Z9E67K/zgs+K4HCuBi9JZu+CAj1VnrFm
	 ZjLozTRCYoee2ap48PIJ6dtnP4lpad17OEzsIbkqSNOE50HB1H0HKoUAi/S5Gm3ddM
	 nvm7yj70l4eLnRl7JUY6+uzyBrb2SyWR7FXYMcq8gI4TW8G9oYACAWIgBce9rNQ7CK
	 IANgjqpJ8abwcF5jznJygyp7bwgZoXEh2MI4uob6hzbt7+uhLUtacM5WpWLxbdIyKP
	 W8gZ8DZhPXwiufkBOrCZT2ZmJxXIfVyiaR6jaGMNytcHUKf125jkZt68qHuRov6Dkc
	 6CYaUQiELOPDw==
Date: Mon, 02 Mar 2026 15:25:10 +0000
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: m.wieczorretman@pm.me, Farrah Chen <farrah.chen@intel.com>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/3] x86/cpu: Clear feature bits disabled at compile-time
Message-ID: <cb4c2a6a0e67320b24244658b724acc1bf9686ef.1772453012.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1772453012.git.m.wieczorretman@pm.me>
References: <cover.1772453012.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: bec042c3e9c91a789964897fc23067bf2f58798d
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 394891DBD1F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[pm.me:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222626-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pm.me:dkim,pm.me:mid,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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




Return-Path: <stable+bounces-222695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLuXJTXqpWlLHwAAu9opvQ
	(envelope-from <stable+bounces-222695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 20:51:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 960071DEF80
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 20:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 736EA308706A
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 19:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E525E383C7A;
	Mon,  2 Mar 2026 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="aSSzl9QX"
X-Original-To: stable@vger.kernel.org
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88633859D1
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480949; cv=none; b=dl52WnQcP2/ipF5ZmZFGDYF8ds6NgXjL6GVdivaewYL0PJUvmPARQvEL/EKiBLXMTRLpempUklknz1lnK7PFR+5iB3cQi0BXoB9jstmR5pRv7rE/5qoTBefsSzJO5GSR6U8Jw6qGlM9IkcH3gEXuEGLMXtb4uHfWZq6fC0RH8TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480949; c=relaxed/simple;
	bh=F4JWrBCYRMohT795u3OelCGJ8+4PI75BN22Q/T6Hf6o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMkYw2lzEWLCMMRm2ZOr7Dr7M8eNUaEKppSL5fkV76HPnDq+CY1E4wjSLO9BLQQyOKLXSFGR79v7MFQnAhakoKvTHJ59ww0uJFdylesXFDPdzfiTv/smAKLcWHPwxYVQj/IqDnwX4WAPihl6OlzAg9o1189RMKvQKeiJ4ZxjrDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=aSSzl9QX; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1772480936; x=1772740136;
	bh=cSU1ztxQjYZxHoKQg9m5+9eZEvCtU8IAfrCg+zFRUek=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aSSzl9QXyyKhRyJ2ZZDnmUAKIlSQ/wICB/QivP31QWl896WowOgNvgpUaBupvtUYc
	 j99ZMoqebH68W/5VUfdhDyG4sMTUwkCTkl8s2VSn5xNf8edcAHRq2jKxDdgV7JtR94
	 rBPyHEcmjhn4R74HigHewprhvBiJfspGpfvfvUNuK2gBo37WMOg/k1EEHWcROca9dK
	 xv6VCmf5Wu0cYvoh7pknLynGjiVVrlVCoXDbObfEGtRd5IvueRsSkDo63beRf+xqt7
	 gmF7QuLTurCRbheSgJyXuQqs7xv6fcWS0jU/lKFsYCtuubi6n1SJAwVOJKodKmHSk5
	 Ke9AOVPEOtS9Q==
Date: Mon, 02 Mar 2026 19:48:41 +0000
To: Borislav Petkov <bp@alien8.de>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Farrah Chen <farrah.chen@intel.com>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] x86/cpu: Clear feature bits disabled at compile-time
Message-ID: <aaXmP1pOU_feTVu9@wieczorr-mobl1.localdomain>
In-Reply-To: <20260302193142.GBaaXlnu86gUtPyQG6@fat_crate.local>
References: <cover.1772453012.git.m.wieczorretman@pm.me> <cb4c2a6a0e67320b24244658b724acc1bf9686ef.1772453012.git.m.wieczorretman@pm.me> <20260302193142.GBaaXlnu86gUtPyQG6@fat_crate.local>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 83c705413a75dcae2029ddc22146dbf3a4e8033a
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 960071DEF80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pm.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[pm.me:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222695-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pm.me:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.wieczorretman@pm.me,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pm.me:dkim]
X-Rspamd-Action: no action

On 2026-03-02 at 20:31:42 +0100, Borislav Petkov wrote:
>On Mon, Mar 02, 2026 at 03:25:10PM +0000, Maciej Wieczor-Retman wrote:
>> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>>
>> If some config options are disabled during compile time, they still are
>> enumerated in macros that use the x86_capability bitmask - cpu_has() or
>> this_cpu_has().
>>
>> The features are also visible in /proc/cpuinfo even though they are not
>> enabled - which is contrary to what the documentation states about the
>> file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
>> split_lock_detect, user_shstk, avx_vnni and enqcmd.
>>
>> Once the cpu_caps_cleared array is initialized with the autogenerated
>> disabled bitmask apply_forced_caps() will clear the corresponding bits
>> in boot_cpu_data.x86_capability[] and other secondary cpus'
>
>All your text: s/cpu/CPU/g

Sure, I'll change it.

>
>> cpu_data.x86_capability[]. Thus features disabled at compile time won't
>> show up in /proc/cpuinfo.
>>
>> Reported-by: Farrah Chen <farrah.chen@intel.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220348
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> Cc: <stable@vger.kernel.org> # 6.18.x
>
>So why is this going to stable anyway?
>
>What is the serious issue this is fixing? Really...?

The documentation from at least 5.10 onwards promises to have flags in cpui=
nfo
only if they're truly compiled and enabled. So I thought that incosistency =
can
be corrected from that point on. For the 6.18 stable kernel this particular
patch applies cleanly because it already started using the awk script. For =
the
older ones I took Greg's advice and prepared separate patch that worked bef=
ore
the awk script was introduced.

>> ---
>> Changelog v6:
>> - Remove patch message portions that are not just describing the diff.
>>
>>  arch/x86/kernel/cpu/common.c       | 3 ++-
>>  arch/x86/tools/cpufeaturemasks.awk | 6 ++++++
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>> index 1c3261cae40c..9aa11224a038 100644
>> --- a/arch/x86/kernel/cpu/common.c
>> +++ b/arch/x86/kernel/cpu/common.c
>> @@ -732,7 +732,8 @@ static const char *table_lookup_model(struct cpuinfo=
_x86 *c)
>>
>>  /* Aligned to unsigned long to avoid split lock in atomic bitmap ops */
>> -__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned l=
ong));
>> +__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned l=
ong)) =3D
>> +=09DISABLED_MASK_INITIALIZER;
>
>DISABLED_MASK_INIT is kinda obvious already.

Okay, I'll shorten it.

>
>--
>Regards/Gruss,
>    Boris.
>
>https://people.kernel.org/tglx/notes-about-netiquette

--=20
Kind regards
Maciej Wiecz=C3=B3r-Retman



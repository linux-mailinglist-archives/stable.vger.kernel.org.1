Return-Path: <stable+bounces-214870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Lgu7CwfeiGmPxgQAu9opvQ
	(envelope-from <stable+bounces-214870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 20:03:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 671F8109F50
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 20:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1CED300CE47
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E0E28852B;
	Sun,  8 Feb 2026 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="i9gxM4h3"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1A125A0;
	Sun,  8 Feb 2026 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770577408; cv=none; b=Wg3lM86sFJnfTgtbMDvgRj8wHFIB/HUgAuiZtbqYZyM0Dfo4DIc0wbe6XUdU4oqsTndet5ZtsoIBygFTtn+nBBPOvjUZG6fJyejcZqP9iUiXzGcv1weQy1whP1a6846SsivY27HoyQHOMP31WhyqUoVOTNFxw9BV97BwxP4rnuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770577408; c=relaxed/simple;
	bh=HO1gtYI+cuw1qebpMmTsoFuLK1nj3uaPVlm4u/66mJo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SZ3nOVBK+UbJ17fNgmP9gFyLlmQFzg0lFSmR6rj9/NSplW/pcZLTBNmtY5DvuoTDGYjvq093spnxeBpO+k6i0TccAwpVOnDQB5GS4uNEGZtPOv3cnnQQZeQF1vH1X0IObhvfleAojLtFT654XMm5HXJrr/XLGd/zo/mVi46zcTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=i9gxM4h3; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from smtpclient.apple (c-24-130-165-117.hsd1.ca.comcast.net [24.130.165.117])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 618J2Dur2368556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 8 Feb 2026 11:02:13 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 618J2Dur2368556
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770577336;
	bh=360UmSY/czEHbtw9BfxwqbaGQOjWwnLSTv8AMRnkfYg=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=i9gxM4h3wUmagAFzK/BHtvtjNxpWLvpEv1fcUn4irEYdMLD47YuX2osGznqx4rcBP
	 yCOolUqh3gHqrM+jPuV2ViRsZI4Upzas8zcDKglyfDLkhoEk0tZbPRpXSkOyhASYyw
	 OGPqrtn7gUxGBWxX2Fx89RvincAcXlb3Lob3Hy1WyJBor5714KkY8QLmuyh73Tcqj1
	 +gvbq0mlUCtEEhqPjFbpA2fhIxjwets6PJz97vkBa21AuBrBKp1h8gAVrBf+vrUOtx
	 dc3ra9oDVsGCEG7y0PNTrM0mvpae5o4qj/PYsL7EcLxF0qtjpFEYnt87RGcjoJTqr6
	 kYb+SaMlk3SMQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v1] x86/smp: Set up exception handling before cr4_init()
From: Xin Li <xin@zytor.com>
In-Reply-To: <a7be319d-381f-469d-9d5b-ddcf43d884e4@intel.com>
Date: Sun, 8 Feb 2026 11:02:02 -0800
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org, andrew.cooper3@citrix.com,
        sohil.mehta@intel.com, nikunj@amd.com, thomas.lendacky@amd.com,
        seanjc@google.com, stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DAF4D431-5596-4FD1-BF8B-D7D753C0810C@zytor.com>
References: <20260206185035.1250577-1-xin@zytor.com>
 <a7be319d-381f-469d-9d5b-ddcf43d884e4@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214870-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[zytor.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xin@zytor.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zytor.com:mid,zytor.com:dkim]
X-Rspamd-Queue-Id: 671F8109F50
X-Rspamd-Action: no action


>> + /*
>> +  * Ensure bits set in cr4_pinned_bits are set in CR4.
>> +  *
>> +  * cr4_pinned_bits is a subset of cr4_pinned_mask, which includes
>> +  * the following bits:
>> +  *         X86_CR4_SMEP
>> +  *         X86_CR4_SMAP
>> +  *         X86_CR4_UMIP
>> +  *         X86_CR4_FSGSBASE
>> +  *         X86_CR4_CET
>> +  *         X86_CR4_FRED
>> +  */
>> + cr4_init();
>=20
> I'm not as big of a fan of this comment. The next pinned bit that gets
> added will make this stale. Could we try to make this more timeless, =
please?

Right, it=E2=80=99s still a potential problem.

>=20
> I'm also not sure I like the asymmetry of this between the boot and
> secondary CPUs. On a boot CPU, CR4.SMEP will get set via
> identify_boot_cpu() and eventually setup_smep(). On a secondary CPU,
> it'll get set in cr4_init() and *not* in setup_smep().
>=20
> This asymmetry is (I think) part of what the root of the problem is =
here
> and how this bug came to be.

Are you proposing a single CPU initialization function for both BSP and
APs?

It reminds me that tglx proposed the following change when I was fixing
a FRED boot order bug.

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 6de12b3c1b04..a4735d9b5a1d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2176,7 +2176,7 @@ static inline void tss_setup_io_bitmap(struct =
tss_struct *tss)
  * Setup everything needed to handle exceptions from the IDT, including =
the IST
  * exceptions which use paranoid_entry().
  */
-void cpu_init_exception_handling(void)
+void cpu_init_exception_handling(bool boot_cpu)
 {
 	struct tss_struct *tss =3D this_cpu_ptr(&cpu_tss_rw);
 	int cpu =3D raw_smp_processor_id();


So something like

	void cpu_init(bool boot_cpu)

and it gets called on both BSP and APs.

>=20
> I really think the current pinning behavior is too invasive. It has =
zero
> benefit to be pinning CR bits this early in bringup. It's only causing =
pain.


Maybe someone can explain why it=E2=80=99s added like this before I find =
time to
dig into it.

I=E2=80=99m curious why cr4_init() is not part of the following =
cpu_init()? IOW,
why does it need to be called so early in the existing code?


>=20
> I _really_ think we need a defined per-cpu point where pinning comes
> into effect. Marking the CPU online is one idea.
>=20
> Thoughts?

It seems a good fit.  Just that {on,off}line() are not called on BSP =
(not
a real problem).

Question is that who would work on it ;) ?=


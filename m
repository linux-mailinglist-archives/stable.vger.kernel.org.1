Return-Path: <stable+bounces-215596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UvQxKDSiimleMgAAu9opvQ
	(envelope-from <stable+bounces-215596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 04:12:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01603116B23
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 04:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB7FB3007E2F
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 03:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87F32DC334;
	Tue, 10 Feb 2026 03:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Do+C+ZME"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005942405ED;
	Tue, 10 Feb 2026 03:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770693166; cv=none; b=TKb9gCzcvoikmB6yDU1co7p4rBR0WoH2RqqP/v+cSzWADNwnppmXDNQgFhhoJt6y/iO4YwD4ssddSsW4DPxzOshp63l/QpeJN2glckHTyKVINaENRZM5lWoGl0pJ9FWpyoSB/FULGq9Nhrr5NZfL8Cc/yiVsGKAIZpMdMFZMpsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770693166; c=relaxed/simple;
	bh=oCywwTiFqVDjXbaZ3YOOAyerrOvEfdEy2EY0BkdU9Zk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=g1Zz7cYtwjC7F3R/nHS33AkTV43oUPkO71MO45jRPw6tnN5JIZAm4om6b4qA8gqo78oRqbMHWiDBHA6K79yu7KlLRlA0oNmiacpA91ZTcmDipr7O/dSuCOOxk79hCJLiRRWFtPupV6q08sCPCiKDqode0B1nA/Ga/h4zYd/PiAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Do+C+ZME; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from smtpclient.apple (c-24-130-165-117.hsd1.ca.comcast.net [24.130.165.117])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61A3Bp1X3126032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 9 Feb 2026 19:11:51 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61A3Bp1X3126032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770693112;
	bh=x3Jpjto0+dFqnJ4u+mgwXcird8EBQd0JtbDN8a+uy20=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=Do+C+ZMEQldOffopI6Wjah6oEAy/lfkgFPtcc0FnpgPgX642kJJc8DYYsk1F5NP3L
	 cinuP37wkNQz8SYYP/n4Loc5uu3rKpmugb3Mp5DvhyMQ5Dr7d+fMUP9leIaeZ7Hvph
	 4aZIwMRrvDqBhvfMWcPS/5mnhtPs1/VnfRjydcqmhD45CdIGJecoWp+DW/o8qEDnss
	 f2rLFAM+N8h2SyfBNsOYtWCrBbXGXxpmeKH0q/hdqp30mf1WBnZYRvSch+vXm/jI9V
	 ga7yUTslIJ/q5h3tBt2c735MJO5V3t2IN/8+6NI+7SahZIkyb+9ZDTCF5AjojBp+j4
	 MTl4mdBYINOyg==
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
In-Reply-To: <3f31f8f8-b0a6-4ff9-b2ea-eeb04196b20a@intel.com>
Date: Mon, 9 Feb 2026 19:11:41 -0800
Cc: Sohil Mehta <sohil.mehta@intel.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com, nikunj@amd.com,
        thomas.lendacky@amd.com, seanjc@google.com, stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1A25CD17-B30C-4B36-811A-5DFD3F75B647@zytor.com>
References: <20260206185035.1250577-1-xin@zytor.com>
 <a7be319d-381f-469d-9d5b-ddcf43d884e4@intel.com>
 <DAF4D431-5596-4FD1-BF8B-D7D753C0810C@zytor.com>
 <37de06e1-aae4-4ebd-ac93-1846ee4cd91e@intel.com>
 <52e152b9-c840-4480-9337-0f0aca327543@intel.com>
 <3f31f8f8-b0a6-4ff9-b2ea-eeb04196b20a@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215596-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xin@zytor.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[zytor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zytor.com:mid,zytor.com:dkim]
X-Rspamd-Queue-Id: 01603116B23
X-Rspamd-Action: no action



> On Feb 9, 2026, at 5:13=E2=80=AFPM, Dave Hansen =
<dave.hansen@intel.com> wrote:
>=20
> On 2/9/26 16:18, Sohil Mehta wrote:
>>=20
>> However, I found another location where we enable FRED in CR4 before
>> enabling the MSRs.


IIRC, it=E2=80=99s expected:

=
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3De5f1e8af9c9e151ecd665f6d2e36fb25fec3b110



>>=20
>> __restore_processor_state():
>>=20
>> ...
>>=20
>>  __write_cr4(ctxt->cr4);
>>=20
>> ...
>>=20
>>  if (ctxt->cr4 & X86_CR4_FRED) {
>>    cpu_init_fred_exceptions();
>>    cpu_init_fred_rsps();
>>  }
>>=20
>> Due to limitations of my test platform, I couldn't verify the FRED =
print
>> in __restore_processor_state()'s path. But, could "restore" run into =
a
>> similar issue in the future?
>=20
> It sure looks like it. Good catch! I have the feeling there's never =
been
> an exception in that code anyway. The:
>=20
> wrmsrq(MSR_GS_BASE, ctxt->kernelmode_gs_base);
>=20
> is misplaced too. Exception handling leans heavily on MSR_GS_BASE.
>=20
> But, it doesn't hurt to be consistent about the ordering.
>=20
> In a perfect world, we'd probably unify all this code. Maybe the boot
> code establishes a 'saved_context' and all the APs just
> restore_processor_state() to go online normally instead of just for a
> restore. Or maybe the restore_processor_state() should be unified more
> with start_secondary() because a big chunk of the stuff its restoring =
is
> pretty static already.
>=20
> But there's no need today to do anything that drastic.
>=20



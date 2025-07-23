Return-Path: <stable+bounces-164497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 598D5B0F8FA
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 19:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9CF1CC05A1
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA47020F079;
	Wed, 23 Jul 2025 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="da6vlKeS"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B151EE03B;
	Wed, 23 Jul 2025 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291439; cv=none; b=VXhrE6e07gEn4dGaXd3ybompVVui0VP7dsxB68RoF4pbVfSPy9vExWa0Z1XoiOgFgt178Xqia4OoswsNsovgH0o0o5p20pTbrbglTSXTH5r3XiTL0kdhFD/wzfla3GF0DTX5Njs0lEc42LD/7BrPqxhandudsm9v1aydZYvqnuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291439; c=relaxed/simple;
	bh=187QpqXPJhgnpRnz4L6D2cn06v6JJjnK/VqE6Aks5Wc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YQrv8LzsAA4sOGaIp6awa4x7fTsOu8+aXNECMkx8IIWbh1p84UpqqVABx1hZebB+VAc1LtbNGvKIIBcBo5J7na06mmzBVX3wODsM3vFrEQ1pgxhL0Aqsu0fcrJKlAhtWSh5t2fkwJDRD8Da87vDa8leWwz28rf7BIxKntEfzWVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=da6vlKeS; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56NHNG921269567
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 23 Jul 2025 10:23:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56NHNG921269567
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1753291398;
	bh=8H5krzXXgF2Mo57XsjerN6D+2Fg11fD1p3mrEBWff4Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=da6vlKeS8Ci1dnKdGhOVNzamIRq4E5xGCged8PdRzf1BxTE5q/k2ohNjRfCgRQVOZ
	 7yj5GrTlD7o0YLo8rsEOrUYz4394bJF5LdtwIW0Y31Nve/oR6GJvbfd7gL04NlJujk
	 LparYRolyLIplS88ll3EsTiLoUUARzjkbhCCKmP9az7DtbwECPOBWBwVes+z05gd/C
	 m8kUMch2VBD2SQ/4y1On9WDJDVVX7To+x7pyBb38WL0LQ7WOQ4omWO94aY6jPtewyZ
	 bnEc3if3Qtdjw3GV6kgMec7MiqPLk1Ub2ovULddAADoTqaZYcyogljyJ3cnpU+ua3C
	 PsieYTxYzEkMw==
Date: Wed, 23 Jul 2025 10:23:15 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Kirill A. Shutemov" <kas@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Xin Li <xin3.li@intel.com>,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, stable@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Clear feature bits disabled at compile-time
User-Agent: K-9 Mail for Android
In-Reply-To: <jee4jnrwcpwukdibgwxts75wyevdj3kuog6qbutnd5jxtnhwqm@4yglpeq3bz3x>
References: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com> <20250723134640.GAaIDnwGx6cAF9FFGz@renoirsky.local> <xfshxftto4al2syvtrmbqbswlussduvncodyowjwfcvi23v45e@sy4e4hckbf7a> <DE4839E9-8874-44A9-B675-AE5FB26C9260@zytor.com> <jee4jnrwcpwukdibgwxts75wyevdj3kuog6qbutnd5jxtnhwqm@4yglpeq3bz3x>
Message-ID: <6730DE37-744C-44BE-BB51-CF41D87EBBE9@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 23, 2025 10:13:52 AM PDT, Maciej Wieczor-Retman <maciej=2Ewieczor-r=
etman@intel=2Ecom> wrote:
>On 2025-07-23 at 08:28:32 -0700, H=2E Peter Anvin wrote:
>>On July 23, 2025 8:13:07 AM PDT, Maciej Wieczor-Retman <maciej=2Ewieczor=
-retman@intel=2Ecom> wrote:
>>>On 2025-07-23 at 15:46:40 +0200, Borislav Petkov wrote:
>>>>On Wed, Jul 23, 2025 at 11:22:49AM +0200, Maciej Wieczor-Retman wrote:
>>>>> +static __init void init_cpu_cap(struct cpuinfo_x86 *c)
>>>>> +{
>>>>> +	int i;
>>>>> +
>>>>> +	for (i =3D 0; i < NCAPINTS; i++) {
>>>>> +		cpu_caps_set[i] =3D REQUIRED_MASK(i);
>>>>> +		cpu_caps_cleared[i] =3D DISABLED_MASK(i);
>>>>> +	}
>>>>> +}
>>>>
>>>>There's already apply_forced_caps()=2E Not another cap massaging funct=
ion
>>>>please=2E Add that stuff there=2E
>>>
>>>I'll try that, but can't it overwrite some things? apply_forced_caps() =
is called
>>>three times and cpu_caps_set/cleared are modified in between from what =
I can
>>>see=2E init_cpu_cap() was supposed to only initialize these arrays=2E
>>>
>>What are you concerned it would overwrite? I'm confused=2E
>
>I thought that cpu_caps_set/cleared could change in-between apply_forced_=
caps()
>calls=2E Therefore if we also applied the DISABLED_MASK() in every
>apply_forced_caps() call I thought it might clear some flag that other fu=
nction
>might set=2E
>
>But I've been looking at these calls for a while now and that doesn't see=
m
>possible=2E Changes are made only if features are compiled, so it doesn't
>interfere with the DISABLED_MASK()=2E
>
>Sorry for the confusion=2E
>

Any changes would be additive, or we would be in a world of hurt anyway=2E


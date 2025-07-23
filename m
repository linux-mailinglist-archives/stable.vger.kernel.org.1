Return-Path: <stable+bounces-164476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF69B0F705
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 17:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AF0AA5F03
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D52F531A;
	Wed, 23 Jul 2025 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kHhPm/h+"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711422F5310;
	Wed, 23 Jul 2025 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284558; cv=none; b=R7Q9lqfDOddC4wYo7Kq6qSxVRZ0nxSe9d2vCvL97h530xPjKIw8CqaAvZFG9iGXwVR9YzSKZkEsUceGbcWRpsa3pzDxq3Jm1J2ghJtWtb7lnOFvc3NgRuND3l+teyZqPYKOWhTzv5e9VwoF3a97bfY6RuXVKFktW+BtAbd/XD9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284558; c=relaxed/simple;
	bh=H1vNV4RrAa2pXIfBp2CvE7oWdXOiG5DfKUXGzdN9WhY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AVcQXKAa4V/nXjHFU1+68Vtu3POc6bUN33l/++VAXJNu6tNHZr6DwsCwEKavmscKoVl0QZ49LfBheTSyl8URn1guJGDZVMWCZFBdudT4hgDQ8o7yk3wylhcJcKYlpR8fg3j3Jfb2KFZgQ4I3HXQMl6a4jNvMxlcqEGDkrN5pSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=kHhPm/h+; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56NFSXPc1215883
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 23 Jul 2025 08:28:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56NFSXPc1215883
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1753284514;
	bh=aWrYZGGJXuyx2JThFJy/NOJLfgzE/vnu3QJbJ6LF2FA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=kHhPm/h+wRBivPxb4P4qogCDu15yW4obZK37FZjoR7quovwsfc8xq4LBOxJAgFA/Z
	 PyVYCoF44N0TAByy5iNiMKY1vmzAF/v26Xcsl9Zbda2bcnMyOMhms1vaBt/l9dGTWM
	 y3BOzIaxGIf9cXQxXS/1wgRsKuUSg4pLkd9n+hRQUdNgD16cIp+t4yBlCqqC9/jBft
	 Qm8GIeat9H6OofBACaROuZ3Dl954AoYVcJkKTIdNCVPz5UUO4j5vSwlGtuDri/OdEt
	 uwIg1Or4GffIRcKSaW2fMACEysyDhhbxsK6lDdcdqSzIqfySPeeLII0pL2d2PUz7We
	 QYYRt1TJfjDzw==
Date: Wed, 23 Jul 2025 08:28:32 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
In-Reply-To: <xfshxftto4al2syvtrmbqbswlussduvncodyowjwfcvi23v45e@sy4e4hckbf7a>
References: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com> <20250723134640.GAaIDnwGx6cAF9FFGz@renoirsky.local> <xfshxftto4al2syvtrmbqbswlussduvncodyowjwfcvi23v45e@sy4e4hckbf7a>
Message-ID: <DE4839E9-8874-44A9-B675-AE5FB26C9260@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 23, 2025 8:13:07 AM PDT, Maciej Wieczor-Retman <maciej=2Ewieczor-re=
tman@intel=2Ecom> wrote:
>On 2025-07-23 at 15:46:40 +0200, Borislav Petkov wrote:
>>On Wed, Jul 23, 2025 at 11:22:49AM +0200, Maciej Wieczor-Retman wrote:
>>> +static __init void init_cpu_cap(struct cpuinfo_x86 *c)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i =3D 0; i < NCAPINTS; i++) {
>>> +		cpu_caps_set[i] =3D REQUIRED_MASK(i);
>>> +		cpu_caps_cleared[i] =3D DISABLED_MASK(i);
>>> +	}
>>> +}
>>
>>There's already apply_forced_caps()=2E Not another cap massaging functio=
n
>>please=2E Add that stuff there=2E
>
>I'll try that, but can't it overwrite some things? apply_forced_caps() is=
 called
>three times and cpu_caps_set/cleared are modified in between from what I =
can
>see=2E init_cpu_cap() was supposed to only initialize these arrays=2E
>
>>
>>As to what the Fixes: tag should be - it should not have any Fixes: tag
>>because AFAICT, this has always been this way=2E So this fix should be
>>backported everywhere=2E
>
>I found that in 5=2E9-rc1 the documentation for how /proc/cpuinfo should =
work was
>merged [1]=2E I understand that from that point on, while one can't rely =
on a
>feature's absence, it's a reliable convention that if a flag is present, =
then
>the feature is working=2E So from 5=2E9 on, it seems like a bug when thes=
e features
>show up as working while they're not due to not being compiled=2E
>
>[1] ea4e3bef4c94 ("Documentation/x86: Add documentation for /proc/cpuinfo=
 feature flags")
>
>>
>>Thx=2E
>>
>>--=20
>>Regards/Gruss,
>>    Boris=2E
>>
>>https://people=2Ekernel=2Eorg/tglx/notes-about-netiquette
>

What are you concerned it would overwrite? I'm confused=2E


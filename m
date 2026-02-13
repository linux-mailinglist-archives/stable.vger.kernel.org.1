Return-Path: <stable+bounces-216301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPUzIOaFj2mRRQEAu9opvQ
	(envelope-from <stable+bounces-216301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 21:13:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5D313958E
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 21:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 031E13037E65
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 20:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5292826FD93;
	Fri, 13 Feb 2026 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UIenRa5+"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D151B81D3;
	Fri, 13 Feb 2026 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771013601; cv=none; b=td2ufr4sWhfpkdyRIQjkwLqsjWC/lhh72wuIGm8UbeZD8TiT0NzMDUVBsG1o8yyupezDB7T0IHjIlNIODgtrr4MI6ARLHoqCvepqJEi5JLOi0FSaZnWpz746Fus//1O1Eq1cxn4lF4Wci7Cm027B8bI0WtQpX+GoGm4yVEqy7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771013601; c=relaxed/simple;
	bh=+gUk4hK7+k7pYFbyAM6dw8oTyzRmsqoUuCwB4AOQlOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/p8HlgFS1mkqzXvXro4zRCzxsJwUVVCOOyBE8PpxM9AQz4ldJWZwZD4F372N2cSya84a9lMEwtjmUftZ4i+0P6mb5iezDh4ZRlDRQmVQb+ceJFdppeaap/h/W2Zn0tgosnp9c4pKprqGa9hfGTnkjMyxH3gUEx1x2oyzOOi0Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=UIenRa5+; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2607:fb90:3709:ce04:bf4c:86df:148a:f3f5] ([IPv6:2607:fb90:3709:ce04:bf4c:86df:148a:f3f5])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61DKBp7G948099
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 13 Feb 2026 12:11:59 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61DKBp7G948099
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771013560;
	bh=qDr8hxaps84UY5Vhn7GxyKkxMFuR1fhYlnu0pWKAx/8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UIenRa5+SCODvF3HfzM/+/w1oYcPTJj0zmEZKetHm8AKDjAj766pfpV6b21fv9djc
	 F4mDW1kCXZALUIDbDAkXCV0W9/cGsMTej9gJnhz2OiicACwASB0CzdWu5EzwADZRcg
	 Pq/1U3gANHfOjYPR12LTBxw59FeajY2Hr6mkuHsDiH1fke97v44z6t3rDTGzyc4xkP
	 LFViuiEFrNKpZXmqpAeRqNj7RTvZEl96/+oCvr3ox+KgHRvNTKDQ2l1m9NuEpsapra
	 rTzvHo9F/VGTB6AZ2mOwuErHUyX4KmmUwQM9t6cAgyyjQFezebSfEz4L8fDz/cYHZB
	 S6CYk7pnREspg==
Message-ID: <5c155da1-35a7-4b36-8c21-e21f8743c3d4@zytor.com>
Date: Fri, 13 Feb 2026 12:11:51 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] x86/cpu: Clear feature bits disabled at
 compile-time
To: Borislav Petkov <bp@alien8.de>, Sohil Mehta <sohil.mehta@intel.com>
Cc: Maciej Wieczor-Retman <m.wieczorretman@pm.me>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, pawel.chmielewski@linux.intel.com,
        Farrah Chen <farrah.chen@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1770908783.git.m.wieczorretman@pm.me>
 <32fbbfc16974cfed11e7d2651bce836ba9ceaccc.1770908783.git.m.wieczorretman@pm.me>
 <20260212155808.GDaY34kOTrEYHLdoyK@fat_crate.local>
 <aY35H-VXwoSLFXoj@wieczorr-mobl1.localdomain>
 <E9F385CE-83B8-4088-B6FC-AB113F8DF55C@zytor.com>
 <A9F52EC5-EC74-43BB-BB3F-351F684BF5CE@alien8.de>
 <19d3f1c8-01aa-4a50-81e0-6af3fb7fe9cd@intel.com>
 <20260212234722.GFaY5mimfap5YbOi30@fat_crate.local>
 <57039edb-419c-4e4a-96d0-3578e233b594@intel.com>
 <20260213005813.GGaY53JfOLNoSJNgRe@fat_crate.local>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260213005813.GGaY53JfOLNoSJNgRe@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216301-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[zytor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zytor.com:mid,zytor.com:dkim]
X-Rspamd-Queue-Id: DC5D313958E
X-Rspamd-Action: no action

On 2026-02-12 16:58, Borislav Petkov wrote:
> On Thu, Feb 12, 2026 at 04:14:07PM -0800, Sohil Mehta wrote:
>> So, as of today, if one of these features shows up, a user can't be sure
>> whether the kernel has enabled it or not. Right?
> 
> This is not such a critical bug - judging by how no one noticed it until
> now...
> 
>> My suggestion is that:
>> Instead of (or maybe along with) fixing this buggy interface, would it
>> be better to put this information in something like debugfs/sysfs? So,
>> at least new user software can start using that.
> 
> ... to go and make big waves and "fix" everything. We'll address this
> inconsistency eventually and go on with our lives.
> 

Agreed. And more importantly, like it or not, /proc/cpuinfo is what people are
using, if they aren't going straight out and looking at CPUID and XCR0 in user
space directly.

A new more structured interface might be nice -- for one thing, /proc/cpuinfo
is huge on newer machines; it was originally designed for the UP world -- but
we can't get rid of /proc/cpuinfo for many, many years so let's actually fix it.

	-hpa



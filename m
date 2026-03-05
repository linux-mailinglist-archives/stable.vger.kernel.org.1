Return-Path: <stable+bounces-223279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKW2GFb+qWk1JQEAu9opvQ
	(envelope-from <stable+bounces-223279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 23:06:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDE4218C53
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 23:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 441AC305B09E
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 22:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51CA35E55D;
	Thu,  5 Mar 2026 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dIa1xx63"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0411030EF92
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772748371; cv=none; b=GrVjXoPYqkhWK4A+Nvc1KvYC6nnTwQp043fU6IRVZ6aK9A5GgsECtlcpPwEkV9p/KZuk9u5ulGw8VlyXHk8FqzeeVN7ixFJRj7AsbCRm00wPgEWb0PDeAWJghFVxjcqvbMWuf6FxTcIQvgddOdgS0sZdUkcyPwFCQqnC1bSrOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772748371; c=relaxed/simple;
	bh=dvzcZGIfty4q4/ZRB3y+hS1qq4sdIATmxzQ3MxaVutE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLqI79+J4gFZupxljQRI3t4OW4QBfuHjva9EV9rngTWxX784hARbkM3vYBa49OpX4kZbtdMSQpqlAPV7peL1SttU4eYM6LBrkmo5nqv3Pf+SJVPgOq6hoZrc1YVSmyeyZuaj2eQAuCWrEodlGaBriMBrMX8x+OqkWh2yiP0+e/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dIa1xx63; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483abed83b6so71722465e9.0
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 14:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772748368; x=1773353168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBbdZfbSAyChtUJZbvsnHxDKBFDo1gjXMVQl5K2iv0E=;
        b=dIa1xx63v/DVMnl0EvGOzpgBPYeb0L4OLaEO/d7okb9zq0Rggk1unj/tf70udOtCdS
         xEXpe17+JWMqGmK17O9xBB5DtPPqHZquhPQu+ZgIG6vf2KSZTbe6lV5nxwJWazCrR2ip
         kAa82i62Ii+x9HmnVVxCxkOzaciutQNsR077zJP+qfMmvkMhMd8L+EOEgB19upIsPw1B
         mkuZD+9lLDAm/xHE/+jHaQGdF5L6QN2G3Jv9frq/9VmiCWHWbm2j8S/J6M1S5Qj1n2zk
         GWOP5Y3KqRIPFCG4Djc/S9GQTCPr8SNvMNkVEXL9b+o/5AeLbOPBBAhz6X3KoRZMlwFW
         xCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772748368; x=1773353168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBbdZfbSAyChtUJZbvsnHxDKBFDo1gjXMVQl5K2iv0E=;
        b=Xt2Oe5uvu3NhgBBMTcj9lBGjEL/z55mWiq3QbdpJP12fZretCNo9iwihPqPwHvJwro
         9U9fvs+59XFZIMqAuWS6qwPy9i2gOiwwuorlxEkRIoK1vUEtm53BN7NLdrgmByu/BpuK
         XXqwu/za9HJmZLNOerO+qsGyboQZr10QtfZbLst4cAOcTIzoXqeP4Em0vI+v/DwHYtzW
         pZgLn4WRXBra+EVnfH8wUp0u/rx0vy3kGdjXckXSRRzY/fYxHXywMr2IX1wvt8zVTcBS
         JUgjkeP0HdE3Wkjx/164fc4pKFffvqSsP2BHZbRrN+JKs9EET/Zo/p0ulVlEqXrJR1Ox
         CzeA==
X-Forwarded-Encrypted: i=1; AJvYcCW8O6llZXuC1BkVbnkRH1ue1Y0ZXge8N2aIpw9XkGW3HtiLktrMSKWjX6kUAP2xTO+x1Pg3iSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6jhtW6LJP5XHQp34dOlk7iI4lvG97OYV6LJru4NlFhQimpy3T
	SG2Hmiw2qv7PSpih10Wede3m2dZj0OhyhLX0YKyMZIBdnedP5VWTslc=
X-Gm-Gg: ATEYQzwNOzU0/jEngj00d/tgUyvo0uDEkH3waT/4G5dRgLD7NRDi5bEoD8MKTlMU6be
	f4bPjLHnMI6voV41+DW7LoJv6cuoeh4MazqaDpZ8rnHlh+iIn/koAdiykhZflmuh0U0qb/rZoFW
	kcp2nYhujH16vQEcjiYTfx7ckE8YR40FRKS4/bgUpDcMu+zX+6FjSVCKjb0l1ItMtAKPueeD/BQ
	ug/X6/hmWzA5jhZudB/aXEoP2aM/L83f0yVN/hvobbaUb5L48Ekzk8DgyYlUtVuPa1lrZg4A3nk
	5HruYaTHWRuA6rXrWvDClVExlRt5qNB8+MJY1tsmjVaLxtJAI7IO+s+Vfrk5Ss7ueqWwejDIoaq
	grtgp34r6/QH0GKsrSONiZBUCKlL81iUIyeVitkDtpokADVdl6tiH1Z5Yp+9OmbJSGLyp7TTvUO
	9dAE1egKGAtNyPdKx3QJI56orOLzeQNczKG4tnoi2GiCMP8s2sodCEHdJYeMe3H33DXNrOXxUNw
	w==
X-Received: by 2002:a05:600c:1d0c:b0:482:df17:bbbc with SMTP id 5b1f17b1804b1-48519874e2amr119001495e9.20.1772748367987;
        Thu, 05 Mar 2026 14:06:07 -0800 (PST)
Received: from [192.168.1.3] (p5b05772c.dip0.t-ipconnect.de. [91.5.119.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fafe4c9sm83973825e9.15.2026.03.05.14.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 14:06:07 -0800 (PST)
Message-ID: <6f42cb43-c281-4565-b968-afc34502b9fb@googlemail.com>
Date: Thu, 5 Mar 2026 23:06:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [REGRESSION] Linux kernel 6.12.75 fails to compile with
 -Werror=implicit-function-declaration
To: Sasha Levin <sashal@kernel.org>, Brett A C Sheffield <bacs@librecast.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Aditya Garg <gargaditya08@live.com>,
 "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 "ardb@kernel.org" <ardb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "graf@amazon.com" <graf@amazon.com>,
 "guoweikang.kernel@gmail.com" <guoweikang.kernel@gmail.com>,
 "henry.willard@oracle.com" <henry.willard@oracle.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "jbohac@suse.cz" <jbohac@suse.cz>,
 "joel.granados@kernel.org" <joel.granados@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "noodles@fb.com" <noodles@fb.com>,
 "paul.x.webb@oracle.com" <paul.x.webb@oracle.com>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
 "sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org"
 <x86@kernel.org>, "yifei.l.liu@oracle.com" <yifei.l.liu@oracle.com>
References: <DD397543-DDDE-4215-A116-318AEAFFC359@live.com>
 <0be301c0-f9be-4d70-9fdb-7a260ccf83ac@googlemail.com>
 <aam_-Y7q-c3gmfGY@auntie> <aanlzq-RqDF9xkdI@laps>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <aanlzq-RqDF9xkdI@laps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AEDE4218C53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-223279-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,live.com,linux.ibm.com,linux-foundation.org,oracle.com,kernel.org,alien8.de,linux.intel.com,amazon.com,gmail.com,zytor.com,suse.cz,vger.kernel.org,redhat.com,fb.com,intel.com,linutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url]
X-Rspamd-Action: no action

Am 05.03.2026 um 21:21 schrieb Sasha Levin:
> On Thu, Mar 05, 2026 at 05:40:09PM +0000, Brett A C Sheffield wrote:
>> On 2026-03-04 20:00, Peter Schneider wrote:
>>> I already found and reported this in the RC cycle [1], and Sasha dropped it in -rc2 [2], and now in the release, it
>>> obviously has, somewhat mysteriously, reappeared [3], affecting all of today's 6.x stable branch releases.
>>
>> Greg, Sasha et al.
>>
>> Can we make a small adjustment to the stable kernel testing process please,
>> whereby we release a kernel that we have actually tested, instead of adding and
>> dropping patches at the last moment and releasing a kernel that no one has
>> tested?
>>
>> We are only a small pool of testers. If we find a bug, can we fix it, release a
>> new RC and test again please?  We can have an RC3. Even an RC4.  Perhaps if we
>> bogoselect fewer patches in the first place we might have less work to do. It's
>> better to miss a backport for a bug no one has reported than to pull stuff in
>> without proper review.
> 
> Could you suggest which fixes from v6.19..v6.19.6 could have been left outside
> the tree?
> 
>> The current stable process is introducing bugs. Bugs that never existed in
>> mainline.
> 
> Releasing yesterday's tree was (my) human error: I don't have as much
> automation and scripting as Greg does, so many of the steps I've taken were
> manual and prone to errors. I'm working on improving this workflow on my end.
> 
> This, however, wasn't an issue with our process, which is why I'm curious which
> bugs you're referring to?
> 
>> The 3 kernels released today were tested by no one before release.
> 
> Right - the 3 kernels released today simply dropped a commit that caused a
> built failure. We sometimes do that to address simple build or functionality
> breakages (this happened with v6.19.2 and v6.19.5 too).

I agree with that, and in this case I don't see a risk here. It's probably fine.

But I have a major headache regarding this one, because Brett is right here:

>> The seven kernels yesterday were similarly tested by no one before release.
>> We weren't given the opportunity.
> 
> Could you explain this point please? There were quite a few folks who provided
> their Tested-by...

The people who tacked their Tested-by on yesterday's 6.1.165, 6.6.128 and 6.12.75 RC2 did so after testing without the 
patch "x86/kexec: add a sanity check on previous kernel's ima kexec buffer", because after my initial report you dropped 
it, but in the final releases it was present again (essentially invalidating the Tested-By), causing the same build 
failure, but only on X86, and only with CONFIG_WERROR=Y.

Now in todays three releases which fix this, you wrote in the release announcements "Only upgrade if you've observed a 
build failure with 6.1.165." / 6.6.128 / 6.12.75.

But this wording is, IMHO, inaccurate and inadquate, because people who built yesterdays releases with CONFIG_WERROR=N 
will not have seen a build failure, and if they now, because of your release announcement, DO NOT upgrade to one of 
todays releases, they now have a kernel with an incomplete patchset, i.e. with only the patch ""x86/kexec: add a sanity 
check on previous kernel's ima kexec buffer" and not the three missing prerequisite patches from Harshit's patch series 
which he said he will properly backport later, and this could be built only by lucky coincedence, and THIS is the 
combination of code nobody actually tested which Brett talked about.

What does it do? Does is cause harm? I don't know. Do you know? Maybe Harshit could tell us if it's a serious omission 
or if it's not critical. This, IMHO, should have been avoided. The better wording in the release announcements of today 
would have been: "All users on X86 must upgrade", so that nobody stays, unaware, on a kernel with that incomplete patch set.

This gives me some vibes of "It compiles, so let's ship it", which is a questionable level of QA you might expect from 
some (shady) commercial companies, but I think the Linux community should (and can!) do better. But I feel the process 
was kinda broken this time, not because of your fault, but because lack of consistency in tooling, as you said yourself. 
And also the unlucky timing of finding that bash/dash behaviour differnence in your tooling vs Greg's, that caused RC2 
in the first place.

Sorry if that sounds too harsh. I don't mean it in a harsh way, but only as constructive criticism. I know Greg and you 
have an extremely complex job with maintaining the stable branches, and normally all works very well and smooth, because 
both of you are doing a hell of an excellent job! But on occasion when a release was bumpy like this one, we should look 
back and ask why, and what could have done better, and how we can improve in the future.


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com


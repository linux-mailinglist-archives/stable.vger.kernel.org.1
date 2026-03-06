Return-Path: <stable+bounces-223300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLMsOhtBqmlQOAEAu9opvQ
	(envelope-from <stable+bounces-223300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 03:51:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DB421AC08
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 03:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0484B30268A3
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 02:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210F0367F3D;
	Fri,  6 Mar 2026 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0U8xGtU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F9F367F2B;
	Fri,  6 Mar 2026 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765462; cv=none; b=kqvqFCcMbQgsiDOi6n+KloWaF1zTt/HLsCFifSkpjWOz0+/Ok9rc7yiWP3a9uaZnECheUZYnIlX4413RsG5ME+n0ckvjww36P/PUeAXaulmMpOoUWkRwlAce9NJLvpYXYzmxumlpAOKSad+0mOVGBvjgytbopCBFa/pY2jJKx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765462; c=relaxed/simple;
	bh=SIwRlI/UnWUG8micCiLQ038ygvT8/SBxi3yO+kXx8iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qq89GTWuMLC4KJ/4SRu80WaOKhvvRLPDPLUOxmVNKgg14JF7c6gmgqLVVJexWq501tY1RD03axbYwo2KPbT0DWA4Peh4ByiiltFarr9wRaj3Bj1lYnJfgb3MHx56Qip18FCxUdtbsDA1avI7i/EvHcTNr7Wb3DwN0GNNtrhxyfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0U8xGtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40FBC2BC87;
	Fri,  6 Mar 2026 02:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772765462;
	bh=SIwRlI/UnWUG8micCiLQ038ygvT8/SBxi3yO+kXx8iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0U8xGtUhxcaSwmlcvtBrSQZiFO6V5Hi1xPWeTNhLEUCTAhgfbDYrDcCXHk+g7cHh
	 rBH1cN4ffl3t1xf3PYv0g/y7KT+zxEn2yTwitWaDRqQ+ObC0tswgLCnVIc2sEMUPjw
	 A05fH3NQYN8BwlEsuyedEBNAJpD8s+hVruXsGhZpcDbUJcZZ3RfLww04oPzlYp9ELq
	 /bRcndPpQxL0bh9pEgdjQaLrfWcj18kLo/9ZT9qNXmxhgTtT0glZrs0JkbXZMtGs0Q
	 cq2yc/Ogp+EMK7qU8HXack/nQfvSrXe5nK9ckGIuTFKQKvfsmEJmPwzS36EiWEIQhx
	 TA3UnQs1U6fVg==
Date: Thu, 5 Mar 2026 21:51:00 -0500
From: Sasha Levin <sashal@kernel.org>
To: Brett A C Sheffield <bacs@librecast.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Schneider <pschneider1968@googlemail.com>,
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
	"mingo@redhat.com" <mingo@redhat.com>,
	"noodles@fb.com" <noodles@fb.com>,
	"paul.x.webb@oracle.com" <paul.x.webb@oracle.com>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"sohil.mehta@intel.com" <sohil.mehta@intel.com>,
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>,
	"yifei.l.liu@oracle.com" <yifei.l.liu@oracle.com>
Subject: Re: [REGRESSION] Linux kernel 6.12.75 fails to compile with
 -Werror=implicit-function-declaration
Message-ID: <aapBFGi7RP5NYsIs@laps>
References: <DD397543-DDDE-4215-A116-318AEAFFC359@live.com>
 <0be301c0-f9be-4d70-9fdb-7a260ccf83ac@googlemail.com>
 <aam_-Y7q-c3gmfGY@auntie>
 <aanlzq-RqDF9xkdI@laps>
 <aan8XRoC4-ndXD67@karahi.librecast.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aan8XRoC4-ndXD67@karahi.librecast.net>
X-Rspamd-Queue-Id: 64DB421AC08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223300-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,googlemail.com,live.com,linux.ibm.com,linux-foundation.org,oracle.com,kernel.org,alien8.de,linux.intel.com,amazon.com,gmail.com,zytor.com,suse.cz,vger.kernel.org,redhat.com,fb.com,intel.com,linutronix.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:57:49PM +0100, Brett A C Sheffield wrote:
>On 2026-03-05 15:21, Sasha Levin wrote:
>> On Thu, Mar 05, 2026 at 05:40:09PM +0000, Brett A C Sheffield wrote:
>
>> >The current stable process is introducing bugs. Bugs that never existed in
>> >mainline.
>>
>> Releasing yesterday's tree was (my) human error: I don't have as much
>> automation and scripting as Greg does, so many of the steps I've taken were
>> manual and prone to errors. I'm working on improving this workflow on my end.
>
>This raises two questions:
>
>1) why do you not have the same tools? This whole process is highly automated,
>both at your end, and ours. Little changes break scripts and cause much hassle
>that could be avoided.  I had to debug my scripts before I could even get
>started (my fault, my bug) because of a difference in how you sent the emails.
>Others had similar problems by the sound of it.  Please, Greg, make these tools
>and the process public and make sure whoever is cutting the release knows how to
>use them.

Greg's scripts are public :)

We have very different development environments. We use different tools, our
workflows are different, and we (normally) handle different parts of the
process. Sure, at times it creates issues (like here, when I'm trying to tackle
some of Greg's work), but sometimes it also helps us catch issues that one of
us would have missed. The latter part usually happens behind the scenes when no
one notices.

I suppose that if I were to do releases more often we'd likely end up with the
same (or similar) set of scripts around this. We're not there.

>2) why is so much scripting involved in cutting the final release? This should be
>the exact kernel we just tested with our Tested-by lines and your signoff tacked
>on.  Last minute changes break things.

The stable kernel is managed by a quilt set of branches in the background.
Every release of the stable tree (for forever?) has been generated that day
from the quilt queue and released. There is no notion of "exact kernel" because
the tree, until it's released, is ephermal.

What happened in this case, is that I dropped the offending commit from the
quilt queue and regenerated the trees, and pushed out -rc2. I'm still trying to
learn why the change to the quilt queue wasn't pushed out, but when the trees
were later regenrated from the queue, it still had the offending commit.

There was no irresponsible last second change as you're trying to suggest.

>> This, however, wasn't an issue with our process, which is why I'm curious which
>> bugs you're referring to?
>>
>> >The 3 kernels released today were tested by no one before release.
>>
>> Right - the 3 kernels released today simply dropped a commit that caused a
>> built failure. We sometimes do that to address simple build or functionality
>> breakages (this happened with v6.19.2 and v6.19.5 too).
>>
>> I don't disagree that there's a risk in doing so, but the risk is fairly minor,
>> and doing a quick release allows users to get important fixes without waiting
>> another cycle.
>>
>> We could discuss a policy change here, but could you show that doing these
>> quick releases introduced regressions?
>>
>> If not, why are we changing something that works?
>
>It isn't working, as we've just demonstrated.

So this is narrowly about the 3 releases from earlier today, where there were
concerns that these small releases without -rcs prior are causing regressions.
I'm trying to understand which regressions were caused by this type of
releases.

>It's not your fault, Sasha. It's a failure (lack) of process. You were trying to
>release seven kernels, for the first time, without using the same tools as
>usual.
>
>The problem was that you (following the broken process), released kernels,
>after modifying them, without getting anyone to retest.
>
>In the rest of the software world testing happens after changes and before
>release, not in the middle.
>
>That's (mainly) what I want to change. No more last minute dropped and added
>patches.
>
>Tagging RCs would help at our end too, rather than relying on extracting
>metadata from email headers, and trying to figure out which force-pushed commit
>matches RCn at any given point in time.
>
>> >The seven kernels yesterday were similarly tested by no one before release.
>> >We weren't given the opportunity.
>>
>> Could you explain this point please? There were quite a few folks who provided
>> their Tested-by...
>
>Yes, I was one of them, although you omitted mine from the hastily pushed 6.6
>and 6.12 kernels ;-)
>
>Taking 6.6 as an example because I have the numbers on the whiteboard beside me:
>
>RC1 had 375 patches.
>RC2 had 956.
>These are not the same kernel.

It's not :)

This one was a fun git bug to figure out.

-rc2, however, had the same amount of time to be tested, and the test priod for
-rc2 was Monday-Wednesday rather than the weeked for -rc1.

-rc1 was in no place to be released as is, so what would have been my other
choice? I can't release a tree with two thirds of it's commits missing, so I go
ahead and do an -rc2 with more commits, and I allow time for testing.

>Then we had another RC2 force-pushed over the top of the original RC2 confusing
>the hell out of me after two long kernel bisects when I found my tree was out of
>sync and wasting a bunch more time as I retested because I thought I must have
>made a mistake.

This is on me. I decided to push -rc2 because the issue was pointed out so
quickly I felt I could sneak it in.

-- 
Thanks,
Sasha


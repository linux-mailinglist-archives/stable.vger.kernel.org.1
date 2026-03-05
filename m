Return-Path: <stable+bounces-223270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a39UANzlqWnuHQEAu9opvQ
	(envelope-from <stable+bounces-223270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 21:21:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5562181B0
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 21:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D2333053E38
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 20:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C7E333442;
	Thu,  5 Mar 2026 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4eB9QxL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1832D7FB;
	Thu,  5 Mar 2026 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742096; cv=none; b=YTyHpdupt6RfbkdAkchjkPp6rcF+JyZPb3HDkp50kceLvknKKOuRFbSrK30kkq97wJWW3c9+8SFjC8GuV3W3bwohFmNSCkKldNM6NoSx+aZutTQ1HoX5hxqzvXE1mrGqE8XRuLWOjlhYvKGZ1geUDaMix3JGV21S6Vcc0sch0wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742096; c=relaxed/simple;
	bh=YIf2ohmeBerc56trYIU4Kr56tQt8FgyfUPo4md5oFBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNFPlS3TsjF5dJFWRENJ5zddWapkBJ2xtHi1/VCrZYU79k7iprgyAq17jXzV08f+9r1YC87cSjJp6V1ePJTbhRuvETH800ojutweCZRe2QfehZoMdWCAYoYySxkXZy2zcareqEHq0uI6AVG5mDZmZUYuovMOIoegCMEI4ZFP/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4eB9QxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A52DC116C6;
	Thu,  5 Mar 2026 20:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742096;
	bh=YIf2ohmeBerc56trYIU4Kr56tQt8FgyfUPo4md5oFBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4eB9QxLd3oFeXzycpGrXLAPfsyspSBnCq0ZDkAWkk720bbYRN509Oj+I5bC5Fiat
	 xmm4Ml1bVW17rmfelig/eqkpdyweJ1SFWKNX/g1WvUZ/k7Vb6RBOGNgYL8mn0/JEAp
	 gxzL4PKPSH8yN0ca6zXMbI8pD5wmRI3L6bCrOxIJBkaSoi3Xx4x/kCHauG94dF5big
	 QRxsb+CPHvSnBAmmeRIGNfcnhnd1rQkB5zVfo+zeqsnryM6qsN9FwZqWIsKwBmks2g
	 x6ZkNQicuInlscoi+oo5Yz8I9l+D518uXWu6AeCyAq04mEY32p6iZDUjTnOKJIx00g
	 mRn1e/OBIl3HQ==
Date: Thu, 5 Mar 2026 15:21:34 -0500
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
Message-ID: <aanlzq-RqDF9xkdI@laps>
References: <DD397543-DDDE-4215-A116-318AEAFFC359@live.com>
 <0be301c0-f9be-4d70-9fdb-7a260ccf83ac@googlemail.com>
 <aam_-Y7q-c3gmfGY@auntie>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aam_-Y7q-c3gmfGY@auntie>
X-Rspamd-Queue-Id: 3B5562181B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223270-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 05:40:09PM +0000, Brett A C Sheffield wrote:
>On 2026-03-04 20:00, Peter Schneider wrote:
>> I already found and reported this in the RC cycle [1], and Sasha dropped it in -rc2 [2], and now in the release, it
>> obviously has, somewhat mysteriously, reappeared [3], affecting all of today's 6.x stable branch releases.
>
>Greg, Sasha et al.
>
>Can we make a small adjustment to the stable kernel testing process please,
>whereby we release a kernel that we have actually tested, instead of adding and
>dropping patches at the last moment and releasing a kernel that no one has
>tested?
>
>We are only a small pool of testers. If we find a bug, can we fix it, release a
>new RC and test again please?  We can have an RC3. Even an RC4.  Perhaps if we
>bogoselect fewer patches in the first place we might have less work to do. It's
>better to miss a backport for a bug no one has reported than to pull stuff in
>without proper review.

Could you suggest which fixes from v6.19..v6.19.6 could have been left outside
the tree?

>The current stable process is introducing bugs. Bugs that never existed in
>mainline.

Releasing yesterday's tree was (my) human error: I don't have as much
automation and scripting as Greg does, so many of the steps I've taken were
manual and prone to errors. I'm working on improving this workflow on my end.

This, however, wasn't an issue with our process, which is why I'm curious which
bugs you're referring to?

>The 3 kernels released today were tested by no one before release.

Right - the 3 kernels released today simply dropped a commit that caused a
built failure. We sometimes do that to address simple build or functionality
breakages (this happened with v6.19.2 and v6.19.5 too).

I don't disagree that there's a risk in doing so, but the risk is fairly minor,
and doing a quick release allows users to get important fixes without waiting
another cycle.

We could discuss a policy change here, but could you show that doing these
quick releases introduced regressions?

If not, why are we changing something that works?

>The seven kernels yesterday were similarly tested by no one before release.
>We weren't given the opportunity.

Could you explain this point please? There were quite a few folks who provided
their Tested-by...

-- 
Thanks,
Sasha


Return-Path: <stable+bounces-223277-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLwzJ5/8qWl+JAEAu9opvQ
	(envelope-from <stable+bounces-223277-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 22:58:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EBB218BA0
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 22:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 209E1301C8A2
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 21:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726363603DD;
	Thu,  5 Mar 2026 21:58:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9335F19A;
	Thu,  5 Mar 2026 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747928; cv=none; b=X1ifIc/pUzuwrlnalSRcOj/eu36/p483DUiyMb/k9P0xAIUVEl43NAFuCfZJhn3nrJeGTJrWE6ziqx4jGvjEpIO4TBEoZjyFX/AsQPwXqhnC4qpHQiH3eRzKRtTvYr7VQDJq+p6+pUmhI6mqnSx1a0bDJCm37877xSGpik3IsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747928; c=relaxed/simple;
	bh=vYLj1kMwpz9HdvtKejSrgLC+l7z0blo8rOb3d4HZb68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/2qPEe/1QJSEQqvkKLc0bXUEjCwT6ttNotg6FBhSBjuCCh7wznAzvd49MEH5aVm57vCoOwED0k/mHYmoB30aCREk23BP2Gj5D3TpXc4NnHGu3tTEjp4MwhfUdS0VsmxGy//wYSHvdXcTj+fidDFala+u1WoFfz79WxbWS5FdLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Thu, 5 Mar 2026 22:57:49 +0100
From: Brett A C Sheffield <bacs@librecast.net>
To: Sasha Levin <sashal@kernel.org>
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
Message-ID: <aan8XRoC4-ndXD67@karahi.librecast.net>
References: <DD397543-DDDE-4215-A116-318AEAFFC359@live.com>
 <0be301c0-f9be-4d70-9fdb-7a260ccf83ac@googlemail.com>
 <aam_-Y7q-c3gmfGY@auntie>
 <aanlzq-RqDF9xkdI@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aanlzq-RqDF9xkdI@laps>
X-Rspamd-Queue-Id: 21EBB218BA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,googlemail.com,live.com,linux.ibm.com,linux-foundation.org,oracle.com,kernel.org,alien8.de,linux.intel.com,amazon.com,gmail.com,zytor.com,suse.cz,vger.kernel.org,redhat.com,fb.com,intel.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-223277-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[librecast.net];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bacs@librecast.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.949];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 2026-03-05 15:21, Sasha Levin wrote:
> On Thu, Mar 05, 2026 at 05:40:09PM +0000, Brett A C Sheffield wrote:

> >The current stable process is introducing bugs. Bugs that never existed in
> >mainline.
> 
> Releasing yesterday's tree was (my) human error: I don't have as much
> automation and scripting as Greg does, so many of the steps I've taken were
> manual and prone to errors. I'm working on improving this workflow on my end.

This raises two questions:

1) why do you not have the same tools? This whole process is highly automated,
both at your end, and ours. Little changes break scripts and cause much hassle
that could be avoided.  I had to debug my scripts before I could even get
started (my fault, my bug) because of a difference in how you sent the emails.
Others had similar problems by the sound of it.  Please, Greg, make these tools
and the process public and make sure whoever is cutting the release knows how to
use them.

2) why is so much scripting involved in cutting the final release? This should be
the exact kernel we just tested with our Tested-by lines and your signoff tacked
on.  Last minute changes break things.

> This, however, wasn't an issue with our process, which is why I'm curious which
> bugs you're referring to?
> 
> >The 3 kernels released today were tested by no one before release.
> 
> Right - the 3 kernels released today simply dropped a commit that caused a
> built failure. We sometimes do that to address simple build or functionality
> breakages (this happened with v6.19.2 and v6.19.5 too).
> 
> I don't disagree that there's a risk in doing so, but the risk is fairly minor,
> and doing a quick release allows users to get important fixes without waiting
> another cycle.
> 
> We could discuss a policy change here, but could you show that doing these
> quick releases introduced regressions?
> 
> If not, why are we changing something that works?

It isn't working, as we've just demonstrated.

It's not your fault, Sasha. It's a failure (lack) of process. You were trying to
release seven kernels, for the first time, without using the same tools as
usual.

The problem was that you (following the broken process), released kernels,
after modifying them, without getting anyone to retest.

In the rest of the software world testing happens after changes and before
release, not in the middle.

That's (mainly) what I want to change. No more last minute dropped and added
patches.

Tagging RCs would help at our end too, rather than relying on extracting
metadata from email headers, and trying to figure out which force-pushed commit
matches RCn at any given point in time.

> >The seven kernels yesterday were similarly tested by no one before release.
> >We weren't given the opportunity.
> 
> Could you explain this point please? There were quite a few folks who provided
> their Tested-by...

Yes, I was one of them, although you omitted mine from the hastily pushed 6.6
and 6.12 kernels ;-)

Taking 6.6 as an example because I have the numbers on the whiteboard beside me:

RC1 had 375 patches.
RC2 had 956.
These are not the same kernel.

Then we had another RC2 force-pushed over the top of the original RC2 confusing
the hell out of me after two long kernel bisects when I found my tree was out of
sync and wasting a bunch more time as I retested because I thought I must have
made a mistake.

So for 6.6 and 6.12 I tested 3 kernels each, none of which were what was actually
released.

And that turned out to be broken. Which we could have told you, if we'd had an
RC to test.

The re-testing happened anyway, after release. I re-tested 6.6 and 6.12 and they
seemed fine. Peter retested and found it was broken. Better for that to have
been an RC3. Less work for you cutting extra releases, and less public
embarrassment for an already tarnished stable kernel process.

This whole release cycle was a complete mess, not because of one person, but
because of poor process and missing tools.


Brett


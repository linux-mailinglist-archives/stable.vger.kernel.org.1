Return-Path: <stable+bounces-222583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPI0MxyLpWk4DgYAu9opvQ
	(envelope-from <stable+bounces-222583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 14:05:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4914F1D9708
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 14:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6094D304E7D2
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 13:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCFE3D7D93;
	Mon,  2 Mar 2026 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JFte0NSx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E96B3D6CDB;
	Mon,  2 Mar 2026 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456431; cv=none; b=WoJ1b34ITeQXwws2qRvEW7r01LVFlso5lmfwsM8VBB088MaYxZMRxOm5/pBY6KHnuCAtMBsqLz/T6+I+EYBxn9CoNZiEjOe4FVALNG0jmZhWyK1nQqlMGndH1vn7YP3Df/Q75Zui/E+AAWXj0L9i7wfLqrEJrFxXlbTwfTRrb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456431; c=relaxed/simple;
	bh=imLdeS6iFveJw8eDaHwIPVvoBoJb7640xx7oOV1x+JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UThKhN/TIeHmKzQSCc6YtZmDprQLL1hn2EiLVhdmyfoBJxDsCXOEQwOk1GgZoClDWuhMkPd94dbYIDXDRf30kL171HeG4kx0LKNWf5h9mDXTScmhqwHcxYBVGuRaWoc0FL6YqHlitLU/52P5U5K1glN4JlvL1q7zo/EJixnLTnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JFte0NSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47B9C19423;
	Mon,  2 Mar 2026 13:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772456430;
	bh=imLdeS6iFveJw8eDaHwIPVvoBoJb7640xx7oOV1x+JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFte0NSxG5UsRGycpkONB4hN8HldmR6q3vDo7lqoK2hf9lG0AeW69gkMYcxNZdy4G
	 DR7TYoBoCD4dzokXEgTRbAa/X8nzTc0QfZq4MAuw4jotQGgBDnqgxRJ09DkR7l34t2
	 JFz3pDbP/gJcyGY+qB0N4tVH5TKYtee4/Zzzz/7Y=
Date: Mon, 2 Mar 2026 08:00:19 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Chris Friesen <chris.friesen@windriver.com>, stable@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: question about automatic backports to -stable branches
Message-ID: <2026030237-unbaked-muskiness-0298@gregkh>
References: <90479cf8-8087-4c8d-8d94-6bd3b885a77c@windriver.com>
 <2026022502-spoilage-drearily-cade@gregkh>
 <8160818d-0138-481d-ba84-e33d7b3845b9@leemhuis.info>
 <2026030107-jubilant-edge-f5c9@gregkh>
 <be46e053-7d47-43dc-9c93-5c5e1fff6633@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be46e053-7d47-43dc-9c93-5c5e1fff6633@leemhuis.info>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222583-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.253];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4914F1D9708
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 08:51:34AM +0100, Thorsten Leemhuis wrote:
> On 3/1/26 22:32, Greg KH wrote:
> > On Thu, Feb 26, 2026 at 09:32:45AM +0100, Thorsten Leemhuis wrote:
> >> On 2/25/26 17:20, Greg KH wrote:
> >>> On Wed, Feb 25, 2026 at 09:56:12AM -0600, Chris Friesen wrote:
> >>>>
> >>>> I'm trying to figure out what the expected process/timeline is for automatic
> >>>> backports to -stable.
> >>>>
> >>>> Commits 2fa119c0e5e5 and a5338e365c45 were merged to mainline on Feb 01,
> >>>> with the "Cc: stable@vger.kernel.org" in the commit message, but I don't see
> >>>> either of them backported to either 6.18 or 6.12 -stable branches.
> >>> For a commit that was made in Dec 16, why did it wait until 7.0-rc1 to
> >>> be merged?  We treat all of the cc: stable patches that show up in -rc1
> >>> as "obviously no rush" as that's why they are showing up in -rc1.
> >>
> >> For the Dec 16 commit, I can understand this. But that "all" in the last
> >> sentence hit a nerve here, as from the regression perspective,
> >> "obviously no rush" to me feels like the wrong categorization for CCed
> >> stable fixes between, say, -rc7 and the following -rc1, as quite a few
> >> of those afaics would benefit from being backported rather earlier than
> >> later:
> >>
> >> - Fixes that (maybe overly careful) maintainers at the end of a mainline
> >> cycle queued for the merge window instead of the current cycle; see the
> >> first example in this recent mail for one like that:
> >> https://lore.kernel.org/all/b4f8ca7a-02b1-4e72-896b-87a00db6338b@leemhuis.info/
> >>
> >> - CCed stable fixes for regressions that are found and quickly fixed in
> >> mainline right after a new mainline release came out without anybody
> >> telling the stable team to manually pick the fix up soon.
> >>
> >> So wouldn't it be better after a mainline -rc1 to work through the
> >> possible backports in an order like this:
> >>
> >> 1. Recent CCed stable fixes.
> >> 2. Older CCed stable fixes.
> >> 3. Commits with a fixes tag not CCed stable.
> > 
> > Yes, it would be "better", and to be honest, I haven't really thought
> > about it much.  When staring down 700+ patches to process, it's a bit
> > hard...
> > 
> > I have done simple scans of "is this fixing a crash" and merged them
> > first.  After that, it's just by order of when they were merged into
> > Linus's tree, as I see that feed from the git-commits mailing list.
> > 
> > Trying to figure out dates as to when things are merged is tough,
> 
> Wondering what you exactly mean with "tough". I assume something along
> the lines of "it takes time to look up the top-merge for each and every
> commit to detect the time it was mainlined (and I can't do that
> efficiently in my mailer)"?
> 
> > as
> > dates don't always match up, any suggestions on how to process that in a
> > way that is "fair"?  Just look at "commit date"?  Or "author date"?
> 
> Hmmm. I guess I would need to understand your workflow a bit better to
> provide a good answer.
> 
> You mentioned "git-commits mailing list" above, so I assume you are
> processing through the list of commits to backport from your mailer? But
>  the merge time is at hand there, as it is the time the mail was sent.
> So if your mailer can search for all mails with a stable tag, then you
> right after -rc1 could grab all of those from the past three or four
> weeks (merge window + last week/two latest weeks of the previous cycle),
> and you'd have those from category 1 above (recent CCed stable fixes).

My "workflow" is, after a few hops and git triggers, a mbox full of
patches that were tagged "cc: stable@" that have been applied to Linus's
tree.  They look like the following (to take a recent example):

-----

Subject: Patch Upstream: usb: host: tegra: Remove manual wake IRQ disposal

commit: ef548189fd3f44786fb813af0018cc8b3bbed2b9
From: Wayne Chang <waynec@nvidia.com>
Date: Thu, 15 Jan 2026 18:36:21 +0800
Subject: usb: host: tegra: Remove manual wake IRQ disposal

We found that calling irq_dispose_mapping() caused a kernel warning
when removing the driver. The IRQs are obtained using
platform_get_irq(), which returns a Linux virtual IRQ number directly
managed by the device core, not by the OF subsystem. Therefore, the
driver should not call irq_dispose_mapping() for these IRQs.

Fixes: 5df186e2ef11 ("usb: xhci: tegra: Support USB wakeup function for Tegra234")
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
Signed-off-by: Wei-Cheng Chen <weichengc@nvidia.com>
Link: https://patch.msgid.link/20260115103621.587366-1-weichengc@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-tegra.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

Rest of the patch here...

---------------

The date of the message is when it was merged into Linus's tree, and I
see the date of the commit in the body of the email (as shown above), so
I can order series hopefully by date when applying the commits, but I
don't have the "commit date to git" shown, and it's not really possible
to sort on the date in any easy way as it's all in the body of the
message.

Now MANY subsystems take a long time in getting patches to Linus, so if
I only sort by date, I will catch them first for those resolve issues
that were sent during -rc4 or so, or do I sort by date and take the
newest ones?  Which is "better" to do here?

And again, anything that makes this all have to be sorted manually is
going to be rough given the 700+ patches that are cc: stable and the
800+ patches that have Fixes tags only in them (because maintainers
still haven't read the documentation...)  So any hints on how to choose
"these before those" would be appreciated.

And I'm not wed to my mbox workflow, if you have any other suggestions,
I'm more than open to them.

thanks,

greg k-h


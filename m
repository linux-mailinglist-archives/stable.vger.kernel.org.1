Return-Path: <stable+bounces-219836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH9IJOWBoGn/kQQAu9opvQ
	(envelope-from <stable+bounces-219836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 18:24:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9421AC551
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 18:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF54B3663FAA
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245F542B74F;
	Thu, 26 Feb 2026 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6isej26"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB0F425CC6;
	Thu, 26 Feb 2026 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122999; cv=none; b=GHn33jD+n+GhBsXTJgM0ZeaoGoga+/Qi+NyKQvpuxnwOH/GSx3r5ALZSGXX2FznKiHARAWOzEFc+IjfQGU1YVN12h3JZz+0f0qfeD0w6jRbPur/DyVEjA2SZlEvAojsmCD/pG1L3ZZHVWoxz+s36JbZI8AfabKDdc7qihT7O5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122999; c=relaxed/simple;
	bh=7l/TUra6RLBpcJuFmYL9hEJKY3thFPIJmRDBDf3lq7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwNpFkMJitwHL2sBkndle2Dp6GKtoh3aJHVeT/uEQ6pbjZWT5oF7xMcBk0j5JxoyiYC6EBOjiUTPotAOhY4BND+KsDrDVgwYNcl1ddjFQSuqR6vtYUO3tsEe51Hw3KFcL4f7HAkaIFCgzpI1vMcF4azHSz18ucJf0Fy8+x2QyeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6isej26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5977C116C6;
	Thu, 26 Feb 2026 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772122999;
	bh=7l/TUra6RLBpcJuFmYL9hEJKY3thFPIJmRDBDf3lq7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6isej26IGz4ABsBn8TY2OVf18rlcMw3l1C4mQlOv57UrMgS8jPhhzr/5iZDboWZW
	 xmAXE5fMfCy0sw9zLY6YaobZKF+5RmsiftJaunA/u4Y+qWYbOrRnkvUM4eKiLisKcF
	 iF5lOoa0A+hWBcT+KfMT8yN804S93p/K8DPhf7ULOvdZdd/9rt16WBB6fX6+okITwm
	 kFYbhnHaZmmIJTUGY1DokTAkj2lBKIfzvHALZ7zAZYdQPZlIQgthr3YWbw/uZ0kTX8
	 UTFrqGMg+5asPfjoXS7KUNeITLvrrSD9fk1Me9i+3M/Ewn0Iwy88lu6QsUBEJ6zh/X
	 T/PCRAJVvi3Bg==
Date: Thu, 26 Feb 2026 16:23:15 +0000
From: Lee Jones <lee@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, David Rheinsberg <david@readahead.eu>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: uhid: Fix out-of-bounds write caused by raw
 events mismanagement
Message-ID: <20260226162315.GF8023@google.com>
References: <20260211164025.171242-1-lee@kernel.org>
 <aZmsTQeeGf26FqvY@plouf>
 <172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet>
 <47ro00po-r74n-870q-q178-67s8rpsss12q@xreary.bet>
 <aZ3IKiL91Ya7_iIM@plouf>
 <r6574n79-563r-9rrp-0n92-784532r67o63@xreary.bet>
 <20260226111816.GA8023@google.com>
 <aaA6fioiB9_aiBrA@plouf>
 <20260226140810.GD8023@google.com>
 <aaBqruhB0a7m0SBG@plouf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaBqruhB0a7m0SBG@plouf>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219836-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B9421AC551
X-Rspamd-Action: no action

On Thu, 26 Feb 2026, Benjamin Tissoires wrote:

> On Feb 26 2026, Lee Jones wrote:
> > On Thu, 26 Feb 2026, Benjamin Tissoires wrote:
> > 
> > > On Feb 26 2026, Lee Jones wrote:
> > > > On Tue, 24 Feb 2026, Jiri Kosina wrote:
> > > > 
> > > > > On Tue, 24 Feb 2026, Benjamin Tissoires wrote:
> > > > > 
> > > > > > Long story short: that patch is too intrusive as it makes assumption on
> > > > > > the behavior of the device. We need to understand where/if the bug was
> > > > > > spotted and fix the caller of hid_hw_raw_request, not the uhid
> > > > > > implementation.
> > > > > 
> > > > > Thanks a lot for the analysis, Benjamin!
> > > > > 
> > > > > I asked about that here:
> > > > > 
> > > > > 	https://lore.kernel.org/all/172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet/
> > > > > 
> > > > > So let's wait for Lee to clarify. Until that, the patch stays out of the 
> > > > > branch.
> > > > 
> > > > Thanks to both of you for looking into this.  I appreciate your efforts.
> > > > 
> > > > This is very much real world.
> > > > 
> > > > Is there a way to add an errata for the PS3 controller?
> > > > 
> > > 
> > > Unfortunatelly no. uhid merely emulates what a device can do, and HID is
> > > a convention. So if we were to have a special case to PS3 controllers,
> > > we would then start having to maintain an endless list of quirks when
> > > the issue is *not* in uhid, but in the processing of the device after
> > > (maybe in hid-core?).
> > 
> > Actually I think the issue is in UHID.  At least the way I read it.
> 
> And I disagree :)
> 
> > 
> > Are there legitimate use-cases for devices overwriting the Report ID
> > contained in the first index of the data buffer?  From my very limited
> > knowledge of the subsystem, this sounds like an oversight.
> > 
> 
> Legitimate, probably no, but we are talking about physical devices
> here. uhid is a mere replacement of a transport layer, and there is
> nothing that prevents a device to reply with a buffer starting with 1
> when requested about feature 2 (because it's firmware and they just
> don't care).
> 
> This happens a lot with proprietary features on devices, when there is
> no spec, so ODM provide their own driver and they can do whatever they
> want.
> 
> If uhid or any transport layer solely takes the decision that a reply to
> a request is wrong, we have no chance of fixing it after the fact. This
> is what happens with the PS3 controller: an undocumented feature is
> used, but that's what the Playstation does, so we need to tag along.
> 
> I hope it makes more sense now.
> 
> FTR, Lee shared the logs of the issue privately, and I already told him
> where we should fix the issue.

Thanks for all the help and the insight.

I will follow-up with the suggested fixes soon.

-- 
Lee Jones [李琼斯]


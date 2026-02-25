Return-Path: <stable+bounces-219667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HbfM7ohn2mPZAQAu9opvQ
	(envelope-from <stable+bounces-219667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:22:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D8C19A82B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED09A307F20D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E595D28469A;
	Wed, 25 Feb 2026 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2GOQZc/J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20537263C7F
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036450; cv=none; b=lZX0mUpb6LZj6XBpfnQh6djIL/ptRX+i/DQzOH5y4+xb1q8+1XmMLzMttpnPGQ5ov+iaae6Z/+fcUSneY8J55dyOwfLkSI5dbccKeL97Xcd5r3ahPk4j+z3TW+RHhNZTZkLo6dH/R6GhDYmC5u8ma92lHH/YLhegkaEPziAOjIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036450; c=relaxed/simple;
	bh=miq3UeLIBuZzjCOXCSHvEFXBAfUiJztQdTz+i9H3rZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYEg47XNQgJFfWtcDWHaV2/PbgHC+/kgN2s+O4xQqJQgzOn+rdaVg5FaTm7Lq+W3OnBPmwQRFWt5ojQ7MSRwSx8ywBIulnpUBuFU+obEHuK4q4mTOOxYsokSNZSWfwOV0+X0jasMuixJS23fjqhtJmG4xz3rEv+ELmIE1ILdo+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2GOQZc/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57818C116D0;
	Wed, 25 Feb 2026 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772036449;
	bh=miq3UeLIBuZzjCOXCSHvEFXBAfUiJztQdTz+i9H3rZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2GOQZc/J/NiwUTKOtK+Mh1WCqJD+gqcl4EvLaNTSNwBkw0d/gQydSWH6BBXoHrmQO
	 b7M4lLSVAf1sc0SB8c5iyRt6DjHIr9kY7aN+OYFsL8VKuN2MWt/0HXiyg4cRA70B0b
	 CPQ21hUOQuhXY6d695zvY87pgeCM1ydLkqEp3lgk=
Date: Wed, 25 Feb 2026 08:20:41 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Chris Friesen <chris.friesen@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: question about automatic backports to -stable branches
Message-ID: <2026022502-spoilage-drearily-cade@gregkh>
References: <90479cf8-8087-4c8d-8d94-6bd3b885a77c@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90479cf8-8087-4c8d-8d94-6bd3b885a77c@windriver.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-219667-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 56D8C19A82B
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 09:56:12AM -0600, Chris Friesen wrote:
> Hi,
> 
> I'm trying to figure out what the expected process/timeline is for automatic
> backports to -stable.
> 
> Commits 2fa119c0e5e5 and a5338e365c45 were merged to mainline on Feb 01,
> with the "Cc: stable@vger.kernel.org" in the commit message, but I don't see
> either of them backported to either 6.18 or 6.12 -stable branches.

For a commit that was made in Dec 16, why did it wait until 7.0-rc1 to
be merged?  We treat all of the cc: stable patches that show up in -rc1
as "obviously no rush" as that's why they are showing up in -rc1.

> Is the backport a manual action that needs human attention?  I had assumed
> it was mostly automated as long as the cherry-pick was clean.

It is automated, I'm just behind 700+ patches because of the huge number
that come in for the -rc1 window.  If you have something that actually
is hitting people, and fixes a problem, ALWAYS get it merged before -rc1
to go a bit faster.

I will get to these eventually, and catch up, give me a week or so.

thanks,

greg k-h


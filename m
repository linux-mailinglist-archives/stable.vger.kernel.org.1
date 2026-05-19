Return-Path: <stable+bounces-249572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DZ6I7hUDGqmfAUAu9opvQ
	(envelope-from <stable+bounces-249572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:16:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBF957E7D3
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 483B530BBD7C
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BE54C77CA;
	Tue, 19 May 2026 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gPAceZru"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628F4CA294;
	Tue, 19 May 2026 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192451; cv=none; b=pXB8KwwH8120IxvhnEp5inX8G6cChWmGdq6ygZUSLptKp4E5k0cYIj4sT+aEhtUXzkrLtUdsgpohBfrva34UEItMI3NDSg+wLn7insMA/Fg5XzA+SRwEDJkT/SMKQWkv1EUcDq0r4Lqd9R5/26kFqurVW+3pGtlRsRxFGy26AHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192451; c=relaxed/simple;
	bh=24gjXT5wmA214FuTksvBZxjgz04Ja4qpNigX7sxq6hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODCRDUYWlDM9bDMNPsoUOJLnVerjyqbhxeItlgFZfSNXItE8GXzOLRwlwWXCNxIs5T1PaDuYoyKKiIWzMtAtBHABw7u4hnewb4oXaRh1CpqLb9zoNtISaHHNfDmKA6slr/df0EuWRzpOI3RpoeOx0DusG4/t+oJy5WvQNZ8eMbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gPAceZru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777D5C2BCC7;
	Tue, 19 May 2026 12:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779192451;
	bh=24gjXT5wmA214FuTksvBZxjgz04Ja4qpNigX7sxq6hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPAceZru+S9ZuIhn16V91zK89WlwILsx+YuFd/0X3f6mr5V35bCAYgGzZxVQG94An
	 XeLA3r777h01ClFUmPgrT+qG6kESsr7JJlPG8caR1aRWaxNz6iiadjiTWvOZ/2rBTs
	 Ftcf22u/gnE0okDk/bJGyZnN1lx4JEEc36yQhWRw=
Date: Tue, 19 May 2026 14:06:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
	kuba@kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] bluetooth 2026-05-14
Message-ID: <2026051909-impurity-nemesis-2f65@gregkh>
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
 <f5cf1c30-48a4-4102-ae00-b74cf02e639e@leemhuis.info>
 <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh>
 <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249572-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davemloft.net,lists.linux.dev,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DEBF957E7D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 12:53:49PM +0200, Thorsten Leemhuis wrote:
> On 5/19/26 12:30, Greg KH wrote:
> > On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leemhuis wrote:
> >> On 5/15/26 17:10, Thorsten Leemhuis wrote:
> >>> On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
> >>>
> >>>> The following changes since commit c78bdba7b9666020c0832150a4fc4c0aebc7c6ac:
> >>>>   net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:12 +0200)
> >>>>
> >>>> are available in the Git repository at:
> >>>>
> >>>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-14
> >>>>
> >>>> for you to fetch changes up to 375ba7484132662a4a8c7547d088fb6275c00282:
> >>>>
> >>>>   Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-14 09:58:08 -0400)
> >>>
> >>> It seems this PR sadly came too late for this week's net PR to mainline
> >>> that was merged yesterday.
> >>>
> >>> TWIMC, from my point of view, it would be great if we somehow could
> >>> still get the changes from this PR or at least the btmtk fix it
> >>> contains[1] to mainline this week before -rc4, as it is fixing a
> >>> regression known since 2026-04-24 that at least five people encountered
> >>> with mainline since -rc3 due to 634a4408c0615c ("Bluetooth: btmtk:
> >>> validate WMT event SKB length before struct access") [006b9943b982 in
> >>> -next].
> >>
> >> Greg, Sasha, that [1] fix I was talking about now reached -next as
> >> 162b1adeb057d2 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL
> >> events") and will likely hit mainline on Thursday or so with the weekly
> >> -net PR to -mainline. If that's good enough for you, I'd say it would be
> >> good to pick this up for the next round of stable kernels.
> > 
> > That "Fixes:" tag is referring to something that is also not in any
> > tree, but that commit does have a cc: stable in it.  So do we need both
> > of these:
> 
> Valid question, as yes, there is a slight mixup here:
> 
> > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length before struct access")
> 
> That is already in v7.0.7, v6.18.30, v6.12.88, as 041e88fb0c08 is the
> -next commit-id for mainline commit-id 634a4408c0615c ("Bluetooth:
> btmtk: validate WMT event SKB length before struct access") -- the one
> that is causing the regression that I want to get fixed. So we now only
> need:
> 
> > 162b1adeb057 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL events")

Ok, but that "Fixes:" tag pointing to an invalid commit is going to be a
nightmare to track over time, ugh.

I'll go queue this up now, thanks.

greg k-h


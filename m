Return-Path: <stable+bounces-249625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNA0FlaHDGo1iwUAu9opvQ
	(envelope-from <stable+bounces-249625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:52:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A06C8581C65
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CF39312E574
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FDC400DF6;
	Tue, 19 May 2026 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pARPau/Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55A7400DFC;
	Tue, 19 May 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203949; cv=none; b=MN481U65FwWBiN9EHirg/seJEbPbLAhw/0yqEix5/CRn31VuKd78KDdN1nxg/GfvkFwxKd+0rmKySt+Vd7/yUlsPy8xpi2o8w4zGcuhkluNeBNLTcMLcYirQGQHOFiu15IpxWicvsIBKVNk2BJSKKwLqm2p8fs61lrH0KcTrTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203949; c=relaxed/simple;
	bh=nNsxKpDn2GIl+ynVQyOFWi8VuSsq3U/b8KBRqO60zFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzyEk9ullhdkcIPCcggow4Xrpp6zSfEPFUgZ+sNAqxtatcMSQ1qcTAthTlvOt7Rkz0Zu03HT6eHnpcOlR0YfiSMygxDEHp4MLyP6yVZYdIKdcwwQ3qpQMa/AYj0v+GM0NIxysOoODOP/4VqnGjpKhda0s6yw2PVq+zlr8NQI8RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pARPau/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61DCC2BCB8;
	Tue, 19 May 2026 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779203949;
	bh=nNsxKpDn2GIl+ynVQyOFWi8VuSsq3U/b8KBRqO60zFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pARPau/Z0VNLvUTTeuvLQ1kKek93j9hxvsdWGgFgrcJFzbpxLC8Lq2BclUqNnOYfr
	 RUb7w25Z0RUAZZW43ennx6Oe7UvVdovqifsnjYsDZ8/I9QZ5cNlmcHTwSAtLwobNe+
	 bSfJb3SyPrQg0K36TyXXhH95lBzWq5uiBcd3WfaY=
Date: Tue, 19 May 2026 17:18:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] bluetooth 2026-05-14
Message-ID: <2026051942-uproar-drainpipe-6370@gregkh>
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
 <f5cf1c30-48a4-4102-ae00-b74cf02e639e@leemhuis.info>
 <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh>
 <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
 <2026051909-impurity-nemesis-2f65@gregkh>
 <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249625-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A06C8581C65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 09:44:39AM -0400, Luiz Augusto von Dentz wrote:
> Hi Greg,
> 
> On Tue, May 19, 2026 at 8:07 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, May 19, 2026 at 12:53:49PM +0200, Thorsten Leemhuis wrote:
> > > On 5/19/26 12:30, Greg KH wrote:
> > > > On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leemhuis wrote:
> > > >> On 5/15/26 17:10, Thorsten Leemhuis wrote:
> > > >>> On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
> > > >>>
> > > >>>> The following changes since commit c78bdba7b9666020c0832150a4fc4c0aebc7c6ac:
> > > >>>>   net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:12 +0200)
> > > >>>>
> > > >>>> are available in the Git repository at:
> > > >>>>
> > > >>>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-14
> > > >>>>
> > > >>>> for you to fetch changes up to 375ba7484132662a4a8c7547d088fb6275c00282:
> > > >>>>
> > > >>>>   Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-14 09:58:08 -0400)
> > > >>>
> > > >>> It seems this PR sadly came too late for this week's net PR to mainline
> > > >>> that was merged yesterday.
> > > >>>
> > > >>> TWIMC, from my point of view, it would be great if we somehow could
> > > >>> still get the changes from this PR or at least the btmtk fix it
> > > >>> contains[1] to mainline this week before -rc4, as it is fixing a
> > > >>> regression known since 2026-04-24 that at least five people encountered
> > > >>> with mainline since -rc3 due to 634a4408c0615c ("Bluetooth: btmtk:
> > > >>> validate WMT event SKB length before struct access") [006b9943b982 in
> > > >>> -next].
> > > >>
> > > >> Greg, Sasha, that [1] fix I was talking about now reached -next as
> > > >> 162b1adeb057d2 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL
> > > >> events") and will likely hit mainline on Thursday or so with the weekly
> > > >> -net PR to -mainline. If that's good enough for you, I'd say it would be
> > > >> good to pick this up for the next round of stable kernels.
> > > >
> > > > That "Fixes:" tag is referring to something that is also not in any
> > > > tree, but that commit does have a cc: stable in it.  So do we need both
> > > > of these:
> > >
> > > Valid question, as yes, there is a slight mixup here:
> > >
> > > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length before struct access")
> > >
> > > That is already in v7.0.7, v6.18.30, v6.12.88, as 041e88fb0c08 is the
> > > -next commit-id for mainline commit-id 634a4408c0615c ("Bluetooth:
> > > btmtk: validate WMT event SKB length before struct access") -- the one
> > > that is causing the regression that I want to get fixed. So we now only
> > > need:
> > >
> > > > 162b1adeb057 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL events")
> >
> > Ok, but that "Fixes:" tag pointing to an invalid commit is going to be a
> > nightmare to track over time, ugh.
> 
> Hmm, did we get the wrong hash or something? Usually, that would show
> up in the verify-fixes.sh, but perhaps it didn't capture it this time
> for some reason, perhaps I'm running an outdated version or something
> similar.

Something went wrong if we ended up with a patch in the stable trees,
yet this fix is referring to it as a different git sha.  Don't know
where the disconnect happend :(

thanks,

greg k-h


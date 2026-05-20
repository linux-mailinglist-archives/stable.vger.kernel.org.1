Return-Path: <stable+bounces-249922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIqWKh20DWoT2QUAu9opvQ
	(envelope-from <stable+bounces-249922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:16:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 348C858EA03
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C918301135A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B8A3DA5B5;
	Wed, 20 May 2026 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pfjIpnZD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74318A92F;
	Wed, 20 May 2026 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282899; cv=none; b=qdlBWuPqHxnNhsIW8DVVKZn7FozgMIkQLdHNhTeVH3C5PdJETahqBSFxCmmWWjQUXZz2ftMSXEBgk8/2spl9khbylr+j91SfsbE3MW/2NZSj9SeuXiggmyydCftWwO2oWPY8/9qz6gFvaEhz+fOzpXbIdf4gyhHmMbHZxTL/u0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282899; c=relaxed/simple;
	bh=332yNbiHDYC/q9L/Y5HE8KnpnzR9GFg1YT2UZ6XlgcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0ArusyJ09DcNqCLDaSz4aeTX/QbcPihmGmJTPlnMUaI0r3Uk5WmmXFQgejS4R1q41mYhZUYx/GvGiIVKpTcN7H3QOE1ycGtpPehO/HMVa6YY5oyDbgolj6YMKJTMl7tEbvfZpZlcHXMOzCsyKlBABtVfMXSU/5uj8i2uAQDKUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pfjIpnZD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EA31F00894;
	Wed, 20 May 2026 13:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779282898;
	bh=0QKNnksfj1AdZlcvGjbO9ONmdIYwgP155TcW3tFuYBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pfjIpnZDDTzdBq1CciBSb6qLL0OSY1mgfkIi87Qsdh/qJk2G0dcwH5LNpaK4YQmCp
	 3oBlSlfNxcCdGOBxEKTAeeJF/ch8dkcwba7wAqrTu5KrEM6EKUsZ25U72aOpEgByq1
	 wCMr9cZxgtiCf/URM350vXXm6I6fiGkstwbAx3MA=
Date: Wed, 20 May 2026 15:15:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: August Wikerfors <git@augustwikerfors.se>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] bluetooth 2026-05-14
Message-ID: <2026052047-silica-grub-0bb2@gregkh>
References: <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh>
 <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
 <2026051909-impurity-nemesis-2f65@gregkh>
 <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
 <2026051942-uproar-drainpipe-6370@gregkh>
 <CABBYNZKzWgL3nmeA=CtN9s80LRyDiJ97aQXgvfSm9vYUBw_SpA@mail.gmail.com>
 <e666c332-e2aa-4525-a208-a4a08742d2e0@augustwikerfors.se>
 <2026052026-barber-espresso-1d9a@gregkh>
 <CABBYNZJ4woc+unpYN6_dzMLtxhFVUd5+ccv2+EQbDMkYuXQ12A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJ4woc+unpYN6_dzMLtxhFVUd5+ccv2+EQbDMkYuXQ12A@mail.gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249922-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 348C858EA03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 09:11:42AM -0400, Luiz Augusto von Dentz wrote:
> Hi Greg,
> 
> On Wed, May 20, 2026 at 8:47 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, May 19, 2026 at 07:37:35PM +0200, August Wikerfors wrote:
> > > On 2026-05-19 17:49, Luiz Augusto von Dentz wrote:
> > > > Hi Greg,
> > > >
> > > > On Tue, May 19, 2026 at 11:19 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, May 19, 2026 at 09:44:39AM -0400, Luiz Augusto von Dentz wrote:
> > > > > > Hi Greg,
> > > > > >
> > > > > > On Tue, May 19, 2026 at 8:07 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > On Tue, May 19, 2026 at 12:53:49PM +0200, Thorsten Leemhuis wrote:
> > > > > > > > On 5/19/26 12:30, Greg KH wrote:
> > > > > > > > > On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leemhuis wrote:
> > > > > > > > > > On 5/15/26 17:10, Thorsten Leemhuis wrote:
> > > > > > > > > > > On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
> > > > > > > > > > >
> > > > > > > > > > > > The following changes since commit c78bdba7b9666020c0832150a4fc4c0aebc7c6ac:
> > > > > > > > > > > >    net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:12 +0200)
> > > > > > > > > > > >
> > > > > > > > > > > > are available in the Git repository at:
> > > > > > > > > > > >
> > > > > > > > > > > >    git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-14
> > > > > > > > > > > >
> > > > > > > > > > > > for you to fetch changes up to 375ba7484132662a4a8c7547d088fb6275c00282:
> > > > > > > > > > > >
> > > > > > > > > > > >    Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-14 09:58:08 -0400)
> > > > > > > > > > >
> > > > > > > > > > > It seems this PR sadly came too late for this week's net PR to mainline
> > > > > > > > > > > that was merged yesterday.
> > > > > > > > > > >
> > > > > > > > > > > TWIMC, from my point of view, it would be great if we somehow could
> > > > > > > > > > > still get the changes from this PR or at least the btmtk fix it
> > > > > > > > > > > contains[1] to mainline this week before -rc4, as it is fixing a
> > > > > > > > > > > regression known since 2026-04-24 that at least five people encountered
> > > > > > > > > > > with mainline since -rc3 due to 634a4408c0615c ("Bluetooth: btmtk:
> > > > > > > > > > > validate WMT event SKB length before struct access") [006b9943b982 in
> > > > > > > > > > > -next].
> > > > > > > > > >
> > > > > > > > > > Greg, Sasha, that [1] fix I was talking about now reached -next as
> > > > > > > > > > 162b1adeb057d2 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL
> > > > > > > > > > events") and will likely hit mainline on Thursday or so with the weekly
> > > > > > > > > > -net PR to -mainline. If that's good enough for you, I'd say it would be
> > > > > > > > > > good to pick this up for the next round of stable kernels.
> > > > > > > > >
> > > > > > > > > That "Fixes:" tag is referring to something that is also not in any
> > > > > > > > > tree, but that commit does have a cc: stable in it.  So do we need both
> > > > > > > > > of these:
> > > > > > > >
> > > > > > > > Valid question, as yes, there is a slight mixup here:
> > > > > > > >
> > > > > > > > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length before struct access")
> > > > > > > >
> > > > > > > > That is already in v7.0.7, v6.18.30, v6.12.88, as 041e88fb0c08 is the
> > > > > > > > -next commit-id for mainline commit-id 634a4408c0615c ("Bluetooth:
> > > > > > > > btmtk: validate WMT event SKB length before struct access") -- the one
> > > > > > > > that is causing the regression that I want to get fixed. So we now only
> > > > > > > > need:
> > > > > > > >
> > > > > > > > > 162b1adeb057 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL events")
> > > > > > >
> > > > > > > Ok, but that "Fixes:" tag pointing to an invalid commit is going to be a
> > > > > > > nightmare to track over time, ugh.
> > > > > >
> > > > > > Hmm, did we get the wrong hash or something? Usually, that would show
> > > > > > up in the verify-fixes.sh, but perhaps it didn't capture it this time
> > > > > > for some reason, perhaps I'm running an outdated version or something
> > > > > > similar.
> > > > >
> > > > > Something went wrong if we ended up with a patch in the stable trees,
> > > > > yet this fix is referring to it as a different git sha.  Don't know
> > > > > where the disconnect happend :(
> > > >
> > > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length before
> > > > struct access")
> > > >
> > > > I don't have that in any of our tree either, this is actually
> > > > 634a4408c061 on all trees in the chain:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/commit/?id=634a4408c061
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=634a4408c061
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=634a4408c061
> > > >
> > > > Or actually that was the hash before it got rebased on bluetooth-next tree:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=041e88fb0c08
> > > >
> > > > But I didn't send the PR from that three so perhaps somebody else sent
> > > > it to stable with the wrong fixes tag?
> > > I believe the confusion comes from "Bluetooth: btmtk: accept too short WMT
> > > FUNC_CTRL events" itself currently having different commit hashes in
> > > bluetooth (e3ac0d9f1a20) and bluetooth-next (162b1adeb057). The former
> > > correctly refers to "Bluetooth: btmtk: validate WMT event SKB length before
> > > struct access" as 634a4408c061 in the Fixes tag and was merged into net
> > > yesterday heading for 7.1-rc5. The latter still refers to it as
> > > 041e88fb0c08. Both are now in next-20260519 but only the latter was in
> > > next-20260518 which was the latest at the time of Thorsten's message.
> > >
> > > Greg, this means picking e3ac0d9f1a20 instead of 162b1adeb057 should result
> > > in a valid Fixes tag.
> >
> > Ok, now done.  Be careful of duplicate commits in different branches
> > that are marked for backporting with different ids.  It can cause
> > massive confusion (i.e. don't be like the drm tree...)
> 
> Noted. I guess I need to dig into how other trees do to avoid that.
> The problem seem related to using 2 trees: bluetooth->net (fixes only,
> rebased on each RC) versus bluetooth-next->net-next (development,
> rebased once per release).

Just never rebase any public tree please.


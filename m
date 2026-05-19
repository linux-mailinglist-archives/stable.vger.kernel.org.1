Return-Path: <stable+bounces-249548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAMHIp5ADGqqawUAu9opvQ
	(envelope-from <stable+bounces-249548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:51:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D944157CD8B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C352D30226F8
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09EE233957;
	Tue, 19 May 2026 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J4Cfvv5f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AC9233940;
	Tue, 19 May 2026 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186665; cv=none; b=G31qcVml7zed8zcnBgVTYgMwz3Kk9VHhT99a4M61ZXEcUO9i98RnBhHNeH71BMmGLNNRSQ1EeMsnvLMd5L/IAW34PHZS9ocVEkjOe+27LRXRsHLukAPiifGoESyJf1vDZKrxxwM6WiaBehmp+1xDKQXk7FD6RVT6Yf3dBrapv/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186665; c=relaxed/simple;
	bh=MIarBP63UTs+88elrdija1WbYU2SPWpM4zA46J2/dpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDZRKCqlHVzkUdfk8Z+bL2QwmTkmm2MLJMwTspN1vgw4wGBGvbQYIxXvwLWSe3/ZXYMCe8ss33FepSu7in9eyc5qPZQv80sG16x0opo0hEAAgWBfAEwVr9ImKbkoLlhs21qXKaYHX0yKTKWWtL+yoeQ6/HpF+6FUX7xQnbhv97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J4Cfvv5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003F1C2BCF5;
	Tue, 19 May 2026 10:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779186665;
	bh=MIarBP63UTs+88elrdija1WbYU2SPWpM4zA46J2/dpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4Cfvv5fSXE/wjAzNFEu2XUxFpVeeB+zUhJVDhvAuVVhkt4/NP/y8M8lpoAbNiikV
	 6iI2TrmpmoPv3EeMMQ62WrdM9a6zfDmyLhlY+UMJeYdEUKxwDLBW4bPugVZi7LlFE6
	 Bl1YJKIlI9q6iVAdG6zQz/Z6pVS1fhsKt5Utnlss=
Date: Tue, 19 May 2026 12:30:18 +0200
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
Message-ID: <2026051954-revision-sierra-6bb4@gregkh>
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
 <f5cf1c30-48a4-4102-ae00-b74cf02e639e@leemhuis.info>
 <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249548-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D944157CD8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leemhuis wrote:
> On 5/15/26 17:10, Thorsten Leemhuis wrote:
> > On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
> >
> >> The following changes since commit c78bdba7b9666020c0832150a4fc4c0aebc7c6ac:
> >>   net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:12 +0200)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-14
> >>
> >> for you to fetch changes up to 375ba7484132662a4a8c7547d088fb6275c00282:
> >>
> >>   Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-14 09:58:08 -0400)
> > 
> > It seems this PR sadly came too late for this week's net PR to mainline
> > that was merged yesterday.
> > 
> > TWIMC, from my point of view, it would be great if we somehow could
> > still get the changes from this PR or at least the btmtk fix it
> > contains[1] to mainline this week before -rc4, as it is fixing a
> > regression known since 2026-04-24 that at least five people encountered
> > with mainline since -rc3 due to 634a4408c0615c ("Bluetooth: btmtk:
> > validate WMT event SKB length before struct access") [006b9943b982 in
> > -next].
> 
> Greg, Sasha, that [1] fix I was talking about now reached -next as
> 162b1adeb057d2 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL
> events") and will likely hit mainline on Thursday or so with the weekly
> -net PR to -mainline. If that's good enough for you, I'd say it would be
> good to pick this up for the next round of stable kernels.

That "Fixes:" tag is referring to something that is also not in any
tree, but that commit does have a cc: stable in it.  So do we need both
of these:

041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length before struct access")
162b1adeb057 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL events")

Or just one?

confused,

greg k-h


Return-Path: <stable+bounces-220007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MJADbb8oWl4yAQAu9opvQ
	(envelope-from <stable+bounces-220007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 21:21:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E051BD8C5
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 21:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCFE03035F6F
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F61413236;
	Fri, 27 Feb 2026 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RVD5BozJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82BC31B131;
	Fri, 27 Feb 2026 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223447; cv=none; b=bZxxrv271PiH06ClFRXDUkW+Yqp/3QMyHv5YrMhpMwdLQ5l648rLA7QeL6Oh3JhrLxu4KlJoSh3a7xAMswXWDLtfW4CO+JG/Zm7oZ2IiFufelHN0PORhKQnrmyg4HY0UQu6ycE2x0hv06eT5IqqWH8xPXyj901Fc3RFEiYYrNSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223447; c=relaxed/simple;
	bh=s0SN7GHDBZTG4PRpuVU2uADRSwcJQhnHFXyvIsBpLRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBgzh+vsZpDeu4uONojDoaySF2VJ2yIVQvxzbwpJu7n0WJYW4nFQciInaJz5SoOe54DlyUBhqsJ7yKHdnmTQY3pRBmF8kTcGbM0N2Voae78N2d5fZMGXDM8cdRoNubHYlAw63hykjD6NiKe3pZRBPCuv9du8Bf0P9cJq4TakF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RVD5BozJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33758C116C6;
	Fri, 27 Feb 2026 20:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772223447;
	bh=s0SN7GHDBZTG4PRpuVU2uADRSwcJQhnHFXyvIsBpLRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVD5BozJtQb8QUxDkd6XVejbrEwvUXNeScBYDVwvDF4DlzzXZLwSBq17/MzimzoFW
	 s9hbOvTe1qlMehv2Hfj9lCVm+1GvQo8Yr/oKOouqkU2UnIJC08w70eB1cFvq0u5Etj
	 LWqe6x1l6WOPxxX/hc2xg59EUZKLgo8zrWcI5f1E=
Date: Fri, 27 Feb 2026 15:17:16 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: Genes Lists <lists@sapience.com>,
	"Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>,
	akpm@linux-foundation.org, jslaby@suse.cz,
	linux-kernel@vger.kernel.org, lwn@lwn.net, stable@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: Linux 6.19.4 - Oops, regression
Message-ID: <2026022756-observant-moonstone-88c2@gregkh>
References: <2026022657-clambake-mountable-8175@gregkh>
 <eb2d1da9-0b4b-4887-83a4-0e2a65e703aa@moonlit-rail.com>
 <2026022612-buckskin-surfacing-d854@gregkh>
 <bb9ab61c-3bed-4c3d-baf0-0bce4e142292@moonlit-rail.com>
 <67d9f732a55a31f3073675164e8d7ada46da3dbe.camel@sapience.com>
 <0a77c13e74493b786c5fe4e1ebdf55b14e5ff496.camel@sapience.com>
 <2026022750-everyone-huff-8fd0@gregkh>
 <95fea1bd0ded180bb79285ec8416053c614150f8.camel@sapience.com>
 <afe24af8ae3913f8988dc551629e8f598313a29d.camel@sapience.com>
 <0f744313-d13b-4de3-9cf1-de97e9b8fb3d@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f744313-d13b-4de3-9cf1-de97e9b8fb3d@manjaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-220007-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D4E051BD8C5
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 07:51:09PM +0100, Philip Müller wrote:
> On 2/27/26 15:44, Genes Lists wrote:
> > On Fri, 2026-02-27 at 08:59 -0500, Genes Lists wrote:
> > > On Fri, 2026-02-27 at 08:32 -0500, Greg KH wrote:
> > > > On Fri, Feb 27, 2026 at 08:18:52AM -0500, Genes Lists wrote:
> > > > > On Fri, 2026-02-27 at 07:09 -0500, Genes Lists wrote:
> > > > > > On Fri, 2026-02-27 at 01:26 -0500, Kris Karas (Bug Reporting)
> > > > > > w...
> > ...
> > > 
> > > Sorry if was not clear.  Only 6.19.4 has kernel crash.
> > > The summary is:
> > > ...
> > > - 6.19.4 - crashes whenever nftables is invoked.
> > >    Does not matter which userspace nftables is used, older or newer
> > ...
> > > I will report back soon as have finished testing 6.19.4 with commit
> > > f175b46d9134
> > I confirm that
> > 
> >     6.19.4 plus git cherry-pick f175b46d9134f708358b5404730c6dfa200fbf3c
> > 
> > works fine and resolves the crash in nf_tables_abort_release seen in
> > 6.19.4.
> > 
> > gene
> > 
> > 
> > 
> > 
> > 
> Most likely 6.18.14 might be affected here as well. Same patch was added
> there also: https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/diff/releases/6.18.14/netfilter-nft_set_rbtree-translate-rbtree-to-array-f.patch?id=08f2c72545fd46526226105230449470db503ecf

Thanks all, yes, I'll go add this to both trees and do a quick release
to resolve this.

greg k-h


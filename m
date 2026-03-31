Return-Path: <stable+bounces-231400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLm8Gyyty2kpKAYAu9opvQ
	(envelope-from <stable+bounces-231400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:17:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D88523689BB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E4993028F45
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189453C9ED6;
	Tue, 31 Mar 2026 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az6FC5Mg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95173C276D;
	Tue, 31 Mar 2026 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955793; cv=none; b=mlMeXI1YEsj87P+UXobe+rQucpCeMK7kP3/9cEV8JorhLTj5y/jelUhoJ3O8sxBj8sIZlZnnfmpQGr20p8bOq+uqZnVjKaCIyR3siN4/lbFi9mns6VIfyqFn3rP5apL22KFVlUdPR9mMuzEWvLCls+L71i2N7Qc3+Kg1EP7GHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955793; c=relaxed/simple;
	bh=g7V653Z3+W27IBQC4uaRsno5n6wKfRS+8Q49+lDclzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwBHcCMKbWwlYh45iDy8FaZEijzyBJNIfCG1g6bF4tu3C7ItI+uaGJFarzRXhOVeWqnXQrssiTr0jcz2o88igvtofJl12cjBNO9Ipqmm2pWuJToqYW4Hpg2vdJ3D7sRzjZVwfSVhASc6nOb2ZBVwVWtNHFtO6mVjh0FTYLuomVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az6FC5Mg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BB3C2BCB1;
	Tue, 31 Mar 2026 11:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774955793;
	bh=g7V653Z3+W27IBQC4uaRsno5n6wKfRS+8Q49+lDclzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=az6FC5MgYXEBZIpdZ5TVqDghvpGpR3yToioYKg5i7d/Px334RmHBa0yOTffwQgtgU
	 9ezIYvtQzYbQ8T70oPywpzpqDLsubtRjB68CRNKZu6KnNKaN8P1ZxfA83jku7MfDMj
	 bpfWjBupaZe0+X1KzLKbHOQBOaO58I48pVOteJjC1n3LfmZhXKMGwiNZc2DqnGxEG6
	 dz+Nv9icRV1amKxnxlh+5+l15R5J2rvO8OIdFvUX8vmgyf0/FL20UFH9cf6+DQ+Tlw
	 kYNRuhAE1Dxt+dC8LNo6OLnBCfkFrzAyNusaGHj8oJ0bmA+b695aizTKZRangNmFnk
	 Sw9491Av+BlzQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w7X5D-00000008REw-0L0s;
	Tue, 31 Mar 2026 13:16:31 +0200
Date: Tue, 31 Mar 2026 13:16:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tony Olech <tony.olech@elandigitalsystems.com>
Subject: Re: [PATCH 1/4] mmc: vub300: fix NULL-deref on disconnect
Message-ID: <acutD9XSXP-vrU2E@hovoldconsulting.com>
References: <20260327105208.1310739-1-johan@kernel.org>
 <20260327105208.1310739-2-johan@kernel.org>
 <CAPDyKFp1DbRufpro86fXi9xXnJGbWW=NrD3Q0NFQ+aHxhxogLg@mail.gmail.com>
 <acuiz2y0pIdEwlB4@hovoldconsulting.com>
 <CAPDyKFpbcn3SJrZP1SE5VPw4nxk7ct=B80=nD9k2gBdEo6EBCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpbcn3SJrZP1SE5VPw4nxk7ct=B80=nD9k2gBdEo6EBCw@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231400-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: D88523689BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 01:03:39PM +0200, Ulf Hansson wrote:
> On Tue, 31 Mar 2026 at 12:32, Johan Hovold <johan@kernel.org> wrote:

> > > > @@ -2365,8 +2365,8 @@ static void vub300_disconnect(struct usb_interface *interface)
> > > >                         usb_set_intfdata(interface, NULL);
> > > >                         /* prevent more I/O from starting */
> > > >                         vub300->interface = NULL;
> > > > -                       kref_put(&vub300->kref, vub300_delete);
> > > >                         mmc_remove_host(mmc);
> > > > +                       kref_put(&vub300->kref, vub300_delete);
> > >
> > > While this seems like a step in the right direction, I don't see why
> > > calling usb_set_intfdata(interface, NULL)
> >
> > The interface data is only used in the USB bus callbacks and is not
> > needed after disconnect().
> >
> > > and assigning
> > > vub300->interface = NULL is safe.
> > >
> > > For example, some of the workqueues might be running a work that uses
> > > the vub300->interface, isn't that a problem too?
> >
> > The driver uses this pointer to indicate that the device has been
> > disconnected. That doesn't mean that the implementation is correct (e.g.
> > the check in vub300_pollwork_thread() should use some locking) but that
> > would be pre-existing issues.
> 
> Right, that was my thinking as well.
> 
> Out of curiosity, are you planning on fixing these issues too or is
> that left for later?

No, sorry, this was just something I stumbled over when addressing USB
devres issues tree wide.

Johan


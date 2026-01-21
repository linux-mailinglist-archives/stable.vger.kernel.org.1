Return-Path: <stable+bounces-210796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FmzDkQhcWl8eQAAu9opvQ
	(envelope-from <stable+bounces-210796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:56:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DEB5BA00
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87CED823FF2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AB54BC02B;
	Wed, 21 Jan 2026 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nQmsi8Lb"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB14A3405
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014668; cv=none; b=npGiMDQqAc8wPnbCrXdqupQ8HW+6qxpJP8O67URoUoZfIa0WyRqNa/BVnOtbzZzSG32zsVi4W0oSmW65enl2FplYIje72QN61+FexfcewfOqTdRSQ7npX3UrHDiBhHr0GWVj4swjpk1DgoAmkebjaY4W09mR7iunPtmAmYYCS1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014668; c=relaxed/simple;
	bh=x5aeSdqqGzGgBLN7hHm8q9HQoIZ+VDX6ILu1R2xxNbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Px2ne+K19qTu8qrFkFtOlWR9oSOg6vhw2oOs5Ze10KQCS2a8nPycx+8GiM/17ACtrmujHSnSVYkuNTsMW9z7ItopwT0jEGQ2/8jFeLsHRo3OgQKf0kO8vPcCvsRI3gH4vr05T9r7U6kMReT38RA3UKD2pcra8fNnvh/sDwkTeGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nQmsi8Lb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 11E53C21A8D;
	Wed, 21 Jan 2026 16:57:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 374EC6070A;
	Wed, 21 Jan 2026 16:57:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B986119B17FD;
	Wed, 21 Jan 2026 17:57:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769014660; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=a75AgL/A7+mTrQ7jeA8LN5S6nZsKjkQB4oc2wcafViI=;
	b=nQmsi8LbsrqHERl9LqRdWMRB/0NQN5l+vai7ZxWJXjS6cQfuyLjKd2xszyvTO+Rma4Ri5H
	2lI9obKTgUlH6fBvjOYQj0xNjZx1g40dKkTiSRxDeOUObT9/uSxJCV+YVMVSWjg+RTHw/Z
	1y5kzoKW7SQv1pzYRl3hgb5fgHbP7mnao6Ndvau7OTUGoZYiPOMU0BRgedF1Q/VdIvZqmR
	C8GvCsFB8HH8qNIG3Jdik/UPvUQpx77SxBshRYmwILgMwB/NEOy//O35KVEZrtrGItZGOZ
	hk/tJm0XvtWJBx1gz+wLxsP1Ts74Os3Cg9Wj/lJ9INfjBNHPEmBpPsfh/sAmsg==
Date: Wed, 21 Jan 2026 17:57:38 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [REGRESSION] v6.6.120: i3c crash caused by commit 82a09b9965ed
Message-ID: <202601211657387e890711@mail.local>
References: <d0a7accd-3d7d-41ec-b85e-469adf156a91@socionext.com>
 <2026012139-fidgeting-comic-916c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026012139-fidgeting-comic-916c@gregkh>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[bootlin.com,reject];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-210796-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandre.belloni@bootlin.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: C7DEB5BA00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 15:56:01+0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 21, 2026 at 08:04:03PM +0900, Kunihiko Hayashi wrote:
> > Dear stable maintainers,
> > 
> > After updating from v6.6.119 to v6.6.120, I noticed a kernel crash
> > when I3C was enabled.
> > 
> > This regression is caused by:
> > 
> >     commit 82a09b9965ed ("i3c: fix refcount inconsistency in i3c_master_register")
> > 
> > The issue is resolved when the following upstream fix commit is applied:
> > 
> >     commit 3502cea99c7c ("i3c: Move device name assignment after i3c_bus_init")
> 
> That does not seem to be a valid git id, where did it come from?
> 

This has not yet been sent to Linus and my plan was to wait for the
merge window as the fix didn't make it clear this was actually happening
in the field.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


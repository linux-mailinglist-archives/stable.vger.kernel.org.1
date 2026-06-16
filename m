Return-Path: <stable+bounces-263628-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0zH8LrP3MGqGZgUAu9opvQ
	(envelope-from <stable+bounces-263628-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 09:13:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F53068CBF3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 09:13:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NWCSG+xo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263628-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263628-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF1DA3015C26
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E8F3546E8;
	Tue, 16 Jun 2026 07:13:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47F13502A9;
	Tue, 16 Jun 2026 07:13:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594032; cv=none; b=iOPw1oHs3MHJUizAbmnJOT7i3zXxm0qx1MoNCRDH0uHsBZGqff5eHpG9JULHFTF7rnNRfo1LU+SFAfVuQgt5EN2c1lP6Ja2vVtmUz48lga9+VCq48hNHNVNxNBxya7vlYhhvDP1TSkp29og1IhWNJTX1ycPdKnVjApa7WAt+MjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594032; c=relaxed/simple;
	bh=Ut5qRS6rGpVfBsBBURz9asjqr94BKlPhlB7+Q0ilNCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcSBvl7tNH/QGkKUvLd1ZCib0XH+1dUKDqpYigFi553xp3XGg9Mc1xnXz820vEm17zSF76DhS1Su8x1zN+sDZDBSgVw9R3EWx97vaQ6gHdoGpC3yqSjkAq5parj5llGcSHv6yAfGmSmAK8Hf4K6zzrYf4HjIHTpHW5KKB+DMxrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWCSG+xo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F04C1F00A3D;
	Tue, 16 Jun 2026 07:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781594031;
	bh=2yPfSU6MBOdHhivpd/ALvH3pjEUub2lJ35/vvEet6cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NWCSG+xoN7ZC6bJ/vlUAWGPyyVnYof3n5RAP/QXjkNdKOOoC9QF0PprU+Zc9mbaBG
	 mLihSIPO7J/jSSbgts5nq/NUDRsZcLH7HF8bjTU52Lc5QH0zap92JKI8Ke/ky28HNd
	 N16XfFpC/7toNJxlLah8plReo+9gTq7pglqqhYOvHO659AyHxR8H0e6/V2Dx4980Kp
	 SHjKYyzjlajzJJnNHugoVwXG6wNknkDJT87pla9l2gsAcYtN+PdtyUgq4PcqjbfpZU
	 t6Pp3wj7Pjlw8CgVmtn5mkS350LDsg0vD2JvqlFfDBlqkzAR4E4O+eO3yO56A3Txcf
	 Yf+u8XnxU+5Rg==
Date: Tue, 16 Jun 2026 09:13:45 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>, Fedor Pchelkin <pchelkin@ispras.ru>, 
	Leah Rumancik <leah.rumancik@gmail.com>, stable@vger.kernel.org, xfs-stable@lists.linux.dev, 
	"Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Catherine Hoang <catherine.hoang@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.6 0/4] fix kernel crash for xfs/235 test
Message-ID: <ajD3Gb-vQkGU0N6b@nidhogg.toxiclabs.cc>
References: <20250322143418.216654-1-pchelkin@ispras.ru>
 <aisAxyXVxf4wql2u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260612233110.2-1-sashal@kernel.org>
 <ajBQPNuKCruxhkXX@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajBQPNuKCruxhkXX@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263628-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,ispras.ru,gmail.com,vger.kernel.org,lists.linux.dev,lst.de,oracle.com,linuxfoundation.org,linuxtesting.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hamzamahfooz@linux.microsoft.com,m:sashal@kernel.org,m:pchelkin@ispras.ru,m:leah.rumancik@gmail.com,m:stable@vger.kernel.org,m:xfs-stable@lists.linux.dev,m:djwong@kernel.org,m:hch@lst.de,m:catherine.hoang@oracle.com,m:gregkh@linuxfoundation.org,m:lvc-project@linuxtesting.org,m:leahrumancik@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cem@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F53068CBF3

On Mon, Jun 15, 2026 at 03:19:24PM -0400, Hamza Mahfooz wrote:
> Cc: Carlos Maiolino <cem@kernel.org>

FWIW I don't maintain the stable trees I really don't have time for
that. Darrick/Leah have been doing a best effort case for that, but
again, this is mostly a best effort so we shouldn't expect them to be
looking/picking up every single possible patch suggested for stable.

> 
> On Fri, Jun 12, 2026 at 08:20:34PM -0400, Sasha Levin wrote:
> > On Wed, Jun 11, 2026 at 02:39:03PM -0400, Hamza Mahfooz wrote:
> > > Any idea what happened to this series? It resolves an issue that I've
> > > hit in a production environment FWIW.
> > >
> > > Series is:
> > >
> > > Tested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > 
> > Thanks for the nudge, and thanks Fedor for putting the backport together.
> > 
> > We generally don't take XFS backports without a maintainer signing off on them,
> > so right now we're waiting for one to do so :)
> > 
> > --
> > Thanks,
> > Sasha


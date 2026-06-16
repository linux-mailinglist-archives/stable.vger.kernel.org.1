Return-Path: <stable+bounces-263742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cMqKG/1QMWphggUAu9opvQ
	(envelope-from <stable+bounces-263742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:34:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F07BD68FF8C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:34:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=nMSzF8R3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263742-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263742-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 440FA304D247
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCA92FF17A;
	Tue, 16 Jun 2026 13:32:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506CD2BE026;
	Tue, 16 Jun 2026 13:32:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616724; cv=none; b=cjoMg3J8MaLUXXzR+dxvPX1AR0/OZnzdVvIGOQtkQb9efD5rsLeXO2DUgblwpX+ztq961Sb/JJx4rJckMVmyCFd54rchIHlVTVGrDcCUq93s+HCGcVebp/gjQsOL7pUCRlEyTSyJLjSqUuGY9/NpndhMGAGqQ0n0mxtSC14YhDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616724; c=relaxed/simple;
	bh=9Lg1J7A4O8tyIczW9feMfYwxsXwLwMsgsLPQDTWGkPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJMywr+mTo0l9x8SMr0J4XpgtiOEZ+fJQflTMgVejF93M5naR0pJm+BpFPWH94s+7HeBpfYNB7jRkweYirGeojhmGw0hSdll95iXaSR062zn4HTXSUmWin6i3jbYqKshoMcf4fQVx1CVNb0Q09ljFgPApS4GzM5lFrIYzapS1dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nMSzF8R3; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id EA72620B716A; Tue, 16 Jun 2026 06:31:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA72620B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781616701;
	bh=1L59/F0MlY1PyEzER7lNpGooBsayOF3108pPWJiREgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMSzF8R3JSbBi1eOF8Be5Wy4X8vcUC7njNyiUG+qm9C5qEoEqbSs1iZvQ6oC+mu+f
	 SmPhvl1pt/2//CrxP0CuSUbSjru44o/8wWC2/PYUpbhHiUh43Wf0ZGVVv5cF/fZVH0
	 zI3e3jHR7HFsk9j4HM+VB6U953Rt/VvCuMr+1KI8=
Date: Tue, 16 Jun 2026 09:31:41 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Carlos Maiolino <cem@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Fedor Pchelkin <pchelkin@ispras.ru>,
	Leah Rumancik <leah.rumancik@gmail.com>, stable@vger.kernel.org,
	xfs-stable@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	lvc-project@linuxtesting.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6.6 0/4] fix kernel crash for xfs/235 test
Message-ID: <ajFQPY2m2A6ltvTH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250322143418.216654-1-pchelkin@ispras.ru>
 <aisAxyXVxf4wql2u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260612233110.2-1-sashal@kernel.org>
 <ajBQPNuKCruxhkXX@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ajD3Gb-vQkGU0N6b@nidhogg.toxiclabs.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajD3Gb-vQkGU0N6b@nidhogg.toxiclabs.cc>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cem@kernel.org,m:sashal@kernel.org,m:pchelkin@ispras.ru,m:leah.rumancik@gmail.com,m:stable@vger.kernel.org,m:xfs-stable@lists.linux.dev,m:djwong@kernel.org,m:hch@lst.de,m:catherine.hoang@oracle.com,m:gregkh@linuxfoundation.org,m:lvc-project@linuxtesting.org,m:linux-xfs@vger.kernel.org,m:leahrumancik@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263742-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hamzamahfooz@linux.microsoft.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,ispras.ru,gmail.com,vger.kernel.org,lists.linux.dev,lst.de,oracle.com,linuxfoundation.org,linuxtesting.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.microsoft.com:dkim,linux.microsoft.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F07BD68FF8C

Cc: linux-xfs@vger.kernel.org

On Tue, Jun 16, 2026 at 09:13:45AM +0200, Carlos Maiolino wrote:
> On Mon, Jun 15, 2026 at 03:19:24PM -0400, Hamza Mahfooz wrote:
> > Cc: Carlos Maiolino <cem@kernel.org>
> 
> FWIW I don't maintain the stable trees I really don't have time for
> that. Darrick/Leah have been doing a best effort case for that, but
> again, this is mostly a best effort so we shouldn't expect them to be
> looking/picking up every single possible patch suggested for stable.
> 

Now that you mention it, the xfs-stable mailing list seems to be pretty
much dead (i.e. the last time fixes from it were merged into stable was
almost a year ago). I guess no one is really working on it anymore?

> > 
> > On Fri, Jun 12, 2026 at 08:20:34PM -0400, Sasha Levin wrote:
> > > On Wed, Jun 11, 2026 at 02:39:03PM -0400, Hamza Mahfooz wrote:
> > > > Any idea what happened to this series? It resolves an issue that I've
> > > > hit in a production environment FWIW.
> > > >
> > > > Series is:
> > > >
> > > > Tested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > > 
> > > Thanks for the nudge, and thanks Fedor for putting the backport together.
> > > 
> > > We generally don't take XFS backports without a maintainer signing off on them,
> > > so right now we're waiting for one to do so :)
> > > 
> > > --
> > > Thanks,
> > > Sasha


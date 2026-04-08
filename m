Return-Path: <stable+bounces-233896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kALXE89Q1mm8DQgAu9opvQ
	(envelope-from <stable+bounces-233896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:57:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEAA3BC7A4
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77502300599F
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783053AE6F4;
	Wed,  8 Apr 2026 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SbaFNV8o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA112E7F3A
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653069; cv=none; b=mzrjLH5Sc0wzVo4B2pM70/OVzlKhvVy4lolqBeLKxU7nuFaRiO26DbD06rItS5UU4wPs5qyiSCiwg5HBJe2m6BLnHM5fjUelstdgXs1qTvpS1DtDa4kFGaVMR4i4OjrY6w2dJm9hilm0QUGHlUtvepNDqjNVfulxsKi0ntgMvlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653069; c=relaxed/simple;
	bh=nF9OnyHQ0q2Ree0kX6u39dDeRH0YTejJV1dZNT/AeJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhzGlrGjuiC1iiJ1eCX2dfaQ7w3JAloKnqIzgIUodZuC6W+OzvhB5uvs3x6Z8YIrnr03BKt/fr/GtoRbw7+wpIZH1wSL8Jy7Y+YPs9eq4QPTeQyS6ei9Qd2khzwByZf8zwFIatw2HiYJbS2+cfEdzVIzu5O0gNkigU7oR1hCGdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SbaFNV8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98058C19421;
	Wed,  8 Apr 2026 12:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775653068;
	bh=nF9OnyHQ0q2Ree0kX6u39dDeRH0YTejJV1dZNT/AeJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SbaFNV8oUgyoDrEjLciGIJ8wUE9s52KrGpNaQBJ+F28tiOTSzHYxlEGRydv9BZUMm
	 TGBuJ5ZswWyVPNyeXb6HaE3HRtJGggogBqhu1a28VAYVyJPSXS+T2j9eKARDnZpOda
	 SxLpW239sRxBMlkMxvqj2o2rFj7jFnxQuBN6Vbdw=
Date: Wed, 8 Apr 2026 14:57:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brett Mastbergen <bmastbergen@ciq.com>
Cc: stable@vger.kernel.org, pmladek@suse.com
Subject: Re: Backport request for fda024fb64769e9d6b3916d013c78d6b189129f8 to
 stable/6.18.y
Message-ID: <2026040842-professor-moonshine-97f2@gregkh>
References: <CAOBMUvhG4DQDiEarc_P132=a+zGN4hySrNPYigUf6qC2Kh9iqg@mail.gmail.com>
 <2026040448-prideful-feast-eae5@gregkh>
 <CAOBMUvijA=zGwbnt4KONVTfXPDgiYWo3T4ZajwTKp=g2BuaQfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOBMUvijA=zGwbnt4KONVTfXPDgiYWo3T4ZajwTKp=g2BuaQfw@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233896-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECEAA3BC7A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 11:36:19AM -0400, Brett Mastbergen wrote:
> On Sat, Apr 4, 2026 at 2:24 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Apr 03, 2026 at 04:30:35PM -0400, Brett Mastbergen wrote:
> > > Please consider applying the following mainline commit to the 6.18.y
> > > stable tree:
> > >
> > >  commit fda024fb64769e9d6b3916d013c78d6b189129f8
> > >  kallsyms: clean up modname and modbuildid initialization in
> > > kallsyms_lookup_buildid()
> > >
> > > The patch applies cleanly to 6.18.21
> >
> > What about 6.19.y?  You also need/want it there too, right?
> 
> Yes please!  I was able to trigger the same panic with aarch64 running
> 6.19.11-rc1.
> fda024fb6476 applies cleanly and gets rid of the panic there too.

Now done.


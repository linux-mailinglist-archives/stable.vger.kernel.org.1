Return-Path: <stable+bounces-219630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE+xDQgGn2mZYgQAu9opvQ
	(envelope-from <stable+bounces-219630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:24:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0A8198A79
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E47B9308CE51
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F463D3485;
	Wed, 25 Feb 2026 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n6EqAquc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ED63D3309
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029441; cv=none; b=ggXo60bFqAV4AwQ/aKlaxDWN6FnRehQ+MtpwF7nZF8XHrwVTwu6bsZVhzK30GgBMGduvXWg7ZpVMfhAdlb4got3XnKF8gJQeZanwldWIQOahnaGO2UK6jkoV5l4iJgvrgXjZndacTada7FraHezBS2kg2hmCw+a+LS4ArfNKKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029441; c=relaxed/simple;
	bh=WuKkuvnPdrSKEhS0H0fTgBb8kGxkerf2Lae8STNfyJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4TCTywAbLd3YW0KaS4noUI8d8fXSBx+5QUdCtyceax1jNeF0/M/ohw7c5hOcQzcb/qZXk9dERrpzCrSu9/ihA12jU4RaG25OxsVRop6FDo5R80/0vk7yqLAKuARMISmpIPoO3x09AnBruigIhBVuyn6RZK/U1mrsj+AtlPvTT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n6EqAquc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A912C116D0;
	Wed, 25 Feb 2026 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772029440;
	bh=WuKkuvnPdrSKEhS0H0fTgBb8kGxkerf2Lae8STNfyJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6EqAqucOxDUIN2XJ+PkQs/7rSo0zdYYMjQe+zFcNwHbULgZcOwqlNF49y3u6MJAt
	 hBRYt7ExdoyT1RTIdGhoGRyYbvT4VBwcAwepMSNUAs/puw1urIf4hMjd2A4i+mK+Iv
	 I1wiS3NnBJPU/ZcYzcU2+NWMxz16whDBGs0gvphM=
Date: Wed, 25 Feb 2026 06:23:52 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>
Subject: Re: A few HDMI fixes for 6.18.y
Message-ID: <2026022524-carbon-paltry-1db0@gregkh>
References: <2525eb93-1515-4213-ba81-6d654c5db2ee@amd.com>
 <2026022401-fondness-unburned-7a44@gregkh>
 <c6996c83-db35-4f2c-b11d-dbb4eaeb7269@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6996c83-db35-4f2c-b11d-dbb4eaeb7269@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219630-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6B0A8198A79
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 08:31:06PM -0600, Mario Limonciello wrote:
> 
> 
> On 2/24/2026 6:56 PM, Greg KH wrote:
> > On Mon, Feb 23, 2026 at 02:04:05PM -0600, Mario Limonciello wrote:
> > > Hi,
> > > 
> > > There was a commit in 6.18 that caused a problem:
> > > c918e75e1ed9 ("drm/amd/display: Add an HPD filter for HDMI")
> > > 
> > > This has been fixed by these commits:
> > > commit 6a681cd90345 ("drm/amd/display: Add an hdmi_hpd_debounce_delay_ms
> > > module")
> > > commit 17b2c526fd80 ("drm/amd/display: Clear HDMI HPD pending work only if
> > > it is enabled")
> > > 
> > > Can we please bring to 6.18.y and 6.19.y?
> > 
> > These only apply to 6.18.y, but not 6.19.y, so can you provide a working
> > backport for both?
> > 
> 
> It looks like 6.19.y already picked them up!

I thought so, but for some reason my tools couldn't find that.  Ah, it
was one of those "cherry picked from" drm nonsense patches.  Ugh, what a
mess, I don't know why my tools didn't notice this, normally it does for
the intel patches that show up in the tree like this.

Maybe something is busted on my end with the 6.19->7.0-rc1 transition
that my tools couldn't handle.  I thought I found all the corner cases
of that, but as it only happens every few years, odds are I missed
something somewhere...

Anyway, I'll go queue these two up for just 6.18, thanks.

greg k-h


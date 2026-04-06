Return-Path: <stable+bounces-233357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCoEOCZs02lxiAcAu9opvQ
	(envelope-from <stable+bounces-233357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 10:17:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 412203A22E3
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 10:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41979300F5DD
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C1A3101D4;
	Mon,  6 Apr 2026 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pw66QeSS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7F3311C1B;
	Mon,  6 Apr 2026 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775463453; cv=none; b=WPxlZ0IMKGVVB+te5Gzx+K5KGy/J5meEt2nzz0qhmhCtJB+NNEBXMQs/temF5YSBkm6IfYD9Qgw697oosdSBlFoDh+y8YRgYuQ7gewyt6WqVlZoOOSGCjedObUxjsjYp9IW6Wh7i+8dKGQFoeJYfSTPX3FYhUyWPHJDzFIiJcEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775463453; c=relaxed/simple;
	bh=xUs+90y5FAnKMN1Wnt/wVKG65eqRgmIUfipA9j8ov+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZZLQ9vwhG6QWD1o/ZcaM+OcGRhMJdTNaK2fn80bht7Jn7wowmVtP/SuFokmIkcmMnIp9+u24zzX0JKOHGqPEoVuVxioUxUHoBDoIyOIVgPStZ8JsnMyMeOj1IzcMosDFHQ0/3OJhBn14Exi7/6bXE2Igro12AMuhNdAxMmSHOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pw66QeSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5A2C4CEF7;
	Mon,  6 Apr 2026 08:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775463453;
	bh=xUs+90y5FAnKMN1Wnt/wVKG65eqRgmIUfipA9j8ov+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pw66QeSSV0OJYpQYUkc8tfsakgO/6joQ0alygYjATNwg84mEDm+gNoCNhi0i1BLAP
	 vhjy8Cy8cIH+5u3oFSS3eKPuk53iqpRs7YoR5IYQqXmNyS0b7HJ/hWCl+SKUMornAZ
	 LK2Umq4hpvtMpwyU5VpNz1LFTn6zrTnd64LNby5E=
Date: Mon, 6 Apr 2026 10:17:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matt Fagnani <matt.fagnani@bell.net>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Warnings and errors in drm_mode_config_cleanup when booting
 6.19.10 and 7.0-rc5
Message-ID: <2026040609-script-perpetual-16bb@gregkh>
References: <a8f058b3-ea2c-4af1-a19b-9ae2db46754c@bell.net>
 <9652ce0b-bb4c-489d-9e32-89c5af5c8101@leemhuis.info>
 <2026040259-glacial-reversal-9a75@gregkh>
 <35ed8f9a-66c2-40c3-a545-da4af629014f@bell.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35ed8f9a-66c2-40c3-a545-da4af629014f@bell.net>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[bell.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-233357-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,lwn.net:url]
X-Rspamd-Queue-Id: 412203A22E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 03:54:39AM -0400, Matt Fagnani wrote:
> On 2026-04-02 08:12, Greg KH wrote:
> > On Sat, Mar 28, 2026 at 11:52:48AM +0100, Thorsten Leemhuis wrote:
> > > Matt, thx for the report.
> > > 
> > > On 3/28/26 11:30, Matt Fagnani wrote:
> > > > I could try to bisect. The commit
> > > > e493c135980f90c20308d1a98f2e0d1223951e94 drm: Fix use-after-free on
> > > > framebuffers and property blobs when calling drm_dev_unplug was included
> > > > in 6.19.10 and changed drm_mode_config_cleanup https://git.kernel.org/
> > > > pub/scm/linux/kernel/git/stable/linux.git/commit/?
> > > > h=linux-6.19.y&id=e493c135980f90c20308d1a98f2e0d1223951e94
> > > Did a quick search. Turns out this is mainline commit 6bee098b914176
> > > ("drm: Fix use-after-free on framebuffers and property blobs when
> > > calling drm_dev_unplug") -- and when searching for that (FWIW, this is
> > > not widely known, but that is really helpful in case like this, as the
> > > mainline commit id is way more relevant) is turns out that is in the
> > > process of getting reverted:
> > > 
> > > See https://lore.kernel.org/all/20260326082217.39941-2-dev@lankhorst.se/
> > > or 45ebe43ea00d6b ("Revert "drm: Fix use-after-free on framebuffers and
> > > property blobs when calling drm_dev_unplug"") [next-20260327
> > > (pending-fixes)].
> > > 
> > > Sasha and Greg: you might want to make sure to pick this up.
> > When it shows up in a Linus-released kernel, can someone remind us?
> > 
> > thanks,
> > 
> > greg k-h
> 
> 7.0-rc7 https://lwn.net/Articles/1066405/ had the patch Revert "drm: Fix
> use-after-free on framebuffers and property blobs when calling
> drm_dev_unplug" https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v7.0-rc7&id=45ebe43ea00d6b9f5b3e0db9c35b8ca2a96b7e70 Thanks.

Does not apply on 6.6.y or 6.1.y, so can someone provide a working
backport for those branches?

thanks,

greg k-h


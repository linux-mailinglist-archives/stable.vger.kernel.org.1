Return-Path: <stable+bounces-248983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNHHCEQ+CGoUgAMAu9opvQ
	(envelope-from <stable+bounces-248983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 11:52:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E1F55AF89
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 11:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6342D3006205
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3716C19B5B1;
	Sat, 16 May 2026 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Do3ffFL4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF310405C31;
	Sat, 16 May 2026 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778925116; cv=none; b=rleyYxM5bw/Rh8vFE7uMyzGZMhqw22/rg7/sd0CksGjA5/KgrxBx5+sr4ySKCvugzUctuvtUGdK0CIY4+0GyBvlF30DzA5gJp3d/6Sd1FawCjamW8glACt+wA8bz2B/ElZ0/h8U0qWdg2iABgLn3wm2sbf0HmovtCD0oWVgqvvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778925116; c=relaxed/simple;
	bh=BUSSURdgLQ4YIhYewunrGBSH8jEmDTjnZ5bx7//RKTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fC5pnYLpPAj9712jWjQzqnAf/nm7J/v/11vX0P9q1Dwygpautqqdv94/o3aLPWkoJ1oLzVJUjXozlCVGnmHrgHHPM0mqYowq9u2UWRPlQ71SbdRzQkpHHrbmQCvj39BlVZK/MFZNxyZrMI6B4OiwrhqbqeWP3TG0d9iKQz/Uzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Do3ffFL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A45C19425;
	Sat, 16 May 2026 09:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778925115;
	bh=BUSSURdgLQ4YIhYewunrGBSH8jEmDTjnZ5bx7//RKTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Do3ffFL45gZaMeh3qIm+wGMso7ZmQxL7Ss8PiQoU9Sr7W2vGtmPs6gnqidpTwuCX/
	 AqcYWLKNQQCHHVXO7OhRFlzIkH53eVUtv/ORPnUxDRnRTLFmwHf0YhI4UHfkfsFRz0
	 JkBA1oPR0ox/fv4utXvt2eGFVFXlRNmpyI+4BHJw=
Date: Sat, 16 May 2026 11:51:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: w15303746062 <w15303746062@163.com>
Cc: louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, simona@ffwll.ch,
	melissa.srw@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: Re: [PATCH 6.18.y] drm/vkms: Fix ABBA deadlock in vblank disable
 and timer callback
Message-ID: <2026051633-skyward-parrot-cdd3@gregkh>
References: <20260515131826.388154-1-w15303746062@163.com>
 <2026051557-thermal-petite-7da0@gregkh>
 <581657f0.ba8.19e2eaaf003.Coremail.w15303746062@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <581657f0.ba8.19e2eaaf003.Coremail.w15303746062@163.com>
X-Rspamd-Queue-Id: 20E1F55AF89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248983-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[bootlin.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,suse.de,lists.freedesktop.org,vger.kernel.org,stu.xidian.edu.cn];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email,kroah.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 16, 2026 at 10:43:35AM +0800, w15303746062 wrote:
> 
> Hi Greg,
> 
> Thanks for the quick response and review.
> 
> 
> At 2026-05-15 23:09:46, "Greg KH" <greg@kroah.com> wrote:
> >On Fri, May 15, 2026 at 09:18:26PM +0800, w15303746062@163.com wrote:
> >> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> >> 
> >> [Note: This patch addresses a legacy VKMS implementation deadlock specific
> >> to older stable trees (e.g., 6.18.y). Mainline has removed this code during
> >> the generic DRM_CRTC_VBLANK_TIMER_FUNCS refactoring.]
> >
> >Why not apply those upstream commits here as well?  No need to diverge
> >from Linus's tree, otherwise we will end up having a mess that nothing
> >can ever be backported to.
> >
> >How many commits need to be backported?  Have you tried?
> 
> I have looked into the upstream commits. The commit that removed this 
> vulnerable legacy code in mainline is:
> 02e2681ffe1a ("drm/vkms: Convert to DRM's vblank timer")
> 
> I tried to apply it to 6.18.y, but it does not apply cleanly. The reason 
> is that this upstream commit is not a simple bug fix, but a massive 
> refactoring. It completely rips out the custom VKMS hrtimer and ports 
> the driver to a newly introduced DRM core infrastructure 
> (DRM_CRTC_VBLANK_TIMER_FUNCS and drm_vblank_helper.h).
> 
> To backport commit 02e2681ffe1a, we would first need to backport the 
> entire DRM generic vblank timer infrastructure to 6.18.y. This seems 
> too intrusive and violates the minimal-risk policy for stable trees.

There is no "minimal-risk policy for stable trees".  And if there was,
the least ammount of risk would be to take the reviewed and tested
patches that are already in Linus's tree, and NOT take anything that is
not already there, as 90% of the time that we do that, it comes back to
bite us hard.

So please, just backport all the needed changes here.  Otherwise how are
we going to deal with the merge conflicts for the next 4 years in this
file?

Or, get the maintainers of this file to agree and review this one-off
change that it is acceptable.  As they are going to be the ones getting
the bug reports and not having their patches applied over the years, not
anyone else :)

thanks,

greg k-h


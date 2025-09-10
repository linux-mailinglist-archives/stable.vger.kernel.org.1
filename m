Return-Path: <stable+bounces-179189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5521B5148C
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 12:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8169B3A8541
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F3C3126DA;
	Wed, 10 Sep 2025 10:52:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D4303A1A;
	Wed, 10 Sep 2025 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501579; cv=none; b=M9QD/jiKwcq5o+j5L1w16o5fo9jJR/ycbwZy1qqf0rq786/WJhV2Fxq3wBWy+vgIPPGChXWUo0e6gI27e410amdhsTo+wXmX2G8zXRCGG4LkkMHw9O3Bl7B+0Zsu+MF23Z6wtt6f9Zo+yQ+Eqhkb21Q6dAzGSWf8VD7EYWihEYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501579; c=relaxed/simple;
	bh=M2tVr9V7sTtDbdHpdZaBkHBTk5Cpio2uctKlvKnJzwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcpX+ZPKjpF9sOjK8RCHiEZ+dyBopGOgNZ6a5YDmrah77cMXRyaIAK8HzpWQZC9kcqhs21IHWrrimRY0uMZi2wCWsJWyRPHVfNjJxjbtim4WjlMmox1N1jaTOpqYwTLLlcUfwGT0rrglHjYy4BUHbmkIFekIMoMnMSYtFcwmYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Wed, 10 Sep 2025 12:52:41 +0200
From: Brett A C Sheffield <bacs@librecast.net>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Yongzhen Zhang <zhangyongzhen@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/1] Revert "fbdev: Disable sysfb device registration
 when removing conflicting FBs"
Message-ID: <aMFYeV4UdD7NnrSC@karahi.gladserv.com>
References: <20250910095124.6213-3-bacs@librecast.net>
 <20250910095124.6213-5-bacs@librecast.net>
 <87frcuegb7.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frcuegb7.fsf@minerva.mail-host-address-is-not-set>

On 2025-09-10 12:46, Javier Martinez Canillas wrote:
> Brett A C Sheffield <bacs@librecast.net> writes:
> 
> Hello Brett,
> 
> > This reverts commit 13d28e0c79cbf69fc6f145767af66905586c1249.
> >
> > Commit ee7a69aa38d8 ("fbdev: Disable sysfb device registration when
> > removing conflicting FBs") was backported to 5.15.y LTS. This causes a
> > regression where all virtual consoles stop responding during boot at:
> >
> > "Populating /dev with existing devices through uevents ..."
> >
> > Reverting the commit fixes the regression.
> >
> > Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
> > ---
> 
> In the other email you said:
> 
> > Newer stable kernels with this
> > patch (6.1.y, 6.6.y, 6.12,y, 6.15.y, 6.16.y) and mainline are unaffected.
> 
> But are you proposing to revert the mentioned commit in mainline too
> or just in the 5.15.y LTS tree ?

Only the 5.15.y tree. Sorry - that could have been clearer.  There's no
regression anywhere else. Mainline and other stable kernels are all ok.

Cheers,


Brett


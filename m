Return-Path: <stable+bounces-86836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A529A411E
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 16:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA321C21665
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A651DED5B;
	Fri, 18 Oct 2024 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nK6h7Xu8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392620E327
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261578; cv=none; b=fslbdWB9jRrWKxkmNQ56YzrXAt3ewybCJDfmfJYkXRKOSQo1UpmLh5eMDJ4VHdr8CnUeiYocS5odoKvUa1OF3hyFeGrJ5iOv4SX9SoUp1sMbU5WGjc1CwF3u3nzweBx4wPsMXhqKAWTOx88jwAVvxMTE3bl3NTPCo3hh4B2M4xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261578; c=relaxed/simple;
	bh=vDD6iYhS1iqNnjH+D3mvpaz/Ec92uDIKZsWOKfNw7so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZFJd8SMCRKDEzoUiD21qy0BGwfrv8/AaeQHHT76nb8B3il78cVe1YMBcRST0C3+LT5/2i7SUHKPuN+R7Y5WNDEPMljAsoIuXTbKKh/v1wCy+CwWB4P9CAbetnBwpr9KmC/OvgHlBrM74USuZ3UMCHzGFrzt1OU7XgtJ261h1HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nK6h7Xu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE43C4CEC3;
	Fri, 18 Oct 2024 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729261577;
	bh=vDD6iYhS1iqNnjH+D3mvpaz/Ec92uDIKZsWOKfNw7so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nK6h7Xu8IXhjbbKJ4bbkKf3B7iSU61zvyMPFBoWsw5BjYwFRe7thoJycBkyTV8chM
	 +QQPuDeydqwN3kFYKyYM/IFwf/rssmU4+BWDylWBlw6U2seHeHEwv6GiRsm9lGAGMg
	 W3IHUjFyeO1fSCzMMf9NZrf1vt51RDOUMzezSlrs=
Date: Fri, 18 Oct 2024 16:26:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: He Zhe <zhe.he@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10] gfs2: Fix potential glock use-after-free on unmount
Message-ID: <2024101811-reporter-prong-bcd7@gregkh>
References: <20241018135428.1422904-1-zhe.he@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018135428.1422904-1-zhe.he@windriver.com>

On Fri, Oct 18, 2024 at 09:54:24PM +0800, He Zhe wrote:
> From: Andreas Gruenbacher <agruenba@redhat.com>
> 
> commit 0636b34b44589b142700ac137b5f69802cfe2e37 upstream.

Why are you sending this only for 5.10 when newer kernel trees do not
have it?  As the documentation says, we can't take changes only for old
kernels, as when you upgrade, you would have a regression.

Please send patches for all relevent kernel trees and we will be glad to
review them.

Also, please always cc: all of the developers involved in the patch, so
they know what is going on.

And:

> Fixes: fb6791d100d1b ("GFS2: skip dlm_unlock calls in unmount")
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: David Teigland <teigland@redhat.com>
> 
> CVE: CVE-2024-38570
> 

No blank lines please.

And no need for the "CVE:" tag as our tools already call out what commit
ids are for what CVE, don't duplicate it again here.

> [Zhe: sd_glock_wait in gfs2_glock_free_later is not renamed to
> sd_kill_wait yet. So still use sd_glock_wait in gfs2_glock_free_later in
> this case.]
> 

Again, no blank line.

Please fix this up for all of these patches and resubmit series for all
relevant branches.  I've dropped these from my queue now.

thanks,

greg k-h


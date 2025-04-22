Return-Path: <stable+bounces-135048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2148FA95FA7
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 09:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB4FB7A7F38
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 07:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACED01DF751;
	Tue, 22 Apr 2025 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zsdS3oNM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF0B524C
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307584; cv=none; b=kHR/aROcG26k4pmdHMdzBCpqVEP1eqkxIwneGrgO8Iz0wVo5yGHVpwmf22SSLv65aIYgwoX6CSjuhiQ1Pcm8FNhfTf7NhgqEki6otzeSMIyzGKLvmb4jNKHSyK5tiVVDNcQ4YYkDnnAhm5dIZxNkMWtpllAZNm6ESFWtzumKock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307584; c=relaxed/simple;
	bh=LWMSEsNSWj2UXudU+OgquJpYzD62Waw8PkXBCAd+2XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwOr87wWcgsIRv3tRaOapa4FmDAnmOHOqBxAg6vLB0WNI3CciFx2DoIugV4y16WHh0eHyR4rlyo17Z56W6MUsYAcFc+IFtRsaZbV6brtjhOB+TGa0Ge2yQZIRUtRi8UxUQ4y1BkqNDOsT0UiWt9uUM4w4Ba7B1JF1FPpQ5PyCXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zsdS3oNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746FEC4CEE9;
	Tue, 22 Apr 2025 07:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745307583;
	bh=LWMSEsNSWj2UXudU+OgquJpYzD62Waw8PkXBCAd+2XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zsdS3oNMowc5p1cy1Fj7m42bLMejUY6+JZMdRtr8ObEwrAAUZvdhLuIqoCL/sMpev
	 73yOPbEhK3Eb/LAPs6JKz8R3qHtntyKss3wPr9lzlAql8sUzvn4c/6peu/3G0ii8tc
	 rSXLYx1T+/roH5+2tPneHCdKxob1OtRmeToJvitc=
Date: Tue, 22 Apr 2025 09:39:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: ilpo.jarvinen@linux.intel.com, lkml@antheas.dev, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] platform/x86: msi-wmi-platform:
 Workaround a ACPI firmware" failed to apply to 6.12-stable tree
Message-ID: <2025042201-botanist-hassle-a21b@gregkh>
References: <2025042139-decimeter-dislike-3ca4@gregkh>
 <c479afca-a994-4a65-a7c5-7fb53b2d38e9@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c479afca-a994-4a65-a7c5-7fb53b2d38e9@gmx.de>

On Tue, Apr 22, 2025 at 12:07:23AM +0200, Armin Wolf wrote:
> Am 21.04.25 um 16:03 schrieb gregkh@linuxfoundation.org:
> 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x baf2f2c2b4c8e1d398173acd4d2fa9131a86b84e
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042139-decimeter-dislike-3ca4@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> > 
> > Possible dependencies:
> 
> Hi,
> 
> this patch depends on 912d614ac99e ("platform/x86: msi-wmi-platform: Rename "data" variable"). I thought that i signaled that
> by using the "Cc: stable@vger.kernel.org # 6.x.x:" tag.
> 
> Where did i mess up?

You didn't, I missed that, sorry.

I've fixed this up for 6.12.y and 6.14.y, but both of these commits do
not apply to 6.6.y at all (filenames are wrong.)

Please send backports for 6.6.y if you want to see the commit there.

thanks,

greg k-h


Return-Path: <stable+bounces-23745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0751B867E10
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 18:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29A71F2CFFC
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 17:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BDE12F368;
	Mon, 26 Feb 2024 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ByQIpJxH"
X-Original-To: stable@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563EA12EBDE
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967784; cv=none; b=j8XRPtkGKfJoDYsRlHGWepH62BKfOREQ4daFlq2Bur0Hk2VRC79TnMagUonBii7BALUS0nOUbaXyEfHI4UQnBoBUsk75H/XMM7jwbCt/eXe89GsDcsDK+TZk3QmyzcnOO+Lk7gkUVCRl58f/EjwFT95XETPij6MrCOB8C7z3YwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967784; c=relaxed/simple;
	bh=oE8hrpoUSR9N67ZJZXv3erGxT2tzDmf9YxuB+DY4Wss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsrPIy5/lzmQh389ds9qpnfcp67A+TDqf7aF3+9+CxAN2jzu0HKhIOqdA0t/SwqVnzuCVvBYC8jUueooGlOBk/yNfuKwwdO6jeVJv879LEA7FrTTc5ruaLWuREsxE65Z/HJpvix+ce4IamJkpWSqnHyAKz9Qs5ew5FjpAYtlaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ByQIpJxH; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tk6hz36YLzMq1N3;
	Mon, 26 Feb 2024 18:16:19 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tk6hy5x0KzMpnPs;
	Mon, 26 Feb 2024 18:16:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708967779;
	bh=oE8hrpoUSR9N67ZJZXv3erGxT2tzDmf9YxuB+DY4Wss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ByQIpJxHSGgdthDGkZsHgkIajVMAPN9ctSDwfU4e9sd4231s+G/sTgW6XXXwu0C2a
	 nv524ywUOinsIC/TRRPPcIrN4c+EcCGNz2TxguG4qEYDgkRNC3W3r+5zwwT5J5JrLr
	 /3OrmT/Y5n1Dgmtf8zFBK0GmQmpMPXhbi4qYc/2s=
Date: Mon, 26 Feb 2024 18:16:10 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <keescook@chromium.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Shervin Oloumi <enlightened@chromium.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] landlock: Warn once if a Landlock action is requested
 while disabled
Message-ID: <20240226.wu2ageiPi6Ch@digikod.net>
References: <20240219191804.2978911-1-mic@digikod.net>
 <202402191304.ED03339B@keescook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202402191304.ED03339B@keescook>
X-Infomaniak-Routing: alpha

On Mon, Feb 19, 2024 at 01:07:48PM -0800, Kees Cook wrote:
> On Mon, Feb 19, 2024 at 08:18:04PM +0100, Mickaël Salaün wrote:
> > Because sandboxing can be used as an opportunistic security measure,
> > user space may not log unsupported features.  Let the system
> > administrator know if an application tries to use Landlock but failed
> > because it isn't enabled at boot time.  This may be caused by bootloader
> > configurations with outdated "lsm" kernel's command-line parameter.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 265885daf3e5 ("landlock: Add syscall implementations")
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  security/landlock/syscalls.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > index f0bc50003b46..b5b424819dee 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> > @@ -33,6 +33,18 @@
> >  #include "ruleset.h"
> >  #include "setup.h"
> >  
> > +static bool is_not_initialized(void)
> > +{
> > +	if (likely(landlock_initialized))
> > +		return false;
> > +
> > +	pr_warn_once(
> > +		"Disabled but requested by user space. "
> > +		"You should enable Landlock at boot time: "
> > +		"https://docs.kernel.org/userspace-api/landlock.html#kernel-support\n");
> 
> Perhaps update this docs to be really explicit with a example, maybe...
> 
> If `landlock` is not present in `CONFIG_LSM`, you can add it. For
> example, if this was the current config::
> 
>   $ zgrep -h ^CONFIG_LSM= /boot/config-$(uname -r) /proc/config.gz 2>/dev/null
>   CONFIG_LSM="lockdown,yama,integrity,apparmor"
> 
> You can boot with::
> 
>   lsm=landlock,lockdown,yama,integrity,apparmor
> 

Indeed, I'll send a dedicated patch and update the link accordingly.

> 
> I *still* wish we had the "+" operator for lsm=. It would be SO much
> easier to say "boot with lsm=+landlock". *shrug*

I guess it's still possible and it would need to be backported to be
more useful.

> 
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -- 
> Kees Cook
> 


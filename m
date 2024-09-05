Return-Path: <stable+bounces-73641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3255696DFA4
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 18:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E40A1C2364E
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 16:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3051A01B7;
	Thu,  5 Sep 2024 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OpoWgOQC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5F719FA7B
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553802; cv=none; b=azpRDnGYvaMD67LZvbn/jLc107MZhOEl46bV4YPdKrckHN4GJ35BXcFA+TIX/BmDEr5MgiBV8tNxOK83Qcm4UviNY7s+HuMFpUFV6YK5r4NDcEQwalDjGdy+UM74HJuNXay8RzSkqcn1H6ChyM3CbXsn2CJkosmtHKhGmLhVVvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553802; c=relaxed/simple;
	bh=xWDZEJKCAOe9ljWrApkLr4zWbHZ3imYeYtkkE7/qmow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCNsQwahb9Jb4uCLSnW/iI47hxPM9xmuyRRcCkzimlPYXn2o13HYDyYWHpkwks+oE6o3ZlSs8ArmrlUBYt7Bd145vwrv4nTTYCGWxzPid6PsZ2p9ikEoh9Lcf31VvC0+NaZy3HC7n/Izvi4HgY+IRmCa0ARO+9NjBTSK8uJHBRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OpoWgOQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C97BC4CEC9;
	Thu,  5 Sep 2024 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725553802;
	bh=xWDZEJKCAOe9ljWrApkLr4zWbHZ3imYeYtkkE7/qmow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OpoWgOQCa16Xdi7mKlJQjlw0p5ax0qvKQkA2p9M4w+Xyy7nUPXp8i4UDzSzRwCK1d
	 PpPJg3Qc7zy4cNm5ZNLhXCUeLj1L12OhTItLO3nvPJHrAj9yZyp2EG6a+K9d/itTC8
	 q1tFL1PkzWvjQoy+1XaqGra3OQYWOlZ1FygIPfPI=
Date: Thu, 5 Sep 2024 18:29:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Hillf Danton <hdanton@sina.com>, alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2 4.19.y] ALSA: usb-audio: Sanity checks for each pipe
 and EP types
Message-ID: <2024090535-drinking-unsocial-6170@gregkh>
References: <76c0ef6b-f4bf-41f7-ad36-55f5b4b3180a@stanley.mountain>
 <599b79d0-0c0f-425e-b2a2-1af9f81539b8@stanley.mountain>
 <2adfa671-cb11-4463-8840-a175caf0d210@stanley.mountain>
 <2024090557-hurry-armful-dbe0@gregkh>
 <747a6089-b63d-4d14-b524-55a76f58d724@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <747a6089-b63d-4d14-b524-55a76f58d724@stanley.mountain>

On Thu, Sep 05, 2024 at 06:11:49PM +0300, Dan Carpenter wrote:
> On Thu, Sep 05, 2024 at 03:49:14PM +0200, Greg KH wrote:
> > On Thu, Sep 05, 2024 at 04:34:45PM +0300, Dan Carpenter wrote:
> > > Sorry,
> > > 
> > > I completely messed these emails up.  It has Takashi Iwai and Hillf Danton's
> > > names instead of mine in the From header.  It still has my email address, but
> > > just the names are wrong.
> > > 
> > > Also I should have used a From header in the body of the email.
> > > 
> > > Also the threading is messed up.
> > > 
> > > Will try again tomorrow.
> > 
> > It looks good to me, now queued up.
> > 
> 
> The code is okay but the Author header is messed up.  It has my email address.
> 
> From: Hillf Danton <dan.carpenter@linaro.org>
> 
> From: Takashi Iwai <dan.carpenter@linaro.org>

Ah that's really odd, how did you do that?  :)

Now fixed up in the patches, don't worry about it.

greg k-h


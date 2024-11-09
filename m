Return-Path: <stable+bounces-92013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDBC9C2DF1
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 15:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902831F21A09
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 14:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B55B1990C9;
	Sat,  9 Nov 2024 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1aSIgGwP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F36B1990B7;
	Sat,  9 Nov 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731164284; cv=none; b=dSUhUREj7QcLkD/+vJnP+2MYLGPRzDIo+kbsq01DxYexXvaz2t3upVm3SC9Z0Z+lpfXtZdfd5d5dgu6+bXI2W24boRSIPTkRz1JdMljft15Mtape5vTIv4Bals08Rbx6AqvSL2faVO9GJYL/HA3TzvEHwmbI5dgzhW7vM+LLgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731164284; c=relaxed/simple;
	bh=jrxlXYLbSuamZOrLkU/W2eD/y8bk3qDW3IvKIPqgfiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5LGVrGBd+Bg3g4FicEr38CVqvwnZxk0sztaxQIzXaWqwYr0Orveza/PljHzjFWw7WCQC5ymh8s1pJxyxusL1/O2xVur9ORoPUyPdv4qLuYEWiv4ZkWPvJCAkVvzFHPEAwlPVhGdcFQko0FNLFkTkvmEkL7OR5Ag4IQpHTh2X4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1aSIgGwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC45C4CED5;
	Sat,  9 Nov 2024 14:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731164283;
	bh=jrxlXYLbSuamZOrLkU/W2eD/y8bk3qDW3IvKIPqgfiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1aSIgGwPkVQE3vsr3I9JL6uzs/MIuxyPYvPjWecjYwZQ5CRrtWy8M8HtlASMZjdb3
	 TD2mDdi0uTfOkL5rydBIjsLD+1Ca45sYWBgA7cW+PoBPPkExoGhkdjZ8q8L/166vIW
	 eI+7DM93z9A6jLV/UrGWrE9OBsDFlhvlW9+VHCKM=
Date: Sat, 9 Nov 2024 15:58:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Christoffer Sandberg <cs@tuxedo.de>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] ALSA: hda/realtek: Fix headset mic on TUXEDO
 Gemini 17 Gen3
Message-ID: <2024110938-graffiti-equity-2c07@gregkh>
References: <20241106021124.182205-1-sashal>
 <20241106094920.239972-1-wse@tuxedocomputers.com>
 <2024110606-expansion-probing-862b@gregkh>
 <b768433e-c146-46af-a077-3e2631a4c292@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b768433e-c146-46af-a077-3e2631a4c292@tuxedocomputers.com>

On Wed, Nov 06, 2024 at 11:51:16AM +0100, Werner Sembach wrote:
> Hi
> 
> Am 06.11.24 um 11:42 schrieb Greg KH:
> > On Wed, Nov 06, 2024 at 10:49:04AM +0100, Werner Sembach wrote:
> > > From: Christoffer Sandberg <cs@tuxedo.de>
> > > 
> > > Quirk is needed to enable headset microphone on missing pin 0x19.
> > > 
> > > Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> > > Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> > > Cc: <stable@vger.kernel.org>
> > > Link: https://patch.msgid.link/20241029151653.80726-1-wse@tuxedocomputers.com
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >   sound/pci/hda/patch_realtek.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > What is the git commit id of this in Linus's tree?
> 
> 0b04fbe886b4274c8e5855011233aaa69fec6e75
> 
> Is there a specific format/tag to add it to the commit? something like
> "Mainline-commit: <hash>". Didn't find anything in the documentation.

anywhere a normal 'git cherry-pick -x' would put it is good.

thanks,

greg k-h


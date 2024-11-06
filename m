Return-Path: <stable+bounces-90103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4A09BE47B
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 11:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98731F22F99
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 10:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33381DE2BB;
	Wed,  6 Nov 2024 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bqc1LXIx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867711D1753;
	Wed,  6 Nov 2024 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889762; cv=none; b=IulPDnUWSKkIpjD5zAyoC/IDOvcU0sxnGpt0UwfsjPMOvCc7i1CjDti/iy0G1rEeI6jKgbqL5hWH4Y7AD0qdlnkP31G/c6H21t4YsnyBk0s26kvkD7QfT0MdOBJwfuEqznX1fq8qTZP1fld+y/4BOfmlL5RFfauYLDOx7fUHYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889762; c=relaxed/simple;
	bh=va2r5fP+7Fzh0b/uBhAyLj4tamsES4F99tp95aSz8zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGPkLoeTzYCrl7chfnwKsms12zvAc1oNF8ePJaxsoaAGjDHZpE6AMSiBCtAOXcvGgXx9Mv63W/oly4A2Kl3dV6kx3xuFUz1YQWczoj3KK72e0McsKKNQlCy5uwHVBKRdyAWrFKtFnVcoSyYjeEp+qQ8/Xiuv3gq1/WWISpFUjoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bqc1LXIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52BEC4CECD;
	Wed,  6 Nov 2024 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730889762;
	bh=va2r5fP+7Fzh0b/uBhAyLj4tamsES4F99tp95aSz8zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqc1LXIxEXjyhn4vHZm90Npd3Kixa4u4JFIpZnz/kgJFbfu/El4NNHFARGRQsT0cO
	 nTfU7dyJTmrVXWnyxJ0RJuMdNYAn5N+xPj/kpvRSHVzgBt61iPa0RyB8rO2TZyc6fm
	 aq+r8yQErrqdpg6tFNXP7D8L8UrZnpnxOXmyHK8E=
Date: Wed, 6 Nov 2024 11:42:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Christoffer Sandberg <cs@tuxedo.de>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] ALSA: hda/realtek: Fix headset mic on TUXEDO
 Gemini 17 Gen3
Message-ID: <2024110606-expansion-probing-862b@gregkh>
References: <20241106021124.182205-1-sashal>
 <20241106094920.239972-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106094920.239972-1-wse@tuxedocomputers.com>

On Wed, Nov 06, 2024 at 10:49:04AM +0100, Werner Sembach wrote:
> From: Christoffer Sandberg <cs@tuxedo.de>
> 
> Quirk is needed to enable headset microphone on missing pin 0x19.
> 
> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: <stable@vger.kernel.org>
> Link: https://patch.msgid.link/20241029151653.80726-1-wse@tuxedocomputers.com
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)

What is the git commit id of this in Linus's tree?

thanks,

greg k-h


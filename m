Return-Path: <stable+bounces-161642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB88B01A49
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 13:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F272A171B57
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC07288C0E;
	Fri, 11 Jul 2025 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eZxvBjHG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B3DA920;
	Fri, 11 Jul 2025 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232019; cv=none; b=RTpkjzYzNf/eISqL92RyRolXIelBBBZUrhAgxlAKdneeeDWBVCr1ITA7llQh8c0Hixz8pKR7L7EMNQyRz92R2hiBdOiSYMLAcPfEGAOL2nFYm7NQnHh9f/rIE4k0qJ1sgivuH8C6nk9u/28z25Z2dGTDHaDuMH58eaVz4F22SOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232019; c=relaxed/simple;
	bh=Kl2wwYKdxu5dO7rsNvg4pv2nYckocqnXAX9CLaLs6Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQfkCBCV2qC/prjUXTQNRf0AO8LbEYRkDiu8bENcb6l4R2wUryewRhsmy72w9EghIss0ntk2830HQa1piT99tlzyQDiBuYLHi9355aMjiTflTMYqeyaWDH8fZ6erQ/QcG69Drb5IU9abcnhbIeQzUGZMU9OhOSe+XFO23W2nVS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eZxvBjHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AEBC4CEED;
	Fri, 11 Jul 2025 11:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752232018;
	bh=Kl2wwYKdxu5dO7rsNvg4pv2nYckocqnXAX9CLaLs6Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZxvBjHGhFTzXeoSzMjD1PFRDXjcTK9NUUhOyjVHlneK0KUhnJeUZC0OlIe1lfnfT
	 9tQldjor/7tGlCBaBbCHRYvg+xkQHDLp2v8RiTUGlyjo7QMq9u86hYOu3RdWe3kCJM
	 loQgC/oBAdSsejOshLkTVdB11kLQ3T0pdqVrdzZg=
Date: Fri, 11 Jul 2025 13:06:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] init: Handle bootloader head in kernel parameters
Message-ID: <2025071130-mangle-ramrod-38ff@gregkh>
References: <20250711102455.3673865-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711102455.3673865-1-chenhuacai@loongson.cn>

On Fri, Jul 11, 2025 at 06:24:55PM +0800, Huacai Chen wrote:
> BootLoader may pass a head such as "BOOT_IMAGE=/boot/vmlinuz-x.y.z" to
> kernel parameters. But this head is not recognized by the kernel so will
> be passed to user space. However, user space init program also doesn't
> recognized it.

Then why is it on the kernel command line if it is not recognized?

> KEXEC may also pass a head such as "kexec" on some architectures.

That's fine, kexec needs this.

> So the the best way is handle it by the kernel itself, which can avoid
> such boot warnings:
> 
> Kernel command line: BOOT_IMAGE=(hd0,1)/vmlinuz-6.x root=/dev/sda3 ro console=tty
> Unknown kernel command line parameters "BOOT_IMAGE=(hd0,1)/vmlinuz-6.x", will be passed to user space.

Why is this a problem?  Don't put stuff that is not needed on the kernel
command line :)

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  init/main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/init/main.c b/init/main.c
> index 225a58279acd..9e0a7e8913c0 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -545,6 +545,7 @@ static int __init unknown_bootoption(char *param, char *val,
>  				     const char *unused, void *arg)
>  {
>  	size_t len = strlen(param);
> +	const char *bootloader[] = { "BOOT_IMAGE", "kexec", NULL };

You need to document why these are ok to "swallow" and not warn for.


>  
>  	/* Handle params aliased to sysctls */
>  	if (sysctl_is_alias(param))
> @@ -552,6 +553,12 @@ static int __init unknown_bootoption(char *param, char *val,
>  
>  	repair_env_string(param, val);
>  
> +	/* Handle bootloader head */

Handle it how?

confused,

greg k-h


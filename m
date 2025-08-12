Return-Path: <stable+bounces-167092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E36B21A6F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 03:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB520682B07
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 01:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9542DBF5C;
	Tue, 12 Aug 2025 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uDzzi4Sq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284C32D780C;
	Tue, 12 Aug 2025 01:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754963800; cv=none; b=O//hTwa6uwMRPLwrEt3FqDi+EbzIGL/PXfP1TK43NO/H9OqOMtIy7r843qWKyWsz33FJ6OEoaVKNFAniz0gSVvrgSV//lFLgDSJR6YyPGdBtQ6ouN0Ptf8W2SHfZLa24ten93FObsxRsS+pMK5nMEmA3uxWL1zXF9bcqfSJgzZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754963800; c=relaxed/simple;
	bh=hBSK0PX+81rnA9LuOdB2E4A8PLVyJnCl/SZJxlw7J/k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PZEGWrEFxKj53eNbba6wnWEGRVNYiMqKvo/uoxnYhnD91q119iT7B6NvH5Qn/YwPMfEnpZIOUGu3+TWKEmG65X3g515eFSe8NFuzl4M4fMZw/DWdPXKVqmm2R72HzxI55XSJFGLQPLCi+OSCJMCvcDfiR93gx7HRkz5HhE93rRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uDzzi4Sq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C58AC4CEED;
	Tue, 12 Aug 2025 01:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754963796;
	bh=hBSK0PX+81rnA9LuOdB2E4A8PLVyJnCl/SZJxlw7J/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uDzzi4Sq54eB+bbub4G2BGLTrMaAicSK/MW8JNXopL5x7Kr80Dnosw4CTZX4m+qEH
	 lPxTDc06DtH4JEmUnm6uRfJoGU5c2eSXz+4iTpVUiUfRlWKp0qQZ4Ghf4GPkcjx9yK
	 e5XlbT8QjnxeGWGNdXv94N4B+EIYlSdg+lkFp0PU=
Date: Mon, 11 Aug 2025 18:56:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, linux-mm@kvack.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH V3] init: Handle bootloader identifier in kernel
 parameters
Message-Id: <20250811185635.f51ddda72f36bc0c2ba20600@linux-foundation.org>
In-Reply-To: <20250721101343.3283480-1-chenhuacai@loongson.cn>
References: <20250721101343.3283480-1-chenhuacai@loongson.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 18:13:43 +0800 Huacai Chen <chenhuacai@loongson.cn> wrote:

> BootLoader (Grub, LILO, etc) may pass an identifier such as "BOOT_IMAGE=
> /boot/vmlinuz-x.y.z" to kernel parameters. But these identifiers are not
> recognized by the kernel itself so will be passed to user space. However
> user space init program also doesn't recognized it.
> 
> KEXEC/KDUMP (kexec-tools) may also pass an identifier such as "kexec" on
> some architectures.
> 
> We cannot change BootLoader's behavior, because this behavior exists for
> many years, and there are already user space programs search BOOT_IMAGE=
> in /proc/cmdline to obtain the kernel image locations:
> 
> https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/util.go
> (search getBootOptions)
> https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/main.go
> (search getKernelReleaseWithBootOption)
> 
> So the the best way is handle (ignore) it by the kernel itself, which
> can avoid such boot warnings (if we use something like init=/bin/bash,
> bootloader identifier can even cause a crash):
> 
> Kernel command line: BOOT_IMAGE=(hd0,1)/vmlinuz-6.x root=/dev/sda3 ro console=tty
> Unknown kernel command line parameters "BOOT_IMAGE=(hd0,1)/vmlinuz-6.x", will be passed to user space.
> 
> Cc: stable@vger.kernel.org

I think I'll keep this in -next until 6.18-rc1 - I suspect any issues
here will take a while to discover.

> --- a/init/main.c
> +++ b/init/main.c
> @@ -545,6 +545,12 @@ static int __init unknown_bootoption(char *param, char *val,
>  				     const char *unused, void *arg)
>  {
>  	size_t len = strlen(param);
> +	/*
> +	 * Well-known bootloader identifiers:
> +	 * 1. LILO/Grub pass "BOOT_IMAGE=...";
> +	 * 2. kexec/kdump (kexec-tools) pass "kexec".
> +	 */
> +	const char *bootloader[] = { "BOOT_IMAGE=", "kexec", NULL };
>  
>  	/* Handle params aliased to sysctls */
>  	if (sysctl_is_alias(param))
> @@ -552,6 +558,12 @@ static int __init unknown_bootoption(char *param, char *val,
>  
>  	repair_env_string(param, val);
>  
> +	/* Handle bootloader identifier */
> +	for (int i = 0; bootloader[i]; i++) {
> +		if (!strncmp(param, bootloader[i], strlen(bootloader[i])))
> +			return 0;
> +	}

We have str_has_prefix().

And strstarts()!  Both of which are awfully similar and both of which
lamely do two passes across a string.


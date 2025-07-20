Return-Path: <stable+bounces-163460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B1DB0B55F
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 13:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B741743FC
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 11:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7C91F03C9;
	Sun, 20 Jul 2025 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZJxe0xae"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD253FE5;
	Sun, 20 Jul 2025 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753009854; cv=none; b=UKbV7AMLvDUgGQsIvIU2gsVt73UZK3VrqCAsAEm489xDtMbkwSQjmdcAj3VdQIN7StAeWgQx2X+5hLiA4AmK3WM4va/ChiXe9FskTqME/gwvrxxhSUlWa2oyVxBa0dGQ8IahkVRzplyr5YzKm8UoXFuxCoLkApgO1f2gbS8R1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753009854; c=relaxed/simple;
	bh=g6RN/P3+AMwSYEbq7xszkzjjlTYqV1BCTxY1zp2kC1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPC7fiKUySmFcyPVB18nvpY9Q1IK00AKA/4Wm+FLru8PFeoyUZhRXrx5zxucP4lnsGUBTN98bqMCqmkKEaPuXPS6sASbIJPLbnkhHYWr1SVas8WG853DxRJXSa0aZurWIa7ILqihJ0PLFdkfasTnzMzS4fxdM0THgU6CinOded0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZJxe0xae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DD1C4CEE7;
	Sun, 20 Jul 2025 11:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753009853;
	bh=g6RN/P3+AMwSYEbq7xszkzjjlTYqV1BCTxY1zp2kC1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJxe0xaek+yG2RCDWC3DwPKw0qX4OEHwwj5EnajXHuO6vPin1SWH/WW2T6XH55vcm
	 K4M6VKlDQXkahTKJ6dZDcojMXzuXPVuGFKch9Wtg1tshvv+bCZauvhcPltydPe72//
	 Qcgh9CB0QP+o9AZdw0d8I3ay34mV0bhZ5Z0NJwVE=
Date: Sun, 20 Jul 2025 13:10:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH V2] init: Handle bootloader identifier in kernel
 parameters
Message-ID: <2025072056-gambling-ranger-5b0f@gregkh>
References: <20250720105509.2914898-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720105509.2914898-1-chenhuacai@loongson.cn>

On Sun, Jul 20, 2025 at 06:55:09PM +0800, Huacai Chen wrote:
> BootLoader (Grub, LILO, etc) may pass an identifier such as "BOOT_IMAGE=
> /boot/vmlinuz-x.y.z" to kernel parameters. But these identifiers are not
> recognized by the kernel itself so will be passed to user space. However
> user space init program also doesn't recognized it.
> 
> KEXEC may also pass an identifier such as "kexec" on some architectures.
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
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Update comments and commit messages.
> 
>  init/main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/init/main.c b/init/main.c
> index 225a58279acd..c53863e5ad82 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -545,6 +545,7 @@ static int __init unknown_bootoption(char *param, char *val,
>  				     const char *unused, void *arg)
>  {
>  	size_t len = strlen(param);
> +	const char *bootloader[] = { "BOOT_IMAGE=", "kexec", NULL };

Where is this magic set of values now documented?  Each of these need to
be strongly documented as to why we are ignoring them and who is adding
them and why they can't be fixed for whatever reason.

thanks,

greg k-h


Return-Path: <stable+bounces-92211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4539C50A5
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 09:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20922280FB7
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 08:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CC520B21E;
	Tue, 12 Nov 2024 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y0ep3qpw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5039B20ADF3
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400276; cv=none; b=On5A622ttEMoSEbETl33zzAch8yDgmWeZLSIhUPzSHjgizg4/d8u8iMYCWTxNIeZBS0UEBUmZ9puAsMSE/jQv10dASvYCIAZZNBWm68ijy1gqlvBXEf8ByHClcnxY02LRUS342d0RbhWqJy8adDwC4zd+shjUJOnqbgR+a8KvO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400276; c=relaxed/simple;
	bh=H3HmAwWJqCzz2uTGl9LYnzZQboUbNuqFUc+i2U9j268=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Krd+fhQtnjolPS68GCJ8dxaRlAqSbooXQc4nfxokJJpuPCpPPWTVkW+8Bx1LAI+COQf3b73awbOJ5forctnQq+hamBPvOsG/j+rETbVgj88j6N1djhk9psw2DhGvixE2VzYK6pCDmXyFHdXED/GWMSSIKbjsrnlGEWdVucSaQBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y0ep3qpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7358FC4CECD;
	Tue, 12 Nov 2024 08:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731400275;
	bh=H3HmAwWJqCzz2uTGl9LYnzZQboUbNuqFUc+i2U9j268=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y0ep3qpw9hHJtnL4ILn/lsKxciB8mu9DfOfBIOGjfitDQ/VLZHt+A4aqoH+5UJQtR
	 oxNCQ/DFI45okjafiAxBkUCI79ns3+eJCzPQIFLNoejDPg1atjPu3ocV29vZeVCFAs
	 EOqiQnLST3xEzVCJ6TjnYguEEO76bhmID403TsdY=
Date: Tue, 12 Nov 2024 09:31:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: sashal@kernel.org, naresh.kamboju@linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.15] ACPI: PRM: Clean up guid type in struct
 prm_handler_info
Message-ID: <2024111205-mosaic-disdain-a4d0@gregkh>
References: <CA+G9fYtgOA-5y73G1YEixQ+OjmG=awBQjdKjK+b0qLNYvAAVpQ@mail.gmail.com>
 <20241111143730.845068-3-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111143730.845068-3-nathan@kernel.org>

On Mon, Nov 11, 2024 at 07:37:32AM -0700, Nathan Chancellor wrote:
> From: Dan Carpenter <dan.carpenter@linaro.org>
> 
> commit 3d1c651272cf1df8aac7d9b6d92d836d27bed50f upstream.
> 
> Clang 19 prints a warning when we pass &th->guid to efi_pa_va_lookup():
> 
> drivers/acpi/prmt.c:156:29: error: passing 1-byte aligned argument to
> 4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an
> unaligned pointer access [-Werror,-Walign-mismatch]
>   156 |                         (void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
>       |                                                  ^
> 
> The problem is that efi_pa_va_lookup() takes a efi_guid_t and &th->guid
> is a regular guid_t.  The difference between the two types is the
> alignment.  efi_guid_t is a typedef.
> 
> 	typedef guid_t efi_guid_t __aligned(__alignof__(u32));
> 
> It's possible that this a bug in Clang 19.  Even though the alignment of
> &th->guid is not explicitly specified, it will still end up being aligned
> at 4 or 8 bytes.
> 
> Anyway, as Ard points out, it's cleaner to change guid to efi_guid_t type
> and that also makes the warning go away.
> 
> Fixes: 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and context")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Link: https://patch.msgid.link/3777d71b-9e19-45f4-be4e-17bf4fa7a834@stanley.mountain
> [ rjw: Subject edit ]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> [nathan: Fix conflicts due to lack of e38abdab441c]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> This resolves the warning that Naresh reported, which breaks the build
> with CONFIG_WERROR=y:
> 
> https://lore.kernel.org/CA+G9fYtgOA-5y73G1YEixQ+OjmG=awBQjdKjK+b0qLNYvAAVpQ@mail.gmail.com/
> https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integration2/builds/2ogNnyGv40aCb0Jqybv8RlPt3S7/build.log

Now queued up,t hanks.

greg k-h


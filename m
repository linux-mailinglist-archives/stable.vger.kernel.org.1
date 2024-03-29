Return-Path: <stable+bounces-33752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7300F892397
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 19:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C071C21289
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 18:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760866BB22;
	Fri, 29 Mar 2024 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IppOzRlj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F854F8B1
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738287; cv=none; b=RX450U4HwVmX/uVBXPBzl+NAZLh2Uk/S8aMWZiCioyg9+hqmS8g+a3IDLgbtC9c7PsfqAvHU8ENtgKZkJtjlMev9DW4FVpstIGPwFeqthHMLGjArrsAYvSTTwmnDBQrIxhs2A+JfTZsqJn7axFNVZgWuSMvK8UzOKSyhdjdkYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738287; c=relaxed/simple;
	bh=QhrHOEqGlHv6/He+YmEla5kLq+arK8TvuhRbCdUMFXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvLuTr6EjxXNQftWd6NS7uINgMcbiHlpirisSzfMA7C4T/NXgpBJnzOQyi6aQRqJNOSs/r2tnQtNy15gSJGAlZhHLeNVEDck7dOsSyvzWwvHsvk0+ejibcfB/K57+0WP0sjd8bRh+0jsiHA9ZgLZZU1sqxjjTBLts/CfpD/Bk+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IppOzRlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E113C433F1;
	Fri, 29 Mar 2024 18:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711738285;
	bh=QhrHOEqGlHv6/He+YmEla5kLq+arK8TvuhRbCdUMFXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IppOzRljB5nvENXx5Eyq1ngtvmiIQZL8jsOj0KAnGfMaGCwyXOmU5SoyXaX/hYVXT
	 sR8cMRbGI/3P++WIMJfpOuPSp29hlOhxGIoF8Dlp52dGkGSSGWuzIsPJ9NfRBc90jl
	 ocEq8+T0Tmo+f6UrREGC0cyucTOWvMyde2QLXs0E=
Date: Fri, 29 Mar 2024 19:51:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: stable@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH -stable-6.1 resend 1/4] x86/coco: Export cc_vendor
Message-ID: <2024032909-hurry-reacquire-37a2@gregkh>
References: <20240329181800.619169-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329181800.619169-5-ardb+git@google.com>

On Fri, Mar 29, 2024 at 07:18:01PM +0100, Ard Biesheuvel wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> [ Commit 3d91c537296794d5d0773f61abbe7b63f2f132d8 upstream ]
> 
> It will be used in different checks in future changes. Export it directly
> and provide accessor functions and stubs so this can be used in general
> code when CONFIG_ARCH_HAS_CC_PLATFORM is not set.
> 
> No functional changes.
> 
> [ tglx: Add accessor functions ]
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20230318115634.9392-2-bp@alien8.de
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/coco/core.c        | 13 ++++-------
>  arch/x86/include/asm/coco.h | 23 +++++++++++++++++---
>  2 files changed, 24 insertions(+), 12 deletions(-)

Got these this time, I'll process them this weekend, thanks!

greg k-h


Return-Path: <stable+bounces-83212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0B5996C19
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 15:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7118F1F21623
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 13:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72967195FD1;
	Wed,  9 Oct 2024 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VSvlXIxK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34543190462
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480831; cv=none; b=V31EMHXH7JHGd7IEDW57RoiNMor4XdTNd0W/fy2u2GncsLQ9jJ5KhsFklSfStveX1Tdr2CjUP9p/Q8iWjM9D4kLnC74ucd+xKC6ebXYCsVP5OrIRmosGhEW88RrfHZfFLF+EO493f+c2g5la/KUgys+dOm12XprUCrUTWurvMpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480831; c=relaxed/simple;
	bh=KMFXbE4VyH9nJgzDnfU1pV2lYk4IPt/GT8qDL76yI08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmwzLWfCGlkBHWO6sDI4SGGJvMCAHCUihpqKI7QdqOSZUt7cyw0Ce2g4KOsVKBMp58w7lbCsoiOq0+q1qlWflFpBxha7V9IsUwIeM0S8+jagl95i/dQzIKmvif97eMtS+0GQ6dBS+qBRDUZM8NJGyENu5PKcFKeIuGeSwtCy9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VSvlXIxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CFDC4CEC5;
	Wed,  9 Oct 2024 13:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728480830;
	bh=KMFXbE4VyH9nJgzDnfU1pV2lYk4IPt/GT8qDL76yI08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VSvlXIxKhmWab/oV4IKQXG4kWJkBmVrJvU8gdxW+HDuJppfC/Y/3FGJKaoFaCU1+i
	 B+LSsVhvJ9YQjGRvxOSYHsFtPE0REKrGfW9M2O4oYudLAb20B5cn3WmT/GWhoJBItb
	 WsOd6fYsFLn/XqvpCm6MwZhG2Grhj0OZ5mwUPR6o=
Date: Wed, 9 Oct 2024 15:33:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiangyu Chen <xiangyu.chen@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1] Drivers: hv: vmbus: Leak pages if
 set_memory_encrypted() fails
Message-ID: <2024100900-lavish-implosive-4107@gregkh>
References: <20241009081627.354405-1-xiangyu.chen@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009081627.354405-1-xiangyu.chen@windriver.com>

On Wed, Oct 09, 2024 at 04:16:26PM +0800, Xiangyu Chen wrote:
> From: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> In CoCo VMs it is possible for the untrusted host to cause
> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to
> take care to handle these errors to avoid returning decrypted (shared)
> memory to the page allocator, which could lead to functional or security
> issues.
> 
> VMBus code could free decrypted pages if set_memory_encrypted()/decrypted()
> fails. Leak the pages if this happens.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Link: https://lore.kernel.org/r/20240311161558.1310-2-mhklinux@outlook.com
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Message-ID: <20240311161558.1310-2-mhklinux@outlook.com>
> [Xiangyu: Modified to apply on 6.1.y]
> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> ---
>  drivers/hv/connection.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Are you sure?  This is _VERY_ different from what you suggested for
5.15.y and what is in mainline.  Also, you didn't show the git id for
the upstream commit.

Please work to figure this out and resend working versions for ALL
affected branches as new patches.

thanks,

greg k-h


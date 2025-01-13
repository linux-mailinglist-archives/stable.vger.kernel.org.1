Return-Path: <stable+bounces-108395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8FBA0B464
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 11:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8483A2218
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA31621ADB2;
	Mon, 13 Jan 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MXukRBjn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B47521ADAA;
	Mon, 13 Jan 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763571; cv=none; b=bpQ17GhlddxjyPJXB4PkPqtzu4hkbgAUzl3acmxDFDGe5bu9Ndj0Bc3Y/Fm8G5xQOmB/gQYd/ZfDhnO9HO2aoIkuE5B1Jg/xdwUNEIMzgZYFn9kqIGbh4drXt8eeMsURg9tAi/Btqj1TZVlCrEabSZzCDqcvimZG0m5PcnYxKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763571; c=relaxed/simple;
	bh=t+WuP34zBZKnJMn7RSGmUlRkwlLe6tJCkZEnKRjHjY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvN/UaTbBhxWSWvG44+MlEBGBbxBJk7aAYm0zu/CfZgGEXLP8Z+0jshvOFlTsQW7T87r/VwMZ4I0h4dx8TpChcj6Vuifn6Qw3g19+1Y5cCLHw1aGHIJR2q4ccB34QnDNRwWlJgSlyRnLeI74FjLq9OPjQXJHGSS+XwgmCvHJY34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MXukRBjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FE4C4CED6;
	Mon, 13 Jan 2025 10:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736763571;
	bh=t+WuP34zBZKnJMn7RSGmUlRkwlLe6tJCkZEnKRjHjY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXukRBjns7ns7CWpIRSVKEF6UYD5eqND99zqLpVss02CsnRb4tXgc+1b1Mhu5zY2g
	 pMsdwUmCMtvFO0Pen/nD4HSVUDnctRIrQqJaUWbHQ3W3rtBLywo8gbs88v2PUOAZ60
	 R4ykVGEVfuqTE+CWn9q5Y+kF73fpMrzQOOONGaDk=
Date: Mon, 13 Jan 2025 11:19:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
Cc: linux-security-module@vger.kernel.org, linux-modules@vger.kernel.org,
	stable@vger.kernel.org, cedric.hombourger@siemens.com,
	srikanth.krishnakar@siemens.com
Subject: Re: [PATCH] loadpin: remove MODULE_COMPRESS_NONE as it is no longer
 supported
Message-ID: <2025011322-climatic-rotting-5b03@gregkh>
References: <20250113093115.72619-1-arulpandiyan.vadivel@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113093115.72619-1-arulpandiyan.vadivel@siemens.com>

On Mon, Jan 13, 2025 at 03:01:15PM +0530, Arulpandiyan Vadivel wrote:
> Commit c7ff693fa2094ba0a9d0a20feb4ab1658eff9c33 ("module: Split
> modules_install compression and in-kernel decompression") removed the
> MODULE_COMPRESS_NONE, but left it loadpin's Kconfig, and removing it
> 
> Signed-off-by: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
> ---
>  security/loadpin/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
> index 848f8b4a60190..94348e2831db9 100644
> --- a/security/loadpin/Kconfig
> +++ b/security/loadpin/Kconfig
> @@ -16,7 +16,7 @@ config SECURITY_LOADPIN_ENFORCE
>  	depends on SECURITY_LOADPIN
>  	# Module compression breaks LoadPin unless modules are decompressed in
>  	# the kernel.
> -	depends on !MODULES || (MODULE_COMPRESS_NONE || MODULE_DECOMPRESS)
> +	depends on !MODULES || MODULE_DECOMPRESS
>  	help
>  	  If selected, LoadPin will enforce pinning at boot. If not
>  	  selected, it can be enabled at boot with the kernel parameter
> -- 
> 2.39.5
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>


Return-Path: <stable+bounces-165202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499F1B15AFD
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 10:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89541176305
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 08:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE67292B2E;
	Wed, 30 Jul 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uT1E4D+I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D391291C3E
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865812; cv=none; b=t1HXhRe1FOPRIFxSyLRkl0AI5NSlk7xY2RSwvZX1tyAmIBOhKQO9XftuMbiYaO++CqCNgWiW4xUNkqY07eJB3qY+cGRPl1GCFnP62xJ3IKOw28hbFLMK41+iUMBTIkW5XJ0Jp2a3YKxgQzHIFlKMNP+CkAZUXd26tJJqpspFwek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865812; c=relaxed/simple;
	bh=EfZhugfzbHgTbLEPaIBKkOed2WItYZLV1HRVfZQpNfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktNbxnGYMOtMwPanP5ua2H0qSx0WaEB5E+tJcrN8lr+XnjUDTAsI9t8tkXMeTd+uzIslmI9wee2TIBH9d3EjhAHekYft5GeVK0WHG5gTe8bC0uj8ZyGa4XsuhEXHQhbpgjOR9FxsAk+4v4ayHhnnTiygYfz6KT2Y/pXFGl7U6gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uT1E4D+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C94C4CEE7;
	Wed, 30 Jul 2025 08:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753865811;
	bh=EfZhugfzbHgTbLEPaIBKkOed2WItYZLV1HRVfZQpNfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uT1E4D+IJbv/xqrcus4bCjapHycaH/c/jKACV3nH99VfaJRuVRxHV6hWj8WMiH34I
	 gA7FAb84z7JvmviFsxZCuYtV57IoispeLLNYWOkbv6c0yoLKprcte5jHVdlbK8B0fH
	 QJ2+spvw926hGWjdllNobMdUtHoz9kJdfhCcmbd4=
Date: Wed, 30 Jul 2025 10:56:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
	stable@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH 6.6] arm64: kaslr: fix nokaslr cmdline parsing
Message-ID: <2025073042-sacrifice-cornhusk-a66f@gregkh>
References: <20250728124644.63207-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728124644.63207-1-chenridong@huaweicloud.com>

On Mon, Jul 28, 2025 at 12:46:44PM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Currently, when the command line contains "nokaslrxxx", it was incorrectly
> treated as a request to disable KASLR virtual memory. However, the behavior
> is different from physical address handling.
> 
> This issue exists before the commit af73b9a2dd39 ("arm64: kaslr: Use
> feature override instead of parsing the cmdline again"). This patch fixes
> the parsing logic for the 'nokaslr' command line argument. Only the exact
> strings, 'nokaslr', will disable KASLR. Other inputs such as 'xxnokaslr',
> 'xxnokaslrxx', or 'xxnokaslr=xx' will not disable KASLR.
> 
> Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  arch/arm64/kernel/pi/kaslr_early.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
> index 17bff6e399e4..731d0a3f1a89 100644
> --- a/arch/arm64/kernel/pi/kaslr_early.c
> +++ b/arch/arm64/kernel/pi/kaslr_early.c
> @@ -35,9 +35,14 @@ static char *__strstr(const char *s1, const char *s2)
>  static bool cmdline_contains_nokaslr(const u8 *cmdline)
>  {
>  	const u8 *str;
> +	size_t len = strlen("nokaslr");
> +	const char *after = cmdline + len;
>  
>  	str = __strstr(cmdline, "nokaslr");
> -	return str == cmdline || (str > cmdline && *(str - 1) == ' ');
> +	if ((str == cmdline || (str > cmdline && *(str - 1) == ' ')) &&
> +	    (*after == ' ' || *after == '\0'))
> +		return true;
> +	return false;
>  }
>  
>  static bool is_kaslr_disabled_cmdline(void *fdt)
> -- 
> 2.34.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>


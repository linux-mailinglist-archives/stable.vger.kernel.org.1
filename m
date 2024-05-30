Return-Path: <stable+bounces-47698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8188D4940
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 12:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45461288064
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 10:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C421761AD;
	Thu, 30 May 2024 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="lbWREGlk"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65D1761B4;
	Thu, 30 May 2024 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063566; cv=none; b=JGs9AU+t8jLlNeoPIQ7V3hgkOsMRDcCHnq/wthBHOxgsrQIr08BV5y2dZ4PUFNZ6d5K/NnKVFgwpIpyqmM0hjcwCZXg1mginyV1iSsZJ5k97PhYDH9f5/Kxj+OBCaHYjOq7oAHQW2Nk8I1RNu793/Ydgcsq03jtqDiBjO6QZExU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063566; c=relaxed/simple;
	bh=P8D54ok9cu6zOkpePcZy8AUJjwmh3AO9JwlkXPHfqEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/O9EWYx52v1dRztpekamVpgs1DFQ3Y+7GfXqmcVd/0+sVaVpMZB7jFT4PgCioLrtisnHEximC6Kqp1C+oYya0xzuXlvj9L6DxYga1T8v1TLfTo8mPryMaCbML1mGky5g+QZMci0w5fgtI55m1V9K5V/v65KX8EBEC7uLUwJ+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=lbWREGlk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1717063562; bh=P8D54ok9cu6zOkpePcZy8AUJjwmh3AO9JwlkXPHfqEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lbWREGlk5GiSkfmpcriEcHBf6Tn3CssE33q54ngE6AIhtMmYix7k4RywNLNddmt1C
	 66ltCd61fcVdH6FnTimj99g6BVeUFP+B4CC0AB6Tdnfivk7CALIprN/JQx/JqMu4Fp
	 VfptFL9AJhKSJF3tmOzqxxDlB5SI1V2ZNNb565vA=
Date: Thu, 30 May 2024 12:06:01 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, 
	Binbin Zhou <zhoubinbin@loongson.cn>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/4] LoongArch: Fix built-in DTB detection
Message-ID: <e1321725-ee7e-4716-ad45-634803fca5ff@t-8ch.de>
References: <20240522-loongarch-booting-fixes-v3-0-25e77a8fc86e@flygoat.com>
 <20240522-loongarch-booting-fixes-v3-1-25e77a8fc86e@flygoat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522-loongarch-booting-fixes-v3-1-25e77a8fc86e@flygoat.com>

On 2024-05-22 23:02:17+0000, Jiaxun Yang wrote:
> fdt_check_header(__dtb_start) will always success because kernel
> provided a dummy dtb, and by coincidence __dtb_start clashed with
> entry of this dummy dtb. The consequence is fdt passed from
> firmware will never be taken.
> 
> Fix by trying to utilise __dtb_start only when CONFIG_BUILTIN_DTB
> is enabled.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7b937cc243e5 ("of: Create of_root if no dtb provided by firmware")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v3: Better reasoning in commit message, thanks Binbin and Huacai!
> ---
>  arch/loongarch/kernel/setup.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> index 60e0fe97f61a..ea6d5db6c878 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -275,16 +275,18 @@ static void __init arch_reserve_crashkernel(void)
>  static void __init fdt_setup(void)
>  {
>  #ifdef CONFIG_OF_EARLY_FLATTREE
> -	void *fdt_pointer;
> +	void *fdt_pointer = NULL;
>  
>  	/* ACPI-based systems do not require parsing fdt */
>  	if (acpi_os_get_root_pointer())
>  		return;
>  
> +#ifdef CONFIG_BUILTIN_DTB
>  	/* Prefer to use built-in dtb, checking its legality first. */
>  	if (!fdt_check_header(__dtb_start))
>  		fdt_pointer = __dtb_start;
> -	else
> +#endif
> +	if (!fdt_pointer)
>  		fdt_pointer = efi_fdt_pointer(); /* Fallback to firmware dtb */

Prefer to use non-ifdef logic:

	if (IS_ENABLED(CONFIG_BUILTIN_DTB) && !fdt_check_header(__dtb_start))
  		fdt_pointer = __dtb_start;

This is shorter, easier to read and will prevent bitrot.
The code will be typechecked but then optimized away, so no
runtime overhead exists.

>  
>  	if (!fdt_pointer || fdt_check_header(fdt_pointer))
> 
> -- 
> 2.43.0
> 


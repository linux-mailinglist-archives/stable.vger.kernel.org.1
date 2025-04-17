Return-Path: <stable+bounces-134489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 220D7A92B4A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 21:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B75797AFBC9
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67180255246;
	Thu, 17 Apr 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NTB5jgsn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DCA2571DD
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916298; cv=none; b=sJsjeuoglZzkUi97ogp9Y3Zp6kqr7v9sCekl0jvQADRXOmoChpfrGwzDheGfzwLR22IaybKhnmMgBqTTftdisZSwl32Z2v79QHKGfdJvB1VCLtUpUlCA57XT7YxNg4CCO7fl8LmYJj6XrMSqlBF3AKqaWTBoKKunbKtYRnrvDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916298; c=relaxed/simple;
	bh=GI0wAuQpSmecxOJW3r0nsOSu1nNXM6MLU4GGCzLPI7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3oBwGl3RbSENxgROVIlANzfHODQQBeAA1w1z3m27QZW37o0qqY2YtaoNaNrhvPBqgLnIUQ0fha+fdWxLNbM7uZ1w85O7V74ab4r+cV/Sa5lKT0Qzhqxfb9Bmm2rxgL5H3jS7c70mS1jXuIQcq9MAaJ24Nqk2HvMpYY+Lzq5NQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NTB5jgsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EF6C4CEE4;
	Thu, 17 Apr 2025 18:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744916298;
	bh=GI0wAuQpSmecxOJW3r0nsOSu1nNXM6MLU4GGCzLPI7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTB5jgsnbe7RiWQeeKaKD+kOV8gzjSDCV6WVUW/T9g38LEuF4I5lQLbjNbHIH4aoW
	 zLNsfQ15Epx2WL/vXhWZAUNJzC/SbYCXLo4v/Yju7jz0VLZHN8tPaZ6RgThPVKrRW6
	 7OE5XpAAONwVGBlGqO2zyPngGtOWR4zhyx1sLDuI=
Date: Thu, 17 Apr 2025 20:19:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: He Zhe <zhe.he@windriver.com>
Cc: cve@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH vulns 2/2 v2] CVE-2024-36913: Fix affected versions
Message-ID: <2025041732-negotiate-drowsily-33f5@gregkh>
References: <20250417134134.376156-1-zhe.he@windriver.com>
 <20250417134134.376156-2-zhe.he@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417134134.376156-2-zhe.he@windriver.com>

On Thu, Apr 17, 2025 at 09:41:34PM +0800, He Zhe wrote:
> The kernel is affected since the following commit rather currently the first     
> commit in the repository.
> f2f136c05fb6 ("Drivers: hv: vmbus: Add SNP support for VMbus channel initiate message")
> 
> Link: https://lore.kernel.org/stable/SN6PR02MB415791F29F01716CCB1A23FAD4B72@SN6PR02MB4157.namprd02.prod.outlook.com/
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> v2: Add commit log
> 
>  cve/published/2024/CVE-2024-36913.vulnerable | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 cve/published/2024/CVE-2024-36913.vulnerable
> 
> diff --git a/cve/published/2024/CVE-2024-36913.vulnerable b/cve/published/2024/CVE-2024-36913.vulnerable
> new file mode 100644
> index 000000000..3aec72af1
> --- /dev/null
> +++ b/cve/published/2024/CVE-2024-36913.vulnerable
> @@ -0,0 +1 @@
> +f2f136c05fb6093818a3b3fefcba46231ac66a62
> -- 
> 2.34.1
> 
> 

Both now applied, thanks!

greg k-h


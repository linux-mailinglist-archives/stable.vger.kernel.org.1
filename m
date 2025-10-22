Return-Path: <stable+bounces-189025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D008BFD9B4
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 19:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3343AF52B
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899EB2C11FE;
	Wed, 22 Oct 2025 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="glxIbN8Q"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A037160;
	Wed, 22 Oct 2025 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154248; cv=none; b=U+Xl73M1EbiDwdiW33CBL3cQjIiGyPusBUJjRGs6K4KuD0ickVG7urLbw+ebms0c5ZCVF0F136T/Inz2s2fuHOF96jFAjD/HWr1mXKv9qwe4MvyJmMCvxuAWdshZSJ06vdqLLeZHjaBTskGOUUJweWK4asLDzy4mAvCH3Zx6hro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154248; c=relaxed/simple;
	bh=1qmY/CwBJD83zWmp5rWvoLYG9ya3rrBEJYcOdtURn9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRukTAoiVztyUGq/rd102UDRs7UAsu0HApiTz7JaJGUVGq3WLpcjmwPOH67iZOep5H9uqqfVjejfCo7MndkMFzB7CYbKrfTg/oMX5wE13Xw4B/S/X1XXWA+HldZNNA5ZZ9QlknOG6nasXjlYSgfmm0y2PCru//lfGBD85KMkV5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=glxIbN8Q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=CeC5OMKBMYRDelbMUjaS7F56dsB+qLx2c1x5CAej9Xk=; b=glxIbN8QhiARCJCgYFMGzZKmGB
	LHkhlk24oX1rrwwapt8AOyvPPKlqODK0OMgTF+pVDD9HLLmFIDRlf8acW9OFzidRESCmNRKLZK9iJ
	nWqdjjv+Bs/v7am+Zu/LUV4dYXRlk45eqo+FIcmrOuUgPOO0eefHt8ay6nVzyNFG/Ot8L0cQU8Ywb
	NdSxIXMTtA2k4rr+GyWuSWlqTOopUcGfJysRaP2xwACp5+V39TVWzAN3qS2g7Pe29xBDgiXaK4D78
	j9pdEJ7/eaHV89ylxU8a383FFaM35SlCFpZywak45mLd/l1zpQPGqYmsRdVvmBT8ZUlaa5EMId1zS
	32z9IpEw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBcfd-00000003nIr-1V7h;
	Wed, 22 Oct 2025 17:30:45 +0000
Message-ID: <2997d8b9-a37a-4411-a5d8-b2cfcc3944b8@infradead.org>
Date: Wed, 22 Oct 2025 10:30:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: process: Also mention Sasha Levin as
 stable tree maintainer
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20251022034336.22839-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251022034336.22839-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/25 8:43 PM, Bagas Sanjaya wrote:
> Sasha has also maintaining stable branch in conjunction with Greg
> since cb5d21946d2a2f ("MAINTAINERS: Add Sasha as a stable branch
> maintainer"). Mention him in 2.Process.rst.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Now matches the MAINTAINERS file.

Thanks.

> ---
>  Documentation/process/2.Process.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
> index 8e63d171767db8..7bd41838a5464f 100644
> --- a/Documentation/process/2.Process.rst
> +++ b/Documentation/process/2.Process.rst
> @@ -99,8 +99,10 @@ go out with a handful of known regressions, though, hopefully, none of them
>  are serious.
>  
>  Once a stable release is made, its ongoing maintenance is passed off to the
> -"stable team," currently Greg Kroah-Hartman. The stable team will release
> -occasional updates to the stable release using the 9.x.y numbering scheme.
> +"stable team," currently consists of Greg Kroah-Hartman and Sasha Levin. The
> +stable team will release occasional updates to the stable release using the
> +9.x.y numbering scheme.
> +
>  To be considered for an update release, a patch must (1) fix a significant
>  bug, and (2) already be merged into the mainline for the next development
>  kernel. Kernels will typically receive stable updates for a little more
> 
> base-commit: 0aa760051f4eb3d3bcd812125557bd09629a71e8

-- 
~Randy


Return-Path: <stable+bounces-93790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC799D103F
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 12:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674AB1F21C65
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 11:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFCD194A73;
	Mon, 18 Nov 2024 11:55:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91936176AA9;
	Mon, 18 Nov 2024 11:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930922; cv=none; b=p4IF5Vgf/QFP+wK1F21B5TQnBuERQqzuFEhzjmzx/UPvdVYV97ixSBZtcgK1g3spmNj6We5UFCLp7DHI7gAGZTcEY5F1zOxFu/cMjU3jVZmcKvEuFAGMFo3YT6VEg0Gi7+I5tRkFFz0hDC5v1MDH/aUSnRBZvuzmi1U3KVKbeRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930922; c=relaxed/simple;
	bh=0r33ICqjyC0L0V5SWoWMae0zplpmsmgOQKIXnCevyRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0900DlCeNzJfnsSpXc+4mMF9JAmu10bdojZ3A18z4EtKN2NUQxdSYoHFqky/bjrpbKVhkVX74nXKlK5bvdiyhGEoHd1tcx2I6D6p0r4XcYAR5SvjYgOLQqV97FTePIcVeEspfb30fsLrdZloWXS2dcqWUJ6BVO6p/oiF5MR/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD21B1682;
	Mon, 18 Nov 2024 03:55:49 -0800 (PST)
Received: from [10.57.91.28] (unknown [10.57.91.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7F253F6A8;
	Mon, 18 Nov 2024 03:55:18 -0800 (PST)
Message-ID: <fc308d9b-9b8b-4932-9f24-1756f5c089db@arm.com>
Date: Mon, 18 Nov 2024 11:55:17 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm-ni: Fix attribute_group definition syntax
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241117-arm-ni-syntax-v1-1-1894efca38ac@weissschuh.net>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241117-arm-ni-syntax-v1-1-1894efca38ac@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-17 10:20 am, Thomas Weißschuh wrote:
> The sentinel NULL value does not make sense and is a syntax error in a
> structure definition.

What error? It's an initialiser following a designator in a structure 
*declaration*, and the corresponding bin_attrs member is a pointer, so 
NULL is a perfectly appropriate value to initialise it with.

Of course that is redundant when it's static anyway, and indeed wasn't 
actually intentional, but it's also not doing any harm - the cosmetic 
cleanup is welcome, but is not a stable-worthy fix.

Thanks,
Robin.

> Remove it.
> 
> Fixes: 4d5a7680f2b4 ("perf: Add driver for Arm NI-700 interconnect PMU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Cc stable because although this commit is not yet released, it most
> likely will be by the time it hits mainline.
> ---
>   drivers/perf/arm-ni.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
> index 90fcfe693439ef3e18e23c6351433ac3c5ea78b5..fd7a5e60e96302fada29cd44e7bf9c582e93e4ce 100644
> --- a/drivers/perf/arm-ni.c
> +++ b/drivers/perf/arm-ni.c
> @@ -247,7 +247,6 @@ static struct attribute *arm_ni_other_attrs[] = {
>   
>   static const struct attribute_group arm_ni_other_attr_group = {
>   	.attrs = arm_ni_other_attrs,
> -	NULL
>   };
>   
>   static const struct attribute_group *arm_ni_attr_groups[] = {
> 
> ---
> base-commit: 4a5df37964673effcd9f84041f7423206a5ae5f2
> change-id: 20241117-arm-ni-syntax-250a83058529
> 
> Best regards,



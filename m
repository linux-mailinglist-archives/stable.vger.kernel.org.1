Return-Path: <stable+bounces-183653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F33BC7558
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 05:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF443A9954
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 03:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B036623D7E3;
	Thu,  9 Oct 2025 03:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI2U7F9K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951A23D7C0;
	Thu,  9 Oct 2025 03:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759982012; cv=none; b=c0HI/pu+gWFEnXzTv7oHh24qEXQkWh5BoJVjv9ehpZOTCjZT2dHMHi0vBKoak1Wu0BMpwa3K0AVXCeKNkRfrdQZfRQLU+yoqzh1aYQpXXZnEtoU5vR+qo4ry6404DyhkpQX8at8jhU1jl6woaTWcXHKoJ/SlYxdv+L3FKlvdWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759982012; c=relaxed/simple;
	bh=uyodu9Nq9lMkDSCdaot9IvSCnaHWz4Hb9j/CRaYxamc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RkqCDL3USNfXwmUCJqBoElic/kuaQA6WaJ50m+DTW89d85zB+iU1fOTLgWDhR4jJ0VFY8xh7+7aSS+fHO4VtKUIhVXPPXBH8+wYXEip1fjUmh6lotlkaoJ7hOtpAtMKH2UmiaDcTl8xDnD4JxHkmVUo/MtOpdnPiyeAtUyvwXBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI2U7F9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8367C4CEE7;
	Thu,  9 Oct 2025 03:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759982011;
	bh=uyodu9Nq9lMkDSCdaot9IvSCnaHWz4Hb9j/CRaYxamc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=dI2U7F9KpZGsC/6vS0gB2fMt7pVi1rCmOLXUSehfyI4436CnIXSTHMdo4v17+aZO6
	 8ZsunLPrB+tk0R6NHWMZra5OtEKwkhqyLebryJRfJu3APGKm1wg+w3q1Rlh7bhXRiS
	 y/n7yuyknM+MqjYXt3aC4at4IvsyNZrZ3px5Rr9/Jkn2EMBofu1Y+XXmxkDpXWsoTc
	 5skysXJKv0+wetubniK3AYlR4mATLiYiMORXtkpGzdh07TN3pjlJnhGWl11iJe3b4j
	 DU2JHRa+f4tiLqzyZ76lX2Y4inL2cZObGBaxUNKpR/wKHwtQZAKIofYoApbtwWwZV6
	 QfOm8LVQmrl5w==
Message-ID: <fdfe10ef-7122-4d84-9299-e16294a1e2d5@kernel.org>
Date: Thu, 9 Oct 2025 11:53:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, stable@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong block mapping for
 multi-devices
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20251007035343.806273-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251007035343.806273-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/2025 11:53 AM, Jaegeuk Kim via Linux-f2fs-devel wrote:
> Assuming the disk layout as below,
> 
> disk0: 0            --- 0x00035abfff
> disk1: 0x00035ac000 --- 0x00037abfff
> disk2: 0x00037ac000 --- 0x00037ebfff
> 
> and we want to read data from offset=13568 having len=128 across the block
> devices, we can illustrate the block addresses like below.
> 
> 0 .. 0x00037ac000 ------------------- 0x00037ebfff, 0x00037ec000 -------
>            |          ^            ^                                ^
>            |   fofs   0            13568                            13568+128
>            |       ------------------------------------------------------
>            |   LBA    0x37e8aa9    0x37ebfa9                        0x37ec029
>            --- map    0x3caa9      0x3ffa9
> 
> In this example, we should give the relative map of the target block device
> ranging from 0x3caa9 to 0x3ffa9 where the length should be calculated by
> 0x37ebfff + 1 - 0x37ebfa9.
> 
> In the below equation, however, map->m_pblk was supposed to be the original
> address instead of the one from the target block address.
> 
>   - map->m_len = min(map->m_len, dev->end_blk + 1 - map->m_pblk);
> 
> Cc: stable@vger.kernel.org
> Fixes: 71f2c8206202 ("f2fs: multidevice: support direct IO")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Looks good to me, thanks for the fix!

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


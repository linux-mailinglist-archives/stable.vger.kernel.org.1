Return-Path: <stable+bounces-67422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A8094FDC3
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 08:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAE71F21052
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 06:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7E542077;
	Tue, 13 Aug 2024 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fEc+60W3"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D409541C63
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529952; cv=none; b=HFoDkm3X0pfq+9WmwSHv2OT5BIVEDyiY5uM/25biju0tJVWzEQhxZGhsSrg1ITVm0Zm/V+zYwquEOZO7hzwMOGpZcUVn+ojdsKPck/2Cema/4gdj9pYzkBrZY/hRmCjYxM+sJHISk+lJKmY7EjB8NzhVobSVLMqHwoOKSKJ4xdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529952; c=relaxed/simple;
	bh=r5fTpr76zvhVkX7Maf/chSQx966AEmRYTENMUBVUsKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvkhBopdT60tT04PWo2W5ok0Dwj8PZ1Nsf162UM1IOBuHFR31cKebQW+tjQxHKch7/zC98nkpOzZgpGgmgkFFbbnJBo2lL3agqAZrORAkQj4xBKqdEpa7ZuGhp3fBxtwFd6EPhbAAzannJ9L7S0tEu70QwtUSTfQNrrxA+T+IoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fEc+60W3; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db199ec527so440698b6e.0
        for <stable@vger.kernel.org>; Mon, 12 Aug 2024 23:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723529950; x=1724134750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+o8W6KPeD+G2pxc/u4nbSNGQ5xQMtPGfIV7k0oCYAhI=;
        b=fEc+60W3gVai8wbM3w89gsITBYBTVBIMdQNyabzeCDQqxo8Z81lDlUOAa/oiScCfbE
         CaO9VGK3M99a2vcucO3SakAy53i5YFXY9CG0SoX3WBcQuoTeDiOBBh+8//S7cJpiKgcc
         EHw0ODf5dOgCUIfraYwOfWmg5A5vkjKe2WAgStOsJj6azMUgihVUOJjxCh1lF9CuDT3v
         y38ik/Y4ydOhvhFiNPMWkSB5pTnPMtFsQSbrWASU8lvKnhJSjGdN1B8l03y3RMhoAi5B
         w9DAqZE/yfsWd2YevHH7NMLb1Ztd5RSQGf6yGLJZkHXuZAjh7Va/PSKHqgsIaas1JWTX
         CCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723529950; x=1724134750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+o8W6KPeD+G2pxc/u4nbSNGQ5xQMtPGfIV7k0oCYAhI=;
        b=G1mUN69AwVpfx+NZp2ZoKomfc94ZjAub5jgvev9699VaZZ0MdO3t8kcAL3+awRXfZN
         UFFWOPx3i34Oc5Hta2qrzSwb3Y1HghqNO17OXXigAWb90zgy9f/xZ9jVuHfXpFSR8Fu1
         05rLoQTx8lG+mObq7xwGyR38VIy0Iwh2JcsZOsEtaPY0yFICfDMN/su/Wxj0wa+qH5jf
         vNGMsjfi7e1H0UcZwms6nxXDLjEV9EphWKoDK6SV7n7TqVQSos2iAg7IIZ0fckITkDqA
         lyt2dRegA9cOatp/n3GZ2HQ73SrGtRv8rSyhyy4/DCFHLFtYuWbXy63/GKjFjjXZidpC
         Jtvw==
X-Forwarded-Encrypted: i=1; AJvYcCWSQ/GbJfXhe/Hp2KKUgm66wSFg3Me3iAo3KBugWozaIFMaHQIV+xwQMDxlODrm+Anku4vcU4a18n2wsMwR7ZxOcpeTZSZe
X-Gm-Message-State: AOJu0Yyyg3XlSwybNVYKv64wp2L/iJv1j7BWKCWs8dN/9QKgyA6CxWsh
	faVgk81zc91iG/D59mpdGEUvqj8JM+I2vyTCdftmR0d/3Dk2JRf3TCg+M6jfrOk=
X-Google-Smtp-Source: AGHT+IHGJ1A9lPbrXqyoEtuy+hO00+nCxFh6Lqpl29dwj8QJ4q9buu50xBdbJQRHjMyls0g/qp3ZqQ==
X-Received: by 2002:a05:6808:981:b0:3db:15b9:f29b with SMTP id 5614622812f47-3dd22ce96bfmr672305b6e.5.1723529949825;
        Mon, 12 Aug 2024 23:19:09 -0700 (PDT)
Received: from [10.4.217.215] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c697a6c6e4sm691042a12.80.2024.08.12.23.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 23:19:09 -0700 (PDT)
Message-ID: <59bf3c2e-d58b-41af-ab10-3e631d802229@bytedance.com>
Date: Tue, 13 Aug 2024 14:19:03 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] userfaultfd: Fix pmd_trans_huge() recheck race
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Pavel Emelyanov <xemul@parallels.com>, Andrea Arcangeli
 <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
 <20240812-uffd-thp-flip-fix-v1-1-4fc1db7ccdd0@google.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20240812-uffd-thp-flip-fix-v1-1-4fc1db7ccdd0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jann,

On 2024/8/13 00:42, Jann Horn wrote:
> The following race can occur:
> 
>    mfill_atomic                other thread
>    ============                ============
>                                <zap PMD>
>    pmdp_get_lockless() [reads none pmd]
>    <bail if trans_huge>
>    <if none:>
>                                <pagefault creates transhuge zeropage>
>      __pte_alloc [no-op]
>                                <zap PMD>
>    <bail if pmd_trans_huge(*dst_pmd)>
>    BUG_ON(pmd_none(*dst_pmd))
> 
> I have experimentally verified this in a kernel with extra mdelay() calls;
> the BUG_ON(pmd_none(*dst_pmd)) triggers.
> 
> On kernels newer than commit 0d940a9b270b ("mm/pgtable: allow
> pte_offset_map[_lock]() to fail"), this can't lead to anything worse than
> a BUG_ON(), since the page table access helpers are actually designed to
> deal with page tables concurrently disappearing; but on older kernels
> (<=6.4), I think we could probably theoretically race past the two BUG_ON()
> checks and end up treating a hugepage as a page table.
> 
> Cc: stable@vger.kernel.org
> Fixes: c1a4de99fada ("userfaultfd: mcopy_atomic|mfill_zeropage: UFFDIO_COPY|UFFDIO_ZEROPAGE preparation")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>   mm/userfaultfd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index e54e5c8907fa..ec3750467aa5 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -801,7 +801,8 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>   			break;
>   		}
>   		/* If an huge pmd materialized from under us fail */
> -		if (unlikely(pmd_trans_huge(*dst_pmd))) {
> +		dst_pmdval = pmdp_get_lockless(dst_pmd);
> +		if (unlikely(pmd_none(dst_pmdval) || pmd_trans_huge(dst_pmdval))) {

Before commit 0d940a9b270b, should we also check for
is_pmd_migration_entry(), pmd_devmap() and pmd_bad() here?

Thanks,
Qi

>   			err = -EFAULT;
>   			break;
>   		}
> 


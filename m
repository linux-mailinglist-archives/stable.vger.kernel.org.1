Return-Path: <stable+bounces-139640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0837AA8EAD
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 10:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25578174962
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 08:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07A41F4628;
	Mon,  5 May 2025 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pa0ibffT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77845376;
	Mon,  5 May 2025 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435459; cv=none; b=MzweaB6jrDkrCrPJ7Jvozm96QPE+yzYNA2C2/oAVU1ku5LC28BZwFLcae/7LF7AWjdxHwyzTgx1lu3HOSuGHZKxIAJj6fHFBQjJXSyr9V75n7zccw5/fiJHaNuWV103FWjTKVyphq4LLdbKeAHGKVKo8WQw0YWeIPQO3BcLDpSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435459; c=relaxed/simple;
	bh=6y6yHTe41YjDL4/4vB2R19X+qDeYYevmGVV/3lXQAl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpJ7amudz3UxpPYuQ0rvuh3tZALlTeYnaTIz7/HjkkOZfRAZYZxnOnIF9D6xMD6ANUUUCZtZQnwlP6v8bvKf7IVApL8d6QDiDti8TBmIBcBvR6M2FxZrXPavsdRcUpZlL6tDyBgdPNn0mQ+sVqMYnd2RPCwzvtUlIxtbemxPHtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pa0ibffT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853DFC4CEE4;
	Mon,  5 May 2025 08:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746435459;
	bh=6y6yHTe41YjDL4/4vB2R19X+qDeYYevmGVV/3lXQAl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pa0ibffTcJyfeIuajd3kOMsCk6R2ECLuTpx9msrEIH9S5822HryWD8Hg8BWiKO340
	 LVbiX1Zfng0YVBLe3Tk6IuyDnWAm6OTxlM3kKB4KySBnFlBDeYBPj7UUatsTrtnk1p
	 Cd4yuFp6aLviuKBBEX00zwF8m529yIoiglhpJBFk=
Date: Mon, 5 May 2025 10:57:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Sasha Levin <sashal@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 6.1.y] LoongArch: Fix build error due to backport
Message-ID: <2025050531-video-reassure-e0f4@gregkh>
References: <20250504021054.783045-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504021054.783045-1-chenhuacai@loongson.cn>

On Sun, May 04, 2025 at 10:10:54AM +0800, Huacai Chen wrote:
> In 6.1 there is no pmdp_get() definition, so use *pmd directly, in order
> to avoid such build error due to a recently backport:
> 
> arch/loongarch/mm/hugetlbpage.c: In function 'huge_pte_offset':                                                                                                                
> arch/loongarch/mm/hugetlbpage.c:50:25: error: implicit declaration of
> function 'pmdp_get'; did you mean 'ptep_get'?
> [-Wimplicit-function-declaration]                          
>    50 |         return pmd_none(pmdp_get(pmd)) ? NULL : (pte_t *) pmd;                                                                                                         
>       |                         ^~~~~~~~                                                                                                                                       
>       |                         ptep_get                            
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/mm/hugetlbpage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/mm/hugetlbpage.c b/arch/loongarch/mm/hugetlbpage.c
> index cf3b8785a921..70b4a51885c2 100644
> --- a/arch/loongarch/mm/hugetlbpage.c
> +++ b/arch/loongarch/mm/hugetlbpage.c
> @@ -47,7 +47,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
>  				pmd = pmd_offset(pud, addr);
>  		}
>  	}
> -	return pmd_none(pmdp_get(pmd)) ? NULL : (pte_t *) pmd;
> +	return pmd_none(*pmd) ? NULL : (pte_t *) pmd;
>  }
>  
>  /*
> -- 
> 2.47.1
> 
> 

Thanks for the fix!


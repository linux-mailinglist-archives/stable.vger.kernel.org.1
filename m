Return-Path: <stable+bounces-128565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E388CA7E22E
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 16:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B4D7A21E4
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8FA1FECC8;
	Mon,  7 Apr 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVSxOBK4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C21FECC6
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036340; cv=none; b=Gh3eR9Ewv24unCRnPhMpWPbNjgffYqRHJS93Owu0OV82NAhLc0TRVu8Ao02C0GIL8GQrR3XkyI9uWhN1C8E5atUYnJcamvImvNTa7lNtYVq//8IUzXzDXlnP5GnIhtnUwINKFa5ldNYn5FOjcG0othHKwp+iYUeLhLGjU4cD/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036340; c=relaxed/simple;
	bh=hdv1gO3t7MN17PsPaLcZlq03rMpbhAxNDhXyS2ZqfQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F184mK/EKQID1EPLLjdfvqCTclPX7P4RA9PekOPHBv55fHULHr1vDF9G1zC8cDXQWc/H6bb+PqzBtZrHRsEaoW5q5PaDW5l7JwwwSJ8jx/bbHw+bOmEINxl5RvfW3dwuAW64njUDdZkexDghnTGjXY+mLrAa2zFhKbW5pkLMaaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVSxOBK4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3913958ebf2so3946668f8f.3
        for <stable@vger.kernel.org>; Mon, 07 Apr 2025 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744036335; x=1744641135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sspLXphw+bUvBqQ8IAow+bkdS8OEOw0XRgjN2W/fPrY=;
        b=fVSxOBK4k/h69H7k5TmnpoyAD66dzFKCq66z1pyk+JplNjEm+ezNhyOWIn4ZgNjVYD
         xfMTW09q7kI2zf8PdUdXYDI6+LSJ9v7AA7pdVySUrjmBB3OhkoJ1VQpUqYvm1e+qT68e
         hH5bxOXk+0PwMSdlIlWfZ9yNw6Vo2t+MIQJwcgm0fMzxJxrslSHNUiBfOCBimFpN+ZxB
         atLefP9zZb6/YF0N4ayf2QA1ars4p8/lB2Puc4hTeFrwZW+zc83gLXBL587D0yqKwlw0
         Bk1etTbvzz0yBEPY+xAFiUE2tctFY3YKnAG2AnQZsZZqycJDjBEOGN1VcDBObJIw2/+P
         dy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744036335; x=1744641135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sspLXphw+bUvBqQ8IAow+bkdS8OEOw0XRgjN2W/fPrY=;
        b=mBYKDrqefCNKxADB5jwaDJCLoiwUQUT0qpvohXpCjwwhNNanlJuqXpNWJktEuCPmug
         7QjhUsTJLAxfNm4QBjfOQa0GX8Szl2+yaXLEnLnnZUEQT6z1cYyFuCdI7fo582CROoYH
         hag2r0M1MtS3qXDCQkXPliG3s8uYWH20uAFhAVALb9kKqcweurCNE31iuvZ0MxUYLHUM
         dUL+zg4ZnImmjewB61Q35ZnAXISJbrmQWYkSWx4cJ98s9dakCKHNvJxecvbc1KjNAqMJ
         Q8ccPbJQjAqvH2gmDf3V+cCsCQUe5P/iN2RmGCfLN8oEfu/Kk6APvAydj3yNprXeISvE
         hjZg==
X-Forwarded-Encrypted: i=1; AJvYcCUTOLl9DlnJ8ExzdplqRyQ6L9VpAqj5fwxPKXAZplwY7Hvth41LFosts/N744P8YAxJxmlcDOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN0ESjjYdivQLkaQRSbMGHBNrANkaQTjcXyjoHy1doKby/9HeX
	1evTjs0L7TA7cCE0jCjZeWeNT5TqKHA6K5o31qAG0o74bbMG5c0N
X-Gm-Gg: ASbGncvePKJ3wFoXtR3F3AF9iPpOSm69A+cEQyGrqa6e6/jsGijRAecE4D31gmbyLek
	y7U2b8eCLVVa84otn2iVKalYplhpMVMdxFs76Bhu4JYBmWuGKfOuiaKzGE7ESWX3ThvrCwMwrGr
	5QO49ztb0a5mU39Y0Q7z7EvpIgo2f5DATRpD69in3uCt3+nBfyugdrpTCLRBr9WD78EXGKJEwlC
	jl+NmnWJmOptCIJZKAi4YUMzT1teNbJAqjlpocLp/QT/MRAAYIIMxu4WaVfnvE9tBcyWFRalwQy
	DjdUI+9i9li9RJiLTiB2KPX77nJIzDXm/tmyd0I667ZdPbhRAsrBTJ4P4TCE1VbujBjR8alWAw=
	=
X-Google-Smtp-Source: AGHT+IFNhKjcgTLgsYLPmhlqMkUCkxPWbnj6cuzFcQXQlfH/tqY63ok6fsoDG3DZxFV8dfVRLwqgTQ==
X-Received: by 2002:a05:6000:1849:b0:38f:6287:6474 with SMTP id ffacd0b85a97d-39d6fc49319mr8067246f8f.15.1744036335147;
        Mon, 07 Apr 2025 07:32:15 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d75ac6d66sm5964473f8f.14.2025.04.07.07.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 07:32:14 -0700 (PDT)
Message-ID: <a4b1190d-4d4f-4c66-9fb7-2be19d2ea3dc@gmail.com>
Date: Mon, 7 Apr 2025 16:32:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/dma_buf: fix page_link check
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
References: <20250407141823.44504-3-matthew.auld@intel.com>
 <20250407141823.44504-4-matthew.auld@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250407141823.44504-4-matthew.auld@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 07.04.25 um 16:18 schrieb Matthew Auld:
> The page_link lower bits of the first sg could contain something like
> SG_END, if we are mapping a single VRAM page or contiguous blob which
> fits into one sg entry. Rather pull out the struct page, and use that in
> our check to know if we mapped struct pages vs VRAM.
>
> Fixes: f44ffd677fb3 ("drm/amdgpu: add support for exporting VRAM using DMA-buf v3")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.8+

Good point, haven't thought about that at all since we only abuse the sg table as DMA addr container.

Reviewed-by: Christian König <christian.koenig@amd.com>

Were is patch #1 from this series?

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 9f627caedc3f..c9842a0e2a1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -184,7 +184,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
>  				 struct sg_table *sgt,
>  				 enum dma_data_direction dir)
>  {
> -	if (sgt->sgl->page_link) {
> +	if (sg_page(sgt->sgl)) {
>  		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>  		sg_free_table(sgt);
>  		kfree(sgt);



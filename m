Return-Path: <stable+bounces-100896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E119EE551
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 12:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846B01887168
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F071211A2F;
	Thu, 12 Dec 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F1RtQkEN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614B1F7544
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003920; cv=none; b=j36fJGAQYkEU9NsVMt0sYb+sVIHeupHd9LGeQeYEjmmVZfyc5jWr1RSCBCAwQnzULyVzcYw/7Gqv+l1bNzh9u/gE0jXm0+A48QfGV7Vrbvgt5e2cJil7I30xh8I2RsYOKChonA08N2RJy264XfWjWs4fped7gGbECr5QAObnbLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003920; c=relaxed/simple;
	bh=/AeMddT5I/7ORa8Vq3OjuCXXDJmjVLBFui+0F4NUov0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQfKw7Cj7nA2jGZhYd+uuwSQbjL6q8ydaOdF9dGGIxtbMvm+giz6CH52QSakeL7coKoThZwayD5L1cXv+CVAmdaUY1W1E/lhrYOzQzwP6WeuoktxUSlh4q2UM4OAQ2r8vSgvKGrhDp4nTlRL03skLRZGm1fGhv+jpgWw9F8YvfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F1RtQkEN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38636875da4so31848f8f.2
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 03:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734003916; x=1734608716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNJ2NNXOEYsaP47VU4MW29jbTvfPJgrGv8fsDcVmvbY=;
        b=F1RtQkENIXfAgjAYovXI8VzSBq3iDlcCy62phGx7oYjCScIgNVh75Qc0fNpd2xPp7f
         5axGrgF1ObTRxntC9aceDilI90b619MMDgyy/xZhnupCSa9YbriHSxATstGD3O4Do+7J
         5V47sxX2hbmcNVAN/Tr1NAqNEVVLh3T6r0Gwm4caAnXN0deuIlwlRGD6L72wWH9yixEZ
         cycuYd+8zWhuNE086LigVP1D+sT3dq8HEYzN988fCCMFdYQYyNRUI+3q4KBYzlPQJEhJ
         LmKlLZHXuaB7EkWNkGNw6PQ3phoL8UN35gfDiVOzVVg5zwOCYBnkzN4k17XhnwSxP4A1
         in0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734003916; x=1734608716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNJ2NNXOEYsaP47VU4MW29jbTvfPJgrGv8fsDcVmvbY=;
        b=jMI2UMlm4loHEWQEU/XRwgCtevG4cyH/sj8BDQVG77KFya7L9DzvSU1WHHptxIbsH7
         FYbugaOuBVDYShnLYLHjTRM31+INLRT5rq92L8eex8PqJJrMdWixhoQwFBr6vN2Z3nC8
         i8k1xQ81HGY7uVZYjqw2Eq4ult0WCJJfkCMGgKBucA8Xq5t/P+/9eWU7B8tDI9gxYHjk
         vGxcvJJCdOhvYpE+heT+G4B9Q6GpWJc3TEnQnPajDRb53gJ+Z9WVvW1mxojDSQeAvylE
         /jBPsGF1Uf+YhV1VEH2yHsAA+kRoepOL/cg1Ve+Ul5z0UfiPCT8TUdRR6HubV0Qg6gTi
         AZzw==
X-Forwarded-Encrypted: i=1; AJvYcCWmpthqD0a1WhJqdH7cgBTVN+gNjQB7UUj5lLFsoheMn/DDZc2kyeWCGZSAVXbMx43maAQ9mXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2fgi1j/ArjQsrwigabS3SQ7LBTJXoC9pkfWmCb8iN7X+GkWnk
	14VRQaOLTyNRuask69A3RtdCu9yQCx1rl8nvhrLZvbNZivQw0IfZdPdypZAmRXU=
X-Gm-Gg: ASbGncvt/Gz+wK2GHkgMyqc0Qow0QqH7g5NkO5lfrbFdRjrHZgte2ME0D5CAG37br5P
	OSsjHvxRJ3Lp2DlLXn1z2C3Xj8RgasbctFalONTYpTejuUtxq6OOGVva7SSIm9MiKJvx3efE5m7
	+sLiIdSYMirm7Mbc0XAezCqzLINWEqJPQuTPJIxKE9DjqqmmgIe2Sw8NHw/OxGLLWew08LkuP/k
	27TZkNS8Nn8jT/RbEsk35nD1udTxOUhWkn+SyQNEJdOcKLDm2/VbHp0U5eE
X-Google-Smtp-Source: AGHT+IEq35k9CwEbCU11uF2TKeyxIO7Vf7aoHPTQorzrPZxcWI2W9+Q+cuNSK/R6YL8Vw1DfHHFb5w==
X-Received: by 2002:a5d:584d:0:b0:385:f1bc:7644 with SMTP id ffacd0b85a97d-3864ce55aa3mr2023500f8f.6.1734003915850;
        Thu, 12 Dec 2024 03:45:15 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21615dba950sm105039195ad.11.2024.12.12.03.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 03:45:15 -0800 (PST)
Message-ID: <92d413be-286e-49b7-a234-b6e2c8c94581@suse.com>
Date: Thu, 12 Dec 2024 19:45:11 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: Revert "ocfs2: fix the la space leak when
 unmounting an ocfs2 volume"
To: joseph.qi@linux.alibaba.com, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 ocfs2-devel@lists.linux.dev
References: <20241212113107.9792-1-heming.zhao@suse.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20241212113107.9792-1-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

The 4.19 branch also needs this patch.

- Heming

On 12/12/24 19:31, Heming Zhao wrote:
> This reverts commit dfe6c5692fb5 ("ocfs2: fix the la space leak when
> unmounting an ocfs2 volume").
> 
> In commit dfe6c5692fb5, the commit log "This bug has existed since the
> initial OCFS2 code." is wrong. The correct introduction commit is
> 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()").
> 
> The influence of commit dfe6c5692fb5 is that it provides a correct
> fix for the latest kernel. however, it shouldn't be pushed to stable
> branches. Let's use this commit to revert all branches that include
> dfe6c5692fb5 and use a new fix method to fix commit 30dd3478c3cd.
> 
> Fixes: dfe6c5692fb5 ("ocfs2: fix the la space leak when unmounting an ocfs2 volume")
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
> Cc: <stable@vger.kernel.org>
> ---
>   fs/ocfs2/localalloc.c | 19 -------------------
>   1 file changed, 19 deletions(-)
> 
> diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
> index 8ac42ea81a17..5df34561c551 100644
> --- a/fs/ocfs2/localalloc.c
> +++ b/fs/ocfs2/localalloc.c
> @@ -1002,25 +1002,6 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
>   		start = bit_off + 1;
>   	}
>   
> -	/* clear the contiguous bits until the end boundary */
> -	if (count) {
> -		blkno = la_start_blk +
> -			ocfs2_clusters_to_blocks(osb->sb,
> -					start - count);
> -
> -		trace_ocfs2_sync_local_to_main_free(
> -				count, start - count,
> -				(unsigned long long)la_start_blk,
> -				(unsigned long long)blkno);
> -
> -		status = ocfs2_release_clusters(handle,
> -				main_bm_inode,
> -				main_bm_bh, blkno,
> -				count);
> -		if (status < 0)
> -			mlog_errno(status);
> -	}
> -
>   bail:
>   	if (status)
>   		mlog_errno(status);



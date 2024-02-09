Return-Path: <stable+bounces-19387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA5584FB7B
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 19:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FF71F2158E
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 18:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8117B7E785;
	Fri,  9 Feb 2024 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kIDfjqvM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA37BB16
	for <stable@vger.kernel.org>; Fri,  9 Feb 2024 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501862; cv=none; b=r6sYZzMKwLSoo7aa9RYBnfnvm/nanhVkWN04loTjoaMC1WcKkTkvDpjaI1HJT1havtquvORwE0FjSd/AE126k1tOygGFJw5cq66hiDSQl5Vo2w59tcXgoDW1btwDAjDQbnVmNnAv5cEyzdbvLovke/71y+iqTGPCJ/cV+y54EQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501862; c=relaxed/simple;
	bh=3hTF6N1ANm2yriMckJqJh/LAcF3RTOt1KkfLxNqJcHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHV2TsAmkALYnh6t+0a4EH+UmxUk3UNFUZYGQo8sgoYan+oa9zx+FiDUqNu3zaiZ+4llB2/SEUIizfBpfFLgKcq3+izRGAesDVEyTyx/DI9QqP2ypX/520YbtmXFFxK2abkt6aXMsozPwSsdNab1SnpxX+RNSN/VnboeuZNp2zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=kIDfjqvM; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b5bc9fdabso212622f8f.0
        for <stable@vger.kernel.org>; Fri, 09 Feb 2024 10:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1707501858; x=1708106658; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DDGOwrrqt5c3Zj0l8FVanxJvubypQgqlJ0WTKt1ARoo=;
        b=kIDfjqvMro5XY8ZI3EpWANpJ0tfI1Q8NzbtsWW6Oxbv+HXZaSN3cFmYM9eVw0xiAP/
         W4d8nxOCcth7rVYUSsQLijhmtavkk+gtzN95FoLMt00BP8NzamKbW1NFtmX7ok05Aedb
         zhD7UCIZk18ZoNhUeUKZOjsOdboxRb6tPa+Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707501858; x=1708106658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDGOwrrqt5c3Zj0l8FVanxJvubypQgqlJ0WTKt1ARoo=;
        b=cB8VvOhHB3UntsBSQfGyZeQL6iMygnSAchO3X6I4L2Q6T4r8ua5WS+kINFO2paisB3
         2QA2C/rPI844y2Cha2nK7oC11FPzYE8fH4z7SdU3+MZpNpMJpsHQanlN+T4TL3JYLs0i
         V9w4ve1JEbyiAILd5jOUjqI3ZfsSgSL0MsLp3EJ/c6Hk4DLp8S8APEEg0j49AMM05f0S
         lXqcFbCJ9qQoMeBlsOa8xDXDFJNGJuzM6q5Tt/Z1XfpqHsCtA19U1vG5AnPan+TNd1Ln
         3a0Y0P+GFknh+R7Ce3HO+O5DsblnzoIjlf8w7nk7Pl/JLtTJTHaKyztxTsbbH4XVN+r0
         e2qg==
X-Gm-Message-State: AOJu0YyGgA7Hp6Tsq2Kz8klNa56S4QPqmmT8Qz5K+jv9J99uiCu64Q9K
	OgFXvjAT6AsTjTPPGgb2YlCYO/KJRmzraQzQccMVE0VEYC9GcDO9+hqDDZz8Qc4FZkTtNq10D4b
	l
X-Google-Smtp-Source: AGHT+IGXQlxTxZvCi09N0bXjgAnY+PwIla/QEH2uBkCQD9xG+jLnikT7a+FS3ULZvbqJIUceELaKig==
X-Received: by 2002:a05:6000:16ce:b0:33b:51dd:753f with SMTP id h14-20020a05600016ce00b0033b51dd753fmr1750262wrf.0.1707501858002;
        Fri, 09 Feb 2024 10:04:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMUr7hIHhkGh5qUfKz0UED6a0VCHBGRbg3U4UIQ6RHg7hHEeaYtgljXxEDaBJcu1ao3NQ/ZZpSwz7uasTIFfxB/vxFl6Jo6V5ynGoL3LpV2PDRkHEKa877tJWLpmYb14cfwAG4meFkTTTCRfIgIcVeNsrysLTBzLifMdII9YeGhVnkkfA4ienLNrLcvve9cGDepZ+ZEYZWJ+9D/xjxQ4X/Y/MN2XUflOs62jxQkhkq+ojaMfwEmYys8ey4hM99/pnL6/avsNCzYnJMOfOK9d+oc6yzzqQms1CIRQpaVOFF5FFm8JRzTpWGDnAkaIQu
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d4b0a000000b0033b4d603e13sm2357576wrq.51.2024.02.09.10.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 10:04:17 -0800 (PST)
Date: Fri, 9 Feb 2024 19:04:15 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, christian.koenig@amd.com,
	alexander.deucher@amd.com, matthew.auld@intel.com,
	mario.limonciello@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH] drm/buddy: Fix alloc_range() error handling code
Message-ID: <ZcZpH3hwBjv7s8WK@phenom.ffwll.local>
References: <20240209152624.1970-1-Arunpravin.PaneerSelvam@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209152624.1970-1-Arunpravin.PaneerSelvam@amd.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Fri, Feb 09, 2024 at 08:56:24PM +0530, Arunpravin Paneer Selvam wrote:
> Few users have observed display corruption when they boot
> the machine to KDE Plasma or playing games. We have root
> caused the problem that whenever alloc_range() couldn't
> find the required memory blocks the function was returning
> SUCCESS in some of the corner cases.
> 
> The right approach would be if the total allocated size
> is less than the required size, the function should
> return -ENOSPC.
> 
> Cc:  <stable@vger.kernel.org> # 6.7+
> Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3097
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Link: https://patchwork.kernel.org/project/dri-devel/patch/20240207174456.341121-1-Arunpravin.PaneerSelvam@amd.com/
> Acked-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

New unit test for this would be most excellent - these kind of missed edge
cases is exactly what kunit is for. Can you please follow up with, since
we don't want to hold up the bugfix for longer?
-Sima

> ---
>  drivers/gpu/drm/drm_buddy.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> index f57e6d74fb0e..c1a99bf4dffd 100644
> --- a/drivers/gpu/drm/drm_buddy.c
> +++ b/drivers/gpu/drm/drm_buddy.c
> @@ -539,6 +539,12 @@ static int __alloc_range(struct drm_buddy *mm,
>  	} while (1);
>  
>  	list_splice_tail(&allocated, blocks);
> +
> +	if (total_allocated < size) {
> +		err = -ENOSPC;
> +		goto err_free;
> +	}
> +
>  	return 0;
>  
>  err_undo:
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch


Return-Path: <stable+bounces-188269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCF0BF3F42
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 00:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312CF54121D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 22:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACD52F3C1D;
	Mon, 20 Oct 2025 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="WSYIcChS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE632F3C18
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761000151; cv=none; b=WxXbWg9714UsXyGLcPrePaKyv4sP7aLqb+YIuvdu86GadzsKLUMrK13vPr59+VTDtr8IBrn5HH0XWgx58rXMZsA+CV/HDrhxMs34xfueQODKkhtneCwYRTtpNU3hIrGF9btXKyEivqr4TYfvkE1FRIrxUdciL0PS0/L9/a9fhww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761000151; c=relaxed/simple;
	bh=V/QlFpXgyJoNbFyFYC7FJdEmHGD+nLW/QS0FRMghKNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDGuHm1v1xYXA/cBzrLGp1ZA+ccl5Nh9mXYKPAZqjdSWobKrtnP6+akdYi0ugoES/CVwn2wsqwkciunpRzpEQR4Nya+AB451w+I+5qlpKOMhKOt/8pGzkQY0wab+y2QTohExLbbOoNyT6SmdEryEsh9gePNk/JBJ7Wc46ZquGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=WSYIcChS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-782023ca359so4783789b3a.2
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1761000149; x=1761604949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WZlH2DqYFCiXY7ctfKICcS4Udl66TWHE3E0JHv0JUQ=;
        b=WSYIcChSQUc9Z/1xQBtIpyGELFJp4j41QLwWqoxR0J0IQJyQ6rCteD8c89r5iDCv2L
         9ujLmaXbUac/EtivqQ7qKQKAmayiQRRlOpvEpc+OeVLfcUJC8asgNcli2VvrxYJaCbKB
         3yxjzLDXK6hVoqSH/01/JrTpX0Td/yv2PAwUcLrPmP1qjGS6FvzlSkTm0dmgZ+ZxUqn8
         UADUtUe6kWyanatsvLpt1/bU+Qb21sVWvezcc92wim7Tg/Z7yNKXkzrJXP4wxh4sDDgj
         mB8jTZ09vmWfWtmH3yQZlLZBqQ6SzEHlr64RN6v/NuA33zXVdvxg6UsiH/MwYCJj+mwP
         Zgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761000149; x=1761604949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WZlH2DqYFCiXY7ctfKICcS4Udl66TWHE3E0JHv0JUQ=;
        b=mJlnCjmX9bI4izhtT7KJ4dX1uU22E/dcxb37QbFdB1Mx9H9u4EhsIiMRI3+ac6MBPl
         GTaMExe7GgRF6UrU5yhb+ZStAvv+bVjVUf/MIs5xs/NVuwJYFVcepYH9OJILjelWuWl/
         5kTkldFqR5zj3w+aOlWLEtJbAnIwWzb0n9gs3vkl2s5t0a2KAkn+l00IgoX5gEb6kRlr
         U7x5WFaGFKa6rEkCn4c4/LwqbAlufgMXac0fPwRcLwh5ico63QJY9e+0mnsMV+nigZ2v
         Wniwcd7Al6euUqVwWjDqVMu55W4L9QaxUB0zpnvU+7Z9DnSAF9fpLPTlQGnTuZib9jMy
         p+NA==
X-Forwarded-Encrypted: i=1; AJvYcCU6Ye3WWZ/0bAVQ/7uARzW10w8lPqBPUkgz7mY1+wKAPYqA701Rmo2FTxdFKI3g8A9KByOXxQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS/VYPbZpJ4MOCfZau7psDjsXLsL1zxQKsD5QwSLl03866NwSi
	587iQaysRH37ULiZnIfm2CYWka4cdUCOjXvZveLAssrmSz8TG+p7v/4rgFSGBZS1wpCa
X-Gm-Gg: ASbGncuJfc+jONIv4bqM5RREPTAae0lolakzs8bV8zRp2pFELMcnc6pl57ADtNu3TcK
	VWbYALy/zXvYqb5+8kbxtIyaiY9xdZNGziMJT9+NP2+8fi7w/LhZhKlxH5ZbpcwoKZl8YTy3EpA
	dB+J8xIhJrGCu55TUUvpvGVFrjiNjWb0zo6Uc7nQlx5svOiSIPd6UL4G69NJOdE4dUeVY/j4Mm0
	Q4wiA8hie/lyVJ7rSL36dLkGh6ZNWbogpwPYpoBaX7QnrkrZKRbtrXzmYW/5cphIwBtjH/D7a/U
	TxebG/XP1bbM56UuwTv/uGxAQvn+Tp4nx7rvosxfG+3JFv0qK7ZCGwtI/PC0lidB2wGEoSXF+AU
	JjZ9H0v2l4C12+wE6/Y7/NOkXYHZAmkCTcNj1s8ZRjrSVn4tXk1O6r5lHQ769W7KJIrD8abyQhc
	A7Ng==
X-Google-Smtp-Source: AGHT+IHUEOc3xfI2tI8heWEXh/h72XqkqsVQcuo2Bv6d3BRyZGZMOF0s+ZVb8CgacF2pj4JNoea9QA==
X-Received: by 2002:a17:902:c947:b0:24e:e5c9:ecfd with SMTP id d9443c01a7336-290cbb49e26mr225774035ad.42.1761000149306;
        Mon, 20 Oct 2025 15:42:29 -0700 (PDT)
Received: from sultan-box ([79.127.217.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de3295dsm9095139a91.15.2025.10.20.15.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:42:28 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:42:26 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd: Add missing return for VPE idle handler
Message-ID: <aPa60qtBV5iCiY2I@sultan-box>
References: <20251020223434.5977-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020223434.5977-1-mario.limonciello@amd.com>

On Mon, Oct 20, 2025 at 05:34:34PM -0500, Mario Limonciello wrote:
> Adjusting the idle handler for DPM0 handling forgot a return statement
> which causes the system to not be able to enter s0i3.
> 
> Add the missing return statement.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Closes: https://lore.kernel.org/amd-gfx/aPawCXBY9eM8oZvG@sultan-box/

I just noticed that this link doesn't work; it seems like that email of mine
didn't make it onto the amd-gfx list?

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index f4932339d79d..aa78c2ee9e21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -356,6 +356,7 @@ static void vpe_idle_work_handler(struct work_struct *work)
>  		goto reschedule;
>  
>  	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
> +	return;
>  
>  reschedule:
>  	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
> -- 
> 2.49.0
> 

Sultan


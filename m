Return-Path: <stable+bounces-192020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC70BC28DD6
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 12:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98E544E4689
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 11:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C308312C544;
	Sun,  2 Nov 2025 11:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lXoX6TLZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD0134D394
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081679; cv=none; b=B6yAAW818XIbCmn08NWoo4eNQIOoGEr7EufWdK9LfX5bszoD3D/r4K4hQ54KBgsdR6K149EeA4h9eEgqXd+h8j8gT57iGZJecMsRS7LjnsZ2aAfVoL6GhL4sALZRikkReZbePHaMXwhY7XGvN2Bd0b/yCsJSOG0qT849LWXsZdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081679; c=relaxed/simple;
	bh=Iwlb2KzOAUsWp1/2ne5jaA2bB1mN4zDZo4gjPoS+WdU=;
	h=Mime-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyZU14kxGMr9SQabO2jzxlJteSrjGuJH7+crlXzJdco2tJAcIY+ocGAwqwFVlm5mdNjMVDU61wNWU00E5PL/UWiQ65ksq4wLfzkJWUxwu2GZf7qMouCOa2J+0bsk0T6eg+ct3RrZboCgT77CyNKjxXsQglxqKkXqZfFRGERYUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lXoX6TLZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640b9c7eab9so251037a12.1
        for <stable@vger.kernel.org>; Sun, 02 Nov 2025 03:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762081675; x=1762686475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ciJ8ltYj16L6OcCIFxyx+RKgKBiqDR+LhiwFD9VIxUo=;
        b=lXoX6TLZ3X6OhtQJoN1ecM0EvigeWFGlqQX3oo5c3dZj3/UEtFKsuJfCY6bAyEGXZG
         /tyapMULUMjb4bnb1NgtQYMXWaVxirnB/qRiwJBmbc+7sIXZfBTym/C7jUxiUAMLqagP
         1XND+XRsI+mjCkTGczgUCgjc+EO38gc8oDnXcbmiBbRgR9DisKCbQCdTdFfJbIqLkTnr
         Hy9s0GsW3QckdB1eRORIXIIuoW0wlXooKOUgxse5btWRczk7q/XaaiczFOcUTN0mjjjD
         +v02zQvsVQpbEuMYQYlQIVRYtLbreg7HmRqzMJ1PfKLAjwtKxpU+FpUfK/vCMhE4I2pc
         Lkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762081675; x=1762686475;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciJ8ltYj16L6OcCIFxyx+RKgKBiqDR+LhiwFD9VIxUo=;
        b=lFzyCYa0ASnsYykC7QdGUhaYGEm3vLFg4hiI8oB7qgsoo9Ov/jPiAb+4IgSsei0h4+
         Jl3MXg5aHcxMH7OcW4d/lMmCxop9hgWvT3oPCWJQ1ilgsliE507PAARtneuhVfPup8jJ
         D3tBCs4c8rILXlP60tcdanCITlyjp048qAKBkZEBpvAokIg/SHD76auZSjECP/2SFowA
         umyMAOe8ufWK5AU+v+reaPqeljdmm4cp87kotymiPeqdskcnK8zbc4Hdq9gdbUQ3kXFy
         EujUHBei8p+9UFQHhPlEASqpMcg68tk6LaEDrliwQ4aaJyoxIcI6Alldi3E4YO9d8dBb
         SvXg==
X-Gm-Message-State: AOJu0YzC6bKdBcPSdmI2igm36nLvFz6UB7jO/lExoHBMgObUyoQNh4qo
	ka6oJ+6wAhbGY/xvBwJZIMT+qinXlVFtI2x1zQ8YDphp+FshCJT/Zx9OjIXOKWgTVcJgKwVIeg9
	k6knodVlphbM1B1excZq7U0/oPbM0L5G3xQ+FIRYv
X-Gm-Gg: ASbGncvsMaEV8m0kTghtbjohGsstE53GfrLU5RjQ/iPCT+9guHBIfdxDOd1D6ORj402
	RAayCDQgN/5fIDpclsC+1eeiC5sE3GdveaxKotlQJvkJxjs4v6fFU8dY0oURzp45dfkiKcqUd48
	7FkFJaonTmVn4UIiYUTiVOPKgoDqf7fwCFCkshGysXc3zPiPopZI+ua1y/3m+bVJ5GbB3TA7zTF
	0W5/rs+WLsgWrs8DDNjvWX8hvu9SuCnnZAcnr6pGGPgulxuM1KpQjSqS7I+ug==
X-Google-Smtp-Source: AGHT+IFtId39lDxEOoZUFlcoBwYD/1NQBZJtxCUsz0p5OSu83tgG4zgZDqWR9Kh3U9gJQEv5pIe1R+zpdQC9Cg/PGuA=
X-Received: by 2002:a05:6402:254e:b0:640:b321:9e9a with SMTP id
 4fb4d7f45d1cf-640b321a1bemr1546121a12.35.1762081674759; Sun, 02 Nov 2025
 03:07:54 -0800 (PST)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 2 Nov 2025 12:07:54 +0100
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 2 Nov 2025 12:07:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Aaron Lu <ziqianlu@bytedance.com>
In-Reply-To: <20251031140044.050079148@linuxfoundation.org>
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
References: <20251031140043.564670400@linuxfoundation.org> <20251031140044.050079148@linuxfoundation.org>
Date: Sun, 2 Nov 2025 12:07:54 +0100
X-Gm-Features: AWmQ_bloO0U9cVt1zx0nmqO8TIGQqJbFrRtmNfCpVvcLCQATHFfRii55pBTKiVc
Message-ID: <CANCG0GdKaxR4_0=O_nRUBj1LA2i=91bNj7M7N_k5P0F=ChGa3Q@mail.gmail.com>
Subject: Re: [PATCH 6.17 20/35] sched/fair: update_cfs_group() for throttled cfs_rqs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

On Fri, Oct 31, 2025 at 03:01:28PM +0100, Greg Kroah-Hartman wrote:
> 6.17-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Aaron Lu <ziqianlu@bytedance.com>
>
> [ Upstream commit fcd394866e3db344cbe0bb485d7e3f741ac07245 ]
>
> With task based throttle model, tasks in a throttled hierarchy are
> allowed to continue to run if they are running in kernel mode. For this
> reason, PELT clock is not stopped for these cfs_rqs in throttled
> hierarchy when they still have tasks running or queued.

This commit is needed only when the "task based throttle model" is used
and that "task based throttle model" feature is merged in v6.18 kernel,
so I don't think we need this commit for 6.17 based kernels.

Thanks,
Aaron

> Since PELT clock is not stopped, whether to allow update_cfs_group()
> doing its job for cfs_rqs which are in throttled hierarchy but still
> have tasks running/queued is a question.
>
> The good side is, continue to run update_cfs_group() can get these
> cfs_rq entities with an up2date weight and that up2date weight can be
> useful to derive an accurate load for the CPU as well as ensure fairness
> if multiple tasks of different cgroups are running on the same CPU.
> OTOH, as Benjamin Segall pointed: when unthrottle comes around the most
> likely correct distribution is the distribution we had at the time of
> throttle.
>
> In reality, either way may not matter that much if tasks in throttled
> hierarchy don't run in kernel mode for too long. But in case that
> happens, let these cfs_rq entities have an up2date weight seems a good
> thing to do.
>
> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/sched/fair.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4770d25ae2406..3e0d999e5ee2c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3957,9 +3957,6 @@ static void update_cfs_group(struct sched_entity *se)
>  	if (!gcfs_rq || !gcfs_rq->load.weight)
>  		return;
>
> -	if (throttled_hierarchy(gcfs_rq))
> -		return;
> -
>  	shares = calc_group_shares(gcfs_rq);
>  	if (unlikely(se->load.weight != shares))
>  		reweight_entity(cfs_rq_of(se), se, shares);
> --
> 2.51.0
>
>


Return-Path: <stable+bounces-172466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0367B31FDF
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 18:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD93B1D63737
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2A21A428;
	Fri, 22 Aug 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M5z7WXcW"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A4623C516
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877986; cv=none; b=J33YoV9uQ1miOBY0jBJt07yuPw3lnCeDV6hOOU9tBpfp8qVVQAbaMogjFEQECvdUf3zjuvEteoaM7Vx5dhinwe4fWObkk+99IUuLLyeheI27yGcqoNxUINVVlQyLsrKkWHP4aN0kThET0nAU4ng6GDLcMn1zPxwlkSM8OqdZm0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877986; c=relaxed/simple;
	bh=gLXeHHwaBzBx+uXpYTKL1oyTokHqs+UE97GcEayCGCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYlgXlAIJVjQK76eDAbO0VTNIo9sz2wFeCuLp6dyKYCGKjLCxhy/XMdpS34d8mxDXyReGU1Grd+Tqq0TAVOswr5mQ3D8E/IObrxULTTEuL5VarSP0s80voWePtBQC4yY18tgcY3dap96NQTQzJiAfJXmLo+LOU8NWzVYrAc5AF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=M5z7WXcW; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-886b12910abso26244439f.0
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755877982; x=1756482782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MxoWX3AhGm6pAUMYpRExeT7r0tsCMCQfXpjWf5wpaxw=;
        b=M5z7WXcWLWh0kCIXFdXMJaPxxHu+TOUUIftLFHWLqfdrXRgHvIZPP0KOAiepbCG25a
         9TllItoQOR/wtKIm/fjTK3ndxsNnGAGnQgLBIFJSyQeAuK2Ni3YAI+/FJlAn7GfqnFqs
         aH6nR8qlmyoGT5NSvgvwz6VFWy6fZeG3m6u6ASInznZ7UtIWlJM1Yap42J+pNCUFYqvP
         NvsSqLv0+u8PzLLJmPcDP195XOqXgHdbN8ryAxHOc55osP0dc4SA6Jzq6K4rQ1HVeaRv
         h564qqgZNC4sZO+eNPVVAmkOGC8W5mNJYpDmEx9ylqVqsQ+lWNf3+y6jMIwKMzV4iMZI
         b32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755877982; x=1756482782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxoWX3AhGm6pAUMYpRExeT7r0tsCMCQfXpjWf5wpaxw=;
        b=QYnJ46poLh3IyhApS/UupcPaHGHbBojTSu/Vws2URf2JjGO46kM0OUrDgW6ETxHQkA
         e3MxpXWFwkl/gZvEQ3VJKD1Q4eXyEtJaFM2ZoRvj6jpgFGrPlfjmEUtdGREY5NIlG5q7
         xssCguWGjqMP96Pa5ARqsuLYaGicKFt3JvOe1lJ9yKAptxKj5RBYUss5M0YyFPsIfUQz
         PVOey7kUAz7noEmnkMHfjCCOaZ8CYSHkBNR92V98MCTr6NrOrdcPLPA9HEc0PM+tVQGP
         /bQqY+bOa+Bwtu6dOJoB+wY1h+La/K0llrR6PCg0WFusPEladsUxkaYqBJpWmLzVBk/h
         cvhw==
X-Forwarded-Encrypted: i=1; AJvYcCWkbdR3S0GMQ/IzmZh+FRh8zLR0SKZeQL4hz+loTE7SORHRBCPewtziMxKq6tPh9UT6mmZPd+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyonzNmVVxIcecw8dBZ3Lj17Dx/ZV4M6xy18Obn7g5yNMUFnjAN
	tR1wDyCKmIhuuvP9DfLDeufE/W0SFpbkPFuH0Q6xm6KX1QqTvaMQRV/j72zal9MeL+s=
X-Gm-Gg: ASbGncu0y/DoSRnMS456Ml/M5OHZkTjvFGHSsKk7enW2/u7q4B9YlEShutLqC9+0Zn8
	byVvwC7Scy7wUXQiaaJ2YQ8WiAv83MZ2DY41sWaJRo/2lHc5NjIWFp9zMk8QCxq1Tc/U0M2r9iu
	hxcuzfPKuRJQZWIvhAofs6+tYG+qMOSXsKCgSKB3xa3W9S2biXWRJ9i3fKTe1kLZdKaZJn/aWEX
	c8nEXH97GmAkUPfdJxbB//GoEswJ3K9R7MZ/zxJ8bmOupXp6jQymxdBbHkyOb4rmW8SigM2PgB8
	0k3Xf0KSrRNKyRlNousL6ZhHf8tchoP+/n1LiVUsMvVc5EUzW8x/4ft4ai2g75KVqwpEuj+2dtJ
	gHsmFmfsub5PITCb1kYM=
X-Google-Smtp-Source: AGHT+IFk+LLGCTiMsUR6fvZSX2L5WLPHY4PuL/sPJk6oGk0HelVrRXJcWmvtpATxHn9bBfTrAhdwgA==
X-Received: by 2002:a05:6602:4c10:b0:876:19b9:1aaa with SMTP id ca18e2360f4ac-886bd1cf44emr518095939f.9.1755877981727;
        Fri, 22 Aug 2025 08:53:01 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886c8ff704dsm16612939f.27.2025.08.22.08.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 08:53:01 -0700 (PDT)
Message-ID: <7b243520-1d95-45bc-b0d6-0ae34fd54e8a@kernel.dk>
Date: Fri, 22 Aug 2025 09:53:00 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/net: commit partial buffers on
 retry" failed to apply to 6.12-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: superman.xpt@gmail.com, stable@vger.kernel.org
References: <2025081548-whoops-aneurism-c7b1@gregkh>
 <75f257ff-21d3-4eae-afa1-a25cff16abe0@kernel.dk>
 <7a97e700-9ecb-4c17-b393-0f8a31c398e9@kernel.dk>
 <2025082232-scorecard-fame-d24c@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025082232-scorecard-fame-d24c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/25 12:27 AM, Greg KH wrote:
> On Thu, Aug 21, 2025 at 03:46:33PM -0600, Jens Axboe wrote:
>> On Fri, Aug 15, 2025 at 9:35?AM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 8/15/25 9:26 AM, gregkh@linuxfoundation.org wrote:
>>>>
>>>> The patch below does not apply to the 6.12-stable tree.
>>>> If someone wants it applied there, or to any other stable or longterm
>>>> tree, then please email the backport, including the original git commit
>>>> id to <stable@vger.kernel.org>.
>>>>
>>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>>
>>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
>>>> git checkout FETCH_HEAD
>>>> git cherry-pick -x 41b70df5b38bc80967d2e0ed55cc3c3896bba781
>>>> # <resolve conflicts, build, test, etc.>
>>>> git commit -s
>>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081548-whoops-aneurism-c7b1@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
>>>
>>> Trivial reject, here's one for 6.12-stable.
>>
>> This didn't get included in the release yesterday?
> 
> Ick, this got dropped somehow, sorry about that.  I'll go queue it up
> now, thanks for noticing.

I always check when I drop the private patch(es) in the branch and pull
the update, and when I did that yesterday it was a wtf moment.

-- 
Jens Axboe



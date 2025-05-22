Return-Path: <stable+bounces-146046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E722AC0614
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 09:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C641BA4245
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 07:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9224222595;
	Thu, 22 May 2025 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="Nvm7S6mQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94463223DDF
	for <stable@vger.kernel.org>; Thu, 22 May 2025 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900093; cv=none; b=VplEliyfzLcuHDlur0nxoz1sEs2vqsL6PQntSznj+KZKfHQFmhJx3ZCUwFGTx1+UITJEcv6z4seDBV593VlwEV9C+8W7oeQA5sZZvR27ALpUehI2jlR/75ChYsoMJBDoNFPyoYAUgCE/smqTpB+KiXvgDmLll97Zhx27n+CprtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900093; c=relaxed/simple;
	bh=s5rXhKN8fm04gH3zjEgZkQxi9KgcHSpKFXe4KOmjYLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4TmATKnDWnocMsFFj3YjLlvBqshD6C+ar54Pl4G6i9PLzxcMYcqQY+diHYZBB9FZt4qMux7NR9uJUT7Mx6GZY/pywf7d+h9MaRBceap1qACcbJJBw6FmlUYk3/pap7BrxB2ICXDgSHnUmVjWcTMUhWoPqKW3P31lAFvUIe4zF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=Nvm7S6mQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a36e0d22c1so3097268f8f.2
        for <stable@vger.kernel.org>; Thu, 22 May 2025 00:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1747900088; x=1748504888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5tHoEF081hTBrMTXmDGBdRAELQ7rm+VvY6CJYQNJKY=;
        b=Nvm7S6mQpx91wCclT98EFgY6hXunLTPv617B7XB4HTnfa6p23cGYjVxYkihU04yIVG
         ecKW+AgLcnRbp8s1PaCCMmi+LxnkYkYn5Br47ksWaKJroo1Yv0wZdYSE49toU6pEXaOc
         I/IddaBvLFuaY4v6UQHdpR0jkNptRlVYT/bUbRIYWWjcOfrjn0ef9fLCwup8nHdnfsZi
         J63HUDRDbBvDQkBHz6DPBz2a0QLSeTHIQZbte4bnDPVM4CsScICcPuspePCQjKx3Ul1X
         EUDNFGyfMNBaI1NtWnnQ4QHZ0B/v9wVuT6+XQvT03ZaK6gnIrZ/gqgXjTBr589bo3mej
         muyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747900088; x=1748504888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5tHoEF081hTBrMTXmDGBdRAELQ7rm+VvY6CJYQNJKY=;
        b=Mi4a1OYBI8bxAMyHCaUvHYsPKn0eAgs3ADSGDVYsaclZMJJ1Kk2ur3NQC8utuRtWBN
         tibk+MRwuDX9vxfOObjP9ZRyoO+Zwgj8R53U3eZigjHWCIXpyav9ChWwWKhydLMXuf7Z
         NGhZkpuOkZNTwWNe1LjqC1a9L4bQR8tQln6WVGio8DMpS01FOvIR7QNzAIw5M8vJ1a+j
         /X2vESvaTYdUDGnwgIH5bNmyHUj4kXlPwACH4Yvcg5mPNesrMvAZ6wDP8Hy7PsSt1TlD
         QhdtRdBcyl89l0lizIjQGJ430+F6bx/Pm467UD0aRGyYQmSzkfhMBm4Pn8zQJKj5AQB1
         2oXQ==
X-Gm-Message-State: AOJu0Yw09O7qhF83eVYNQMZTnA1my57BIWLnDHAy11Uqfmz+w11nlZKT
	UR3u6olTzarTeuXp1SCAzxIbZLpqPHe+ZNU5skA1pFF4cWz9ldixfof0ajr5nvCGQHY=
X-Gm-Gg: ASbGncuOtsU9781yUJrzJrSHPBpf3TIjTcEeBVrcoWZULzKSe0yb8PN/rqFkvQ9bYDh
	GWDtcAKUg92dTftKjjij+Kw0j2Dzdez93AWgLVQEAULfOYsL08FxQ6OZ0zCctr8fsscJUzTgdkp
	cEstHj7I9LPsxYW4n55cIqiPSZ2Map5xkR2fZodN9+LKRSJFujIIjp+cmIBjfRFYvXGurceTAfd
	DvFrTD7KTwdMdHhq7XbLymRwiIXr6hgyznC0GmSrIkPeKI5FNoAeSNp4RhTdFBMlyUprMrFao95
	2ArLMA5dpAv7OVc0pqeJTdac5Ck8kk3hGH29mRPX33cP3J1yg0RbWYk1ctX1mo5UVA==
X-Google-Smtp-Source: AGHT+IGbkJMnGYZ8P7cMd1tkBKxTGBPIh2TO5lh2gkJ9zR4cK2cD3xOSpXi64n3ioGsF9v/Q8vZu2g==
X-Received: by 2002:a5d:588e:0:b0:3a3:772e:e824 with SMTP id ffacd0b85a97d-3a3772ee85emr11517266f8f.26.1747900087533;
        Thu, 22 May 2025 00:48:07 -0700 (PDT)
Received: from [192.168.0.101] ([81.79.92.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3620dbc6asm20832300f8f.88.2025.05.22.00.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 00:48:07 -0700 (PDT)
Message-ID: <dcbc785a-2c19-4caf-b33d-b9c5cc315e0f@ursulin.net>
Date: Thu, 22 May 2025 08:48:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/i915/gem: Allow EXEC_CAPTURE on recoverable
 contexts on DG1"
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Cc: stable@vger.kernel.org, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20250522064127.24293-1-joonas.lahtinen@linux.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250522064127.24293-1-joonas.lahtinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 22/05/2025 07:41, Joonas Lahtinen wrote:
> This reverts commit d6e020819612a4a06207af858e0978be4d3e3140.
> 
> The IS_DGFX check was put in place because error capture of buffer
> objects is expected to be broken on devices with VRAM.

I don't quite remember the history and it is a pity 71b1669ea9bd 
("drm/i915/uapi: tweak error capture on recoverable contexts") did not 
spell that out but almost made it sound like uapi disablement for some 
reason. But if there is an userspace fix, and you say VRAM capture is 
broken then that's fine by me.

Acked-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> We seem to have already submitted the userspace fix to remove that
> flag, so lets just rely on that for DG1.
> 
> Cc: stable@vger.kernel.org # v6.0+
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index 7d44aadcd5a5..02c59808cbe4 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -2013,7 +2013,7 @@ static int eb_capture_stage(struct i915_execbuffer *eb)
>   			continue;
>   
>   		if (i915_gem_context_is_recoverable(eb->gem_context) &&
> -		    GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 10))
> +		    (IS_DGFX(eb->i915) || GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 0)))
>   			return -EINVAL;
>   
>   		for_each_batch_create_order(eb, j) {



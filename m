Return-Path: <stable+bounces-194826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D67E3C5F7D0
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 23:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E70435EC22
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 22:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B5D30B529;
	Fri, 14 Nov 2025 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M448Fyck"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A430ACF3
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 22:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158487; cv=none; b=VkckXc2nIGboivfVOKy/ouRllMCct0tJlcNkMvQ7K6fD9GGWTfGbhfBTVRyAgTk4+arox1g1f26sUGto+4/VMPwSZSbzkgp2jOlexgU7B0llrBnkMI8RncnXoJoHpDFmYgD/V/AxkBJGYJpVX45uXGn7NE5MXAClhrXKTNyERfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158487; c=relaxed/simple;
	bh=AeAR0M6mN5y9tfSb089vll0wM+bX8hpgQUBfGyUAPbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLXR6JxepSCzVZL+dJk1xGVNfQ6bwsL/cIKlLrvasaWCA34rJozPeO6grm20z3RIS/ciKdmVn/3VbvWgeCTK4grBJx4zQOGhMVfyPYp/6/XMw9wHcKYDvy0qGN/w3f6V0ahOA0csgna6P2zk0x9GodM4RyI6KSZviku7sbE4CHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M448Fyck; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso18028875e9.0
        for <stable@vger.kernel.org>; Fri, 14 Nov 2025 14:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763158484; x=1763763284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7NTstYfdgFQcU+ZeosUKnP918N0qC2sjoB9U+WCqJg=;
        b=M448FyckiJbWILnucjl43yiDJZmCTY1lLssr8N4vIS1fsENpsyfe0isqPJRD8WK1Zv
         nvwaK7HJpwABbNX+Zy0uSOYHMyzl6qeEfQxjxCR9yHE7xEnCyuAXadDF99Qxu6HBbmZJ
         iH08XCCgelqR7TDzfpF35zoswl3fo4zyW0FXDQCvcw2ZLtaZJApqoiNkn4nYlKpzLzOT
         /D8Z0Yi+rvBc2saUW80gxuhBfcjMd9Y0JE0KHkQOxXFQmqAyKktip3ABkLXe0Gfq0tpA
         OdXruiv0r/dQRMN2f1FoDguYtJ0ihdXEqRD21iKrbXsF/jKjRb4LDzcF/O8H9FIVryju
         ziCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763158484; x=1763763284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C7NTstYfdgFQcU+ZeosUKnP918N0qC2sjoB9U+WCqJg=;
        b=LaixRACE5GBHm0hLTUiBMGVJpg8XIEzBe3JHQ6QdOTNskFE4sksU2KPPk3ATxU8c8q
         swLUvCxd65TAQU0bpDErDZ6Voiio2Z7wEXPAcqUAVrZATeVOC+MHclNvCOdipfjnyaFG
         3PCtmNpvmG4iaimjllvfjQ708QQMPWUuOcuw1b5BVoLiBcN5hXLpG1yivDhJfL+EqvPJ
         9vkZxh9E/2xJX+fdCWjVaYf+VxcFDLRZZH/Pu7S0APNjadE8X1O28HFj0BeTawuPpXpQ
         g4/2kY0R/kdP0D0xr7myzcVyo22+ivwVOY9ssrt+0AbntUwESpZB9ldkDjpGkccKw8dY
         C+6w==
X-Forwarded-Encrypted: i=1; AJvYcCWIBVT8MoMezJaOlUp+LWBXQAl5PFwVBCbZQaKdeX0gViwUv7mm0reofBmF0HlAQ5SeUX/95To=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhykrIdB2iotYtWBEsRiGU+AVVqQrSjkJ+ndhUZbsEo22xoeZV
	8xtjAPqJBR+TNXJT4YpcezhX06YF9IG7KYAMeeOSIJCiKP7+vb6aXGIJ
X-Gm-Gg: ASbGncvxOTkqMgymw4V8vkyC4czUUEM9PlNWIgoiFx5nlSB+fuyNfQXsJgRXrS8DsTa
	MYeXREJRfNSlVH422G6t35LvpSbXJeoYhmIduDlaJ3L83s1KvThy+r7Y5wjXYfp0isxn6H6dXaA
	IL7Pfyny7vYMIry3LnjRAAit7wf+q1mWSXCsqS3aiydYyKtl1/Q1NZYZUx3S1Tdr0rkztPsGIEh
	L0hnYmmjrDWjn5R/TZPAlJaQdmqMUrdr2Q3HBocPlxoH9En0x84fKwQA5ypRLOb2CJFUPfLX80N
	7IV9ssslmfA/N1oyB1ij3oTy81w35HDH+hOk+Hv5PfJLMSfMrwoqOOxr0oZrhhza9wen6eg2rJt
	2pKxcaBJTD4PFKGJuCi3rc4RP3+SD+GPh6Zf54ZqdzKNszG/MFsqlUIp49nxFw/qwE/8pmE5vJp
	5cMAKgPfJOo7o23r8r/H0+qWbFxrRvzXmh0S2T4PlKIyUTezMOH4nD
X-Google-Smtp-Source: AGHT+IE0XeSBj5bp4627BP3nAgHaoIXuFpJ7/yfefA7DkOxrWwspxLMHxhrDGXhBwCSWL97AvT4zYg==
X-Received: by 2002:a05:600c:3550:b0:477:7d94:9d05 with SMTP id 5b1f17b1804b1-4778feb0f3emr46454605e9.35.1763158484005;
        Fri, 14 Nov 2025 14:14:44 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bd0f761sm55370795e9.4.2025.11.14.14.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:14:43 -0800 (PST)
Date: Fri, 14 Nov 2025 22:14:41 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Chuck Lever <cel@kernel.org>
Cc: Andrew Morten <akpm@linux-foundation.org>, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, speedcracker@hotmail.com
Subject: Re: [PATCH v1 v6.12.y] nfsd: Replace clamp_t in nfsd4_get_drc_mem()
Message-ID: <20251114221441.49481cec@pumpkin>
In-Reply-To: <20251114211922.6312-1-cel@kernel.org>
References: <20251114211922.6312-1-cel@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 16:19:22 -0500
Chuck Lever <cel@kernel.org> wrote:

> From: NeilBrown <neil@brown.name>
> 
> A recent change to clamp_t() in 6.1.y caused fs/nfsd/nfs4state.c to fail
> to compile with gcc-9. The code in nfsd4_get_drc_mem() was written with
> the assumption that when "max < min",
> 
>    clamp(val, min, max)
> 
> would return max.  This assumption is not documented as an API promise
> and the change caused a compile failure if it could be statically
> determined that "max < min".
> 
> The relevant code was no longer present upstream when commit 1519fbc8832b
> ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()")
> landed there, so there is no upstream change to nfsd4_get_drc_mem() to
> backport.
> 
> There is no clear case that the existing code in nfsd4_get_drc_mem()
> is functioning incorrectly. The goal of this patch is to permit the clean
> application of commit 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for
> the lo < hi test in clamp()"), and any commits that depend on it, to LTS
> kernels without affecting the ability to compile those kernels. This is
> done by open-coding the __clamp() macro sans the built-in type checking.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220745#c0
> Signed-off-by: NeilBrown <neil@brown.name>
> Stable-dep-of: 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed_by: David Laight <david.laight.linux@gmail.com>
> ---
>  fs/nfsd/nfs4state.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Changes since Neil's post:
> * Editorial changes to the commit message
> * Attempt to address David's review comments
> * Applied to linux-6.12.y, passed NFSD upstream CI suite
> 
> This patch is intended to be applied to linux-6.12.y, and should
> apply cleanly to other LTS kernels since nfsd4_get_drc_mem hasn't
> changed since v5.4.
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 7b0fabf8c657..41545933dd18 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1983,8 +1983,10 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn
>  	 */
>  	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
>  
> -	avail = clamp_t(unsigned long, avail, slotsize,
> -			total_avail/scale_factor);
> +	if (avail > total_avail / scale_factor)
> +		avail = total_avail / scale_factor;
> +	else if (avail < slotsize)
> +		avail = slotsize;
>  	num = min_t(int, num, avail / slotsize);
>  	num = max_t(int, num, 1);
>  	nfsd_drc_mem_used += num * slotsize;



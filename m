Return-Path: <stable+bounces-59122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C7F92E8F9
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 15:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B1D1C208E8
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 13:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9167215EFB6;
	Thu, 11 Jul 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jC2jnlXX"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17316C857
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703293; cv=none; b=TnbFCwJCkmnWtvdfSylY0ApW7OoNAwnMxGHnVhEcrqDn+ORmtRZgJwQFeAg8mjDi8kfq1H9EoBoUJCoWcboc6gbjXXPw1QseXQTT1oq2nhUueEUKcFb28W6ZUdMaCoKvB1hUq4H0a2tXVm8+cHBTjBkh33hS1+kK4ddBETsUEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703293; c=relaxed/simple;
	bh=toX66UYAZYqpCVKVyXRqHzR8N6aD+uqvP/MHCXctlAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bctdGU5/NhTqywQzhWhcfG5L0/M767CcKpb0+xzdp8x7A5/l2VxVSSEESjCbTMVEXZ90CFa1jfj6eKpoULRkj6mUS+p9l5Qel/cSF+Rkh9UvT3hyXyuiBqbEJe66jRRRhLBWK+wGfbSlYWgK9znCvohZoL3V7Q0PZqQcrlg8LqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jC2jnlXX; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f7Ctq/lLP50wIXaiTDSHG4T4+belqO4CtXtJoZYkhY0=; b=jC2jnlXXh7/1IG97QxPa345X6/
	hUQwrKRtgJtkSkgzcvEPaNhqAMUKrgdXnDHVKas3srXe/1KiZapmvZQTd4njoz9ObcAfFAn5zgxHe
	1Mkq5W0qlPXuTss5bBfA6fhLT7yWabp7+bzhWnU9PX5bOh0v17VLetT2j4VVQbtzF7juvcw9UXAhg
	iZMEJk9I3T5BKDBAnXOd62bgmg/x+TaDwHAUo6bBsVQajYTjOzczjtZ4lRB4SLy76OeoHmOunF/p7
	UriThI8ZwvoGMOrhQK6WMpx7mop2ourF0dOH5PfbknWg50mjhrEO3KPvh7BOgSELyDMC19NRrPlW6
	e4iKxIlA==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sRtWn-00Dhaq-NS; Thu, 11 Jul 2024 15:08:06 +0200
Message-ID: <d2f04561-871c-4020-af4f-3718ac4bfa84@igalia.com>
Date: Thu, 11 Jul 2024 10:07:59 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/v3d: Validate passed in drm syncobj handles in
 the timestamp extension
To: Tvrtko Ursulin <tursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Iago Toral Quiroga <itoral@igalia.com>, stable@vger.kernel.org
References: <20240711091542.82083-1-tursulin@igalia.com>
 <20240711091542.82083-5-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <20240711091542.82083-5-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/11/24 06:15, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> If userspace provides an unknown or invalid handle anywhere in the handle
> array the rest of the driver will not handle that well.
> 
> Fix it by checking handle was looked up successfully or otherwise fail the
> extension by jumping into the existing unwind.

I'm not a English-native speaker, but again I need to say that it feels 
to me that it is something missing in this sentence.

I suggested "Fix it by checking if the handle..."

> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp query job")
> Cc: Maíra Canal <mcanal@igalia.com>
> Cc: Iago Toral Quiroga <itoral@igalia.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>   drivers/gpu/drm/v3d/v3d_submit.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index d626c8539b04..e3a00c8394a5 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -498,6 +498,10 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
>   		}
>   
>   		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
> +		if (!job->timestamp_query.queries[i].syncobj) {
> +			err = -ENOENT;
> +			goto error;
> +		}
>   	}
>   	job->timestamp_query.count = timestamp.count;
>   
> @@ -552,6 +556,10 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
>   		}
>   
>   		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
> +		if (!job->timestamp_query.queries[i].syncobj) {
> +			err = -ENOENT;
> +			goto error;
> +		}
>   	}
>   	job->timestamp_query.count = reset.count;
>   
> @@ -616,6 +624,10 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
>   		}
>   
>   		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
> +		if (!job->timestamp_query.queries[i].syncobj) {
> +			err = -ENOENT;
> +			goto error;
> +		}
>   	}
>   	job->timestamp_query.count = copy.count;
>   


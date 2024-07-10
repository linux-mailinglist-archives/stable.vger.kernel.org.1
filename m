Return-Path: <stable+bounces-59028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2823192D6B6
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 18:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80891F2136B
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 16:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A04194C85;
	Wed, 10 Jul 2024 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SaOAZbhH"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42323193445
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629578; cv=none; b=NBPF97oOhTJHvkaN0b/ZnIulWTJ13A91sPMAShPumHEUa4S9kRSNUp/IiGsgJy6Bth/oA2Wr4QxkI6gFYxtA1EwX3/3JNh1gK10e4Gyq9KyQgqM/ujE+xQMi4HwyD9kjF0ZLDbR1MrX335to7ppQQSFkUjgqLWhcDQU9Xsbq7Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629578; c=relaxed/simple;
	bh=3npt7ipPLSXp3U9uG7+NE/wVSm2F6WUpizJ6ODZpOes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huzt8CksolMyzThsszclIM7meOZMFT+O1FNsnshkPNN2s8E845iEIDriNcCUWPDllY469Qr7v1EC3lKc1qG8TyLACVO5V1g6hqKkWnn/o7ofi2tRXcF2xo9SCA6a8rt3JJT9Qt36qDOQrkKOyGbAvOp39Kz03RwBs/YsZKYipuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SaOAZbhH; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VyOGG0qBiEBBcnMdvG8fEUcGJthJSAwtuDEMgOAUAAo=; b=SaOAZbhHLzAgovpUwk5aPKvioZ
	x1glWArBPnRG7HMZjkdvRG3+XgH4RLzfwcHV7aBdpzRj5pTcdJ3nEGeMPpGyFy/EBso/wR49M6lAM
	5T9Y0/bzTJx/zCnvW6n6lKnpEojSKNr3tbl2ZHUggJ6EWEPIVzU+AMiPyBDn3eWtmORr9HNZl+zF0
	GDOPvkVgdxrPO4/JjYlh3kEnUVLGm+zIHpU8xXtyU+Lpbx0mygn+rNGas3RgBgZ0Ix3jQKyoASwHC
	zpQuNjH4Mp4tDlZ0/YLrg9d/heNzgPuyvT2XfXfVJVJ4yV7nH399QUN9oioVOhxF0Ebjmg7N8f9Ah
	EOFz6jcg==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sRaLh-00DKi5-U4; Wed, 10 Jul 2024 18:39:22 +0200
Message-ID: <84d22fb2-c9e9-4354-90a2-675c0b42cb60@igalia.com>
Date: Wed, 10 Jul 2024 13:39:14 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/v3d: Prevent out of bounds access in
 performance query extensions
To: Tvrtko Ursulin <tursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Iago Toral Quiroga <itoral@igalia.com>, stable@vger.kernel.org
References: <20240710134130.17292-1-tursulin@igalia.com>
 <20240710134130.17292-2-tursulin@igalia.com>
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
In-Reply-To: <20240710134130.17292-2-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/10/24 10:41, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Check that the number of perfmons userspace is passing in the copy and
> reset extensions is not greater than the internal kernel storage where
> the ids will be copied into.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> Fixes: bae7cb5d6800 ("drm/v3d: Create a CPU job extension for the reset performance query job"
> Cc: Maíra Canal <mcanal@igalia.com>
> Cc: Iago Toral Quiroga <itoral@igalia.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>   drivers/gpu/drm/v3d/v3d_submit.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index 88f63d526b22..263fefc1d04f 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -637,6 +637,9 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
>   	if (copy_from_user(&reset, ext, sizeof(reset)))
>   		return -EFAULT;
>   
> +	if (reset.nperfmons > V3D_MAX_PERFMONS)
> +		return -EINVAL;
> +
>   	job->job_type = V3D_CPU_JOB_TYPE_RESET_PERFORMANCE_QUERY;
>   
>   	job->performance_query.queries = kvmalloc_array(reset.count,
> @@ -708,6 +711,9 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
>   	if (copy.pad)
>   		return -EINVAL;
>   
> +	if (copy.nperfmons > V3D_MAX_PERFMONS)
> +		return -EINVAL;
> +
>   	job->job_type = V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY;
>   
>   	job->performance_query.queries = kvmalloc_array(copy.count,


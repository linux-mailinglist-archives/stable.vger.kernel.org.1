Return-Path: <stable+bounces-59033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB2D92D72E
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 19:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6408281919
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 17:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436BB194A59;
	Wed, 10 Jul 2024 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UwdL931F"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A29819249E
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631412; cv=none; b=pJfx1Numf0q9hi8JVtIeALTsBleECdNlcExfuhZAOsLXxZdSbGK89unfPv5mgXpmKsJeBciLu1fSC73PqQu7Y0ozm70nq5ja97M9vFcBADDjhDWkVy17GIEBONEAVsUgYollDJz5loK81+WJEmlmERe1rKSNcLBVBArZGTlmlac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631412; c=relaxed/simple;
	bh=rQeoUj5OiWEO+XnL/TAwd4A6vRXdRqzMeQUrooSGj5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OS47OCk8Olp+HUQ69udXRYqncbIojz/IqSoajMBM3AfLq9z6GnjxeKGb37yAav4oEDOGvZDt0zAso3paz2IlWAU6y5OiguqYRGle185t6XQpfSbk+ycMIjjB8i9+06+3nGRMtoKJg2QJMtpupFhkzGEucrtHZgDYcPY3WdGmqXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UwdL931F; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W960oQS6oN8rtnoJrGvR0wCSj4QLBhNosc7fVn8jr90=; b=UwdL931FqG5mSVJ6QTJ8ZtsvhL
	iGl5VFYZaJFnXSaEgyPYu9SH6Yofzz0sSyv5Ot9g0C3ERQ9nWEcQkKraLx/fG7AGLq2uNTGuWiFu1
	uVf/ukiE1kDwSWwk45/vGSjGPhfIkK0dOmV9fg1p/MP/CDtMx+yEx7rwMTURwDtTBb2UuDGIYMo+s
	5/bEqh+Ah0/XCYH2MAM/fwFdHmo2S/+TIKUVp2e5A/sUwyvMyb7SMadAYU4asH7amor5ljG27OrgI
	0fXYtlhd/2UYppTDRAUFonvRnxoZ+3K49TZorChPjIudO67K1NPjrosc8kvAv0vaoni4FfP4dlJ01
	5eeN5wJQ==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sRapP-00DLKH-LT; Wed, 10 Jul 2024 19:10:03 +0200
Message-ID: <6545484d-fbd0-4591-8b78-ba2a2086dcf6@igalia.com>
Date: Wed, 10 Jul 2024 14:09:58 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] drm/v3d: Validate passed in drm syncobj handles in
 the performance extension
To: Tvrtko Ursulin <tursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Iago Toral Quiroga <itoral@igalia.com>, stable@vger.kernel.org
References: <20240710134130.17292-1-tursulin@igalia.com>
 <20240710134130.17292-6-tursulin@igalia.com>
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
In-Reply-To: <20240710134130.17292-6-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/10/24 10:41, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> If userspace provides an unknown or invalid handle anywhere in the handle
> array the rest of the driver will not handle that well.
> 
> Fix it by checking handle was looked up successfuly or otherwise fail the
> extension by jumping into the existing unwind.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: bae7cb5d6800 ("drm/v3d: Create a CPU job extension for the reset performance query job"
> Cc: Maíra Canal <mcanal@igalia.com>
> Cc: Iago Toral Quiroga <itoral@igalia.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>   drivers/gpu/drm/v3d/v3d_submit.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index 3313423080e7..b51600e236c8 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -706,6 +706,10 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
>   		}
>   
>   		job->performance_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
> +		if (!job->performance_query.queries[i].syncobj) {
> +			err = -ENOENT;

Same from previous patch.

Best Regards,
- Maíra

> +			goto error;
> +		}
>   	}
>   	job->performance_query.count = reset.count;
>   	job->performance_query.nperfmons = reset.nperfmons;
> @@ -787,6 +791,10 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
>   		}
>   
>   		job->performance_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
> +		if (!job->performance_query.queries[i].syncobj) {
> +			err = -ENOENT;
> +			goto error;
> +		}
>   	}
>   	job->performance_query.count = copy.count;
>   	job->performance_query.nperfmons = copy.nperfmons;


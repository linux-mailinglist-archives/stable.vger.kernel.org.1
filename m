Return-Path: <stable+bounces-59018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8292092D350
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 15:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986EC1C23316
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAB918FC6F;
	Wed, 10 Jul 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jWZWM4tp"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2748D12C491
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619161; cv=none; b=BzFeAZz9fhdzPRC52Ogjf/NwUVV/nIJHaqlopK9w7isSsDJy+wmNI/9afjbbLOZ333vU5ESjErzE2RAviRn2hFdUvV3quDkyttU8pvVqk5nUNGNHeKkmsbxGhA7LTtJcRYi8PSJz3R7Uhfb6L0676kziyLg5cwLjXg9epeKKF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619161; c=relaxed/simple;
	bh=uSllHNvCa33fLjUOL4tQbIte6QDhNUse2qdvAxMvjuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ghp8kCw7zzo1t4Q7Fo8CMA4vnEyLppZgg3zxnPbD6vA7sDI4as239g3L9qOIY0v6RS496CifakJ6g/7YSomgzVNohVkMnt6js8kquU0hJRBsyCSKTqfi6bETKJuk6aVBIHrXhFcmhs1BpjGRCWFBUNjyvkrhumjR5wRWDu92J30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jWZWM4tp; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4kAYpNXLlLXB920zUa/04CWkfwmM7xDwjfJIpNAa8C0=; b=jWZWM4tpC02OfxR0wJOneXgiqm
	xs88iHUXWLvxkG8TO2Iz2ik60TMY9ic5MyKkGxBUO8hHwp44lZm5ZA5/ydfTXDpcLik2c15k+cXfz
	IIx7uKzyu/yHqTucYJHKs3PloXoU6dlVLJyVdg0YsXRoFIwT08tDrP8SzTNpj8ghN3F6ZJfMM5yFb
	j5No23uC4D8aK/QtEGKDlIvJMZjWUCX1vIpKMnL2MDBgj7AByroi0nl2tiMQQHiGoBYfB91xDhJf9
	JyGfhtDpkiTgDQ3OjCRxITNfoLXA1HMzkaBRPiF/auxqifIV9u8UCgj57lQ6UopA/H7I2NoBQf5dF
	z8mgfgdw==;
Received: from [84.69.19.168] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sRXdr-00DH94-Ey; Wed, 10 Jul 2024 15:45:55 +0200
Message-ID: <fe477eb3-f702-40ca-ad94-6862e8692e30@igalia.com>
Date: Wed, 10 Jul 2024 14:45:54 +0100
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
Cc: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, kernel-dev@igalia.com,
 Iago Toral Quiroga <itoral@igalia.com>, stable@vger.kernel.org
References: <20240710134130.17292-1-tursulin@igalia.com>
 <20240710134130.17292-2-tursulin@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20240710134130.17292-2-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/07/2024 14:41, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Check that the number of perfmons userspace is passing in the copy and
> reset extensions is not greater than the internal kernel storage where
> the ids will be copied into.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: bae7cb5d6800 ("drm/v3d: Create a CPU job extension for the reset performance query job"
> Cc: Maíra Canal <mcanal@igalia.com>
> Cc: Iago Toral Quiroga <itoral@igalia.com>
> Cc: <stable@vger.kernel.org> # v6.8+

On this one I forgot to carry over from v1:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

Regards,

Tvrtko

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


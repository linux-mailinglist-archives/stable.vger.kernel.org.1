Return-Path: <stable+bounces-151530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D652EACEF8B
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 14:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A626A17332D
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 12:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010752144A3;
	Thu,  5 Jun 2025 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEXf3ZLq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E91E7C1B
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749127857; cv=none; b=VSThG3zh8n6N+tPn9r3MLuay8w46LSjkk2l9NJl+E/QqAlFDCtXUc8oSqpEdZ+w6sXDNRLfCE5bjKtOYq9FBBbClGoF3q2AcxPKnN2rrNebhS7qN/WxKYgjZA1LYSb9WphAcZpPIsJ1nUoOFf5cLuppCgWnrkrB8ej/xx8AQ1vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749127857; c=relaxed/simple;
	bh=uoNDoEBv6wIhnMNTyam9ugb9mMupLqQdWlZrz/S85J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+4+8BdSjTJn5cSgkyQVjEd38Jrm4+EFSF8qVKiMbzvZgKAB0FtvHsIXba7j1w0dkbwpd4dukM71EDmalRuCl0cVmCV7d2zVusUF1kdJl/VO3BXdHzfYed8M0ZQRHWPBstVnjJtQAKH+MXBEr669km3nDSYhTIvszjvjnzJAeQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEXf3ZLq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749127856; x=1780663856;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uoNDoEBv6wIhnMNTyam9ugb9mMupLqQdWlZrz/S85J8=;
  b=KEXf3ZLqTE7dNTn+L7C+LP4zCd5oQRUN3XtzSXJvMrAkh9LjhQiGFrd7
   cuIeHMnoJwi6oE3W8Lgu+HS75RjIXyWTj4drvx4VAOq49Yr1P8uEzJ94o
   POiNiYc6aM1g6kIV7eaIIRK9Pq8xVFw07GVFRxY5a7oxTa744kXXUabaa
   RZ8FTELLNrGXyoKg/V5Rr6reS6hEjNeWsjGMgDWxTwBABRaqeBtDUSbF0
   Y3DLjGT3nZ42igX1htUqaiVgdVEOTpoggiYm5z26voAWIhFa1qgYGpKEw
   9kH01n7WKqY8vlkzJLSqZUVdaFrbBN86e0ruEHcRglEJ+pKZYi04J7Sbn
   g==;
X-CSE-ConnectionGUID: JbTgxhdeRv+c2Pn8YKpFoA==
X-CSE-MsgGUID: MIIt2yY0RPGg7b0MMgIVew==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="61510931"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="61510931"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 05:50:56 -0700
X-CSE-ConnectionGUID: a627yGbOSj24PNiji6efKg==
X-CSE-MsgGUID: h4GpRwYJSQulwP8/qRPKJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="149342486"
Received: from unknown (HELO [10.217.160.151]) ([10.217.160.151])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 05:50:55 -0700
Message-ID: <04c421f0-5628-4eac-9bb7-46a18f2fefae@linux.intel.com>
Date: Thu, 5 Jun 2025 14:50:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Fix warning in ivpu_gem_bo_free()
To: dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com, stable@vger.kernel.org
References: <20250528171220.513225-1-jacek.lawrynowicz@linux.intel.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20250528171220.513225-1-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Applied to drm-misc-fixes

On 5/28/2025 7:12 PM, Jacek Lawrynowicz wrote:
> Don't WARN if imported buffers are in use in ivpu_gem_bo_free() as they
> can be indeed used in the original context/driver.
> 
> Fixes: 647371a6609d ("accel/ivpu: Add GEM buffer object management")
> Cc: stable@vger.kernel.org # v6.3
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> ---
> v2: Use drm_gem_is_imported() to check if the buffer is imported.
> ---
>  drivers/accel/ivpu/ivpu_gem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
> index c193a80241f5f..5ff0bac739fc9 100644
> --- a/drivers/accel/ivpu/ivpu_gem.c
> +++ b/drivers/accel/ivpu/ivpu_gem.c
> @@ -278,7 +278,8 @@ static void ivpu_gem_bo_free(struct drm_gem_object *obj)
>  	list_del(&bo->bo_list_node);
>  	mutex_unlock(&vdev->bo_list_lock);
>  
> -	drm_WARN_ON(&vdev->drm, !dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_READ));
> +	drm_WARN_ON(&vdev->drm, !drm_gem_is_imported(&bo->base.base) &&
> +		    !dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_READ));
>  	drm_WARN_ON(&vdev->drm, ivpu_bo_size(bo) == 0);
>  	drm_WARN_ON(&vdev->drm, bo->base.vaddr);
>  



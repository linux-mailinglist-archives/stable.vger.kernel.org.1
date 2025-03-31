Return-Path: <stable+bounces-127042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05895A765B9
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE0F3A6E28
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 12:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31321E32A3;
	Mon, 31 Mar 2025 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pq+lbGHa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C5155393
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423788; cv=none; b=heUfUPH6skA2I7u8a1imSkYEaLvi4q1jBeY+XUeuTnQ1KlLnF6LvAzKULJKgwtcVcer81gUo8J+SypiUtuKQJHM/lJABhqW7EDrFrSUs3AwzqHT11M/ydH0FG/eKBfIJxLgcSUIjuRNaMDKznJTpsbffbnNvlAnN3RU2WXvEDm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423788; c=relaxed/simple;
	bh=OCZvu5QJIcaNqafaE+kxtGxHaUlcB7WyioBflxbw96o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkLhjz2vB6/W4vM8qI6qzHDodPDnLsC5n1cQRInyfEamKpg3dUqLHFir34ArBgD09GO96mmzRQCwZU/SZWXTy0kd7JV5qtlLJHob2ksGRUeTqYBBkTW7PlERX51yv7h9/2XgfdIr46ME/bpPZTZrOiGUeHJ9muKJkITzwg7qcUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pq+lbGHa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743423787; x=1774959787;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OCZvu5QJIcaNqafaE+kxtGxHaUlcB7WyioBflxbw96o=;
  b=Pq+lbGHaNmVJtrxkq/qri0HWKaRqU/g7uT61KYwlucuhhNlRJysr0xyZ
   jgo46xEciK7XYNS/6LoGXXmXUD4/1W7Vp/6m4005fPkW3kx42L0T22ddp
   p1KW/uwNUVNpB0LtSh2QNysWKJNva/pdgr0piqrdmW+7xZP7rfnyt/cI2
   sJpL2x9J/br/ojAWALyNU3RCKhVat+eJwKfaPgoK28whGcKraEV6Gbsas
   Xo4jaOSVX0gCznGopF4vSZzosauoGIfHxPz5zXhXVgFTNgQAm9f862Feg
   eb3F4t9QWcAEUm2ND32+QCoMO2NEwt39yoxqDe0ULvZwkdXJL/pdhvH2R
   w==;
X-CSE-ConnectionGUID: 0s/y3lMuQD2N4fEy9ZVr3Q==
X-CSE-MsgGUID: mERONm7GRzqrxRzGICT+ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44714238"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="44714238"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 05:23:07 -0700
X-CSE-ConnectionGUID: 8GbwudkYSVykEz7vltiLdA==
X-CSE-MsgGUID: r1ChqzVZQCyuLJorEJb74A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="126066586"
Received: from pszymich-mobl2.ger.corp.intel.com (HELO [10.245.112.211]) ([10.245.112.211])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 05:23:05 -0700
Message-ID: <72fe8dcc-3a02-49ca-9285-17aec29cf493@linux.intel.com>
Date: Mon, 31 Mar 2025 14:23:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Fix warning in
 ivpu_ipc_send_receive_internal()
To: Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, quic_jhugo@quicinc.com, lizhi.hou@amd.com,
 stable@vger.kernel.org
References: <20250325114219.3739951-1-maciej.falkowski@linux.intel.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20250325114219.3739951-1-maciej.falkowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Applied to drm-misc-fixes

On 3/25/2025 12:42 PM, Maciej Falkowski wrote:
> From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> 
> Warn if device is suspended only when runtime PM is enabled.
> Runtime PM is disabled during reset/recovery and it is not an error
> to use ivpu_ipc_send_receive_internal() in such cases.
> 
> Fixes: 5eaa49741119 ("accel/ivpu: Prevent recovery invocation during probe and resume")
> Cc: <stable@vger.kernel.org> # v6.13+
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
> ---
>  drivers/accel/ivpu/ivpu_ipc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
> index 0e096fd9b95d..39f83225c181 100644
> --- a/drivers/accel/ivpu/ivpu_ipc.c
> +++ b/drivers/accel/ivpu/ivpu_ipc.c
> @@ -302,7 +302,8 @@ ivpu_ipc_send_receive_internal(struct ivpu_device *vdev, struct vpu_jsm_msg *req
>  	struct ivpu_ipc_consumer cons;
>  	int ret;
>  
> -	drm_WARN_ON(&vdev->drm, pm_runtime_status_suspended(vdev->drm.dev));
> +	drm_WARN_ON(&vdev->drm, pm_runtime_status_suspended(vdev->drm.dev) &&
> +		    pm_runtime_enabled(vdev->drm.dev));
>  
>  	ivpu_ipc_consumer_add(vdev, &cons, channel, NULL);
>  



Return-Path: <stable+bounces-238735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL+DFpAL5mluqwEAu9opvQ
	(envelope-from <stable+bounces-238735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:18:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB270429DCE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D6C33006F00
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609323921C9;
	Mon, 20 Apr 2026 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vbeHqt8h"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5263334374;
	Mon, 20 Apr 2026 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683903; cv=none; b=VmdsE7clbHEECQax5mKBT5QrIJwwnn2mgs/7TqKLKx8Q9xyVL0a6+/RTIXPyRDlXOMiMwKjU8Ktu2gr6aygiZ7uLFlrounG68cadwE1DcQagR6eEwkAANl90umW0oRaiQcB8XcUvLPvchaMaK2XV5FabF7AmYhvopJrxo5203H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683903; c=relaxed/simple;
	bh=eDjCLpVfQ9c2PFa8mDoqqBedTvS6p99mksjDimWJylo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSQ71t54zssW1FQizGeVfWo6HT0S08O2+Cx+F6+77qDMJBq6sEwAQymx0+0ip770t4NTGpryAeneErRNqZJXlKBonwUYfdJ5GKaIYH1bQ7FRL3/LHDUIY8Vz9I6wGDGCLdhRhDtrD4XNzMv7u1G/Km3/KijcJMVpdHuiWA/3+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vbeHqt8h; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0ED61516;
	Mon, 20 Apr 2026 04:18:15 -0700 (PDT)
Received: from [10.57.32.80] (unknown [10.57.32.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CB2D3F641;
	Mon, 20 Apr 2026 04:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776683901; bh=eDjCLpVfQ9c2PFa8mDoqqBedTvS6p99mksjDimWJylo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vbeHqt8hcNjMtrvOPqFVKZ7p1MPb1UOM9FleKPMsBJD+kY/Invg4xoMDqPO9bQ/RN
	 RJrU+VLX65fMl4Rp2CzFLlMqg4OAhCNK9eVngfsH9PcFIZHVLZ5oxQTBoCdXggb4UP
	 XKSYcRIiKL1R3OrIwU1qBQFRPTgdjEIBOymiw6AU=
Message-ID: <48a13e98-ac6c-42d3-98f6-a8d77b349c3d@arm.com>
Date: Mon, 20 Apr 2026 12:18:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/panfrost: Fix wait_bo ioctl leaking positive
 return from dma_resv_wait_timeout()
To: Gyeyoung Baek <gye976@gmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, =?UTF-8?Q?Adri=C3=A1n_Larumbe?=
 <adrian.larumbe@collabora.com>
Cc: Oded Gabbay <ogabbay@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <cover.1776581974.git.gye976@gmail.com>
 <fe33f82fded7be1c18e2e0eb2db451d5a738cf39.1776581974.git.gye976@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <fe33f82fded7be1c18e2e0eb2db451d5a738cf39.1776581974.git.gye976@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238735-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,tomeuvizoso.net,collabora.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steven.price@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:dkim,arm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB270429DCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19/04/2026 08:17, Gyeyoung Baek wrote:
> dma_resv_wait_timeout() returns a positive 'remaining jiffies' value
> on success, 0 on timeout, and -errno on failure.
> 
> panfrost_ioctl_wait_bo() returns this 'long' result from an int-typed
> ioctl handler, so positive values reach userspace as bogus errors.
> Explicitly set ret to 0 on the success path.
> 
> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 3d0bdba2a..784e36d72 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -390,6 +390,8 @@ panfrost_ioctl_wait_bo(struct drm_device *dev, void *data,
>  				    true, timeout);
>  	if (!ret)
>  		ret = timeout ? -ETIMEDOUT : -EBUSY;
> +	else if (ret > 0)
> +		ret = 0;
>  
>  	drm_gem_object_put(gem_obj);
>  



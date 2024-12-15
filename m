Return-Path: <stable+bounces-104278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B489F2427
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 14:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1151885EAA
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 13:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00362189F43;
	Sun, 15 Dec 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UgdALH13"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A40514BFA2;
	Sun, 15 Dec 2024 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734268400; cv=none; b=mozqShdGLH6Q/fEfPRg38wzbI0o3LaL5TluzBXS806lYWf8iCcBoZZr6GQsw3YIKkNHsP1GKBkdOR4EUQmd0h7qwa9ysH3JnA4gnp5fop8uf64LthSJ7TB4uUfzCaWC4jz2nw2661w92YtGWafKcYZCmHNd0pLQAjVAQRogBWnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734268400; c=relaxed/simple;
	bh=oVsaFywUpOuv+msqvVac4ISm2LdrnqEXWubTqo/CYlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCeepaZQ8F5g6dRHe/tKJh1OgWRQs36o8vIBEkBXRVMzGt3uiwRKpbwquM3poj7EA4GLD27lF/JNsX5V4gnR/65/KHpHMVAiF9/Mi9DT4q7yKnG4uGoC624BdmTUEbOJpffAi5vkj+b1vIfHRxGclnfSrGcDk510Hn2TIHxnhyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UgdALH13; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3A454A57;
	Sun, 15 Dec 2024 14:12:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1734268359;
	bh=oVsaFywUpOuv+msqvVac4ISm2LdrnqEXWubTqo/CYlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgdALH13Od9P2Xwxw2tffH3ewbTXorof9YJ0zEZTayP4/AuuA7GBo9G1Qu/tQ4O9D
	 /4pgzVcnY/NLA+WsSi2IBCkvs/iqRuT/PXRktwTYBncCEVo0yt7+QwCjxx19LQkaGi
	 eGx5eqBzNm7eH10t/R2GXEqEgtcMdu8NG17/3GQA=
Date: Sun, 15 Dec 2024 15:12:58 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Karol Przybylski <karprzy7@gmail.com>
Cc: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, michal.simek@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCHv3] drm: zynqmp_dp: Fix integer overflow in
 zynqmp_dp_rate_get()
Message-ID: <20241215131258.GC25852@pendragon.ideasonboard.com>
References: <20241215125355.938953-1-karprzy7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241215125355.938953-1-karprzy7@gmail.com>

Ho Karol,

Thank you for the patch.

On Sun, Dec 15, 2024 at 01:53:55PM +0100, Karol Przybylski wrote:
> This patch fixes a potential integer overflow in the zynqmp_dp_rate_get()
> 
> The issue comes up when the expression
> drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000 is evaluated using 32-bit
> Now the constant is a compatible 64-bit type.
> 
> Resolves coverity issues: CID 1636340 and CID 1635811
> 
> Cc: stable@vger.kernel.org
> Fixes: 28edaacb821c6 ("drm: zynqmp_dp: Add debugfs interface for compliance testing")
> Signed-off-by: Karol Przybylski <karprzy7@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changes from previous versions:
> Added Fixes tag
> Added Cc for stable kernel version
> Fixed formatting
> 
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 25c5dc61ee88..56a261a40ea3 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -2190,7 +2190,7 @@ static int zynqmp_dp_rate_get(void *data, u64 *val)
>  	struct zynqmp_dp *dp = data;
>  
>  	mutex_lock(&dp->lock);
> -	*val = drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000;
> +	*val = drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000ULL;
>  	mutex_unlock(&dp->lock);
>  	return 0;
>  }

-- 
Regards,

Laurent Pinchart


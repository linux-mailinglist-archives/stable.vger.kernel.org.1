Return-Path: <stable+bounces-98960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1315B9E6A1D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CE2282833
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 09:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FC51E1022;
	Fri,  6 Dec 2024 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cWjTfCCf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825F41DFDAE
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477398; cv=none; b=L/YJKwB2p10RFw21VwtMAlLprMOADFD4pwefXdX80urAqRgPjqoci99uH9TTOC3DD7dTVvkQRR5yky2N8SZIVJectfCgHiWIgwhbKEKPB3c48EJEzjuEGKXxd6OOQbNzUfFQBAktV4L2pE94Kn1QqePw1Q5S1ZSNPmweYTRx/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477398; c=relaxed/simple;
	bh=uchmWnOek+ZZ9WN+y0HotdPK8seCY/5LrOyNIJXwakw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dibn7mKf9j4D+r+B1iLlguD9+UeHtB2y9oHS3AbWyfuM9WZq1GhNO2qsfftAwLDDBBmJqcy8keZ90v/rtutcXa6fbhgYu6OGn1rL8l5HoxdnTxz49zzBlE87oeAiAjecPyg3e6UWxkIT4XYUGgMW/8aLbiU7TAc9zgXCH68Yueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cWjTfCCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2DCC4CED1;
	Fri,  6 Dec 2024 09:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733477398;
	bh=uchmWnOek+ZZ9WN+y0HotdPK8seCY/5LrOyNIJXwakw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWjTfCCfWtZ2DMzQlLfxYWfJjDWTamyhBxRPni0yQ0/vPwy8Gm11W3SjBaLNTqucg
	 Piy5boyl++mZzHzUa3kZo54siDTmeu9FqsTtYWXtvhbgNyNwkb6FU8WHSIuGuLCbio
	 F3ESy1xJMUbcLBvf3Xl5E5UbvKw3KBAw98KGeBmA=
Date: Fri, 6 Dec 2024 10:29:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: cve@kernel.org, stable@vger.kernel.org, kevinyang.wang@amd.com,
	alexander.deucher@amd.com, liuyongqiang13@huawei.com
Subject: Re: [PATCH 4.19] Revert "drm/amdgpu: add missing size check in
 amdgpu_debugfs_gprwave_read()"
Message-ID: <2024120642-evaluate-diligent-d65b@gregkh>
References: <20241204082231.129924-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204082231.129924-1-zhangzekun11@huawei.com>

On Wed, Dec 04, 2024 at 04:22:31PM +0800, Zhang Zekun wrote:
> This reverts commit 673bdb4200c092692f83b5f7ba3df57021d52d29.
> 
> The origin mainline patch fix a buffer overflow issue in
> amdgpu_debugfs_gprwave_read(), but it has not been introduced in kernel
> 6.1 and older kernels. This patch add a check in a wrong function in the
> same file.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 4776196b2021..98bd8a23e5b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -394,7 +394,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
>  	if (!adev->smc_rreg)
>  		return -EOPNOTSUPP;
>  
> -	if (size > 4096 || size & 0x3 || *pos & 0x3)
> +	if (size & 0x3 || *pos & 0x3)
>  		return -EINVAL;
>  
>  	while (size) {
> -- 
> 2.17.1
> 
> 

Sorry, but 4.19.y is now end-of-life.


Return-Path: <stable+bounces-71530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FECB964B81
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BF9280DE0
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973B71B3B38;
	Thu, 29 Aug 2024 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mg67JLS1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506BE38F9C;
	Thu, 29 Aug 2024 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948345; cv=none; b=lSZSuHFUOyaZoMKEMcwdNB2Q/juWnGJtMbeiK5NyCUSFHgFOucXa8/TE2e7KTL2w9MsOLv6AtW5sbMGzyOpx6xNU1bOPDvZnT1KKPlWnMRrZnrkx9lLaPTF/D5C8B+xFc7SzxHXwPlHjONO2X5GPluVMDumORybYUhwQ7/CYJ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948345; c=relaxed/simple;
	bh=IzY8cnr3y3J+5JXmGEIO7/jD3TY5go9gwhXmQCYhAF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czvXf9ei7WEQ/Rm+dV7lUvEjY+TnOejtq27/MAaRAL/awsPyY1fd5HkbPy6AoLlpCB7XVj79Jd8EAU6IeZm7VAfjvSsw8SPhd16fHPPq1600jkApoLglwNFM379Wguf7XzwN+IDt0sDPWNsjRQhlVzhDAFMzD2itmfGRoPEA1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mg67JLS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5047EC4CEC1;
	Thu, 29 Aug 2024 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724948344;
	bh=IzY8cnr3y3J+5JXmGEIO7/jD3TY5go9gwhXmQCYhAF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mg67JLS1FEbXy+FK/Ntlfj0GLuXwKrtvTY+zUkwba4Vx2/HnmBZv20OAUHLNd4AJd
	 sCZT54c7gZayu7tztKidd2GYk376TWHQC/nQeQck2CBqaKQIrksM2JUxIGskcNNipr
	 Gj5FjUR5TW4blw9KPDm53WttRy5nVsQge7ZIfekQ=
Date: Thu, 29 Aug 2024 18:19:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Cc: stable@vger.kernel.org, jesse.zhang@amd.com, alexander.deucher@amd.com,
	sashal@kernel.org, christian.koenig@amd.com, Xinhui.Pan@amd.com,
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com
Subject: Re: [PATCH v4.19-v6.1] drm/amdgpu: Using uninitialized value *size
 when calling
Message-ID: <2024082955-luxury-agreed-36e6@gregkh>
References: <20240828151607.448360-2-vamsi-krishna.brahmajosyula@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240828151607.448360-2-vamsi-krishna.brahmajosyula@broadcom.com>

On Wed, Aug 28, 2024 at 10:15:56AM -0500, Vamsi Krishna Brahmajosyula wrote:
> From: Jesse Zhang <jesse.zhang@amd.com>
> 
> [ Upstream commit 88a9a467c548d0b3c7761b4fd54a68e70f9c0944 ]
> 
> Initialize the size before calling amdgpu_vce_cs_reloc, such as case 0x03000001.
> V2: To really improve the handling we would actually
>    need to have a separate value of 0xffffffff.(Christian)
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Now queued up, thanks.

greg k-h


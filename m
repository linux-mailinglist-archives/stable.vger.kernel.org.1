Return-Path: <stable+bounces-76965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D899840A1
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 10:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B8E281B67
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 08:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B09E14F12D;
	Tue, 24 Sep 2024 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cucX8MyL"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486A1FB4;
	Tue, 24 Sep 2024 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167054; cv=none; b=RQDqQ66SMu2dvZmT42DIRpZj9i+P/LXMcqtY6V3ixCROC5lRmj3CyQIsY0XpRIElZIPeq/R8SIq0tYZZhW2EyhwEhGXlL93XCpcam08mSsE3V58eb7bY0WNTHoWrjAF00L5I8/f8ooV33B2Q3+ATF4tQNrcvq2L+PtGGz3SYQHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167054; c=relaxed/simple;
	bh=yFz2ruMDyyrm94Xg4UuHtx9xJuqnbfSoLQIilrXNUpQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1KraDLwsp+k15gVezIhARlSXBnMLd5WVWiVhvrQ9TabMiuMd5FlnjYXHQIy/sEO9AXtWHKnx0L11Q0Fz9Ow52H48xmEKZx3jWoXpVzDs6/FUbdvMy0KE5pobF2HaBvn7xdsfeAqG1b6MvvNOdE+1rzH8aacHsIXk+pvv4bBkG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cucX8MyL; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O0S4wv007728;
	Tue, 24 Sep 2024 09:50:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=selector1; bh=25Ai+21oTsnytmEqWoMSwPTn
	XOsbd1o8rmkh2/RtMOM=; b=cucX8MyLnJZvCK/jdTMDXNwEzj65Xi5ulAW8M8ns
	Usl9WInmJOlNsE+y1ZVJ9IyO0YRBh56oFKxTb2HnWTna3+zXglXyicKVyC2TTgLG
	Y1yREmjolHbUJYiCe2QsNc2Goa68U9F7NXFODqbk9l3Ub6UVtfAXuIm9rpGcQg3S
	zgpqqNt389rqLP2cUy1ttEBwn0cJrO49se1uWcIwXLJKSqFuXZGOdtziex1i834j
	w5YPwl8PsEcousVdaR2P8gnFYmCpy/b0aO2sYCgcoZt2zed0E2GME6pFKHeHXB1u
	FKmlRd/hBsoGOoo1PCwfrIBFFY+Hngy7i/q4WiaSMYLqDQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41snfxwav4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 09:50:31 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0CB854007A;
	Tue, 24 Sep 2024 09:49:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3B62D25C95F;
	Tue, 24 Sep 2024 09:47:37 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 24 Sep
 2024 09:47:36 +0200
Date: Tue, 24 Sep 2024 09:47:34 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Ma Ke <make24@iscas.ac.cn>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <vincent.abriou@st.com>, <benjamin.gaignard@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <alain.volmat@foss.st.com>
Subject: Re: [PATCH v2] drm/sti: avoid potential dereference of error pointers
Message-ID: <20240924074734.GB463025@gnbcxd0016.gnb.st.com>
References: <20240913090412.2022848-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240913090412.2022848-1-make24@iscas.ac.cn>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi,

On Fri, Sep 13, 2024 at 05:04:12PM +0800, Ma Ke wrote:
> The return value of drm_atomic_get_crtc_state() needs to be
> checked. To avoid use of error pointer 'crtc_state' in case
> of the failure.
> 
> Cc: stable@vger.kernel.org
> Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - modified the Fixes tag according to suggestions;
> - added necessary blank line.
> ---
>  drivers/gpu/drm/sti/sti_cursor.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
> index db0a1eb53532..c59fcb4dca32 100644
> --- a/drivers/gpu/drm/sti/sti_cursor.c
> +++ b/drivers/gpu/drm/sti/sti_cursor.c
> @@ -200,6 +200,9 @@ static int sti_cursor_atomic_check(struct drm_plane *drm_plane,
>  		return 0;
>  
>  	crtc_state = drm_atomic_get_crtc_state(state, crtc);
> +	if (IS_ERR(crtc_state))
> +		return PTR_ERR(crtc_state);
> +
>  	mode = &crtc_state->mode;
>  	dst_x = new_plane_state->crtc_x;
>  	dst_y = new_plane_state->crtc_y;
> -- 
> 2.25.1
> 

Thanks, patch applied.

Regards,
Alain


Return-Path: <stable+bounces-76962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F71983FAA
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 09:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39061C227BE
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 07:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEBA149C4A;
	Tue, 24 Sep 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="R0UG6jyM"
X-Original-To: stable@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE66145B1F;
	Tue, 24 Sep 2024 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727164149; cv=none; b=gSTP8kTk02V3aq7yopfUcxX+ZkjAm7bt6h9hHsw9LCvEd9eTPaHOYJPB4bxBgdQr5mpja3QRtvK3DqaDcpKI8SMpWkHZVb93p2UCieGRfS1a+Wurx/3yEjaKzKUFfeiVxSazsoYITeGBLEVuVC6U/j+XPp+l7ncMdCF7ZTVwvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727164149; c=relaxed/simple;
	bh=9Dplu3ANlhcOvdfaoJvBrPEgWOZPkJBXXZjPGPHDY94=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VS54TRw7E0Bc+RXWVYaXv6nPUSpA7s9jpoFsxYKivI7Hpcs+aVCN/XAVAzCBWcPoJerIAgc0997lvdIVqSEpoy9VhmWobWAS8NNqVnc2B6BtsNYnIHQq7QGFu+pZOoIMADwOHI6EF5Iou92pgYnGAtpGPnQ3Pyma8pSEz/YO6Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=R0UG6jyM; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O0TmRD031635;
	Tue, 24 Sep 2024 09:48:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=selector1; bh=6sf8+ZK2uL9hpIXwXOaJNk4X
	lwi0uROM4AHYO0w9Jro=; b=R0UG6jyMeMn3J6WOqkQgZ8fh9QhkYqMCsUOEpEgI
	ghAWxHZoIUcT6dj6Xr9b6d7rMhv8WS3iLERiwBTAYFyU7MP4m5KzRJRHktNol7GN
	BnesbvMXbNi7mfwtzODRMKNMaP8wOg29F7wk06nn55/im9VDhhhkkSW0mGxdCTxh
	/vt61kxrQQrm0wRpPoED60Tc8rKwmRd228WO3a2TY7l5vUNcFRHaA2sj0KfdNYq/
	TIYdgqewf0mxVz8FpCi3yb2rFUcycUKTmRA7Yp+g4WiEzal7lkPgfHpp4G0IGKbb
	MdTbn5N+UhokRLaI74bV0IU1T8BQrdRHWVaOGdmgtdlEAQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41t93j9yev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 09:48:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6DB1F4002D;
	Tue, 24 Sep 2024 09:47:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 263BC25C94C;
	Tue, 24 Sep 2024 09:46:21 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 24 Sep
 2024 09:46:20 +0200
Date: Tue, 24 Sep 2024 09:46:15 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Ma Ke <make24@iscas.ac.cn>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <benjamin.gaignard@linaro.org>, <vincent.abriou@st.com>,
        <akpm@linux-foundation.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <alain.volmat@foss.st.com>
Subject: Re: [PATCH RESEND] drm/sti: avoid potential dereference of error
 pointers in sti_gdp_atomic_check
Message-ID: <20240924074615.GA463025@gnbcxd0016.gnb.st.com>
References: <20240909063359.1197065-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240909063359.1197065-1-make24@iscas.ac.cn>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi,

On Mon, Sep 09, 2024 at 02:33:59PM +0800, Ma Ke wrote:
> The return value of drm_atomic_get_crtc_state() needs to be
> checked. To avoid use of error pointer 'crtc_state' in case
> of the failure.
> 
> Cc: stable@vger.kernel.org
> Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/gpu/drm/sti/sti_gdp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
> index 43c72c2604a0..f046f5f7ad25 100644
> --- a/drivers/gpu/drm/sti/sti_gdp.c
> +++ b/drivers/gpu/drm/sti/sti_gdp.c
> @@ -638,6 +638,9 @@ static int sti_gdp_atomic_check(struct drm_plane *drm_plane,
>  
>  	mixer = to_sti_mixer(crtc);
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


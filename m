Return-Path: <stable+bounces-75726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57343974029
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0BB1C257CA
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B25A1A4B6E;
	Tue, 10 Sep 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="TK2UKA0G"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1381A38D9;
	Tue, 10 Sep 2024 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989307; cv=none; b=Pcyubm1TBYFNBsjqvBTbK+NTWo6ObeW9VRvFU/PyeM+DgQUcQrZE7jwCFY2WRJj+CDmEqNeeAUCAF7jUMRgnOLPW2GubDQ6EUr4ON8IjNmb33petCE974ghUVAMqz2WEvibB5WhmENuUcpMs1dG0n9lSXGJPYRoJo8rNoGqN1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989307; c=relaxed/simple;
	bh=3Eg5cRv4Su0IPV0jZ7cJXTtt05Csfltty4TizWg4YG0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lqg2y5QLQcAHKVRymDdxKtk7ubjqI3tOWuXH7Rc8gGmohGZMTUV/V2A+OCTyU5x9/bCn6OGK4ApS2pLWTHxjDiaMP0ZBQ1VnoXe0jW8dYhkW2SxAFZiz1wjUMS5Pz6ROnM8ObZCVIFAFuqtekYpA0o3PlqtFwlEbIsigbfOz3Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=TK2UKA0G; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48ABmRVG026944;
	Tue, 10 Sep 2024 19:28:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=selector1; bh=LPcqWQK585FTA09IXMoe7dAv
	hjuyVFvkXrm8oqa/JDw=; b=TK2UKA0GJ+VSG4eXsasS8mf6P8ZbKUrR5zB5121m
	mTF6Q7I9xWoU+JmvlPtpbP7tS3m4JUoMMaLWLMGavkrHTRG7het9V9cpc8QVlhK7
	Xosz/FlovhL76E3jDN9Xs+ylhRnORDCVIDzOGFOCSHNNINzXLVgPQqQoZrrOlqh+
	eQy7WUrUaTAf6aRWMBEygNWVPdD7kKWDJ+1ep8gQJ0Mdc5DdSgz6Gw7v7eJlUsYV
	8m9MhNvocNrHq+R6W/E6A/xCo2qKG0fmLYogqvTfj1esKiq6bJJnNQZ01yplRpCf
	fvPCCt41t5HmperAsUi3u041s6at//hrE4KrtZeLn9LLlg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41h0cyjse2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 19:28:06 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 89D8340046;
	Tue, 10 Sep 2024 19:26:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F2C012786E4;
	Tue, 10 Sep 2024 19:25:53 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 10 Sep
 2024 19:25:53 +0200
Date: Tue, 10 Sep 2024 19:25:43 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Ma Ke <make24@iscas.ac.cn>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <laurent.pinchart@ideasonboard.com>, <akpm@linux-foundation.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <alain.volmat@foss.st.com>
Subject: Re: [PATCH RESEND] drm/sti: avoid potential dereference of error
 pointers
Message-ID: <20240910172543.GA3518200@gnbcxd0016.gnb.st.com>
References: <20240826052652.2565521-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240826052652.2565521-1-make24@iscas.ac.cn>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi,

Thanks for your patch.

Acked-by: Alain Volmat <alain.volmat@foss.st.com>

Regards,
Alain

On Mon, Aug 26, 2024 at 01:26:52PM +0800, Ma Ke wrote:
> The return value of drm_atomic_get_crtc_state() needs to be
> checked. To avoid use of error pointer 'crtc_state' in case
> of the failure.
> 
> Cc: stable@vger.kernel.org
> Fixes: dec92020671c ("drm: Use the state pointer directly in planes atomic_check")
> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/gpu/drm/sti/sti_cursor.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
> index db0a1eb53532..e460f5ba2d87 100644
> --- a/drivers/gpu/drm/sti/sti_cursor.c
> +++ b/drivers/gpu/drm/sti/sti_cursor.c
> @@ -200,6 +200,8 @@ static int sti_cursor_atomic_check(struct drm_plane *drm_plane,
>  		return 0;
>  
>  	crtc_state = drm_atomic_get_crtc_state(state, crtc);
> +	if (IS_ERR(crtc_state))
> +		return PTR_ERR(crtc_state);
>  	mode = &crtc_state->mode;
>  	dst_x = new_plane_state->crtc_x;
>  	dst_y = new_plane_state->crtc_y;
> -- 
> 2.25.1
> 


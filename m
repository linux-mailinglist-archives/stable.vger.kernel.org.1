Return-Path: <stable+bounces-75952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E759976213
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 09:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFD0EB20C93
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 07:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E9A18990B;
	Thu, 12 Sep 2024 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GW7WJBQR"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F101885AD;
	Thu, 12 Sep 2024 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124609; cv=none; b=X0fidFhY7ZBxZfqwnyrmKuPcSCV0pIk5R3waz+TuCxkVsoC4dpHdhi3fegdRYyaRRzVvH75B2huvVwPIWB4m8rB2Q8Gvw6ZFKPI+JjXNlK1Kwplv5L6oC++eso2bizjCv60WfrBoUrm2ROTSMKO86TX7DHggD17rYK+jJXVBiYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124609; c=relaxed/simple;
	bh=Xc1q612FXWqYjVl3OEveMb/snF76bnxhT9ezyEEOzrg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgwKM1VAMuJN29FlEMnGczyMyxW0G68xjIn7Y0Cy7o9m1wu7mWNrDwIJ90qL/BchliQ6Hg+PB3ZiNkYAVKj7mwWiNNZ5u54FRT/rjJTZfxVR50CIXQgS7plbTHXfE4DXhCKT695iDaDuNczc1MRodiEBRqWMUG2SYSEmgJTc1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GW7WJBQR; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BMuH40012392;
	Thu, 12 Sep 2024 09:03:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=selector1; bh=3mki8FvljTnvJDZ5qn4LULmA
	s0UwFtiL5BA99RUWmWs=; b=GW7WJBQRm7G8yIgBLmp9t91VXgIt4WcGpx4cVQM3
	FkiIi4v/2rDrAl+CF44UqFrb6XULXRMEgu6yeFqjKa1w/v2wOXPwvbS+kiteaQJ3
	5Ip2YwN1gg7HAzGbk/29jvjwwkTWCzac/R6VDJGF9C9ZsCT4yd4zBwSot7FeEsV9
	sYoAk9yB2JImyaHbhF7yeOCfCpOTJBGNdaQzy0UmtV1WBHcoPqABgeTL0xDl8MN7
	ryHFM/s8wahv/oEy0kvG7N4wbQAyrQhE/haPVih7ToyyyFgwjIHbvhpgKqKrkHAw
	DVDXy8GrjhuVTN7NISWWodXP6PyqTur0+Tzh6niP1hYAPw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41h0cytf9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 09:03:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C19D440045;
	Thu, 12 Sep 2024 09:01:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E98BA24D998;
	Thu, 12 Sep 2024 09:01:29 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 12 Sep
 2024 09:01:29 +0200
Date: Thu, 12 Sep 2024 09:01:18 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Ma Ke <make24@iscas.ac.cn>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <laurent.pinchart@ideasonboard.com>, <akpm@linux-foundation.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <alain.volmat@foss.st.com>
Subject: Re: [PATCH RESEND] drm/sti: avoid potential dereference of error
 pointers
Message-ID: <20240912070118.GA3783204@gnbcxd0016.gnb.st.com>
References: <20240826052652.2565521-1-make24@iscas.ac.cn>
 <20240910172543.GA3518200@gnbcxd0016.gnb.st.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240910172543.GA3518200@gnbcxd0016.gnb.st.com>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi,

I probably went a bit fast on the commit message.  It seems to me that
the Fixes line would be probably better with below one instead.

Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")

The same fix is actually necessary for all planes (cursor / gdp / hqvdp),
which is related to the same original commit.  Hence sti_cursor/sti_gdp
and sti_hqvdp.

Would you be ok to have those 3 fixes within a commit ?

Regards,
Alain

On Tue, Sep 10, 2024 at 07:25:43PM +0200, Alain Volmat wrote:
> Hi,
> 
> Thanks for your patch.
> 
> Acked-by: Alain Volmat <alain.volmat@foss.st.com>
> 
> Regards,
> Alain
> 
> On Mon, Aug 26, 2024 at 01:26:52PM +0800, Ma Ke wrote:
> > The return value of drm_atomic_get_crtc_state() needs to be
> > checked. To avoid use of error pointer 'crtc_state' in case
> > of the failure.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: dec92020671c ("drm: Use the state pointer directly in planes atomic_check")
> > 
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> > ---
> >  drivers/gpu/drm/sti/sti_cursor.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
> > index db0a1eb53532..e460f5ba2d87 100644
> > --- a/drivers/gpu/drm/sti/sti_cursor.c
> > +++ b/drivers/gpu/drm/sti/sti_cursor.c
> > @@ -200,6 +200,8 @@ static int sti_cursor_atomic_check(struct drm_plane *drm_plane,
> >  		return 0;
> >  
> >  	crtc_state = drm_atomic_get_crtc_state(state, crtc);
> > +	if (IS_ERR(crtc_state))
> > +		return PTR_ERR(crtc_state);
> >  	mode = &crtc_state->mode;
> >  	dst_x = new_plane_state->crtc_x;
> >  	dst_y = new_plane_state->crtc_y;
> > -- 
> > 2.25.1
> > 


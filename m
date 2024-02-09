Return-Path: <stable+bounces-19396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7F984FD0C
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 20:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A28B2A7EB
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 19:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3993B85C56;
	Fri,  9 Feb 2024 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ya/PZN5i"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD1F8287F
	for <stable@vger.kernel.org>; Fri,  9 Feb 2024 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507635; cv=none; b=li/DwxqI0RIl+MF3Fk9bAILWr9KO2UbPLRkpNDx1CaSbo3FWDIaLRcVgqnknz0j4qzsMFNhvf+xrWkB6RurmLUhbJsCr+sJYSIJvUvc+pSgsytExENHZ0u+G8lnRP52SvD9ixTNf6YOJ0jhCziB6kEuGHbpzZQbOsER3+Be6I2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507635; c=relaxed/simple;
	bh=m3g/iijKL19qQunqh/wN7/7tA1L2QEOaTS7lq1GIymk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2FuccOkHsFhutmdOVCHc1oZxdujWrIBuxOyb1PPVv6nhtLEAA/9wNz5fpxoE2EQsxAgAYKiuUV4IR2n1oBUgicyk6FBJaRbKP9TY9TdY2S7bsYWRYfBuqa0I2yA97YAKlF0EBiGGDupjqIYY+Ct0LpcX1xCseZBtcQigV/b8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Ya/PZN5i; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fb5f5fd84so2860025e9.1
        for <stable@vger.kernel.org>; Fri, 09 Feb 2024 11:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1707507631; x=1708112431; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0tW/i6priEcrQG2x5Iv8T9kmua5rlprr/xlqbBzFMYE=;
        b=Ya/PZN5iaB9vBmYwpcj8jw1ck8Y7kTbTG20m6lQ8WRj+DmJU0ulnHvnMWRmowCM753
         4wlk/fVSZVfRZVcRUsfeID4d9p4WVaDIRnaklrJ4AxDX3Ij2MPqbxUkii/2oGAfslknR
         Bwd3FC0Qtp3a+nmccjTpYInenSEiSDb0cGASU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707507631; x=1708112431;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tW/i6priEcrQG2x5Iv8T9kmua5rlprr/xlqbBzFMYE=;
        b=lJDFMw9pikqVR9dnueH1Kt/fHVmVOCmPaSa0wwCrmV7Wo7Cc9zXsRWuKVr+vAmmN0F
         eF2HDMhQHFTlRCIlQhae3m27H9CcwSm98DXpOM02U6R1IPYK/Rb99wbiV8T5l8vD/IgK
         dEEeE4o/x2xKxYg8XN2hFc2KAU+VVufOyLC/4rLAbGO+pzesCOedpxINqjr3qp98yds5
         k+uXJMe8DwN7tep9p6SJcLI5OHvMDCw1Rkcx0cPTefT+7u9LPXo64oTLmcNanYqap5dG
         bm3RUhrNX06yekPzP4QvsA8kcnfd7AuGXUka0s3DEozu1SyDQdnFjHD63HSfy2crOObj
         S1EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlmMiV+01AU9xxr5oXXBRlH72shnoAOOPPJdzH0pjxIGr7jQwrn6wXOdAK6GOvhYPVTsyYfyfiILMT80pft73OnnvWifBC
X-Gm-Message-State: AOJu0Ywad19cXSirzJn8UpayBUqlEJeR8f8bMCNW0lqJKCcHKhfiYGvL
	YpxhE3rfdy4Qk4kOJ4liE9ioGxgh4VkPbt0CpIHa2ysqu0uCxeE8844GhcdxmdRbdr6fFGLSKfs
	Y
X-Google-Smtp-Source: AGHT+IG7etAAs3gp2cJ8AQ+uFdPZ0v5yg2KA4Pyw9SWYoYV8xjA1gXe2y6k0L2xCVo674E+KM0r32A==
X-Received: by 2002:a05:600c:4c18:b0:410:896d:ca9 with SMTP id d24-20020a05600c4c1800b00410896d0ca9mr1950wmp.4.1707507631115;
        Fri, 09 Feb 2024 11:40:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXajWfx5YzrxNJupEWK3onJx29zijUNMD9venW8ezCbHndI54Gzo7T1cphgYDGv19hvoHQqiwiQb6t0lZjYF76XafcOGydqDHmd0ecdxFBrY07Kp1KUprL553MudEypU2fhR6zge8suZ9x9/oXpEJ8vjMxlpiqWsQBtC9rx7EtPmSuZpJkFejKG4qwde1PbyXotbRaGB9C8ItNZowI36ODAodbcYctuWhGM5g5Q0bIsyXtFDWiVAlgHhqs+wucqpsOmsAodgbraLGMEDFp8v3tqmmMXK8JeipNIix65deBS0YlYFxRqOYZlG3ip10XGng90XFIK3Zsa1H8v12/tp0fOqN3pZaCCllffD1a0VykA
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b0040ff2933959sm1536685wmq.7.2024.02.09.11.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 11:40:30 -0800 (PST)
Date: Fri, 9 Feb 2024 20:40:28 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	christian.koenig@amd.com, alexander.deucher@amd.com,
	matthew.auld@intel.com, mario.limonciello@amd.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/buddy: Fix alloc_range() error handling code
Message-ID: <ZcZ_rLEjLTTHO14w@phenom.ffwll.local>
References: <20240209152624.1970-1-Arunpravin.PaneerSelvam@amd.com>
 <ZcZpH3hwBjv7s8WK@phenom.ffwll.local>
 <543e5800-8ac8-215f-2377-7a0e75a98cac@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <543e5800-8ac8-215f-2377-7a0e75a98cac@amd.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Sat, Feb 10, 2024 at 12:06:58AM +0530, Arunpravin Paneer Selvam wrote:
> Hi Daniel,
> 
> On 2/9/2024 11:34 PM, Daniel Vetter wrote:
> > On Fri, Feb 09, 2024 at 08:56:24PM +0530, Arunpravin Paneer Selvam wrote:
> > > Few users have observed display corruption when they boot
> > > the machine to KDE Plasma or playing games. We have root
> > > caused the problem that whenever alloc_range() couldn't
> > > find the required memory blocks the function was returning
> > > SUCCESS in some of the corner cases.
> > > 
> > > The right approach would be if the total allocated size
> > > is less than the required size, the function should
> > > return -ENOSPC.
> > > 
> > > Cc:  <stable@vger.kernel.org> # 6.7+
> > > Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3097
> > > Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> > > Link: https://patchwork.kernel.org/project/dri-devel/patch/20240207174456.341121-1-Arunpravin.PaneerSelvam@amd.com/
> > > Acked-by: Christian König <christian.koenig@amd.com>
> > > Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> > > Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> > New unit test for this would be most excellent - these kind of missed edge
> > cases is exactly what kunit is for. Can you please follow up with, since
> > we don't want to hold up the bugfix for longer?
> Matthew Auld has added a new unit test for this case. Please let us know if
> this will suffice.
> https://patchwork.freedesktop.org/patch/577497/?series=129671&rev=1

Ah yeah, might be best to submit them both together as one series (you
just need to add your own signed-off-by if you resend other people's
patches). That way bots can pick it up together, since new testcase and
bugfix only make sense together.
-Sima

> 
> Thanks,
> Arun.
> > -Sima
> > 
> > > ---
> > >   drivers/gpu/drm/drm_buddy.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> > > index f57e6d74fb0e..c1a99bf4dffd 100644
> > > --- a/drivers/gpu/drm/drm_buddy.c
> > > +++ b/drivers/gpu/drm/drm_buddy.c
> > > @@ -539,6 +539,12 @@ static int __alloc_range(struct drm_buddy *mm,
> > >   	} while (1);
> > >   	list_splice_tail(&allocated, blocks);
> > > +
> > > +	if (total_allocated < size) {
> > > +		err = -ENOSPC;
> > > +		goto err_free;
> > > +	}
> > > +
> > >   	return 0;
> > >   err_undo:
> > > -- 
> > > 2.25.1
> > > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch


Return-Path: <stable+bounces-203190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA4CCD4C7F
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 07:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF162300B9B1
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 06:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B174F327BF4;
	Mon, 22 Dec 2025 06:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TOaFo7N6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7C326D6B
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766383809; cv=none; b=ZnkP4G8RgM8fvHu4dH0gLb3nXNz7OIF/jMUHhF/TKaXTGcJz5ss8l55HbAVZTKTeNRKyJbLUkhVfTDf60mtmY1Q9VAgTMHLBOsq1KTqd7VA5yyIqOnrJmIIy9u5Tq6CllXpY7jBhhLX/kaHJUnivaRq2kM3FOmb31sMuvc2Q0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766383809; c=relaxed/simple;
	bh=2ZLm6y+vDWz/IlruQLkF1a1UAxU3uOV5Gb4PE6qBNwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzbzSbY4AjNyDwyIyejYBeJeTV+viePgTEQaNdOTYRe4z90N8KN+tWJZ1G2wo5pfzCw/LyE+LoiEMk7BP7zLYoHoptfNo0mv91XqjTTbbDGpELGDQR+LfL8Vrj0+j5PYCqzgPPpEveA+mt4utui5sO8WDkq8ZWsBdM/ab1D+kps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TOaFo7N6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a1462573caso461665ad.0
        for <stable@vger.kernel.org>; Sun, 21 Dec 2025 22:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766383806; x=1766988606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4d4yIf4cTLhpX8RECsjI9Ii+PJ5wkNjuQ9k20d0TZc4=;
        b=TOaFo7N6mLf/qJubLvZ+KvpRUg0oaVehBqgYbjMALcjbdFM0wXRNlHnEWjNFzZ8OZU
         tkH2Gt5pj4hm/Loi+Soe7P93Q3amndGpkhkOZudcCIbzFVr2G2t/UpGOHQ9M7uM8X7uG
         gDImXuOKD+hw7ChYhYQi52adS0hbNucd/18AvlnLjYgxPYm1jCCYMwYUTUf5G8rbNAoA
         D6XOCsuQ6EViIdYy//FEZhUMNY1jCLMIH5U9mL+RGJKjphSrybN8uFdz1p8zFbAXwIX1
         lBFEt9kAPNeGyVgTzI4DQ0XEJ0m8yadMYpKOCIDgNpj2Qkxi0o7A1x+BbF3t6iwXPzZX
         WdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766383806; x=1766988606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4d4yIf4cTLhpX8RECsjI9Ii+PJ5wkNjuQ9k20d0TZc4=;
        b=KbxfJLGIihr/Jg4Z/nxeMEvMXY9K5+rcGq+n/cp/4lgNb759GOy8R+RQgoXc2CFtRR
         0+DcYZNnWkYyhrMPY2pg1a7ETramrje8rRtlp4hrnmNxkK4SOyWVqQOy1O1eDEc34fIe
         8UiJaaZRohw8/JilTIkWBomS89LOZAXwC88qAKXjr5SzHhvc3/qmOIOMmM4wcL/GHNAc
         sSXbTBAAPd1yJ7xhCz9xE69z58qr4XvBESaZ+jDXf7gXJhzqgp823cnq89sYjNaluzd9
         UeUDEstG9q7k2+PPjBbDEmMSm+8pybmSsezzYsXE7KJLPjwnmH8Hmxtlg8pwrmmJuKOq
         ceKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSROB5pOD06b6FHBRnHqoQlGslWa+1tToLfIKo7VreHztOx2OGsULy+W9/VVI8EUrtOam2QVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlDY+YcQtygGbFvvCv63u2ldS3BONtxSkl42VSJLaP+iNowch2
	QbyexNHFqK9fBKpzpqz0+hqffWEUxA9WEamQDvQ+sWaedUmLwMryNPqfoi5WmRCAsw==
X-Gm-Gg: AY/fxX7o7S0EyWgKHz3mhwvUcrafxiPiR5qTqhGyr1iMnOn7MhGBV5IZiHFdLhPNkWi
	3kOIdzpLrJeafWZleFsTUhmOGhkdFq2TFfd55oi3YpVJzExgh1ias3VEZDVVhLW+Uz7VCLqSPyC
	DDKtr3aoyoFiTQ4aPQDRQ3crveSHPlK8a/uzV+NzwggInn/kWR2Kl+0bImVov5bY6f7XTFPj2Sx
	u0LifJOBZfdKSdM62UCUUxmokaw/dbZeygDZJsFLkFW7CD53UDu8cfp3fVb3Hz6VOMwI+rLm+Ac
	vTCYe/dfQ8GjLTqlIZSiq048+HEjvHbPDbSDa+/zLiYjsCoaET6E2Af5f6P7Po9+zj2XCFIjAR1
	D51o1RvEJuQRGWKuvYBVJgFA9dHfmAaV7yEcfqSL3kAH56XC0vYtT/R1Vb1roMtcGk58vndgobn
	rzT1SR3jViAK+TF91NUefH2Ruaamf4QtSisruFwWJ8IQx9H+QRD60c
X-Google-Smtp-Source: AGHT+IGJHMHvQ2BiL8kGi+L1NEiyq9evaHsD0bUwM82dYISq+7N3XOj+vRLmNpWXWMhfzBHm5bRjRg==
X-Received: by 2002:a17:902:e788:b0:2a0:7fac:c031 with SMTP id d9443c01a7336-2a311806e37mr2693085ad.14.1766383804712;
        Sun, 21 Dec 2025 22:10:04 -0800 (PST)
Received: from google.com (248.132.125.34.bc.googleusercontent.com. [34.125.132.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f30bsm9091090b3a.48.2025.12.21.22.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 22:10:04 -0800 (PST)
Date: Mon, 22 Dec 2025 06:09:59 +0000
From: Bing Jiao <bingjiao@google.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, akpm@linux-foundation.org,
	gourry@gourry.net, longman@redhat.com, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/vmscan: check all allowed targets in
 can_demote()
Message-ID: <aUjgt4EdBv4UyrTM@google.com>
References: <20251220061022.2726028-1-bingjiao@google.com>
 <20251221233635.3761887-1-bingjiao@google.com>
 <20251221233635.3761887-3-bingjiao@google.com>
 <d5df710a-e0e1-4254-b58f-60ddc5adcbd5@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5df710a-e0e1-4254-b58f-60ddc5adcbd5@huaweicloud.com>

On Mon, Dec 22, 2025 at 10:51:49AM +0800, Chen Ridong wrote:
>
>
> On 2025/12/22 7:36, Bing Jiao wrote:
> > -void cpuset_node_filter_allowed(struct cgroup *cgroup, nodemask_t *mask)
> > -{
> > -	struct cgroup_subsys_state *css;
> > -	struct cpuset *cs;
> > -
> > -	if (!cpuset_v2())
> > -		return;
> > -
> > -	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> > -	if (!css)
> > -		return;
> > -
> > -	/* Follows the same assumption in cpuset_node_allowed() */
> > -	cs = container_of(css, struct cpuset, css);
> >  	nodes_and(*mask, *mask, cs->effective_mems);
> >  	css_put(css);
> >  }
>
> Oh, I see you merged these two functions here.
>
> However, I think cpuset_get_mem_allowed would be more versatile in general use.
>
> You can then check whether the returned nodemask intersects with your target mask. In the future,
> there may be scenarios where users simply want to retrieve the effective masks directly.
>

Hi Ridong, thank you for the suggestions.

I agree that returning a nodemask would provide greater versatility.

I think cpuset_get_mem_allowed_relax() would be a better name,
since we do not need the locking and online mem guarantees
compared to an similar function cpuset_mems_allowed().

Best,
Bing


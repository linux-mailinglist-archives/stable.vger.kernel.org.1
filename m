Return-Path: <stable+bounces-64749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7829A942C13
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 12:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34959283332
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139D1AC435;
	Wed, 31 Jul 2024 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4ALYZGY"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED131A8C0C
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422179; cv=none; b=dGoJhnrBCjzxFBuyDbsG/6f2INs8MRXtD2vHDQ2LMDOlJY4OzYgZgcHOb4j3g5JO18SrkRU3evsccvHdkHEnIsOAWq7w8zZhVT+t0JdziS8OMOo8duiWwpKF/Eck9Xi6/1e6iGTL5fT2xRBGe+EsV6h8IfvyAIzDZp4G+Gj6L3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422179; c=relaxed/simple;
	bh=O4ckb6Oqb3ncJsu76380tJXMj+cK5C9kz9ggdB4lYew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSLFf32IUQaeSTzmpy9UosBaaxCXJlKTlWyBv9fpqfFCv7woNjTc9Gsu+ih0WfUhIwBaha2VZq8o2gcLGupCj0aQEmEbQmXFsFFM6FMqxueVkvMKpTR4ks6MsdnXyllMvx2axClD0kUUtJwvapJR42muEej5aKcxgeAcGFtIyJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x4ALYZGY; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e05e4c3228bso4327286276.0
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 03:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722422177; x=1723026977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O4ckb6Oqb3ncJsu76380tJXMj+cK5C9kz9ggdB4lYew=;
        b=x4ALYZGYnX7JQpEVivNIbct/58G9/OEX6YULStOLMGRjBQ69puON/MKyuZP87+BqmY
         aEnBbsY7uEEn3rmS6t8P6oeiOA0KvKPGSycTfIfyW04Ch0k1UTDkrdbvTqaYQ1H4Zie6
         pczzFGVTtfG0dHFimI4n89TBoYjrprnrZN+aMv/q8bAXdvCvmTt977hm7H4b2tSyirdh
         gW3GCKZB2wR4txkUlKCE6ZMqZRTUJBMXGvKx6eYuTac8YuIz8jnWLx15rbNexR92otVR
         /qAf+9VC6lQpqorMnvYzDyjqLrZaXoloXZo7N/h4DtF3i5bwZwDecTStsLkf9O6Zkost
         Nhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422177; x=1723026977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4ckb6Oqb3ncJsu76380tJXMj+cK5C9kz9ggdB4lYew=;
        b=Bl8CCcEBhV/BfrLriSCExuq9WCHyChYXUvJv9IhT4joxsYltoprEcq+hAZO0Y01AcH
         25w63QzRhoxNyME+V73Qo5jnKUjuK0cweXqtQNTji5+zcogymi7S8bNPd4+vfgMKZKsL
         HbZRebN5UD7GYUU5ctmdIKsVTO8ZHGwLgcOZPUrn+2d09dOnSU9e06eR0O22/lnVL5wI
         480qvnh+93lXyVfF1PSjQdvOHxCyFkNUJFmeLDm9/f/fRhnIGd/EfzPtAetDzkj7sRjx
         goTc0XqM4U3F1M3/hhWvSyIfJwyNaGQvpaV0eLSIKp+BVFxW5KQJHcZbRRw56BrGQuv7
         cM0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtkurUEd+OTQmTqf2gluWZHMukkyZe2fpnM61yCJqUjyGinaCb+93XVqD5zaqfLxxsHNqm6Hc0Um04euxroRRKWyMgsZQU
X-Gm-Message-State: AOJu0YyRD7fvEowhMPoHWA3QKvSt5qdKJHESlpXZQ/fn8ybu614HXy11
	jWx4qlcUjKt8mKkiYU8gleXOaokQXN2aQZMDqaWMqJNn6iKHEEYCP9w0Yw53C0iaCdQAhYo9yD7
	UevtFaHuWUWMsTNA9glDKgzP+rTYhp1qG+aXr/Q==
X-Google-Smtp-Source: AGHT+IE4Y0e/F10tasO9Hsf+j3yu7/uUrjh/4//0ti7GwEJstGqgDi8KunOtAzG0ELqcvTEvSFLeK3FKcUPdYjLJ62o=
X-Received: by 2002:a05:6902:120d:b0:e0b:2afc:a803 with SMTP id
 3f1490d57ef6-e0b544ebb73mr13729666276.30.1722422176743; Wed, 31 Jul 2024
 03:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711131637.opzrayksfadimgq4@vireshk-i7> <CAPDyKFqczrJzHApBOYRSg=MXzzd1_nSgQQ3QwKYLWzgZ+XY32A@mail.gmail.com>
 <20240718030556.dmgzs24d2bk3hmpb@vireshk-i7> <CAPDyKFqCqDqSz2AGrNvkoWzn8-oYnS2fT1dyiMC8ZP1yqYvLKg@mail.gmail.com>
 <20240725060211.e5pnfk46c6lxedpg@vireshk-i7> <CAPDyKFpSmZgxtmCtiTrFOwgj7ZpNpkDMhxsK0KnuGsWi1a9U5g@mail.gmail.com>
 <20240725112519.d6ec7obtclsf3ace@vireshk-i7> <CAPDyKFqTtqYEFfaHq-jbxnp5gD7qm9TbLrah=k=VD2TRArvU8A@mail.gmail.com>
 <20240729060550.crgrmbnlv66645w2@vireshk-i7> <CAPDyKFosi4dhf36iNaNgGN6RHLDunL1nEwD+A_aW2khxER59nQ@mail.gmail.com>
 <20240730033242.4ajotym33bheativ@vireshk-i7>
In-Reply-To: <20240730033242.4ajotym33bheativ@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 31 Jul 2024 12:35:40 +0200
Message-ID: <CAPDyKFqbPCrxziTgr65Ku_unJKwdKhZkVFHkm4TKf2jyonrZ4A@mail.gmail.com>
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM domains
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]

>
> > That's right, but why do we want to call dev_pm_opp_set_opp() for the
> > multiple PM domain case then? It makes the behaviour inconsistent.
>
> To have a common path for all required OPP device types, irrespective of the
> fact that the required OPP device is a genpd or not. And we are talking about a
> required OPP of a separate device here, it must be set via this call only,
> technically speaking.
>
> Genpd makes it a little complex, and I agree to that. But I strongly feel this
> code needs to be generic and not genpd specific. The OPP core should have as
> less genpd specific code as possible. It must handle all device types with a
> single code path.

I agree that we really should avoid genpd specific code and that's
exactly what I am working towards too.

However, calling dev_pm_opp_set_opp() from _set_required_opps() looks
to me like it has the exact opposite effect:
*) To solve the bug according to the change you proposed, means more
genpd hacks.
**) To make the code for the required OPPs consistent between the
single/multiple PM domain case, we need additional genpd hacks.
***) We can't remove some of the existing genpd hacks [1], as those
would then still be needed.

Finally, while I understand that you prefer a single code path, we can
still keep _set_required_opps() common and generic. Today, it's used
only for performance-states of PM domains (the involved code isn't
even genpd specific as it calls
dev_pm_domain_set_performance_state()). If tomorrow we see a need to
extend it to additional resources, it's easy also without calling
dev_pm_opp_set_opp() from it.

Kind regards
Uffe

 [1]
https://lore.kernel.org/all/20240718234319.356451-7-ulf.hansson@linaro.org/


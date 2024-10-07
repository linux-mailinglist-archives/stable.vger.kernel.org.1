Return-Path: <stable+bounces-81298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD37992CFA
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01E71C22F04
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 13:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAD01D358F;
	Mon,  7 Oct 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNSgfg6W"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8096D1D1757;
	Mon,  7 Oct 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307081; cv=none; b=kvx7L3cJA6myuBx1c93xgCmfhZYrC+hCCEUWw39jkvSJ+S8Pyd4nfjhFK85MyRR+yebLQmkxehpoVTtKyt4AAqSS/ZoT7BgkuHweBJRRb29oans//St4cTbXszZTri0s9Y4ldoh7k0FBKqFwIXXnsAu3qF2l3bbcm+zKqGNkHxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307081; c=relaxed/simple;
	bh=tx9O6Y+T54JTMHwURH7itnODet0oN97tn0uR6nWXaok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRUOzNpsQeeenZV9YYmSFOr1dV+6or/Q/AaEpLqVMgSWQssEp5VavjFf+87QLF3fhFyfwljf+r59d/FyvfBCDxrK5wmReorTBWyV4EM/s5dR0kGGy/OzDgfDVp4c4ZLroZdhX2XmuDo+ZO7GTPCyQ96EBjOeLZkSQ/TY+4i+mEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNSgfg6W; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fad0f66d49so65608261fa.3;
        Mon, 07 Oct 2024 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728307077; x=1728911877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tx9O6Y+T54JTMHwURH7itnODet0oN97tn0uR6nWXaok=;
        b=TNSgfg6WtMDU/4HKwa3FYSZeZmKhYu1bk7mtYN5uAr0Gx0uDkrdT4xuEck5sdQ/cJs
         Gn8OPLKPoCgpV5i9KHWodOWiIt4Io4m+Uzhnulrv8J2ErWahRDVIfyl16MbVDIWO1hEn
         RETnwo734mojCavPFFdvteBTYyhizJilS7zhJOFMp4qxQB34wymaEvDK7xPEXHGASrkB
         AjhQOOOMFsku20Rh8dbX2qcggOPdxXyp2S5Yk/t8Ah/V55Pr+DofkVOEoMqVMtwu25Rw
         kmERDLdlNHcVAmkm1z0ZGbAYhHwD3euRY/BG7ULpkD5qlMPuCo/5yft6rh0+51LFTTSb
         gCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307077; x=1728911877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tx9O6Y+T54JTMHwURH7itnODet0oN97tn0uR6nWXaok=;
        b=V8KLNrhUuKZciHuwZ1kw/CWPTqxiTOPb0YxV1FnMU+xQ68v+z23zQ8kBqX60tO0827
         WPhlYfiOKUv6N4R6P/8j4On6bONpE3cxDIHRO+qE/P7oCcuTQ6242VDXwCsKLjV0j6Ec
         sbAAkJjP9hs7EROlsLM6ndL/I8YSaiiQ9p+GbZabci9x3ytDa54fi6EeBKnWEqKbgKN1
         I7Rs0V2/5UaaQdffZ3nI0k8B8ZQ6roMDEfXvzJ7DyfacZ9rlKLqJX7+bvcudnWRpeqc1
         jE7sLV+AqHuhSqi2nSpnSlQJ83Hjgcx5QIRjQ0OFgBRW4bDgXGIjpgwayC9z5ssEd7yg
         ALkw==
X-Forwarded-Encrypted: i=1; AJvYcCUeorQWkvnhhZTS06lPB/ml6K3Y9Mi1KcVOlgiFQc+hvsltUa9vLe6lWc0AssMEjAYMQbdPoNevjbaUCKA=@vger.kernel.org, AJvYcCVXsI397gc2enhTVIxWSWNej527LtUVEeRQiMFIcuh6wc5LrKFcRO4Km8ci9ZeqzbTmPUH0kBtW@vger.kernel.org, AJvYcCVYZQu5xKSnyV9JNp6eELVGarH/TsQDzJUxFDb6vtjpoc+FNX04uDLtn9RSr10R4OIo0CS94Q9FRoM3ERg=@vger.kernel.org, AJvYcCVpb8MfrIFmCf4yxKgYIbfT+nljc5PD/upiWzm0CzbVWCCS06TNSk5S11M7UAfmtoN/u1xPmQAjRUHA3fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAiw/9Gl99t7DGI14XL6WzJWVFY2eqj/+xKEuO0IADyneUSpMO
	XppK28rPP+eIbJUks7SGQekTQlRi0olhcgYj0EphqeULRXgI0mWbuVvxy3IYYZ7F4bB+i7rPF1y
	h+xSed9j9mA4/fL8kDy399jEVivY=
X-Google-Smtp-Source: AGHT+IH1uWm70xxJL4yv/OIOFnKNXYSJa+hQ6Vxo0xgLDa+E4C5LcvQi59lfj00AMtCMaVLZR/KVsjavTfCY7d5Anik=
X-Received: by 2002:a2e:4e1a:0:b0:2fa:dfd6:4451 with SMTP id
 38308e7fff4ca-2faf3c42c66mr44447541fa.26.1728307076598; Mon, 07 Oct 2024
 06:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-tegra-dapm-v1-1-bede7983fa76@skidata.com> <32040b21-370f-44af-b1fe-bd625bc3fd9d@linaro.org>
In-Reply-To: <32040b21-370f-44af-b1fe-bd625bc3fd9d@linaro.org>
From: Benjamin Bara <bbara93@gmail.com>
Date: Mon, 7 Oct 2024 15:17:45 +0200
Message-ID: <CAJpcXm7252KSGdkASJq-GpZPUKnmxL9o3raNJL-QjkL67Pd+OQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "ASoC: tegra: machine: Handle component name prefix"
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-sound@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Benjamin Bara <benjamin.bara@skidata.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Mon, 7 Oct 2024 at 15:01, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 07/10/2024 10:12, Benjamin Bara wrote:
> > From: Benjamin Bara <benjamin.bara@skidata.com>
> >
> > This reverts commit f82eb06a40c86c9a82537e956de401d497203d3a.
> >
> > Tegra is adding the DAPM of the respective widgets directly to the card
> > and therefore the DAPM has no component. Without the component, the
> > precondition for snd_soc_dapm_to_component() fails, which results in
> > undefined behavior. Use the old implementation, as we cannot have a
> > prefix without component.
> >
> > Cc: stable@vger.kernel.org # v6.7+
>
> Fixes: f82eb06a40c8 ("ASoC: tegra: machine: Handle component name prefix")
>
> I think Samsung speyside from the same patchset might repeat this mistake.

Instead of reverting, we could probably also rewrite
snd_soc_dapm_widget_name_cmp() to directly use dapm->component, instead
of using snd_soc_dapm_to_component(). In this case, we can explicitly
check for a NULL and skip the prefix check - not sure why it currently
is implemented this way.

I think fixing snd_soc_dapm_widget_name_cmp() to be able to handle all
cases might be the better option, what do you think?

Thanks & best regards
Benjamin

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>


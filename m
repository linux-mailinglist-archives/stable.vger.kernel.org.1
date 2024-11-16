Return-Path: <stable+bounces-93651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A82FD9CFF69
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 16:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECEB2845B9
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 15:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D1E17543;
	Sat, 16 Nov 2024 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYtI6S+U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E21611713
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731769672; cv=none; b=dWs4NsFhBQGAoviIM3R7yjwOuo40JfwJOLtfmoEXKNxjdneweY6H8iFQF7LF+m/xpf/y09Fkt3WdZ8N1CmwqiIJhDZ/LLxBU9lbRWz5TJAEnVuLweDgfRxvlal7f9vjxH5wuCGAPOgXqeIWhxgK7Gz9zLCsJGaUiJ85ldIOedi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731769672; c=relaxed/simple;
	bh=NWRPY6ydSvP9VVPgVMoGjXdNMjg7i/bWEodd8ekTfOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQ6WeT0+DNGbIuL8/hvGFUgYR93VkBITZlPKb5J92NeizW4F7Y7PzbtyttmIk/kcG1xMiDbujYUSHCy6zSHXpBj5ARDcgfivtOgznheClBCsHDxUdM8B35Qg7cmXfCvY07kcsoAYWsE567TJgPKf4PPtBfg+6v/Sp7B+8dfKfHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYtI6S+U; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ea4e97ca43so20975a91.0
        for <stable@vger.kernel.org>; Sat, 16 Nov 2024 07:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731769670; x=1732374470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVFMUrKlCVGA5yem62mrTfvON79wDwyTNQWib2Y11dQ=;
        b=KYtI6S+UlQc7WIS6R+/k0dczbUqn9NV0R6UrmGB5u2nq/8YkNLfs0eZu1EEfVVcCb4
         JL+eT3gGdTSEZrf6Nd9gB7CeOgktRxx8+7/QwgBeGiZlAvP3UjleagRscQV0vGXLMHDt
         W69sBkXJQ/vfkssgjI+4mQZ6ZGxTJBkIk4x16c2FERLTafzon6IygbWobej6UAeJwqdf
         URB/LF/wb+fMPN2j1atm3+Dw8ThTnfplrr+1PeHflcUVs76TAOZObQl+nxTCtUiM0S01
         fGHQunL0hf77KFvfS59NLsCnVC36BVCJw63Pfj1Rg+ylKuC4f4ie8fWBQrjeDwRVh6lb
         rNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731769670; x=1732374470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVFMUrKlCVGA5yem62mrTfvON79wDwyTNQWib2Y11dQ=;
        b=hn9lNn/UhYqaKJrBZMKmc07owCl4UrvV5QzI/05ZCWxfsctYVhHAnuBoSCHE6Bm5aZ
         RbRo3YlfB46tf3rXi/pbRjhZuOuRPmGz2hWpWf2v9Hk9WPPoZh/b57ybTFm1ujf5KE48
         wmIe3XFY6vfrHvGlWJTpgXshUkJs2RLs7p7FhiSoEjW5UHeRfB/+SWHfnngZvgwEfsH4
         yJngFVcGH2tLzTTh2yhcVFQkPXVRb1g8Zk4sZlf1pxb46jfwPYgYZUWhx9Q5yFKEHNTG
         ZYGPt1d09Lf7smsLuDQclyJtARng2d3ni5wk7un7lrtjgTv5xKXQc74jZMKo1LkopsR3
         lXtQ==
X-Gm-Message-State: AOJu0YyHxnTnPZw2tVrYXxMMzbwj3tuGPvjs/3GK87nH4+E/U/se9pmt
	CcBIKU06nFAU97jERRR9+0XDJurau8PuqZ1OMzS84GQ4/QRMf2ZA27M56Jm2bv2RuT/QY1nYa68
	8YbfWCVek7+eZcVq24sK0850Z9knTj5c5fdc=
X-Gm-Gg: ASbGncuUmMd6EdH49pGvXoK/yJGCksM+NypjYJOL9V0iMoPeW6Lr52SE1xaEa18OSp+
	9c5qW9iGS/rR2VPkFEPECc1ddgbstMn0=
X-Google-Smtp-Source: AGHT+IH3osYZ4+PJeghzMeBHxsZqD3CUHrHmaNsKS80NPfpXANadsySnUYv+Ew6OYXbLAsrfvA+lLoaBZT6xgIfsTHg=
X-Received: by 2002:a17:902:f68c:b0:20c:df08:9a78 with SMTP id
 d9443c01a7336-211d0ecacaemr37185525ad.13.1731769670318; Sat, 16 Nov 2024
 07:07:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116130427.1688714-1-alexander.deucher@amd.com>
 <2024111614-conjoined-purity-5dcb@gregkh> <CADnq5_PkG8JywBPj5mivspUPJUC6chEGuNEH5a1_A-FCd_8wog@mail.gmail.com>
 <2024111653-storm-haste-2272@gregkh>
In-Reply-To: <2024111653-storm-haste-2272@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 16 Nov 2024 10:07:38 -0500
Message-ID: <CADnq5_MPEwVGmnMBz_xzO4ZCBM0kgqP=rzwK+L5VPjwpnRj9+A@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/pm: correct the workload setting"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, 
	Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 9:51=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sat, Nov 16, 2024 at 08:48:58AM -0500, Alex Deucher wrote:
> > On Sat, Nov 16, 2024 at 8:47=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Sat, Nov 16, 2024 at 08:04:27AM -0500, Alex Deucher wrote:
> > > > This reverts commit 4a18810d0b6fb2b853b75d21117040a783f2ab66.
> > > >
> > > > This causes a regression in the workload selection.
> > > > A more extensive fix is being worked on for mainline.
> > > > For stable, revert.
> > >
> > > Why is this not reverted in Linus's tree too?  Why is this only for a
> > > stable tree?  Why can't we take what will be in 6.12?
> >
> > I'm about to send out the patch for 6.12 as well, but I want to make
> > sure it gets into 6.11 before it's EOL.
>
> If 6.11 is EOL, there's no need to worry about it :)

End users care :)

>
> I'd much prefer to take the real patch please.

Here's the PR I sent to Dave and Sima:
https://lists.freedesktop.org/archives/dri-devel/2024-November/477927.html
I didn't cc stable because I had already send this patch to stable in
this thread.

Alex

>
> thanks,
>
> greg k-h


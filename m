Return-Path: <stable+bounces-125881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE7BA6D899
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 11:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F4F47A5246
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9734725D91D;
	Mon, 24 Mar 2025 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQVTlNX5"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD539250BF1
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813257; cv=none; b=iS/qGL37M7CWDZvHni29amAl3jEJafC3KFJk5abPSzbpfXOirF8x3GHg8YPUtq3kFNyJDsVGHyv6G6A9ojGMoLBe0Yi1oEZ/jgWIsDTJSnUKJRVGGIIRFpyVcNDxvYF0dJOH1CPpPzVpUsCsqhMZKy5R9zlo1Cc45f/SY+PXzmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813257; c=relaxed/simple;
	bh=5jw7vEOJd9+kVHxfxG1vL7hag7BbqohE0PbGawFjKs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hm0kqzyJCAOT0gH/FGHNjorde0X4BekVWs+tlo8+p2lXiiB59ZnAk4FJClQl/2Xwr3lgjeze1/O5TXE17L1OnPUrlxlSyv6bNHq8sZkrFZpzQ1KTXVysoOBnh1ms15W4rW/3ZCo421ez6LArhyuQaUM1WPgxRfLv72qr2H9atI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQVTlNX5; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c12b7af278so3267271fac.0
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742813255; x=1743418055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jw7vEOJd9+kVHxfxG1vL7hag7BbqohE0PbGawFjKs4=;
        b=bQVTlNX5DMZHQXwoRQQzZRklACPvnqZbtfOePyUTQoeouNyidq2aj11FbmeT0h5Yd6
         WJmAtXVplDs8Aw3MFoEsjIzU9LjU/RjGlM4gaHfQotX2wxzwPifjqF7fnfmH2LH8BnHH
         TkExmfyjMBry5ND2aiX7Sj+838yfuRHdVrhzXSHZisBxstASRHoF0cAYy7Dt3yjGUz6s
         J7cCTomZfcHh5bRlGwB1BN1DkCgVji2bianzagwYKSRWPQkOL5qftR4wGTSOHfASZpoG
         DP5uSff97iRJJpT744EnnYvYyY9djPFexPlMUR3638D7sq+OvR62ZUX8oDEEOMsza9/J
         GJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742813255; x=1743418055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jw7vEOJd9+kVHxfxG1vL7hag7BbqohE0PbGawFjKs4=;
        b=mHn5ID8PbfISL3AN0B8g1BXyHY5oTbXcBodDkBcWY5qF0jurOcojC1L4jXovMZCx1V
         +IV0uaoq7WQSDzPoMq4Lo136tsIEuBgfi/z6+D0LQ3a9o6psx9m5G+zbVTLtEzG4+jDg
         /V+BbiejB3izjeZFHLBF3ZYhJanN9ORcfYP6z4RFwDoCNjjQ7BDvgn3aNWFY56akYyck
         UxrzCz+8nQCalmXC43K0lTqL1crktL4pitP6uZMSoVJw0DCiGwVRV/Izxk7tUwzxa/3l
         7TNY+hEGBTmfLurHU0UsDoCEX7np0BuAkVTOpbET/qZAYmXsj3FJcK+oMHEMhVy/Nwd/
         mbIw==
X-Forwarded-Encrypted: i=1; AJvYcCUFsq3IZBumIj5xg5cGjJw6CD+W0kwMXx3pWjW5n+dypZNsMEX2hBxdlPvQnSfK/QIOkvb1U5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAk9JeAgo5GWyC74dzAVd7ubUA7vbHDVHssw9GWSKT7NpJK+Wr
	ELLZYwSgaoF32evui/SVBLlZl/hOLKMaooqvqZpaIEAI44UutEFlXWVRlhywYi88uvoqZvpYLTq
	T17WVNRI8yPzNgMtTYMALFHx8aDo=
X-Gm-Gg: ASbGnctcwdxCab2MTgBtaGgkm2/gnJJPmpxlVUJj4HLIEiFGeVDDsJ/73r+SnGF14WV
	h/J7hdiEC0oEghJLWdSj4XhIEgpevPmMsIsOeCgsSoPd1PmZeUi6EIwbbvH476JaU33N6vW+aBs
	RWYxiMFiGlpK0JO7T4uYz212s=
X-Google-Smtp-Source: AGHT+IHdRQL4CSzJPpXSBIfWZCaqqx9IsDza48gb58MoU4sbd7mv0bZ+NfyczdL84bXw8ET1tmLi6+9Sj6+qfwbCaK4=
X-Received: by 2002:a05:6870:3c89:b0:2b8:41ef:2ca with SMTP id
 586e51a60fabf-2c780289b26mr7641268fac.6.1742813254753; Mon, 24 Mar 2025
 03:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324083755.12489-1-kwizart@gmail.com> <20250324083755.12489-3-kwizart@gmail.com>
 <87pli6bwxi.fsf@intel.com> <87h63ibwma.fsf@intel.com>
In-Reply-To: <87h63ibwma.fsf@intel.com>
From: Nicolas Chauvet <kwizart@gmail.com>
Date: Mon, 24 Mar 2025 11:47:23 +0100
X-Gm-Features: AQ5f1Jpv52Yi-NV796ol6p6RUqVLUgoluSjVAoOFPu6MP-olcZdD_Qf9lZ9zltk
Message-ID: <CABr+WTmQ3rZ-UZH2Wv0R6qKegyjCovn3R7PWBeWiciAj+NbtnQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] [RFC] drm/i915/gvt: Fix opregion_header->signature size
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 24 mars 2025 =C3=A0 10:34, Jani Nikula
<jani.nikula@linux.intel.com> a =C3=A9crit :
>
> On Mon, 24 Mar 2025, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > On Mon, 24 Mar 2025, Nicolas Chauvet <kwizart@gmail.com> wrote:
> >> Enlarge the signature field to accept the string termination.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 93615d59912 ("Revert drm/i915/gvt: Fix out-of-bounds buffer wri=
te into opregion->signature[]")
> >> Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
> >
> > Nope, can't do that. The packed struct is used for parsing data in
> > memory.
>
> Okay, so I mixed this up with display/intel_opregion.c. So it's not used
> for parsing here... but it's used for generating the data in memory, and
> we can't change the layout or contents.
>
> Regardless, we can't do either patch 2 or patch 3.

Thanks for review.
So does it means the only "Fix" is to drop Werror, at least for intel/gvt c=
ode ?
I have CONFIG_DRM_I915_WERROR not set but CONFIG_DRM_WERROR=3Dy, (same as F=
edora)
Unsure why the current Fedora kernel is unaffected by this build failure.


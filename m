Return-Path: <stable+bounces-208424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E622AD22EF1
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 08:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 577C930B8B06
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C172532D0F3;
	Thu, 15 Jan 2026 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKW+Q6pD"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F7632694C
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768463360; cv=pass; b=MKAYslsP4a0Qh6JhBpV3HZzxxx0AfZeFMZGR154V+w69RNf8VLZWC1IkzUoDKgyDYkKrwWjgr120x90g/EOcl9bNieH0FEXkj9bhDaUp5FE6aKHFGRfZO+dCqzVTqGiV2gQ3h3UH3JIwgMnD+UoLXASv/i2YpAOrEWDqQ97Jz7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768463360; c=relaxed/simple;
	bh=nOQz0muhgLoELpd5FN9SYvUUu2wnEMl9sQ0vYgazaxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQY+NJpHVmb0c6YyEBBMTTlXQeREhedyg99eckyyb8Z8eS2h+PZ+UA3GCKgd8YDaYBG7AKL0/JAiHPbS5at8qO1rQnqxpnqmQwPAagVPxQg1T1kGxQ+sVKpPbo1rvG0nPSByayovAfUhOCrqgZguTnvYFW2hnjapz1C+0Poeiy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKW+Q6pD; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b1769fda0eso78187eec.3
        for <stable@vger.kernel.org>; Wed, 14 Jan 2026 23:49:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768463358; cv=none;
        d=google.com; s=arc-20240605;
        b=XqMLyuE0Tf9jUauW2CXSAVDdWhvSsaeKjs+V/EiTSC0L+wOf6Ljo5mDjN5QS+cscbz
         BbFZ6qFDBoZGQnx+XKDxpf1vfUtB3/jC8eflbT5t1MZJXP48Qjia0Ng3H4Djvyo2Ag0o
         xNf2I6/syA+9Qn8qBACLZbcwl5ujvHGpqtcfYTN8AXA2NSbCsKBJgksjLLK8gtkyZE4X
         dqRdBxQwvqddAlOhQVrqvF39T4hxmlXaBnR4YDj6wxIurugFcCxlEIli6URaDaj+H1KZ
         eGrso9IE9ZZeXKcalwln9dbVwjgqNnUctMXvC6p7F63iO85BhXEfhAm9iHo8qpu8Z/qF
         eseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nOQz0muhgLoELpd5FN9SYvUUu2wnEMl9sQ0vYgazaxk=;
        fh=oD7H/KAUeBfenNubK6lXQCRGEf10cnHhTYt7KOkZr3Y=;
        b=ZwQLsDu1BdOruEGWdVv3wzooC063l9/K5OV/nD0nVi5+U9dQ67BLJm8S9eYf9l6niN
         b6a/gv21tqDXq0IleJHZWGAsdHiN4ka0UCNjA5wx/ESGjP6JvEo8ZioVXmhFYspx10Vh
         tdjZvQmhrH/wibNkrp6S329EFa7jEYsv+xIRXpLf2fqrIKaPx39YyK5bzUVtkM6UL+mq
         CCv1zzVkrC+FiB3PJ6SKBrc40mYHNPWfOR6QEqySIhPQoJ2tHEO+sqvOOZN5dHd9mCsQ
         s1/GJDFItLvy82XiyL36sU+xPY8004lyxXHihdqTqSYEV0+CzQotUCNdmAd51ItkhRZv
         dTug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768463358; x=1769068158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOQz0muhgLoELpd5FN9SYvUUu2wnEMl9sQ0vYgazaxk=;
        b=NKW+Q6pDTwy+lHxrW9/jbrOIO2fXs60xw4O5+ZA6cc1ofr7oQC0w2PymPmrXox+n2A
         mOOETmZ2Gy4by/WtC8f4JQvihVyboi3HVD10A4iwW0jZ1p83k1jbFzYl4BpFOjcZ+cIf
         11XP0Opfoax+3yI3nqfvI28QTT5bXbUC+PM4lkmTc2aBuMmYClYmlj4pVlJuoQ2qlPIB
         NBW7slOfbR7kgeDErZ8DM+usaM1ZgU2YGqvbDn6wtoj/JfEAxvNSyidZ4TkkqqqW86Sl
         nF2T2/EF+UD9zQZ7lhMgDse7xQ/fPe8YmtL59cANi2eNhzDyuzwv0irID7dzWJ88+D81
         83JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768463358; x=1769068158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nOQz0muhgLoELpd5FN9SYvUUu2wnEMl9sQ0vYgazaxk=;
        b=l/o/hCXV1LI2uEWskkOBYyfJPqS2tLUeGGJL25fmmlz30On/QeOZ0W53xklbKwPhra
         jGlr2w/IjkiRkkDv3Hg4iBzpsL+x4a0alv5IwM8ZsOzwRh0YsmZP8MRXQh0/gaNiGI8u
         PfCk9x7eU0DM/8o1ezoPjet9Fzl8Z1x6vgOpOXECqGZbfaterEKoeAhqcA7Bp3F0xhWG
         lbE7DfCLykqjhifJ82remOmhhYlOoSuDyRRbEUBWmwvvVB5q+2jJjpmofYKaErTJr41l
         bV06wfuDPFS1E21lT6TzomeGXc7q4U+P0SH5xuw+rZX6nGd0tiMciu3aFboeai1Rku5q
         D0Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUIY4v9U8SJMFSE8um9mKk+SXznJsyv7oSxwoJBsU3KvJZ/XwNhB7EZjc8nY62xiwblARiL9XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV3WFpvhzrPBiSxYSSSljNR9BOYjziVM2ZIbFMxWuvx4y/ssZT
	MGa17pbWCuRpvKa6MEdJU6hDiBYo91vDXwF891b8FVdcS5NRnPKacoHx+V//+1zOSU72ABEXRZW
	8CNPJtFVuThznQJcKdCylowEpAOBwBtjw7584
X-Gm-Gg: AY/fxX5CH1S+5o2l6sOSfVTQmTlPGjwIkLVbHxxOxbQ3K+Hc4pWpko7aZ725SLesLKe
	hMA/Oj12goY3PJrFlxUN+i8YHEyE9yAInhSEaKgY6e/LnVdDIfRZml6krxhmrs1EcR8A8/K7FBQ
	RXJ60zxtfn3RRyCJ7DSYq/kZhcWqOxlmhZN3E5MeHZL9wVw9bqHgdV/uT6tIACDswLsibm6mUW6
	S9h1HFnCyrLYW39HbrpgX7tY2djnr2u58m04u5SvD9zXDHN9tNdLz9WW7ndVVf8IKbeR4N7ZnQb
	VKlQfQg25/+0RwCYY+QndxtAf4duBf1ss1Gn4xhoU0HsMSBieO4fs+AeeiH/AXEt8Tktm2klpsW
	lbna4b+b0W5aE
X-Received: by 2002:a05:7300:3b1a:b0:2b0:4f9a:724b with SMTP id
 5a478bee46e88-2b4871e9771mr3815587eec.6.1768463357956; Wed, 14 Jan 2026
 23:49:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com> <20251208-io-build-assert-v3-5-98aded02c1ea@nvidia.com>
In-Reply-To: <20251208-io-build-assert-v3-5-98aded02c1ea@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 15 Jan 2026 08:49:05 +0100
X-Gm-Features: AZwV_Qh28YVcYO6VVyfidVd7hc-EBw_qgwEmENRAhtkTb9yLXtecSM5NN0ft-tA
Message-ID: <CANiq72=U93ceCxLH_HYesCvCywpCsou98kM2Z53x=cx=iVXm0Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] rust: sync: refcount: always inline functions
 using build_assert with arguments
To: Alexandre Courbot <acourbot@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 3:47=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> `build_assert` relies on the compiler to optimize out its error path.
> Functions using it with its arguments must thus always be inlined,
> otherwise the error path of `build_assert` might not be optimized out,
> triggering a build error.
>
> Cc: stable@vger.kernel.org
> Fixes: bb38f35b35f9 ("rust: implement `kernel::sync::Refcount`")
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Boqun et al.: do you want to pick this one or should I take it with
your Acked-by?

Thanks!

Cheers,
Miguel


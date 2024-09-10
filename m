Return-Path: <stable+bounces-75627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62037973607
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239DF283346
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C7518DF73;
	Tue, 10 Sep 2024 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgSnvftV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8BE18C03F;
	Tue, 10 Sep 2024 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966981; cv=none; b=FwRo4Owg28DY9PuaifxehoMtZkt1PVr77ZEV4nkINaNMR79KMxh2teIpjjCqz/sXwDcu+nBXuifm3hIxlzIJKu6AE4teBZNzIMHiUV9OJP2C6JZ/ytar2GmH0leRZf/oMWodZn0ACSPxYNg6+uff+LYQSNoo9omoUk2NEypT6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966981; c=relaxed/simple;
	bh=yQX89QhFGr+C4XGPQjCWHDBmdtOKd/jqBt5r09fwsC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6rHt4j94xElZY0Zq0H0gVBTdHnUnx3terI4f0bxBzasj3Yon9IHa2+E03XXrfPABrtZ/2V/l2AD9tdGMYsDS9lXCQSVvqW9TE3ed/hDffSq/3r9RP7j68EmmGnU8nVPjBPPlxPhM/tR4vUvisl05NjrKBXwwq+DkxCGoEc5wLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgSnvftV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2da5acb95d2so593008a91.0;
        Tue, 10 Sep 2024 04:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725966979; x=1726571779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJA0hixTkQffbfYsekTZKlNFgkzLHbMBx3EWUSMnkTU=;
        b=JgSnvftVOLCKV9RI9hf3nVNRcgLXfIhQLipX/YVnGc4ymgWct2HrJuGA9eR5Oxt0p9
         wIZ7J/1i67oyVOFDzxgNvby/yVZWRjlNODieO7BCqY5VelDMK4Nj7/C+8uTh+eJBF0C3
         dAiCL18nukbJObhcyZdiCQ8zUgprG7Wc4H8nWQ/NxXKVhpWSczoJWxsO3UTu8Z5beIce
         QAF1BN9ewpSY0hEm8NFqWLtVFaxegObyWDMiTUTj6xgg/wfbfv0PEjabKZ1Qp+EOJsWN
         36UbPyTDYqzga17TiiAdfSM8gZadnIqbX0VsnfxtqC+DGeqnWBvB5+z8VF91Wtbxi2T/
         puOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725966979; x=1726571779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJA0hixTkQffbfYsekTZKlNFgkzLHbMBx3EWUSMnkTU=;
        b=LOyr2GGT6VIVsXnbSpopZUrSNU1qE9GcZkyK5EEpVL2nCOmBDfGn1yxQ85hbDbxPEx
         qRDiiPR+T8mCQkSvflZj2qM8NgiCgQaI9dyY9I1ZgoSKLjVudI7cAmuE0V5GnMqBd2PJ
         sXKdmMnuD1OvGroMWQtN4q1/QiUsyRw9x+BRl4KRsEJ5CdIUtOA1CwJjsCjt1WEhq+4/
         q5xJTkunfo4c/U7nyiywj5CVDiV6vd5FqfgYWUNv+sSaOBpeFBVzNqFe1APa6cO4Y0CF
         +Yb+lRQUqeu+ubJ6h+07m6sr9occ6bq3S3pKli2UfUXZ1fKGxcdLifqTb4kPzuAXKzog
         Qw0A==
X-Forwarded-Encrypted: i=1; AJvYcCUXLog6o9ZzhtWgXsRCUUfyyQdM58LPjLKgOmVlmKV0LW/y/mOzmc+T1gJHi7B6Yu7CNCNYJ+vE@vger.kernel.org, AJvYcCW4EEX7mGZEC5OX6/F9hfY7e3d3eOnBwLpH6rPenHBmvj1d9fVqxToJYeZQewYKBwqle79P0+2YVkW0QOWqfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzHE7o6V/Xqdv6n2voQBy7w0vb6oD26aoRag87fvBCRPdtnNS
	pslJ6lzc4FburkRGsKviQug9n7u4eb/HmaMIF1DoyTtdBVbjufUey+QfG2ESLW+98enH4IXG2j2
	Pw3QcKVKlqmpJ8Smq774aQ3oeUyM=
X-Google-Smtp-Source: AGHT+IHrpPCV6yQ6AH8b/e5uzLL7g8Xe5chUWcyt9XKDLWL4CwlEVZeYpM+z6IlY8hjEx422E1d1oWUnTDuxuypoEuU=
X-Received: by 2002:a17:90b:3143:b0:2d8:b96c:3c65 with SMTP id
 98e67ed59e1d1-2dad4b9af86mr7220034a91.0.1725966979486; Tue, 10 Sep 2024
 04:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909124814.1803199-1-sashal@kernel.org> <20240910105557.7ada99d1.gary@garyguo.net>
In-Reply-To: <20240910105557.7ada99d1.gary@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Sep 2024 13:16:07 +0200
Message-ID: <CANiq72mdR6Ub9_9wKP4zSo8-bJC3eArH-kK1Qzz=DkTX3dwSkA@mail.gmail.com>
Subject: Re: Patch "rust: macros: provide correct provenance when constructing
 THIS_MODULE" has been added to the 6.1-stable tree
To: Sasha Levin <sashal@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Gary Guo <gary@garyguo.net>, stable@vger.kernel.org, 
	stable-commits@vger.kernel.org, boqun.feng@gmail.com, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 11:56=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On Mon,  9 Sep 2024 08:48:14 -0400
> Sasha Levin <sashal@kernel.org> wrote:
>
> >     Fixes: 1fbde52bde73 ("rust: add `macros` crate")
> >     Cc: stable@vger.kernel.org # 6.6.x: be2ca1e03965: ("rust: types: Ma=
ke Opaque::get const")
>
> The `Opaque` type doesn't exist yet in 6.1, so this patch should not be
> applied to it.

+1 -- Greg/Sasha: for context, this is the one I asked about using
Option 3 since otherwise the list of cherry-picks for 6.1 would be
quite long.

Cheers,
Miguel


Return-Path: <stable+bounces-151942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D9EAD1338
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 18:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6383AB552
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375C9194C96;
	Sun,  8 Jun 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhPa++iH"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402242F37
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749399054; cv=none; b=K8AHukH+F/T945yFHT/KNY9JkQ9+/ks5Esf8FHu4VEeYKRfMO4ThcdchiJncIaDkNkSiZ0jNtrYRUXhcA78MUIT6clsPv8L7B7/HXwYOIZAS4miTSMIenRttF/Z5QZOMBEYIJ4W7cBMa7+xBCx6s8Me6fqlKDE+spSGiyfLg5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749399054; c=relaxed/simple;
	bh=nTTNlCWM2h+TFgfcKK5uHOHPtVtlSkEDn8NhraSHx24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzVp4aEYGX711pn/5/T6WaHFTLQT9E7DX0v5X3h2M6ynf/3YNDvFP6kZhVNrI/hf7K27C0bAfrBVBQWPk3VP3Nr20NQfGxSxeniWht/oFZtyRf0hx8r7J/wMmv7Z0GY2xXguWqPQRhQZiAThT5p4r14ItOZEMECVW1nnGZrNfMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhPa++iH; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32a806ef504so27741571fa.3
        for <stable@vger.kernel.org>; Sun, 08 Jun 2025 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749399050; x=1750003850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kofwrmSEDrL6QKSdQeegpBBo7OLphfcREnFQpXkegA=;
        b=jhPa++iHnmNx5F47zP7LnAukQ3F75BYV8XrN0eGicz2amE7W5TugEn3yPUgdhK2C34
         04wzYQkydO6ZK/BQBxuFHgoeC1VU6R9zBQeR4ppf+Jb8UZ2uMxl0JVvKb9PDhW8VNtE3
         y//EfQuTwHASD3WNSsQqZxEOH+BQcuqDHo9RwbHvWzqBD3iZh4aWJLLgu6OzQryYVv7M
         3ILsv7kDeim6/OhrgriQsavpO3ZVi87/VuLA7vlkAG+JC3xJ/Kalp8phxH8r0GHFhrHx
         nO5RQSSSvOn47GgGOIk1mPr8RdpzFqPvVUpKMz5MSeE/9Vb2dSiKgDzFIjp//Lls5GGE
         nKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749399050; x=1750003850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kofwrmSEDrL6QKSdQeegpBBo7OLphfcREnFQpXkegA=;
        b=HPhFb0Vnowzbe5SY1mXaG4ihY8ayQZPba6Oxql9mFrXOIRZ8nWWd/RqeYJF3jSRgHi
         +A1Y9+eOndLAjXRMGQrd4H9bAF/1tFoLkUTMmTfzZx0/VdH5mv0Nb4zHvO6Nk8XUft3k
         OhWLnSc4uSKWk6KESuikaZV7OQPQUuQNKesNBA8dNbmoELRGqiacAo1zLE+5l6ARQLuG
         0f1mwSucEGcuNutg7mc1FCNgS7HtICD5PiPEbRh9DiMmldanCeDTSZw2rHUIkPduMOqU
         URowkZIZNqE6pjnfu7cr+ihfuIaR3501XuCLhbupjewN0ywSET+Iq5iZw21g3SIOZ08o
         Mrew==
X-Gm-Message-State: AOJu0YzYCUiE8zdwS7uUCqjNu3xgVeaIwDCLwvD6W8/x7z2Y0gUWQ5Jq
	zoN3WEP97QTOleMPTUfiJLH2//Pt7cQgQuZVKHzeF9JQeP77ZtJtMPHBlBYOOsA6MocPzSt+SPS
	PLv/3ydZ4KdYi8Nu7ne3JtQTPMicwLAQ=
X-Gm-Gg: ASbGncuVHh4uA2B3R9b4AVAGWoRM8JqbRAoQ/jJfuFAvbLmzA12jg7Q1LCqBYqZvf6c
	fmBeVrsgxQ3ERihkyQkWw7IOWF58dJTTV9bnYx9qneqj6Xtch/qr3BdnS4FMXkc13Y1YqFXndJz
	N9HhMVE0mL3owuiw4yoPpTQfrzpOJ5c4Ia
X-Google-Smtp-Source: AGHT+IFtRwqxaYRqCAOIl7niTdnFzoOQ72v/eBlUSRB5q78Sp7SAgmJ6zhZtWkpJo4VMwatR6d4cTn/HLXGPsubgpus=
X-Received: by 2002:a05:651c:2221:b0:30a:2a8a:e4b5 with SMTP id
 38308e7fff4ca-32adfc0e025mr28112431fa.27.1749399049838; Sun, 08 Jun 2025
 09:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608145450.7024-1-sergio.collado@gmail.com>
 <20250608145450.7024-2-sergio.collado@gmail.com> <CANiq72mVx258c0rbGDwF1sP_gn0v_L7PPMG1q1XcBF2OQWH9-A@mail.gmail.com>
In-Reply-To: <CANiq72mVx258c0rbGDwF1sP_gn0v_L7PPMG1q1XcBF2OQWH9-A@mail.gmail.com>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Sun, 8 Jun 2025 18:10:13 +0200
X-Gm-Features: AX0GCFsRYv-E_s94WBb_4ILOEKyJOgxYUQ69-ZZnQXl62lNn3vY3oZUqmJQXyks
Message-ID: <CAA76j93Bj00WmWEQeG3vi6YJtN1at8=fbryvf3-JP_gaBcnQkw@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 1/2] Kunit to check the longest symbol length
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

 Thanks for the remarks.

 The commit is exactly the same as in the mainline commit.

 The upstreamed commit, is mentioned in that way, because when I used
the full hash, I was getting this error from scripts/checkpatch.pl:

ERROR: Please use git commit description style 'commit <12+ chars of
sha1> ("<title line>")' - ie: 'commit 0123456789ab ("commit
description")'
#10:

Regards,
 Sergio

On Sun, 8 Jun 2025 at 17:59, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sun, Jun 8, 2025 at 4:55=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
> <sergio.collado@gmail.com> wrote:
> >
> > commit c104c16073b7 ("Kunit to check the longest symbol length") upstre=
am
>
> I think this may need to be the full hash, and a period at the end:
>
>     commit c104c16073b7fdb3e4eae18f66f4009f6b073d6f upstream.
>
> But like in the other patch, maybe the stable team's tooling still
> picks it up or maybe they fix it manually.
>
> However, more importantly, is there any difference w.r.t. the original
> mainline commit?
>
> If yes, what the difference is should be mentioned.
>
> If not, this probably could just be Option 2, since at least if I take
> the hash I can directly apply it (auto-merged). Same for the other
> patch.
>
> Thanks!
>
> Cheers,
> Miguel


Return-Path: <stable+bounces-125584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0A0A694F1
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 17:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC68146343C
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D9F1DF72F;
	Wed, 19 Mar 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VKefHaP+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0C33E4
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401759; cv=none; b=rkoFxdtPqa4Ltafr22jEAHeIJZmkoLH33tNi2SLbtRBFZF48odt/UbJHbiyARhSvvREBL/TsIQnFUc+8XD/LI61V+900Z2TB6GNus6BGct/NzoQI/EAPL4rr4TmV4nV9Nj58SKnSVSc3NoHxPV9dNodbX2+3vYMqrL/omhZ7kRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401759; c=relaxed/simple;
	bh=hwUDnf/Z/3f61N2tG09n8L0bGp7x2JELk0wlJT1OAtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdBM2tQ4GAn5xrC40tfbzEs49nlz4qjDbllzBCns7a7ZatgibMw1JtZNlqXb09Fb6cck9pWaewAyQE5vagXFFBDdaRw+D065twe+DVhB9BCnBYxFCpvxCdjRmg1SkjrLtJ3GXLqm8lrGBzYxlHi4Se30Tzct5688bdbepMSCm4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VKefHaP+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so10064895a12.3
        for <stable@vger.kernel.org>; Wed, 19 Mar 2025 09:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742401754; x=1743006554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TCb3qM2QC7Y5TFlfRSzGurVBp3rhLPVzNLTamog5b44=;
        b=VKefHaP+2fmM+QesfjajmSmJ+QOVp+GWPPjyiy9Ju7z6+WqcJyG1pKQBHNmA8VKMGP
         H2guCTblyOpAHgWqhowvvRk4BFgQvfvVOKtNK0KbIsdcytPazCcY1TllWMdfnmdNMDUJ
         cdxp1sLV7KV+s8zX8odJR6NiG/T86ZeYug5EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742401754; x=1743006554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCb3qM2QC7Y5TFlfRSzGurVBp3rhLPVzNLTamog5b44=;
        b=JEG11bMY1c62fxxefDr9IIvkvm5+4atlfoZAunIBUN+rGrNN5b+YuPk+jF4x/mPwIa
         Fgy+aIdQAx/dyd1zttADS2zaOJJY3Tafem8nqK+bFXMnhx9Q8CJsI9YpVaP1iRCt4+RA
         VstN9EP4cdbllsOdDgPZoTjGGKgkl5yasmzg5egtavQO89/Qdhe742EHwA6qNIaKMl+t
         ++uEyLlzmfVzyCoxFMa/YVDYS/LtkMK+tJIfbvoyobSEe0BBYVWNbvfDNuGR6M5HVRAN
         LPKe5VINFWFd4xY52kQ69h76Q8pU9Bf9jYIqeWsTYdPIToUbT5wCuzOU4YNeC8dapcsH
         pf7w==
X-Forwarded-Encrypted: i=1; AJvYcCUX5pbEU5oFcC0Y552kXnUuxfiKjqKd6ZXXB39yjDNabgRfrezpGXmSR+geEqXK5sSKwzgUNDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5WAv8hExqyTlDuEehrqEU4lQ7/LdgVwgEC+E4/POcuAMkFlB
	6Limg4xwDz2uXAf+ZHuLJzxX9VDRPpJFGOEEhbzzyaeiPk0Oqr6mhnGyWhWtp+nA4opuGCVXrpH
	r0vE=
X-Gm-Gg: ASbGnctVVPekgTP6LmX2DPYStBqGPmJd3PSl8k9/rUihvbYcnajF+qfDDpBv7uC+Mhg
	X9qX8MCz3m/ptNwn4Dm72FkzimHJQrQnKJl3pmVwSQDjEjvCqvuX5HOwKDpiFze3zfOI+Tow0vW
	cvWt83mwpWO+Ep+M15JPlJbfD17b4XDxdws2NAhqsR1du+OGkMV2AmwhLMBDzmhNguwGjUs7XC1
	xYXxHF7uMSZLQuDYjeDRJFy32kbuUT1B5ZAVgPTICQabXYIvZIbRWLyEvhrbC7fn6fje/WJ2071
	iIFLTONkGFFsIcay5sEHhzCLbFJbeFApdz15Un/xP+VPBpQy2LjIESHAVcGpX9uysXjbWjk4438
	HO9AXUi5QDMtb5nCbKg==
X-Google-Smtp-Source: AGHT+IGIeT+HS44kPgSWe2t3a7CcnRbIEzZMYQIa4+Vl4QGFxOjEU+2/iuMSRdPfqml33G+0Ql6+7A==
X-Received: by 2002:a05:6402:3487:b0:5e4:9348:72e3 with SMTP id 4fb4d7f45d1cf-5eb80f884b8mr2358118a12.21.1742401754485;
        Wed, 19 Mar 2025 09:29:14 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad27c1sm9611261a12.59.2025.03.19.09.29.12
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 09:29:13 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac298c8fa50so19712166b.1
        for <stable@vger.kernel.org>; Wed, 19 Mar 2025 09:29:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9Fy+V8/MCamBN7yo9DoVPWLkkd3kThJ3bliFIFAELAnJnDkj+xqOZlU3LNlNK9ogN1pyYlv8=@vger.kernel.org
X-Received: by 2002:a17:907:c24:b0:ac2:cf0b:b806 with SMTP id
 a640c23a62f3a-ac3b7fb18e5mr330787066b.56.1742401752310; Wed, 19 Mar 2025
 09:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319110134.10071-1-acsjakub@amazon.com> <20250319130543.GA1061595@mit.edu>
In-Reply-To: <20250319130543.GA1061595@mit.edu>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 19 Mar 2025 09:28:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzYVZ0ZNvcqC+yToX6nFx+SNZqTcyEvzm2RMP-TU-Dqw@mail.gmail.com>
X-Gm-Features: AQ5f1JqX8KCi7u4eca5D9cFcz1zkfHc1WSecvRjtvtJbH05h1e_J7ig4pUcqtGo
Message-ID: <CAHk-=wgzYVZ0ZNvcqC+yToX6nFx+SNZqTcyEvzm2RMP-TU-Dqw@mail.gmail.com>
Subject: Re: [PATCH] ext4: fix OOB read when checking dotdot dir
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jakub Acs <acsjakub@amazon.com>, linux-kernel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Mahmoud Adam <mngyadam@amazon.com>, stable@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 06:06, Theodore Ts'o <tytso@mit.edu> wrote:
>
> I'd change the check to:
>
>         else if (unlikely(next_offset == size && de->name_len == 1 &&
>                           strcmp(".", de->name) == 0))
>
> which is a bit more optimized.

Why would you use 'strcmp()' when you just checked that the length is one?

IOW, if you are talking about "a bit more optimized", please just check

        de->name[0] == '.'

after you've checked that the length is 1.

No?

             Linus


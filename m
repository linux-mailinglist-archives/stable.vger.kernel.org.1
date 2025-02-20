Return-Path: <stable+bounces-118483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B27A3E15D
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F507AA99B
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0AD2135D0;
	Thu, 20 Feb 2025 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="Frzm7BDE";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="rE6oq4vS"
X-Original-To: stable@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6050211712
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070047; cv=none; b=t3ie0IgWU1UwjHK6mY4MP2aX3cQsIYh9ESSeZ+70D57qPgBHDS+W0mojYYpbOeV9gM1t47Z4IqasxlRaX+6/rF/y9tNJHsFj52Rhz/Xz0jTIclCG4wo+Z0wjMk1tkxRotAUP+gTqv0qFSn2gQn/+rvdHjOsVjlYZyoVZ6g2q+00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070047; c=relaxed/simple;
	bh=G8Rvj1+RYM5PtCvCGhsKpVb42PxUTrWVFF4NYbTXBoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxMw+2mFjoS7AcXhJiWW5fCKr1qw9ax53giFkM6hADyquKPeG97eFx8KHcT2j3aD5KYZUJ6XdLKp3fjLZhSP0bhCdeJCy7bu/kHY+FVeDJFWBrBc1qoCO8FwVrkRhEaq8Rurvps8OfgWjdtUYhIv2VkGtXGfpPRuxsMuKMAp1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=Frzm7BDE; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=rE6oq4vS; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=LvrmbHNdQa4JVysc/FIbRXhYNUaX8nkPjWm+cWDvugI=;
 b=Frzm7BDEU4kl2jqh8juk0J5UlPtaXXXlLuw8tOmbJq6uzNIeLF1assocYXiP/dKlrFBL1IwVTVTohchj7kFNkwYvLiDQiJ0q5c1fyNxEqGtK7OUWO1TFk4Es7QdSTqOyfOM8+kXtKWSH96FCguHwDI5zAVmm1o4nSFyhiZjI5LCk8QkcOW27vkmyxwLX3kFnH4njD2Ze+mD+Cf56VIr+nVRjy6pAI7B0zqtaq7BRWXYxP3Y/yNHXxsifzBsl5DVS06xwZk5j3lKtxBjrg2GGVQ/D+PLgiuwX1vdy1wmnlpqX+jtruy/s/NosjTMfPwBySVg72V5k3i1wHcQdApjeZw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 11A6C2C00CA
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 16:47:22 +0000 (UTC)
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abbb44abae6so174338866b.1
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 08:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740070041; x=1740674841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvrmbHNdQa4JVysc/FIbRXhYNUaX8nkPjWm+cWDvugI=;
        b=rE6oq4vSeCi9p/d7podF3IFvjyRo+tOoOeVs9e9qLaZdP9rXWZYIHaBMag0fR6Xlrz
         SEZfHMt5yeHhz/MUZcotDSXT/dn0UwMzl3HGZ4A/iQ7Tm9kDZJrwolda9kyg4Q3EEgQW
         sfvX1nTHGE9Y8qB2JgfMzAV+twQIi/m7iQYhEixBaeZRNhRt/vGC5Et9jWtW8RxFoHP7
         NC9a0FaE2LawZrWp1eqqlKpw7b+4kOjUA05VDXa1eecs6aGmacoM49ILohQasiS6ZPtm
         jOG4TI9codCZy8Lomq/vNoVkLf3ViUhNopKNhDKeF4FEHidPKTayp9w7DUjn4GYUpQFS
         PPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740070041; x=1740674841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvrmbHNdQa4JVysc/FIbRXhYNUaX8nkPjWm+cWDvugI=;
        b=TRy/cvSFMOAnsK7dt8CyBPhH/tZtX9YDCY3WLgMSYT2yU1/ZNO5cH2KKXpAz+Z5I9f
         bV33AAZfTMXY1MD1C6jh5qvYkJj1GAhXLeXrlNRRzQLqgWviyVRZi7E5T3y2q8tEBJ5b
         MSXgfLjwgkcK9jt/YfxT+Zwly1UU3pGjos1fSYDyJBQVo4Dh7dtEHXuw+FfoP8qOo+F0
         weWY73f4v/Eqa8dXw3fnLjj8hJTeVmtZHc7tYniT14I6U8JdqDNm5ZLO9UR6bnetvENp
         eRJ/Vivz6aU7wOO3sQRIKnWrTWLN53WjmlPU1q/97IjImFyaKFcFwcjTfrFOotPnTz1a
         rTpA==
X-Gm-Message-State: AOJu0YxE13QBWvr8g5Sqjv8QjqCKZI9lHgKW8I4p25TB5ELDfDu3OpRn
	LYt5/HwNmlpLk/mHu4VIiKD3hk/m+JOmlzMt3W7cNQX7rgqO0A173YCr19Pq+rvItNvlLOkbf6q
	6C59sKdtfWBGV+o0GjTTV4ptCnGHtz4me/mC8uXr1dgRjH4Uq1Um1ZNdp5dLBaDqQWf/q7MX6dd
	kY+gj+xGjRgl6a9rn7JiB5sMbUCZoQq0cLbXboPiJSbEfkAfdoq3PRRGyZXhNeM14=
X-Gm-Gg: ASbGnctqfLJ7lBRoxD8SXIVwU/2gTT+B1csXC+LT97cU71ut9o1gae5CFawUxg3IuC9
	M4s7H4b2Y3js1j9qh9g1UB+hQZqBB/YTI1fc8kXY5xG7zDvDaqDpQVAFznUn4vQ==
X-Received: by 2002:a17:906:3083:b0:abb:83b9:4dbe with SMTP id a640c23a62f3a-abc09c0d19dmr510066b.47.1740070041342;
        Thu, 20 Feb 2025 08:47:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBCENTa9zojiB6+sevtUZcBrd1NLHq2XG6gSAX9QhN/ExTmOHUxbRZ1VeIW36PUVvO/3J3D44f/zHm02o796g=
X-Received: by 2002:a17:906:3083:b0:abb:83b9:4dbe with SMTP id
 a640c23a62f3a-abc09c0d19dmr506066b.47.1740070040871; Thu, 20 Feb 2025
 08:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104454.293283301@linuxfoundation.org>
In-Reply-To: <20250220104454.293283301@linuxfoundation.org>
From: Slade Watkins <srw@sladewatkins.net>
Date: Thu, 20 Feb 2025 11:47:08 -0500
X-Gm-Features: AWEUYZklFFz99Wzn4U-bFKpzlTK9ociJQmc_XORzn4XFpW7PpwbbhCLQN7WTZQs
Message-ID: <CA+pv=HM=0yKe74WT8dDHYvxFvCSsHocGwjz-82mMU8oosn2mAA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/225] 6.12.16-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MDID: 1740070043-9O2jBCvvIGZL
X-MDID-O:
 us5;at1;1740070043;9O2jBCvvIGZL;<slade@sladewatkins.com>;3898a0dee3d557fa468e7fbfdd1a7683
X-PPE-TRUSTED: V=1;DIR=OUT;

On Thu, Feb 20, 2025 at 5:58=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.16 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade


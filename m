Return-Path: <stable+bounces-131795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DCBA810CA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 17:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959191BA787A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633DF22D789;
	Tue,  8 Apr 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HUZScxTd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E211C2324
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127386; cv=none; b=ohVqGCzL05mzBWRKUFwlif5wT9EETm1u8+mjCmTvzU4xZNJgHL+pNB1MdfuYlVbtwpS+uGlLPA2QKXYG5MMGi4IqrY9HVgNcCnSBBLeHQSpDM5BfDXpBwuCzzmj8eoOXG7GEvIzxg+DBHTshQnhd2iyWq0LrXLb4ceiY81LCq74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127386; c=relaxed/simple;
	bh=I7L+pC0nSrEQbmfcg/uT3SdcgcGR00a3+S/TkDfUH3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muiEC0CvJZ/+4prcSWL2C02/HZg/6+1GApQbMIRCqQcx5QqeXfQeS6wQXHj7m+pEP6VOgknrfQ1VHRXM6gwdVgRnnBIjPFRQA0tkL9F12OHZE6drri3SNYa3/qlhyW6d7DAqSY7dp2m5KkkB1IYfn4VffQp3GQmA3A8XO+TUCFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HUZScxTd; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30c091b54aaso51718231fa.3
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 08:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744127381; x=1744732181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7L+pC0nSrEQbmfcg/uT3SdcgcGR00a3+S/TkDfUH3w=;
        b=HUZScxTdXeA300onwlZrX6S8rWVCGLJqE5mQiP9lQvpczIEW7tunAYlZCJFUM4MPVH
         6qBM+s2TL1anFqTCN6wZmEkibv9cYSLmqY0mqow9sEeXibc2sXJtZPj152nKr8+z7luo
         wgc7T8GYKLG/VBghavDiJZk3qJgd9Vmue7o3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127381; x=1744732181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7L+pC0nSrEQbmfcg/uT3SdcgcGR00a3+S/TkDfUH3w=;
        b=HclN/ud1moJ6slGcYErXUiUDNQxg1phfgvlT6wuXnfcVxlpZohqEVsfTbei/foXRPV
         cpUKG3aCmcZ6+Fp3XIhUUR31W9Hredapj8f42bTrI6pyIFLwiM1v0Vwyf082ukzhUbdv
         V/VvAx05AQvs+zC+MpPqCDTsfpBuOgi18aQzNM8Jm9ravSGfqTrZP3DW7gFu8O3rlbrB
         ESkprOthV1b9WZCS4WksTwDvUFLd3JwWGzECv2rIWaY6iRppiuaCgqpfYymClVrb89nJ
         qKH+WJDygAox4aqSLUx7H5QGYWcU4OIXYqg57wV/9in92BgzU42ZJ3HXrlep/tjOH4qp
         UOsA==
X-Forwarded-Encrypted: i=1; AJvYcCVQhqQic9kiYG8BEXEqhsUTqGYss/AQ52ChihMFKfkGaBJpf38llJNfXrE19aIy2fqNWmWGrgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7TTm1vPHaDAEw2f10LAG0EpLvCrux7MnCkK7xPKp5ITjobuk
	5xhQB+KbkJyWV9BTQd/J15HbNe47FuNy0UjELi67D5x2zbo11d3RgGSIv22eVqxEzPat8PtZZwf
	btg==
X-Gm-Gg: ASbGncu3mma4Z3x7bXwWdnxViJm4xEvQs7Y/JGZem2F/3G/w/wmIVvTIs9z0ADo5bU+
	sAhVh08v+WHn3kmUND95UMgmIIPQy003J7PPvJUf+WZ/U4A8+e86zUl5Zz/cimzwg3R6eoFyA/G
	o3La67XLR/XqpY6jZ8Dd7sVCsM7dkk574tPjGfXSIqoFzozOwczguL4QHXBaNH2EFBvH+POuFsl
	7Ao55RTrELSMYuFC2FPA43iqF2VBfhr+YWj3Ad6BjWaDJdJMvQW1QWo1QwlGz4i6nBIbSRM5YOx
	iMnL4WKE+mR+ZVwIxdgjMZzyTcPk+N0wLz9PL4xfwjGlMqlLeYRAYZDGMavcr26z4Q7wSCV0WUf
	T0OJfUd5Vf5bG
X-Google-Smtp-Source: AGHT+IEVnK8orNvwQqphHVCBhIdKQE6aI6cO2HhWd0At1rEhIC7pR2xr9ErPMgjzK9SrC2JxysEY+Q==
X-Received: by 2002:a05:651c:891:b0:30b:9813:b011 with SMTP id 38308e7fff4ca-30f1658c694mr53267991fa.28.1744127381029;
        Tue, 08 Apr 2025 08:49:41 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f031cf07dsm19057781fa.110.2025.04.08.08.49.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 08:49:38 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30de488cf81so59647221fa.1
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 08:49:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUz74zGghnqRBijUbW98PPrSOIRK7rG3c5P3qoE8jRZKZQf0z3xPpYmaXTxHBy3X122PcGMUuk=@vger.kernel.org
X-Received: by 2002:a2e:ad08:0:b0:30d:e104:d64c with SMTP id
 38308e7fff4ca-30f165a46a0mr36678651fa.40.1744127378315; Tue, 08 Apr 2025
 08:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025040844-unlivable-strum-7c2f@gregkh>
In-Reply-To: <2025040844-unlivable-strum-7c2f@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 8 Apr 2025 08:49:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U=7G-V2FBNHJ5=bE+BVa1Jcbd=fi-zD4wCVAwxcpU2ww@mail.gmail.com>
X-Gm-Features: ATxdqUEtiMZ8dwQn908N9Z8hRlAVsXfB5DkLwxwWsTTFFKLsiPKIZqr-3QrJFaI
Message-ID: <CAD=FV=U=7G-V2FBNHJ5=bE+BVa1Jcbd=fi-zD4wCVAwxcpU2ww@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] arm64: errata: Add newer ARM cores to the"
 failed to apply to 6.14-stable tree
To: gregkh@linuxfoundation.org
Cc: catalin.marinas@arm.com, james.morse@arm.com, stable@vger.kernel.org, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Sebastian Ott <sebott@redhat.com>, 
	Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 8, 2025 at 2:17=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.14-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.14.y
> git checkout FETCH_HEAD
> git cherry-pick -x a5951389e58d2e816eed3dbec5877de9327fd881
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040844-=
unlivable-strum-7c2f@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

FWIW, this patch applies cleanly for me to the top of 6.14.y if you
simply apply all 5 patches in the series, all of which are CC stable.
AKA these commands work

git checkout v6.14.1 # Current linux-6.14.y
git cherry-pick ed1ce841245d~..a5951389e58d

Where you start getting a conflict is if you also take this patch from main=
line:

e3121298c7fc arm64: Modify _midr_range() functions to read MIDR/REVIDR
internally

The merge conflict between those two series was resolved upstream in:

edb0e8f6e2e1 Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm=
/kvm

-Doug


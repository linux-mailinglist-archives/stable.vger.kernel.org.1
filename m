Return-Path: <stable+bounces-132642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78971A8878A
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 17:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1F23AD1AD
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CDF274669;
	Mon, 14 Apr 2025 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gGSOEoa7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5446B27466A
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645074; cv=none; b=hW2wpj/dOaVbFZAF+9qVKpS55EoHRe5ognwnDNnvNXk25yjBKwq5FLORHO2PNwREGKL2ibXqwGR8vYxx2jzEzKgBVQ5AoiJcHiGRr8BDzSnQMpycUA/9OvEYslTQ8dSAKk0neVhMigcKh8PRzcGunK8dWyc9P2RQ2PXt+r+QTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645074; c=relaxed/simple;
	bh=53UwETaVo9Ptb4LLni0MTGJ9DvmqlROi99VWcorDpRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ix5yGSuy+kbcU2yzOaWrWRdB+JUE6g0XrDw6eE+5SIee9iCjoXes/Gw64FI1EYZ2s+8Ka4fsHub+7SOfp1VsMmfu8TOGtxo7x/Is8CSXCJOEjFq7R3upzOkrnzJ8oB8amCTHIOKdVKnmHrbR0Rjrxwe8bmUJBwQLbCaIAgwQuAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gGSOEoa7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2243803b776so67083125ad.0
        for <stable@vger.kernel.org>; Mon, 14 Apr 2025 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744645071; x=1745249871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53UwETaVo9Ptb4LLni0MTGJ9DvmqlROi99VWcorDpRA=;
        b=gGSOEoa7MsYVxej4OC3mWmiRZ1CGl/gIFXYxBDVhc576wLzREfsZOCo/uri7xpvHxH
         7Bcucn8xp2XEJfRE2ilg+ru/342dd8oQW8yM7OK2t98oxNtHUtn/MPH80y6Rq/XRrx+s
         cB7l6HqWFsgQ4f7afRAGY8hAy9pVjRXHQBgFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744645071; x=1745249871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53UwETaVo9Ptb4LLni0MTGJ9DvmqlROi99VWcorDpRA=;
        b=tq1aF46HEp9aRGEKvcFPoj3zI4d4Gv2qQwgYQs/hdLQnm1n9TBVV3SoZw9454GJdoA
         S3gdRbOzqw1+7wnFZDXmIsaCAtRner9c1Jv2jsFkvYa3pG2Cv2noAqlzqYiNnyCPzkdC
         6LyzH0r4JPLKoLh5XeOr2/U5KX6d1cWtufpYHHBte7S+EAAGxrG4jmoUw+5CbDOZqd5M
         b0e+jar9tvxkymmrZ+l0tFdLcdWpiNOVgcBMkbGscWPOi5Eh/8ddjZ0g4Jhrp5g7qUzs
         gum3Lh5q2orq1oT9buyyUqPQEhVgFtSE5tGEq13xQRbOQwqEEiD1SOPwvZPalFtwlVkS
         IZFA==
X-Forwarded-Encrypted: i=1; AJvYcCWXQkAwtoV1yb+muQqpQ4j3OpvUOQ55fK6AYdxwd0LuUiOiv6lv3KjSIdtAYc10kAwpc8ReBu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVVqWxU1LzIxedK+gQ8mB67dw0TldIzE0YezzJJFTrPD8gLB1j
	XQL7g2ur/lLtTtp1cigrBheJUCFgOv9atu5e0gfgWxelwrPtVUorC6+HM0RJqamPGx9tVzc4mQc
	=
X-Gm-Gg: ASbGncvNFWQMpIIUwZc1xdT/3mB2uP7Gm66qZ8SEprseIXEVbrmnokxj1EbcSWaqePd
	NRRVsoPvuLPpnZsifzhvdugbJCCqbZRbexTEgsVbxRYkTDPc+/mA/98lekw5MStCjt2uk65NHZC
	t/mJeVKelWex1Vdiq5P2iuM4SaY7y5OZ0BIsYqY1PHgbsTIeuxQgWdmtLXGpQaGGbtIp3FdgmGw
	nSPjd+eF9CZwObbVXxlC03MQhEecTxOZmnvOxtJq5dBdMkTHMuY8Tl527MRWbf71X9iJhTtzxKs
	GKfAZoZjlqmXIRil0DIZwDIOxWK4pCi5CMjbWBahEy/Gz6kCIjr83KHlun0Fce8B5BaufjdxfHX
	vshv9
X-Google-Smtp-Source: AGHT+IH5bK9/QOX0MmGpcj3ti/hZ3NR2q+yG2tz6vayhjPqYdH7MWVg52bfbv5tIkttRSwtf7OoG1g==
X-Received: by 2002:a17:903:2392:b0:223:6744:bfb9 with SMTP id d9443c01a7336-22bea4efae4mr209277705ad.41.1744645070500;
        Mon, 14 Apr 2025 08:37:50 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com. [209.85.216.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f1012sm6977409b3a.96.2025.04.14.08.37.49
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 08:37:49 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-306b602d2ffso4739525a91.0
        for <stable@vger.kernel.org>; Mon, 14 Apr 2025 08:37:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDQ66AgI/vwOW88tESezYFXJ4uvKL29dKY0ZUakIi/wu5emebLA+Qw/i5fgJXqifYJ3SyOthI=@vger.kernel.org
X-Received: by 2002:a17:90b:4d0a:b0:301:1c11:aa74 with SMTP id
 98e67ed59e1d1-308236712aamr17193528a91.28.1744645068508; Mon, 14 Apr 2025
 08:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025040844-unlivable-strum-7c2f@gregkh> <CAD=FV=U=7G-V2FBNHJ5=bE+BVa1Jcbd=fi-zD4wCVAwxcpU2ww@mail.gmail.com>
In-Reply-To: <CAD=FV=U=7G-V2FBNHJ5=bE+BVa1Jcbd=fi-zD4wCVAwxcpU2ww@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 14 Apr 2025 08:37:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UrERLaPhPznUkW-O-K=_-uBROScPYy1eC_7RrDGXPS=w@mail.gmail.com>
X-Gm-Features: ATxdqUHeYXgX-nvV2n_KSjlEhPG0j6Fkq44wIyJQSZgExr7nF43eLKL2ShTFpJ0
Message-ID: <CAD=FV=UrERLaPhPznUkW-O-K=_-uBROScPYy1eC_7RrDGXPS=w@mail.gmail.com>
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

On Tue, Apr 8, 2025 at 8:49=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Tue, Apr 8, 2025 at 2:17=E2=80=AFAM <gregkh@linuxfoundation.org> wrote=
:
> >
> >
> > The patch below does not apply to the 6.14-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following comma=
nds:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/ linux-6.14.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x a5951389e58d2e816eed3dbec5877de9327fd881
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '202504084=
4-unlivable-strum-7c2f@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..
>
> FWIW, this patch applies cleanly for me to the top of 6.14.y if you
> simply apply all 5 patches in the series, all of which are CC stable.
> AKA these commands work
>
> git checkout v6.14.1 # Current linux-6.14.y
> git cherry-pick ed1ce841245d~..a5951389e58d
>
> Where you start getting a conflict is if you also take this patch from ma=
inline:
>
> e3121298c7fc arm64: Modify _midr_range() functions to read MIDR/REVIDR
> internally
>
> The merge conflict between those two series was resolved upstream in:
>
> edb0e8f6e2e1 Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/k=
vm/kvm

I tried again as of today's linux-6.14.y (which is 6.14.2), and the
patches still apply cleanly. I can send all 5 patches to the lists if
it's desired, but I'm uncertain if it's required since they all apply
cleanly. Just "git cherry-pick ed1ce841245d~..a5951389e58d". They all
apply cleanly all the way back to 5.15 as far as I can tell. Would I
need to send the same 5 clean picks in response to every stable kernel
from 5.15 all the way to 6.14?

These patches don't apply cleanly to 5.4, but that's because kernel
5.4 doesn't have `proton-pack.c`, so presumably none of the Spectre
mitigations were ported back that far.

Some of the spectre stuff is present in 5.10, but it looks like not
all patches are being picked there. It's probably not critical to
support newer ARM cores there, but changing the default to say cores
are vulnerable might be worth it? What do folks think?

-Doug



-Doug


-Doug


Return-Path: <stable+bounces-208284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3105CD1A643
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 17:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B269130248A9
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C3434B1B8;
	Tue, 13 Jan 2026 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pfe1coMX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C97634A782
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322843; cv=none; b=C7pHTLpmDhXlGLiRdkQMBbrE1fV/O83Ckmtss2vYwffqIK6MmyZ6fjkj/4fQdoV4+l2TFTpKiZJn1kxDcMs/1gDJCQa668yK3ukHUpDI9HvALR1k86YxcJ/A3cs9z/0pQ22LVOHDX+q0w/gj9onbZELwN5Lz2Jouues+Ho1Mwx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322843; c=relaxed/simple;
	bh=HY4BnY7teM7CCGVFPSxTnZxPmgQTkxZnDEtWAZOyY0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCfL0nhIgyGfqFeUm9Oak0HQ3CqYFOAOr0gK1EnQQe/tykgdITuzjHSay4sUnBtYmhEDKzv82JXlvQqQ4rb4f+bJkhMlkTBHAr6Mcw3TNAOn2Q1Pi9Vys2kTgE47w64hphg3cFcaVmmjuQn+wBDTCOd/trrinvRtw5jd5ureYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pfe1coMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A11C19424
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 16:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768322843;
	bh=HY4BnY7teM7CCGVFPSxTnZxPmgQTkxZnDEtWAZOyY0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pfe1coMXBnOSQZoNV5i60p74LQljfzhtY3+EemWNbPahI14TNJDiA0cXEHQWFhJRM
	 hpEEQGzr+EtI778vt3l6+Z7+3WChdSqJ4yhqCGe8WuW09C4IvZLf5Fxf5l0IEbyKHL
	 op5Mqjpx6iXG8UjhLpNfYd2NkhW/dAqFZu/7zRDduy//v2IbK9EjfxXmFhExM/peFE
	 NIaHWpaxlEsgS1qygx2+qOCC5CfL7an4FvrZ0bl3a/haSddXVd08U59ZJO+pAktrIO
	 k0w7FEj6XvKzB6Dp5WqQBkTA6PfajBrDZKljTL1d/7KroZQ+i2l8eScafZdb/bC5kQ
	 feqE3l2cQYRTw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b834e3d64so5108899e87.2
        for <stable@vger.kernel.org>; Tue, 13 Jan 2026 08:47:22 -0800 (PST)
X-Gm-Message-State: AOJu0YxMNQXwvCjoFQUsJU5QWn0HBLenKxeDbdnKDTYsLpAWAY2BsfZ/
	h5EBY1hn+HRyLrzODRGUbEdOovVruSSWgQGShn35u4AzRA6ze+JsFyB3g6TAMPgc/Qo5CN56rPQ
	VyyYtLQwElRGuxnntuPVntxVJRxlzbGzxESm7N4689w==
X-Google-Smtp-Source: AGHT+IGyodboIvaktA+R+vb3RJBm34QtLmBepQxAUf9FgC4ZNLarrG+cFTVi/v03ZJMW9OV79tRqeFnxIuhObPjBCvw=
X-Received: by 2002:a05:6512:3da4:b0:59b:9f92:301f with SMTP id
 2adb3069b0e04-59b9f92323amr238573e87.7.1768322841734; Tue, 13 Jan 2026
 08:47:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113164229.1548396-1-sashal@kernel.org>
In-Reply-To: <20260113164229.1548396-1-sashal@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 13 Jan 2026 17:47:09 +0100
X-Gmail-Original-Message-ID: <CAMRc=McT++3cx-bu8Gws9abX_uHiYZ1sZ_O7XPebv084jXO8CQ@mail.gmail.com>
X-Gm-Features: AZwV_Qigs74LZQ5SHB12qObDB8D9WKZPq8H1iO7bTP2Z5zy3KzL8TYdKIs2KPnw
Message-ID: <CAMRc=McT++3cx-bu8Gws9abX_uHiYZ1sZ_O7XPebv084jXO8CQ@mail.gmail.com>
Subject: Re: Patch "gpiolib: rename GPIO chip printk macros" has been added to
 the 6.18-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Kent Gibson <warthog618@gmail.com>, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 5:42=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     gpiolib: rename GPIO chip printk macros
>
> to the 6.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      gpiolib-rename-gpio-chip-printk-macros.patch
> and it can be found in the queue-6.18 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>

This is not a fix. I'd drop it from stable.

Bart


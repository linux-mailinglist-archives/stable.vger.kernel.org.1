Return-Path: <stable+bounces-20882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FCC85C5B5
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600A3283BA2
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D1B14A4F5;
	Tue, 20 Feb 2024 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8QXCtdk"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BB014A4F2
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460596; cv=none; b=oSkT+3uhzWKUZM0Tu9DwDvQs33CWoK5rATf1P3MS/HMdeuUM1hxywERrcuj/Y+s1l+frdK/vq1OQO6bO3wra3bfQkzJQ2DcNfhX2zHTu7iShT02ipceTasuW9Y69sR8dsCFanoxBkpx0AalHOD5pRoTWQzsVUQQBkd2ELRofhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460596; c=relaxed/simple;
	bh=NtAupI7eYtgh3yi1/lcfdhrIrAXohnaOpbdHMhKQZCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J38hx4c0ZM6kwy5tV4SfFAJlf3nh6jm9pjFc1YZf297gDOOCFZfEC69vC0YGHcz64U1LyjgCPJgBH2eGrlyQddDP5iz4y2wYIhKUCRr3u7R4neYbGe8tKD9xCRvvvvDASQYckdnuat21Qkdbf4vRkovQRwYl0uzTsM+mogamtqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8QXCtdk; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-607fc3e69adso48632737b3.0
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 12:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708460594; x=1709065394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAcxoiwswXf0u4UcozWlRje00byaUAVEvvkr0DiyRgc=;
        b=W8QXCtdkdkG8DUdEi5h38+g8jzJVrt4P4xvuqPDQWDlvikFb3et8/SyVnWFZn0qEaA
         cLA9Nao4zSqnUwOrzM+XAvpyxptXP9OTJIkckTpMyT3T57bQJGJGYbMobfrGJ6i5xdIk
         eRld0gMyAC5Qh4SVEr6VlY261MYmMJb4ICq9ML88RWD+DxR1mOTSFvxs4XKxc9+/9lS5
         cRzfCStM5WI+BJw7nyHyFBsesxYrEwodS2Adg0QXYp66ng2QCAHJIIMqDv3iIcQ+0Nri
         cSmKtWaepNBZVEO87E5avVrDc5IGFh0t5Ri9+s3gjfeV+AgcI8rN2lB+BVDSAdwvb/Fc
         UOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708460594; x=1709065394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAcxoiwswXf0u4UcozWlRje00byaUAVEvvkr0DiyRgc=;
        b=CZs4X5/WgsSO3AF1cDc1TjISkmXGDjiKpLGpMz2BeHxduJqQzEF2EtMCqJ0XYe0e7C
         4m7Nbhfk3aGlHOtDCIc0oe/x2aL6NvCIMS2YQHeBDruz3DPVvJ/WxQ6vy0wNXmNSJyBT
         NmGg1FNaci6zsQJrSpiuid1Ffots4TtMgpLaLczBJjLkJ2lM+P8I84y+vuZIi5Ttv89P
         VylH+VSOjGXDzAFuISz4WCezMPkRrCOfXiPSY3Z7n2AfO6UUBSX4g9L03PGbJBHKf4Fx
         Mlaz4ayYnEaPjL3qlYyqnuh7e4IT2MeeVwo8spq86unJwkbji/y4jWYYEDNkHXOwfuFe
         LL1Q==
X-Gm-Message-State: AOJu0YyILszKOORBO4ul7gySM37rZCU/nOQuZlGUM/MDyGL3IzZ6ORzY
	Sxppof+TNEaGGeBVGN+S2Yn+P0TqHwMRX0XMD4eKEII1Ll1OwwtYUDcQQtOszJ6D4XWcPn+A1Jf
	0Ft251Ms5J5a6qn6pzSo1Y/uSNG5B3T3nx84Y
X-Google-Smtp-Source: AGHT+IGzUgQtgghZbWrK8eYJQEzXHrPL1+7CeQbbFfzgXHAAUnQxJde+shFK2EnUD76tCj1j++WuAGjwwVmLXoPHmBs=
X-Received: by 2002:a05:690c:368d:b0:608:3785:707a with SMTP id
 fu13-20020a05690c368d00b006083785707amr7238229ywb.52.1708460593452; Tue, 20
 Feb 2024 12:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024021921-bleak-sputter-5ecf@gregkh> <20240220190351.39815-1-surenb@google.com>
 <2024022058-huskiness-previous-c334@gregkh>
In-Reply-To: <2024022058-huskiness-previous-c334@gregkh>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 20 Feb 2024 12:23:01 -0800
Message-ID: <CAJuCfpEzRNG-aZWskphrUFCC6wr8nbsbpCxwG9tyfxA=CyWCoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: 9328/1: mm: try VMA lock-based page fault
 handling first
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Wang Kefeng <wangkefeng.wang@huawei.com>, 
	Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:20=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Feb 20, 2024 at 11:03:50AM -0800, Suren Baghdasaryan wrote:
> > From: Wang Kefeng <wangkefeng.wang@huawei.com>
> >
> > Attempt VMA lock-based page fault handling first, and fall back to the
> > existing mmap_lock-based handling if that fails, the ebizzy benchmark
> > shows 25% improvement on qemu with 2 cpus.
> >
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  arch/arm/Kconfig    |  1 +
> >  arch/arm/mm/fault.c | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 31 insertions(+)
>
> No git id?
>
> What kernel branch(s) does this go to?
>
> confused,

Sorry, I used the command from your earlier email about the merge conflict:
git send-email --to '<stable@vger.kernel.org>' --in-reply-to
'2024021921-bleak-sputter-5ecf@gregkh' --subject-prefix 'PATCH 6.7.y'
HEAD^..
but it didn't send both patches, so I formatted the patches I wanted
to send and sent it with the same command replacing "HEAD^.." with
"*.patch". What should I have done instead?

>
> greg k-h


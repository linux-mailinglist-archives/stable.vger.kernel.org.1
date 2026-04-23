Return-Path: <stable+bounces-240498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ABbM+Qn6mnkvQIAu9opvQ
	(envelope-from <stable+bounces-240498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:08:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F854537A7
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29B5D300D695
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF17630C61F;
	Thu, 23 Apr 2026 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/jVyTsG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359230E821
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953249; cv=pass; b=oWbvAZmkpeRnDkRoJTSlv84IV3FJ0coPakrXFHaIVdlIiG8gz1YWlTFaqsXwocfkdC+4H62frBBcG3xCvURT5zAqeMV1C9QCoktsfsejZTaN6EXaxXjNm03Srz2x+jUISBkKOVcgochdKObT7TgwRXm1xvVTvg6cVdB4GkFdE7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953249; c=relaxed/simple;
	bh=vdEgnQ7UYncJPIweIDG0txiZ1qkftEmzo9ZKETJ59o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRwfPKhsWXYfFiJ3zSZ/K0Q+TDaLAxKE8HPUWoDHNnwrXDprStjzeYNp+g33FfaATefyI7/lcTvaBWu+jYaS7zVFic7ft2XuEhlMYIDpIZ9atoLJPArY6AO6c4o3/ADq5D0C+8NB7YRdhXw/shmRAb8qbyjkDqoXnrgmXYbssyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/jVyTsG; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso43679296d6.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 07:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776953247; cv=none;
        d=google.com; s=arc-20240605;
        b=Kkru7d8POzDbVSVGLKm74w2D7xbcrlo+AG/dZJsSUbxPztKZlY9Lf/6oAf+3Jd/JFP
         9ySv/XVYnmgl3Daj3gEwx/S7qixbqjKBUiMtOzWKMM5yGcfG8jNLzI+EhbdPzuVmsoQC
         GjMQxFsvzO1zDJ2qlcoJC/grsw/GDnhwEpy0i+GY6RGqqvyhXqdD+TfQ1FMBTF+UpzKS
         YCoIh+ApUdmoZZP9x01UXpLdOYYeH4YSK4g/gYsT/7sjpa35eOYZ3Fdcvs7W+edxUhBJ
         bLTJwNKyltN9uP/fy/qnZXLbylsjUQ6bpBurenCzapGXpb0pU/SqNo3cIcSyrrRGNsR4
         ijSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YnWvO7yjwrQhs9Z8T4RkhOyGwxBUSEXUTTKsZ/p4eKo=;
        fh=si+Uk+ldnz5zyi3hQC6JllhxCv/dYdAihees0/YuzL8=;
        b=J56RYew5SyD6GcnYvRh8kajBDlsllU7wr3qCjcO+zJj2SJR8Mq2B5jDpJyUfP4XFCe
         TpAeiUQ43VNBhex9dzdhS1e61VP75NlPgWENbwyeNZZcxUkWHauebictC9zBjaGa53jM
         uLQMZjyIJDBFO6/iAmBJ0UC5fun5rsBKIEKH1pNYtWlx2/fIO9w48lSqpinBNTl1Sx+Z
         /c/fel7NTI0P3kwSDD9+faR4mW7xiaNkxWf9m/5Psc5ZoqDrwYsbksFvogofr+lKieat
         758mDwhaUSGzvrnth68KjaiJL4Ps4qDDu/P8ZhmUF8DbbHm+vgPvqKZbj6bUjNM48RsX
         IeOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776953247; x=1777558047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YnWvO7yjwrQhs9Z8T4RkhOyGwxBUSEXUTTKsZ/p4eKo=;
        b=s/jVyTsGiyxgRH6irkrvazOlJ8hh77TwqdWVTqJOHk2RZbYFY7lA+SMJiqQluWOsGW
         Qhm5sYAM1+wsa2rtVMJpgR8T1CmU/vi4uOBwc+GEa52TceRDn3BBIdkxbehMpvh/fT6v
         0DWm5GXz4PUxaV6T/o5Ne+sVqRrO4w3sYF/L4X/kiCltCTJG2/KxqqNc4DK8JDMm6xQh
         JhP116cS8NGI3wkJBQf3YDB4HGdpLweTYgK4uQ9YQOrzX9ksUciNoux3TxJfEtsIGKHf
         oZq0RhuCFWik05NjL0PNis2pMAMCYf0yIVwybcPtg9EPM6osIPCfHIKENbr2BfoNB8kC
         YKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953247; x=1777558047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnWvO7yjwrQhs9Z8T4RkhOyGwxBUSEXUTTKsZ/p4eKo=;
        b=aoJeMt2fNVzshT8FAscQjVNwXlPcGKpLnPjz6sy4M3n1bVeOqye9A0FxhTfnSPdjTJ
         0kfgzSPv7uznkdCdNiuBbGWtnLAEbTmNR4Qza63TQ9RIGjazdWUeLy19zyvRtgdy2dsU
         8GkghtY416QrbmYw9jhlEVajc85v/UZzaSdePTR4WpY5/hwU15S3UVcncQ4cNlQ50UK8
         ywoCsxrMuFXrA7xipVRC5NgWOSubQKz+Mllebqr7A4B2aG0FE/jMtlKSeA7/CtovgJQQ
         //JfYFBEINy7vVppcTiOVgrN+UyERI/k36GSmSwN4RYGjY2SLPG2SWXdvIWZURa4rVqO
         TDYw==
X-Gm-Message-State: AOJu0Yy7ShD5H0tJhQ47DEpE4XzeFguM4liWp6rjyT38vkViO93ZdjGn
	PCQNX2bGbV3EteXIPy4eiH0tetW8V7ihaTChYAiBE1tNKuz2D/HoQFD60Ip/wBuAjpEaOJCVBjD
	4A4dDBgTt56dRRSiUZUaWGrce2Vsh28I=
X-Gm-Gg: AeBDietgqMAIfmtsU29qc3lImBzoQ94Jsk6womE8hTw7ADg4yHOLRXvFZFJ7W1Bxz14
	A0sVH1T02KuwQV06J4Q7w8lGWAMtDX5P2vknHzpd5go9hAHTPVeCwbpr/TYLAhaXmV77Gz1GEpr
	3ccZnEmUJ8AULIjTUjzC3vm2cngplxOJN5a0IjGJba1sP4XMKLSU53o9U9Tog3fsS/0SkzAyMVb
	VHqwMLquoN4jchWVhLG5dHqwpP7QGX15+G0T4BQ3aLinHMvhO4HHWOANV8wpcwMulcJBP0sv3ut
	A7VvyhRDtwRbKw==
X-Received: by 2002:a05:6214:5505:b0:89c:cb57:6227 with SMTP id
 6a1803df08f44-8b028565f9fmr389605626d6.12.1776953247144; Thu, 23 Apr 2026
 07:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219171310.118170-1-aha310510@gmail.com> <2026042355-blighted-chewing-5e50@gregkh>
 <CAO9qdTE0NhB58hqK8_1=69bD7uG_vF-FfpQXGR8dqcuWV4H2Mw@mail.gmail.com> <2026042327-wackiness-purify-09c2@gregkh>
In-Reply-To: <2026042327-wackiness-purify-09c2@gregkh>
From: Jeongjun Park <aha310510@gmail.com>
Date: Thu, 23 Apr 2026 23:07:14 +0900
X-Gm-Features: AQROBzCIjy63kF1LW75_LGFH4-N7i7woPyvD8ToIg_JgdzxbdpkrD0vUqxkoZkY
Message-ID: <CAO9qdTGQPoMdh6ds6LFWEDtPSnjWEM746mrpfaVfxi8LBtckwQ@mail.gmail.com>
Subject: Re: [PATCH 5.10.y 00/15] timers: Provide timer_shutdown[_sync]()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, tglx@linutronix.de, Julia.Lawall@inria.fr, 
	akpm@linux-foundation.org, anna-maria@linutronix.de, arnd@arndb.de, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, luiz.dentz@gmail.com, marcel@holtmann.org, maz@kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, sboyd@kernel.org, 
	viresh.kumar@linaro.org, zouyipeng@huawei.com, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240498-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,linutronix.de,inria.fr,linux-foundation.org,arndb.de,roeck-us.net,gmail.com,holtmann.org,kernel.org,infradead.org,goodmis.org,linaro.org,huawei.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 52F854537A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > Ugh, I got the following build error for this series:
> > > ../drivers/misc/sgi-xp/xpc_partition.c: In function 'xpc_partition_disengaged':
> > > ../drivers/misc/sgi-xp/xpc_partition.c:294:25: error: implicit declaration of function 'del_singleshot_timer_sync' [-Werror=implicit-function-declaration]
> > >   294 |                         del_singleshot_timer_sync(&part->disengage_timer);
> > >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> >
> > Oh dear. This issue occurred because commit 997754f114ef ("misc/sgi-xp:
> > Replace in_interrupt() usage") was merged into version 5.11-rc1 and was
> > therefore not backported to 5.10.y.
> >
> > Since this is a simple fix that only requires adding this commit to this
> > patch series, I will quickly write and send you the v2 patch.
> >
> > https://lore.kernel.org/all/20201119103151.ppo45mj53ulbxjx4@linutronix.de/
> >
> > >
> > > Don't know what happened, but I'll go and drop them all now.
> > >
> > > Do you _REALLY_ need these in the 5.10.y kernel?  Who is going to use
> > > them?
> > >
> >
> > You might think it is unnecessary, but I have seen bug patches related to
> > timer_shutdown[_sync]() being backported after I backported it, and I
> > believe it is well worth backporting if this feature allows various
> > bug-fixing patches to be backported smoothly.
>
> So you don't have a specific issue you are hitting with this patch set
> that you want to have it here for?  It can't be for android devices, as
> this patch series will be reverted from that tree, just like it was for
> the 5.15.y Android trees, so what systems require it?
>

I am not backporting because it is absolutely necessary for Android or a
specific system.

https://lore.kernel.org/all/20251007155808.438441-1-aha310510@gmail.com/T/#u

I simply started this in the hope that the same problem will not recur, as
I had to write a separate patch a few months ago when I backported a bug
fix patch I had written because the feature was missing.

> thanks,
>
> greg k-h

Regards,
Jeongjun Park


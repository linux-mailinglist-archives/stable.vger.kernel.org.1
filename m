Return-Path: <stable+bounces-154565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3BAADDB49
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 20:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012A14A1A31
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389DF21A447;
	Tue, 17 Jun 2025 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjnoZCOY"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F22C2EBB80
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184744; cv=none; b=PGqtgI7Rsb6ZAmgZ2YvF62aI7UU56B5Yn1rKEa4PPeos+tJT6VqFJo3m9wmh6VrmbDr7YjicHskCH4bPF5jkMXOMvzpy2GF7Jig2Ktk/YZrtcrv4W82vcap9w/5dYE0AloM+TE/8GWwu/8I/xgWe1JrVCF9nzZYQ+7m59be8uQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184744; c=relaxed/simple;
	bh=mm3yab2sZRR/+DADP2ehV8G/nxgMSR70bl1lJapIZkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOIbbZYWVAQFG1SmyfZ7Sv2ZBfRqrx2oE90fHhqqjiY7FEHTRcTNpfJT4Y4Vzr7H78XAmmKW3yL572az60S6b2sgzhzk7QIm3YFHd4+zNd3PhkHdrIhQ41qcVeuVoVY5aUzRpCf0j6uMERZRVM07rHAosdZ1jpOMCQzuJos/OZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjnoZCOY; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32b7123edb9so9255181fa.2
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750184740; x=1750789540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQ4qkDHPaV7BDdZpqRDsoJFCKFnruqaPeK/AbJzqYW0=;
        b=tjnoZCOYS4tjBWPKhvq5SWXWMeztWysxHGpMAB+PJa8jCyDKVfvmHVQTsl09nTU+9i
         YTyq/JFifxzBlVxTvQuc699RkLcpIL3v6VmjOXTuFUJ4BhPIy3IXc/w1aN9FnBkzpp89
         /eeCIPQTqDrUHjPrl3372HnqKtEljoYGdBWgnmIF/P0VC3lAIo5YHSnZKiMaSYhbnD4N
         +Eg6R6s1LFHArqgXPU1uecr/+pCeL83JS696cfNeLGSzqR+Hr4EFHjyLsxwTTFfW4Nz5
         iZBtYi3tohpVm5T5SsZo/Gfl+k7yge9D7dxpWVlA/IYXH7taZdtXxmpTiMud1IY//ASk
         njaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750184740; x=1750789540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQ4qkDHPaV7BDdZpqRDsoJFCKFnruqaPeK/AbJzqYW0=;
        b=YguTVtr9QtNoPVyYTa6/nB44fBKGUoM3VDntGZzxDJd3pewC92FXpnwhTdm+jV/CzY
         lcOSrTrSCvJB6vZxUgKMdTUSsdBoWGomKAePKppjoD9GRDTUyQFJACx/Ds7UdxSz4p6c
         FEJDRF4ReTTllt2/i1AdN3RFLw0kOfo86hSW0B9UByjDF0PxCQtmPW7p0Fk130z+Y+Ym
         becwnW5Gql3wmCIMx8yGCocTtt+doTbzMS2oB9v67TfB5d5XtLBnOpGh25aDosP/zZmF
         8rT8uyyUbO5rtSvXmZDhKtt114ej/KL+QSKsI5YWVYq1lh2qkEJX/BF/IFFD4xFPa67W
         oqWw==
X-Forwarded-Encrypted: i=1; AJvYcCW32nOkZtKhwvYOSQg3HnSHJia1/nh2utNx+mf5O3qoxCTewFAfT05JaD1mwEEOFlPbhcDQ1XU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Vi3KWOQZrtEx565rfV3E47np24hM1qu23F3tsvLRj5BbS0yT
	4qTa1k6E2CMGuxuGRO0dUuXLwC8GvyBJLgSny7FGiOlFcnMcVWHuaYhXm2yP/3t6SkJZsAJqmiu
	NQzrrkefd2YVZvccZKNWPUYxAXi9uySfTGMXcm2VB9sdYqni7ZPR2CA==
X-Gm-Gg: ASbGncu2e1H8lvdj159OuKiq6AX+doKDqdDJxKPOvdb65w+o28Zf8TVegcq9x5po715
	xYEzYVBe1+cyWjT/VmMG9CjQ5owDlfqtvN2ftZ0hPNxDzm1fWQCCXDizkHhAcTnKX+LUKp+aE7w
	5OHDGTBTjhgP0j7ZfpkSr/BXDyKX5Jnt4golaJOu4uSxU=
X-Google-Smtp-Source: AGHT+IGrZsLW9DjNWb5jhWUSKce2LjoSTMDK2XGnOs97Tp7M1TXO9eH5XVrHznP63PG8KFJ6Tm2Hr3oMej0naxklo9I=
X-Received: by 2002:a05:651c:1423:b0:32b:47be:e1a5 with SMTP id
 38308e7fff4ca-32b4a7030d3mr30371381fa.39.1750184739953; Tue, 17 Jun 2025
 11:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aElivdUXqd1OqgMY@karahi.gladserv.com> <2025061745-calamari-voyage-d27a@gregkh>
 <aFGl-mb--GOMY8ZQ@karahi.gladserv.com>
In-Reply-To: <aFGl-mb--GOMY8ZQ@karahi.gladserv.com>
From: Willem de Bruijn <willemb@google.com>
Date: Tue, 17 Jun 2025 14:25:02 -0400
X-Gm-Features: AX0GCFsmrlWBjBQ22REUW9WD_pmKQ8rQnTSfDc9BIdn9LRRzQhwwh-qhv8-aS4g
Message-ID: <CA+FuTSen5bEXdTJzrPELKkNZs6N=BPDNxFKYpx2JQmXmFrb09Q@mail.gmail.com>
Subject: Re: 6.12.y longterm regression - IPv6 UDP packet fragmentation
To: Brett Sheffield <brett@librecast.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, Brett Sheffield <bacs@librecast.net>, 
	stable@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 1:29=E2=80=AFPM Brett Sheffield <brett@librecast.ne=
t> wrote:
>
> Hi Greg,
>
> On 2025-06-17 15:47, Greg KH wrote:
> > On Wed, Jun 11, 2025 at 01:04:29PM +0200, Brett Sheffield wrote:
> > > Longterm kernel 6.12.y backports commit:
> > >
> > > - a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a "ipv6: save dontfrag in co=
rk"
> >
> > It's also in older kernels:
> >       5.10.238
> >       5.15.185
> >       6.1.141
> >       6.6.93
> >
> > > but does not backport these related commits:
> > >
> > > - 54580ccdd8a9c6821fd6f72171d435480867e4c3 "ipv6: remove leftover ip6=
 cookie initializer"
> > > - 096208592b09c2f5fc0c1a174694efa41c04209d "ipv6: replace ipcm6_init =
calls with ipcm6_init_sk"
> > >
> > > This causes a regression when sending IPv6 UDP packets by preventing
> > > fragmentation and instead returning EMSGSIZE. I have attached a progr=
am which
> > > demonstrates the issue.

Thanks for the analysis. I had received a report and was looking into
it, but had not yet figured out this root cause.

> >
> > Should we backport thse two to all of the other branches as well?
>
> I have confirmed the regression is present in all of those older kernels =
(except
> 5.15.185 as that didn't boot on my test hardware - will look at that late=
r).
>
> The patch appears to have been autoselected for applying to the stable tr=
ee:
>
> https://lore.kernel.org/all/?q=3Da18dfa9925b9ef6107ea3aa5814ca3c704d34a8a
>
> The patch follows on from a whole series of patches by Willem de Bruijn (=
CC), the
> rest of which were not applied.
>
> Unless there is a good reason for applying this patch in isolation, the q=
uickest
> fix is simply to revert that commit in stable and this fixes the regressi=
on.
>
> Alternatives are:
>
> 1) apply a small fix for the regression (patch attached). This leaves a f=
ootgun
> if you later decide to backport more of the series.
>
> 2) to backport and test the whole series of patches. See merge commit
> aefd232de5eb2e77e3fc58c56486c7fe7426a228
>
> 3) In the case of 6.12.33, the two patches I referenced apply cleanly and=
 are enough
> to fix the problem.  There are conflicts on the other branches.
>
> Unless there is a specific reason to have backported
> a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a to stable I'd suggest just rever=
ting
> it.

FWIW, I did not originally intend for these changes to make it to stable.

The simplest short term solution is to revert this patch out of the
stable trees. But long term that may give more conflicts as later
patches need to be backported? Not sure what is wiser in such cases.


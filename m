Return-Path: <stable+bounces-70071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0179195D86F
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 23:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACB51C20C78
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 21:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEBD19046E;
	Fri, 23 Aug 2024 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ0hnbs6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C1E80C02
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724448240; cv=none; b=Rc/P1Vomx91Vm3kuwqKlpJINm2f1EcvUEW0YJt8llEv/c7nafGdMLykxQLv2PT8jvsxFPlpLplXYZGXnan4P/u5qDPbB+oCjgg5irbn4N+qvEofZLfQARCog5tBtXcbppyEsKUOolyvq0vooG+K4XxD18V9WX+qHJGnNHEFfTTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724448240; c=relaxed/simple;
	bh=oVX0gprL1g84iPtJiXZbGlPhFQ5hcBmSUv2sjHyFPOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgquxAtlhes0swIK8KP1/GCzMAFyehaeNBPAJiANU8V9TJisnwKwvks7rURvO6HeKOT34A4LRuQu5SCuAycSI/3gBrY8STLrFUzxhrovIHN+99thnkOwTGu5Aoo6zH2cLrbODdDwQOXZo9OW52rLvmEcP06rgc1vO1UgBRZE8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ0hnbs6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2022fea51fdso2815685ad.0
        for <stable@vger.kernel.org>; Fri, 23 Aug 2024 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724448238; x=1725053038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVw3UGVAksq0IK59oQbkTTVPhibGCKRt7ecfvi6uMvU=;
        b=mQ0hnbs6WUsq3CmE+fWedep45qtFbkyahY5pRFs81MuMrHOZ2zk5ibT/+x4tLQMIaP
         ofnHsSCEz4YANI7hxAxwNbNR/sPgrpAYX5Kf8b+lHjs7MPdtzquQOurLDux8YY2pbnDT
         3FgzlOmu6O3G8JGKTiMy5d6k3HfX6XiJULs78fPGpFzUP36G4ncOCf4WEuBnu400hoss
         oK1mT3M7Y2cXO6hrCkYb3qYUTuXLg3lzy+svY160W72Bjo7Oql/RgCAOpNTuqRAb+Vd5
         nhwGnQ5XB1npZSpMY9DISTEALpOwNRO1PUIVnqjB/zZjRotpp4RIFHrG4IESPF73bJH9
         pbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724448238; x=1725053038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVw3UGVAksq0IK59oQbkTTVPhibGCKRt7ecfvi6uMvU=;
        b=igaltO6rLg0cN5+RsXeMCPi+1SApJ2dniTU6xI6gLM6j8YYPrgmpZ6vBeDKrcYeF23
         Bh9PQteXf0ys7xV2qsxNJkjqmNAw1IVwkUym0x2kgsGPzkntE1YJzOkS9R8kcX2LOv9d
         p8SlP6IZYKHgcGCUTucfjRu9rqUWTgyqX4tJhy8OoIx3ovtuaxwY276RS/qXa7rBmb4k
         n6XHTpBnJ0SuNm3kjmHnnVYwkvheoUrOsIgnqqMdYCqcELXaGXLROwq3YooH85LCB1B8
         MS1yis+2wpKgcU96YR7jqn6bdkwfX9j3vdTAi8j6p4/yj0K00sYolxjNIlwQwi1IcR3t
         nMFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUiXfGNiTwo2QW9VfdKe/VSvhOjDPIkUayOGkCZvvkg5BniBIk/K9+dp+joAYlAHGocb4oesc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6crDEuzy+1iFT3tOsBVBfK/j9wEH7MIcgGeEXAz0YG9dpECCI
	B3QCaaGP2J3ll3DQO3Kq6AcO0B8N5dTYXIJltMpm3kLKNLdM0g8KQz78qKMOlRI0A8pNnuyKsuP
	k9C4RRjGE6BR7PY6+wM0qbIt5R7Q=
X-Google-Smtp-Source: AGHT+IFlOkaj3R9oJ5MLV1p2+5FXk+ZEOLOmbW8Wg/l2bhgSMmOXoWoM5YzlxCIpuOtkNz77NLUceTnVMAFojKzGrBY=
X-Received: by 2002:a05:6a20:6a07:b0:1c2:5f80:6bc7 with SMTP id
 adf61e73a8af0-1cc8a01ea7emr2752575637.4.1724448238192; Fri, 23 Aug 2024
 14:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024081247-until-audacious-6383@gregkh> <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
 <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com> <2024081558-filtrate-stuffed-db5b@gregkh>
In-Reply-To: <2024081558-filtrate-stuffed-db5b@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Aug 2024 17:23:46 -0400
Message-ID: <CADnq5_OFxhxrm-cAfhB8DzdmEcMq_HbkU52vbynqoS1_L0rhzg@mail.gmail.com>
Subject: Re: AMD drm patch workflow is broken for stable trees
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 1:11=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Aug 14, 2024 at 05:30:08PM -0400, Alex Deucher wrote:
> > On Wed, Aug 14, 2024 at 4:55=E2=80=AFPM Felix Kuehling <felix.kuehling@=
amd.com> wrote:
> > >
> > > On 2024-08-12 11:00, Greg KH wrote:
> > > > Hi all,
> > > >
> > > > As some of you have noticed, there's a TON of failure messages bein=
g
> > > > sent out for AMD gpu driver commits that are tagged for stable
> > > > backports.  In short, you all are doing something really wrong with=
 how
> > > > you are tagging these.
> > > Hi Greg,
> > >
> > > I got notifications about one KFD patch failing to apply on six branc=
hes
> > > (6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, that you
> > > already applied this patch on two branches back in May. The emails ha=
d a
> > > suspicious looking date in the header (Sep 17, 2001). I wonder if the=
re
> > > was some date glitch that caused a whole bunch of patches to be re-se=
nt
> > > to stable somehow:
> >
> > I think the crux of the problem is that sometimes patches go into
> > -next with stable tags and they end getting taken into -fixes as well
> > so after the merge window they end up getting picked up for stable
> > again.  Going forward, if they land in -next, I'll cherry-pick -x the
> > changes into -fixes so there is better traceability.
>
> Please do so, and also work to not have duplicate commits like this in
> different branches.  Git can handle merges quite well, please use it.
>
> If this shows up again in the next -rc1 merge window without any
> changes, I'll have to just blackhole all amd drm patches going forward
> until you all tell me you have fixed your development process.

Just a heads up, you will see some of these when the 6.12 merge window
due to what is currently in -next and the fixes that went into 6.11,
but going forward we have updated our process and it should be better.

Thanks,

Alex

>
> thanks,
>
> greg k-h


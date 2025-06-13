Return-Path: <stable+bounces-152623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7D8AD8F7B
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 16:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBC77AED57
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E8B18A6DF;
	Fri, 13 Jun 2025 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PcAPZLKt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3571547E7
	for <stable@vger.kernel.org>; Fri, 13 Jun 2025 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749824808; cv=none; b=CwG/UEg495QC38/sroRQMiUc/HvVwJ1JuzRA6JcfVpz+s1jRmXYVezvfWSLqVYtUvX6PQu6WuVDWgjADeyaYQcqXvsTBW7/No6n7xiBNn1hotQOqRVJeq4HDG818nUX3s4iimDoIFOHnDiMZ4Kvoe02VwAz61m4/YF75Gwr1V/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749824808; c=relaxed/simple;
	bh=ACP/hrp9Qfye/edApO/TeDy89ncgx6tq3kl7aHALZpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aF4b6fCbIdqOok3InyTPhLIJqduhRrKOqjPon8uS5ICsrK1zxoTsKOLBuv2O5ivg7iamVmUmbFRUi1m6aNktIWnlmmX40VBCg4LmUAlR76p+7pyz/xrxId025uBOanQH6yqA8wMr3V8rnhcla32XjD4PGZs4gHKEod7qrSpAzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PcAPZLKt; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47e9fea29easo369011cf.1
        for <stable@vger.kernel.org>; Fri, 13 Jun 2025 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749824806; x=1750429606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8Jxe80PMT+botQHpeWFQMqNDpkBacoLOJzzs4cmSiE=;
        b=PcAPZLKt9+nXrU53hJ90Tmhfeg2D4hDXX+ICqhmMYDTfAkWsExNYXre5UGzG+SC9iP
         dsjdD+YV0Ax1fiUCyTZex1mxkJa1m8nrMQUqSyYBdf1vPLACemXKn8NGT6Tnb8gTh8hZ
         FpLr+BA2NiYtD4ltLlSr6WCv1ds6HGLDHLo35BVTmzVs9eqsWc5j5pqB7TKIjIzuEgu1
         DO/ClrAkWeOVhuBvgk+FuaslkTNYuz7/G8VKsl7VgnQGGP4lDd1hRbe5w4dbZq2A4pIf
         bOfVx82ydMam3maChKgINNH/ffeP5bxUKsB1t2rPOsQF+G6dSFKt2CWvM3iAVnwS7m0Y
         yj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749824806; x=1750429606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8Jxe80PMT+botQHpeWFQMqNDpkBacoLOJzzs4cmSiE=;
        b=SEm/qEzNRAQPj+rnsemSSBM9uYoI0Y7Rk92eiM9jWPZGwKE0hsQBT6do572wH61irf
         hmgS/yc2996iZsoCuXaopxMH2/FYfH8757x1Spah/56Qd2so/dKJuvkfHUgJQJoAf3mg
         2NuO+p7Bt3QH44HnHNinoeZq6HvZDx6PSOdKfS6pmTaJMBqPSx3y6szXgoozDxU4WWyD
         oVE/jAo1aipeBwgUCJaWbALq1sPUXmMSr58xB0pwPTMQ5sw5Ej2naC4JIdAGGSpdrE7o
         TefVvkcaI+uaHBYlPpToHCGfEVYmZEGUQnPqnlAorRFM6ee4mDqkfww/M9Q4aEeZzb14
         HOMg==
X-Forwarded-Encrypted: i=1; AJvYcCWCe/8vcIHTMfrG5I7U87y4SkoMSzXlTUoV3BXW7/OljFhCnQyJOG76amkdkN1tSiN8RInrDMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSnox3cTvBpjp3dK6OgaD+NDRpfUqnMqLGVkos2jwXdWhstYO
	4ZSVoaw7idK7rVes97yyvn9Avvs+8bI3RLW+P/cSMIoOqldAJeXuDrClZmLw3HzHYds/os5Vxf+
	/XvLZ/7BkzRNIrj52rIA7N6vhi40kbMjh74JyDljs
X-Gm-Gg: ASbGnculCcBWRKEgFxRR+vnd4jSZk6hDxc2AfC29PErtoMaZFMlcxSzoX9NzWJGbNpx
	vl/OFYc67JsIs0vTgrh3okriRfMym0MQiydh+K1zz6X/VKMzFvyfl6s9PccY11R9qeLsNgHgDrx
	VJJM8fAvtw7NpIf9f/hp2kI98VwAGiJ7BtPhHp3JuHhXMO
X-Google-Smtp-Source: AGHT+IHbli7Lnsvwsi7yQrld3VyFR4wD7vNt+L+iVVFtsCnMyMdexDNlww/fNjqKMLlNLxY74C9MxoEAw1mQ94XjIUg=
X-Received: by 2002:ac8:5fc4:0:b0:47b:840:7f5b with SMTP id
 d75a77b69052e-4a730d79d74mr4093481cf.29.1749824805557; Fri, 13 Jun 2025
 07:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610215516.1513296-1-visitorckw@gmail.com>
 <20250611184817.bf9fee25d6947a9bcf60b6f9@linux-foundation.org> <aEvCHUcNOe1YPv37@visitorckw-System-Product-Name>
In-Reply-To: <aEvCHUcNOe1YPv37@visitorckw-System-Product-Name>
From: Robert Pang <robertpang@google.com>
Date: Fri, 13 Jun 2025 23:26:33 +0900
X-Gm-Features: AX0GCFvkWwS1rcTtPYvnDVkpn-tKhNLpwiqEQsoAt3bvG3Gm0tJIQwjdfh_F5WE
Message-ID: <CAJhEC05+0S69z+3+FB2Cd0hD+pCRyWTKLEOsc8BOmH73p1m+KQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Fix bcache regression with equality-aware heap APIs
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net, colyli@kernel.org, 
	kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-bcache@vger.kernel.org, 
	jserv@ccns.ncku.edu.tw, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew

Bcache is designed to boost the I/O performance of slower storage
(HDDs, network-attached storage) by leveraging fast SSDs as a block
cache. This functionality is critical in significantly reducing I/O
latency. Therefore, any notable increase in bcache's latency severely
diminishes its value. For instance, our tests show a P100 (max)
latency spike from 600 ms to 2.4 seconds every 5 minutes due to this
regression. In real-world environments, this  increase will cause
frequent timeouts and stalls in end-user applications that rely on
bcache's latency improvements, highlighting the urgent need to address
this issue.

Best regards
Robert Pang

On Fri, Jun 13, 2025 at 3:16=E2=80=AFPM Kuan-Wei Chiu <visitorckw@gmail.com=
> wrote:
>
> Hi Andrew,
>
> On Wed, Jun 11, 2025 at 06:48:17PM -0700, Andrew Morton wrote:
> > On Wed, 11 Jun 2025 05:55:08 +0800 Kuan-Wei Chiu <visitorckw@gmail.com>=
 wrote:
> >
> > > This patch series introduces equality-aware variants of the min heap
> > > API that use a top-down heapify strategy to improve performance when
> > > many elements are equal under the comparison function. It also update=
s
> > > the documentation accordingly and modifies bcache to use the new APIs
> > > to fix a performance regression caused by the switch to the generic m=
in
> > > heap library.
> > >
> > > In particular, invalidate_buckets_lru() in bcache suffered from
> > > increased comparison overhead due to the bottom-up strategy introduce=
d
> > > in commit 866898efbb25 ("bcache: remove heap-related macros and switc=
h
> > > to generic min_heap"). The regression is addressed by switching to th=
e
> > > equality-aware variants and using the inline versions to avoid functi=
on
> > > call overhead in this hot path.
> > >
> > > Cc: stable@vger.kernel.org
> >
> > To justify a -stable backport this performance regression would need to
> > have a pretty significant impact upon real-world userspace.  Especially
> > as the patchset is large.
> >
> > Unfortunately the changelog provides no indication of the magnitude of
> > the userspace impact.   Please tell us this, in detail.
> >
> I'll work with Robert to provide a more detailed explanation of the
> real-world impact on userspace.
>
> > Also, if we are to address this regression in -stable kernels then
> > reverting 866898efbb25 is an obvious way - it is far far safer.  So
> > please also tell us why the proposed patchset is a better way for us to
> > go.
> >
> I agree that reverting 866898efbb25 is a much safer and smaller change
> for backporting. In fact, I previously raised the discussion of whether
> we should revert the commit or instead introduce an equality-aware API
> and use it. The bcache maintainer preferred the latter, and I also
> believe that it is a more forward-looking approach. Given that bcache
> has run into this issue, it's likely that other users with similar use
> cases may encounter it as well. We wouldn't want those users to
> continue relying on the current default heapify behavior. So, although
> reverting may be more suitable for stable in isolation, adding an
> equality-aware API could better serve a broader set of use cases going
> forward.
>
> > (Also, each patch should have a fixes:866898efbb25 to help direct the
> > backporting efforts)
> >
> Ack. Will do.
>
> >
> > I'll add the patches to mm.git to get you some testing but from what
> > I'm presently seeing the -stable backporting would be unwise.
>
> Thanks!
>
> Regards,
> Kuan-Wei


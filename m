Return-Path: <stable+bounces-210090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB270D38494
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 19:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 048AE3007518
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 18:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7272533C50D;
	Fri, 16 Jan 2026 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0dKO9GNo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C678F1AC44D
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589144; cv=pass; b=GSZ9TUCI5looAabFXTu6PmFJwZrtXHqApKl02xf8PaZ0kNAICUW4wlnq0kLAaVoBDi4gV4mGp06LfBmBEuKuf8mYuKApsfgYM0Mv+kboCu0MtAFw1QxudF91Yn4ZFLzV7y63lkQ8jUwIRJcJWgL0uixaJhALNatf9i9ctXT9oxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589144; c=relaxed/simple;
	bh=hMmiW8zfRsv2dvkHvXYKEE/1e1KgEYzpKKHi4QV047o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXfyF9L3sSSl+aW4GTaxxKSpOYoUpdDJnZDwQiFI3hE2s0DdFrDyqIei54f/U20Jh5a/zTrs2ROfwcxaPh/LrpvCn+GGte18x0ZdgW6FsQRt0n3zclaiLtN0gPuA/3FV/bpMq+AlVQ6Hh2Sd72JUZ/J1oPGs1E+laj1uM5CdHKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0dKO9GNo; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-501511aa012so30661cf.0
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 10:45:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768589142; cv=none;
        d=google.com; s=arc-20240605;
        b=TqKN0Eq/D175RjDVSuIY5WpY5UPUHMrbl0poQTIDJ8hXuv4l5QMLcg4FLsyLNLz6BK
         O40Uwn1tXs41IN7C0ZiPJGnUVVhxVQe1hEZJwafjQQ4UIvkd125HbSK7KSGTA5FNNTcG
         Ru3AnTi9b0VEuA1zcF1nJe7oknnEeK8hRwwGnJ0QCMzJsNOUW7SDdv4gDOoAyZUuIalV
         WrvDEXaROENjb9tRHd35b6yMwj0cElJ9zobcaDlbAeg78T1tTyrFyJN9qDIQQyfceJAz
         3Yof1d6++SZxCs3TQq9bAT5ZhsEwBZL9Tx2vqzsKsRMz0lXpp/4ha2FkAyuwamWpRSkA
         JfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N6bLqjwmicKmcvJcfCMzcrC4HuJd8fUxKurXeY12ItM=;
        fh=b0rvvWs6una0DVT+enBUSbrDgSlDSWD3ghDTasYK7jI=;
        b=XC1znQgJM8Z2REnx5pDMXhyUu3xaQGLoW+LdPaQ/Tl+yFX6wgj0YPxqti+Y4S/+VzF
         khiOFVbOcbDQ6FprqDhbyQUfh5BcozyxmOgesVS4HYHykE1EiKZUWPH9ab7jsEHsWJ2p
         Xn4iTJJORpCV6xMs5R3qSWeR8j+1RXXBT9iboJ4p9Iw5aIDKF4y4lPZG0l9KU4QbLWrw
         aw4N+QegCLUCr8NmPB+DLfmH2Iqn5qODfQR6TGzGl3zVR6ORvUXe2wOpauYsr8fHNA4w
         fEbAclRj4T/o64FLX47OxFILxRUqFIW9p1SSqKgJYo1GCPiM1rO/LXIMc6qaVGEbnqCB
         vIkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768589142; x=1769193942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6bLqjwmicKmcvJcfCMzcrC4HuJd8fUxKurXeY12ItM=;
        b=0dKO9GNosxJwKOhDFPCxbI1v6KtQqJGOSN15jyPdKJGAgNWorYyaWau1wdmq5CQF4o
         u1E6tQcfqxZct3D7nKj+gOBXqZTFHI6fpNh1G6s3AmjTSeg8rszn4vbKk1CV43zM6khn
         rA8ql4i0FkaFE2oe87/t+s+wStgHZczBN1LRDDJwQMqGnGRVWQr5GGmqZDPFX2OAofhg
         Xgoo2pWfBjGkKFXkyyIakCYZHW5AG8dDetCYrpR9cqJtuNpTPfvk8X5sfp+FZwQMhCRI
         X6/j8yWWoE8T+IUIBwrkYxgWdj9NbsjHMKL8wXKaLPQiVqhd6qscNd6kulc0pG/jJu5E
         zmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768589142; x=1769193942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N6bLqjwmicKmcvJcfCMzcrC4HuJd8fUxKurXeY12ItM=;
        b=aEpKj8/TNtsReqTJaABuqC4qRLplkEcYzIV0I8WqqzPfiU/a7E1atIipRp3S3rDgh6
         ATppQEMje6rVboU0ZVH0bNbOyE/PL2Sj3n3zALqmy7utPw1Q4kSB6h+aG5uYJjvnv1qp
         a8fZ3b8MK23jt3k2SoUSvriE1rml2IxmbQEYR7HSUHQUJGNLNeZvvTEdC+IIKcoEy1NB
         1I9T/f/g3CW6BtUaEHRnSdK4ibIXrfgk9S4/iKHXR66VzcvrBbjB/h5UnBfeQwd3IV+J
         J388wLoswWgHkcCZ7aXqhgBitPgidNi8aW9X+2exQ5k6QncqpiEVdsPU/ez6gbsavcrN
         gl2w==
X-Forwarded-Encrypted: i=1; AJvYcCXlSkg25XyhWApwEazoZm8S016SDA22fcGv7/EG2gUK8PxFtl+eoTedjgHT29wETEq3q3k28PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDdWwyXUbpjmeOsl/UASg08r6rWseESd3ETZB5PvvmIHc+DumQ
	9WgxfM2NQhRenTB9U6Hxvl7RWBnzJNVXs9yZ4FAWEdHb18b0frAurb7O8HPrY35jKeLJNIXXO0Z
	k5PMe192OfNCo2Ppf2Sbjz6dcG9fGv4ztwp9nIVNS6kSpHgzds2+n55uRSjo=
X-Gm-Gg: AY/fxX6rRgSR1KUXYnnVNG3XhMFqFzr5YDKKdaT6m81H10LImj74Cpae0q2keKKYYu3
	npqSpbAIbJk+yrws1EcUummPwM7rv0pwwC8s5CLxmM7MR4zUmv7sc/Bq28mu+LWzOMVUAVGXWvb
	p+AxxDq12VSe7UNPpO9lf8fSW39RG4PSdOfY0QR4GtSnRCbVDVIlHGoDwp34EwV3Ta+bEms7UgD
	JIdUqzuj0PgftCWAwfCCnHhAEn0tPOew4aWfyFF42O6TPbVJJbrO/gxgwGmxPXO8j91zQ==
X-Received: by 2002:ac8:5a08:0:b0:4ff:c0e7:be9c with SMTP id
 d75a77b69052e-502af8fc780mr566291cf.0.1768589139933; Fri, 16 Jan 2026
 10:45:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpEQZMVCz0WUQ9SOP6TBKxaT3ajpHi24Aqdd73RCsmi8rg@mail.gmail.com>
 <20260116021835.71770-1-sj@kernel.org> <CAJuCfpFevUwXxwOrpH3+VOibjJw0rBw3=QL-nqeKreNEky7_Gg@mail.gmail.com>
In-Reply-To: <CAJuCfpFevUwXxwOrpH3+VOibjJw0rBw3=QL-nqeKreNEky7_Gg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Jan 2026 10:45:28 -0800
X-Gm-Features: AZwV_QhozlK7uakvTFIi3gMT5z1ESm9uu7kKs6NCK1JEMKW6K3c69hS_mesSIW4
Message-ID: <CAJuCfpGS_Kw7O1tTWAVs_6dHMPjewh9NLSB2TNRTKXTcwbq0xw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Docs/mm/allocation-profiling: describe sysctrl
 limitations in debug mode
To: SeongJae Park <sj@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, corbet@lwn.net, ranxiaokai627@163.com, 
	ran.xiaokai@zte.com.cn, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 10:30=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Thu, Jan 15, 2026 at 6:18=E2=80=AFPM SeongJae Park <sj@kernel.org> wro=
te:
> >
> > On Thu, 15 Jan 2026 09:05:25 -0800 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > On Wed, Jan 14, 2026 at 9:57=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Wed, Jan 14, 2026 at 09:45:57PM -0800, Suren Baghdasaryan wrote:
> > > > > +  warnings produces by allocations made while profiling is disab=
led and freed
> > > >
> > > > "produced"
> > >
> > > Thanks! I'll wait for a day and if there are no other objections, I
> > > will post a fixed version.
> >
> > Assuming Matthiew's good finding will be fixed,
> >
> > Acked-by: SeongJae Park <sj@kernel.org>
>
> Thanks!
>
> >
> > Fwiw, the typo is also on the .../sysctl/vm.rst part.
>
> Correct, I'll fix in both places.

v2 is posted at
https://lore.kernel.org/all/20260116184423.2708363-1-surenb@google.com/

>
> > And from the finding, I
> > was wondering if it is better to put the description only one of two do=
cuments
> > rather than having the duplication, and further if the 'Usage:' part of
> > allocation-profiling.rst is better to be moved to
> > 'Documentation/admin-guide/mm/'.  But I ended up thinking those are too=
 trivial
> > and small things.
>
> Yes, I didn't want to complicate reader's life by adding a reference
> for a couple of sentences.
>
> >
> >
> > Thanks,
> > SJ


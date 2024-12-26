Return-Path: <stable+bounces-106178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644B09FCF14
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 00:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2491A3A0340
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 23:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCF819992C;
	Thu, 26 Dec 2024 23:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x76JMJH5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2408190077
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 23:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735254473; cv=none; b=B/mXDbwNUDGLzwr0emQ3DhHPklyDgRCIjd2EusQdT0g0MbETo7JohV6wgaAAvguQe52miKZ8NKO+jXCToVAoxA90Bv6LOOPi3Q98BPhMVvgkuU1MUma4k1QKJNZpaMKu/F3j6w2LVxAfHhPKwvsaaBV2wKtY3vKyhWuvWIXpP3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735254473; c=relaxed/simple;
	bh=T7m1ZfI5nt6EBHnKwYOGho4eD3nQbiorgxa7jVOgQzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOVgYZr4nTggpdbyWlEjc0Z36KrCMRBYFaOKcEvKbX9yxd/q8XgmbeQThNEvsTT0adHzXUkQI6v2mG/2RM39elNeY+9QdPa+01Nkx0KgzRMqpM1LJS40NMxLwryFjmWC+CuKKReEVc7CiL+i26EOJPKK2LviWzc1TCvlDfUNvcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x76JMJH5; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4678c9310afso1715051cf.1
        for <stable@vger.kernel.org>; Thu, 26 Dec 2024 15:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735254470; x=1735859270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRomBso2hHE7YrImWq0wbVcT1dst09ldMkIN2FASxJ0=;
        b=x76JMJH5OB3TrRg5Wtfyc+Wt/3N+UPTP5HKDuWRh4mvgQ4V/YXTTDzJoqbyaRfU/g4
         4X62RRaldd1PLHng1FMk9hqeFUp1wRgmpSBHUyIw6IPzsTUGagjXfZ8Cgs0j27o26EoK
         gMJk78Yyadlt293hbhJxkkfcTc52rRnQFFTg4uIOXxPWKEwWaUkHsMj85xGgEj9ClouI
         o0yb7WyXyllusV6Vqr9P1ZjrAt+ZGPbTnYPSGcA+cAxrTIkVySVki5oSdzPHe8Vvx9zc
         wpIOfVkqEiNshLx0sN6WRK0P7oK6KUKF35h0u3HjyVZMLQ4WmFC6lJUrANVgoZsPoD/i
         8RcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735254470; x=1735859270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRomBso2hHE7YrImWq0wbVcT1dst09ldMkIN2FASxJ0=;
        b=ApHGgX2Lv+l1/vMM4Jx9s11vWx9t18vg/WU2Uh4uog3ZokmP8XoE8pJCTcDRcl1Gl2
         Fov+Q3aZaFiOz46T8mdfLEp1n21N7PsU5EwUObOMq1Xfiod8Z6wVyViZIHMixHIQMgCr
         cz8Uxm6ztBz2DFWdxZn6kdwYSZKCgMwRjWtyog/yQkSDn9XVgtmd/ODIzkLNpCAHs6iQ
         gwaMqyEJDJnNeUOWGrNlKCbtp2g7aEO4FPiNhVjHutHiQ79vjaP7I5hd1M4dO5kSBliF
         CoLz4Y0UBB/in0YUHgy96iAXaKrMZaHMu7o7sZYJh8lZoEOHjgud8GQ5vFPX4zn7bjbw
         evrA==
X-Forwarded-Encrypted: i=1; AJvYcCWMTvmQubuHIdiGBDxI89QbL4sWB7bR4rLeQVEa4DDJARzSmbFIgczjwsDWdU06tiQdvnzsZ1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxooVdsWYk/SFDIgw9f8358Lj/aenxoLqH8T7xYrV7U+khKyqaZ
	bQu84mEXsd0L97weBDsQxCSXvQA/qUWYNde2Z0VctdGZLL1U58vRCL5TYcoq7E3wSPgnfMbbIRv
	O3D8r4UKhO5Hq7Oe+bhZK/Eafq3Ta7ImbJGhY
X-Gm-Gg: ASbGnctsHnOObty9qUBxuuCmqROpiM/ZWiPCieF0jkgbmNW9CDtVmTXD6WH8G2QrZ3r
	Nespi60DWCh441fgbLaJeyBzx/hXugml8LSJAug==
X-Google-Smtp-Source: AGHT+IFhjdoMUGCzHBQmzdGdz4JrsyT+H2pqbPiCnL0Gl+iLY8mS0CNjTft2xGk+ZwISn3BwzOAc38wfaZi5URoujxU=
X-Received: by 2002:ac8:7f82:0:b0:466:8e4d:e981 with SMTP id
 d75a77b69052e-46a4bfc6904mr18862911cf.3.1735254470272; Thu, 26 Dec 2024
 15:07:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226211639.1357704-1-surenb@google.com> <20241226211639.1357704-2-surenb@google.com>
 <20241226150127.73d1b2a08cf31dac1a900c1e@linux-foundation.org>
In-Reply-To: <20241226150127.73d1b2a08cf31dac1a900c1e@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 26 Dec 2024 15:07:39 -0800
Message-ID: <CAJuCfpFSYqQ1LN0OZQT+jU=vLXZa5-L2Agdk1gzMdk9J0Zb-vg@mail.gmail.com>
Subject: Re: [PATCH 2/2] alloc_tag: skip pgalloc_tag_swap if profiling is disabled
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kent.overstreet@linux.dev, yuzhao@google.com, 00107082@163.com, 
	quic_zhenhuah@quicinc.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2024 at 3:01=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 26 Dec 2024 13:16:39 -0800 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > When memory allocation profiling is disabled, there is no need to swap
> > allocation tags during migration. Skip it to avoid unnecessary overhead=
.
> >
> > Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable@vger.kernel.org
>
> Are these changes worth backporting?  Some indication of how much
> difference the patches make would help people understand why we're
> proposing a backport.

The first patch ("alloc_tag: avoid current->alloc_tag manipulations
when profiling is disabled") I think is worth backporting. It
eliminates about half of the regression for slab allocations when
profiling is disabled. The second one I couldn't really measure, so I
think it's not as important. Thanks!

>


Return-Path: <stable+bounces-87607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 657C59A70B7
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 19:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0940B2177F
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978DF1C330C;
	Mon, 21 Oct 2024 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KcIHQIRo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9102C1CBE89
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530747; cv=none; b=a9AGK5Hmuw/xVV4xBYVOjDAXFrxGlrIrpj2muDkcIcLwsC2JWWGoYA4TgQ6WV7Bgh6FYS3SuhRMdLiPupaF6Zz0C5khVTD9R5pYFMwPrWx+koGEIXuNTnK95o6PcPP/rA818oBgFenWq3sRunkVGJ4UovXOmOws4Sdho8t9JH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530747; c=relaxed/simple;
	bh=SCTFdrbfUBXrIcqhRwUXd+X5Tdul2fIzg9oC8CWTHCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQe6jUGadP8O/5vLsT+JZz582T+05EQOVaiM1qGwVPvMLWx9qCRljmChcBmueekq6PPhTQG0XGacr3I7LcI2frXv0vUgrq7VIo3tH5fKPHQANSnpO5AFP4+4ygWAWkOtp3aISE/VZpVDTyvAnlFADjfclX5f61thww4aE+niW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KcIHQIRo; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4608dddaa35so18641cf.0
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 10:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729530744; x=1730135544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwNJFQj9wVXQQyM3LpHrEo68BHNeskwH6JzAGyjqzms=;
        b=KcIHQIRoNDc3GBWm+IbXN4QSgBVCxSMERdMkT002wAgOF/roCTIe0vOus7MyyeuqLC
         H4Pn1r6TvXKZ0eGnNYRxP1txiB8bnsmQNXYd6Y4P9iqy+oOt/Sl1kro62/bAiYAKO/LP
         gnTr3xa6IKekdB5GtqiUyyvykjO2vydIaH/Z4iT/nZ88LGW4b7qtgZ7/TaiumXiUoSoA
         TKaOsCkn6ogXvKNtXNtjDtwUJ3ODfUgPigke689JS9YopbqWqdJxsSELTCHy3KgH9raM
         oKEj904K6LlwS5PCFG7Ty2WgHXMfAhH7UsI7jGcKaCU0KBFevHFU+lAeZXXGli8v2KTF
         gVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530744; x=1730135544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwNJFQj9wVXQQyM3LpHrEo68BHNeskwH6JzAGyjqzms=;
        b=RMNK5fWGNGz82+JlsReTjb9PddBbLLt/CsK6nw3XqyNEOFfj/Pci+bAgLsQFONKK9k
         /f13dqIdVoHjRvNDENsl5/YBsRZLHDILfKFfMp3tBvjzCIIZiXulYG/MTBC+2vbnTi8W
         nVxfVEjwvH6fgv3/BPx4gcbtlmSAlhUrjEB52J9JeTcIqt5/UVytOM0ZmjdeT5jNlyXV
         YSu4ox0l6iq4NDS6opxp2oC7rb0bug5U+AZCY/wSYZGIsvZenqtKBNY3PVbuVde+y1BG
         5VsGvartYcgblu1/y4o4NQ8o273lDsuDfZHgZYXe7YSTW1sFk0L2Bu+AGD0RYYJSQpbI
         IRVg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0x3Q67UX5hepjgx2PAYhpfxIodesQtn77u4EWVv1AbTcMTjS5qZckmhazBmPBrLNWZUYszw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gi9cSx78109msHsMPaupadHGIvJMQRxOj2ttxDC2Jf2oGq/u
	DQ3Z677FnETVXV+EV4mfyjO3taWyGW/k9zPvdglNzrPu70DMbmdsLYFpGr86DxLMVAGNHco77x2
	OC1FzLPujuT5QfFuic6+uGlgPz9QJQSVqm86zV7yJhqTUggwhI1b+
X-Google-Smtp-Source: AGHT+IEX1w5oqvDfujpUByKRchWeThxcAKNpbwDI3AtAJ2PzyzefCjV0Et+8rfWN9SPjgyE6zHw/nVLVcU2oYC5446c=
X-Received: by 2002:a05:622a:5b97:b0:460:371b:bfd9 with SMTP id
 d75a77b69052e-460be4194femr5020471cf.5.1729530744180; Mon, 21 Oct 2024
 10:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021102259.324175287@linuxfoundation.org> <20241021102300.282974151@linuxfoundation.org>
 <a4163f51-cc1a-0848-d0fd-e9b94dafc306@candelatech.com> <ZxZ_uX0e1iEKZMk5@pc636>
 <2024102130-tweet-wheat-0e55@gregkh> <fb0cd50e-5525-4521-aa1d-f919ae19f77d@suse.cz>
 <CAJuCfpFU1tLc_wvAGu1T3WximLFRARVxBtJTm0bOfgqt_MnYyA@mail.gmail.com>
In-Reply-To: <CAJuCfpFU1tLc_wvAGu1T3WximLFRARVxBtJTm0bOfgqt_MnYyA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 21 Oct 2024 10:12:13 -0700
Message-ID: <CAJuCfpFzgYvCTOWNDq55tG+xPVdJ5Rc2DjH6Ltzrc7--U4Kv5Q@mail.gmail.com>
Subject: Re: [PATCH 6.11 024/135] lib: alloc_tag_module_unload must wait for
 pending kfree_rcu calls
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Ben Greear <greearb@candelatech.com>, stable@vger.kernel.org, patches@lists.linux.dev, 
	Florian Westphal <fw@strlen.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:06=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Mon, Oct 21, 2024 at 10:04=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz>=
 wrote:
> >
> > On 10/21/24 18:57, Greg Kroah-Hartman wrote:
> > > On Mon, Oct 21, 2024 at 06:22:17PM +0200, Uladzislau Rezki wrote:
> > >> On Mon, Oct 21, 2024 at 09:16:43AM -0700, Ben Greear wrote:
> > >> > On 10/21/24 03:23, Greg Kroah-Hartman wrote:
> > >> > > 6.11-stable review patch.  If anyone has any objections, please =
let me know.
> > >> >
> > >> > This won't compile in my 6.11 tree (as of last week), I think it n=
eeds more
> > >> > upstream patches and/or a different work-around.
> > >> >
> > >> > Possibly that has already been backported into 6.11 stable and I j=
ust haven't
> > >> > seen it yet.
> > >> >
> > >> Right. The kvfree_rcu_barrier() will appear starting from 6.12 kerne=
l.
> > >
> > > Ick, how is it building on all of my tests?  What config option am I
> > > missing?
> >
> > Most likely CONFIG_MEM_ALLOC_PROFILING
> > Depends on: PROC_FS [=3Dy] && !DEBUG_FORCE_WEAK_PER_CPU [=3Dn]
>
> Yes, it's disabled by default.

6.11 backports including prerequisite patch are posted at
https://lore.kernel.org/all/20241021171003.2907935-1-surenb@google.com/

>
> >


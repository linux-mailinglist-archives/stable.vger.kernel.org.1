Return-Path: <stable+bounces-87603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D129A7097
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 19:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6BF281C2B
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7551CBE89;
	Mon, 21 Oct 2024 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZJFBp6S"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412CB47A73
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530393; cv=none; b=d3Ps/GCkxyET0zQH0XEUnLg2q4mSCJcfEscj9pfNNsCthsskp5x30V4q43AljHq5JVWLmbBlt797fSEyM/KHaHrehJiLDtpgaiBtHa/a0CiXyagO/zfTziFOZ0m55zccVZfPlHXABxYIP0qelaBSnLuF+N2RpFvznmjlIp+udAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530393; c=relaxed/simple;
	bh=X5kmd610FEscRrunhJz3c1ni6ltsuNEVDD2UBNJXJmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTp/rA9uzpOBdDICZidII8rOCZfQqumxoA96hDCdC9x/P9SC3bGBJjaBHzFrLIUFHN306FvZinpgrFNxynzNg/d9dgEUFXM8ytfnv6cfYwgsEpG9gMvcbBB+ago1WmM9HehAMVygTg4tPt1KrtgXCYHi/1ojE6DPeZteecPnjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZJFBp6S; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460969c49f2so16961cf.0
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729530390; x=1730135190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AJQaP6lejXxoDFr/L47fXxDRsNjBuRBiU93WXWAkCw=;
        b=TZJFBp6SG8boErWBnvyfQmEQSgo4KPnNE0aEjXIcLyKjRf+eyrHGq7SIXip0Dznahg
         Ui1Xut0KojnFufA3ISvf1j1Aa4BTw7IoPu7wQzAQlOlls+T5row0RcCeL/DkBCZXGpvQ
         06aUtVu1matVKXa97AYBLMY3K0JWhK1oksUvKLejDjK2uo7KfRkSv+6uyBsnlKvXKgCl
         HroLI5qZz5nccIwPVmDRBjRotkQ3PA60fgrxszlpE+0joTRSyYEUQvwI2H37HfvIi6aj
         ZPZ+kL6qKWmhpET3hMe5eyjtLSK6Jaemm7K3VP/13qeo4RvUogFEq7I6AcxN5R6zFQ2U
         XZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530390; x=1730135190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AJQaP6lejXxoDFr/L47fXxDRsNjBuRBiU93WXWAkCw=;
        b=O9LMJol0hnkmhZeM+gNRDK7ulllrpul+4yFY8RHFl0Q1H7WWAjJ07z9M2jk4YA+q6M
         p9bZ4jrrxTBWIO/8cFWEugrCTd9gtV4haZijD46kpg+clpuikJ6xsKNAwXpszJ/q3lSl
         kJhH37NZpmkN4hOYAAsgEZw5C/1+Q+OeogS5Dm4T9pALFirmZy05VyZhlSpLKjscQUD1
         kBPRkGEVOHcrPOeM8EHBS9wd7iBcl/aLPSXkCcrME7c3+KGQS9X/9VDzbHxswJwxc1/a
         gyVPCJd2Djzt6L4fT1S2cyCCaZmH5dRHCHeq3jHOhsT22LsKWFrCr55y1rFgMH4jjhlS
         bfjw==
X-Forwarded-Encrypted: i=1; AJvYcCXw4DEoV2D/vzrp05fYM06zSUfkFbFqb9zW/dNwPhqVuXgoTN0JzuUX5RTHBvN7VovdKr6y/N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKpVsFzCRdAu0NJMerJekZQoJJGdxvFxUqCzBcUGe/xnFF4WB0
	ObiZyfAmCOG61964n6/l7+pJLN+DuY4Vmobf0RK7VX3wt5t/qsEMkA15Ke5X8kX1qvV9ZNt6DI/
	lud5g19JI9tNQkRcGTtAbAYBP8et3nzrAT5AQes0t3ZT0m8TkSg==
X-Google-Smtp-Source: AGHT+IG8C7uzJEQzdBvBjvlkO06dxz2dTbSsoDNYgZ/WJwAsrG+FF6lsUc4oj6IFs5BLoTA9zzkhRN/kvRDwTgBvzRg=
X-Received: by 2002:a05:622a:5b90:b0:45f:924:6bcd with SMTP id
 d75a77b69052e-460bc6abc5amr5210591cf.22.1729530389600; Mon, 21 Oct 2024
 10:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021102259.324175287@linuxfoundation.org> <20241021102300.282974151@linuxfoundation.org>
 <a4163f51-cc1a-0848-d0fd-e9b94dafc306@candelatech.com> <ZxZ_uX0e1iEKZMk5@pc636>
 <2024102130-tweet-wheat-0e55@gregkh> <fb0cd50e-5525-4521-aa1d-f919ae19f77d@suse.cz>
In-Reply-To: <fb0cd50e-5525-4521-aa1d-f919ae19f77d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 21 Oct 2024 10:06:18 -0700
Message-ID: <CAJuCfpFU1tLc_wvAGu1T3WximLFRARVxBtJTm0bOfgqt_MnYyA@mail.gmail.com>
Subject: Re: [PATCH 6.11 024/135] lib: alloc_tag_module_unload must wait for
 pending kfree_rcu calls
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Ben Greear <greearb@candelatech.com>, stable@vger.kernel.org, patches@lists.linux.dev, 
	Florian Westphal <fw@strlen.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:04=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 10/21/24 18:57, Greg Kroah-Hartman wrote:
> > On Mon, Oct 21, 2024 at 06:22:17PM +0200, Uladzislau Rezki wrote:
> >> On Mon, Oct 21, 2024 at 09:16:43AM -0700, Ben Greear wrote:
> >> > On 10/21/24 03:23, Greg Kroah-Hartman wrote:
> >> > > 6.11-stable review patch.  If anyone has any objections, please le=
t me know.
> >> >
> >> > This won't compile in my 6.11 tree (as of last week), I think it nee=
ds more
> >> > upstream patches and/or a different work-around.
> >> >
> >> > Possibly that has already been backported into 6.11 stable and I jus=
t haven't
> >> > seen it yet.
> >> >
> >> Right. The kvfree_rcu_barrier() will appear starting from 6.12 kernel.
> >
> > Ick, how is it building on all of my tests?  What config option am I
> > missing?
>
> Most likely CONFIG_MEM_ALLOC_PROFILING
> Depends on: PROC_FS [=3Dy] && !DEBUG_FORCE_WEAK_PER_CPU [=3Dn]

Yes, it's disabled by default.

>


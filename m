Return-Path: <stable+bounces-106219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0A39FD695
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 18:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5EB163F0E
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 17:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B751B1F868E;
	Fri, 27 Dec 2024 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPqxYuAS"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED32C1F8671
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735320530; cv=none; b=fxoXN91mGuXcla04Rpst8vFbwqgmOmJK9RkwnCsbL5vzwx5BCfvZclfeVIW3iGwf4N2VDJe2cvx7BrBd0V7ZKqdrxV4Y0vFqIYCaBxRJC/PuNmR95GQyzFTWiWC2LOHcxCtUHAVAahGf6pBGXlGoqzShfxpxYRtl3p54r2GsaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735320530; c=relaxed/simple;
	bh=ULTUSzRAGz20FulS7nvF9ST3it3WDhDXbGp7XX88+SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eF8ufOx0l4wPn9ryD/QA/wjnPPBgPwLFqXvekHTE5veoHWb6SFBqJkqCtF/6YKBl3GcXJigSVP2EyvUj/OJEACN1rgd4roUrSpMejN8xJ0fhRuKnzXZ+pH87xWLcJrXUMY/5tGgHvtcQoiTMqaUBoRKMY9q5dLBHmMLl+PxG8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPqxYuAS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467abce2ef9so1980811cf.0
        for <stable@vger.kernel.org>; Fri, 27 Dec 2024 09:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735320528; x=1735925328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpCKjMyoJFbHMCmkJCoptr+HQTE/8N0QQxukHE9I6Ro=;
        b=tPqxYuASPmLak0G7GVzi0xbdEXbYUzxEKuEk6z+BgyoMzSDrlDYhX02miKZQBDKD47
         WPaJb6qc4nUqiD0Vk8ehyXbvMaPWtho8cUg5ciWfSbcYeBaWST4i+4+8fZ/p7USLfcwM
         L1ugb2S3kBm+S0zVuA8hwr7nLCZlxxxb9Jp6hcS94R4Mtxr9qei4XMqKcNUIjPO2q1Op
         57kW0u/L3yEE22yoY7DgyWJmarRxRMh93DpKmkSie2OuPEyUMBQP5gTZQbw6Qm6D/c8G
         3b4ptP0uxk31VZHr0AfB6xrDXz5QyJVQUqy0zivEbadVbmOEcH5uQBF2NK6MVjknpAb6
         JaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735320528; x=1735925328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpCKjMyoJFbHMCmkJCoptr+HQTE/8N0QQxukHE9I6Ro=;
        b=Q2AEHpkj1LXO/OQXm2h13baXKEXNf6P4TBz6TbK1h4eul+/tVVKLtgsDFjz1e3CCwI
         +gkzBjssMUJ/P/d1jrKv8eSJ3bMOsHTyv7gn+6HdkbqNdxnhGpKv4aWkietNNFacm4MN
         h1l76YnYeA7U+cqlrjjDFq4FEZDOJ75pOVCqg31LS/+kqpL+aBOLu0jEPPXdsocDMybx
         lRyRqyuk/J5a0vua5AesDd5Ci6silGskTYM1A64tGob+fXwn/C4fjQYu9MOhCLkMSmEX
         tT2/Uu5l2Ve9bm5+GdQ3wMsSbBWeTTEE9xnARTGk09BlACJ/EpEm0TsOilFvYJ8PNb2w
         rXmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0drsqIjmJ9den9IragNWPAYszn4JmC3LOlT7y/hkYEetNMsmHliv3Ll3JuA4ei8uu3dHFvbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqThZZ/b/uFyJniWiBhz+6TCl8tATPlJDGZadmCQDuBiF3BY32
	7TeVSJg0FksatGhuUIHLPFPIxShBORgjk6oelA0c/HZ9RdYVF+snFTjyZU5PIL4wlD25x2wR/oO
	NuSumGuZbPInVcJgsV4kY45bqI+kKlu8GZHvX
X-Gm-Gg: ASbGncuKhT4nh2UsglpcPjq0n5BjB0EycbYTrP4ipTOHATs43LVoCO3KJRXseyPTAI1
	blHAkm+v8/a0IbmuNexc2YlPIroGEt/mK5n9pbw==
X-Google-Smtp-Source: AGHT+IHXJ9qnlcknbZgTfwfnqxYMBtpCb6XoucoAKBV2CWfPidzPtEvqga3s4/HDaXdYSAmQ3MqzuRVNN/1m3MYP72c=
X-Received: by 2002:a05:622a:18a8:b0:463:6fc7:e7cb with SMTP id
 d75a77b69052e-46a4c00f1ddmr20923011cf.11.1735320527675; Fri, 27 Dec 2024
 09:28:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226211639.1357704-1-surenb@google.com> <20241226211639.1357704-2-surenb@google.com>
 <20241226150127.73d1b2a08cf31dac1a900c1e@linux-foundation.org>
 <CAJuCfpFSYqQ1LN0OZQT+jU=vLXZa5-L2Agdk1gzMdk9J0Zb-vg@mail.gmail.com>
 <20241226162315.cbf088cb28fe897bfe1b075b@linux-foundation.org>
 <CAJuCfpG_cbwFSdL5mt0_M_t0Ejc_P3TA+QGxZvHMAK1P+z7_BA@mail.gmail.com> <20241226235900.5a4e3ab79840e08482380976@linux-foundation.org>
In-Reply-To: <20241226235900.5a4e3ab79840e08482380976@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 27 Dec 2024 09:28:36 -0800
Message-ID: <CAJuCfpHJ7D0oLfHYzb9jvktP4X6O=ySGe7CK7sZmVNpSnzDeiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] alloc_tag: skip pgalloc_tag_swap if profiling is disabled
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kent.overstreet@linux.dev, yuzhao@google.com, 00107082@163.com, 
	quic_zhenhuah@quicinc.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2024 at 11:59=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 26 Dec 2024 16:56:00 -0800 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > On Thu, Dec 26, 2024 at 4:23=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Thu, 26 Dec 2024 15:07:39 -0800 Suren Baghdasaryan <surenb@google.=
com> wrote:
> > >
> > > > On Thu, Dec 26, 2024 at 3:01=E2=80=AFPM Andrew Morton <akpm@linux-f=
oundation.org> wrote:
> > > > >
> > > > > On Thu, 26 Dec 2024 13:16:39 -0800 Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > > >
> > > > > > When memory allocation profiling is disabled, there is no need =
to swap
> > > > > > allocation tags during migration. Skip it to avoid unnecessary =
overhead.
> > > > > >
> > > > > > Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
> > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > Cc: stable@vger.kernel.org
> > > > >
> > > > > Are these changes worth backporting?  Some indication of how much
> > > > > difference the patches make would help people understand why we'r=
e
> > > > > proposing a backport.
> > > >
> > > > The first patch ("alloc_tag: avoid current->alloc_tag manipulations
> > > > when profiling is disabled") I think is worth backporting. It
> > > > eliminates about half of the regression for slab allocations when
> > > > profiling is disabled.
> > >
> > > um, what regression?  The changelog makes no mention of this.  Please
> > > send along a suitable Reported-by: and Closes: and a summary of the
> > > benefits so that people can actually see what this patch does, and wh=
y.
> >
> > Sorry, I should have used "overhead" instead of "regression".
> > When one sets CONFIG_MEM_ALLOC_PROFILING=3Dy, the code gets instrumente=
d
> > and even if profiling is turned off, it still has a small performance
> > cost minimized by the use of mem_alloc_profiling_key static key. I
> > found a couple of places which were not protected with
> > mem_alloc_profiling_key, which means that even when profiling is
> > turned off, the code is still executed. Once I added these checks, the
> > overhead of the mode when memory profiling is enabled but turned off
> > went down by about 50%.
>
> Well, a 50% reduction in a 0.0000000001% overhead ain't much.

I wish the overhead was that low :)

I ran more comprehensive testing on Pixel 6 on Big, Medium and Little cores=
:

                 Overhead before fixes            Overhead after fixes
                 slab alloc      page alloc          slab alloc      page a=
lloc
Big               6.21%           5.32%                3.31%          4.93%
Medium       4.51%           5.05%                3.79%          4.39%
Little            7.62%           1.82%                6.68%          1.02%


> But I
> added the final sentence to the changelog.
>
> It still doesn't tell us the very simple thing which we're all eager to
> know: how much faster did the kernel get??


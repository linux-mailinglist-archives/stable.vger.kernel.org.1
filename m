Return-Path: <stable+bounces-65350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA1694702F
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 19:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CA02813E5
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0012513A265;
	Sun,  4 Aug 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFHLgijJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CEE137750
	for <stable@vger.kernel.org>; Sun,  4 Aug 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793926; cv=none; b=g4UMYCgu+DB2Lp0r0WIoATGaMbJ2iVlP8t2zC8/ERQMEkMP/On1MCd7ttn+mYaRiv9xfA+xT1HyzhRaPSiqmmqaEDJVw3scQjxntwAxevOqYueNjh3JR/H3WczRVbEQJY9XkY3mFzH7vjCAKtPSQvl5/c3uVcwgHaJZ5CJx7MJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793926; c=relaxed/simple;
	bh=M6rWXZf52qIB+Mm9mbU8jueBVd1OR1uH8vfQMN8Q+3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li4G4+M5OSC3Dj3ZE2AIpLPtV67Thg/AJ/BFEKzqtuxHnGF1apPwd2BHuI/cdKA81vSlxkCsqATmhMMhqo2cM7Jd7liej0PTRl2WoGmp+ODC/x48/xw2SZErxzr4q6vQi2PdOPuuMw0rQLUXYGloTU4GltppSD0JHg0Xcfi3Okk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFHLgijJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35284C4AF0F
	for <stable@vger.kernel.org>; Sun,  4 Aug 2024 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722793926;
	bh=M6rWXZf52qIB+Mm9mbU8jueBVd1OR1uH8vfQMN8Q+3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QFHLgijJf+7B9dQqaPB8dB3AAoCQB4Q2G40f9FBIpUxyK8sXyy77KnL9+eSb6ierd
	 fIvvEs7ah+GIHGSBMYer6SjPCAdTWIg/DR22exrMQ0wyKEqhQdd5jYuCmV5UNjA11S
	 hdOxRKd4jg3V3C1++DaoLm5PudzlKle8wOHpz3KLIxe818uI4qNTv+rm5m04IoRtU3
	 wOEjyus4D9utMs3RLSPxG4VXaV2OHQZhXWm6XJ9sAcltcqV7hnNbOvQiXBZS7PTIp5
	 /qK1ZP2FOGk/enyaSvKINEqLicx1cN4IgWvU7RRc90XuriT+hA4mOYIzIUUPtGu2j4
	 rgdzAYn4WY4/Q==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-690af536546so7650687b3.3
        for <stable@vger.kernel.org>; Sun, 04 Aug 2024 10:52:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXauk2DAP28r+AlhW8j0WoRUjfzpgbkIdLT+2IEwjJv3zdDIRmdHacmPHCMpos/5Ry9nzhPJRrfNNXJ7yVkPQi/ltxib2CU
X-Gm-Message-State: AOJu0YxD2M4qfYJORs54CiZmrxL/hrAK4muMLhLngnSPgCfHlIIvnYlr
	sDRcXY1h+D8yRggFd1pBKuTxE8Naat0HRo7Naw4Isn/v7u+EzjdPANgl0lP+z7570Y7cxyqb2x+
	HAInQq6F+BihQxnV/whl/V8slfkYFwad3a0hQuQ==
X-Google-Smtp-Source: AGHT+IG8rqmKvFu0oePREvl9xWibUHtyMYHj/OiX5IKUkVz8roXdJrHtnmfFBi0m7m9mKhYS4OWM5/Hm8dUGnRVO1og=
X-Received: by 2002:a81:c242:0:b0:65f:dfd9:b672 with SMTP id
 00721157ae682-6895f9e5cdamr102427917b3.11.1722793925477; Sun, 04 Aug 2024
 10:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1719038884-1903-1-git-send-email-yangge1116@126.com>
 <CAF8kJuNP5iTj2p07QgHSGOJsiUfYpJ2f4R1Q5-3BN9JiD9W_KA@mail.gmail.com>
 <0f9f7a2e-23c3-43fe-b5c1-dab3a7b31c2d@126.com> <CACePvbXU8K4wxECroEPr5T3iAsG6cCDLa12WmrvEBMskcNmOuQ@mail.gmail.com>
 <b5f5b215-fdf2-4287-96a9-230a87662194@126.com> <CACePvbV4L-gRN9UKKuUnksfVJjOTq_5Sti2-e=pb_w51kucLKQ@mail.gmail.com>
 <00a27e2b-0fc2-4980-bc4e-b383f15d3ad9@126.com> <CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZUmErNAXoXmw@mail.gmail.com>
 <CAMgjq7CLObfnEcPgrPSHtRw0RtTXLjiS=wjGnOT+xv1BhdCRHg@mail.gmail.com> <CAMgjq7DLGczt=_yWNe-CY=U8rW+RBrx+9VVi4AJU3HYr-BdLnQ@mail.gmail.com>
In-Reply-To: <CAMgjq7DLGczt=_yWNe-CY=U8rW+RBrx+9VVi4AJU3HYr-BdLnQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 4 Aug 2024 10:51:54 -0700
X-Gmail-Original-Message-ID: <CACePvbXJKskfo-bd5jr2GfagaFDoYz__dbQTKmq2=rqOpJzqYQ@mail.gmail.com>
Message-ID: <CACePvbXJKskfo-bd5jr2GfagaFDoYz__dbQTKmq2=rqOpJzqYQ@mail.gmail.com>
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: Kairui Song <ryncsn@gmail.com>
Cc: Ge Yang <yangge1116@126.com>, Yu Zhao <yuzhao@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
	Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>, baolin.wang@linux.alibaba.com, 
	liuzixing@hygon.cn, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 5:22=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> > Hi Yu, I tested your patch, on my system, the OOM still exists (96
> > core and 256G RAM), test memcg is limited to 512M and 32 thread ().
> >
> > And I found the OOM seems irrelevant to either your patch or Ge's
> > patch. (it may changed the OOM chance slight though)
> >
> > After the very quick OOM (it failed to untar the linux source code),
> > checking lru_gen_full:
> > memcg    47 /build-kernel-tmpfs
> >  node     0
> >         442       1691      29405           0
> >                      0          0r          0e          0p         57r
> >        617e          0p
> >                      1          0r          0e          0p          0r
> >          4e          0p
> >                      2          0r          0e          0p          0r
> >          0e          0p
> >                      3          0r          0e          0p          0r
> >          0e          0p
> >                                 0           0           0           0
> >          0           0
> >         443       1683      57748         832
> >                      0          0           0           0           0
> >          0           0
> >                      1          0           0           0           0
> >          0           0
> >                      2          0           0           0           0
> >          0           0
> >                      3          0           0           0           0
> >          0           0
> >                                 0           0           0           0
> >          0           0
> >         444       1670      30207         133
> >                      0          0           0           0           0
> >          0           0
> >                      1          0           0           0           0
> >          0           0
> >                      2          0           0           0           0
> >          0           0
> >                      3          0           0           0           0
> >          0           0
> >                                 0           0           0           0
> >          0           0
> >         445       1662          0           0
> >                      0          0R         34T          0          57R
> >        238T          0
> >                      1          0R          0T          0           0R
> >          0T          0
> >                      2          0R          0T          0           0R
> >          0T          0
> >                      3          0R          0T          0           0R
> >         81T          0
> >                             13807L        324O        867Y       2538N
> >         63F         18A
> >
> > If I repeat the test many times, it may succeed by chance, but the
> > untar process is very slow and generates about 7000 generations.
> >
> > But if I change the untar cmdline to:
> > python -c "import sys; sys.stdout.buffer.write(open('$linux_src',
> > mode=3D'rb').read())" | tar zx
> >
> > Then the problem is gone, it can untar the file successfully and very f=
ast.
> >
> > This might be a different issue reported by Chris, I'm not sure.
>
> After more testing, I think these are two problems (note I changed the
> memcg limit to 600m later so the compile test can run smoothly).
>
> 1. OOM during the untar progress (can be workarounded by the untar
> cmdline I mentioned above).

There are two different issues here.
My recent test script has moved the untar phase out of memcg limit
(mostly I want to multithreading untar) so the bisect I did is only
catch the second one.
The untar issue might not be a regression from this patch.

> 2. OOM during the compile progress (this should be the one Chris encounte=
red).
>
> Both 1 and 2 only exist for MGLRU.
> 1 can be workarounded using the cmdline I mentioned above.
> 2 is caused by Ge's patch, and 1 is not.
>
> I can confirm Yu's patch fixed 2 on my system, but the 1 seems still a
> problem, it's not related to this patch, maybe can be discussed
> elsewhere.

I will do a test run now with Yu's patch and report back.

Chris


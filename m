Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3695B7DDA97
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 02:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345114AbjKAB1j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 21:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345060AbjKAB1j (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 21:27:39 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EB9E8
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 18:27:37 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso4969468276.3
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 18:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698802056; x=1699406856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9F2S85nrQwVjkJXZ1QXNB9unaOxe7JFrDjf8Uexjb0=;
        b=UWNOVY0tN/WrMe1VflYR7aJLDTxrXisZ9WhFmIfpuQ6WCPH/bwFhhLi2vDqIcHI+yp
         U/xEEacnzxY7pS+piUTGvTh62sYupVNHw5clHfOj5Lf6vxoSq+YGDZdfkLtuK0qSr+wc
         bKKvrDCLeu7jBl3jgplBuTZhKD0J131Dk54GEutcmwIOU2TrKHKJJ1IuEfgtaHXQkUg0
         dLlTBIuRjPpisbi0UwOp+Wohz5GyUJwRwb7+vw90pf4AZcm0Or87JYnvay5PR2UI4Miy
         0A72wxTK9K/SYihQW0+Cv5BmkTQ8UnUD5VO+JTecBIZLKBWKXNjQ5UvhnnOjNlneXfkt
         uYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698802056; x=1699406856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9F2S85nrQwVjkJXZ1QXNB9unaOxe7JFrDjf8Uexjb0=;
        b=QEaqUPTqmoa9Dpi3ktUz58P3ggg0+vQ1eq33aQMnr7mYFNqR1E9F9ZZE5asfPHE0q9
         Og/Dq6z+gV/B6eWnLDfZqHIyYPcsngpjeNRNdnPyO8hg1wMWjVUMHCsPiV/gGtd1XHJg
         +7qudH8fW79INxIQrkqTiH/4XrGhV38ljdFSZQ+s7/2ly5jetWEnJH2A7iRwYUj5Rrta
         CASzS9i2/L+8bc+YMoTPelv9f+XqWoB4o0mNPpfUqeyyk7M7EP/laV2aWUg4y18YXMeL
         AZW4krVxLmDWl0FYHEyc5foOpkBD9Q0+i9LFcciEssNdBh3XfcwzQVH3VoUCt7Z4g0LF
         Nfcg==
X-Gm-Message-State: AOJu0Yz43GwiqViRvp9kvPFQZhR5KEhiIcNUGsOW6aV61XpOTq2F43Kf
        USoNfCXCkrunkRIVlHoZ4NN8d0gmwg7rbdaU1d0=
X-Google-Smtp-Source: AGHT+IGE/c64lLcNYlD85SNTuo1FeA7mh/riwGBmUgRjj+nc5k98CezvOKtRYTWCC891QYGix030sHR2YhBq+BrvIh4=
X-Received: by 2002:a25:b318:0:b0:da0:c49a:5fdf with SMTP id
 l24-20020a25b318000000b00da0c49a5fdfmr10745700ybj.7.1698802056126; Tue, 31
 Oct 2023 18:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <3514c87f-c87f-f91f-ca90-1616428f6317@redhat.com>
 <1a47fa28-3968-51df-5b0b-a19c675cc289@suse.cz> <20231030122513.6gds75hxd65gu747@quack3>
 <ZT+wDLwCBRB1O+vB@mail-itl> <a2a8dbf6-d22e-65d0-6fab-b9cdf9ec3320@redhat.com>
 <20231030155603.k3kejytq2e4vnp7z@quack3> <ZT/e/EaBIkJEgevQ@mail-itl>
 <98aefaa9-1ac-a0e4-fb9a-89ded456750@redhat.com> <ZUB5HFeK3eHeI8UH@mail-itl>
 <20231031140136.25bio5wajc5pmdtl@quack3> <ZUEgWA5P8MFbyeBN@mail-itl>
In-Reply-To: <ZUEgWA5P8MFbyeBN@mail-itl>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 1 Nov 2023 09:27:24 +0800
Message-ID: <CACVXFVOEWDyzasS7DWDvLOhC3Hr6qOn5ks3HLX+fbRYCxYv26w@mail.gmail.com>
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
To:     =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Jan Kara <jack@suse.cz>, Mikulas Patocka <mpatocka@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 31, 2023 at 11:42=E2=80=AFPM Marek Marczykowski-G=C3=B3recki
<marmarek@invisiblethingslab.com> wrote:
>
> On Tue, Oct 31, 2023 at 03:01:36PM +0100, Jan Kara wrote:
> > On Tue 31-10-23 04:48:44, Marek Marczykowski-G=C3=B3recki wrote:
> > > Then tried:
> > >  - PAGE_ALLOC_COSTLY_ORDER=3D4, order=3D4 - cannot reproduce,
> > >  - PAGE_ALLOC_COSTLY_ORDER=3D4, order=3D5 - cannot reproduce,
> > >  - PAGE_ALLOC_COSTLY_ORDER=3D4, order=3D6 - freeze rather quickly
> > >
> > > I've retried the PAGE_ALLOC_COSTLY_ORDER=3D4,order=3D5 case several t=
imes
> > > and I can't reproduce the issue there. I'm confused...
> >
> > And this kind of confirms that allocations > PAGE_ALLOC_COSTLY_ORDER
> > causing hangs is most likely just a coincidence. Rather something eithe=
r in
> > the block layer or in the storage driver has problems with handling bio=
s
> > with sufficiently high order pages attached. This is going to be a bit
> > painful to debug I'm afraid. How long does it take for you trigger the
> > hang? I'm asking to get rough estimate how heavy tracing we can afford =
so
> > that we don't overwhelm the system...
>
> Sometimes it freezes just after logging in, but in worst case it takes
> me about 10min of more or less `tar xz` + `dd`.

blk-mq debugfs is usually helpful for hang issue in block layer or
underlying drivers:

(cd /sys/kernel/debug/block && find . -type f -exec grep -aH . {} \;)

BTW,  you can just collect logs of the exact disks if you know what
are behind dm-crypt,
which can be figured out by `lsblk`, and it has to be collected after
the hang is triggered.

Thanks,
Ming Lei

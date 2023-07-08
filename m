Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206AA74BFDA
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 00:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjGHWyE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 8 Jul 2023 18:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGHWyD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 8 Jul 2023 18:54:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0C6E44
        for <stable@vger.kernel.org>; Sat,  8 Jul 2023 15:54:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99342a599e9so406081566b.3
        for <stable@vger.kernel.org>; Sat, 08 Jul 2023 15:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688856839; x=1691448839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMLbgJOTu2WV/nORFtWqoUMvz+jr1XXDxLBzD5NfFBo=;
        b=Sg6Ahf+A9qzcGKQMRKk69F4K9URRCUVpjB5cGLSCNq0mu+WuoJBjyae1Dvr9691OD5
         fjxBdSuRdPH0+STiSjYVNN2SUgB5mGOA/pTMaVa2rrtmYzZJmmUv2DXbkLRKWOA/PSG8
         vHEI/eLkcfL96BlYRAhQgI7eVLFxqdLAhrnfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688856839; x=1691448839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMLbgJOTu2WV/nORFtWqoUMvz+jr1XXDxLBzD5NfFBo=;
        b=POw9r+EK2vlpT+mZE/0nPxIp41WYLUW4YYg+LfFqA4+bIzUIyDBS+9++CTIH0cpL8o
         Ed4hMSV7mcx+NncGX2RjC8heI3MD9IBeo9+2N3fjpor114NRxHJ+P7+fRqv1g7WpCKio
         qIFzlcGuGiKvdh6CuOFN/xaJmnuQFVHCSWB37ZrZDTBebykbkS7V+WJ3hL9Ajpwrj+7o
         /qQVXfyfvk8QzNVd+BrmuDRQZEaYw+PtQj45XcGnAf2iBV7YLrHm6C4+nWNqBgKku4yE
         MSaYiU+xckAnPF4uKCCJ7PAXoi9GVpc3T7eQukRpoBXI6QR5QPMCNkPmTzR6tcC+GIH5
         Oo9Q==
X-Gm-Message-State: ABy/qLZ1f+LdlIxcWwrhqN39MkcXc28LrgSUViXZMg32Dzz8paoy32GQ
        9JVj9URVqvfO02ADGMkRppIzLPcyB09A+DDTBv354NLd
X-Google-Smtp-Source: APBJJlH8LLFyFV0+3k4axx7KryY1suF4g9Jt0n+vwATEmt7HB4xEScBugrRWxCdDKaR1xZqJhKi5wA==
X-Received: by 2002:a17:906:20d7:b0:993:ec0b:1a21 with SMTP id c23-20020a17090620d700b00993ec0b1a21mr2554393ejc.27.1688856839218;
        Sat, 08 Jul 2023 15:53:59 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709065f8d00b0099364d9f0e2sm3976486eju.98.2023.07.08.15.53.57
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 15:53:58 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51e29913c35so4342721a12.0
        for <stable@vger.kernel.org>; Sat, 08 Jul 2023 15:53:57 -0700 (PDT)
X-Received: by 2002:aa7:d383:0:b0:51a:50f2:4e7a with SMTP id
 x3-20020aa7d383000000b0051a50f24e7amr7201378edq.13.1688856837545; Sat, 08 Jul
 2023 15:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
 <CAHk-=whhXFQj0Vwzh7bnjnLs=SSTsxyiY6jeb7ovOGnCes4aWg@mail.gmail.com> <CAJuCfpHuFc1P=Wo6Oy0T0u-H1B_JsbRgqhVJxY7D64ZY1zh7Cg@mail.gmail.com>
In-Reply-To: <CAJuCfpHuFc1P=Wo6Oy0T0u-H1B_JsbRgqhVJxY7D64ZY1zh7Cg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jul 2023 15:53:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9NQdt3-yHRXExdnu-QpUfXsqiSujkSTg6AdGjabPs6g@mail.gmail.com>
Message-ID: <CAHk-=wi9NQdt3-yHRXExdnu-QpUfXsqiSujkSTg6AdGjabPs6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
To:     Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, regressions@leemhuis.info,
        bagasdotme@gmail.com, jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, peterx@redhat.com, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, 8 Jul 2023 at 15:36, Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Sat, Jul 8, 2023 at 2:18=E2=80=AFPM Linus Torvalds
> >
> > Again - maybe I messed up, but it really feels like the missing
> > vma_start_write() was more fundamental, and not some "TLB coherency"
> > issue.
>
> Sounds plausible. I'll try to use the reproducer to verify if that's
> indeed happening here.

I really don't think that's what people are reporting, I was just
trying to make up a completely different case that has nothing to do
with any TLB issues.

My real point was simply this one:

> It's likely there are multiple problematic
> scenarios due to this missing lock though.

Right. That's my issue. I felt your explanation was *too* targeted at
some TLB non-coherency thing, when I think the problem was actually a
much larger "page faults simply must not happen while we're copying
the page tables because data isn't coherent".

The anon_vma case was just meant as another random example of the
other kinds of things I suspect can go wrong, because we're simply not
able to do this whole "copy vma while it's being modified by page
faults".

Now, I agree that the PTE problem is real, and probable the main
thing, ie when we as part of fork() do this:

        /*
         * If it's a COW mapping, write protect it both
         * in the parent and the child
         */
        if (is_cow_mapping(vm_flags) && pte_write(pte)) {
                ptep_set_wrprotect(src_mm, addr, src_pte);
                pte =3D pte_wrprotect(pte);
        }

and the thing that can go wrong before the TLB flush happens is that -
because the TLB's haven't been flushed yet - some threads in the
parent happily continue to write to the page and didn't see the
wrprotect happening.

And then you get into the situation where *some* thread see the page
protections change (maybe they had a TLB flush event on that CPU for
random reasons), and they will take a page fault and do the COW thing
and create a new page.

And all the while *other* threads still see the old writeable TLB
state, and continue to write to the old page.

So now you have a page that gets its data copied *while* somebody is
still writing to it, and the end result is that some write easily gets
lost, and so when that new copy is installed, you see it as data
corruption.

And I agree completely that that is probably the thing that most
people actually saw and reacted to as corruption.

But the reason I didn't like the explanation was that I think this is
just one random example of the more fundamental issue of "we simply
must not take page faults while copying".

Your explanation made me think "stale TLB is the problem", and *that*
was what I objected to. The stale TLB was just one random sign of the
much larger problem.

It might even have been the most common symptom, but I think it was
just a *symptom*, not the *cause* of the problem.

And I must have been bad at explaining that, because David Hildenbrand
also reacted negatively to my change.

So I'll happily take a patch that adds more commentary about this, and
gives several examples of the things that go wrong.

                Linus

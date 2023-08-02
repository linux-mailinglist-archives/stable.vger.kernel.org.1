Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E3376D88A
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 22:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjHBUVq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 16:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHBUVp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 16:21:45 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F17FF
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 13:21:45 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso194773276.1
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691007704; x=1691612504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ua/z6hJjJwaKpWnVce2LKpeE5PhDq5AwoL0z00SOjR4=;
        b=064itWtp3kWfEW186lgdqtOYBw/O5OZE00SLFKDPchRuS5vHGdVAh7rm94pcPhRxvC
         e7Pl2vnoPsz8euehcSnFMXZndkStl2qAUnXOISSVhtP9jgtOx+WtBuUZMQgSKkNVxixo
         hjxRWZNoKBi1HgWiArxXBB2w7dpI/rQnwSCrrtvkkqfTs/5bX9Y91cdRsRPmRQT8P7vn
         LJnF7oklLQQi2Rjs3irE7YFZTi9LSXhV+n+yWc7LvBuhm0EdywbRD6y0yKPyPiO9DsZk
         Pmi2tBPJlcAWyKWDAtijPct3C28V3IYhrOljME2Oaom/rK27cB1Tq0crG9liRCUd/srK
         o7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691007704; x=1691612504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ua/z6hJjJwaKpWnVce2LKpeE5PhDq5AwoL0z00SOjR4=;
        b=ZhL/OoxngII9atKTF2WVNmh2NfErF/WDfA3ONhiD3W7HrxiTYSXe0HEyzZE9wV5Fjg
         yy68lEH6ZgyLFkt4MXBLRxuX2fspNnvujRoQCYS6hc7k02fK5sDpOWoM5k6ZYxt7CX88
         PMxpGpGGAhYb1KWP2aASoUFAK0BapjN2de+blOQyT+FwjWNpQHFNBWtCGai19XUutF+F
         3MVEBvrqXMu7f/QUVJsKcrcMum8QnP+V42mZ4HYKJdNjjetI6V7KBZ3Y7g1m0v30C2ah
         l9l2tbJ3o6g4irvo/uazhBS5Q1dY8PkdMBzdKx5vKVpp137i0sAcWGmoswdk2QNHxB5f
         ph4A==
X-Gm-Message-State: ABy/qLb33AxMu2/17jAma2bWpWvcru9PpU3SDe+7cdWOeQajGtmCCV+x
        bTR1aJEfNUfyx8d2f0a3L62oWH2FS8lNM7mpQMaQ+A==
X-Google-Smtp-Source: APBJJlEewzNilSK9EhWoCm+pHDq+zrz9nrcvOAL6kD//nIyxF94LiWj7YSvP5Zmqsl4NTrqRtDoNukIk3awhpvJrb5s=
X-Received: by 2002:a25:86ca:0:b0:d06:d1ae:dcf2 with SMTP id
 y10-20020a2586ca000000b00d06d1aedcf2mr12816778ybm.13.1691007704032; Wed, 02
 Aug 2023 13:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230801220733.1987762-1-surenb@google.com> <20230801220733.1987762-5-surenb@google.com>
 <CAHk-=wix_+xyyAXf+02Pgt3xEpfKncjT8A6n1Oa+9uKH8bXnEA@mail.gmail.com>
 <CAJuCfpFYq4yyj0=nW0iktoH0dma-eFhw1ni7v9R-fCsYH7eQ3Q@mail.gmail.com> <CAHk-=wjxQpxK_vOpdcCycR2FGrSHLHZk+GVuVHrAv-8X3=XzUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjxQpxK_vOpdcCycR2FGrSHLHZk+GVuVHrAv-8X3=XzUQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 2 Aug 2023 13:21:31 -0700
Message-ID: <CAJuCfpHG+fR5YZ74QmUXQcAKcDWaTNMB4gzddZPKdjBr0=s9dQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] mm: lock vma explicitly before doing
 vm_flags_reset and vm_flags_reset_once
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     akpm@linux-foundation.org, jannh@google.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 2, 2023 at 11:54=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 2 Aug 2023 at 11:09, Suren Baghdasaryan <surenb@google.com> wrote=
:
> >
> > Ok, IOW the vma would be already locked before mmap() is called...
>
> Yup.
>
> > Just to confirm, you are suggesting to remove vma_start_write() call
> > from hfi1_file_mmap() and let vm_flags_reset() generate an assertion
> > if it's ever called with an unlocked vma, correct?
>
> Correct.

Got it. Will update in the next version. Thanks!

>
>                Linus
>

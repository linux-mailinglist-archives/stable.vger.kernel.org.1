Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3957F76D692
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 20:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjHBSKW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 14:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbjHBSKN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 14:10:13 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2BA30C7
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 11:09:51 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d2b8437d825so73340276.3
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690999790; x=1691604590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iib+Xd2im+vZ2DqX3HEGdgepyyImF3VT4ZisE2yj1ys=;
        b=oRtOtKDjkVBCb38qf+mS/3skawfAATDJfzXhOCYonPmwyEJ3aDUUHtY12ZPrkfSxrU
         QHKxlfUXoXekdHWtSbFd2kfposrCnzV6kIJtsRFB7HpejPYEfn5dXGzS679fnY6sz8ax
         Qcuy0veEvBzAAoNnZSIvAOb93CMlVa/DfdRVftzkvAJC7mCTgs6xKHPfHV9elwBsUuS0
         oaF4pXYDYZoxVxgkM90NZMCuvK0Sv3/m/d5UIoAnXglUS9MNI6Z4cihQwLH3Ptz7uDbs
         jS4rqCLwdg8CA89xgDoFxv7IuGDC3Szd7oGret51d/nJFO60hJPIt1BHXTVRXybMODVQ
         d1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999790; x=1691604590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iib+Xd2im+vZ2DqX3HEGdgepyyImF3VT4ZisE2yj1ys=;
        b=Ty/IA0AvOydBinh/l4MmycoHMtQwKdarMznv/IUY4D4808nc/2/Pc6swvXnnfoL4Fr
         +b2NBAY5xVieVVTCbODlIHgdaW7XFYUgHQQAR4LW/toSnPb96EmQ7JtwU6szwWNdMzRD
         tVVTy9FS2zSWwjdQqomyANZkDRjCnaVvEPehrk2QoHSy14FfZhWvDOEh1r1KgsbZVWdR
         0h/3RZM+G9q2ZWo1LxdmQI6mvwoztEYJ0zWISlbJyt67kz5/WOnGL1ONWTP+WO2yWxmH
         Cch2r5WQYlcUM4CRI6TS84IrkQFm9fcpqURDy0m1rp/w5Nmg9UlMVgHf7o/RlCvvfrnk
         mnQg==
X-Gm-Message-State: AOJu0YyPQMbHOZ54vDAbinYLiZA5fcH+Bvs8UOmsIZcyO2ib/F8Ho7mW
        SgGGshq5TL5zb/NRnIVCBLQ6GKFqA0vhKflSNn4gxA==
X-Google-Smtp-Source: AGHT+IEUC0dFG99W++f2WyMIi43qQ5eyHn34lPHwz5XXFxFSHJUXCaft8RZj3ShW9s9RbqGok9vSU7ZZRNdeAF3VH8g=
X-Received: by 2002:a05:6902:100f:b0:d3c:e4aa:4985 with SMTP id
 w15-20020a056902100f00b00d3ce4aa4985mr2109823ybt.61.1690999790140; Wed, 02
 Aug 2023 11:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230801220733.1987762-1-surenb@google.com> <20230801220733.1987762-5-surenb@google.com>
 <CAHk-=wix_+xyyAXf+02Pgt3xEpfKncjT8A6n1Oa+9uKH8bXnEA@mail.gmail.com>
In-Reply-To: <CAHk-=wix_+xyyAXf+02Pgt3xEpfKncjT8A6n1Oa+9uKH8bXnEA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 2 Aug 2023 11:09:37 -0700
Message-ID: <CAJuCfpFYq4yyj0=nW0iktoH0dma-eFhw1ni7v9R-fCsYH7eQ3Q@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 2, 2023 at 10:49=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 1 Aug 2023 at 15:07, Suren Baghdasaryan <surenb@google.com> wrote=
:
> >
> >       To make locking more visible, change these
> > functions to assert that the vma write lock is taken and explicitly loc=
k
> > the vma beforehand.
>
> So I obviously think this is a good change, but the fact that it
> touched driver files makes me go "we're still doing something wrong".
>
> I'm not super-happy with hfi1_file_mmap() doing something like
> vma_start_write(), in that I *really* don't think drivers should ever
> have to think about issues like this.
>
> And I think it's unnecessary.  This is the mmap op in the
> hfi1_file_ops, and I think that any actual mmap() code had _better_
> had locked the new vma before asking any driver to set things up (and
> the assert would catch it if somebody didn't).
>
> I realize that it doesn't hurt in a technical sense, but I think
> having drivers call these VM-internal subtle locking functions does
> hurt in a maintenance sense, so we should make sure to not have it.

Ok, IOW the vma would be already locked before mmap() is called...
Just to confirm, you are suggesting to remove vma_start_write() call
from hfi1_file_mmap() and let vm_flags_reset() generate an assertion
if it's ever called with an unlocked vma, correct?

>
>                    Linus

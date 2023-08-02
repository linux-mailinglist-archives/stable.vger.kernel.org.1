Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5646C76D613
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 19:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjHBRvO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 13:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbjHBRun (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 13:50:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7734C3C17
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 10:49:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bcc0adab4so13826066b.2
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690998592; x=1691603392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dzqHOy3EWB73hskWYI+kku60VmM84hW7xpB+VPVJbzE=;
        b=Mzpho8HSTxtRblZ5r3wLdyVS/gJV9K6opZ/3m5LMlYVmOKNZO5TFC3a9rzEYbAIlTr
         w+kDQ3e94yztp371ZcW41LsgJZapcAVBzuOfb440h3Sqi3RA/vwvEBqNgq+eblPyDOaa
         5Z/MVhMfk3jmzwXF2pjOO9CuY0LFqYgDY0gZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690998592; x=1691603392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzqHOy3EWB73hskWYI+kku60VmM84hW7xpB+VPVJbzE=;
        b=d3W0MJrQhmTAJGhOWtW6o4m2sAQKElaYBjZbLyEpgDjtYS+ItEwpIBNjbFKDDuCXAI
         olWh7ChYtkvDUHsY8g0L4wTAnwew2Xy+Hq5d6EtJva24aF3o+fSb88ZCIPfQY61Oni1l
         5hZDO0dj9VxbOOQvIeWIVfxc9U56gx80V6VPSF1HbJrcQoshQzGdLI0mS8lRfh3Koac7
         6wVE1DAOX153IlbuOpS4Tz+orOyNgJIo07BtJmwMeAu4CR8WXDl1/+QRyH2WnXXYF/Ri
         XDSZJ1pjBmPUo4HdrL85e/9m87E82s8jxC2OcUc/FSk5md9VAjhaFCUTzlazWkBFD3fZ
         ScfA==
X-Gm-Message-State: ABy/qLZ25l2oSbfmwI/R5ZXz7bxFHXlRMT53kvFYYLiPUvUGKdpZbsUz
        dZ5LamNXmJGxn1efw/rA64MUR0PqKzVCNQb5496+fpsF
X-Google-Smtp-Source: APBJJlEkMCP7ia7Hua7YM13xjx2bwRcVotdzQ/bydn5HPctERQeVwy1xxskBLJCe5kNRLUzxXctP6g==
X-Received: by 2002:a17:907:2ce8:b0:99b:f645:224 with SMTP id hz8-20020a1709072ce800b0099bf6450224mr5251957ejc.9.1690998592753;
        Wed, 02 Aug 2023 10:49:52 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a26-20020a17090640da00b009829dc0f2a0sm9459592ejk.111.2023.08.02.10.49.52
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 10:49:52 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5221f193817so9824690a12.3
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 10:49:52 -0700 (PDT)
X-Received: by 2002:aa7:c0d2:0:b0:522:d6f4:c0eb with SMTP id
 j18-20020aa7c0d2000000b00522d6f4c0ebmr5009048edp.40.1690998591858; Wed, 02
 Aug 2023 10:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230801220733.1987762-1-surenb@google.com> <20230801220733.1987762-5-surenb@google.com>
In-Reply-To: <20230801220733.1987762-5-surenb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Aug 2023 10:49:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wix_+xyyAXf+02Pgt3xEpfKncjT8A6n1Oa+9uKH8bXnEA@mail.gmail.com>
Message-ID: <CAHk-=wix_+xyyAXf+02Pgt3xEpfKncjT8A6n1Oa+9uKH8bXnEA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] mm: lock vma explicitly before doing
 vm_flags_reset and vm_flags_reset_once
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, jannh@google.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 1 Aug 2023 at 15:07, Suren Baghdasaryan <surenb@google.com> wrote:
>
>       To make locking more visible, change these
> functions to assert that the vma write lock is taken and explicitly lock
> the vma beforehand.

So I obviously think this is a good change, but the fact that it
touched driver files makes me go "we're still doing something wrong".

I'm not super-happy with hfi1_file_mmap() doing something like
vma_start_write(), in that I *really* don't think drivers should ever
have to think about issues like this.

And I think it's unnecessary.  This is the mmap op in the
hfi1_file_ops, and I think that any actual mmap() code had _better_
had locked the new vma before asking any driver to set things up (and
the assert would catch it if somebody didn't).

I realize that it doesn't hurt in a technical sense, but I think
having drivers call these VM-internal subtle locking functions does
hurt in a maintenance sense, so we should make sure to not have it.

                   Linus

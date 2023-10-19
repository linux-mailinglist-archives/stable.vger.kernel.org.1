Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2A27CF49A
	for <lists+stable@lfdr.de>; Thu, 19 Oct 2023 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345039AbjJSKFJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 19 Oct 2023 06:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345162AbjJSKFJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Oct 2023 06:05:09 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB23F11F
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 03:05:06 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-778940531dbso93031985a.0
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697709906; x=1698314706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3bjb9rubAXmEx3BuTMzb9DXzA+Icb3ceQsdxtJC/Jk=;
        b=SXUoECpe8Nqneq+LhOtX8hB3yRr55n3RE0jS7au85tbECVbOSYro3wbUKJ543rwF/c
         XMy7p5iZzD3sLLP47IIzzdJM5GJgOMwTlg2rhqa+NR4tpF1cx7elsQoXzYYD6tNN9gp7
         6DO8LgS3MCcwvlxC6siOUI3kM/rN1VSbREuhJ39RIooSTaW4oXrqGkF75THM05pC/Xby
         KfuBYQSokrLJRhaGcQRNsf4X6ohd68MhTytvbZJYSlgkcKgpacxBg99SLc57noWSUpc3
         ed+nQhrpjGqOCZOB2gwSgoitqEEEvCqLZg9qfRpQUa2XNsY42zRBJ7BwyBzxPzyN14ky
         4hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697709906; x=1698314706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3bjb9rubAXmEx3BuTMzb9DXzA+Icb3ceQsdxtJC/Jk=;
        b=tX1la87JhKwBQDmpVeBIU/8SmgT2qoMo13mk5qQVQfDyaOpPQwW4EsTc9x7R4WASgv
         BS1/fcWzhPrTNbo1ypYLHJWGpfoxhr5S7iTCnJPfH0R/U7bbRp7WjmoKgHq5b4faRUzz
         Oe5AeITFLwYiXjex2sl+nQiHkEaEN2NVwNiTx4ztxClQ8eXNl72wY8ltOZb/Ap0L/D8z
         TL4Wcekaedm4S1b1ub7f3AHGCrc+jPi7qSyuVYZ7g7Go0S398PvJXzZd6Tsb9spqJwgX
         gdPyuVBElk0vR7ac8udnxbVFoBq7Qq49JrCzvk+iNoZsHdUGnUhM0uwjsThGsc2PP46b
         Hi/g==
X-Gm-Message-State: AOJu0YwudIavQWTAfWZLJ6+jEHU5J5tKTs2XefwgEsTJveQL9iVItGCn
        hoENLm4ymMEngZ0jrn8l2OxdNALkJr7nkDjz2vf3nQ==
X-Google-Smtp-Source: AGHT+IH6FHJbxjRMVCH1yb8tkbndeFnPREHuEjI+EYywqZ7BjmHUvnxgyZZpMGESGZMAgQQUcjtqiwGQIFSoapndiHM=
X-Received: by 2002:ad4:5f0b:0:b0:66d:1624:2200 with SMTP id
 fo11-20020ad45f0b000000b0066d16242200mr1943369qvb.13.1697709905579; Thu, 19
 Oct 2023 03:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231018182412.80291-1-hamza.mahfooz@amd.com> <CAMuHMdXSzMJe1zyJu1HkxWggTKJj_sxkPOejjbdRjg3FeFTVHQ@mail.gmail.com>
 <d764242f-cde0-47c0-ae2c-f94b199c93df@amd.com> <CAMuHMdXYDQi5+x1KxMG0wnjSfa=A547B9tgAbgbHbV42bbRu8Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXYDQi5+x1KxMG0wnjSfa=A547B9tgAbgbHbV42bbRu8Q@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 19 Oct 2023 12:04:23 +0200
Message-ID: <CAG_fn=XcJ=rZEJN+L1zZwk=qA90KShhZK1MA6fdW0oh7BqSJKw@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig.debug: disable FRAME_WARN for kasan and kcsan
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        linux-kernel@vger.kernel.org,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Nick Terrell <terrelln@fb.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Li Hua <hucool.lihua@huawei.com>, Rae Moar <rmoar@google.com>,
        rust-for-linux@vger.kernel.org, bpf@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> > > Are kernels with KASAN || KCSAN || KMSAN enabled supposed to be bootable?
> >
> > They are all intended to be used for runtime debugging, so I'd imagine so.
>
> Then I strongly suggest putting a nonzero value here.  As you write
> that "with every release of LLVM, both of these sanitizers eat up more and more
> of the stack", don't you want to have at least some canary to detect
> when "more and more" is guaranteed to run into problems?

FRAME_WARN is a poor canary. First, it does not necessarily indicate
that a build is faulty (a single bloated stack frame won't crash the
system).
Second, devs are unlikely to fix a function because its stack frame is
too big under some exotic tool+compiler combination.
So the remaining option would be to just increase the frame size every
time a new function surpasses the limit.

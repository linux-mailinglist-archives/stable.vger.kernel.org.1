Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFB178B677
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 19:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjH1Rah (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 13:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjH1RaY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 13:30:24 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964D211A
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:30:21 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-44e86f3e4b6so858399137.0
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693243820; x=1693848620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2WXMkuXavCrvB5E1bSmvUXIa9Xz7X0iJQJfaZFxRihk=;
        b=C8lvsFNOYMem0PLD28/tzEAE2qEIzHidIey+CQoeI/aBZ0YTVeFVWYombQUGViO2+t
         W+80eJyqOHVAhZryw0bNoYX3j/u3RqY/2VyNLWozWheCAXYLfsy/KIYqgCFnx1sFctD0
         p2186BC1f9D4So9WK6jNJQGqgNlb7+Lja2enTtdMHhCtoNj2eUKz2kLeO5be6yyyL+lF
         RdVmYG4sDir0f1W8QK+9BrR5dPRK+3o0W+LIVIpDg8HDpY+UqWCIMMxE45JqAlv43aCH
         +6F0q9p4NMRxZRB4hzh9Oe+sr5oOX9C5kkiVwlU2BIH1WtM4s3T9DgcxAVgrZzlRWRZT
         FmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693243820; x=1693848620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WXMkuXavCrvB5E1bSmvUXIa9Xz7X0iJQJfaZFxRihk=;
        b=NAcuwvJfMKtKuNr7uhOQjBVToYixgkluBOOOuOzd3vvc6+nnS5jWPQUS5EH5HzreAv
         lIgHM0Py90DukvnrzNjhEyXupSAnSQ6IcHp+rPo84SUfxxTuc7EL9rEdbA8ItYxzA4SH
         svlwCjTgQVAyb/jScmsnfn5xcb4sZJZU1VW2bdn2TTPDU6RQ6A4FKYLkjUsuqO7Z/OYk
         sPU+PJvViZgQKNh88pbJo6cmYQiibSNG6xvtcRCqMZO5CHQsMrk0tiN33mlRVEiMxTAS
         QsfoCfe9DwkUJGP/NOip3F69Pd4L0jZWVo/KzCaPpbgPzSuXyGvTLSej6sNZhbbjl0dZ
         28Ng==
X-Gm-Message-State: AOJu0Yx9RAtFeqSqRXeKfeXuT0FqtcMvMJE1Y7BUk8FX8IVqIBVPIDep
        ke5IzGmyFIwKX2XMlPMdoiZgbq5Au8dTqJy0p0rShA==
X-Google-Smtp-Source: AGHT+IGgcJ/msAlUq9iW+kDjKzwJiwE02t53bR7UOEBKquUn9g7lTmqYj/TpdAvPJIlxRJNe5bMBS4W5kuKO4v5LwKk=
X-Received: by 2002:a67:f8d5:0:b0:44e:9a71:27a1 with SMTP id
 c21-20020a67f8d5000000b0044e9a7127a1mr7609225vsp.17.1693243820627; Mon, 28
 Aug 2023 10:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYscGFiG1TVLyfETVu3NV5BAe8sCOXRGDnky-w31aB6yVQ@mail.gmail.com>
 <2023082853-ladylike-clanking-3dbb@gregkh>
In-Reply-To: <2023082853-ladylike-clanking-3dbb@gregkh>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 28 Aug 2023 23:00:08 +0530
Message-ID: <CA+G9fYtS-Pe0L9PsjTdEjnysuX9Ax+04jgZSkJAFqsGHC1Xm=w@mail.gmail.com>
Subject: Re: clang: net: qed_main.c:1227:3: error: 'snprintf' will always be
 truncated; specified size is 16, but format string expands to at least 18 [-Werror,-Wfortify-source]
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Sasha Levin <sashal@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 28 Aug 2023 at 20:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 28, 2023 at 05:57:38PM +0530, Naresh Kamboju wrote:
> > [My two cents]
> >
> > stable-rc linux-6.1.y and linux-6.4.y x86 clang-nightly builds fail with
> > following warnings / errors.
> >
> > Build errors:
> > --------------
> > drivers/net/ethernet/qlogic/qed/qed_main.c:1227:3: error: 'snprintf'
> > will always be truncated; specified size is 16, but format string
> > expands to at least 18 [-Werror,-Wfortify-source]
> >  1227 |                 snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
> >       |                 ^
> > 1 error generated.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Is this also an issue in 6.5?

I see it on 6.5, Linux next-20230828 tag, stable 6.4 and 6.1.

- Naresh

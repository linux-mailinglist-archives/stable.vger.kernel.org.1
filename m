Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C377D77822B
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 22:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjHJUbU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 16:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbjHJUbT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 16:31:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFA32738
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 13:31:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686bea20652so1175548b3a.1
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 13:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691699478; x=1692304278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmA0D0ppBgmOjczk4CVHcUSDpPugaWM3Kx84P6qwgeI=;
        b=RfrtqqouriqrOh/vkxrdmy9bYEqBy9qQgW7CCwSBrS5NXDhE7/ojyQ5KH0dm5dadLq
         pgGoZcwmhkg02tN/XqtGtmO58xICSjojaFi9OyTtdSuEGEhIxLggKZzlE+500nuUEuzI
         oRvRf7mzTUVKfQuuk/QxB+3cEfZxBU0cM+BIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699478; x=1692304278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmA0D0ppBgmOjczk4CVHcUSDpPugaWM3Kx84P6qwgeI=;
        b=Oj3BIrOCQlG+Gr7dsMr78rgPhJHZThil7c32aK2pg2d/oOGQ/5VCWBXxGc68rNB88X
         ErWXFS/xHcffHcsnWowrkAlTZsi6V7TT7VwNyyFXxHCc+pjDfTWlkZ016riuOxIH8hOo
         /DKcrCvqjROdG9JgLqnHGtLglDjnwZy4NyIRSJgXgI5JoeyDdk/NE67RHlrPrNsL1Vqu
         uAzIvUe9hMmpc5VQ1jPq9LEmZsgHrCRXcsw+yo8I0AuZIM+zPSn+021s8nMmLOIAMIxG
         ixzvuT5tPlFak/PYuk8nsQQh0mT6PmmdUZg1pL8tgfMf0SsuBNxdtop6GekNdj5UBNML
         Xw9w==
X-Gm-Message-State: AOJu0YzvCJYx8dmwmCN9AVKE62k5svvPz9G8a4FhqgFVGycSMRiQ/pz7
        G+YUqtrsPnsbt4+GKyBgpeK7qw==
X-Google-Smtp-Source: AGHT+IE0gnsgv/pJpfLOEYU0Fzxm+6j4x/w8nvcxBTo64Odro0Cux1tbhbVaHKEPWstRET+1An19hw==
X-Received: by 2002:a05:6a20:8e06:b0:135:8a65:a772 with SMTP id y6-20020a056a208e0600b001358a65a772mr66652pzj.50.1691699478169;
        Thu, 10 Aug 2023 13:31:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i20-20020a633c54000000b00564670fea62sm1950771pgn.21.2023.08.10.13.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:31:17 -0700 (PDT)
Date:   Thu, 10 Aug 2023 13:31:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-hardening@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: stable-rc: 6.1: gcc-plugins: Reorganize gimple includes for GCC
 13
Message-ID: <202308101328.40620220CB@keescook>
References: <CA+G9fYsf0jePDO3VPz0pb1sURdefpYCAYH-y+OdsAf3HuzbeRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsf0jePDO3VPz0pb1sURdefpYCAYH-y+OdsAf3HuzbeRw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 08, 2023 at 10:57:30AM +0530, Naresh Kamboju wrote:
> LKFT build plans updated with toolchain gcc-13 and here is the report.
> 
> Stable rc 6.1 arm64 builds with gcc-13 failed and the bisection is pointing
> to this as first bad commit,
> 
> # first fixed commit: [e6a71160cc145e18ab45195abf89884112e02dfb]
>    gcc-plugins: Reorganize gimple includes for GCC 13
> 
> Thanks Anders for bisecting this problem against Linux 6.2-rc6.
> 
> Build errors:
> ---------------
> In file included from /builds/linux/scripts/gcc-plugins/gcc-common.h:75,
>                  from /builds/linux/scripts/gcc-plugins/stackleak_plugin.c:30:
> /usr/lib/gcc-cross/aarch64-linux-gnu/13/plugin/include/gimple-fold.h:72:32:
> error: use of enum 'gsi_iterator_update' without previous declaration
>    72 |                           enum gsi_iterator_update,
>       |                                ^~~~~~~~~~~~~~~~~~
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

I'm slightly confused by this report. Is it the build of v6.1 that is
failing? Commit e6a71160cc14 ("gcc-plugins: Reorganize gimple includes
for GCC 13") was added in v6.2.

I think you're saying you need it backported to the v6.1 stable tree?
("First bad commit" is really the first good commit?)

-Kees

-- 
Kees Cook

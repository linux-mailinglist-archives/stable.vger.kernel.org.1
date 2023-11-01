Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468C57DE3A4
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 16:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjKAPSu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 11:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjKAPSs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 11:18:48 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ED418C
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 08:18:31 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7ba45fc8619so1553444241.2
        for <stable@vger.kernel.org>; Wed, 01 Nov 2023 08:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698851910; x=1699456710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9RB7BfhgpRCUBVJO5uIDlwkrn/lyyD50XG0yLUMwIqk=;
        b=nCR0Tl8xMzZJtARG7shYdxMc+x+3+CpLKn8w2U3UjJbYZ38qrWg2shRSHQiBw0YbUi
         NWZzyQnqu8s1iBAmn92k0d28H69kT6tpiU7nbGmFXImamcbryF1+FDE5RtwCLlm1E/jq
         RwxEVtL3K/p7wF7pa7RAJXZ1gH3Kifj41vBGu+XWjHdihBagXGys4lepKY0TzP7qUFBl
         tXlWa6N5fDQ4MpuHi6Nqb219q4WhmKyoG9GEUxLw6kHIMTNWGgjN5PUUWgz2F6M+FkuB
         EgVNmN99mxzSfnzQHWax7KGX8rR9hzEW44spjmnIB4f0u6MfXlar6+hL4WwahVGyNuI0
         FQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698851910; x=1699456710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RB7BfhgpRCUBVJO5uIDlwkrn/lyyD50XG0yLUMwIqk=;
        b=sIit4hZ/rQLTXNLF4Oc7jL5TdQy3esMqHpX7zMedq9MG2ajOpmOpT8hKEZ5HK6sOqk
         MXcJJHUL2uqkbYbGW6osp48z4uIwlYx4D4TBRHAIJ+1yBFISZsUt/SW41fmFD9u0iAjv
         acwp/pbs4LdHg8rj0Ewd6K0NQ9t3Q68r//YroKuZYrDgOc/0sBTWnR3BymBwEphy715h
         FOnwIezCO7ob19pow+nO/wTpUGdM6js5ZSbQLuBGCzQlAuBY04RsP8JWbQTiaLlyjnuZ
         vq+LY1gscHiX2FPmP4iMx4kh9Qj5IDzX/TGLD7Gm+sElFIA0XCt5zCCVojZOosTokGU9
         9Fmg==
X-Gm-Message-State: AOJu0YxUwdVGtpAGZGRom74uCjfYCld251ankVIs8ISOuJmKoQB+bsDj
        wtJSa0rUshL+yqwyAQpkoITHsTqRK+xBLAJJjnhdlCtuTttte00uXS+K8Q==
X-Google-Smtp-Source: AGHT+IGUVnJ4Kri5RWsIPeqzB2Au8woVRnmkFohfQGhuwqW6ihHKnI9RyhPRUbH6QEbNk9siiSJ56wW5hdjEJvMH70Q=
X-Received: by 2002:a67:e09b:0:b0:45b:6afc:6819 with SMTP id
 f27-20020a67e09b000000b0045b6afc6819mr9117223vsl.21.1698851910053; Wed, 01
 Nov 2023 08:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt-XxvA+Fg5+htpqy8ySAtY-q+dGD_FOvmzGJOPbAySHA@mail.gmail.com>
In-Reply-To: <CA+G9fYt-XxvA+Fg5+htpqy8ySAtY-q+dGD_FOvmzGJOPbAySHA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 1 Nov 2023 20:48:19 +0530
Message-ID: <CA+G9fYu0Xix_eZBuRg1+MdVmUDhbFcfR5FeiU8VzgMa__M5iow@mail.gmail.com>
Subject: Re: stable-rc: 5.4 - all builds failed - ld.lld: error: undefined
 symbol: kallsyms_on_each_symbol
To:     linux-stable <stable@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 1 Nov 2023 at 20:38, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Hi Greg,
>
> I see the following build warning / errors everywhere on stable-rc 5.4 branch.

I am sorry,
It is on stable-rc 5.15.

>
> ld.lld: error: undefined symbol: kallsyms_on_each_symbol
> >>> referenced by trace_kprobe.c
> >>>               trace/trace_kprobe.o:(create_local_trace_kprobe) in archive kernel/built-in.a
> >>> referenced by trace_kprobe.c
> >>>               trace/trace_kprobe.o:(__trace_kprobe_create) in archive kernel/built-in.a
> make[1]: *** [Makefile:1227: vmlinux] Error 1

I see the following latest commit on stable-rc 5.15 branch

tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
commit b022f0c7e404887a7c5229788fc99eff9f9a80d5 upstream.

- Naresh



> Links,
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2XXALLRIZaXJVcqhff4ZmGTeZoQ/
>
> - Naresh

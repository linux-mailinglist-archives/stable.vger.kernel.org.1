Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF55A7DA41C
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 01:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjJ0Xhq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 19:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJ0Xhq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 19:37:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824601A6
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 16:37:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F93C433C7;
        Fri, 27 Oct 2023 23:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698449864;
        bh=aCJLWjdhU+5nCV6MY/j5MaIJfk6Y70haoZWhwkapETs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JHj014QsOtLjRB9STmY/QRoHaYnrnyBpcw9by28Jtet59hAM6hbi9ii8GgCrSzIKO
         Hm8Ul3DdYBKuWXK/qDqmcnwQjWsjGGrfbQu8LDWTv/NbFR+Z7/X8ZM4CLSYTwLNW46
         lhLQoBh5xa+CwpOnFz59bFl8W8HoVqywfhC74JRyomxoeWNlc0PezUY3uLAvZLVpOP
         F23DDQ+DB/ck9aRuglLbsmuSgOVkakOEjQY9k4ZyqD7nEwEQOELwdqiwWyfknVQSgg
         yba36D9LSAOC2fTfdBQZ91LRKLXa9AIF4ea0LVOg33Fvl9uw7fwYr+zqySDI73NMJJ
         zWYY0NkVnxAVg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-507a62d4788so4022933e87.0;
        Fri, 27 Oct 2023 16:37:43 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy91cJ8TRqcRVxNZS/99iGJX7V15jzHJ4TlYX7+h1L6uEnmgQiQ
        tNUY47LGmS6RlwLL8Pwr3ac9v6/KMDwuVIjLFVk=
X-Google-Smtp-Source: AGHT+IErVIa16OdIYg71SntJ/eEKyZs7geS5tG2hC3qrU6xcJtP1SoEw0chQzTcaA7dv3gPNQ+TRXyUSWSpAYpANjDo=
X-Received: by 2002:a19:7710:0:b0:508:1c45:f998 with SMTP id
 s16-20020a197710000000b005081c45f998mr2314308lfc.48.1698449862246; Fri, 27
 Oct 2023 16:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231027233126.2073148-1-andrii@kernel.org>
In-Reply-To: <20231027233126.2073148-1-andrii@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 27 Oct 2023 16:37:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4aLOvH7t2m6tm8CjPWKr_hvsvh_TacDgpggg7bL3b7aw@mail.gmail.com>
Message-ID: <CAPhsuW4aLOvH7t2m6tm8CjPWKr_hvsvh_TacDgpggg7bL3b7aw@mail.gmail.com>
Subject: Re: [PATCH] tracing/kprobes: Fix symbol counting logic by looking at
 modules as well
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        bpf@vger.kernel.org, Francis Laniel <flaniel@linux.microsoft.com>,
        stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 27, 2023 at 4:31=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Recent changes to count number of matching symbols when creating
> a kprobe event failed to take into account kernel modules. As such, it
> breaks kprobes on kernel module symbols, by assuming there is no match.
>
> Fix this my calling module_kallsyms_on_each_symbol() in addition to
> kallsyms_on_each_match_symbol() to perform a proper counting.
>
> Cc: Francis Laniel <flaniel@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func mat=
ches several symbols")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <song@kernel.org>

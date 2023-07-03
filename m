Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02687746174
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 19:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjGCRae (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 13:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGCRad (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 13:30:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFA4E59
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 10:30:32 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98e109525d6so853050266b.0
        for <stable@vger.kernel.org>; Mon, 03 Jul 2023 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688405430; x=1690997430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CrS/MpuWOEjZGLSDInBYEukcytiKIRhK8AvJ7Dhgwl8=;
        b=AJkYUWLzRRpXGP3wlCexBptPwNnatNTc7igkz+o8cRwv9+1oMYA3C6ips1xNmuVzq2
         ja6+S1uPJJChIBXCC+NxyFAgQLmaGyt59nw78LrPb00wYw4XkrR7tpqqV5ccr5TchBpo
         D1TvpylEA9Y/zgZpGt7ZALZIKF+rXktKsw/MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688405430; x=1690997430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrS/MpuWOEjZGLSDInBYEukcytiKIRhK8AvJ7Dhgwl8=;
        b=BcO2qQ4QEGtaJyTJCpaSLUTq5fHhaUnkC3IH2j8oDNJypsccritvmsJUzTOTUjng2Z
         RYfxNQP8PXrBr/it7VmWY+l/5qe5q+9DBmytaJa8pz0dpuByB2DokfsWxjmsYauGnbYV
         hDh3vbO7XSVmMqm9PuFDyD2bmvEP8JNd+r1wpsue7N2CcmYhpgjlPNW2uKxUxc3Un561
         OMQfqwXXUz0TZXSJHfgWS2jMStDqzm0ZaxoMCCOUTAC556gOFliwuui1lwVrNWTbGbdy
         EtyTzDaooJC7p9KkHs0q/Kj7s+m2aO9e+KXOtS/TDsAiMmtDj6w7Tj774CWih8rOdeRV
         rXOA==
X-Gm-Message-State: ABy/qLZfz675DuAJ57zFvPUGNwIkJzNNmAVUzw1loRYaO/sCaVGUd93+
        IYZWOoMpVYXejScqEMgPQisBIXEKdB7rrzlsoCCrVF2t
X-Google-Smtp-Source: APBJJlHAO6THnDsMDoXyIQOWdI5H7G70PgUU8hsK54PW5QnLeSCoi2FipvrgpOYGeCiKKNRuizOfVg==
X-Received: by 2002:a17:906:108f:b0:988:8a02:457b with SMTP id u15-20020a170906108f00b009888a02457bmr9907696eju.15.1688405430537;
        Mon, 03 Jul 2023 10:30:30 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id gt12-20020a170906f20c00b00992b2c5598csm5887786ejb.128.2023.07.03.10.30.29
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 10:30:29 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51dd0205b2cso8306172a12.1
        for <stable@vger.kernel.org>; Mon, 03 Jul 2023 10:30:29 -0700 (PDT)
X-Received: by 2002:a05:6402:4494:b0:51a:4c1e:c94a with SMTP id
 er20-20020a056402449400b0051a4c1ec94amr18268322edb.2.1688405429462; Mon, 03
 Jul 2023 10:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <2023063001-overlying-browse-de1a@gregkh> <0b2aefa4-7407-4936-6604-dedfb1614483@gmx.de>
 <5fd98a09-4792-1433-752d-029ae3545168@gmx.de> <CAHk-=wiHs1cL2Fb90NXVhtQsMuu+OLHB4rSDsPVe0ALmbvZXZQ@mail.gmail.com>
 <CAHk-=wj=0jkhj2=HkHVdezvuzV-djLsnyeE5zFfnXxgtS2MXFQ@mail.gmail.com>
 <9b35a19d-800c-f9f9-6b45-cf2038ef235f@roeck-us.net> <CAHk-=wgdC6RROG145_YB5yWoNtBQ0Xsrhdcu2TMAFTw52U2E0w@mail.gmail.com>
 <2a2387bf-f589-6856-3583-d3d848a17d34@roeck-us.net> <CAHk-=wgczy0dxK9vg-YWbq6YLP2gP8ix7Ys9K+Mr=S2NEj+hGw@mail.gmail.com>
 <c21e8e95-3353-fc57-87fd-271b2c9cc000@roeck-us.net> <CAHk-=wj+F8oGK_Hx6YSPJpwL-xyL+-q2SxtxYE0abtZa_jSkLw@mail.gmail.com>
 <7146f74d-8638-46c7-8e8c-15abc97a379f@gmx.de> <CAHk-=wjqp09i1053vqFc41Ftegkrh0pD+MKY-3ptdYu3FUh6Bw@mail.gmail.com>
 <964806c4-db73-a70b-2168-24168e4b5aab@roeck-us.net>
In-Reply-To: <964806c4-db73-a70b-2168-24168e4b5aab@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jul 2023 10:30:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-hZr6N-ONO3mmUOwPDrOJ_N3NYXD3bsk4bm-1jaD2mw@mail.gmail.com>
Message-ID: <CAHk-=wh-hZr6N-ONO3mmUOwPDrOJ_N3NYXD3bsk4bm-1jaD2mw@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Helge Deller <deller@gmx.de>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John David Anglin <dave.anglin@bell.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 3 Jul 2023 at 10:19, Guenter Roeck <linux@roeck-us.net> wrote:
>
> FWIW, my qemu boot tests didn't find any problems with other architectures.

Thanks. This whole "let's get the stack expansion locking right"
wasn't exactly buttery smooth, but given all our crazy architectures
it was not entirely unexpected.

Let's hope it really is all done now,

            Linus

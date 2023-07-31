Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7BC76A152
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 21:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGaTdY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 15:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjGaTdY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 15:33:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3AE1982
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:33:23 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe0e34f498so7605607e87.2
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690832001; x=1691436801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yXLFlpjaOoFRKiNfZATjG2CogmUERUAniLQFoDaW35U=;
        b=DmEFT6jHO9aU0Q7mmz7r/3blosp5zNuGMXAmEo5De2MDIjQKJZZBHYk/ElQiLMJeg0
         QxQml6A/B37Up+BHTkZgXTfbuW4Inuyyvw66qiXZBSPYiVtmmmJCuX1VbOBpKw+XJtXr
         nRWRkTI1yyC577PjDeimQqdrdqEu8m7qM+jQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690832001; x=1691436801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXLFlpjaOoFRKiNfZATjG2CogmUERUAniLQFoDaW35U=;
        b=lqreer1SGBsMA/xBst7MwFenq8YqkWi+3b2g+HdfKT5Gdyt7DiRaspR04fZJP17Fes
         E8hSOV690y07/ns/pn32bOyNAuTvaPOIUSzrdBqaSGuAuyBfqcaUQ1ghFx+qrqCnYszQ
         Gs5+AQu12b+LrHnp68mP6e5CT+hfty0uJMPwau8H0FMQKfHwNZW5CZThHYDzCNRSlIY2
         OPTKZXLRg42wGUspi25i0lrdCc4fbCHxLiBawXC9v7rxuq+FyAo9Pj7TnJsLaKaumCXB
         MMcm/ViJAsbyC6tBYdaVZtRUoQgzt31k13trgaBvqMZMN4MjAMBdXWF2YatbpbS4yz20
         7LWw==
X-Gm-Message-State: ABy/qLawg2IZXDFRgJhogZkj2I1b/r6l0/y5PpyRmfd8VuiOwDQlQCiw
        9B1xjWdhmMqC8hC9ZTrsWJ8BBjgmHW0M44c6IT3T6Ib+
X-Google-Smtp-Source: APBJJlFHG2rEwRusmy+eqqznmR00HbynG/Arxo/WCl4JxASAuo3rQs1r1Zh4+2wgOlEeWBAqivYASw==
X-Received: by 2002:a05:6512:549:b0:4f8:7551:7485 with SMTP id h9-20020a056512054900b004f875517485mr555850lfl.5.1690832001065;
        Mon, 31 Jul 2023 12:33:21 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004fe1f02db22sm1816940lfl.186.2023.07.31.12.33.20
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:33:20 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso7656421e87.0
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:33:20 -0700 (PDT)
X-Received: by 2002:a19:2d4b:0:b0:4fb:89e3:5ac6 with SMTP id
 t11-20020a192d4b000000b004fb89e35ac6mr527434lft.62.1690832000024; Mon, 31 Jul
 2023 12:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230731171233.1098105-1-surenb@google.com> <20230731171233.1098105-2-surenb@google.com>
 <CAHk-=wjEbJS3OhUu+2sV8Kft8GnGcsNFOhYhXYQuk5nvvqR-NQ@mail.gmail.com> <CAJuCfpFWOknMsBmk1RwsX9_0-eZBoF+cy=P-E7xAmOWyeo4rvA@mail.gmail.com>
In-Reply-To: <CAJuCfpFWOknMsBmk1RwsX9_0-eZBoF+cy=P-E7xAmOWyeo4rvA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 12:33:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFXOJ_6mnuP5h3ZKNM1+SBNZFZz9p8hyS8NaYUGLioEg@mail.gmail.com>
Message-ID: <CAHk-=wiFXOJ_6mnuP5h3ZKNM1+SBNZFZz9p8hyS8NaYUGLioEg@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: enable page walking API to lock vmas during the walk
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 31 Jul 2023 at 12:31, Suren Baghdasaryan <surenb@google.com> wrote:
>
> I got the idea but a couple of modifications, if I may.

Ack, sounds sane to me.

             Linus

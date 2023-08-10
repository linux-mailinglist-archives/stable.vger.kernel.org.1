Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDD277807F
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 20:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbjHJSk7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 14:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbjHJSkn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 14:40:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841413C1D
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 11:39:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bfcf4c814so175926366b.0
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 11:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691692771; x=1692297571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4XjBV0qXXp37wiVyXtpMqkFIhm8hlMYH3y9Bd3d4SgY=;
        b=Y820onkS7q0gvE2DiiLiBvn4MlVr42biwd5fACjdg/gRbZUP/zrOVtQAaZ8gMPfpHL
         VUMhrbvWNJ1yd7fLgZ1K3EI0TiITo7RPJuV+Kk19fpYOPNTNYmcOd+pamOilg/M6Vuxp
         6az6LtqPKUTDuIlH4Sr7ozIQK4YNGZ4eS1bF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691692771; x=1692297571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XjBV0qXXp37wiVyXtpMqkFIhm8hlMYH3y9Bd3d4SgY=;
        b=Rwu+xRG+aKmdfxa+mikLMHY6LpfKlfp5l4hY/sB1huqCPMNk7AszPlHpHeLFyOHiI9
         ZiJfWkL11rYTWapU8EZuJ2k870kaxzT1bM8JfwXgdZSDeNVRzDGbOixN72KBqmUlc+aN
         gqvOj381CGFcyVb7vJTMZy/Ud1AJTdILmyN/ZNy65MvQjkyQ/7RVkN3c5SesK+S3m5Df
         SiXyUqxVjsV2yrw1AJL4tBbDGDYeCV6TVcCPT/mK0/8xfnnZ/eipQbOuNmSSH6jehXP6
         U98rM+HGXJAtIOAnVKQjk+mMIV0X9gRQGrVsfQGgX0hOD5cAXdTcWrAITjSkssLc89jm
         3Xpw==
X-Gm-Message-State: AOJu0YwMdIOqFfdCoXdFR63XRLtKfOc0T22wkYugbxq3EXSXCpiHt9KN
        my2satIshrjPpktGspx0fmLYrLQmMBplmJ5S2PkvxYX7
X-Google-Smtp-Source: AGHT+IFF18BVM4kIhHs+TT6BEIalkyADS7LaGuXkFniFrPXoRHzymk7Zf48BfQZHXKQGymZ+WNzvCA==
X-Received: by 2002:a17:907:75e7:b0:99c:441:ffa with SMTP id jz7-20020a17090775e700b0099c04410ffamr2683263ejc.29.1691692771161;
        Thu, 10 Aug 2023 11:39:31 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id lf6-20020a170906ae4600b0099cf840527csm1255993ejb.153.2023.08.10.11.39.30
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 11:39:30 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5236a9788a7so1578154a12.0
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 11:39:30 -0700 (PDT)
X-Received: by 2002:a05:6402:31eb:b0:523:3609:d3ca with SMTP id
 dy11-20020a05640231eb00b005233609d3camr2930836edb.20.1691692769886; Thu, 10
 Aug 2023 11:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230809144600.13721-1-kirill.shutemov@linux.intel.com>
 <CAHk-=whaGTq11x_F1Y+J85j+Eh7JxVqH1sWpqgH+-7wQZ1ZE2A@mail.gmail.com> <CY4PR11MB2005976F49613E20BC072ECCF913A@CY4PR11MB2005.namprd11.prod.outlook.com>
In-Reply-To: <CY4PR11MB2005976F49613E20BC072ECCF913A@CY4PR11MB2005.namprd11.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Aug 2023 11:39:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whS19C=y32vNMRp7UfQMVw38HOfzhs9v5rjLayEFjMNPA@mail.gmail.com>
Message-ID: <CAHk-=whS19C=y32vNMRp7UfQMVw38HOfzhs9v5rjLayEFjMNPA@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix access_remote_vm() regression on tagged addresses
To:     "Schimpe, Christina" <christina.schimpe@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 10 Aug 2023 at 05:42, Schimpe, Christina
<christina.schimpe@intel.com> wrote:
>
> We don't have any LAM support in GDB yet, we are just working on it.
> We currently rely on that feature, but could still change it. We don't
> necessarily require /proc/PID/mem to support tagged addresses.
>
> ARM's TBI support in GDB does not rely on /proc/PID/mem to support tagged
> addresses AFAIK.

Ahh. That would explain why nobody noticed.

I do wonder if perhaps /proc/<pid>/mem should just match the real
addresses (ie the ones you would see in /proc/<pid>/maps).

The main reason GUP does the untagging is that obviously people will
pass in their own virtual addresses when doing direct-IO etc.

So /proc/<pid>/mem is a bit different.

That said, untagging does make some things easier, so I think it's
probably the right thing to do.

             Linus

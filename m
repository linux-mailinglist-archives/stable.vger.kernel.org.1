Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB4B6F07FA
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 17:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244086AbjD0PNF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244145AbjD0PND (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 11:13:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02742421D
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 08:13:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-959a626b622so836797566b.0
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682608379; x=1685200379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tnBlwR2KgjIrpyr1ey4GRZA/jG9gwGR13N6cjFqMs0=;
        b=fKUaWjUJ8mKf36zHO3vuQML5HdFupvkc97Aet0N6roPO9Mvl1emFYI5ASnORVKNVVP
         24vG050RF1h/m2pGUsY4Qs7K0X6dBSNg3CLH/amgUBi2nJnumZkI+F+rsnlHaA144sYe
         0UxQZGO4FZAwz4bCC/i3t/YZamxccbGa10nE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682608379; x=1685200379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tnBlwR2KgjIrpyr1ey4GRZA/jG9gwGR13N6cjFqMs0=;
        b=VM1zf+lXqVmy2Nhb6E8aNf99NxrD+HX3yeAAheAeisDeZzj2D1Q9o1TEURBtbM78Gg
         BYc1dwHiIq2hA/fn+tgqCNq2wAhK+u/lqRRRoVJTIKpH6r/XfHb067e/d8B97wQu6PIn
         FPWEj7V46/uY6jNAgcuT+vqvvOt6imJnzrPtWPMmJYlQZbyWVPaMTFEBo83J7M7Rkt8z
         /8FP3mJK7cSR++f2u5eHwZ0bXowujj91LwjZApWhgjYq8B1RZqWM1X4PntaO4NnD7dOm
         R/aFtYF6NpiyPewhpSvJUPdef1QmEwJThKLAj+U+sNAQe8vqLlOn11/Ux8nXUmRKn3PN
         PugA==
X-Gm-Message-State: AC+VfDxMuxdZWW5r2BLkSdeMOL5Z5q9WlvZ6xW42NSxohWdPWwVkT7hd
        YXWL2ahqgXREiXT6oN1rj9hbfOmLzsVmCGGAPR/GNA==
X-Google-Smtp-Source: ACHHUZ4L52HNZGq9VNgSbNa+rh5iB0ccMH0UMY+wza+LrsWF8kyK+L6RP+5odw1hWyJ9CAwtXZY94g==
X-Received: by 2002:a17:906:eec8:b0:94e:edf3:dccd with SMTP id wu8-20020a170906eec800b0094eedf3dccdmr2438968ejb.0.1682608379398;
        Thu, 27 Apr 2023 08:12:59 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id kw15-20020a170907770f00b0094f8ff0d899sm9645651ejc.45.2023.04.27.08.12.57
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 08:12:57 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-504ecbfddd5so12819918a12.0
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 08:12:57 -0700 (PDT)
X-Received: by 2002:aa7:c946:0:b0:508:3b23:d84c with SMTP id
 h6-20020aa7c946000000b005083b23d84cmr1902412edt.1.1682608377021; Thu, 27 Apr
 2023 08:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230427140959.27655-1-vbabka@suse.cz> <2023042719-stratus-pavestone-505e@gregkh>
 <3cc6e10c-f054-a30a-bf87-966098ccb7bf@suse.cz>
In-Reply-To: <3cc6e10c-f054-a30a-bf87-966098ccb7bf@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Apr 2023 08:12:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdGzy6-3jzN6Kvtz1QxStTZBZPz1zy9i4gM9nbe5FGbA@mail.gmail.com>
Message-ID: <CAHk-=wgdGzy6-3jzN6Kvtz1QxStTZBZPz1zy9i4gM9nbe5FGbA@mail.gmail.com>
Subject: Re: [PATCH for v6.3 regression] mm/mremap: fix vm_pgoff in
 vma_merge() case 3
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Greg KH <greg@kroah.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, lstoakes@gmail.com,
        regressions@lists.linux.dev, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Fabian Vogt <fvogt@suse.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Apr 27, 2023 at 7:39=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Sorry, I wasn't clear what I meant here. I didn't intend to bypass that
> stable rule that I'm aware of, just that it might be desirable to get thi=
s
> fix to Linus's tree faster so that stable tree can also take it soon.

Ack. It's in my tree as commit 7e7757876f25 right now (not pushed out
yet, will do the usual build tests and look around for other things
pending).

                 Linus

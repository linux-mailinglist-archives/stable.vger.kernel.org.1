Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2E976D736
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 20:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjHBSyr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 14:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjHBSy2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 14:54:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B11212D
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 11:54:09 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so83859a12.1
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691002447; x=1691607247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bOvJemkz8MAV7rkDv/s31q26dZgdbiAYujbRCsOrvF8=;
        b=iAJoALiqtAbdQA87RmsAUnXZA1DIpIrj6EBAyzQ29CwXAsd1jXvMnU6jawbCRiZxkw
         MO3Hyie+UDR5MuVg7zawY4kOg/B1dlb1qinzOGkMV/PeZ21PziYIFA2zI7OgXvj7MSWG
         Phb2xmkRhTsrgx0XSeWRscKqti8AqniVr3Mb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691002447; x=1691607247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOvJemkz8MAV7rkDv/s31q26dZgdbiAYujbRCsOrvF8=;
        b=dJcnZdWggXvFsC4qqxFcTlOUu/TwEyTGBXbqhqbAM7CQMhD2la1rpfChaaPoDy3eAE
         IKQggDW1VENIbObAHTvoLiEgyZY6J0dZNR1SVnC3h7WsWZ58du45ljzmYp/rBbDtJr1X
         K+dG0IDm1/0ihRBk1TdMEOdVxsCNjo9c4hqlVwqYe7nn82531GKZ6FGxNzFVXnJ1FFmH
         mB42U1PTl3OZ9rHKaVJ8jkHevFlblSNkMPIHAvpklLouyqYHsoWPAJ/ldvYJGgtpLzaE
         ekpScnPntVQes1PZNDbuUjVtxhqhvACOthupV0nYg32stXtiFqMWBloJYuGTBHUXvNHZ
         +j0A==
X-Gm-Message-State: ABy/qLbA6zX+1aToILqpoLXV9Kzmap1jCcgJ4kmfDe8S/00qs41/7duW
        Nn+rQxrTm2kD3mg17X8yKMP97QVSyZopCx40k2evwrJW
X-Google-Smtp-Source: APBJJlGursx7V5YNLURaJJOm3Vno3fM3j8eLPLy+S9u/MW0F1kJ7fm2XDeNB4U/j6eemn497gyvM4A==
X-Received: by 2002:aa7:dad3:0:b0:522:ab06:721c with SMTP id x19-20020aa7dad3000000b00522ab06721cmr5926624eds.29.1691002447748;
        Wed, 02 Aug 2023 11:54:07 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id d4-20020a50ea84000000b005221f0b75b7sm8900732edo.27.2023.08.02.11.54.06
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 11:54:07 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so75535a12.2
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 11:54:06 -0700 (PDT)
X-Received: by 2002:aa7:df18:0:b0:522:289d:8dcd with SMTP id
 c24-20020aa7df18000000b00522289d8dcdmr4973875edy.35.1691002446423; Wed, 02
 Aug 2023 11:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230801220733.1987762-1-surenb@google.com> <20230801220733.1987762-5-surenb@google.com>
 <CAHk-=wix_+xyyAXf+02Pgt3xEpfKncjT8A6n1Oa+9uKH8bXnEA@mail.gmail.com> <CAJuCfpFYq4yyj0=nW0iktoH0dma-eFhw1ni7v9R-fCsYH7eQ3Q@mail.gmail.com>
In-Reply-To: <CAJuCfpFYq4yyj0=nW0iktoH0dma-eFhw1ni7v9R-fCsYH7eQ3Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Aug 2023 11:53:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxQpxK_vOpdcCycR2FGrSHLHZk+GVuVHrAv-8X3=XzUQ@mail.gmail.com>
Message-ID: <CAHk-=wjxQpxK_vOpdcCycR2FGrSHLHZk+GVuVHrAv-8X3=XzUQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 2 Aug 2023 at 11:09, Suren Baghdasaryan <surenb@google.com> wrote:
>
> Ok, IOW the vma would be already locked before mmap() is called...

Yup.

> Just to confirm, you are suggesting to remove vma_start_write() call
> from hfi1_file_mmap() and let vm_flags_reset() generate an assertion
> if it's ever called with an unlocked vma, correct?

Correct.

               Linus

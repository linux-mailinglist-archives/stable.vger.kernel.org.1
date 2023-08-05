Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBA4770C98
	for <lists+stable@lfdr.de>; Sat,  5 Aug 2023 02:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjHEAPB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 20:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjHEAPA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 20:15:00 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCAA4694
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 17:14:59 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso4519530e87.1
        for <stable@vger.kernel.org>; Fri, 04 Aug 2023 17:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691194497; x=1691799297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BOt/owxzUYbRmdYSMwC2b72ailgyx1LyngYZzbpA3ng=;
        b=MF8u79hZkqfIQj1bKlqAfcw+UQ/BjtTo66egFuiPnkVR9Kysz/98+FJKraaklpJQHj
         79f6ExYtvBzJmQf8j0iqQTHPzQPWEGuC+p60EbGtvMIAFYJcjooc34ylQ53jWEv4a8iS
         7naqDeTti+w+vfBweyCdRCmw9m6yVNMT1++W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691194497; x=1691799297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOt/owxzUYbRmdYSMwC2b72ailgyx1LyngYZzbpA3ng=;
        b=KpHAOy2shYO6Udjcw48eKwWvNb2ptt/sA4g4k3isIwJmYAqPzK449fKURYdy0oqVZF
         UqeNxW3r6LHJkgoQzn9SQBu34WYbYC66+Ce/uof8n7cp++uljdldfnzzqUBnM5pQvtbv
         4oLEoDyqB/S14RbJ+MpsjbVQHrh+RpS3sNnk5ddrsnN9boyDkDTBQ1PWAcQQRTMNMMZC
         OHwwUCS6LmqusuSfDPyDZbDuUb6FczYhISkZFfU84DPDFEOlYg+YVnSGFap9Y8o7i10t
         AWYsO81vcpJXmGyCsp3CLPwLxiUNZ/VtsUr0sHIk6MYQ5MwCAGxiKF+zzfGEGEYytTE6
         OBcw==
X-Gm-Message-State: AOJu0Yy7eENn0NPKtUz+JmfSzj5fwHMLuijJqlnG23wKweMspYEG5Zc6
        cvFdc7JH+csg1H/XewMtoVVaYJQCWTtIq4bLT/msbVRy
X-Google-Smtp-Source: AGHT+IGDmmfcMfBXvtN/jG+NvdUrxR87vS09CBmz95KSACJEWZ0ChxJBZU3NqTNI7USI5xfBIm5Fpg==
X-Received: by 2002:a05:6512:2097:b0:4f8:5ede:d447 with SMTP id t23-20020a056512209700b004f85eded447mr2128381lfr.28.1691194497407;
        Fri, 04 Aug 2023 17:14:57 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id w13-20020a05651204cd00b004fdfd79e732sm557943lfq.289.2023.08.04.17.14.55
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 17:14:56 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso4519507e87.1
        for <stable@vger.kernel.org>; Fri, 04 Aug 2023 17:14:55 -0700 (PDT)
X-Received: by 2002:a05:6512:74e:b0:4fb:ca59:42d7 with SMTP id
 c14-20020a056512074e00b004fbca5942d7mr2051745lfs.33.1691194495615; Fri, 04
 Aug 2023 17:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
 <20230804214620.btgwhsszsd7rh6nf@f> <CAHk-=wiy125k1dBmQFTGpHwiOqEyrD6xnd4xKWfe97H_HodgDA@mail.gmail.com>
 <CAGudoHFsAU_BDCOuz8UgDBLGEM8xg=aUGjaVoqkM_Zvxo2Re_g@mail.gmail.com>
In-Reply-To: <CAGudoHFsAU_BDCOuz8UgDBLGEM8xg=aUGjaVoqkM_Zvxo2Re_g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Aug 2023 17:14:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiG9xaVvBJXHqTxtop0=mW9KxPS9C54ED23p59VNEKdWg@mail.gmail.com>
Message-ID: <CAHk-=wiG9xaVvBJXHqTxtop0=mW9KxPS9C54ED23p59VNEKdWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        regressions@leemhuis.info, bagasdotme@gmail.com,
        jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 4 Aug 2023 at 16:25, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I know of these guys, I think they are excluded as is -- they go
> through access_remote_vm, starting with:
>         if (mmap_read_lock_killable(mm))
>                 return 0;
>
> while dup_mmap already write locks the parent's mm.

Oh, you're only worried about vma_start_write()?

That's a non-issue. It doesn't take the lock normally, since it starts off with

        if (__is_vma_write_locked(vma, &mm_lock_seq))
                return;

which catches on the lock sequence number already being set.

So no extra locking there.

Well, technically there's extra locking because the code stupidly
doesn't initialize new vma allocations to the right sequence number,
but that was talked about here:

    https://lore.kernel.org/all/CAHk-=wiCrWAoEesBuoGoqqufvesicbGp3cX0LyKgEvsFaZNpDA@mail.gmail.com/

and it's a separate issue.

          Linus

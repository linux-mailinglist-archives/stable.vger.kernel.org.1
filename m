Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1017E7C6C10
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 13:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378229AbjJLLP2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 07:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378223AbjJLLPZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 07:15:25 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FC1B7
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 04:15:20 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so370126276.0
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 04:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697109320; x=1697714120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y911gpikiKBoVvk2OZa8oqIqP+/8W07F+urby0JQ3ZM=;
        b=X+3Je67IoP8WDkBg9T8C+ZQ+oii8wzOe+uDykVttTCFi1z2Acyf5R4Doc3Jo3lIaoK
         HqVUg5ZHPYIMOVWWnisdKIOuqlmKkvyF5vXJNhwyaF/f56oX4qkfylChDpHQmEpWQmwS
         6Qea5aiLl2pVXGOJVXbdZlNd4wc3n/N9Boz6l5i2YrEBtP8GqIwvqUK3WT278jR84Ppg
         g4aUzSddXLp3VI3M8gXYCesZgijC/9PU9lDOh6bur8MF107Ou2KKWVEXDcZge0AJmgjw
         ANiixgiTMQLiyp74lAhMYUeR5bRqrZUs/+Kdyui1AfrItMRVdxtOgXl5RLCWe6gVzsky
         I44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697109320; x=1697714120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y911gpikiKBoVvk2OZa8oqIqP+/8W07F+urby0JQ3ZM=;
        b=xCNSJeulrf6J7LXnwmR5MLe+1ecVE6KuCnxB8aTVy9BQia+BYi9AKbCeb4lVYX1LIS
         kr1i32QTaaTWmXHjr41AujMUxOYELBquabNiMlTFGBc1ld7LXMpLXZOsPSrq6opatdIq
         WJhmoSJ1RKp8pt2aOMcHkHiakHmDLGgQEIdgOHohxAjDm5kg/sHmMtJLN/s486Gr3fV7
         LLIhDLrMd7/CGUzOj80AQbVmY4MLRioV8wzyHnV2gDrU6m/xHL2taqTLaalUvvhMBkid
         RD8wKDSJ4e3BZmPpRB97ZwtqEhtluO9v3rkl1//IpvoOCRnV9E98Zo9mT1PyJQZL+OUR
         k2OA==
X-Gm-Message-State: AOJu0YwCYnTesi47qrBHQ6XUbP3iO0pX3A8DcFqu1HO3DpZ5Wef/Gb1q
        aIJ/JsHy8zN6hFHP4ds30Iiw6VHfnxEcBumo02Lf1t4CL9VjJr62p/z3tQ==
X-Google-Smtp-Source: AGHT+IGwIVeL7SRBtlxvksOhSK/PxqvkdWCx0W3SClEzqBWTGW1/iYOKoNkd6XXItp5p4xedKezhtXUmr+6UZipsZ9o=
X-Received: by 2002:a25:ef4a:0:b0:d9a:be04:7faf with SMTP id
 w10-20020a25ef4a000000b00d9abe047fafmr1804514ybm.9.1697109319751; Thu, 12 Oct
 2023 04:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <2023101238-greasily-reiterate-aafc@gregkh> <CAG_fn=X-dnc06r0Yik24jBaL-f7ZzrUQiUJmMHeN9CaSa3ZveQ@mail.gmail.com>
 <2023101201-grasp-smartly-2085@gregkh> <2023101241-old-germinate-7a05@gregkh>
In-Reply-To: <2023101241-old-germinate-7a05@gregkh>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 12 Oct 2023 13:14:39 +0200
Message-ID: <CAG_fn=W0cRThcNzE3G7bu5VqwOddTp_uqup3k7tZSMqM2te0_w@mail.gmail.com>
Subject: Re: [PATCH] lib/test_meminit: fix off-by-one error in test_pages()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        Xiaoke Wang <xkernel.wang@foxmail.com>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 12, 2023 at 12:37=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 12, 2023 at 12:26:58PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Oct 12, 2023 at 10:40:14AM +0200, Alexander Potapenko wrote:
> > > On Thu, Oct 12, 2023 at 10:17=E2=80=AFAM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > In commit efb78fa86e95 ("lib/test_meminit: allocate pages up to ord=
er
> > > > MAX_ORDER"), the loop for testing pages is set to "<=3D MAX_ORDER" =
which
> > > > causes crashes in systems when run.  Fix this to "< MAX_ORDER" to f=
ix
> > > > the test to work properly.
> > >
> > > What are the crashes you are seeing? Are those OOMs?
> >
> > They are WARN_ON() triggers.  They are burried in the Android build
> > system, let me see if I can uncover them.
> >
> > > IIUC it should be valid to allocate with MAX_ORDER.
> >
> > "should", but I no longer get runtime warnings with this patch applied,
> > so something is wrong :)

I think I know what's going on. In March 2023 Kirill changed the
semantics of MAX_ORDER to be inclusive: now alloc_pages() accepts
0..MAX_ORDER, whereas previously it was 0..MAX_ORDER-1:
https://github.com/torvalds/linux/commit/23baf831a32c04f9a968812511540b1b3e=
648bf5
Older kernel versions had an explicit check for order >=3D MAX_ORDER,
which is what you're seeing on Android.

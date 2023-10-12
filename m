Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FBE7C6888
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjJLIlA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 04:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjJLIk5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 04:40:57 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D347E0
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 01:40:55 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7b6043d0bbeso295105241.1
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 01:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697100054; x=1697704854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=femz9eG5LNJZtFUuzEiCEtauGuhCTJpV+a0qgb0KnWw=;
        b=RBT+tBddq13pTdBRR50pJhhB7ySCVMWmxJidwh5QRyOCTOjzDmEoa1RK4AdIKme0x4
         i0wO6x5ZMDVc1k6CtLz0b4y2qIx1XqEMLMEseIdhy/OpqVVYXMUqD+t8Qg8NFA2Z8ITR
         uekrVfkK9RBWKdT3i/9oSgx4jbmdb71gveKqcEd7vK+fIjExhTcUSQo9kyVfoxhMLqml
         W6+7d+HP5t9TTcNkeeKUaLsYWRy+Y9tP3iHN9nYsLMKR2GFDhpfGYFJ/wqQhuYWNAG8c
         M7FDFE1FaKC1/5i6560qlNvfGVJYARLrVTYMwplVr28o49Q3b2EUnF/NoddHIzH6LRDT
         h37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697100054; x=1697704854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=femz9eG5LNJZtFUuzEiCEtauGuhCTJpV+a0qgb0KnWw=;
        b=k2i09lJKXbZ6Be4o9m6vWtgWhpjnsxJh0eUEuR+0eBitsLfrEz8rdOw5TEpWexM4Ts
         hc+Xp1gSubJ2BxMeqarJ7h2UJGh2CRxY5/XUS8DjBZ3kACI5kvpb0prT1D15hhL96vAp
         Ks6IBkDYDOY85Wvy2l1UJziuH27eyzQVZnDvUmuah3n8O1WwC857q58LVrTaiRiXM5wn
         YqsRsr6rhChLV+YCjJgdt8ZYqnU8ZF9toYdEv/1JUKUIA7j1T2DzQtsitXgkVYL7gQe7
         zDNL8XQrBwqu2wOKu6WRZpNk4JLY2wWjTlBtPjMsEUt3kymrYYMZWdViyix63xsYj5Zv
         zZ6A==
X-Gm-Message-State: AOJu0YzOse7LbNQ9YRmOeRbZXFcVvrQuigDXqyH1tW3hiqX69mTUEUVZ
        RWIToeFrItZAnJ1WU1QfzgYTAomHigrkgeXCXF4qeKQqInRINWDCOO42YA==
X-Google-Smtp-Source: AGHT+IF5HdRDvsLLKMWrZikqgNLttIk4NNP7dPPin92vPMCIo7Njn8zDFag0yNoFMuoOhqU2ZvFabR5dbmfqJmjniYo=
X-Received: by 2002:a1f:c7c5:0:b0:4a1:a334:57f0 with SMTP id
 x188-20020a1fc7c5000000b004a1a33457f0mr5588679vkf.3.1697100053947; Thu, 12
 Oct 2023 01:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <2023101238-greasily-reiterate-aafc@gregkh>
In-Reply-To: <2023101238-greasily-reiterate-aafc@gregkh>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 12 Oct 2023 10:40:14 +0200
Message-ID: <CAG_fn=X-dnc06r0Yik24jBaL-f7ZzrUQiUJmMHeN9CaSa3ZveQ@mail.gmail.com>
Subject: Re: [PATCH] lib/test_meminit: fix off-by-one error in test_pages()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        Xiaoke Wang <xkernel.wang@foxmail.com>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 12, 2023 at 10:17=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> In commit efb78fa86e95 ("lib/test_meminit: allocate pages up to order
> MAX_ORDER"), the loop for testing pages is set to "<=3D MAX_ORDER" which
> causes crashes in systems when run.  Fix this to "< MAX_ORDER" to fix
> the test to work properly.

What are the crashes you are seeing? Are those OOMs?
IIUC it should be valid to allocate with MAX_ORDER.

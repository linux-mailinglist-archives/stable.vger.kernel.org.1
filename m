Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D17B75FADF
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 17:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjGXPf4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 11:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjGXPfz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 11:35:55 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A779CF
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 08:35:54 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a5ad21a1f9so887738b6e.2
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1690212953; x=1690817753;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oKZv/rBmUS8jYpb20v0bLOMjZtXNWMA7dW9EuTAoCFk=;
        b=kXfW6CLF0OSdXza+/b10cNHYYi7dagRWPLZb23nfItK9QmOO0FcMPU1H66eUvcqi5m
         bVsNXcfUT4MsQ6YXPWMS+dUmtY8E8GTiNz5KEBVJZMIF3LF/ruzurtduAsbiDsowpTGP
         2d/VlfNHqamUE4ayamTMkT/jzy39DAKXe0idnmfQ8OhhqCRYoI8CQNDMtO2QY57bHYDb
         RQ26AYVeyU+meLr02jrmMkgcpae0j3wVXw5OEriXC4X5Mz46RTCz+KAAWauCYacpIh0y
         iHZe1DrQRBC9GJT8z2t89iuj1ihdutxQUec4Hqi4y1stF472GRok/pziJAu7mjqljp1T
         FJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690212953; x=1690817753;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKZv/rBmUS8jYpb20v0bLOMjZtXNWMA7dW9EuTAoCFk=;
        b=bT+5vB2U/Xep0ygXm3ZG5VVXZRMtKIs8KK3z3A49UsM+0pOcFgAZx/1TtBZslgfkF9
         oMPFyO/K7AnPZUJhur0VhRlICw7jTejkN8IjhRc51EqypEngJvKzbyU0bkMTgU+Kefq6
         YPw5HsEuxax/1gUpK1A1osh6X+Mm8p2DgAyS8wBoNo//0Yv+Dip59rTcWqi/9B3tHHlZ
         FwCxgtYJsWpC14oeYFC0KdiKvzfi3MnBVUs/UOer4xTUUbxA0keBNjPHHmhnTlMYDVv9
         ar/Kh2v99/uGDCNplVVj3woXR8L9i2EeMtbiNb59GFXrROOd3nODYX2F6S11BYGhZPGW
         Q13g==
X-Gm-Message-State: ABy/qLa0OXQzuyMTOvEusbEFkDtWMUJehgSJxEYiozB9XEiJXt5/RUSV
        9uq+JoyoXhu2wegWxYCk5Q/L4AAxX5jipRwkqNCaZQ==
X-Google-Smtp-Source: APBJJlFC27Fs2FQEX6/uDWYX3uVjauBNtGtTmosdOo0LpcFraWNWeDabeLTKObjIMXvb/cfgKzxEeXkoh90w1rflBig=
X-Received: by 2002:a05:6808:f01:b0:398:34da:daad with SMTP id
 m1-20020a0568080f0100b0039834dadaadmr13502844oiw.51.1690212953373; Mon, 24
 Jul 2023 08:35:53 -0700 (PDT)
MIME-Version: 1.0
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Mon, 24 Jul 2023 16:35:43 +0100
Message-ID: <CAMEGJJ2RxopfNQ7GNLhr7X9=bHXKo+G5OOe0LUq=+UgLXsv1Xg@mail.gmail.com>
Subject: Re: [PATCH] io_uring: Use io_schedule* in cqring wait
To:     axboe@kernel.dk
Cc:     andres@anarazel.de, asml.silence@gmail.com, david@fromorbit.com,
        hch@lst.de, io-uring@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-xfs@vger.kernel.org,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Andres,

With this commit applied to the 6.1 and later kernels (others not
tested) the iowait time ("wa" field in top) in an ARM64 build running
on a 4 core CPU (a Raspberry Pi 4 B) increases to 25%, as if one core
is permanently blocked on I/O. The change can be observed after
installing mariadb-server (no configuration or use is required). After
reverting just this commit, "wa" drops to zero again.

I can believe that this change hasn't negatively affected performance,
but the result is misleading. I also think it's pushing the boundaries
of what a back-port to stable should do.

Phil

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8FA79303A
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 22:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbjIEUrE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 16:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjIEUrD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 16:47:03 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9939F13E
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 13:46:59 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-637aaaf27f1so7792266d6.0
        for <stable@vger.kernel.org>; Tue, 05 Sep 2023 13:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693946818; x=1694551618; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIZBuQpyPprPjp9AfQ0F6YmgpoYVN/9B/52W/QXvI5s=;
        b=TiwiYymovqXIBgxvXkwS+l/eD+4jFYB3BdD6ylMO4uMtdhLyuutHBf4dz/j5znSAuT
         c4CFH4+k20zLDs7DnhNBSfFgAn9VJchP7V8QQ7vLeUGPqZ6yMKGGwraP9Hxru4F9bZBx
         vhqhhuREGYhP6EAIpzxVQkQcObo/3o0LuiSWgF+JE+jN+ucmlcZu/8pKgi0gqe+OMv22
         JoTIVL+WN8CrqgJtP4BSJmigChaoFnEk8mJ4M6WjnbhAvWJWVdKQGsXcVaPotsH6VOBi
         pumBaAqfTdq6onW89VCYDbHgcw5C61eLEjfzHV7izC9J9TwYFgz0L29icpfoVq1K/jW8
         R9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693946818; x=1694551618;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIZBuQpyPprPjp9AfQ0F6YmgpoYVN/9B/52W/QXvI5s=;
        b=UQfMRaOi2cazZyxWGWRouMWs9pfQwrt5U2cwa9hVuR5bVfM3mSAL9NJmL1+GloCUUN
         nWDIx2Q0VOKo7e8MAvRYIXis/urtQ3yxCnexP+sLbQ+NCoSX2r/9fQarfnU0dGTilEGB
         rea+FXfldkHsX1dKmvcPVYWaODP6LYmpCgS6g8vxElY56eGK87im1V+eG4Izu6aB2/K1
         +9bscr5p7gC7pAD/njMvIp3SM7/9UAbE7x9ugxyhJr6fh3bYTrPs8qGk0y+HXn6spjgK
         M2vq0ByVkshDyufYmithmf1cqVIZstGMAr+rr2NpRP5HtLIF2FgXyMZQc3DncISMOTKN
         bDbw==
X-Gm-Message-State: AOJu0YzfolvCjqlieZpsfwwJWKNwFQ8rGYJWL1xBxPq569cnwAx1ecpf
        EKqpB1jqHLxX4SjsOuZGOxyWi+xHgPkQysEZ/0Q=
X-Google-Smtp-Source: AGHT+IHAWQoz7bYjap8+myiC9y1w4slJaGvRmWX+n5yEUpFaJVDazYAbHY7m//v0SRRBrHJ7bkEx8hAldNTvcF85rbA=
X-Received: by 2002:a05:6214:21c5:b0:63d:2a0b:3f91 with SMTP id
 d5-20020a05621421c500b0063d2a0b3f91mr16022597qvh.2.1693946818422; Tue, 05 Sep
 2023 13:46:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9a4d:0:b0:64f:3ff1:1bed with HTTP; Tue, 5 Sep 2023
 13:46:58 -0700 (PDT)
Reply-To: reggiiehilll@gmail.com
From:   Reggie Hill <williamseakorah@gmail.com>
Date:   Tue, 5 Sep 2023 21:46:58 +0100
Message-ID: <CAGEvky9iwfPKKVAmAqOrr9Aqgh7LB-QXEDatTjSw5eqyyrWC9Q@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Kindly get back to me for a mutual benefit transaction. I will
appreciate hearing from you

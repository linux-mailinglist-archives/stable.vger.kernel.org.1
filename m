Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6170E75FD02
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 19:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjGXRSm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjGXRSm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 13:18:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8471E76
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 10:18:40 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e619bcbf9so6063604a12.3
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690219119; x=1690823919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DiNAxv3soP8tI6jAe+qdKnlb59allXFrqv0MoTTkWTw=;
        b=ei9K9FUeso3fQEu1rxYQ9wFS/n1cP1OeYbkHkyW+wbmNLY69VrTc59I0urkLUnc+0z
         /DLbhefW1MEN1/gWnoSAsevTImNejbUZt8GFZWMcVv6YhkC3UqNgp1IKEEZiMpgXIfDN
         C9NcPZMLDb40FVoSY2JX54KtBWnYtF8QHBQWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690219119; x=1690823919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiNAxv3soP8tI6jAe+qdKnlb59allXFrqv0MoTTkWTw=;
        b=BTRmNoRFbWfKRnXRWVAlaOcOv+dD/9cIaYecHIBO3WUSGJCL0u02IfcM7IR5be7VNu
         23DP5xWDRWzDIU+z7A4YCTNLi6sUEcr2aAy2/b7B+rkKFbBH/KHpbjzNpRoTUjYp1PCS
         i9p0ohk+RtLcBj2f5cI96iukuM7pSjHX5Z3Oc8FVjLoROnMKgHi5KQFPqQM398nINfLS
         rRp+UyzX/BuDoSDIWsy+aZdVXrWrbPFkEq+Z+AttjWu1lM8CArpaZn673Vb9OCzqPLDA
         DweO4USU0Go/wpHv/eRO6vzDkYmf/8xIXlWBaNe9NtGPIOiljAKF1HxW2mj+5JaRYMP9
         JYgg==
X-Gm-Message-State: ABy/qLZ2iHCi78OkIOszv32gy8nW7ToGy3DB6QbnlpVOEuUqHZjBMG3o
        NZVlhxYpX+72bomfxd+SQuz6TwIrulfUYaviMLW+hg==
X-Google-Smtp-Source: APBJJlG5Qa38mmukyPHKYGClfMf/EY/iauvuzWIbS39MpQBcXw93xDL0L5MRoZpyq+y2gTq+Y5mfZg==
X-Received: by 2002:aa7:cf06:0:b0:521:ae63:ee63 with SMTP id a6-20020aa7cf06000000b00521ae63ee63mr8132857edy.16.1690219119365;
        Mon, 24 Jul 2023 10:18:39 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id v8-20020aa7d808000000b00521d1c34b23sm6394736edq.83.2023.07.24.10.18.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 10:18:38 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so6067012a12.2
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 10:18:38 -0700 (PDT)
X-Received: by 2002:aa7:d311:0:b0:522:3a37:a45f with SMTP id
 p17-20020aa7d311000000b005223a37a45fmr1623875edq.21.1690219118168; Mon, 24
 Jul 2023 10:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-pyjama-papier-9e4cdf5359cb@brauner> <CAHk-=wj2XZqex6kzz7SbdVHwP9fFoOvHSzHj--0KuxyrVO+3-w@mail.gmail.com>
In-Reply-To: <CAHk-=wj2XZqex6kzz7SbdVHwP9fFoOvHSzHj--0KuxyrVO+3-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Jul 2023 10:18:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjiL6dgqD4CFUkrxqkTw+Fp7dsfuRkPQLL_M5VymtD6Vw@mail.gmail.com>
Message-ID: <CAHk-=wjiL6dgqD4CFUkrxqkTw+Fp7dsfuRkPQLL_M5VymtD6Vw@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
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

On Mon, 24 Jul 2023 at 09:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Maybe it doesn't matter. Obviously it can't have contention, and your
> patch in that sense is pretty benign.
>
> But locking is just fundamentally expensive in the first place, and it
> annoys me that I never realized that pidfd_getfd() did that thing that
> I knew was broken for /proc.

I've applied the patch, with a much pruned commit message, and just a
link to your original email instead.

                  Linus

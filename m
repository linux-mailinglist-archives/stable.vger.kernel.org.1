Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93C9771196
	for <lists+stable@lfdr.de>; Sat,  5 Aug 2023 20:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjHESsH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 5 Aug 2023 14:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjHESsH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 5 Aug 2023 14:48:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F01EA7
        for <stable@vger.kernel.org>; Sat,  5 Aug 2023 11:48:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so5364342e87.0
        for <stable@vger.kernel.org>; Sat, 05 Aug 2023 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691261283; x=1691866083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aE3aVUFZz0Pt4+RHGO5Pm733Go7Y9ttkQg+3JtB4S4o=;
        b=KEMzk5v0Oh3tsnT/i0nIJU1gJAbdCtKX4OnuVdxyS27fy+0jUaRg5wLjFeL92No1aG
         wQ3JWr+1sRao10tnYYjWT3ikwT5IRaTcjjR1o177iT5+erd1ivEa5MGcFJ/FXXPdbLeR
         BetMoVCkMoOEWW2vqoN9IhdYkUTz8XROJ/lHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691261283; x=1691866083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aE3aVUFZz0Pt4+RHGO5Pm733Go7Y9ttkQg+3JtB4S4o=;
        b=LqXDFvgHC/dTNmhVmslQq0vXSsn+HnEK9xzX/E9h+x/ZhmKa3wtyhWu2oN5bJq4Hsg
         AkiFgAY5sBN7IOHexWZ6zMxP/w1/TF8EGpwVlOkhudfB2WXHCP5N04fDagBQZRHAbqY9
         KOpGa0rr9jRoy5ujX4SdX1KNvZAH1i0awomFifDc8IEoYrOdtcjqK4RnpctKBC0aFrGn
         +NZ2I1nYYwySy4y4169dLWkEHaCl+tZd4Bj2nq51gHuk3zRyQAnQWf83k0D29TNdDGll
         Xsy4kUrSAWQz27HEliBNoJtccQDYWu2tnwILsNufA0ThjPL0GcXslnuASt1wX76/gZkh
         6zDQ==
X-Gm-Message-State: AOJu0YxwTsiiMXjRhb8/XDZDIaX6XOsG7J/i316DR+pnh/GPqPZw6sxd
        sMMAmK5YNTHAiBJ9ftP9gS+pvJyVyMUpcBq+yw/ZYgmV
X-Google-Smtp-Source: AGHT+IGrfWtiKYVsjN+AaOnet1ATUDAvJ++lrxD9DI8o85sF8Hgj1AYyuA7CtQakwQYU1LlcGH4/jw==
X-Received: by 2002:a19:5f19:0:b0:4fe:279b:7607 with SMTP id t25-20020a195f19000000b004fe279b7607mr3507225lfb.20.1691261283562;
        Sat, 05 Aug 2023 11:48:03 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id u12-20020ac248ac000000b004fe3a8a9a0bsm829571lfg.202.2023.08.05.11.48.02
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 11:48:02 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso50214191fa.1
        for <stable@vger.kernel.org>; Sat, 05 Aug 2023 11:48:02 -0700 (PDT)
X-Received: by 2002:a19:7611:0:b0:4fd:d64f:c0a6 with SMTP id
 c17-20020a197611000000b004fdd64fc0a6mr3262956lff.48.1691261282423; Sat, 05
 Aug 2023 11:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230804-turnverein-helfer-ef07a4d7bbec@brauner> <20230805-furor-angekauft-82e334fc83a3@brauner>
In-Reply-To: <20230805-furor-angekauft-82e334fc83a3@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Aug 2023 11:47:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=witxS+hfdFc+xJVpb9y-cE6vYopkDaZvvk=aXHcv-P5=w@mail.gmail.com>
Message-ID: <CAHk-=witxS+hfdFc+xJVpb9y-cE6vYopkDaZvvk=aXHcv-P5=w@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
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

On Sat, 5 Aug 2023 at 04:47, Christian Brauner <brauner@kernel.org> wrote:
>
> So instead of relying on the inode we could just check f_ops for
> iterate/iterate_shared.

Yes. Except I hate having two of those iterate functions. We should
have gotten rid of them absolutely years ago.

You shamed me into fixing that.

          Linus

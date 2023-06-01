Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BF771F165
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 20:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjFASKw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 14:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjFASKv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 14:10:51 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EE018C
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 11:10:49 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bacf685150cso1222809276.3
        for <stable@vger.kernel.org>; Thu, 01 Jun 2023 11:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685643049; x=1688235049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6l2jcIFuzndjiTSV9rfNM+wFyrCDOkojMdFnO1wMCQ=;
        b=goM+dXwUiuSaOtDBFH3U9tHfoJqxDvvjHH7sFLQic594s30f3u+O8NEXruD51hm7sB
         d9EBA5xoGWYIB0oYnDTRZS8WNdJFDhyFY6BxYfck0TLxrBdmbNU1rTMbhvg3cX/pNaa0
         GRjsOUCcMdCtceLrdhEj4e621wUCikG1rmThGdclpXY5hqlKecvAhLFJ9VjjhLRsgIwB
         R4vyFSPyOOJ2aqHWEsO5KOmfFAr0mblC2TwDvzy/UItAB4vRqVcBvCBK+9v1lmr3gl2V
         Xl1ttH/gWNXo8w+Arbh32VrlePbutmpVtqfyYBerWvcG95tDJpG6NFK5eXJFIOdJiH4M
         BA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685643049; x=1688235049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6l2jcIFuzndjiTSV9rfNM+wFyrCDOkojMdFnO1wMCQ=;
        b=R/a7mBjh4/QUYWzf2rZ3/K5zl3ISEIxR7HcCPAZVp3V24ZgynCV02DLK4kA6CG9T1i
         cZWAfRGQa1Ncuc/dPZJkmYYqFjcS8IL+pWcVj/+Q7yJLdgnJLezhOruvWbzY59yArReY
         ByhN3DDUsyLJoCGc2cutPeVVm5HiB0tERzlUQntD2pfCx5veGHLCvRh/Mr9g2qYCV0Nq
         UCW2Ttja09DnB7ekrE6/t/oLkzfTCGYf4yBcHiS1mNatlsmgK+S2Z1/D4IxbAVcifHcN
         nMWWdEtkxclwK8v7yMF1kIFJZyuoD0zK8yFPHxdAc+NFmX70+CKVJ8eYss37h1jPUvyz
         LDzg==
X-Gm-Message-State: AC+VfDyZl/yttCPWw7vVd2Cb/yETt13kRN4YpcJWfiqUv8Dy1yfUsaaZ
        b/Unfpi6kiLS6usmnkuWfrcQ2hBTuokBMrwIFqKK
X-Google-Smtp-Source: ACHHUZ45xk2Dcsb/S4DQ5gvqZl6ChXfbD2VeC1PLSni4vxZSxAbXAsXLgFdLHEy2iaT/UivEVWKhTueZgUj6ooKN2Hs=
X-Received: by 2002:a81:9e14:0:b0:561:429e:acd2 with SMTP id
 m20-20020a819e14000000b00561429eacd2mr10954002ywj.35.1685643048983; Thu, 01
 Jun 2023 11:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
 <CAHC9VhTmKbQFx-7UtZgg8D+-vtFOar0dMqULYccWQ2x7zJqT-Q@mail.gmail.com>
 <bb1e18f8-9d31-1ec7-d69a-2d1f5af31310@amazon.com> <CAHC9VhTFzN_Y_7HBroJnbTHL2NZEYjFy9BB3JJJBKnwv_k25dw@mail.gmail.com>
 <d2b14172-7aeb-be98-ded2-b4ce255dccaf@amazon.com> <2023060120-monopoly-math-3bc5@gregkh>
In-Reply-To: <2023060120-monopoly-math-3bc5@gregkh>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Jun 2023 14:10:38 -0400
Message-ID: <CAHC9VhTdZ=-Tmi=nPzKFHRoiE+oWNFWrXr=oG70fti9HNCgrWQ@mail.gmail.com>
Subject: Re: Possible build time regression affecting stable kernels
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Luiz Capitulino <luizcap@amazon.com>, sashal@kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 1, 2023 at 1:05=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
> On Thu, Jun 01, 2023 at 11:50:16AM -0400, Luiz Capitulino wrote:
> > On 2023-06-01 11:45, Paul Moore wrote:

...

> > > I don't want to block on fixing the kernel build while I keep chasing
> > > some esoteric build behavior so I'm just going to revert the patch
> > > with a note to revisit this when we require make >=3D 4.3.
> > >
> > > Regardless, thanks for the report and the help testing, expect a
> > > patch/revert shortly ...
> >
> > Thank you Paul, I really appreciate your fast response. I'd also
> > appreciate if you CC me in the revert patch so that I don't loose
> > track of it.
>
> And please add a cc: stable@ to it too :)

Done, and done.  I just sent the patch so give it a few minutes if you
haven't seen it yet.  I'll leave it for a few hours in case anyone can
give it a test build before I send it up to Linus.

--=20
paul-moore.com

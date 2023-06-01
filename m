Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F1871A11B
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 16:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjFAO4i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 10:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjFAO4i (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 10:56:38 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E49018F
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 07:56:36 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ba81f71dfefso993429276.0
        for <stable@vger.kernel.org>; Thu, 01 Jun 2023 07:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685631395; x=1688223395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/qJ+uqkhR6Y+gpkBUfGs83848bf5sFD0hNA+Fi8YNc=;
        b=CwwY1nYxlw4D1lZbwSqtobYgsFChICPWXUVbzTtgfLd8TQ3UeAg6HCcZrG1YVZg4cJ
         drIHcPOmNgIVnc0NIA6RjpF0MTUEb/qN6Je0R8yeB+tQBsOR/yg222dg6xybn6oZTbWh
         wkmWyYASD8RM8fGLhg/lI8Kn9wR3rKFaNVkSVmzXS6DWAXrQ6Q8yUbrB9P/mNfWLVZyj
         FzFyS/w81omM46nWvZ7RZezG6e7QlCB9nbdhyh1SCXUP+R6CilSUj4HSrssXCkzR+rL9
         p9avkzQdiy3jEGU9mTyPWHsQ2MF9t4EczH49TUriPRFX/zwQUJUsZnfb5EQotGhr9ojU
         go5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631395; x=1688223395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/qJ+uqkhR6Y+gpkBUfGs83848bf5sFD0hNA+Fi8YNc=;
        b=eAoljU2u3VZGv3yGfBWBG2ipO+o/pE1NXPN3Fv+FXt61FVAXHiW+rjNVLpFBldI3hI
         qt+bYXXh6xdjsXRvjSscxZhEqH1VL1Fm+CjiX2yCgw6V8gmkY+zY07FISA8yZ6ckBxzT
         HwAX86S+v5PxdWaE75Tbsgex6LvoYRAyY3U9XBiArSNRQIKwgGZV9z/F9jwbKXF+HRVw
         V9bSriVn2lYpb5TA2YYDB73bq8y2i4vRj84/D9KJM6TgfqlCAN7/HGG/s5N3gYaciVDa
         sBkb0RJQElFBcE87Tc/2jrTY6Op2QKjdFrXB8mQbVfLRjwoI5Cuszos0WzE7D0SWVdqz
         6UJg==
X-Gm-Message-State: AC+VfDykUWnlrmu60VsKzkJ1eNG8rCJ1OITLB//ZBeXTf+YI98OB1ZDw
        2D2pPzMx1TSVFVWjUCIQlRGxABPYW6Yj6740N87D
X-Google-Smtp-Source: ACHHUZ5HGUKq/ohiMxRqgqhnaYAt5OGoyb6NAVYveB65uZ9oSr6+FPkG3H3dXaG+amsKMVSJ9GPxKctmcQtcAyEohR4=
X-Received: by 2002:a81:5217:0:b0:561:d21d:8ce3 with SMTP id
 g23-20020a815217000000b00561d21d8ce3mr10062828ywb.3.1685631395543; Thu, 01
 Jun 2023 07:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
 <2023060156-precision-prorate-ce46@gregkh> <20259cf7-d50d-4eca-482b-3a89cc94df7b@amazon.com>
 <2023060148-levers-freight-5b11@gregkh>
In-Reply-To: <2023060148-levers-freight-5b11@gregkh>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Jun 2023 10:56:24 -0400
Message-ID: <CAHC9VhQ6W4hq3B122BxcrD6h6_-Q1AguFYYLjAbB6ALCbmzDoQ@mail.gmail.com>
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

On Thu, Jun 1, 2023 at 9:20=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
> On Thu, Jun 01, 2023 at 09:13:21AM -0400, Luiz Capitulino wrote:

...

> > Yes. I'm reporting this here because I'm more concerned with -stable ke=
rnels since
> > they're more likely to be running on older user-space.
>
> Yeah, we are bug-compatible!  :)

While I really don't want to go back into the old arguments about what
does, and does not, get backported to -stable, I do want to ask if
there is some way to signal to the -stable maintainers that a patch
should not be backported?  Anything coming from the LSM, SELinux, or
audit trees that I believe should be backported is explicitly marked
with a stable@vger CC, as documented in stable-kernel-rules.rst,
however it is generally my experience that patches with a 'Fixes:' tag
are generally pulled into the -stable releases as well.

I could start dropping the 'Fixes:' tag from non-stable tagged
commits, but that's a step backwards in my opinion.

I could start replying to every -stable backport email notice, but
that seems like a lot of unnecessary work for something that was never
marked for -stable in the first place.  I'm guessing it would also add
some additional management/testing burden to the -stable folks as
well.

--
paul-moore.com

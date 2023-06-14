Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1FB72F7BB
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243439AbjFNIYW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243452AbjFNIYS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 04:24:18 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A26CA
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 01:24:15 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bd5f59fb71dso433860276.3
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 01:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686731055; x=1689323055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmxrYYgO090N0quqU8Zir/MR9T+5qqVRSNHL5BET6QE=;
        b=u8Zm2d/xrBZlWAPeKti+YmyFmi1blCKu7MxNRmgIC+ZRuFCxR/kr35WQAXtEpEdzlx
         gUN1W+Jvo7kBmvyy5n5MdQWxqr1c3BMDqp3LRAvQkLqOLBq8E3rOENDtT294c3opyic3
         2hRu1e1cVpXvwz8T4Os4kfbSUrivUcWDyU7XmSZYnXzZWO3j1rCY6ckYuDv9P4EsgT6V
         ELL+w3JZg7O/VKBAT9r0KMWFlb2K5ooCV0A43YnV4ExVZb9LHEnwxnF7EqV7hbuT9vbr
         sUWIQgmHbJuTczpJpLvWYBiZe8S8t62/bQG7BwJ6orNTGbJOlwtjblT7f6pB/eMbqbUG
         PhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686731055; x=1689323055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmxrYYgO090N0quqU8Zir/MR9T+5qqVRSNHL5BET6QE=;
        b=S5X5ockpm8hj8jhhakS4r+yn6djA+PSQTlFS/hksn+zVce/28dB2oopSvRp52qZY8l
         LAfmkiiFxHb6EQD4zk0e4oVGPCFt8jiyv8sAV6xFXe12a/K2WELVibDFvKcFVmaHW8gn
         o79Pc/zocuIuLiFH/pHtKx4OAs0NU/iVC6EwgFFzIzcMRdCasGusezfflfcoYTWBwH3f
         SKb2KJjQBdEMgvxsX6lpxoDa/delOy+VorYcsprqyXTHyZKbjU/ausRWXEhA5mB9Eo/8
         RaHwoiTFg2Q0e54iawd2B0WuIsZ/+MI9gGY8tmkCt3n8mlCOJG2AgmBsZWf/nEc+kyRn
         KdJg==
X-Gm-Message-State: AC+VfDz2VFNKxLOeGQRfT+Ihupzm7LVSKaAYDLEo7ISfzbYxwk0jIozJ
        wo9D+rwHRwkME6CjxUylh5YX4W541A0j0pKnHYp1dA==
X-Google-Smtp-Source: ACHHUZ4eWgDFgxqRFaloRBccOZ5sNdUKgStnj6PgUQ3FPqkMpuHTkCJNNHZ0lWqYRY9ONIBJlh0oieBdgVwd0o4u+t8=
X-Received: by 2002:a25:b096:0:b0:bac:69be:9494 with SMTP id
 f22-20020a25b096000000b00bac69be9494mr1759609ybj.36.1686731054806; Wed, 14
 Jun 2023 01:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230613213150.908462-1-linus.walleij@linaro.org> <9c1c00a5-0360-09ae-56fe-4431632f0302@disroot.org>
In-Reply-To: <9c1c00a5-0360-09ae-56fe-4431632f0302@disroot.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Jun 2023 10:24:03 +0200
Message-ID: <CACRpkdZz55B-dF3+sGGmkMtTMLTcUbmFmk9aajPPV=u0=igZYg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: ab8500: Set typing and props
To:     Stefan Hansson <newbyte@disroot.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 14, 2023 at 9:54=E2=80=AFAM Stefan Hansson <newbyte@disroot.org=
> wrote:
> On 2023-06-13 23:31, Linus Walleij wrote:

> > I had the following weird phenomena on a mobile phone: while
> > the capacity in /sys/class/power_supply/ab8500_fg/capacity
> > would reflect the actual charge and capacity of the battery,
> > only 1/3 of the value was shown on the battery status
> > indicator and warnings for low battery appeared.
> >
> > It turns out that utemp, the Freedesktop temperature daemon,
> > will average all the power supplies of type "battery" in
> > /sys/class/power_supply/* if there is more than one battery.
>
> I assume you meant to say UPower rather than utemp here?

Yeah of course. Maybe Sebastian can fix with a bit of
git commit --amend when applying?

Thanks!

Yours,
Linus Walleij

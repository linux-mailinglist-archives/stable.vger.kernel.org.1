Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFD8779762
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 20:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjHKSzh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 14:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbjHKSzh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 14:55:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B3A30CF
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 11:55:36 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so3704990e87.3
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 11:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691780135; x=1692384935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uuRnK69MU6Lcim2KwchdBtj06ixdIXcvFeb8SD9Pua0=;
        b=bevpvsPX4n5ismYz2JRzJu3RxtNmuz61zrOXwgrXa4rs6IMeUV8CWTvkBCunEuZUVD
         EaIyx4/QXJzEiuBJ9Has3ZXHwuiPuduUzPaVKbnpOeunmDsNMao0rE2+NVH98dkurQax
         je2nblq7WDYb8HO7/BgOlgz88FjsDBATEjxuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691780135; x=1692384935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuRnK69MU6Lcim2KwchdBtj06ixdIXcvFeb8SD9Pua0=;
        b=V9T5m7LyOEBKDkpTSOnnYg3qlKDmGIz3rzmlumaR/Jn88XbLN9gWTvNoqu4vaa4TH9
         NPIIoH7XcYfzM4PbeFXajY6smlKb2efoppcriOG8SJytdAX59Blvy7Zt7xp4O54BeuAr
         eqDyaxtyXm5c6reZ++9xKQUJzvjTR9YRtyNkXMAa7/MMfiNuR5z7diyujN3zsUwLnYcX
         XwRz+tQncTgZiF44Pi6y1hTHe70Xhc/j5dU4M7ZTDGwnkS6G+qNgWM7idm1/9+dl0b8I
         n8R1SSuup10lppmtuyd4YZJSo7NBc96m+XeJdc0B6uOth0luvuVcF4TE7aBbabseNNOv
         QENg==
X-Gm-Message-State: AOJu0Yz3e4QPR7fqr8fHqRXcOgD4k1aWeKHelC9pwT5o2eAUDeQ1MesQ
        BG88S1YFft8l9K0SF1+08Cvy6sVptyTpOoKG0MaR7VPx
X-Google-Smtp-Source: AGHT+IEUPKMkDbCZD3lTIEl17MlRJ3OAKQUHp2NTG3wl28LWqTbc01x5Av8BrIaJFnzcKzsky4XYLg==
X-Received: by 2002:a05:6512:2027:b0:4fd:c715:5667 with SMTP id s7-20020a056512202700b004fdc7155667mr1690210lfs.20.1691780134920;
        Fri, 11 Aug 2023 11:55:34 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id x30-20020ac259de000000b004fbb69d8791sm813774lfn.79.2023.08.11.11.55.33
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 11:55:33 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso3733826e87.0
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 11:55:33 -0700 (PDT)
X-Received: by 2002:a05:6512:10cd:b0:4fd:fef8:7a81 with SMTP id
 k13-20020a05651210cd00b004fdfef87a81mr2309540lfg.55.1691780133463; Fri, 11
 Aug 2023 11:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230710133836.4367-1-mail@eworm.de> <20230710142916.18162-1-mail@eworm.de>
 <20230710231315.4ef54679@leda.eworm.net> <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
 <bb5580e93d244400c3330d7091bf64868aa2053f.camel@gmail.com>
 <0f272843a33a1706dbcbb2d84b02e3951ee60cbb.camel@kernel.org>
 <fdd5fd9ece045ebd1888672a75f157e64ade98fb.camel@gmail.com>
 <a588d1d3-12e0-b078-b6cc-b0a63c54ab37@leemhuis.info> <CUPW0XP1RFXI.162GZ78E46TBJ@suppilovahvero>
In-Reply-To: <CUPW0XP1RFXI.162GZ78E46TBJ@suppilovahvero>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Aug 2023 11:55:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRVp4h8uWOX1YO+Y99+44u4s=XxMK4v00B6F1mOfqPLg@mail.gmail.com>
Message-ID: <CAHk-=whRVp4h8uWOX1YO+Y99+44u4s=XxMK4v00B6F1mOfqPLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christian Hesse <mail@eworm.de>, stable@vger.kernel.org,
        roubro1991@gmail.com, Grundik <ggrundik@gmail.com>,
        Christian Hesse <list@eworm.de>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 11 Aug 2023 at 10:22, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> I was planning to send a PR to Linus with a quirk for MSI GS66 Stealth
> 11UG, and apparently this bug report would add two additional MSI
> entries. This is becoming quickly a maintenance hell.

Honestly, what would be the immediate effects of just not enabling the
TPM irq by default at all, and making it an explicit opt-in?

When a common solution is to just disable the TPM in the BIOS
entirely, and the end result is a working system, I really get the
teeling that this is all pain for very very little gain.

Would anybody even notice if we just disabled it by default and added
a "if you really want it, use 'tpm=irq' kernel command line"?

Hmm?

             Linus

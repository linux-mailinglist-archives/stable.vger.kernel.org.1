Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCD276C82D
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 10:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjHBIQF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 04:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjHBIQE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 04:16:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCDD19F
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 01:16:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe1344b707so10455152e87.1
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 01:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690964161; x=1691568961;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1XKoPsX4UORhornaX2uleS8Riwv7Wf5fxSpfuXgQDg=;
        b=bSPZ7yq66wj72cC1huv59PJSPMCMW0dzLNUr9gtAgTH716mcEjiGsA7MSHGy7BeEPa
         TmP3PIn3t30vy99dEr+yicUF/73mKAoNzZMeMCfL8cSi178AN1CXbTtRauv7ULdWFZrz
         LmA2Of7N0X2j4qGi1vfqwWJwLeBmYpTILy4sy82Ue7W6amK4JhJcp1CiEjP4HCwL7kSZ
         h2ur3EDYTpROkntjwxuBGCMSCQ/pnaVUZFFJ76hzsFeAoz+HktTv4UC5H9mPUSLS25EK
         JY65jXjNAIiC2on+tt1rSyw3c9HpYJYiehZvCNZkVsKbb8zHK4jgj5WHo7EyDGirgas2
         ih5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690964161; x=1691568961;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1XKoPsX4UORhornaX2uleS8Riwv7Wf5fxSpfuXgQDg=;
        b=GD5YgBpQeJYQjDLMPrXDz3d5GdbszOuOqypEe5S8Wf2hWE/28ARb3s0d0VUXO/opjL
         B+5SNxKKQMP1d8FKzN66U4xm5PgY+2fwjif8Ujp2D5aMo2X0fGZilW6+9dgSxN5Js47e
         ACgRevOvWVuK90MAZRjK1ophm54AdSEeJZ82VnBQp1/q1gUbh7CYNHMh9KU/Sk00SZgq
         FFjyH3J2FV84A0xvTlENDsu5UAwLcAL5VMMHi7Wz9Jtv23FJ/5o/ZxOXP8FNzlTSgkqM
         XnUkgac+0prwBwv7IfBlx6AlA/oTJwFn2A3RL1uK3IRZSDg7yMJqjAitZscGhMdb9iaA
         nj5A==
X-Gm-Message-State: ABy/qLaJBsDnjthRIUWfC8O2rANWKdNaNbunfn7DIJlToGIMDyY1wvLx
        uRITycd+rYCgfICNDKufgVA/l7k+lLsnz6rJDj8=
X-Google-Smtp-Source: APBJJlG/YxjoODCy9ypi3OF65XEByNJ855BHvG5T7TdSod2dOKX/4abZA9xLKadj3kKvf9eUn6ltsNTh974Qu0vpuUE=
X-Received: by 2002:a19:e612:0:b0:4fe:788:d969 with SMTP id
 d18-20020a19e612000000b004fe0788d969mr3849360lfh.69.1690964160962; Wed, 02
 Aug 2023 01:16:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:7814:0:b0:239:e92:2871 with HTTP; Wed, 2 Aug 2023
 01:16:00 -0700 (PDT)
Reply-To: carolynclarke214@gmail.com
From:   Carolyn Clarke <crftpedals@gmail.com>
Date:   Wed, 2 Aug 2023 10:16:00 +0200
Message-ID: <CAGoVmOr3F5GQdgn+Xxu90WMn8-hBzYSqeK6Sf+PBksgQi-SMxw@mail.gmail.com>
Subject: Re:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Good day,

Kindly reply back urgently if this email is the most effective way to
communicate with you, I've a proposal that is in your name,

Carolyn Clarke.

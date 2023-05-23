Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5730C70E4B9
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 20:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjEWScF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 14:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjEWScE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 14:32:04 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A258F
        for <stable@vger.kernel.org>; Tue, 23 May 2023 11:32:01 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-561f24bad98so62967b3.0
        for <stable@vger.kernel.org>; Tue, 23 May 2023 11:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684866720; x=1687458720;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :references:in-reply-to:reply-to:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sHiBDrRFYmb0/XOzThudIlGCis55XYc3s6LextevjWU=;
        b=AqTtEm/0a9m1spEMFCwi74QIpXtVtGHC05dPZ//ajZQYLMFNBebwBegbVvSu8fA/8Z
         +tZzwLSQXzd7wvwylCKWG5oEC70pBNVXPLKj3DBe0ICW1IxBh+iEKUDTTv9VbeeQhCpH
         vSGxtipvdbRvgFqmlX6bkC4nLBqrZXBKofEWeuf29UU6TXCL7PnJ5uMhmxD/LKDpJLTd
         6U7cJCqWJJYinpLDLJId/J37NbzTxNf5RnYS/qZbMFt5oyXVj8IUIph1tNDXIRBn23Hs
         NYWmhmotCW2a4FuvjEH7y7vP6b65t0lExIn62eki9zEBj3HWXN0oqN+n+hkPXcmzu+9w
         2Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684866720; x=1687458720;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :references:in-reply-to:reply-to:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHiBDrRFYmb0/XOzThudIlGCis55XYc3s6LextevjWU=;
        b=lLnWjGbL02Kk7CFE946flqxQF4FWYIvA3Gk5clAP/5lXNp11ovEsXKTtrPeN+IyBDA
         kgrm/dD4MwB9FKyipw2y9XLndic6Jv4ghqZSBsKE/wYRHcyYDtldQXdJLOEYE71Xnsip
         BcCLXcvf838aWJmtzbijU93Zp9hGOXWYG62BjtObW3taajebqwxJMfr2WouB4OgDcjZc
         xrY7zIyki3v6mEBg+dIKpeGLq92ePityWD8Pe6coDvfgZ1Gi49vwKaKGNw40bxIjSU+7
         e2i+m8Z9Y1bEunUO4UP0GlJRzQ0JirSj/6IAbdNmzOE+cloraw0jhhzgc8PW4T+uge+d
         MJyw==
X-Gm-Message-State: AC+VfDwd7k6TBujV2qGADABIyNb/MpZKY8x9dksYHGv/S01+0Lau7gxj
        vEETfqsH/JwTlQp2nPPHH+kD5ySoFO+HnyeIxJM=
X-Google-Smtp-Source: ACHHUZ6LqdFTkRakrHzvtNs/LU1HDAiIzQkqQLDmuC1nSAiqviUu6dT0kcaxJTPkvhP/fgN/JWAE2mxDGXLsEfb7qKQ=
X-Received: by 2002:a81:9a16:0:b0:565:5228:44f7 with SMTP id
 r22-20020a819a16000000b00565522844f7mr1996830ywg.4.1684866720125; Tue, 23 May
 2023 11:32:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:8da3:b0:348:6866:1f2f with HTTP; Tue, 23 May 2023
 11:31:59 -0700 (PDT)
Reply-To: Adba.hassan@outlook.com
In-Reply-To: <CAA-bSKLrGQZjcrMmn-A_rMvif62KB31s+HGf-x7Sc6cWtPtUMQ@mail.gmail.com>
References: <CAA-bSKKO2Jqosi1X79qzxuNGMiALTY-T49sOE-9ioxan=Dr3SA@mail.gmail.com>
 <CAA-bSKLrGQZjcrMmn-A_rMvif62KB31s+HGf-x7Sc6cWtPtUMQ@mail.gmail.com>
From:   Adba Hassan <johnsonrite1975@gmail.com>
Date:   Tue, 23 May 2023 18:31:59 +0000
Message-ID: <CAA-bSK+v=AOZMRGrEGYgTV_1fh5rsy5kYo_iJd7rcPY5DqnrSw@mail.gmail.com>
Subject: Re
To:     johnsonrite1975@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greetings, to you do you get the money I compensate you GBP =C2=A3500,000.0=
0

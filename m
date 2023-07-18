Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653C7757B09
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 13:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjGRL6N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 07:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjGRL6M (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 07:58:12 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED361A5
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 04:58:11 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e56749750so7640645a12.0
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 04:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689681489; x=1692273489;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGXGG+/u1X/FI5XU0kGUcX5x1MApZuJ2kl53gs1mNiY=;
        b=RJCMVucZ0FEBRdI+7Llj7CcgABZkGhZWlYymj2rwCWl8hlfT9NHkZUTMcV5xtTnrwb
         xjdsmOlH1f76v/F/60KnJ/B9uVVgRQl8aDwD2YXSuOUFpPDLfh5wRoH2tGtJU11H/BVh
         /2VS6J64YNYRUlFqXe8JciBhNd5P6AiGSFiwtewXhGYBAmS8rsmP2tTwGwwnBA++WcLJ
         b4LGcauWLpwIiwhFQrlHaxCHTqCg/prDF/TWRe9kDq6iSupOWOpj+euPisGNLusK8nlZ
         rCm4go5Y8gslzBmxjX9rzI4PFvvzEsmbBZEeG/62eAQ27n/An8eUpwoRIDDPclNGaXQ3
         v3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689681489; x=1692273489;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGXGG+/u1X/FI5XU0kGUcX5x1MApZuJ2kl53gs1mNiY=;
        b=R93dgIO3+1HrrkiklogtVimI275LnxH20o8bhUyInMz0CX0hdNfUYRSI6LkTLNbYfl
         HBSCq5d0MeNLvD+Y4Y5bTR7T1kNWvfgvelYzqaADA7FGmT7CUk+uzFjgdFblQy7xj9fx
         QSlCfcGriLkTR7yR0zKwpnmNsjPKFjqY0eS0Ryk70fyez55UYJDSYHp52b6XiABcc6Mq
         LUtIjjav1GZ3N7bEHKrOhzQyswZmnoFGp6k744nwbT5lt/Ev2TGadPtN1uVLeiAlXqsq
         U3pKNw1KPqq8BRfNHaqoukcyDyDj3KEM//XK/C+QuWGAPlwwQLk5TABTEfOpaUd+QBIB
         bB7w==
X-Gm-Message-State: ABy/qLYaTQDudhfSF2NwNknYLQD8kXy8WBv6ysqnEkrDtfmQ2XaXUWKT
        NRIX03WbVLOmK6MEv9Xf9p12O1U6yWxHcWVT+t32b+tGkks=
X-Google-Smtp-Source: APBJJlEsdqfUczL6RrcMgNQpKtgha+gCMSzNVMplvPcnPgvk01aSv3b1lnXuMBj85EqGNfRv+UJL1p2EPB0E0vTGDro=
X-Received: by 2002:a2e:7213:0:b0:2b6:df25:1ab0 with SMTP id
 n19-20020a2e7213000000b002b6df251ab0mr14027092ljc.34.1689681469002; Tue, 18
 Jul 2023 04:57:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:640c:f85:b0:1cb:bc8e:538d with HTTP; Tue, 18 Jul 2023
 04:57:48 -0700 (PDT)
Reply-To: rosellinthomas@gmail.com
From:   Rosella Thomas <joycethomasj5@gmail.com>
Date:   Tue, 18 Jul 2023 04:57:48 -0700
Message-ID: <CAG1cWb6nB1amR5oigaN55TOgK79HeXTTBDnfcNpQZxSFDzLOeQ@mail.gmail.com>
Subject: please Very Important Issue
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2a00:1450:4864:20:0:0:0:52c listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7087]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [joycethomasj5[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [joycethomasj5[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello Dear
Good morning and how are you doing with your family today, please I am
still waiting to hear from you please so that we can move ahead.
Regards,
Ms Rosella Thomas.

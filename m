Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335E0739EAF
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 12:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjFVKlY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 06:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjFVKlX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 06:41:23 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFB31739
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 03:41:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f64fb05a8aso9595063e87.0
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 03:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687430480; x=1690022480;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlQW24sCbG4fJqRr7+xqRWh0zzGQ8N1utKQv/d1ktPY=;
        b=aebUCOV69rj/JhcUzAldkSUo+AmAe9Ppsvf68AsIKX9Uoqf0qogv5Hd03mG4Imk0l1
         /4gzQ7C6IJki4tfp1N/l+xbPzKtO45rwh8TDOjZkuhQ1sttaFD84AzrOq3GGs8ywSf5Z
         80e/vbo4stQSlOaLaEnrwkTX4Qs3VYhuKehB39JgzX1Ubv/+wjUPKrsEhysPjAmd0HsX
         V7iSLgiF7JxCcHoDPdSt61RSu73rqU7+NRFKCIW6s/DnCPjevi0NnYvR9xe8H/zi8eRS
         EjmpjSMw+1HtsLsjLxa95HG2iA/azMl5NtizSn8eMluVLE13AP+rJAt2FAtv4WjGQAxL
         6lIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687430480; x=1690022480;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RlQW24sCbG4fJqRr7+xqRWh0zzGQ8N1utKQv/d1ktPY=;
        b=cJ+gOAyTEef1KPDU/SnoIUUZLhGoen5OBzUi3C6qP/1hfYbbMqETqlSdx5X2BR/X22
         y3bs524Px1RbAXIKchHHwDjeVLCJu05JPyHzVTowTgYdMtjEPU8N4JG8vmoARIXZJUJT
         U6p70BhLTfwuRD40Ep8TaHDtOtW6EH8LRYn6pvBFXonW8iKaG1aeb7Hz/msQ0FPLco/W
         WB/WM3bgdqRpl8lIZFKkQ6xUWbANbfuKa5sIIuENaO5rULifMrkvC7WosKj2cfSboTzy
         MwhPRPtXIO8zmci+Dp0MlLShaiEvM7Nx4Q9ySQnvK5ebUJCObl+jEX8hqMyNz6Rofnu4
         M3bw==
X-Gm-Message-State: AC+VfDwFydys2N7r1JLcOolbOTwlAG3x6q8Ny+eT5E8lUQJknqFGD/Ed
        in4Id4KDf5NV8oneJTJH9/PrJRn67bOTShYi6Uw=
X-Google-Smtp-Source: ACHHUZ4qPpGkRz6mhoYBnKO4CGW6J/XUW2DNqUFUcCoDOprvkTlGKoY9kniu0xP9pizxzVU5sVLH2Q8HefxKrPK/uQE=
X-Received: by 2002:a05:6512:31c8:b0:4f9:5d34:44b1 with SMTP id
 j8-20020a05651231c800b004f95d3444b1mr3540281lfe.2.1687430480049; Thu, 22 Jun
 2023 03:41:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:834e:b0:52:a723:1c10 with HTTP; Thu, 22 Jun 2023
 03:41:19 -0700 (PDT)
Reply-To: qyh.nguyen@inbox.lv
From:   Quynh Nguyen <anrothdgnyers@gmail.com>
Date:   Thu, 22 Jun 2023 10:41:19 +0000
Message-ID: <CANDNYShmc6QXMc0mQdpYD_V6oQEU0be3MAd80vU2qqVQwWHwqg@mail.gmail.com>
Subject: Greetings..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:129 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [anrothdgnyers[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.5 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

-- 
Greetings,

My name is Quynh Nguyen, I'm an Asian woman, 67 years old from Ho Chi Minh
based in Europe and currently writing this message to you from my sick bed.
I'm a businesswoman who deal in raw cotton exportation and currently
suffering from ovarian cancer; I'm critically ill at the hospital and don't
know if I will survive due to the information from the doctors, for this
reason I decided to send this message out to seek assistance to fulfill a
wish.
I would like to have an important discussion with you concerning the sum of
8.5 million Euros to be used for charity projects, 30% of this money will
be yours for accepting to receive the money and carry out the project as
stated.

When I receive your reply, I will give you more details.

Kindly write back soon for your quick reply is very important due to my
health condition.

Quynh Nguyen

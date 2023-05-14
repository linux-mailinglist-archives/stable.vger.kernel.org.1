Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1558701DA8
	for <lists+stable@lfdr.de>; Sun, 14 May 2023 15:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjENNzu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 14 May 2023 09:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENNzt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 14 May 2023 09:55:49 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AF119AC
        for <stable@vger.kernel.org>; Sun, 14 May 2023 06:55:48 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ad89c7a84fso95702501fa.2
        for <stable@vger.kernel.org>; Sun, 14 May 2023 06:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684072546; x=1686664546;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvlUHM+AeT0nrl6pi6zSHWypFX8amZHiNpAMdt9We3s=;
        b=g+a6Gglr5aZUU6m2fZMILI8JWrgdnLZhKnu7T4vf3lePX/G5plwLLCcEspxKYMSkcy
         ueGaq71cXZhvTbQ/Wja7qIJxSBRhHkGpF5KpwsaK1TadaUwRYtionStpIFdMqbri9Ba9
         +RkkhrQb/RCyxyA5yyBLxQ47oFn9SpvTMbMLHaU7E11NFHObWuZ8ay+rE94Un3RmaMRH
         YklJCAA8jUZhbhp7TWAP/3tiT8CdoLPHkKkSUhdDi/jfSr48ZB39hQPchXzAvSWWuWpq
         CpTBuh3Pt+jwFi8a3xE1R/5tqdE8oo7j01/poFv9M9ykTTNYE4gJ1OkHXMDrb1WBuwf9
         HkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684072546; x=1686664546;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvlUHM+AeT0nrl6pi6zSHWypFX8amZHiNpAMdt9We3s=;
        b=Qy4JbHTwq6AJ0ltK6/t8X69VyNnlEDFvUdkcTqKC/10/uuXlMEDx5nxD0kQQ44IBn/
         BwtBJLvdyC2TmvSNRzM/9eWKyGC1fhswFxbO7/fHqHIPvD0p8TIHimFBobg6j+YMhgkn
         xiaPjWPLwMCNmdLqSByNPITYthwZOd7mtli6nSCD5Ib4l/hGpa8hbnHtJqgtr8l4C9vo
         XE4L/vmF0HR9aN/MPukOvGgaFb51ulraFd1OQaI/r7sYVFCMjKXOUGN7q+Jvx0YPj1n6
         BbK+ylG/X3r4vERJ2JPQP8QBJrho7cTJfpG0XeYu9wzSMNJEhNdM4ewNbwwdSWdFMz+p
         Acdw==
X-Gm-Message-State: AC+VfDyR9Z30mC3MZkU3GM8wjDOzs/zFkliLozPtxUdArk3osLTLjlgc
        sTXGi8qj7a4b1dkvUAUF47n+SXGCldfRVwdoxFY=
X-Google-Smtp-Source: ACHHUZ4L+2AjEYQCeSJCfEkufiMQv5B5DXHC8SmKAGi0bs1h5ryRtj0CBZwSXReR61wPwurzR0lVsy6sGJRBEZEiSP8=
X-Received: by 2002:a2e:3c05:0:b0:2ad:d9bd:1d2 with SMTP id
 j5-20020a2e3c05000000b002add9bd01d2mr1997788lja.16.1684072546251; Sun, 14 May
 2023 06:55:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:67ea:0:b0:228:a49e:83bd with HTTP; Sun, 14 May 2023
 06:55:45 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   wormer Amos <johnjohnmore2022@gmail.com>
Date:   Sun, 14 May 2023 14:55:45 +0100
Message-ID: <CAJ-8a6jcgot5TjpX=D-uf9wXFe21d-WjX1=TU2FGfrBwXGQ56Q@mail.gmail.com>
Subject: PROJECT IDEA?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:234 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [johnjohnmore2022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [johnjohnmore2022[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Good Day. please i want to know if you're capable for business investment
project in
your country because i
need a serious business partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email below.

Thanks and awaiting for your quick response,

Amos!!

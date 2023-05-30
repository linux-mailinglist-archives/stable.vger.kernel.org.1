Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58D6715F0E
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 14:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjE3MWf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 08:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjE3MWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 08:22:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D4111B
        for <stable@vger.kernel.org>; Tue, 30 May 2023 05:22:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b00ffb4186so28075205ad.0
        for <stable@vger.kernel.org>; Tue, 30 May 2023 05:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685449326; x=1688041326;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp3BxLWAgiAOYmXPwY9NoluFwvcU1D66jZiJDUh8lSo=;
        b=Lyemnf6mb/BDMIezF7meHPgy0EzC+Qf2rRa8jzkvjtpP4dnxWG3dhapI5Ego6Fz6na
         ZTYfd+Jb6PIap01rCQLKTUZLO0SDwoo/oWH3gMvGj5uKwOg4dtRYfjPppDXG00yhxKAM
         7W61yLZsHZW+uxkXvRTBe6bVevFPqASth50DDJffD3Q8Kr5EIyVYCNIqIvZ2QdusZ4+y
         Rv70tLbcsMjxsjxIbyIOnAU7o7lYRGrDnnaR1U/VHVLWisY5DZ+B+l4BMmmv5+EqyZzH
         /MFE9zhaGHKCX/0qUauRurXdn4elD2IrRTzE9xjXdk3bSVOc8jNj1ubz4hHPv8GE1CZm
         sQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449326; x=1688041326;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rp3BxLWAgiAOYmXPwY9NoluFwvcU1D66jZiJDUh8lSo=;
        b=OyKW1agdd2o95x1Io7E2cKZzmr4qTV/dyOGzzZwxjNiKJpPdgF3HfqX2zrD4LcBHI3
         dwQHWWJi0zv3aZ4/oS+eIJ2sFkiA9VD1JCVvWWEFAdSAPvwR/AK2jf/npcqTrTDWUYGz
         AqYYYNqGxdH5PALLbeLA9Jksl9RWlgnLYC/1JcpnqSnq98KTmTFTFtm8pavbdesA0Rcn
         x8/DgFHa8pEATbzOw/a8EDoKU6t2rFHdOf/qd3YagWySbTnaFyDp2AgXmQOMjNFxfvcu
         m4LMDpuX+IKEJMtpJ0Pmry8R2+C2YrjkPuXv92PkXeqPvwp+nUoymgGCltkHPnFE+rxe
         ZoPA==
X-Gm-Message-State: AC+VfDzKP2wGGgQAA0FiRdO0ZVwy7pOQPxtZtoIWGyLmpD++710MP16g
        ZXHoc4ZgiO9EcnHJHdIDnbmax3os+5SV+IWOvCs=
X-Google-Smtp-Source: ACHHUZ5hQ1WZW+u7T//pSRvSgO7w1hFtIyOdidd3bYnXuTa5fSifBM/8ZHI0LXa6LaTe26XMrHxgGRoYT28473rdMIo=
X-Received: by 2002:a17:902:aa09:b0:1ad:edbd:8541 with SMTP id
 be9-20020a170902aa0900b001adedbd8541mr2083421plb.13.1685449325977; Tue, 30
 May 2023 05:22:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:728f:b0:f0:b69:4155 with HTTP; Tue, 30 May 2023
 05:22:05 -0700 (PDT)
Reply-To: petergrace159@gmail.com
From:   kun suu Hui <johhjames4333@gmail.com>
Date:   Tue, 30 May 2023 13:22:05 +0100
Message-ID: <CAJ2gfHEYNV9SByQNbPuwvY9O73X=1b1UFYd_pttTto_N5ocY5w@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:632 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [petergrace159[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [johhjames4333[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [johhjames4333[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Buenos d=C3=ADas querido amigo, por favor, =C2=BFha recibido la compensaci=
=C3=B3n?
dinero que te envi=C3=A9 a trav=C3=A9s de mi secretaria MR. PEDRO RAMOS?

....................................

Good morning dear friend, Please have you received the compensation
money I sent to you through my secretary MR. PETER RAMOS?

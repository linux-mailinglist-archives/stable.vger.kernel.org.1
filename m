Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA9772357B
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 04:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjFFCvM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 22:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjFFCvL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 22:51:11 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92F58F
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 19:51:10 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-565d354b59fso63056407b3.0
        for <stable@vger.kernel.org>; Mon, 05 Jun 2023 19:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686019870; x=1688611870;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l5WgoTOOy3LfvpyQK2mDprd493OAdAU1mq1QegQCXwQ=;
        b=GV5JjTj+6A53qRGbeyMqY0btqQ9bnZfGcDnIju6OM7TLTyQdgIziOFpf8oYIcrUc/R
         FHygE1TK6u8BvUxn3U9Wv0Z3IIbp+yF8OfEG4yi1kRpn8hKBRHXAKb/ZrZ/Lqk3dSs9P
         UQdWZgGSXD3P72ZvDzjw0emCBCDCy6nfq2Z8dH+C+oJM/kCNgR17t0c2Gn9VfT36Omz5
         vYvghiYJcPN/vLnJgUWoPOcYN57ntB8ajG7k4kZdosPPd8BX86GpSuX/B8M9XjwKyLi/
         n7XyKuJfB0N+ClkNL9aacIr8YAKeOkS2/EdN0W8WSkwGipUvFuEf9pzIldw7tFp4xVCo
         hgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686019870; x=1688611870;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5WgoTOOy3LfvpyQK2mDprd493OAdAU1mq1QegQCXwQ=;
        b=lJSZyFMR3o5RNYJman8Ly8FgdDImkjTKqCjMntR0LGGs2ksRcL+jKrZvTHX/zhe6lN
         n9lCe4tAeec3E806zlPw2O0HvWJ+SAGvw6uQWhszMTDicgxypdyq1wgtNqvCF9ElCaHe
         WncimHWmvrd9y8w/morAFQT35SQ3gPbzezKM0G+FfJx7mvaINCWDZ1eaDQ9vDYrb8We+
         FUxshXP/k5f5l2oAgsDBF5MhqhoEkJcUsRwPMR4JWMbZmKFuEpxieqHtAtr0pXjVb+x/
         lp5yVdF+mvPLiu4xlEUzarmeosrRFSxIbNMahFcDQ/TyUiVJT7RQI/x102u42Z6/ED5H
         tl4Q==
X-Gm-Message-State: AC+VfDz1mRFFPxMVrj9nHXCq/YXkRg7cFfr+SUAN+znyhr7HDT3bGO+6
        7CYFrco7MLJDVT6gjohQEZBFzAGyp1M81n6hsmw=
X-Google-Smtp-Source: ACHHUZ4B3szK2OHTjyIo7ay8QA72v4J2QbghrtWIwUDnJuW5cA1LDbzQTC4Luhf74V5TuIy4PLiO6mbxMibmCLEl4lI=
X-Received: by 2002:a81:494f:0:b0:565:df97:4439 with SMTP id
 w76-20020a81494f000000b00565df974439mr492900ywa.37.1686019869551; Mon, 05 Jun
 2023 19:51:09 -0700 (PDT)
MIME-Version: 1.0
Reply-To: michelmrssonia@gmail.com
Sender: jkfltd121@gmail.com
Received: by 2002:a05:7010:330c:b0:357:ee2f:ae12 with HTTP; Mon, 5 Jun 2023
 19:51:08 -0700 (PDT)
From:   Mrs Sonia Michel <michelmrssonia@gmail.com>
Date:   Tue, 6 Jun 2023 03:51:08 +0100
X-Google-Sender-Auth: mxCB-eMMYiMrlN3_j3aKnNTGPzU
Message-ID: <CAFJa1AeCHC8-gRXgecEr0vkKmx0h+VTGV1VPkXKF=j94Mb0svA@mail.gmail.com>
Subject: Happy new week
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.7 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_8,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1141 listed in]
        [list.dnswl.org]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michelmrssonia[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jkfltd121[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.9 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.5 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  1.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

 My Greetings and I need your prayers,

This letter might be a surprise to you, But I believe that you will be
honest to  my final wish. I bring peace and love to you. It is by the
grace of God, I had no choice than to do what is lawful and right in
the sight of God for eternal life and in the sight of man to witness
God's mercy and glory upon met life. My dear, I sent this mail praying
it will find you in a good condition, since I myself am in a very
critical health condition in which I sleep every night without knowing
if I may be alive to see the next day. I am Mrs Sonia Michel, a widow
suffering from a long illness. I have some funds I inherited from my
late husband, the sum of US$ 8.5m (Eight Million Five hundred Thousand
Dollars) my Doctor told me recently that I have serious sickness which
is a cancer problem. What disturbs me most is my stroke sickness.
Having known my condition, I decided to donate this fund to a good
person that will utilize it the way I am going to instruct herein. I
need a very honest and God fearing person  who can claim this money
and use it for Charity works, for orphanages and gives justice and
help to the poor, needy and widows and also build schools for less
privilege that will be named after my late husband if possible and to
promote the word of God and the effort that the house of god is
maintained.

I do not want the bank to sit on the money. I also don't want a
situation where this money will be used in an ungodly manner. That's
why I'm making this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die. Please I want your sincere and
urgent answer to know if you will be able to execute this project, and
I will give you more information on how the fund will be transferred
to your bank account. May the grace, peace, love and the truth in the
Word of God be with you and all those that you love and  care for, I
am waiting for your reply to my email via

Regards,
Mrs Sonia Michel

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C1C723375
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 01:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjFEXCM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 19:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjFEXCL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 19:02:11 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD4583
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 16:02:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-97458c97333so656541766b.2
        for <stable@vger.kernel.org>; Mon, 05 Jun 2023 16:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686006129; x=1688598129;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CX4slVzv4iOtTDndi3AIv4oh1uMBegfcaTKftHIwMaA=;
        b=Pov6yQzFcfJpg9GBS0EqTADuFhwBZ8VKswl1GHC2mMcM0mKhh58rdWLix9QyTKtf79
         QlUFnEe0jQbofdE9gFL+r5oCMaggWOSz7qD9NNtTDS7mCCFBtZAvuPAR6UfMnEJxVWLC
         n607D3UGMty3hitIZhprvjuyM2XKJu95gVSvxl4WqLXPu8EB89Gn6RtgO+ZtEkxI6L6c
         rTn8N7u0wWIv2fsTHX2h1QaruZYJMV5RnVHgCgEE1kVr56++X4lvUQeiAe1YUowQRRsa
         erBi2/3oGJaDKFib5gGFP7+HBr+q8Zs8WsdZs3R0dRiZXPhi6PHB+S/xM/UefS+OB4WB
         W0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686006129; x=1688598129;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CX4slVzv4iOtTDndi3AIv4oh1uMBegfcaTKftHIwMaA=;
        b=EDey1yAE9f2dGJdhkjO7NKwgOqLb9DFNDsBuv0MTu0snoHQWcsfZVZIv6gORuQ6j2s
         RsG3KlE4/W8Eo7qszJkO+nuj+x27N9/e4FbSFnVYEhp9M2J8df5SutnpitEJMgwmaHEg
         puLC3JTYnbT89hTlACwFJ+JQc5cF70PmgTRD6jeMPfTXftRbWQ7JvfAKO5xoIidLgrRL
         qj6JMYQnqFxNYx9R7td0XlSvWNPmOlvLbT5bwHG/Ox+O2CwUhFzFBV5xveQqJWNa+5uA
         DtttF4cY+vlIy6z4frIvGmeQ9IXlR1gswvyQ7oIkaCGuCxNo1C5pOUPLRynXMDeI0rQB
         pBYg==
X-Gm-Message-State: AC+VfDwEjIjTFNV/4Ptz7/uCee5Ox+QSTB8pDHrWPswlTWqV8+bXGtY9
        hR7CUn7cUe1hDPW1ypRkB6iyWKI4lskqIcZNYyc=
X-Google-Smtp-Source: ACHHUZ7CXu/Lw7eXJeNxOdTWVbLTRhWrxl44TxQEAuapxo5HGNDnwN4he6kZcCGeN/9RF6kOzSkIBNJ8mJxsc7YsnSM=
X-Received: by 2002:a17:907:7ba6:b0:968:4d51:800b with SMTP id
 ne38-20020a1709077ba600b009684d51800bmr269567ejc.1.1686006129030; Mon, 05 Jun
 2023 16:02:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:640c:e54:b0:1cd:333b:8e7a with HTTP; Mon, 5 Jun 2023
 16:02:08 -0700 (PDT)
Reply-To: mmaillingwan391@gmail.com
From:   "Mrs Helen Philobrown." <mrshelenr2@gmail.com>
Date:   Tue, 6 Jun 2023 00:02:08 +0100
Message-ID: <CAJ59mN3TNwH_cyQfoYvCxQ4Yrtch9T=4M1xguU12LxU72fcUqQ@mail.gmail.com>
Subject: HI
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FRAUD_8,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY,XFER_LOTSA_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:641 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mmaillingwan391[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrshelenr2[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrshelenr2[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
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
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 XFER_LOTSA_MONEY Transfer a lot of money
        *  0.5 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  1.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--=20
Beloved Greeting,

Please forgive me for stressing you with my predicaments and I sorry
to  approach you through this media it is because it serves the
fastest means of communication. I came across your E-mail from my
personal search and I  decided to contact you believing you will be
honest to fulfill my final wish before I die.

I am Helena , 63 years old, from Philippine, I have been dealing on
Gold exportation for the past fifteen years in West Africa. Am
childless and I am suffering from a pro-long critical cancer, my
doctors confirmed I may not live beyond two months from now as my ill
health has defiled all forms of medical treatment.

Since my days are numbered, I=E2=80=99ve decided willingly to fulfill my
long-time vowel to donate the sum ($5.000.000.00) million dollars. I
need a very honest person who can assist to release this money and use
the funds for charities work of God while you use 50% for yourself.

 I want you to know there are no risk involved, it is 100% hitch free
& safe. If you will be interesting to assist in getting this fund been
released from the security company for charity project to fulfill my
promise before I die please let me know immediately. I will appreciate
your utmost confidentiality as I wait for your reply.

Yours Dying Sister
Madam Helena Philobrown

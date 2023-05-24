Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA0070EC57
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 06:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjEXEDt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 00:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjEXEDs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 00:03:48 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3532E10CA
        for <stable@vger.kernel.org>; Tue, 23 May 2023 21:03:26 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 46e09a7af769-6af70ff2761so151895a34.0
        for <stable@vger.kernel.org>; Tue, 23 May 2023 21:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684901004; x=1687493004;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLnE1viA2YkFQlIS735wdkGePat6D3JreXDWC7/8f9c=;
        b=Pxgebf5ox6ifucfvPjzc+o4/4g+bX7gn4xZh3rbTtjjUwrct9kJql2B0ssxMFZMMTv
         uSDmsbkYx+/urpTR1TQCEh5Yu30f7sQ7z9QZZCGF8vb8scbXelbBCivrj7xHUdA+gc2D
         AVvUHvUXdtfov/3jhKr0rwEVwycjsWqWssNkNB5+wOwWaX0WQNFl0tp7PItGcoNkNExB
         IASCTmA2LRlPk8xLlcuxDpLJzAyJN5xIrzhZEDJAbJ7fs+KUyPPtT4OAlg0K2LaCjlnn
         J3AGxnxTEOVQUzuIPz0WKmyaRAYmSbJcHcPixI3HsivULPLjZIgnxtNqaN6sgBVKhCsq
         UW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684901004; x=1687493004;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLnE1viA2YkFQlIS735wdkGePat6D3JreXDWC7/8f9c=;
        b=VM7L92m7RvAboaUhzhkmmtjGI+XcNyWzhPkF/PpEZjkcyAOH7ZHkiXRxGfLepYkqiZ
         iCnK8p4O+B9w41qvxOBz/zt4oO2X8ltpVArPIc8eRb/ySUWp1boQ4JmM9oJ054PjBCQ8
         iYQ8gMmmcK7hWivQ/PSKHzDLpHmGRdUXnEi73CLgpuP+mrQYyrdjkt7hxYmq+IcRElC4
         bTp/6h5j2w9cM0BL7ZhAEgit+EFnMCp1We7+xIHgktSxuclazBdtK97L2YvtIgNfo9vF
         /v7eHlorK3pWquQFthcbKIwwwdy+rb0x+nQgCkBtPK005BKOZzeXfXJovAnGETQBjfXR
         lQvw==
X-Gm-Message-State: AC+VfDzlaIBR+VW15qmBVMOOTpnwV/CvpeHKulCNZVDCwimxNuPXb+sz
        OyP3oUdHV2rDL19SoIE/j7oDJLYDmuScWvUE8Ow=
X-Google-Smtp-Source: ACHHUZ7DmLRDPW9B9T7MqHa7JI5Wi1SbJZNDpizCh84Z5QCsVl7ESANJro/dFGs9UX5tHiznc885GVm9ptdPTrhRsdA=
X-Received: by 2002:a9d:7dd2:0:b0:6af:8743:daac with SMTP id
 k18-20020a9d7dd2000000b006af8743daacmr2881168otn.36.1684901004101; Tue, 23
 May 2023 21:03:24 -0700 (PDT)
MIME-Version: 1.0
Sender: arryod72@gmail.com
Received: by 2002:a05:6358:8423:b0:121:cdc4:fec4 with HTTP; Tue, 23 May 2023
 21:03:23 -0700 (PDT)
From:   "Mrs. Sayouba Athelah" <sayoubaathelah@gmail.com>
Date:   Tue, 23 May 2023 21:03:23 -0700
X-Google-Sender-Auth: 1aSfSOFahaZ2M_3nQMoPbT3IkSs
Message-ID: <CADS+2b5kQktB3Ds=nN0pLxPxv3o6qZBBRUDE+n+ca5E-9TS-Eg@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,
        MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:342 listed in]
        [list.dnswl.org]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [arryod72[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sayoubaathelah[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dear God's Select

I am writing this mail to you with heavy tears In my eyes and great sorrow
in my heart, My Name is Mrs Athelah Sayouba, I am from Tunisia and I am
contacting you from a hospital in Burkina Faso. I want to tell you this
because I don't have any other option than to tell you as I was touched to
open up to you. I married Mr. Sayouba Brown who worked with the Tunisia
Ambassador in Burkina Faso for fifteen years before he died in 2016. We
were married for eleven years without a child.

He died after a brief illness that lasted for only three days. Since his
death I decided not to remarry. When my late husband was alive he deposited
the sum of US$ 8.500.000 million. (Eight Million Five hundred Thousand
Dollars) in a bank in Ouagadougou the capital city of Burkina Faso in west
Africa. Presently this money is still in the bank. He made this money
available for exportation of Gold from Burkina Faso mining.

Recently, my doctor told me that I would not last for the period of seven
months due to blood cancer and hemorrhagic stroke. Having known my
condition I decided to hand this money over to you to take care of the
less-privileged people, you will utilize this money the way I am going to
instruct herein. I want you to take 30 Percent of the total money for your
personal use. While 70% of the money you will use to build an orphanage
home in my late husband's name. And help the poor people in the street. I
grew up as an Orphan and I don't have anybody as my family member, just to
endeavor that the house of God is maintained. I am doing this In regards to
my late husband's wish. This illness has affected me so much. I am just
like a living death.

As soon as I receive your reply. I will give you the contact of the bank in
Burkina Faso and I will also instruct the Bank Manager to issue you an
authority letter that will prove you the present beneficiary of the money
in the bank, that is if you assure me that you will act accordingly as I
Stated herein.

From Mrs. Athelah Sayouba.

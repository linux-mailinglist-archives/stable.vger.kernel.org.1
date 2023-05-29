Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7EC714C13
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 16:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjE2O3Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 10:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjE2O3M (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 10:29:12 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E6AA0
        for <stable@vger.kernel.org>; Mon, 29 May 2023 07:29:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 41be03b00d2f7-53487355877so2088988a12.1
        for <stable@vger.kernel.org>; Mon, 29 May 2023 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685370551; x=1687962551;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGuPs2HAW5Kc9EAlBZmlCe2PoQii+LuASoE3r9n3wKk=;
        b=sF95MoK3Cxd2+SjlQMzCJafBwWTNLH4142RQpZP1+k6GqHR3lXPEjYoCAJO/8EzJVE
         OIZf2Aba8Facr5UtOFvu9kt0rt8H2/EcQK9MILvihG6UiytWAB9n/G0ZYhQincvtGDRr
         IzCvvzxl24OL79fme8xPxlxIrIFSzb7H9XuJJ07sxSkUgYIlsmJQcCOaBFNKCsg99cxo
         x37fA730v0kvl7KCB5awBmLuqXFfaAFVo/fwcgopviJN1+MeIw6sSn3fNlngcmLAGlYI
         SHgitG16f8hbdHPztC6i3rdMjHxUX8B/fgLIoodFgB6pYemjiPVi7Ya4xSEcwXekD1GA
         UXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685370551; x=1687962551;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGuPs2HAW5Kc9EAlBZmlCe2PoQii+LuASoE3r9n3wKk=;
        b=MroJ1AW6ekPL7Kd3AiKV0s0EfadauPqvgB8Gq6FmOgr6JF6ACqQbecrmOMVCBBKYVJ
         bMNDZ1Vp4FS0iSdnjpynzFsGwb5mSqtBOefOnSZrZcrEpkyhcwJVXKQQIktDVXYSGT08
         EFg7ceWdOrWihEAZvSn5P/oFWY/9CfNEmIiXr94nAjeRLR+opw76YIxKGtgqJln4SMQC
         ddWDO2xaDQIZsbcM9IBnYPMXRKv1f3xDL96Kbi5KT6UyuTGfwzQrfRVznfLKIxy6TISj
         1bu5Z4bFsLZ4F3Rm6Y6irIGXHrvUnPvB+lSwBFQ34UZQ7hCKvGTg/Xrl57Ko9c0NP880
         YTOA==
X-Gm-Message-State: AC+VfDxgWCm6PpASjxbDaFBj7sk+BHnTksmU2b805sVMM8zvJ6A0ogwn
        j8qiwb7X37bzNrVVhZXUKTEamZXjWwuwqjOqQuo=
X-Google-Smtp-Source: ACHHUZ43/dHQrVSMcqNQOXm2X00bAAq1rPO3AFn+0KxK0CD5Sv/y5Nc+8fdDblBYx/S2x11ID0lNFLZBD7+NTj8lNCU=
X-Received: by 2002:a17:903:120b:b0:1a6:54ce:4311 with SMTP id
 l11-20020a170903120b00b001a654ce4311mr13103024plh.43.1685370550690; Mon, 29
 May 2023 07:29:10 -0700 (PDT)
MIME-Version: 1.0
Sender: boaheadquatersbf@gmail.com
Received: by 2002:a05:6a10:8f07:b0:4b8:9705:31b8 with HTTP; Mon, 29 May 2023
 07:29:10 -0700 (PDT)
From:   "Mrs. Lenny Tatiana" <mrslenytati44@gmail.com>
Date:   Mon, 29 May 2023 15:29:10 +0100
X-Google-Sender-Auth: 68pXCO3ffLG_rmGU85l9SvOxqXQ
Message-ID: <CADAwBtKLLFUEKh_qT2bGUES8Yhdms-0=RGegYVLhUVR25o7OYw@mail.gmail.com>
Subject: Greetings dear friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        RISK_FREE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:543 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrslenytati44[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 HK_SCAM No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 RISK_FREE No risk!
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greetings dear friend,

Calvary Greetings in the name of the LORD Almighty and Our LORD JESUS
CHRIST the giver of every good thing. Good day and compliments of the
seasons, i know this letter will definitely come to you as a huge
surprise, but I implore you to take the time to go through it
carefully as the decision you make will go off a long way to determine
my future and continued existence. I am Mrs. Lenny Tatiana aging widow
of
57 years old suffering from long time illness.I have some funds I
inherited from my late husband, the sum of (19.2Million Dollars) and I
needed a very honest and God fearing who can withdraw this money then
use the funds for Charity works. I WISH TO GIVE THIS FUNDS TO YOU FOR
CHARITY WORKS. I found your email address from the internet after
honest prayers to the LORD to bring me a helper and i decided to
contact you if you may be willing and interested to handle these trust
funds in good faith before anything happens to me.

I accept this decision because I do not have any child who will
inherit this money after I die. I want your urgent reply to me so that
I will give you the deposit receipt which the SECURITY COMPANY issued
to me as next of kin for immediate transfer of the money to your
account in your country, to start the good work of God, I want you to
use the 25/percent of the total amount to help yourself in doing the
project. I am desperately in keen need of assistance and I have
summoned up courage to contact you for this task, you must not fail me
and the millions of the poor people in our todays WORLD. This is no
stolen money and there are no dangers involved,100% RISK FREE with
full legal proof. Please if you would be able to use the funds for the
Charity works kindly let me know immediately.I will appreciate your
utmost confidentiality and trust in this matter to accomplish my heart
desire, as I don't want anything that will jeopardize my last wish.

Please kindly respond quickly for further details.

best Regards,
Mrs. Lenny Tatiana

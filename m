Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB457727151
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 00:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjFGWNX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 18:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFGWNX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 18:13:23 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51032115
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 15:13:21 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75d4b85b3ccso585688785a.2
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 15:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686176001; x=1688768001;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sY0QFEu3A5QobU/zM9Mm2liDTEjcpZ5YBtL/8PmQ474=;
        b=IzYQXZKELRM4rsJaq3m4dXWr1Vha/Uryoa24PRir6JYAjOGfdp410A/EPbQsswB73k
         sTgB7C6iGWukbDcw+Dt1vjHeJsJh5xplh2mgDFFg+wlF0moj90FYvkOubVGIE4ndYwmk
         HAKvrnx+O5YHGvjs79RGXrHSCWpJbueFjxUh+FNICr4JDm9CHjXHK4ztyBzMWRNITvsY
         8qfCvdVkzpi0UWNvPt4Vz+RqT/Z0k2h8xBmzbqF0qH/b5b/RVBBu50FyIN3t+dc0Ov/M
         OY98cqOP7XcAxdnaQCe/PwMeKHh2dhK94DTw8Fv2kZWDV+a5Kwh3Cq047CSg7HPCgndf
         LckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686176001; x=1688768001;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sY0QFEu3A5QobU/zM9Mm2liDTEjcpZ5YBtL/8PmQ474=;
        b=If7EogfuRaFTqI2KX+oqYR+eYaxx5bAl9HJHjHgfyCdCiNKSj15uQ1K1JKUpEsuTbr
         14UKq7wZ7NhwH/TqmELpuK/D3VsE4S9STnL+hzmFNaNyYaGKB1ap17QaHXQavl/8KZxh
         /Fx/legzKIIuRYz7c+/iJWSN+/ZyBNcsNrm+hCfzyCieOeH8VYJEsPRAnzu+wmfBNvHy
         WnF8hcL0fsfymcBmmLjpwcf8XbwYkuTKQQexB61HxCi8HcW74v7qyxuKhRkB4Oiw19+s
         V0wAB81tYmgnIWWlISEo/DhYabAu9CzYCMR5F+BK7LyiNvIkhmMc5Uguw5DdYW5W1mHD
         WRyQ==
X-Gm-Message-State: AC+VfDyxYgNZcOmIeCNzoeaRps3lS5RGFHjBv9agD/aY9hMsjUWWCu6E
        3m6JRkOZ78ArnW48DgLCV2BIn1i3vAyBXfmz/LA=
X-Google-Smtp-Source: ACHHUZ6PiuZXHQTwa81StUlBKZIeqFlJthm0gCOT5+/dJno/tyFm7GVxjlBWYc9Bnlh81TWCvlInYEmuYdmDHY5yHfM=
X-Received: by 2002:a05:620a:6285:b0:75c:b919:b4e0 with SMTP id
 ov5-20020a05620a628500b0075cb919b4e0mr3420243qkn.25.1686176000756; Wed, 07
 Jun 2023 15:13:20 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mkwesogo@gmail.com
Sender: jitiongu@gmail.com
Received: by 2002:a05:7000:66cd:b0:4c8:3014:62aa with HTTP; Wed, 7 Jun 2023
 15:13:19 -0700 (PDT)
From:   "Mr. Muskwe Sanogo" <sanogokwe@gmail.com>
Date:   Wed, 7 Jun 2023 22:13:19 +0000
X-Google-Sender-Auth: hiV9tTJL7cYSfcmbDFriJ7O8wlo
Message-ID: <CAJRo45g-KJKkQO_HMa6V_Dghj4msXVxKSn1MEKjC=9mTSo_pDQ@mail.gmail.com>
Subject: If you are interested to help without disappointment or breach of
 trust, reply me
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:734 listed in]
        [list.dnswl.org]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jitiongu[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  1.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greetings and articulate salutations, I bestow upon you a
serendipitous and euphoric afternoon.

With due respect to your personality and much sincerity of this
purpose, I make this contact with you believing that you can be of
great assistance to me. I'm Mr. Muskwe Sanogo,  I'm the Chairman of
FOREIGN PAYMENTS CONTRACT AWARD COMMITTEE and also I currently hold
the post of Internal Audit Manager of our bank, Please see this as a
confidential message and do not reveal it to another person because
it=E2=80=99s a top secret.

It may surprise you to receive this letter from me, since there has
been no previous correspondence between us.  I will also like to make
it clear here that l know that the internet has been grossly abused by
criminal minded people making it difficult for people with genuine
intention to correspond and exchange views without skepticism.

We are imposition to reclaim and inherit the sum of US $(28,850,000
Million ) without any trouble, from a dormant account which remains
unclaimed since 10 years the owner died. This is a U.S Dollars account
and the beneficiary died without trace of his family to claim the
fund.

Upon my personal audit investigation into the details of the account,
I find out that the deceased is a foreigner, which makes it possible
for you as a foreigner no matter your country to lay claim on the
balance as the Foreign Business Partner or Extended Relative to the
deceased, provided you are not from here.

Your integrity and trustworthiness will make us succeed without any
risk. Please if you think that the amount is too much to be
transferred into your account, you have the right to ask our bank to
transfer the fund into your account bit by bit after approval or you
double the account. Once this fund is transferred into your account,
we will share the fund accordingly. 45%, for you, 45%, for me, 5%, had
been mapped out for the expense made in this transaction, 5% as a free
will donation to charity and motherless babies homes in both our
countries as sign of breakthrough and more blessings.


If you are interested to help without disappointment or breach of
trust, reply me, so that I will guide you on the proper banking
guidelines to follow for the claim. After the transfer, I will fly to
your country for sharing of funds according to our agreement.

Assurance: Note that this transaction will never in any way harm or
foiled your good post or reputation in your country, because
everything will follow legal process.

I am looking forward to hear from you soonest.
Yours faithfully,
Mr. Muskwe Sanogo

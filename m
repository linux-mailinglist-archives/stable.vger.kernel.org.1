Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7AF7B15EB
	for <lists+stable@lfdr.de>; Thu, 28 Sep 2023 10:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjI1IVq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 04:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI1IVq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 04:21:46 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2D295
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 01:21:44 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so30033944a12.1
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695889302; x=1696494102; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGuPs2HAW5Kc9EAlBZmlCe2PoQii+LuASoE3r9n3wKk=;
        b=OgumJO5YR6QaHDp3cpDAlWeI3rsT5cS2EdVl/PKJ7oBCApSmHPzOdUqbnK64d+kviE
         lXApmmMovJsYgU0wm0c/TlBfXmpFC/fzOt9JDodXZNAcalFBhyH3YaxAqiZsaC2UaM8F
         v95VwodhpuvgPtjesOHOEnCaxAQIsVYHTItBwMOO/SoM4IJFACqPWPyvYL8pq+chdPwB
         dE/YQ40SZlq+HVLSOR7bSfa8+HDDTn10Nm+FCYuAIOFcLQABW2SfDBE15d2h2hPyDeep
         jCVseH4A3CZVACTi1NDiWd62X3jSRhhe8jJhucIRFt061lPD5669IVbkvFPQw40zGCGP
         rQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695889302; x=1696494102;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGuPs2HAW5Kc9EAlBZmlCe2PoQii+LuASoE3r9n3wKk=;
        b=lyjvmW3ERlLS+/jG7W/qeanSVJqAo6deYr8x1hh8VPH8bq1yNJ1b9onqJBKPt70Gd9
         ZHpZVT1BssufgNmsc8NnDCNg519Z/HmizoU677W2c9q+qBDJ40+9H/Wt2o6l4+U6xb4Q
         iFXIlWHkpUFiKZH5ofPlM4HORlH1mV91LNCZLwTlQh7/5atKm5T8bU2+04XzQaipl6FW
         C57sHdtcAdSPQkzzfDbDofDWa7C2TuuzOBu18kBd97sDNULfq3FfWyERFonI0z1V9FKo
         pd6ZxqvYFW7UZfl+LMnYCycq0PPymLG65RTz5i27S44NzBUBOZcMvSw+q4R2geQ1d8NR
         DXvw==
X-Gm-Message-State: AOJu0YwOlDPhuoL/VljCwmlWjSkC1/mFOMAhZghuQyr/FzvZdp6zxBSX
        0c9rszXS1dlw0w2kZyuPIUMCp5agLFCF2V0tpn4=
X-Google-Smtp-Source: AGHT+IHeESqtSKB04b7uN9B+G64RUhIjp2HYKTrSiZnHnxUinOXiIAkcuaemuhRjnw+5Zf9HOJudP1hMpE4GBBO0Esg=
X-Received: by 2002:a05:6402:2547:b0:530:8942:e830 with SMTP id
 l7-20020a056402254700b005308942e830mr700857edb.2.1695889302377; Thu, 28 Sep
 2023 01:21:42 -0700 (PDT)
MIME-Version: 1.0
Sender: frddzng@gmail.com
Received: by 2002:a05:6f02:c18b:b0:5b:2d8a:f386 with HTTP; Thu, 28 Sep 2023
 01:21:41 -0700 (PDT)
From:   "Mrs. Lenny Tatiana" <mrslenytati44@gmail.com>
Date:   Thu, 28 Sep 2023 10:21:41 +0200
X-Google-Sender-Auth: yQWxAhrwE6VNgdEA95_FX50JSOg
Message-ID: <CAGUd7jmqD51k40kvtb9D069bDd8T+Ud8kjDnMC5WB7yf95xDNw@mail.gmail.com>
Subject: Greetings dear friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        MONEY_NOHTML,RCVD_IN_DNSWL_NONE,RISK_FREE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:542 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrslenytati44[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.7 HK_SCAM No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_NOHTML Lots of money in plain text
        *  0.0 RISK_FREE No risk!
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
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

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5260278077B
	for <lists+stable@lfdr.de>; Fri, 18 Aug 2023 10:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358774AbjHRIvh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 18 Aug 2023 04:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358773AbjHRIva (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 Aug 2023 04:51:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5536F30E6
        for <stable@vger.kernel.org>; Fri, 18 Aug 2023 01:51:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe2de785e7so923716e87.1
        for <stable@vger.kernel.org>; Fri, 18 Aug 2023 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692348687; x=1692953487;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1TlFutujkuAS8Uu3sm+iKv8p70navDOeGKRAp5GVBI=;
        b=Dq8nqhdj/DBx9SA6+s1B+KzGEZSZlsD3o1KubDrbEpXJM4HEvpioB9qYgKwxUHrWt3
         B7yWQyJtfjC1416CpypuJTBpiTJK7xG07tbJZi4KfmDh0Ly1fzWBEuq5srcrXtm9M0oU
         +J8j/WQDi1sS+QXywaNPakQHJTGqfCLYDWFS0QaOC1L7Sovi4r9aeHl3Ixk1X5AVUWa8
         lhohdSPnPRppA7dxxix4jhcprxGhM+YcucRVDAmX8dxsRcnqbGK7h6laAsbrDgLFERFZ
         C44GvjUqAuplWKVxvXvdd26UMK1yshcme7rA0xq4/o8JR3vE8ounRU+NexeJTotKQ5au
         45+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692348687; x=1692953487;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1TlFutujkuAS8Uu3sm+iKv8p70navDOeGKRAp5GVBI=;
        b=XcYRPP6yp9MV7SKnRpFOyMIcBCVs0/LKkocTOY0YHSMHgsjlJEySnlaqp8Fp2HGT+m
         IqGnNjO9Pa7a5H/qEyY84nl1Leq7s6YURlERFEKezdulIm/OGvEZVmQBtr4xjHNw0Wof
         dd6sLyRkEqN0nwuZagWDa0hDDCsIDp7WwQbUXs/1xJRp2HoN1TkltH+LvPMSoe0EykUo
         ydRGdMSE562rsq9hXF1Dk6c8zQNwZjWiADyZbtPlrUYtl+zYhDgf3JnG1M+tUXF3ePa2
         c93OD/X1Vy8eX0ly88YfKhipJSfTMowJzMx+1XPf29oS+MZWAe2FObcPi/c9bPVPLUbw
         vu3Q==
X-Gm-Message-State: AOJu0YypX4BMolM1MagY5h5rJoCTffL7Kva3tEz01Fm5uqRLV2z8km4w
        SKRt4LFzpQawjkvY7b7t4NEoMjNFCrASR7zTS4g=
X-Google-Smtp-Source: AGHT+IEnvT/OC+Dr5EOBDBBviOtKqpBdU+Vj2t7UrLHbbVAhVu/DgcQfFRY6SQpp3V6AO7bG3j5zgmQ9tAgKK4Kr998=
X-Received: by 2002:a2e:6a02:0:b0:2b9:bf49:901b with SMTP id
 f2-20020a2e6a02000000b002b9bf49901bmr1279352ljc.6.1692348686915; Fri, 18 Aug
 2023 01:51:26 -0700 (PDT)
MIME-Version: 1.0
Sender: mrpatrickj95@gmail.com
Received: by 2002:a05:6022:8087:b0:43:21ab:29cc with HTTP; Fri, 18 Aug 2023
 01:51:26 -0700 (PDT)
From:   "Mr. Patrick Joseph" <patrickjoso09@gmail.com>
Date:   Fri, 18 Aug 2023 01:51:26 -0700
X-Google-Sender-Auth: 2vyyr7SjHS6I9WfUx6hSAePR1eE
Message-ID: <CA+a7-=XbtjWDvTqaeA5SG0Uo_nY33aan6MNiLWnQETqcSbUYfQ@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,RISK_FREE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:134 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrpatrickj95[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrpatrickj95[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 RISK_FREE No risk!
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

I am Mr.Patrick Joseph, The Director in charge of Head of Operations
section of Africa Development Bank Burkina Faso. I need your urgent
business assistance in transferring to your bank account an abandoned
sum of $26.5 million dollars belonging to our deceased customer who
died with his entire family in 2006, leaving nobody for the claim, I
ask you, can we work together? I will be pleased to work with you as a
trusted person and see that the fund is transferred out of my Bank
into another Bank Account, Your share is 35% while 65% for me. Contact
me immediately If you're interested, so I will let you know the next
steps to follow. The transaction is 100% risky free.

Thanks,
Mr.Patrick Joseph.

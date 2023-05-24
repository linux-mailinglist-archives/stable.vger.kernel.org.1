Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0E270FEF7
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 22:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjEXUGg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 16:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEXUGf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 16:06:35 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3BCA9
        for <stable@vger.kernel.org>; Wed, 24 May 2023 13:06:34 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-19674cab442so566834fac.3
        for <stable@vger.kernel.org>; Wed, 24 May 2023 13:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684958794; x=1687550794;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=egwO5+jRcHqhSVFUfUGWVJVk/4clvS0mJ+iA2ckPsK0=;
        b=O5mluwPFgWd6dyDmXC+6WWeHcZqfrlb4IdFDBqf+igHNq42eb9tfaAsVhSLLwO7v2l
         lDeh4JppgmFyThAbntxediev3l8oVL+5gPcMqkmw4pKlHbDHAAvcu6HKkbDuTW43yOX9
         0m/sIq7t/Hx3Iu0HDzOqhdIugzcGaq9hfzDnt2OsnhqP//Fbk+7OLYx9ybFgQwAQ24m9
         wEClqBtYUyo0uGgaNS3EkhhIoPUyO20QHPGF7jI8w5QI5CUU2UrRVF7kptoRuKAuvpRY
         x9Nm81pXMJV+5VkGcCRpd/hQA4GENeA+xc3JLMziiTr3ZSQAL0e9/8C+BNFz/rU7zv2C
         3MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684958794; x=1687550794;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egwO5+jRcHqhSVFUfUGWVJVk/4clvS0mJ+iA2ckPsK0=;
        b=Lk32squzWX60bqw0Z6z246DJdMORK74T6Cj61AUgz71WGeFBpjvRFQGvcbFBDt+FhS
         C1xwFylmSjNz+XSx88DfP8gs6KqKiZaBtU42KaXk9eHcKG7hP8kX0zbIsaJqyhbYxtuf
         XvsnoMlFMf/l/c/k5YyUGzwOA3rVYcrDvyQwvgMzfI8EIvkuKyoleKGL0teGeM66Q6Yw
         rs8bBNvYiFrb+DmQZq/1qKi0cNzrnb0uND3QjIXyWT4uE27kd7028GOHtyKYF9T57R7p
         Q7UqhX3VX+ZwMsMXYgZ3zPUvVu9gnGNegDBwzZidCFX2nZKonoaxAH2lRpp2hSPmDvEh
         0eTw==
X-Gm-Message-State: AC+VfDw+AaF+SEmHFMgbTnHDWEJbVWVqozLybjgtwy7vVrhteXio0xsi
        +lIh5gNbUGWDnLQ+J9uA+gPSOuqlNj1n02PB4Vw=
X-Google-Smtp-Source: ACHHUZ6G/vi2D3H7jFa/TNnvocjVS3a1ac9UVJn/hshZ1xzg7lgABukmgkQO8we/QkD8jS2J5ULPTs9Y5fx9pTxAfhY=
X-Received: by 2002:a05:6870:e495:b0:18b:15cd:9b45 with SMTP id
 v21-20020a056870e49500b0018b15cd9b45mr418771oag.40.1684958793660; Wed, 24 May
 2023 13:06:33 -0700 (PDT)
MIME-Version: 1.0
Reply-To: abebeaemro99@gmail.com
Sender: bashamarliza@gmail.com
Received: by 2002:a05:6358:60c8:b0:11f:1b4c:7fff with HTTP; Wed, 24 May 2023
 13:06:32 -0700 (PDT)
From:   Abebe Aemro Selassie <abebeaemro99@gmail.com>
Date:   Wed, 24 May 2023 13:06:32 -0700
X-Google-Sender-Auth: 1QSncvFEw-9MZjoFfbmUrnpy_6Q
Message-ID: <CACeKo8KOLuFdQ2VLM0_pqzCE4FUfuDNR=+Oc2S+q2KBTQBrUUQ@mail.gmail.com>
Subject: Greetings From Mr. Abebe Aemro Selassie
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FRAUD_3,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abebeaemro99[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bashamarliza[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.8 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_3 Lots of money and several fraud phrases
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greetings From Mr. Abebe Aemro Selassie

I have a Mutual/Beneficial Business Project that would be beneficial
to you. I only have two questions to ask of you, if you are
interested.

The reason why I contacted you is because am the account officer of
Mr.Jin Wei-Liang,here in our bank,who died in covid19 pandemic with
his family,since that time until now,no one has come for the money,the
meeting we hosted last week with the central bank president,bank
management agreed to take the money as government property,that is the
reason why I contacted you so that you can apply to our bank as a
cousin to Mr.Jin Wei-Liang,because I have all the documents concerning
the disease customer in my office,I will be here as asider and be
giving you informations,anything bank asked from you,I will give it to
you because in this life opportunity comes but once,I have been
working for this bank for good 13 years now and am based on monthly
salary and never achieved a tangible thing and if I don't do the
business with you,bank will still take the money so this is the reason
why I contacted you so that we can do the business together,the
disease money is (18.6 million dollars),50 percent for you,50 percent
for me,if you are interested respond my email but if you are not
interested do well to inform me so that I will look for another
partner and please don't expose me,delete my message because if bank
finds out,I will be in big trouble..These are the two questions I
would like you to answer:

1. Can you handle this project?
2. Can I give you this trust?

Please note that the deal requires high level of maturity, honesty and
secrecy. This will involve moving some money from my office, on trust
to your hands or bank account. Also note that i will do everything to
make sure that the money is moved as a purely legitimate fund, so you
will not be exposed to any risk.

I request for your full co-operation. I will give you details and
procedure when I receive your reply, to commence this transaction, I
require you to immediately indicate your interest by a return reply. I
will be waiting for your response in a timely manner.

Best Regard,
Mr. Abebe Aemro Selassie

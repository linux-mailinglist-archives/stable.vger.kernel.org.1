Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F697A1BD9
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 12:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjIOKPJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 06:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOKPI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 06:15:08 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A40B8
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 03:15:02 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1448958a12.2
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694772900; x=1695377700; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1tpyTCtTPNKY2KN67ZSUlhE60Ex/RUBHK+l7PSItCA=;
        b=Y+wpYnQObJUmC7Fi8QdHP50SIyH2k0pXc5bC+lU5h1W0ve+qn58MOq/spBBzCPz8nA
         4ZV96nNa9aB7am4DYCHhRLG/TGkk6l+AA9j+Twt8NfvUHk4KQdOheSiYcJDwVn0lD8ZX
         +1O9m86ZCVHLR+ewBcSSc4O8+lnlWOhwtKuhfpceZtD0A5tAlAw4M1rs6lB0Oego+KUe
         e+5Ixm58b9wPkm9+oUIiT1qhR3iAPjAShvk3FXG6G3D0ghKJMB9MWbVZPla8Gev52r6C
         +HTC3a4Sj/z6/fF5XDt/G878wx+S7+oZUZ57swxrcJRZ/Sm2lU/OQQsBksVGt4Owe+3A
         svuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694772900; x=1695377700;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1tpyTCtTPNKY2KN67ZSUlhE60Ex/RUBHK+l7PSItCA=;
        b=X1H7pKseG+3xGqdP/aCcq5Y90L7X9MUQdjDBJQ7aM8Wr4RR5AqpNd6oYWEjCVPWPJj
         V2QB+lS3y+sPjsUQCKcLhqjbeVl9LN9LkXnFKg3oO6/Rqsz5i+AIZ7888qfPn/7JOTO3
         XdAFKq3ZNf0ZA9/5QZc2AYJ1cyemw8+hAEjyWAncO2bpifTo3tzUlO/e+/I2iQ61JnrB
         Rqrd6DQbXqNp6Jd4f5FhT5yJe5SHq5wnDkkRCXzbLzK5ap6vHp65bs7tRLPFRUZZmwel
         q1In/4zOjnoGDFzqzzd8UuKTBXiw396PnzkiUcKUbaHQJu53sf+ZM7UzeD9jn2hQEHuq
         HlRg==
X-Gm-Message-State: AOJu0YyhAxKU9X/TNp6b7PB2FbRiRg0B8NfB2RiZnPiJ4sTmuzLxJO9B
        uvsD1yRIPhAmLdW5rv/w+bwtAS69/PcycST6+iY=
X-Google-Smtp-Source: AGHT+IEGg7Pc0AebSA/9E+oQlCecE4MPEj5tGzmPAy1ijeMw4jKu+QV5fGSTG7DYl11erZ93TedA7lfnCJPxOoDkkh0=
X-Received: by 2002:a17:90a:d906:b0:26d:2fab:1e51 with SMTP id
 c6-20020a17090ad90600b0026d2fab1e51mr957233pjv.21.1694772900329; Fri, 15 Sep
 2023 03:15:00 -0700 (PDT)
MIME-Version: 1.0
Sender: uba.uba.atmcenter.bank@gmail.com
Received: by 2002:a05:7300:6d09:b0:ec:a604:33e1 with HTTP; Fri, 15 Sep 2023
 03:14:59 -0700 (PDT)
From:   Mr Psacal Yembiline <mrpascalyembline123@gmail.com>
Date:   Fri, 15 Sep 2023 11:14:59 +0100
X-Google-Sender-Auth: bpWAwhdKyr3MmQZrIUmN_bWLUec
Message-ID: <CALSdegqk49cbx=zDeXtaFOXVVeLXnycAfMvcV-WaNUEr7nHPPw@mail.gmail.com>
Subject: Do Contact me for more details
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MONEY_NOHTML,NA_DOLLARS,RCVD_IN_DNSWL_BLOCKED,RISK_FREE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:533 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrpascalyembline123[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.5 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_NOHTML Lots of money in plain text
        *  0.0 RISK_FREE No risk!
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi friend I am a banker in ADB BANK. I want to transfer an abandoned
$18.5Million to your Bank account. 50/percent will be your share.
No risk involved but keep it as secret. Contact me for more details.

I am requesting for your urgent assistance to collaborate with you to
move the balance sum of $18.5 Million US Dollars and 950kg of gold
bars, this is a very genuine business that need full concentration,
corporation and transparency between the both of us and its %100 free
from any risk.  I agreed to share the funds and gold bars with you in
ratio of %50 %50.

Yours

 Mr Pascal Yembiline

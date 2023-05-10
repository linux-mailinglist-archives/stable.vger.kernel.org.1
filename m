Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9996FE670
	for <lists+stable@lfdr.de>; Wed, 10 May 2023 23:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjEJVtf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 17:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEJVte (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 17:49:34 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC0549F9
        for <stable@vger.kernel.org>; Wed, 10 May 2023 14:49:31 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-392116b8f31so2499782b6e.2
        for <stable@vger.kernel.org>; Wed, 10 May 2023 14:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683755371; x=1686347371;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+z24Pl7od6xO10XmMEfecsYemTIfW+XARlPRi62dVY=;
        b=adCTu3oX/wUIv+3gge7PhKiHXxZ1JbcdaPK8fJoYSpflaAVbAr+qqVryoewTfHmOqS
         exdDdfg92AO9uuDNi654xofgz+Mvhr6GcM14/cRJZ26k905pEQbyylsh0eBJ9zkrD3Z6
         kZPO2n9lBKltTm5Yl0xm4QOWxGVfzQV7zeke3VvvJ9Epvh6R9UWNXpYw57rzOCsiFlVC
         uPcTIZVThLQeEx44pmqWC1HUcofF2+vgryc7XEW7E2LtNyEByrGBbpmIVNemIo0O9MYS
         RQEUZ4/EvXkMO6UOx97u8zp9b8AA1c7E6fKN8Eb6FbFxr28Lpgspwftg3GjQN4YJ4ZVU
         iXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683755371; x=1686347371;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+z24Pl7od6xO10XmMEfecsYemTIfW+XARlPRi62dVY=;
        b=L4l2l/J5c/OUR4ApGuPS0+QX9LNj7188AF6zYUhZ4zdoFb2MmFzE+/XpeK95bwUxsG
         YwT4RckyGn1FmF/PZs1fsu9mkG57yi6Q0/8DNFA2Y9UADRZ9O0kNSjAiaFohDWyJdLiW
         pkk4h5EM9CRd9eX4IoBnmrCpbNKdHwt833IeOcSAbcGb1jbfVN9yKoq4Y6H6S/oGXEeA
         CX2DetD52tk0q0L7pSvQnaHVdKtF6h8fdGG4IVyT/7ari99F0ak+vioRcW1csuyaUa+j
         hiFLpo2hAvOOfAiT/jGV3hv7RCptLBKON43U4t32+vTS+qJ6pGoR/JzDXXL5mVrtChq+
         7Ndg==
X-Gm-Message-State: AC+VfDz1jYK1w43SplqbYhR+JHWEhFmnhemjx+CfWzKySdavwGBEUclW
        UT6Ngi4ThPffhZS9XvI+/8FN5yZRa+J8Nl8kkTo=
X-Google-Smtp-Source: ACHHUZ6ViGBeXq2hYcMyCn+PQaVlwh6ORErxgj83icahpF4kufVakbDx1/oLFOOzqjzvMp5Z4ucmlz2pFPVuqrNhByI=
X-Received: by 2002:aca:1801:0:b0:38e:36d1:2f99 with SMTP id
 h1-20020aca1801000000b0038e36d12f99mr3465331oih.12.1683755370655; Wed, 10 May
 2023 14:49:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6851:a9f:b0:46d:329b:b8e9 with HTTP; Wed, 10 May 2023
 14:49:29 -0700 (PDT)
Reply-To: pmichae7707@gmail.com
From:   paul michael <paulmichael2466@gmail.com>
Date:   Wed, 10 May 2023 22:49:29 +0100
Message-ID: <CACzWseofSDXqTQnbVVxtHjcg3GwotkC9qaawF6hr6BRat3bVtg@mail.gmail.com>
Subject: Hello good
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Every time I retest your email, it tells me to check with my ISP or
Log onto incoming mail server (POP3): Your e-mail server rejected .
Kindly verify if your email is still valid for us to talk.

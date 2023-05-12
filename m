Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E73700CF4
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 18:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjELQZ3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjELQZ2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 12:25:28 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C181849F9
        for <stable@vger.kernel.org>; Fri, 12 May 2023 09:25:27 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-434891a48b7so2561665137.0
        for <stable@vger.kernel.org>; Fri, 12 May 2023 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683908726; x=1686500726;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+z24Pl7od6xO10XmMEfecsYemTIfW+XARlPRi62dVY=;
        b=oeKYDRYsI9wszFAQZSs9VZkQZuswkqcAsJKiGAfxpu1KQjmUryOr7Rmj6sftBGQ06/
         BxxS21trrDo91pF2MnICsFmNiD4BDJxq3taUDi0/wZGNXzgfb0Utk0F1Xg+yr6pUSJJS
         wYkoZYXQ8UI8e0qxPNFkH+XHX9gLLepxd6+7O7iyv1HpjPkGZ3PKX5CC8RQfFJgRoz6m
         PrLqB/zfCBzdbyBk4ndq4/lOfYLsWAu/FHVWIt4R9xfrnSoYC63Z7WQ9jHGBqbx5sSxy
         tdyuRqFf44FMUoRWLkFeEJmeiRe6n90gaxeovf673gHM3RE0L4TFAv0eDVZLOuPGeeRN
         5Q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683908726; x=1686500726;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+z24Pl7od6xO10XmMEfecsYemTIfW+XARlPRi62dVY=;
        b=SKuAhQ5C7+Benrf+Z+nitoti3ARGImNU1tHPQQRsb9QTrDuN6v/+KLF3PO4KxaJ/VN
         /XCHO6ICQnOQGL8dKBxzLlxEhB4fonkP366hsf7jukF/iz7Vk07pLiWKpO4jDkVErEP2
         ELzM+L+Ye0TEqARrIY4X9DYpcByok9CbETCKXaQtvQronQoMjNArd+gP4PHvp90jmWL1
         kr4bV0jvJOuzTeS5JSeCdeNNJLvMBaKqapaM9MltUCbDGscvId989FdCvf7Q+ZX9lufk
         nmwnGJ9s9gpVRhQnur0+b7Xn12k8U3KJuWCjnQJuzHjSZaEGhY0yqOqQpyhFH1ltYz9+
         VJZQ==
X-Gm-Message-State: AC+VfDx0e4GrfJyGLiq4m3/ZATG3h4rfgmjUknpbXj3QjDfIx5CmQx2B
        lGSFqqmyOLGEcx/Em1+n2vHKKxzOfpLOydAAde0=
X-Google-Smtp-Source: ACHHUZ6NEi+ZrTP/9/xmBJBLScunqQcLJcV1zj3WlDOu4fc/VkeiAHM2+TKqBprQIznejWGwE8YzncAXMMRpenGOTJ4=
X-Received: by 2002:a67:b646:0:b0:432:93ad:966c with SMTP id
 e6-20020a67b646000000b0043293ad966cmr10106165vsm.3.1683908726574; Fri, 12 May
 2023 09:25:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:c123:0:b0:3ca:d30:d5e with HTTP; Fri, 12 May 2023
 09:25:26 -0700 (PDT)
Reply-To: pmichae7707@gmail.com
From:   paul michael <pm3768072@gmail.com>
Date:   Fri, 12 May 2023 17:25:26 +0100
Message-ID: <CACMckHYof6gCxbRz5n3xVVc475yff2Sqz0S5DzPAaJd6SdfCqA@mail.gmail.com>
Subject: Greetings
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

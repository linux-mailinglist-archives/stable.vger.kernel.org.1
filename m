Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B376F9988
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 17:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjEGPx0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 11:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjEGPxZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 11:53:25 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D481161A
        for <stable@vger.kernel.org>; Sun,  7 May 2023 08:53:24 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so21436691276.0
        for <stable@vger.kernel.org>; Sun, 07 May 2023 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683474803; x=1686066803;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0ecg5KC5wMELpv5KoMWwexl88AAqVKm+usrtL33ouU=;
        b=hRWdT6oV3CVqnScBUwBoZUjGA5WortU/fOZUV81O6ybi9yQfl5p+ePemk8bNNSYXyf
         OyWVKvA1P1VsbVjeZ93JGyhtkrRAs59ApibR+unWXZUcO6CH3a+MBX8F2ZGd7mxJ0aPJ
         IcnFx55Mo8IAl0Zws7A6gnh6Ja3gCcxPbwhYW3bk8rT6vHqhmc3ixt+lFHEnf5+Tfzz0
         HsNvB/BY3f3skRDCcCikwOYDYo0+U/v5Y8xSzq11ManhPAguJ9HLleOfEUtNb0sJERUE
         9RvLc5QB4WmNkLVxmEUpXE/0mVhBa7X35uCjQIaKwmz45NePTivWIbnb22mbcUaDUoUI
         eaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683474803; x=1686066803;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0ecg5KC5wMELpv5KoMWwexl88AAqVKm+usrtL33ouU=;
        b=SB4uKdL4/1JCaEFnVmOJUbbr8uHXNZaOyKmto7bq0wYZaBIAfql9xvwGghVzPpN+SO
         rcKo577YxoHCMy5RVYUgrLNIudTIBojowC0l9lB1lWjHwtub2DvlTAe/gyCdtdt9FWYV
         1Pc1sUhNd60V5LMglZr2BScFoiuRIHhUZG/Azy9CRAIyaesz+bLIcFwZx8245eXOGBUg
         QQuh2Ox3l1Q+kVtUwN4b3EH3P2R2/l7+tYz01aMN6zdR++DgyPfoxHe+RF4R8HoF+pTH
         a0ZdDofcFHEIpu1JB2uI1WZ8ANcMO4b5REEUzRDtSf6+OLV86YuiBDHfBO+m+WXnw0pm
         G8Qw==
X-Gm-Message-State: AC+VfDzePHj9Q/+pGkN5QuGBdedtwTwN8Qm7NqypvIjgfr1xd5Mou0gU
        wiJV3rkfN1YanFuaqOjjWml9W7tJi9K4mtAvEgY=
X-Google-Smtp-Source: ACHHUZ5sQQ0Jd0piSx0dvP2cm/pKPJ76YvpGuHSn8vwoxAq81UEqD6Yhn+Byisl3sHQGO06Pg3jnzUP4rBFXIMHoy8w=
X-Received: by 2002:a0d:dbcf:0:b0:55a:88f4:be96 with SMTP id
 d198-20020a0ddbcf000000b0055a88f4be96mr8236668ywe.7.1683474803221; Sun, 07
 May 2023 08:53:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:1b01:b0:348:6f44:5117 with HTTP; Sun, 7 May 2023
 08:53:22 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <mosesstephen120@gmail.com>
Date:   Sun, 7 May 2023 16:53:22 +0100
Message-ID: <CA+Jpxymj=zLZs26uykK2iWZ8QxdHeJnPNkiCGw08km06eFCFuA@mail.gmail.com>
Subject: GOOD NEWS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Whats up. please i want to know if you're ready for business investment
project in
your country because i
need a serious partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email below.

Thanks and awaiting for your quick response,

Wormer!!

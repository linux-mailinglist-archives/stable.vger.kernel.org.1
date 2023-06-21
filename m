Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F694738E83
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 20:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjFUSXQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 14:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjFUSXP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 14:23:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BB81710
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 11:23:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id ffacd0b85a97d-3112f2b9625so4618731f8f.1
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 11:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687371793; x=1689963793;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rJ/7Kbo9gs7zs3QTF5nFKkJrBjocKGAtdax9LA/wsFg=;
        b=edmNdkQOK/jLnUmP9KBcbk8Qk2mLzhAKyMHAEcUwfdbsuaF8znYeAjMOLYPGuBfyA/
         uYEGcvQvwF/5k5m6rxPT8kwQa+5FPaGsayogmIEQTtt9O4W3Wr4zIPkvMCPVS9ltZX5V
         T3KGoNDMKHfgYJXmWKTHRptYyRf43jVwDNEByXePx8+huYvT4nHJGUN89hqY2mcop+oQ
         RkRUkVfsRgflPq5kq6zZOCgCFDoP22BFM/vwosbK88oQfL7Oi9NVrfeWnBDVtGGysXAr
         5KFocUOWlzPF4hLYF2mVquMn3B9GyZq+SXU5TP9QfwGUexaVqLo87IJnbkGrlgHjcrtf
         9dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371793; x=1689963793;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJ/7Kbo9gs7zs3QTF5nFKkJrBjocKGAtdax9LA/wsFg=;
        b=DQlun20A8Mo7aE3TY/f5vVYfMbKZ8zPEHMN8+2S+2FKmIlIj4oPXilwPy0EgF99ZsC
         37f7bkMSOl70AWnqb3ie2vjSc3Jipi8HQ63WPmLGBRNtisdBM/3i6ErEf0piVgCObGh3
         hq4Dqds6OwJLSDf9QZxB6z7AJkKaHX2ydk9GjWvNcLxFJzwJURGMYu4lt1RgBcY9BY0z
         PVExpanitEk2RveS1dXF45A5AjJapLjXiQ7kgRGiPRlJO5BeTxL5auDAGYKMEzrvqjaN
         Gv1ae/mXU9TmF/Qz1bRf0xzV+LNMR497DTRhGOead14MWTssk8mV6UPVxJo4HoueFYjc
         mtCQ==
X-Gm-Message-State: AC+VfDwry4elDNnCG6LSixww/tFt2f1n6nf/WLxK0XfsrrPhdpa2lmv3
        J1/OZpCMecxcVk4ilmiflUH18WF+5y7pX0XDcr0=
X-Google-Smtp-Source: ACHHUZ4058z5gMYZ6Y+PRkKy8QL0Gncw4gkdVqqF/dRgxoadkdWLg1tfoNOek0iq1LiguOVvzoVz9NL1zrIN/f2J3F4=
X-Received: by 2002:a5d:5342:0:b0:30a:c2c4:7133 with SMTP id
 t2-20020a5d5342000000b0030ac2c47133mr12190662wrv.49.1687371792479; Wed, 21
 Jun 2023 11:23:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:f88e:0:b0:306:3860:4d5b with HTTP; Wed, 21 Jun 2023
 11:23:12 -0700 (PDT)
From:   OFFER <maerskoildrilling@gmail.com>
Date:   Wed, 21 Jun 2023 06:23:12 -1200
Message-ID: <CAKz7aAiYZXpfVfLwd_SAp-73WDxYcReVgKbUzCmy_qG_wn8Rag@mail.gmail.com>
Subject: Greetings From Saudi Arabia
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dear Sir,

Need funding for your project or your business ? We are looking for
foreign direct investment partners in any of the sectors stated below and we are
willing to provide financing for up to US$ ten Billion to corporate
bodies, companies, industries and entrepreneurs with profitable
business ideas and investment projects that can generate the required
ROI, so you can draw from this opportunity. We are currently providing
funds in any of the sectors stated below. Energy & Power,
construction, Agriculture, Acquisitions, Healthcare or Hospital, Real
Estate, Oil & Gas, IT, technology, transport, mining,marine
transportation and manufacturing, Education, hotels, etc. We are
willing to finance your projects. We have developed a new funding
method that does not take longer to receive funding from our
customers. If you are seriously pursuing Foreign Direct Investment or
Joint Venture for your projects in any of the sectors above or are you
seeking a Loan to expand your Business or seeking funds to finance
your business or project ? We are willing to fund your business and we
would like you to provide us with your comprehensive business plan for
our team of investment experts to review. Kindly contact me with below
email: yousefahmedalgosaibi@consultant.com

Regards
Mr. Yousef Ahmed

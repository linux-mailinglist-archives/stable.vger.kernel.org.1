Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671F9705B4B
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 01:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjEPXX4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 19:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjEPXXy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 19:23:54 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663E75FCD
        for <stable@vger.kernel.org>; Tue, 16 May 2023 16:23:19 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-76efb0f6f60so686039f.1
        for <stable@vger.kernel.org>; Tue, 16 May 2023 16:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684279398; x=1686871398;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhC+EdgR4lx7sMb1Dm8gtcjBcr1zv5XMid+XirEv7fs=;
        b=VVXmzp5bF98dNN9xtDMYyguBask53JqjO8GoPOw+v5w9+iv/15N/VgOsQa4UMCl42H
         A9bRIBcfJwDRxnWLRkjrbgvN5GG0Ccc3TaOl0MWvs5UHnjhkJgMWC6FMrnMh4BcbYWcI
         9+7J8Z+Eg6ciPdC9j92ikDucdt3r/sF6p+072U39QyR9DdtrNavooskLHfZBRJRqUbO0
         mE9pXz/1sSfxu8H7A84JW2yD+JQXUhB8QdoqVaJXsf4qfxXEoXDpV9jZfzBgaXmoXtXl
         2ty8gwwoUt5Yagp22AmAyJ6e42JQh35M+BEb+y+NKQVbc+j2pmJIR8PdLXz/1lgPrVRc
         kPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684279398; x=1686871398;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhC+EdgR4lx7sMb1Dm8gtcjBcr1zv5XMid+XirEv7fs=;
        b=VEsmqolBIBjGWcvcIkX+pZyGMcmNrpd4qwAm0x/JrZkcgOnjees51nsI9igAnkDBxI
         7vDiWkJ/guXSoEZVsbmcCA9lPhLfZm49juifCnhnntvmh3CNzd4ZgQnhWtLAAtcyvm5p
         rNR93DinlG+OrFzCvRB4eOtTDJoDBQO8oRCmSNzsBSCHHcH4hpsTYaAwV+831gtyrFat
         rw4ni5T8RfR86T5M6idplSZrZ7hfXidomwVHNBl1UjFs+I0NCQK3QedbFT1KSVG1rAmz
         /byoss3zepZGpnxk72ddAvXWix+gnanoDSdqtQ+Vv167z2uZ0AP8djan2N4S0tqVcWIy
         k7Pw==
X-Gm-Message-State: AC+VfDyEz5X4TmBpc3Z8rAk56WC1+/xYThjfksXMOQ8KDnGiIhaM4a7a
        3SL2ME4mxzZsw9WvmoMjFQ0AAGSavQPNPcr8ykX61ajjc+4=
X-Google-Smtp-Source: ACHHUZ7zG+udo5EIzKkHwqpFWZDQ5rm1dmvVVEpm67PuIvxWKgSvrnT3KCtqvNyf34GvJNYCrkpG9W65T4l8zktMmh8=
X-Received: by 2002:a6b:3bce:0:b0:76c:67bb:11d1 with SMTP id
 i197-20020a6b3bce000000b0076c67bb11d1mr470191ioa.1.1684279398474; Tue, 16 May
 2023 16:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220715230519.2183-1-jason.gerecke@wacom.com> <nycvar.YFH.7.76.2207211349490.19850@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2207211349490.19850@cbobk.fhfr.pm>
From:   Ping Cheng <pinglinux@gmail.com>
Date:   Tue, 16 May 2023 16:20:11 -0700
Message-ID: <CAF8JNhJbdyLjHwt2Dfq73zcWfFABP9NXC5mZfz7FSUVwXkp7zg@mail.gmail.com>
Subject: [PATCH] HID: wacom: Force pen out of prox if no events have been
 received in a while
To:     "stable # v4 . 10" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Stable Team,

This patch, ID 94b179052f95c294d83e9c9c34f7833cf3cd4305, can be
applied to stable kernel 4.14 to 5.15 AS IS.

The patch has been merged to stable 6.1 and later. It fixes a missing
proximity out event issue.

Thank you for your support!
Ping

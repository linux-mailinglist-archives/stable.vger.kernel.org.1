Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB0C705B4E
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 01:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjEPXYM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 19:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjEPXYK (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 19:24:10 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A867A4C17
        for <stable@vger.kernel.org>; Tue, 16 May 2023 16:23:59 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3357ea1681fso54645ab.1
        for <stable@vger.kernel.org>; Tue, 16 May 2023 16:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684279439; x=1686871439;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECgBqKNM9jOPZ+b0/PGX1aVkBElvOJQhVkQG8pzriFI=;
        b=R8ZFYIG2INURY4yxszP6knyptNzZTtlPrdrJBOWRpWC75/kgg37XFcd2BWDkU91pVg
         0FmHbmXC+k3pOrbhCcOWPm5ImlXqXR9rhpbpU16A62FJvxMS04bPQd1w1c1wIM0BXi0J
         MjrQYg8r0l2G2GC6S6TPQLvpK/vr9X75gcw/JgTzAH/Ph/v9J7Jp9okSq1fHCIjhLLe1
         kHS/5r0z006bVCPiTRqCF5eXY30A95osXxlt0R8pb7ZrmTQWTcvjFspw4bsiTyyX7jr+
         qV5LjEe237PCIDz2cWZMT+5M82zmha87WhEvzv90C5PL8D+Y1dyhKo44jD06ZNWaTd8r
         welA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684279439; x=1686871439;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECgBqKNM9jOPZ+b0/PGX1aVkBElvOJQhVkQG8pzriFI=;
        b=jdxdXY2JZddu1Pxi89IYxC/Tec2iPIN3vQ8BdV2TMnnXd37MgQhSlFNNggubckTZRU
         bapiGVS/fNm6VQyshk2zxq/UaSvRVvfVscGGY49+IwJhgz2AVH4jPZcs80xlNhQpqywf
         uLzxPtcU7Pw3wMCzWp0D0jYlROyTrSvti6quAPoeQfW45QTXHYyXAqQE4AR6NDedYtNk
         hBCrZiW88QSIawI1oKHfAE7Vf/nu+RC+6EKIV5aiK8DyTfzG3/JL7qfehvdo+MwJJjQS
         hxU6AZ9IEw+StmzPvcR3GtmFVvSwQCqZLGSszWvItQOx/43PRPYWTQHRGyotsPIpqLxx
         ACUA==
X-Gm-Message-State: AC+VfDy8l3l0NXcSCFjZdUQwVdwUVzVFvCmqC+yCxY1PZdrWNh/Nm3kq
        ZadqhNfIc/GGuNB+Q9b4F8MeZ9aIc2uIXn8yX+DblCC+Pyc=
X-Google-Smtp-Source: ACHHUZ4uWl0ZX8Av0WWRNK4q59E11mVk+p9YVoZsTZZk4FdYEZGT+DVSqW19XVMLpC6gZePZ79c0CsE5oZmafcdkq4w=
X-Received: by 2002:a5d:84ce:0:b0:76c:6fa4:4df4 with SMTP id
 z14-20020a5d84ce000000b0076c6fa44df4mr404351ior.2.1684279438800; Tue, 16 May
 2023 16:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220826213402.9950-1-ping.cheng@wacom.com> <nycvar.YFH.7.76.2209021200450.19850@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2209021200450.19850@cbobk.fhfr.pm>
From:   Ping Cheng <pinglinux@gmail.com>
Date:   Tue, 16 May 2023 16:20:52 -0700
Message-ID: <CAF8JNhJn0s7zJYb+JHD_b1bXa=pVbpocrWxgZHyQZ+CU0NRirw@mail.gmail.com>
Subject: [PATCH] HID: wacom: Add new Intuos Pro Small (PTH-460) device IDs
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

This patch, ID 0627f3df95e1609693f89e7ceb4156ac5db6e358, can be
applied to stable kernels 5.4 to 5.15 AS IS.

The patch has been merged to stable 6.1 and later. Thank you for your support!

Cheers,
Ping

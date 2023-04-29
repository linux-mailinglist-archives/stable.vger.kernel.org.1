Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78F76F2626
	for <lists+stable@lfdr.de>; Sat, 29 Apr 2023 22:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjD2UD7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 29 Apr 2023 16:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjD2UD7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 29 Apr 2023 16:03:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DFC1BE4
        for <stable@vger.kernel.org>; Sat, 29 Apr 2023 13:03:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-95f4c5cb755so222067666b.0
        for <stable@vger.kernel.org>; Sat, 29 Apr 2023 13:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682798636; x=1685390636;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+z24Pl7od6xO10XmMEfecsYemTIfW+XARlPRi62dVY=;
        b=Uib+gTNhT2HDpCrOnbr2/u42YT/LvAGe8niYqHRwlsFMJpF1p1YA2C848RaFJ6M+6s
         Q3JKLE4YO9cf9E8cZ1IOefduLd3XcCgIALt4S4vuuMqPRkMtps4Si9cocZu61G5A3ZIB
         dnP4pSgbTXate1f+AeESU77l9SOSFD2fM6JpAq/IhSdWyEgWXh8wwKtdXPQo25R2W/z0
         gVmMZPnb0x8Cnk6ve92Ld/zfZGq/uybrjBZZzjayIQgh5pD6jaztdukWHQqDlaCE0wX1
         nmPXIhp1ZZG8uGt4a0O8Rtc/QcZ7uYbp3nsxnM35k7WqpI1RrgVkkhLVWh9YWD0iyngk
         rouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798636; x=1685390636;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+z24Pl7od6xO10XmMEfecsYemTIfW+XARlPRi62dVY=;
        b=Fc07cKuwUXf4ge11WwGfb+e4p9OmvA5hHyepuw12LHmOrnzosxucNEQ8ehXcLkt9KI
         37iwgV+1KvLe9aegTLs65QGqvJ6iwecHKgcV7KIXMEim3H5FhU5HORcjGZPlXaJnoRr2
         kKE/rQaZ1qfYWcEGwVz5sUHqeGVNZigb5uFn7oINlWB+Zau5MqbIqB4U3RPSTWkwf2jX
         D6+U9b9FhwhPqmqfFdnHx+Pa46GVCqOPARD83uwQ7DSCKdmakU05mnykTojd83afa5Wo
         ayR2edq+qHAmoAhLmpQ4y5L7JPd/TGPrMGYGInGweY/vnQZh0Px+gId4EqJDXjSmtu95
         7C5A==
X-Gm-Message-State: AC+VfDxIAtxbNYXyLZVvKUJehA49HrqlABnxWB8B4OiPgbxVWQPwuD6p
        47h0Rzh9movHzylzk8jLq6uQawpo10BakbJHbw==
X-Google-Smtp-Source: ACHHUZ6T4d5EXEJXcj+KQf822LqTcRY8R/PdeVHL/E1rgAgy8KsYVhDn1D1CgG77y1Xyxd0aMngBJPICDtqV305xIow=
X-Received: by 2002:a17:906:fe45:b0:94f:adb2:171f with SMTP id
 wz5-20020a170906fe4500b0094fadb2171fmr8763362ejb.28.1682798636225; Sat, 29
 Apr 2023 13:03:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:98c:b0:906:449c:e24 with HTTP; Sat, 29 Apr 2023
 13:03:55 -0700 (PDT)
Reply-To: pmichae7707@gmail.com
From:   paul michael <pm9568521@gmail.com>
Date:   Sat, 29 Apr 2023 21:03:55 +0100
Message-ID: <CACSDF=9LfQAd6Jkp3JvY7v39tyP7c3ScmDq9AThkN1EEcsfXQQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

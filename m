Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF4A78D28C
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 05:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbjH3Dcs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 29 Aug 2023 23:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbjH3DcR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 29 Aug 2023 23:32:17 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D48113
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 20:32:14 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-1cca0a1b3c7so3442502fac.2
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 20:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693366333; x=1693971133; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17UK3aRyTxFky6+P1xMVk2goTNEs8K/8RqHS7tcaLzY=;
        b=RKoH2k7eVR5gApJX9Hf1N9VIjuQl60ivt1lePhmwvyQk6ruHUKjFYyj7HhOYv/E9Jk
         tXL0hmcABn0/QJDxvKiWw4LuimH2uxzqTFZVvBW1DECMgVY8qGB8+UL/rg6DmHKwpDo2
         rH4fQfhX/i6R16qE+e4do7SjECCSwSVnteAPWuvZoJ1mogmZS0Fp3zLOVOC+wPvTVnpL
         Gi0zXh8X9QZAOfSvUoG5EywZ5GH1SUOEq3Y9XxDobFnqWwZlvWH4rkhvmAjgNs4eNTsN
         h5vYZcX+litKfaxNLwBxIACy+WoFifdzzP8W12FonhQykMU8bS6rh8xXv2mhpkrCR18D
         GqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693366333; x=1693971133;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17UK3aRyTxFky6+P1xMVk2goTNEs8K/8RqHS7tcaLzY=;
        b=l7ysv4UQThEcmrPx9H6kGajg3BHmGyIy/AZ7Q9GOv45dQtzxU+DTABSlYfg5kcC8bs
         Brp6WNBMsV+bFaQJjEnLB/BUHixLEC7kTb+9jgdL+1Pf/Snu7y3+/CAKwLqpW7VMXnGL
         fgSH215UZ4rGrtHq+X3NV+Dl4GaDSY+5r8M1w8NMGUjZApRuCcWi8ZjmGP8n49VuoEqn
         Y/9TrcjBXt22mkS+2m0y0/UgoH2tk3uZ9BrUVtDYS8bIuU0zU8o9x2GVuy9Yohovloy4
         LDqGbFJS7k59vPozemNAucUoO30d6/CJiRT/SHGe6A0rfhzO5Xaabm5dS6B+BeUeZNfw
         1QIw==
X-Gm-Message-State: AOJu0YzFf4DKcDNER5DMN6F5sQrGDPKZDmdZhIoD7rVUpwTbknxhxJgr
        IICm8LGZ20wgIFMoZCu3P2DYN4B5TIEXR9uBPiE=
X-Google-Smtp-Source: AGHT+IGDW40n8K69mDiGRTvp+LopeNGgZ5Sbcmw3UKFjprvsiC1xMGcZQCW3Jg6EHBxk2YKKHeZe1eDginI4TMz+pSs=
X-Received: by 2002:a05:6871:810:b0:1b0:189c:87a0 with SMTP id
 q16-20020a056871081000b001b0189c87a0mr1231887oap.41.1693366332790; Tue, 29
 Aug 2023 20:32:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:522:12db:b0:520:3f04:aef2 with HTTP; Tue, 29 Aug 2023
 20:32:12 -0700 (PDT)
Reply-To: matthieujean200@gmail.com
From:   "Mrs.Augusta Matthieu Jean" <vincentistasse56@gmail.com>
Date:   Wed, 30 Aug 2023 05:32:12 +0200
Message-ID: <CAAR1-KjQrOT60jsAwQa-R59-EM9fKY9OJqGd=KHY_BDjTR34QQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello my dear,
i want to hear from you first,
Thanks
Mrs.Augusta Matthieu Jean

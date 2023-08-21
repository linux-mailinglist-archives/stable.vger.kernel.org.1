Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0A87824FB
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 09:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjHUH7k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 03:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjHUH7j (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 03:59:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E16FA8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 00:59:38 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68a3f0a7092so859334b3a.1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 00:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692604778; x=1693209578;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S7Mz7Ele/4y6XRqPznCUOmaYOagEExcSG1j9CcCWrqc=;
        b=ED7TA0kMARdUtnwMtnGspMHx9ijcFQ0GjaVRUM3NBL6va/uB92+19HBoM4D9ks0Q3e
         2HCc2IHcP59X6V8cSXXXA6OTwVs63MVG2/VZQz7lj5bjQL2BjKkAnTHQd4IZ4WdfQxnm
         4XGKoNrxChEtJMlhZ3ICIlKzpR47RHl1IjGDgvrzHfk8PxKMu6tGM2oEp1S7jSX+FY5h
         qsBIkZbUKfXgA8j8oO5CW8jntMmzQ03D11Wczs3dSlEePxI4+nVbbT1qBc+yVnfQxJNW
         kjokz0yf1/dLVYIq0MbbLUZzbsjMgeLhFgzCa4RAjfBfmNKW8RwUODD5tkw98UmBOz3N
         kggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692604778; x=1693209578;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7Mz7Ele/4y6XRqPznCUOmaYOagEExcSG1j9CcCWrqc=;
        b=BiiFcYMML4bqKQVcg3Xlyjluhw+ZHDJd4bw430Q13TXepcI9tZ69tYjHw2BvvPiPsQ
         gRTt8hMY+K8Y3PoGcUFJT1nRWYDsgJdBfBe1BvVu7cDUASLFHuXhClhAfE4yAzz5AKhD
         /30lXNsPgBRjkaV4O1tQZ0CfJU2Ah4l8XASWeZPFM/tgSGLa+g3tnwUY+TLm/5se2lBC
         uhTKwG37esUAGmFUg7syzLyfBQj+IRP74TA/udv0UZqST/LnIn9//jhmkgaYwH3oBnIE
         7S3/wm2IjB0F72CZNHwBr1CsYpGOJNRYIM3CcSpHDRJxKnqbadxeVYo8ZMXj6vflij2G
         jKeg==
X-Gm-Message-State: AOJu0Yw3X2rTBJT4WLVUm+2cPiOsFPJY2IXhD4xafBnhW9dcYeAIToAt
        lJ0ocSY4BGcCGavy+dwzhvc61/Sc9luccbjI40U=
X-Google-Smtp-Source: AGHT+IH1Z+YVRxxwDBDg51I7TChZgfNJ4ENxtlrGRHW3JNiFyhsFo5LYX6txupH+UvP5hcIRMZKa2706LigpzKpXyok=
X-Received: by 2002:a05:6a00:190e:b0:687:7ef9:a796 with SMTP id
 y14-20020a056a00190e00b006877ef9a796mr8210204pfi.25.1692604777910; Mon, 21
 Aug 2023 00:59:37 -0700 (PDT)
MIME-Version: 1.0
Reply-To: baristerdalla@gmail.com
Sender: joyj7182@gmail.com
Received: by 2002:a05:7022:2508:b0:68:45ca:b414 with HTTP; Mon, 21 Aug 2023
 00:59:37 -0700 (PDT)
From:   Dallas <macd5238@gmail.com>
Date:   Mon, 21 Aug 2023 07:59:37 +0000
X-Google-Sender-Auth: V4zouc6Q1vbnGTnlsLZMf33gXQg
Message-ID: <CABVMpjzCvm-0ctrST4GO8YuVvkXF4hR7-gbenJjrB3BVcQH-+w@mail.gmail.com>
Subject: With all due respect
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greetings,

I am Barrister Dallas. I have a very important message to discuss with
you. Hoping to receive your reply soon.

Barrister Dallas

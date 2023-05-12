Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D5C700D73
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 18:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbjELQzf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 12:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjELQzd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 12:55:33 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2EED042
        for <stable@vger.kernel.org>; Fri, 12 May 2023 09:55:32 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-334d7bb7155so16841655ab.0
        for <stable@vger.kernel.org>; Fri, 12 May 2023 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683910532; x=1686502532;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tgxR2bDWw43l9TyRbM99R3zx5LyjvCXMRfv36ocEFs=;
        b=dXCr5hD+bNHFny8TW2XwMF2nlw1Q7unaGTrPeELYyHOOjnRxcaemvxC42wtFQFVj+G
         xOKsqhfTaW3FaBqUAswFzJhbYm2717iy4WCNJRdhtoBPqHKkBG9wVcKZYiHNs+ANdc76
         zoQoSllP9hmm+50xnG/s7b2zxyoDjehJ1e2i0vycui5TTPBGbz/W+1cjyQjwMV0tr8TQ
         CLgrXfRH9YoTE1Wk0JaSz+YLsXH2RyPoutYA1XX5xI5artNUPjfVI5gNcy9vQ/M9BNXB
         Fd1W1xtogpfwOygce9wvgGsEGWtS2pRyNfaNgwoQN0FAU0nBTHXyMMQflJ1qC9p4pUxG
         TUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683910532; x=1686502532;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tgxR2bDWw43l9TyRbM99R3zx5LyjvCXMRfv36ocEFs=;
        b=BTllodauiA7CPRac5n6VsGM7ddMX0zwCB7fdvADSkUz/DKRaGck927lWGk9+ZW9A3+
         FEhr4nEfoaEZzwyj+EBoyweNO2w9x9O2GxwlLSc4jaWXx932i3aktLxAhr0HSwTlljDD
         avpdx2C2Zx8Z5zwLpv0Pa3BB/hBpxDAf+Z7jTYbkxuZU7p+hsQyiPzstFUPRewWc45FM
         ZKYYNRjYx6a1ODA0bIRudH6JrK4PL6M9NeMdcKPqckQNpAIZkj1SyGnk4yXlprd3eKBX
         BNvynvAcmPq8mpRdX96wlyvOnL0yPvjntO2c74ZweH6j2LATC9rZYa5oIAEZYWCnEsva
         9d7w==
X-Gm-Message-State: AC+VfDyxnkQQoVilAiDaMUJJNsCYw12n9UIos8I6cvmsCAJVa7xY8uop
        tOluuYRd9iT2/a1n5ILcDZV6n+u4luS+GHRJa1c=
X-Google-Smtp-Source: ACHHUZ50JvGE6Kf48UJ6v1CngSdQraDxSm+b9bXOOe+Gh+NFh/l1qJOd/zA5HjjKRLJw6c+V6x6K5LhVBtyrl3DuVFs=
X-Received: by 2002:a92:d844:0:b0:32c:bea6:e41e with SMTP id
 h4-20020a92d844000000b0032cbea6e41emr15793798ilq.2.1683910531947; Fri, 12 May
 2023 09:55:31 -0700 (PDT)
MIME-Version: 1.0
Sender: johnwhite998765@gmail.com
Received: by 2002:a92:dc92:0:b0:331:3d5b:363a with HTTP; Fri, 12 May 2023
 09:55:31 -0700 (PDT)
From:   Rose Darren <rosedarren82@gmail.com>
Date:   Fri, 12 May 2023 16:55:31 +0000
X-Google-Sender-Auth: s9rdMZUzJdwxVCME7ZYrr9onUYA
Message-ID: <CAC=a3tiaPdTUeYz09LHZdECi-6G41x3OucD_b3=7Wyz5+v69pQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greeting to you
Did you get my message last night so we can discuss more?

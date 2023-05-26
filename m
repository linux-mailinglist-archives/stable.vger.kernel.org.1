Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD75712C74
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjEZSbR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 14:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbjEZSbP (ORCPT
        <rfc822;Stable@vger.kernel.org>); Fri, 26 May 2023 14:31:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8476AF3
        for <Stable@vger.kernel.org>; Fri, 26 May 2023 11:31:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-9700219be87so188296866b.1
        for <Stable@vger.kernel.org>; Fri, 26 May 2023 11:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685125873; x=1687717873;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/isQ8S+XwUtFhpB8Qy/P9/2D28oaaCpwFbyNtv2ZZqU=;
        b=ZZH18WgXMo3bOpQlBO9x4CGNzCTRDkjIzr7qMuIO4i1k3yz532qeHrp88mzL7SVy9S
         X+IhrkHh3mzOWb56wjQyfNDkwfCHxk8HEACO5CA/P9g+2am8CPv6C/Ga0GGkpnw/UO7k
         D7kLiydB1IL0yTFkqrOcdw992F07LPtxwokvgHM1jKPJA+zdBgr/5gB2hzNREk2qHfQh
         hSvaKVcfERxRQov2HJU5/yxgTVRepGBdq1ykUFGLMp7BPFyTc7qZV4zRKWyVhUx5Jzdp
         zh9OahA9138fILtni0fdH4CYCAmeqdPg0YZZIQuTSJGuhnZD94A7avheC/r8zuZg9HBR
         R1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685125873; x=1687717873;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/isQ8S+XwUtFhpB8Qy/P9/2D28oaaCpwFbyNtv2ZZqU=;
        b=VcUuV2onj+hLQ5o6ffMICmhpADPMyoUUfnY8YfPtgo1L9w4Z5lqqsNMv5A0l4+8YJq
         /tycnIMxcBNtqjqPLDtdKK1mUKz4qRj22cQvJnNlnBQ3B2zD6gabLzsW3pL08zK6YY+x
         /nRdsxQZSJmZSAkPhcdpIxDj1oaB1kY1mf7yTajnYAQ3sHaY4qNyoYRqw/CG/cUI1Swm
         5e5dHQmbbS1nVPGsx/jSIZ3uran0NhUOd5qpyIZQNIBGXW4ZQBcwgm00JxIsFS4gnYYq
         5qvMn9ujCzwf/rM6H78tl2kKfAPHOT7/LJDNjkhzJEU1c1770kzeyvmLKwG87xyjTTo0
         wASg==
X-Gm-Message-State: AC+VfDyZhVFz8iG+MH/SqKClIkHYk537Y9zDPWxg0ckc6wNd+YmcyWTQ
        oTK93uKDvZ6RBanitskG/2KsjtIaJqeWayj6vww=
X-Google-Smtp-Source: ACHHUZ6NqWi/A/l3Usf461m2dcdjXKGkpJ1J7y+U73Z962vO0By4gMFot4A3UwYW1hovecwqtcvZEjC91wl+giXUEPE=
X-Received: by 2002:a17:906:ef0c:b0:96f:e7cf:501b with SMTP id
 f12-20020a170906ef0c00b0096fe7cf501bmr2574142ejs.33.1685125872913; Fri, 26
 May 2023 11:31:12 -0700 (PDT)
MIME-Version: 1.0
Sender: johnlarry70@gmail.com
Received: by 2002:a17:907:3f10:b0:96a:2dd7:2ef8 with HTTP; Fri, 26 May 2023
 11:31:12 -0700 (PDT)
From:   GOOGLE AWARD PROMO <williamsjoestin@gmail.com>
Date:   Fri, 26 May 2023 19:31:12 +0100
X-Google-Sender-Auth: Jr6SpDFgqD4PruE8rD47IOi8jhE
Message-ID: <CAMkVbgiiGYksPxKs1RgouukkQUjjcPK2dyYguZOKqdpfYX=H=A@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FORM_SHORT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        UNCLAIMED_MONEY,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:641 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [williamsjoestin[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [johnlarry70[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.4 UNCLAIMED_MONEY BODY: People just leave money laying around
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  0.0 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dear User,


Congratulations...

Your email won you a Cash prize of $600,000.00 in the just concluded
GOOGLE AWARD PROMO Held on 24th of May. 2023. Your Ref No:
(GOOLGXQW1563), For claim Email us your Name,Address,Occupation,and
Phone number for more details.

Note: All winnings MUST be claimed in 2 weeks otherwise all winnings
will be returned as unclaimed funds.

Mr. George Harris
Promo Co-coordinator

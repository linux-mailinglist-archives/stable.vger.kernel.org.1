Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D077C77EFAF
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 05:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjHQDzr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 23:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347932AbjHQDzY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 23:55:24 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7424226B6
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 20:55:23 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a81154c570so1876146b6e.1
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 20:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692244523; x=1692849323;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gb4qAVlMN/V48c3tDnit9Qdh+68rSKImmu7s/ky4OWc=;
        b=XI7m/zznxZ4aPkTspl+4F2hkxPQMFV/SA6DW5QbWbq45/ySn06nnL6iFpX9CTOBkd4
         tc3224mXMq6pT4XU9dqJhfcRnbpbbhbnj+pjQ+zotEdAavAPevnt9KQp3y5Fu4sLSxy7
         2xssKJM9cZD65A/JJXySE3PXod3ADk9tPwf/G59BshcvoySbwUAFZlSqaCnqG91yoCXb
         mD4WFpY2puqqgv+zPbwJE40Z38oQfixXwVx18xOq1pGCxgQLUjwT5JzVJZFcUbVhpyYm
         SSVIVZTXPdQb2nWh+5k3LdCpESAEgHSF8bA7GMNdCbQ1QWWe4Me8QxE0Eci7W3HzpiSO
         uEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692244523; x=1692849323;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gb4qAVlMN/V48c3tDnit9Qdh+68rSKImmu7s/ky4OWc=;
        b=Tofe6UjxczC6CmxAZGzDGbg3lFBFpcrF6SEREMRnMsuXz2d0/vDnXxSRBrgWSSwTm/
         BW52x9CniJm7GejcEGk+cVIdRD3AXiezZ9tNAlAG53F4JpzOnakGHQFKeSjbTfMViUnr
         T0UIYfcri8r051BtxXbiyk9RLi3WwzLds0g8kf1JH1fT3MeHJrC3vG8yegw6T/bqGUvg
         zHKc1oeB0Ad5R8JRUWWG+VHa6vhWKXOGpamjn96UEGQ65zTKB/jr1Yr4cT57kdBamkWa
         cG6kgYtiyTYWzipNwITaF+QehNPym4lv31589yZ7hvwcUW8oJcbAKhmVuUn5Pa/7kBI9
         JalQ==
X-Gm-Message-State: AOJu0YxSCBLq4ZXUUOtha5B8Dl6+FzLcB8iR9ch9DDrU8JQccKsuMaD0
        4yOh2dORy0zClTm1wZdG2KLL9k0RAPkXAr1ctdE=
X-Google-Smtp-Source: AGHT+IFpBgVTNE7D4AYzdwlBHId9YHYK9UIWGzoUlK7gyNRhxSI015nsXjcQKN7Pn5SL2Szo6m0vyMwQLzM9c/kZK3Y=
X-Received: by 2002:aca:280b:0:b0:3a7:adf5:d5aa with SMTP id
 11-20020aca280b000000b003a7adf5d5aamr3939166oix.31.1692244522534; Wed, 16 Aug
 2023 20:55:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:d099:b0:133:91d:bed5 with HTTP; Wed, 16 Aug 2023
 20:55:22 -0700 (PDT)
Reply-To: privateemail01112@gmail.com
From:   KEIN BRIGGS <privateemailjsuee@gmail.com>
Date:   Wed, 16 Aug 2023 20:55:22 -0700
Message-ID: <CAGgyiOo8N1VmN4WeWTyY8_0KCNeib77vD_XNfPJOzOPMZXM8DA@mail.gmail.com>
Subject: Your attention please!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Your attention please!

My efforts to reaching you many times always not through.

Please may you kindly let me know if you are still using this email
address as my previous messages to you were not responded to.

I await hearing from you once more if my previous messages were not received.
Reach me via my email: privateemail01112@gmail.com

My regards,
Kein Briggs.

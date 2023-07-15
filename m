Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C4D754804
	for <lists+stable@lfdr.de>; Sat, 15 Jul 2023 11:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjGOJpE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 15 Jul 2023 05:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjGOJpE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 15 Jul 2023 05:45:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3117635A2
        for <stable@vger.kernel.org>; Sat, 15 Jul 2023 02:45:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-521662a6c9cso1616998a12.1
        for <stable@vger.kernel.org>; Sat, 15 Jul 2023 02:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689414301; x=1692006301;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rd7EcdjpHZnpl97A2dYWJXnY3/LTkIe+Qq5CeS9NCY=;
        b=B8ZSLTcynd7YAu1mqOQtTIcCnQkSKVszvuofuV3KBodSRTvPSLgt72wU5nYfDoVx/h
         CSRn7OMponkMfE6nMaRy2wquvnbbEogBNNfsiT4sN8ZYUPeUM0rLIK2aZ9Grq2mCIFQ1
         95FL7T44P8pTP0F9BbaM64AC+KikNNRX8i4kviUqmo26hvmaQRAn3qHucF9fppiuQOIr
         ej6ITstzQCXmF0Cztul6WDXfWh+bGpqDnixatxT+5XEPy3H4V/uS79ySLmDpX0DoRMCE
         KUKFWN7sVoQtbuVkuKGzuepVCw4c+5ox2BRTXvfEQa9cMDHAWY7sc43NdZ+N4KBKHzev
         SvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689414301; x=1692006301;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rd7EcdjpHZnpl97A2dYWJXnY3/LTkIe+Qq5CeS9NCY=;
        b=YY84Izf19SPze3oBCGpfotBhlRYcTsSfL4HI31pFn7AjCm5OW45Pm1WI7C+lXncG+p
         UbLrdObZmN3joJeTIJsLE2Zk7dHkoV+3RU80CjlRqkRJV07mohs3VNDNJRhDAP0Bdzu1
         pnuAr1h5oa7QrIscXWWk9IFDOdVcVib+Y/Pr7dKire5aq4rUrrSX3AEt8detXKwfT3W5
         VrWDqT72k2XslxMfjLwArEPl/1g/IOl/67v7QDEoBrLvsZWXgaVEIk8H8YvxVnMiHv07
         y8fOt0mu6NFH/NCa+lF5fwK3MuBgJn7AGnGL5xagTH4eOlc+syS0UCrnOFttcA5DVFMN
         gbYA==
X-Gm-Message-State: ABy/qLYO40bEe/OZxgA1gbqqOXnW2KxV7nTkXjORpwb3bICFDHFVqVqf
        NWHza+Pc+5dkhR6uzfL4QJJHd55NkSV04OUgq5k=
X-Google-Smtp-Source: APBJJlFrujjmpQv+PuBc9WdeZoG7IQQkR/YMu5oo7TmgxkuHNG7HPdODPLbwrsbtN1WxEhznoaUc8iO6W7Mbcv41fMc=
X-Received: by 2002:a05:6402:68e:b0:51e:17d:a1c3 with SMTP id
 f14-20020a056402068e00b0051e017da1c3mr6003043edy.32.1689414301271; Sat, 15
 Jul 2023 02:45:01 -0700 (PDT)
MIME-Version: 1.0
Sender: kaboreabrahamstewart@gmail.com
Received: by 2002:a05:7208:53c3:b0:6e:fff9:e047 with HTTP; Sat, 15 Jul 2023
 02:45:00 -0700 (PDT)
From:   "Dr. Thomsom Jack." <jackthomsom7@gmail.com>
Date:   Sat, 15 Jul 2023 10:45:00 +0100
X-Google-Sender-Auth: tVnVRaSnbeeTpCZN3rtNt5kS6fQ
Message-ID: <CAJpCdcQFSURRRZyQKzbKMODUOugnA5tPsrQ-OM7ZL6yBqcoodQ@mail.gmail.com>
Subject: I NEEDS YOUR URGENT RESPONSE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greetings to You,

I have a good news for you.Please contact me for more details. Sorry
if
you received this letter in your spam, Due to recent connection error
here in my country.a

Looking forward for your immediate response to me through my private
e-
mail id: (jackthomsom7@gmail.com)

Best Regards,

Regards,
Dr. Thomsom Jack.
My Telephone number

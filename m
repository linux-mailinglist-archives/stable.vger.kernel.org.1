Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E8B7860C1
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 21:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbjHWTi2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 15:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbjHWTiY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 15:38:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030E010CC
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 12:38:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-317f1c480eeso5263479f8f.2
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692819497; x=1693424297;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FkdYMeXA9dTi+jYrtJK1AER7q3RbWwnPY/aiY/XaIWw=;
        b=bO+BGNzMMtfXnc3J8MO3m08yfLTOR8Tf1oZlXYthCQquaVAwSUoJsI0Cx2G/fwd7ji
         8tmHURQnv75GK6B5vnVExfom+rJRHFRGU3EV+OwaWqztXhN4Gd9gWxzayqzh6Dq8+2bO
         YIzq7D74rUBvntQV7nUvC7SavFJEDrCwYzIluKwRVajzR61+RoHfggmz0D5PlRF1XeiO
         JYfhtsoDSz7MAb/eQ945wOxqpn/iSGCQq71ICqluOHX/PLmw6FKD2AGFKjenrDsuB+TJ
         VVz0v0K+8hlZtwL3AO7xF9B89HD/+l9/m0bKjz3jIKUR7x9gahMZMwf9Zent2C2Q9xqU
         B65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692819497; x=1693424297;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkdYMeXA9dTi+jYrtJK1AER7q3RbWwnPY/aiY/XaIWw=;
        b=UufekJ3cQTsICUCtlMpGKF3lAW24tNrORlopameC/UiDjMMnitss94Ikhi66Gu9lpu
         KiTWln32JcZ1zc9nSImzDQDBGPVrYETba5UpKVw3YNzzNIaK4jtQjkP1A17HJyryz5zI
         NpsnilR44P6yefb2UbM4klQV6LLUr6kNmfFV20yDugHH8/5Pd2Rcly3ebLETUuqzlRL7
         Khgki32CE+zzbijJHKdXawB3gpuEL3YGsqtu4XNCfvFfcOzm8nRcaj7tjbuorQq+umM6
         efsE+y/DbkaeGJmPhql8TCeXpGij4y2YrxN8eUOgh/iwA6IP4sJjKYQNI9/VNFBm/GLx
         +Enw==
X-Gm-Message-State: AOJu0YyUSyVB4xOC1zsrFFCUnQYoUkKbiTtnSX3LU3McE8rPzY4UuaWc
        84v2xU6UqNlZKlZg80is/xK0v1e520rmnq5CdT0=
X-Google-Smtp-Source: AGHT+IHD15Zhei2n5QVUIeyL6YizKp8fWevSHSxiGekm0f2F7dMYwMhIb/ZKuuwcPwUg2AnKj+kJ2JiPbzdxVUy2Igk=
X-Received: by 2002:a5d:618c:0:b0:314:21b:1ea2 with SMTP id
 j12-20020a5d618c000000b00314021b1ea2mr10329353wru.39.1692819496734; Wed, 23
 Aug 2023 12:38:16 -0700 (PDT)
MIME-Version: 1.0
Reply-To: unitednatiusa389@gmail.com
Sender: harritakipkalya@gmail.com
Received: by 2002:adf:cf09:0:b0:31a:eca9:e08 with HTTP; Wed, 23 Aug 2023
 12:38:16 -0700 (PDT)
From:   UNITED NATIONS HEADQUARTER OFFICE AMERICA 
        <unitednatiusa389@gmail.com>
Date:   Wed, 23 Aug 2023 12:38:16 -0700
X-Google-Sender-Auth: QEThN7z96Yyig_w6llebUdoScQA
Message-ID: <CA+ugitz3yVq=oZEU=VgiojSjMixtxZ9e_5muCfuZ+oWj1bLSJg@mail.gmail.com>
Subject: UNITED NATIONS HEADQUARTER OFFICE FROM NEW-YORK AMERICA
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Official Name:United States of America
Capitol:Washington
Population:318,814,000
Languages:English, Spanish, numerous others
Geographic Region:Americas Northern America
Geographic Size (km sq):9,526,468
Year of UN Membership:1945
Year of Present State Formation:1787
Current UN Representative:Mr.Dennis Francis

Greetings

This message is converting to you from united nation Headquarter from
New-York America to know what is exactly the reason of being
ungrateful to the received compensation fund, meanwhile you have to
explain to us how the fund was divided to each and every needful one
in your country because united nation compersated you with (=E2=82=AC
2,500,000.00 Million EUR ) to use part of the money and help orphan
and widowers including the people covid19 affected in your country for
our proper  documentary.

It had been officially known that out of the (150) lucky winners that
has received their compensation fund out there worldwide sum of (=E2=82=AC
2,500,000.00 Million EUR ) per each of the lucky winner as it was
listed in our list files and individuals, that was offered by United
Nations compensation in last year 2022,(149) has all returned back
with appreciation letter to united nation office remainder
you.Woodforest National Bank reported to united nation that they has
paid all the lucky winners,after we checked our file we saw that
(149)has come and thanked united nation and explained how they used
there money remaining you to complete the total number(150).we need
your urgent response for our proper documentry.

You are adviced to explain in details how the fund was divided to the
needful as the purpose on your reply mail.

Thank you in advance
Mr.Dennis Francis
PRESIDENT OF THE UNITED NATIONS GENERAL ASSEMBLY

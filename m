Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6383F7346D5
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 17:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjFRPk4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 11:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFRPk4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 11:40:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AED7E4F
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 08:40:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6664a9f0b10so1671853b3a.0
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687102854; x=1689694854;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YoVNkAV5H8CPBrHDfcXSFLQyT8Hkrr2iG7fwie/SF+4=;
        b=YB/YpaJJoWQy/C7qvN2867HtVnd4mQssyinbK/c1XIEPlbDzdQBypQgBEJiHGwUudX
         +0e/fQMfmd0claWXh3eGpaK6siSFdBasu9sqeOAqp50bQnDGJpuCZ2Gyuoags5Rlfamx
         BBAaPK3aGsLRtyw+6pV3zgtn932q4i168xnw5j5q0i0/otvgGjRr7udrjdHsXbu/76p3
         DkKrIkkZ9mGAfoDMYrMHmiIWDif9PgnnEaeMPQb0czVHO36F3rqrY3fx9OI52MRsDIQD
         kEf/8jdhM8xGBwiAebGVpn6YCw79pNVzo0eFn+4QmaVPSPU8xxTtLWXlLRSGDwbjFPYo
         qlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687102854; x=1689694854;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YoVNkAV5H8CPBrHDfcXSFLQyT8Hkrr2iG7fwie/SF+4=;
        b=UItNIqbA6GO+iRV+8eb2s1UK7/FuXAK89D1jdAUmimqHo4kFeecJhP7AqSE7mw9F8w
         ohpPSC5+nHWJAIjbxktNEojLv2F8baYJu8o8QT4fA9aHSfbZ3IRbV1YP9ogx4hWUfmJO
         NmJCNjoKwg/Flq9dFgIpT6XCmzZ9LqfxU6mgnIqUAvXbMRKz/PwDnAIJgij+ZcEpzw1g
         7MNuGkod6ta/K6OF6EF0V6Z50J0cu4sdn7/0tCWW7u5/eO9nZdStUZHRzdzvU0ta3Bo0
         54QDgvT0KbwxiWbiqnk/sKR235C6Ui6SW9w949sM4UsXVDNTsMAgFrgSRc7GWA/LmKeI
         Ml+A==
X-Gm-Message-State: AC+VfDwB+ShKGMvIcfeTHkMsev3l5E6Lg0Hf7w6TD/hmhkIyAmUq0OjT
        D3qWDSYLP5J3NCZ5GSGUil/T4TwgqUM=
X-Google-Smtp-Source: ACHHUZ5PdgMVcRPkK4x//QIEwMHwGFz/NA5HlXh4ufiyr1wxLaODpd9DvCnl1FHo/q0EOoMA5k56OQ==
X-Received: by 2002:a05:6a00:c83:b0:666:617a:c3b5 with SMTP id a3-20020a056a000c8300b00666617ac3b5mr8156918pfv.21.1687102854379;
        Sun, 18 Jun 2023 08:40:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l7-20020a62be07000000b0063b7f3250e9sm16240830pff.7.2023.06.18.08.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 08:40:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3f21adac-8a67-1789-22fb-86b2cd096ad2@roeck-us.net>
Date:   Sun, 18 Jun 2023 08:40:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Build error in stable queues
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Seen in linux-5.15.y-queue and older.

Building mips:defconfig ... failed
--------------
Error log:
arch/mips/kernel/cpu-probe.c: In function 'cpu_probe':
arch/mips/kernel/cpu-probe.c:2039:9: error: duplicate case value
  2039 |         case PRID_COMP_NETLOGIC:
       |         ^~~~
arch/mips/kernel/cpu-probe.c:2012:9: note: previously used here
  2012 |         case PRID_COMP_NETLOGIC:

Guenter

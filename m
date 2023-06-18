Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1017346D8
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 17:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFRPnh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 11:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFRPnf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 11:43:35 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6627CE4F
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 08:43:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6664a9f0b10so1672684b3a.0
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687103013; x=1689695013;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XO4FSqXrMIQws9nB6o08DkeH4/N8DYy1Br/NRxikx+s=;
        b=mpNjOs/pCUAOr4xERJrKtPrgSEwg1BrMtQ2QIvtvfVtVYe6JqweAhOqxH37oboJLqA
         6DftMwlX7QBeg7vXCHAuDenxm2pd7U9gSQBdex75DRzoxveyOQU5uRkmPWWEybMh7qVf
         zmF64lfq6nmT516IBB68Wfbek/rSmjALCv8bRWikd5OZqabTe8j7vZ7H4KlWzQQP+pKD
         YCQjfA+VyI22z5N9LqnDGlR1R8jaiPtby+6t90ifdA9ejTP//fAqXqEOYNTBCXmkOQKG
         cCh/+Zmp9AvrGxMe2uOiFlgy6SRQX8kaBCsdon3CWx5eqI3qkqSfK6yCY8S6wLsv6hFB
         YOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687103013; x=1689695013;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XO4FSqXrMIQws9nB6o08DkeH4/N8DYy1Br/NRxikx+s=;
        b=Q38GSQsNI1IN5TuwWp/tDAKmI+5KHwXmK907yXT1Aig1g7NyLeSkv9I44v4zx/dlEv
         CtHjecBS+4GA52WB1KcYaVhpwIO46qbDaWyufAR5ejF9ZCiJxhSlqbTcT4R+NcHVmeCn
         jPiJx2u6F7Jl7qfIP0yx8YG/2fmsQloH86rtRWXVNo0EQ4/aWOAp0phI/yzK8O7LaUWY
         or9jz5ghv9J1b83A+UN/qmFS0zkW1TFnkt4tvt7Dfhuhbu7oezb51H2osBliGI4ceq01
         0IlroQKCPsQl/jMTcbYsVqg4qhKAwcRkiBzw/PrEkcLFw2d7b3h40vKVfXy2tFLPAjYI
         jXAA==
X-Gm-Message-State: AC+VfDzGLv4JlAHXH1Y75QwzbYNN5S9lVJwC8Uejj8Vw/eG5EKhYUfwA
        uCPP5OMM/CzsPIGZd13HibONaJys5eg=
X-Google-Smtp-Source: ACHHUZ5RmHS8XKh5rBZ0Z6JlZgyfBfAN864zV74dTynIFODXCE23Q0jrhh4BmTwcFbDETBWgFGA8nA==
X-Received: by 2002:a05:6a20:1596:b0:10c:663c:31c3 with SMTP id h22-20020a056a20159600b0010c663c31c3mr7848459pzj.29.1687103013305;
        Sun, 18 Jun 2023 08:43:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j73-20020a638b4c000000b0052c22778e64sm3922928pge.66.2023.06.18.08.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 08:43:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d76bca14-4d95-2d6d-f51a-7c6071dcbdbd@roeck-us.net>
Date:   Sun, 18 Jun 2023 08:43:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Build error in v4.19.y.queue (parisc)
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

Building parisc64:a500_defconfig ... failed
--------------
Error log:
drivers/char/agp/parisc-agp.c: In function 'parisc_agp_tlbflush':
drivers/char/agp/parisc-agp.c:98:9: error: implicit declaration of function 'asm_io_sync' [-Werror=implicit-function-declaration]
    98 |         asm_io_sync();
       |         ^~~~~~~~~~~
drivers/char/agp/parisc-agp.c: In function 'parisc_agp_insert_memory':
drivers/char/agp/parisc-agp.c:168:25: error: implicit declaration of function 'asm_io_fdc' [-Werror=implicit-function-declaration]
   168 |                         asm_io_fdc(&info->gatt[j]);
       |                         ^~~~~~~~~~

Those functions are indeed not available in v4.1.y.

Guenter


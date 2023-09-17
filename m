Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BB07A35F7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 16:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjIQO60 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 10:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjIQO6T (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 10:58:19 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132D211B
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 07:58:14 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7955636f500so151473239f.1
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694962693; x=1695567493; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NWUbWA25YXqpror227XldM/36YXQGvWvbjMtDvGK5qY=;
        b=V9E9CWczyOa1J6XsGmVhGUvL4+t6pBsmehdZgBT7jz6DOGCIVCfGq3iCy/9PzReacd
         MbYDYQnMSVuoKrR3AFA9iT2dQT22D0GB8Rk2YMXDoe8H5y3zNjFkb8V5VFFOId+3LiS4
         BYKuiojEhFNvUkGLc4aZ4CLA4QzUnNKRac2X3NY+jVhJWvN6QOXPdfUMxOaUAorS25Rl
         gy2liyZIVmZlf5jWPMg15CVNCknJwFwzKESMRDv9AA/I8ZfwdHDf87fZZFDGs2Up4B4a
         cY70+QBBLaFVpLvyUA75A1afjx5Pg7LYJXF1aXwjsADEPLZ89yQ+X94nKnb+8xD9YBq6
         5dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694962693; x=1695567493;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NWUbWA25YXqpror227XldM/36YXQGvWvbjMtDvGK5qY=;
        b=I7FACKv+vHSnOdwU3JYwmkED3b9CoAodwfvzk2dw7FHs3NXbcwKMvytCH4CBqPgdNr
         w0+zUObPDc21G/X7TfWEsycVbDTnPZ5cWzlVx+S1IzaYuK+lIbXUC5U5FKCZVizkUcWw
         0KuywWDdQkAnNWTGKVe0OYJ8aU2HtFuTRkL3sK714mnrklWxoevo27eChQAAzzGZ4nES
         9fLCmC9x+knN2Sv7F1+ij/V/zGSflKtYJdrAbGmFMf+f0A/HobvmGNOOLLqbQn3UOGIH
         t255omw6BM8hKZi3kw6YyTOdceU5kh6kFoIARoJR0kpSYK21eqhmFh/VJJhTB7Jf3EFx
         eH7Q==
X-Gm-Message-State: AOJu0Yxrg8NVl+79xJTch7UzxW/KszU/ixYmlCtndkUERTKGdlvzS9GM
        gVnrl1x1cjRoXBQ1km9PD75q9ZLa0/I=
X-Google-Smtp-Source: AGHT+IEYPmMQACeN8Xc6Vufm/q+iag1Mt7cCX92L0bCwAlSqsdouwpoAkdNCjzJmGH37Kd+SoKUcpg==
X-Received: by 2002:a05:6e02:c24:b0:34c:cbd4:114b with SMTP id q4-20020a056e020c2400b0034ccbd4114bmr8602343ilg.7.1694962693127;
        Sun, 17 Sep 2023 07:58:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a4-20020a029f84000000b0042bb13cb80fsm2294934jam.120.2023.09.17.07.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 07:58:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8e198214-c12c-a921-ef7e-82b5e2f70ec2@roeck-us.net>
Date:   Sun, 17 Sep 2023 07:58:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     stable <stable@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Build failures in v{4.14, 4.19, 5.4, 5.10}.y.queue
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Building parisc:allnoconfig ... failed
--------------
Error log:
arch/parisc/kernel/processor.c: In function 'show_cpuinfo':
arch/parisc/kernel/processor.c:443:30: error: 'cpuinfo' undeclared (first use in this function)
   443 |                              cpuinfo->loops_per_jiffy / (500000 / HZ),

Caused by 'parisc: Fix /proc/cpuinfo output for lscpu' which
moves the declaration of cpuinfo inside an #ifdef but still uses
it outside of it in v5.10.y and older.

That either needs to be dropped, adjusted, or commit 93346da8ff47 ("parisc:
Drop loops_per_jiffy from per_cpu struct") needs to be applied as well
(tested with v5.10.y.queue).

Guenter

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2B37DE34B
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 16:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjKAPX2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 11:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjKAPX1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 11:23:27 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3083F111
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 08:23:21 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-457c19ebb3aso2686331137.1
        for <stable@vger.kernel.org>; Wed, 01 Nov 2023 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698852200; x=1699457000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LpZajEnIJ2wREzjcJFAnd+xRdxFoOFuiAGLAOylQOyA=;
        b=hi/EYlSbEfsnb7RLde/bDks4P92dExumyEXrPmIaMY24tcTDTAfnbdTJzcJjLCYvNN
         ZLYIOH6E/GRCpk6kuIab7PBffgQtz5vjxb6+mgGApC4TbatmPH781IDjkklw8noydWBg
         4RlC5N8SzbjJWPNPEuLy58jmwWb+ruNJV4l1fLr2KIqqKRy9hie6lyOev8gWl2X030Vv
         8HF+vbh+NnhnPk6BjLdKtd8DZLSraCa2qiNrbqMn4xtjYMoo+m6iGLdZYg9Xb79kX/P2
         J6hCY8nTctzFy5WXZsg9g8IvSIM1pz5TOZr4d3dkhv2R0PsZjruDbGEzngmeUvfMRgnl
         JPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698852200; x=1699457000;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LpZajEnIJ2wREzjcJFAnd+xRdxFoOFuiAGLAOylQOyA=;
        b=Ps+vE3OloIkiAXPwCBo/nHcO64Nb/PxsePiKdO3Nj0ak2aD5cDgkWaCEd/7Walyhe3
         gJHhyeby09MTEpHVBWhovHHw/e+j4VlVMYxdGSX9XZmH90pDgQrL0tbOBQHqgIUMzYK1
         Q9/Vb8ncK8a/wSRbXs41S2VGjQ4EAFhNnPW20C6vLVfQ1POExLy9iJ3F1VtvhoeOU6f1
         /FhYhfCpDPWAx5uW22RpTGbaiyjW6hQOAnH1rIyegwjhCbk3q+7rS9kob1grcnWgk4YJ
         MUw1g8GYRHSo4P0Jjj8YORyk+aVrLdNGcJHZg45By8N5DM8+5U4DeFaUHsw8L5UHnVKX
         FE+Q==
X-Gm-Message-State: AOJu0Yzt88OAqL+5qkRCiCYRf4sX6hSQwRCiVt9EaoSn9pLX2mWtBqq0
        s0I8IRfS+YcQAJRw5DpE726p4I8KJ43WWnvjsRhnn/YbUrXA70+Pvvrghg==
X-Google-Smtp-Source: AGHT+IFmGYTe0ry3QDJqyXVUt/kTXD2F0jl2TMHiZ4a44bCQkcPPfvcfXOEsj4bRb3/bbaeEXSIu3BCmlPI+l5Cr53I=
X-Received: by 2002:a67:c015:0:b0:452:6efc:1789 with SMTP id
 v21-20020a67c015000000b004526efc1789mr11439857vsi.32.1698852198425; Wed, 01
 Nov 2023 08:23:18 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 1 Nov 2023 20:53:07 +0530
Message-ID: <CA+G9fYsHeas7E0yDEKe3TUPU85zq98GszWbcuencULL3nYby4g@mail.gmail.com>
Subject: stable-rc: 5.4: arch/arm/mach-omap2/timer.c:51:10: fatal error:
 plat/counter-32k.h: No such file or directory
To:     linux-stable <stable@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

I see following build warnings / errors on stable-rc 5.4 branch.

arch/arm/mach-omap2/timer.c:51:10: fatal error: plat/counter-32k.h: No
such file or directory
   51 | #include <plat/counter-32k.h>
      |          ^~~~~~~~~~~~~~~~~~~~
compilation terminated.

Link:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2XXAJIrAB4GOy6jEODeH021cM2U/


- Naresh

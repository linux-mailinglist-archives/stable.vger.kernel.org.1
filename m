Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0DA78990B
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 22:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjHZUeU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 16:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjHZUdz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 16:33:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6A5196
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 13:33:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4018af1038cso19381965e9.0
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 13:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693082032; x=1693686832;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuBXyxO5VRkfmiSduOQc0d8U4bHaBkRBImnyuV2r9Co=;
        b=QZKpKZ8XfxRk5j/u4lAb7sRP3Z8jWkHNCXx8038eeYYxaiQglIjMwYu6ocFlrt+jvr
         fvRiEIy4qmfJ1tCd1JHJAL34nBoOK+I9zEo3eN/hBkanhWrPXYQMMaqXWWprmmhhng77
         ZpOIx0Uo2ffCZV+LLFIMqfaUv0Vb/TzVv3zHcabxIY5rgoAyGUxZz2Sn+V2ePM+cPkiI
         fTwY6l7iBC0iZJaKT7JoylazqP/l85FeHMJstZwwyLuI4j0dGKuid5Q2IXflQmZG5gwx
         tM3T7rJ47xpckgLqhvc3Si8P3y886eVdttum2x76mPlHgFGVrCYo4p4k3jOqYiewV4K3
         b2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693082032; x=1693686832;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uuBXyxO5VRkfmiSduOQc0d8U4bHaBkRBImnyuV2r9Co=;
        b=DNlpQurjEHmgBvtgDG/MgWNkBI63xzjQHl/JjMqIxpNXxj+LtLMRxAC033FX0jOdmk
         hLLapeMw5jUa9keCqYpVJbxqXmBs4xSkfhv7IoKCMU74JYuPO+iibQTM6wIUh6o0bnFt
         PUkDn8QUCIa0HkzJiJgf9j32l3s3n+Vs34AiMNggfJa22bzfc9KP1Q3Xxnn3sZcEp6G9
         j8PLQ1/nN57++ld6WKFv8wgjh0HynlAg/Xen40vCIDkPvn/2HjM0oG8y+BQrl8JkLRfk
         lR62tErUEY324UMqRiWQ1Vt68Ac1TzXZUJNejauLDzRqyMSGWWXCWodxBzlS+lj6cOAX
         cJRQ==
X-Gm-Message-State: AOJu0YxISC+NERGF1WrhxowyiVWVIcIDFaZ4LMdS+uhFNlgklepP4TIB
        /mwUpmIEur4NWdl62Npu2MPSDiZRZK/Zvg==
X-Google-Smtp-Source: AGHT+IFQrR+4XWYPtAmULJFnBb8HYuTxvfE3S2scsw+tj3UMmIHvkqcn2OBdi7ehLU5tygHUXsLvLA==
X-Received: by 2002:adf:ce02:0:b0:319:6b5e:85e3 with SMTP id p2-20020adfce02000000b003196b5e85e3mr14788255wrn.71.1693082031420;
        Sat, 26 Aug 2023 13:33:51 -0700 (PDT)
Received: from [192.168.43.213] (na-19-75-36.service.infuturo.it. [151.19.75.36])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d6144000000b00316eb7770b8sm5802171wrt.5.2023.08.26.13.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 13:33:50 -0700 (PDT)
Message-ID: <aa1649b6-b7a8-4fbe-8356-2c856951e283@gmail.com>
Date:   Sat, 26 Aug 2023 22:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Luca Pigliacampo <lucapgl2001@gmail.com>
Subject: [REGRESSION] [BISECTED] power button stopped working on lenovo
 ideapad 5 since a855724dc08b
To:     stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, linus.walleij@linaro.org,
        mario.limonciello@amd.com, Basavaraj.Natikar@amd.com,
        Shyam-sundar.S-k@amd.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

since the commit

a855724dc08b pinctrl: amd: Fix mistake in handling clearing pins at startup

after boot, pressing power button is detected just once and ignored 
afterwards.


product: IdeaPad 5 14ALC05

cpu: AMD Ryzen 5 5500U with Radeon Graphics

bios version: G5CN16WW(V1.04)

distro: Arch Linux

desktop environment: KDE Plasma 5.27.7


steps to reproduce:

boot the computer

log in

run sudo evtest

select event2

      (on my computer the power button is always represented by 
/dev/input/event2,

      i don't know if it's the same on others)

press the power button multiple times

     (might have to close the log out dialog depending on the DE)


expected behavior:

all the power button presses are recorded


observed behavior:

only the first power button press is recorded


i also have a desktop computer with a ryzen 5 2600x processor, but that 
isn't affected

#regzbot introduced: a855724dc08b


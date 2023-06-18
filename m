Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8966C7344F8
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 07:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjFRF2f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 01:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFRF2e (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 01:28:34 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54929123
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 22:28:33 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4716726b741so169078e0c.3
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 22:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687066112; x=1689658112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=819T+Hums9z0ALJaMfV4zVuKwKkgEHB36oxn/L470wg=;
        b=vFiBrMLa2ufylk3qqY7rw8oo1wZUyOzx7spgL7nWt8yaR7onpJJLx9Tgu/+/3pge4T
         wa764t40qoW8CCk/V69XJeH7Mo6/n7NLeGicVLbnQo6ihVb1GsqzQi6RmhRWxa+tNT0M
         bFFb9TdG7GaFi+/fcDTFRgH/IW9tp2nJy+JKoeLSF2x7anbtMVQ36e5YSQFHcHYTp7gx
         YX8zc49x6T+/7lVzN46UxTodosj548bL9O/9nagkZxdfdv1UkbOG6rCDbgQesX55i4Dr
         TcyiCu6UQd2UM5coNp78ORZFoNxr4kww4oPq0Nu0PQx9najeGLcaXUk75kM5dQ5mb2GK
         WtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687066112; x=1689658112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=819T+Hums9z0ALJaMfV4zVuKwKkgEHB36oxn/L470wg=;
        b=FAw9p9NPq2Luq88kAPxTxBhj7kE5Jxuy+jk43FrorHzdATtj9Fr7diHnTL5Cb/ouFd
         +r1jEFAcEMMfuK2A55EEm5dbLoPM0/aE4IdNlZS4RDMTPnOqETGdz+ZjNwZ/GGLmZU+X
         YEnD+IgdO7dvB3c7u5NmTwUiNCWNTtMR3DMmE9VUfHO/letI726L80VEbfAzBlPrqxWV
         9hN9KUngcFk80Pg6+g4B6AFB6KP/ZZRx4xUNHrJaXFNibACizIpgXk59KcLlrczx/E6y
         ABhHPbgpUuByry+JL6F4cQZQztofXeC09qZ0i/ZY0F3iVIFuYUURqqZOxKvHHesrw7yr
         EnQQ==
X-Gm-Message-State: AC+VfDylHWfidyopTXiuSp0BnfbrEWzOFvbCxBPjrNfhYaexrmFyz4xM
        eFxEgljrElImz4xb7aQz/FfEqrRHO0yAobtJnChbomaTzV5LL75zDrW+Fw==
X-Google-Smtp-Source: ACHHUZ41W+nn5g+eIQ+Px1fffx4Aqa3gBgoZDpWHuFBHcwBdrZDnPAMcH6/tff47Q2p45Ed1misAsrncFvfTb4IT/LM=
X-Received: by 2002:a05:6102:3016:b0:434:6958:cdbf with SMTP id
 s22-20020a056102301600b004346958cdbfmr680249vsa.18.1687066111963; Sat, 17 Jun
 2023 22:28:31 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 18 Jun 2023 10:58:21 +0530
Message-ID: <CA+G9fYueU5joKgRRgLgfBaRTx93B71UXMyueNR_NeA_HZTsvFQ@mail.gmail.com>
Subject: stable-rc-5.4.y: arch/mips/kernel/cpu-probe.c:2125:9: error:
 duplicate case value 2125 case PRID_COMP_NETLOGIC
To:     linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Following regressions found on stable rc 5.4 while building MIPS configs,

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

MIPS: Restore Au1300 support
[ Upstream commit f2041708dee30a3425f680265c337acd28293782 ]


Build log:
======
arch/mips/kernel/cpu-probe.c: In function 'cpu_probe':
arch/mips/kernel/cpu-probe.c:2125:9: error: duplicate case value
 2125 |         case PRID_COMP_NETLOGIC:
      |         ^~~~
arch/mips/kernel/cpu-probe.c:2099:9: note: previously used here
 2099 |         case PRID_COMP_NETLOGIC:
      |         ^~~~
make[3]: *** [scripts/Makefile.build:262: arch/mips/kernel/cpu-probe.o] Error 1

Links:

 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.247-33-g615b5c31a2ce/testrun/17568185/suite/build/test/gcc-12-rt305x_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.247-33-g615b5c31a2ce/testrun/17568185/suite/build/test/gcc-12-rt305x_defconfig/history/


--
Linaro LKFT
https://lkft.linaro.org

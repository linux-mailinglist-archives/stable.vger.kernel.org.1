Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF3F717262
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 02:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjEaA0B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 20:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEaA0A (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 20:26:00 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C134CC7
        for <stable@vger.kernel.org>; Tue, 30 May 2023 17:25:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d604cc0aaso4060739b3a.2
        for <stable@vger.kernel.org>; Tue, 30 May 2023 17:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685492758; x=1688084758;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fGT8ZjOYFBsLQ3R8UG/tvyNPBSjaivPF26ps0u2YwhI=;
        b=L39XkfI75GQp4DTd9rAFaXRv9DLkK1P9T+bbLS5+ynk0WEotu7gWxfHvl5nbeXhYlN
         rfJV0so2cDEDlyhmS69381vPt8q9bYimzybyoZu1wq4TH7Ibve5CWAEY5GcimmCmB4um
         +mM26ue/vD6QbfSUvDh0t3gNZRCgRpcnMP98dz2f4qUtJFghvRylgiGnJCaulawH7Gn/
         tUc7c6Ofe+karbG+rlwHe8kMlwUSI8Iv6e6sHWskrN3tWm6ngWgDm4Wm7jX5ZubbojHy
         kaCFfFFHupFlv8SopejZLT9oNP05Y/W7JiwYKw539sfJMH2D43XBOfQ1rg1gzJ3a0BBo
         q33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685492758; x=1688084758;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGT8ZjOYFBsLQ3R8UG/tvyNPBSjaivPF26ps0u2YwhI=;
        b=FrJepKuJEdQ0MccbrvqEEIBRlBKP17s3q7oGSv51ZuADoInTTzIyyWtBibh7Sy37dc
         GwjJaDu37RwqX/phn5HMh3cWLPloE/LBVzvETMfSFqXJjuptqzfPrQ8Zu54IKhxwvQ33
         TAjd+IdUgdBE6fmfuI+CMd/nCy9fqhTqnIDBteKwPhXZwQeYsuQSK9KUZrPKst0hW476
         VtYeSXWbkg/dbgwLNA12l51P0KPJgsDtAbLdx/G6OK++/ubZHWSNyZhV8l9+Rny1a9pv
         nN4TfF5OJwoSudkoUcZEyIOyS1ALcejEfJj8KOwjoXJshfcr38vCzu2rLotwk2NdUc0N
         56cA==
X-Gm-Message-State: AC+VfDxvnWqSxMnF65BotjNqRIInJg9+DDVoHygyGd9oezdqqCguhiVa
        2N5XJHQzPQTqVWbleGcBSC3gk09KkDcaHRb4taYp/Q==
X-Google-Smtp-Source: ACHHUZ7u5fNZWsJc53laGTgRgf5Vk1mCEBolsKBIRb4qUTiaoG00pFMu0x54+wMV0KJ8OBH82nplVw==
X-Received: by 2002:a17:903:32c6:b0:1ab:afd:903a with SMTP id i6-20020a17090332c600b001ab0afd903amr4053519plr.24.1685492757843;
        Tue, 30 May 2023 17:25:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902b60400b001a6f7744a27sm10910988pls.87.2023.05.30.17.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:25:57 -0700 (PDT)
Message-ID: <64769415.170a0220.8fb29.4edc@mx.google.com>
Date:   Tue, 30 May 2023 17:25:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.3
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.3.5-41-gb4d8aea953f2
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.3 baseline: 168 runs,
 2 regressions (v6.3.5-41-gb4d8aea953f2)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/queue/6.3 baseline: 168 runs, 2 regressions (v6.3.5-41-gb4d8aea95=
3f2)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi             | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.3/kern=
el/v6.3.5-41-gb4d8aea953f2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.3
  Describe: v6.3.5-41-gb4d8aea953f2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b4d8aea953f2c56242ef3d628ec37b2f52849e49 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi             | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476613289d9399b492e862c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.3/v6.3.5-41-=
gb4d8aea953f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/b=
aseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.3/v6.3.5-41-=
gb4d8aea953f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/b=
aseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6476613289d9399b492e8=
62d
        new failure (last pass: v6.3.5-41-g8b53689a0fb0) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64765e3e6c70d54f0b2e8671

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.3/v6.3.5-41-=
gb4d8aea953f2/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-lib=
retech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.3/v6.3.5-41-=
gb4d8aea953f2/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-lib=
retech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64765e3e6c70d54f0b2e8676
        failing since 0 day (last pass: v6.3.3-491-gda6d197f2db4, first fai=
l: v6.3.5-41-g8b53689a0fb0)

    2023-05-30T20:35:49.313105  / # #
    2023-05-30T20:35:49.414982  export SHELL=3D/bin/sh
    2023-05-30T20:35:49.415386  #
    2023-05-30T20:35:49.516848  / # export SHELL=3D/bin/sh. /lava-3632364/e=
nvironment
    2023-05-30T20:35:49.517304  =

    2023-05-30T20:35:49.618781  / # . /lava-3632364/environment/lava-363236=
4/bin/lava-test-runner /lava-3632364/1
    2023-05-30T20:35:49.619611  =

    2023-05-30T20:35:49.624740  / # /lava-3632364/bin/lava-test-runner /lav=
a-3632364/1
    2023-05-30T20:35:49.759714  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-30T20:35:49.760011  + cd /lava-3632364/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

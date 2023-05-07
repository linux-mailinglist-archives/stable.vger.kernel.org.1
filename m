Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AC56F9B42
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 22:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjEGUDu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 16:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjEGUDt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 16:03:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710531157E
        for <stable@vger.kernel.org>; Sun,  7 May 2023 13:03:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ab05018381so35601875ad.2
        for <stable@vger.kernel.org>; Sun, 07 May 2023 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683489826; x=1686081826;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y3/0KHPxxF1+GoVybuXVfMmNC/9neAA/7D6x+SP/1l0=;
        b=UF2T/DHfyoQkMcL8IqVLEYALo8cEUPl90PoIlb2MjK+TrU01Hp3DJ6sjMF35FS7hNc
         tDKgQpHSYJP8Gx6I+NY5FrFZXTtbmdgZGdWsRAoSm20fWdBX0Pbnurh6r6Q4IFkKm0Q2
         kvl2xkgTLUieCJSmr812SIVe/iibhblNv/4O7R8RRvztcXj/aq3UrThtwIoLWmsTGMp1
         madZCv0BIkMGU9lt47DW1N+OcGYjebp7mQduEzDYsuSYesZ5m8+iV717TuwBSNdjYx6Y
         nyIEn/MvkWyphgCYEu4ve1oMiI8scWQT913MbY4Dzp+7E6M/Dw0tAi/+MOhY+GzACzl9
         eu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683489826; x=1686081826;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3/0KHPxxF1+GoVybuXVfMmNC/9neAA/7D6x+SP/1l0=;
        b=jRid0xE6v3W6x0LYS7sA5Kb36n3B0nMB6haDrWHaFtw6+JGRIJsCS0t+qejmbwiBxm
         Jt6BJRU4f6uI/DLeA92cn3cJ2WSX50vsQKes5/v54xuqW8rt8ZfgqEaoSaZJ2LTd22Oi
         ejwdgsNC3eWi2vBOeXX5Hsf19R/ubphkSy6DcdS5ydhkQcmy8i6wJ/iP1Q0xk/rB/D6r
         tPzS6YQ4ZrmpBRmgwgFP4EjmQcOF/vEDllW9o70giwYESiTzJE79LOsj/FMLMTergGam
         Mr84lYY4l4nylbd4iEtpzb5MqIgPXLFfSHnzI72zRw9ooWHYK8nbOElrcTYQxzEwBu11
         glZQ==
X-Gm-Message-State: AC+VfDyBoDX9njsRjESWzRaycfN73oeD9V63mReB6SlktVv8TakW95VU
        ZBoo+taUqBQdzFrRsPR2HMFYG76kqu139PyFUs7mNA==
X-Google-Smtp-Source: ACHHUZ5Gwn7E+mkniUoS36r2u9HDWJCdUtZIGBdai4ifRI6CpirqIqX3yf1Oz7t8NQWhcvQnBI9Bow==
X-Received: by 2002:a17:902:7b87:b0:1aa:da53:dd9b with SMTP id w7-20020a1709027b8700b001aada53dd9bmr8001912pll.28.1683489826271;
        Sun, 07 May 2023 13:03:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jw21-20020a170903279500b001aaecc15d66sm5486443plb.289.2023.05.07.13.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 13:03:45 -0700 (PDT)
Message-ID: <64580421.170a0220.91acc.9552@mx.google.com>
Date:   Sun, 07 May 2023 13:03:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-1196-g571a2463c150b
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 158 runs,
 10 regressions (v6.1.22-1196-g571a2463c150b)
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

stable-rc/queue/6.1 baseline: 158 runs, 10 regressions (v6.1.22-1196-g571a2=
463c150b)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.22-1196-g571a2463c150b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-1196-g571a2463c150b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      571a2463c150be35d08d68a0d996a5064ea9e9cf =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457d3d0014197f0ac2e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457d3d0014197f0ac2e85f9
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T16:37:14.055684  + set +x

    2023-05-07T16:37:14.061898  <8>[   11.518129] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10230140_1.4.2.3.1>

    2023-05-07T16:37:14.164078  =


    2023-05-07T16:37:14.264696  / # #export SHELL=3D/bin/sh

    2023-05-07T16:37:14.264908  =


    2023-05-07T16:37:14.365464  / # export SHELL=3D/bin/sh. /lava-10230140/=
environment

    2023-05-07T16:37:14.365765  =


    2023-05-07T16:37:14.466278  / # . /lava-10230140/environment/lava-10230=
140/bin/lava-test-runner /lava-10230140/1

    2023-05-07T16:37:14.466637  =


    2023-05-07T16:37:14.472209  / # /lava-10230140/bin/lava-test-runner /la=
va-10230140/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457d334500af7e3e52e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457d334500af7e3e52e85ed
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T16:34:40.279365  + set<8>[   10.976450] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10230162_1.4.2.3.1>

    2023-05-07T16:34:40.279862   +x

    2023-05-07T16:34:40.386754  / # #

    2023-05-07T16:34:40.489203  export SHELL=3D/bin/sh

    2023-05-07T16:34:40.489932  #

    2023-05-07T16:34:40.591511  / # export SHELL=3D/bin/sh. /lava-10230162/=
environment

    2023-05-07T16:34:40.592232  =


    2023-05-07T16:34:40.693798  / # . /lava-10230162/environment/lava-10230=
162/bin/lava-test-runner /lava-10230162/1

    2023-05-07T16:34:40.694949  =


    2023-05-07T16:34:40.700171  / # /lava-10230162/bin/lava-test-runner /la=
va-10230162/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457d335c072b8205a2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457d335c072b8205a2e85eb
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T16:34:42.119483  <8>[   11.046707] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10230184_1.4.2.3.1>

    2023-05-07T16:34:42.122807  + set +x

    2023-05-07T16:34:42.228239  =


    2023-05-07T16:34:42.329962  / # #export SHELL=3D/bin/sh

    2023-05-07T16:34:42.330581  =


    2023-05-07T16:34:42.431906  / # export SHELL=3D/bin/sh. /lava-10230184/=
environment

    2023-05-07T16:34:42.432522  =


    2023-05-07T16:34:42.534038  / # . /lava-10230184/environment/lava-10230=
184/bin/lava-test-runner /lava-10230184/1

    2023-05-07T16:34:42.535118  =


    2023-05-07T16:34:42.540312  / # /lava-10230184/bin/lava-test-runner /la=
va-10230184/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457d335be5166f1d52e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457d335be5166f1d52e85ee
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T16:34:40.573687  + set +x

    2023-05-07T16:34:40.580542  <8>[   11.444603] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10230198_1.4.2.3.1>

    2023-05-07T16:34:40.684452  / # #

    2023-05-07T16:34:40.785130  export SHELL=3D/bin/sh

    2023-05-07T16:34:40.785336  #

    2023-05-07T16:34:40.885907  / # export SHELL=3D/bin/sh. /lava-10230198/=
environment

    2023-05-07T16:34:40.886132  =


    2023-05-07T16:34:40.986727  / # . /lava-10230198/environment/lava-10230=
198/bin/lava-test-runner /lava-10230198/1

    2023-05-07T16:34:40.987165  =


    2023-05-07T16:34:40.992174  / # /lava-10230198/bin/lava-test-runner /la=
va-10230198/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457d32da187ad3e992e8689

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457d32da187ad3e992e868e
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T16:34:39.731870  <8>[   10.726496] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10230185_1.4.2.3.1>

    2023-05-07T16:34:39.735350  + set +x

    2023-05-07T16:34:39.836641  #

    2023-05-07T16:34:39.836958  =


    2023-05-07T16:34:39.937556  / # #export SHELL=3D/bin/sh

    2023-05-07T16:34:39.937772  =


    2023-05-07T16:34:40.038361  / # export SHELL=3D/bin/sh. /lava-10230185/=
environment

    2023-05-07T16:34:40.038580  =


    2023-05-07T16:34:40.139132  / # . /lava-10230185/environment/lava-10230=
185/bin/lava-test-runner /lava-10230185/1

    2023-05-07T16:34:40.139427  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457d33fb84e8128b62e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457d33fb84e8128b62e8611
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T16:34:52.066986  + set<8>[   11.201000] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10230135_1.4.2.3.1>

    2023-05-07T16:34:52.067103   +x

    2023-05-07T16:34:52.171470  / # #

    2023-05-07T16:34:52.272086  export SHELL=3D/bin/sh

    2023-05-07T16:34:52.272304  #

    2023-05-07T16:34:52.372801  / # export SHELL=3D/bin/sh. /lava-10230135/=
environment

    2023-05-07T16:34:52.373022  =


    2023-05-07T16:34:52.473531  / # . /lava-10230135/environment/lava-10230=
135/bin/lava-test-runner /lava-10230135/1

    2023-05-07T16:34:52.473822  =


    2023-05-07T16:34:52.478504  / # /lava-10230135/bin/lava-test-runner /la=
va-10230135/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457d323a187ad3e992e867b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457d323a187ad3e992e8680
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T16:34:35.190821  + set<8>[   11.672651] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10230176_1.4.2.3.1>

    2023-05-07T16:34:35.190918   +x

    2023-05-07T16:34:35.295331  / # #

    2023-05-07T16:34:35.395997  export SHELL=3D/bin/sh

    2023-05-07T16:34:35.396200  #

    2023-05-07T16:34:35.496719  / # export SHELL=3D/bin/sh. /lava-10230176/=
environment

    2023-05-07T16:34:35.496987  =


    2023-05-07T16:34:35.597525  / # . /lava-10230176/environment/lava-10230=
176/bin/lava-test-runner /lava-10230176/1

    2023-05-07T16:34:35.597906  =


    2023-05-07T16:34:35.602692  / # /lava-10230176/bin/lava-test-runner /la=
va-10230176/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6457d0ed62392752702e8622

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6457d0ed62392752702e863e
        failing since 0 day (last pass: v6.1.22-704-ga3dcd1f09de2, first fa=
il: v6.1.22-1160-g24230ce6f2e2)

    2023-05-07T16:25:02.847697  /lava-10229853/1/../bin/lava-test-case

    2023-05-07T16:25:02.854403  <8>[   22.867301] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457d0ed62392752702e86ca
        failing since 0 day (last pass: v6.1.22-704-ga3dcd1f09de2, first fa=
il: v6.1.22-1160-g24230ce6f2e2)

    2023-05-07T16:24:57.423382  + set +x

    2023-05-07T16:24:57.429458  <8>[   17.441150] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10229853_1.5.2.3.1>

    2023-05-07T16:24:57.535204  / # #

    2023-05-07T16:24:57.635806  export SHELL=3D/bin/sh

    2023-05-07T16:24:57.636017  #

    2023-05-07T16:24:57.736576  / # export SHELL=3D/bin/sh. /lava-10229853/=
environment

    2023-05-07T16:24:57.736789  =


    2023-05-07T16:24:57.837349  / # . /lava-10229853/environment/lava-10229=
853/bin/lava-test-runner /lava-10229853/1

    2023-05-07T16:24:57.837654  =


    2023-05-07T16:24:57.842756  / # /lava-10229853/bin/lava-test-runner /la=
va-10229853/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6457cded6d86a8ee4c2e8603

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
96-g571a2463c150b/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6457cded6d86a8ee4c2e8=
604
        new failure (last pass: v6.1.22-1159-g8729cbdc1402) =

 =20

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8139C75D6C7
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 23:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjGUV5o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 17:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUV5o (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 17:57:44 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F44C9
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:57:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666e64e97e2so1548168b3a.1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689976661; x=1690581461;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=skgdr8urNjO+mCKYDQ7xZeWMoQFCBv+D8MKQNsfACxw=;
        b=zYkiase93YgFz1+/KXZgzj8Nb04EXzVbTT+wIn+7PUOpzadpBkEooNOodSpFMa+Cqc
         +nXVF9+c9CRXFWmBN0I3rfgfh6b/k/Zppiecm8tKDKC+/zln/vVgaZyJeiyuKJOEPJTm
         2UfKT3VCtoqOiLARFVrNoStQyYNNvBMW3sVNjEX4p1K3qsiDkGu609HsvLQkhJsLXs0m
         6kSxQwjjL0yQiCfZmPfN+vs5RQIJAOS/4eIBwoibcCaPo1X3BNQKv2bPWnlF4BPwacXU
         e1LDiMRANzOcyY9FcfAt+PLukL7AKiaNejooFPC8xRzjYKMzav/6x2zsqDQnMh+b5aHN
         z2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689976661; x=1690581461;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skgdr8urNjO+mCKYDQ7xZeWMoQFCBv+D8MKQNsfACxw=;
        b=he8kA8uZ9q0wC1aDW7hgCDAsrciwFC0wkM/gmiwnPls7rKFCC9QbB/z80/TcXgilRw
         njW0Ze1OmBaGE4rHE+KaNAemrQER8oxQuqKQOIicrLP8zM43MQ0hmVMBI8UcfLBwJuQr
         c3oxgQTbayUrA6Qu4iAxN7dqc+EPJIZWbO0hGvX/Yden0G5KX6/9P7oTCCP+3EqFp7Yl
         TR0BomkAaqxcyNagffPHsunIdtezcctvB7ksiJ+pqmVgiAKIjpc+EScKFkJaQQPQzmS9
         /3pRXLf0o0fwq79vMGC+BRLcO+SveL/da4XZs5oP1TrIIINDcoO9S+VxFrtsn05qRcwi
         aO+A==
X-Gm-Message-State: ABy/qLbYlVn2o4jU7R7nKFOaCE/TikE0NfteYbb73KFii3EQ/3766CwV
        nWqyrnSA5W+wSNzp44DnYsoy5eqUewQ6L1W+eHc=
X-Google-Smtp-Source: APBJJlG7ec5GjQSPYqeMGMfoXtdD0u1RW1lx8sgdUxHn/w6zd1l6y6PF5GkZr/XxaN7qF+Iagcu8Sg==
X-Received: by 2002:a05:6a00:1350:b0:65b:351a:e70a with SMTP id k16-20020a056a00135000b0065b351ae70amr1552004pfu.29.1689976661390;
        Fri, 21 Jul 2023 14:57:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k11-20020aa792cb000000b00682868714fdsm3541456pfa.95.2023.07.21.14.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 14:57:40 -0700 (PDT)
Message-ID: <64baff54.a70a0220.6bc9a.78fe@mx.google.com>
Date:   Fri, 21 Jul 2023 14:57:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Kernel: v5.4.249-278-g78f9a3d1c959
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.4.y baseline: 71 runs,
 4 regressions (v5.4.249-278-g78f9a3d1c959)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.4.y baseline: 71 runs, 4 regressions (v5.4.249-278-g78f9a=
3d1c959)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.249-278-g78f9a3d1c959/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.249-278-g78f9a3d1c959
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      78f9a3d1c959657b597bceaaf963b5d918b642a4 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64bac744e07b51a54b8ace3e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-278-g78f9a3d1c959/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-278-g78f9a3d1c959/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bac744e07b51a54b8ace43
        failing since 185 days (last pass: v5.4.226-68-g8c05f5e0777d, first=
 fail: v5.4.228-659-gb3b34c474ec7)

    2023-07-21T17:58:09.560743  <8>[    9.857724] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3724054_1.5.2.4.1>
    2023-07-21T17:58:09.673017  / # #
    2023-07-21T17:58:09.776661  export SHELL=3D/bin/sh
    2023-07-21T17:58:09.777867  #
    2023-07-21T17:58:09.880172  / # export SHELL=3D/bin/sh. /lava-3724054/e=
nvironment
    2023-07-21T17:58:09.880581  =

    2023-07-21T17:58:09.982108  / # . /lava-3724054/environment/lava-372405=
4/bin/lava-test-runner /lava-3724054/1
    2023-07-21T17:58:09.984210  =

    2023-07-21T17:58:09.989460  / # /lava-3724054/bin/lava-test-runner /lav=
a-3724054/1
    2023-07-21T17:58:10.033718  <3>[   10.320221] Bluetooth: hci0: command =
0xfc18 tx timeout =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bac7125912a988998ace3c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-278-g78f9a3d1c959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-278-g78f9a3d1c959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bac7125912a988998ace41
        failing since 113 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-07-21T17:57:53.909927  + set<8>[   10.271471] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11124173_1.4.2.3.1>

    2023-07-21T17:57:53.910014   +x

    2023-07-21T17:57:54.011151  / #

    2023-07-21T17:57:54.111932  # #export SHELL=3D/bin/sh

    2023-07-21T17:57:54.112151  =


    2023-07-21T17:57:54.212643  / # export SHELL=3D/bin/sh. /lava-11124173/=
environment

    2023-07-21T17:57:54.212864  =


    2023-07-21T17:57:54.313390  / # . /lava-11124173/environment/lava-11124=
173/bin/lava-test-runner /lava-11124173/1

    2023-07-21T17:57:54.313685  =


    2023-07-21T17:57:54.318242  / # /lava-11124173/bin/lava-test-runner /la=
va-11124173/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bac7168ead1fecd68ace20

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-278-g78f9a3d1c959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-278-g78f9a3d1c959/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bac7168ead1fecd68ace25
        failing since 113 days (last pass: v5.4.238, first fail: v5.4.238)

    2023-07-21T17:57:25.808602  + set<8>[   10.310535] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11124178_1.4.2.3.1>

    2023-07-21T17:57:25.808700   +x

    2023-07-21T17:57:25.910376  #

    2023-07-21T17:57:26.011185  / # #export SHELL=3D/bin/sh

    2023-07-21T17:57:26.011385  =


    2023-07-21T17:57:26.111899  / # export SHELL=3D/bin/sh. /lava-11124178/=
environment

    2023-07-21T17:57:26.112141  =


    2023-07-21T17:57:26.212648  / # . /lava-11124178/environment/lava-11124=
178/bin/lava-test-runner /lava-11124178/1

    2023-07-21T17:57:26.212956  =


    2023-07-21T17:57:26.217865  / # /lava-11124178/bin/lava-test-runner /la=
va-11124178/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64bac70e66695f2e1f8ace41

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-278-g78f9a3d1c959/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.249=
-278-g78f9a3d1c959/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64bac70e66695f2e1f8ace46
        failing since 185 days (last pass: v5.4.227, first fail: v5.4.228-6=
59-gb3b34c474ec7)

    2023-07-21T17:57:18.665549  <8>[    7.840801] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3724058_1.5.2.4.1>
    2023-07-21T17:57:18.771325  / # #
    2023-07-21T17:57:18.873165  export SHELL=3D/bin/sh
    2023-07-21T17:57:18.873570  #
    2023-07-21T17:57:18.975036  / # export SHELL=3D/bin/sh. /lava-3724058/e=
nvironment
    2023-07-21T17:57:18.975445  =

    2023-07-21T17:57:19.076893  / # . /lava-3724058/environment/lava-372405=
8/bin/lava-test-runner /lava-3724058/1
    2023-07-21T17:57:19.077663  =

    2023-07-21T17:57:19.081916  / # /lava-3724058/bin/lava-test-runner /lav=
a-3724058/1
    2023-07-21T17:57:19.145997  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20

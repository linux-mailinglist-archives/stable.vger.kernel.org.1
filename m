Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65C1712D6A
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 21:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbjEZT1c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 15:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbjEZT13 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 15:27:29 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81461B6
        for <stable@vger.kernel.org>; Fri, 26 May 2023 12:27:20 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5346d150972so1001331a12.3
        for <stable@vger.kernel.org>; Fri, 26 May 2023 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685129240; x=1687721240;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xxyFjv8y0awkVDhNWSNIdN8WRhpcdsHZe32CIwx/JkY=;
        b=bNAaMBiP+Hym/UNcu8sbgxqh98XVIq4dCh1dYu20CB5Gv+EDHQ8chlyXCZhy90QtCv
         YKtLqF+4biVWOiO6lz5+09LD0HiTjoKCgQx5BN9Hvuoqb/UBCeS1piJpM+K6VAHxSnpI
         KMCxq3C1D/ThVec+twp92B8dgJ29lJad7xHBr3uaAKkiYNHCKZi+m5kbp1YjAwKaH1CP
         q8Lu4cYVKW7RptDbu6geAGVhNVXh640mx5ccqgk/pisvemDwokSwosR0mYFeI7uFJF1g
         3uF1X9vdAlIbefHTdPOICeiSWmR2xmDcs3eHERe1Y6csya6wylmAbONbSplYFOzh1frk
         kbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129240; x=1687721240;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxyFjv8y0awkVDhNWSNIdN8WRhpcdsHZe32CIwx/JkY=;
        b=R29uqhYPmrOAqZbyrzIPNpM63ntCK2ohBfnEHK22JpJRjEmKQ7M6gcPk/lH9REQnsZ
         oT+1aE5VIrx2aPb9wteDyA5ti3ERFuyQ/wV/gu9B6VIW2njEitW6IkcQV35biWIPUsDM
         eH+CHEL/wEOfQqy+jeX45GbQIl0STQaK4kQ0xFMYxV59pLcikVz1rd2TIlS5y1+M40nj
         ACRDtO7DHxe6/BR9sGHJ4zZi0EuNgMtM2ZBof3DUZFvTGWUkVMC64qiefV0H3BwnuBfv
         23kDPhBHhywZo8sgPqmUBdq4ku2IW9E8dvsfi4+qTSoc8VZZFa89QKcTdUxiglsIqt4P
         nLYQ==
X-Gm-Message-State: AC+VfDy2tBmBWsEXeakwdYRIzjeyISV6wrdoRBEGO4ZdBiJ/HjJwGHcj
        xWEOhNqQta2iJbvcorCgeQS2CFNV1nzzavuCxewlZQ==
X-Google-Smtp-Source: ACHHUZ6QetXPZwMMqLLJEJb97LzHvFMKS3cqWpaVV35X9oHUw/KSIyDo6kyI6mt3lxgpKZ3v+pNYhA==
X-Received: by 2002:a05:6a20:8e05:b0:10c:4e7f:1a5a with SMTP id y5-20020a056a208e0500b0010c4e7f1a5amr457598pzj.49.1685129239641;
        Fri, 26 May 2023 12:27:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x16-20020a1709027c1000b001aadd0d7364sm3611698pll.83.2023.05.26.12.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:27:19 -0700 (PDT)
Message-ID: <64710817.170a0220.cecf4.7d54@mx.google.com>
Date:   Fri, 26 May 2023 12:27:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-304-g13ee4424b4d8
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 179 runs,
 8 regressions (v6.1.29-304-g13ee4424b4d8)
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

stable-rc/queue/6.1 baseline: 179 runs, 8 regressions (v6.1.29-304-g13ee442=
4b4d8)

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

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.29-304-g13ee4424b4d8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-304-g13ee4424b4d8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      13ee4424b4d88596fea660ca90d921319c6f4df8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d13a6edf7f8e1f2e86ba

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470d13a6edf7f8e1f2e86bf
        failing since 58 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T15:32:56.505338  + set +x

    2023-05-26T15:32:56.512154  <8>[   10.601412] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10467480_1.4.2.3.1>

    2023-05-26T15:32:56.613942  #

    2023-05-26T15:32:56.714826  / # #export SHELL=3D/bin/sh

    2023-05-26T15:32:56.715023  =


    2023-05-26T15:32:56.815530  / # export SHELL=3D/bin/sh. /lava-10467480/=
environment

    2023-05-26T15:32:56.815789  =


    2023-05-26T15:32:56.916355  / # . /lava-10467480/environment/lava-10467=
480/bin/lava-test-runner /lava-10467480/1

    2023-05-26T15:32:56.916742  =


    2023-05-26T15:32:56.922416  / # /lava-10467480/bin/lava-test-runner /la=
va-10467480/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d12fcfe25a76fc2e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470d12fcfe25a76fc2e85f8
        failing since 58 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T15:32:49.314368  + set<8>[   11.821783] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10467453_1.4.2.3.1>

    2023-05-26T15:32:49.314931   +x

    2023-05-26T15:32:49.422949  / # #

    2023-05-26T15:32:49.525449  export SHELL=3D/bin/sh

    2023-05-26T15:32:49.526361  #

    2023-05-26T15:32:49.627863  / # export SHELL=3D/bin/sh. /lava-10467453/=
environment

    2023-05-26T15:32:49.628656  =


    2023-05-26T15:32:49.730133  / # . /lava-10467453/environment/lava-10467=
453/bin/lava-test-runner /lava-10467453/1

    2023-05-26T15:32:49.731309  =


    2023-05-26T15:32:49.736248  / # /lava-10467453/bin/lava-test-runner /la=
va-10467453/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d146794d6683a42e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470d146794d6683a42e8607
        failing since 58 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T15:33:06.396608  <8>[   11.243767] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10467419_1.4.2.3.1>

    2023-05-26T15:33:06.399716  + set +x

    2023-05-26T15:33:06.500987  #

    2023-05-26T15:33:06.501304  =


    2023-05-26T15:33:06.601926  / # #export SHELL=3D/bin/sh

    2023-05-26T15:33:06.602167  =


    2023-05-26T15:33:06.702647  / # export SHELL=3D/bin/sh. /lava-10467419/=
environment

    2023-05-26T15:33:06.702855  =


    2023-05-26T15:33:06.803401  / # . /lava-10467419/environment/lava-10467=
419/bin/lava-test-runner /lava-10467419/1

    2023-05-26T15:33:06.803686  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d6d0e11ecbbdc52e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6470d6d0e11ecbbdc52e8=
5e7
        failing since 36 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d27dd5547f24d52e85fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470d27dd5547f24d52e8601
        failing since 58 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T15:38:21.379345  + set +x

    2023-05-26T15:38:21.385434  <8>[   10.862896] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10467478_1.4.2.3.1>

    2023-05-26T15:38:21.490392  / # #

    2023-05-26T15:38:21.590997  export SHELL=3D/bin/sh

    2023-05-26T15:38:21.591208  #

    2023-05-26T15:38:21.691721  / # . /lava-10467478/environment

    2023-05-26T15:38:21.822627  export SHELL=3D/bin/sh

    2023-05-26T15:38:21.923206  / # . /lava-/lava-10467478/bin/lava-test-ru=
nner /lava-10467478/1

    2023-05-26T15:38:21.923510  10467478/environment

    2023-05-26T15:38:21.927950  / # /lava-10467478/bin/lava-test-runner /la=
va-10467478/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d1236edf7f8e1f2e867a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470d1236edf7f8e1f2e867f
        failing since 58 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T15:32:38.366069  <8>[    9.948111] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10467410_1.4.2.3.1>

    2023-05-26T15:32:38.369493  + set +x

    2023-05-26T15:32:38.473477  / # #

    2023-05-26T15:32:38.574279  export SHELL=3D/bin/sh

    2023-05-26T15:32:38.574540  #

    2023-05-26T15:32:38.675139  / # export SHELL=3D/bin/sh. /lava-10467410/=
environment

    2023-05-26T15:32:38.675354  =


    2023-05-26T15:32:38.775895  / # . /lava-10467410/environment/lava-10467=
410/bin/lava-test-runner /lava-10467410/1

    2023-05-26T15:32:38.776304  =


    2023-05-26T15:32:38.781659  / # /lava-10467410/bin/lava-test-runner /la=
va-10467410/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d148794d6683a42e8624

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470d148794d6683a42e8629
        failing since 58 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T15:33:05.711585  + <8>[   10.961815] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10467443_1.4.2.3.1>

    2023-05-26T15:33:05.711673  set +x

    2023-05-26T15:33:05.816388  / # #

    2023-05-26T15:33:05.917023  export SHELL=3D/bin/sh

    2023-05-26T15:33:05.917223  #

    2023-05-26T15:33:06.017737  / # export SHELL=3D/bin/sh. /lava-10467443/=
environment

    2023-05-26T15:33:06.017957  =


    2023-05-26T15:33:06.118510  / # . /lava-10467443/environment/lava-10467=
443/bin/lava-test-runner /lava-10467443/1

    2023-05-26T15:33:06.118928  =


    2023-05-26T15:33:06.123538  / # /lava-10467443/bin/lava-test-runner /la=
va-10467443/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6470d12a2e9a7019272e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-30=
4-g13ee4424b4d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6470d12a2e9a7019272e85f8
        failing since 58 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-26T15:32:43.104566  + set<8>[   11.668925] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10467442_1.4.2.3.1>

    2023-05-26T15:32:43.105238   +x

    2023-05-26T15:32:43.214489  / # #

    2023-05-26T15:32:43.316047  export SHELL=3D/bin/sh

    2023-05-26T15:32:43.316843  #

    2023-05-26T15:32:43.418120  / # export SHELL=3D/bin/sh. /lava-10467442/=
environment

    2023-05-26T15:32:43.418471  =


    2023-05-26T15:32:43.519157  / # . /lava-10467442/environment/lava-10467=
442/bin/lava-test-runner /lava-10467442/1

    2023-05-26T15:32:43.519471  =


    2023-05-26T15:32:43.524393  / # /lava-10467442/bin/lava-test-runner /la=
va-10467442/1
 =

    ... (12 line(s) more)  =

 =20

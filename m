Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1836F972B
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 08:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEGGcl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 02:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEGGck (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 02:32:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC7D13C08
        for <stable@vger.kernel.org>; Sat,  6 May 2023 23:32:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aaf706768cso25351815ad.0
        for <stable@vger.kernel.org>; Sat, 06 May 2023 23:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683441157; x=1686033157;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EZnQ7Tc8/P3KaQDo8MiN/je0o4aHnxsACe0nOURCwOQ=;
        b=Vrv4EWPn2GT55oFHjBBsk8K8jU8zO0Ys8SHS/U/3EOjD/yu1DvTr010nBvAz0cwYhS
         Gyyt1EHQHCGGrNdzFvuJioU2RTqVOh8R7bzHx+LNMqrjVa9eblWJXzk3M0TcGrwbcQLL
         DkZ8berkEJ+93mw4LAhmrtns87Dd/yThbqe8DAVU8Gppfvl4lCDkISAipl3vM2n3dNCA
         +i4cut2q4n+2344Lb22mSObWceejFi79GPaZSRZYblcI3jPyNbN91V7QLrCB0q3v9nAf
         HM136wWaVFIVj7xwiOxLbT5jaeCnnNlB4g37uLXcBPvFrs00CCtmgVBlzssN/wXxSPuo
         WSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683441157; x=1686033157;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZnQ7Tc8/P3KaQDo8MiN/je0o4aHnxsACe0nOURCwOQ=;
        b=M099WBvGUe5QigbC+WA1DMwfdnAnngDVP6Pq3B3WmcOhEtMkdC7Ii90Ve928Ij03c8
         gSgw/3ANYqGCryXb5BL5ix4BA0s1LEOSw4WHnKGiqhAtMimRvWApFc2Pbty4nAu6FA1O
         EMYgXD3NZ8ATDrsUCyh3wt67ywmjsAuz2AXJ6WtkFNJ0DpdHr5Qmi0FiHyt3ZEo7d5Tn
         9kNwoWtiUCxn4lfxQH6kBd2etNZMU/cGDwzk1PMChlrTaHqDugE9Z5A0DDcwQZNkPLAS
         2nArdoz7c4NhmOa65jHOyINyVHWEvurkM8i7TkKqV+WhDVXDbZ94hTEd/Wq21Etcl30i
         el/w==
X-Gm-Message-State: AC+VfDy43+Loj1XIzXugbRAHXbFcIvTn6igX2vRCF8sdRm0fzuQX5ci5
        I2ZMG80VIgT69YVsswt4SR1k7BiIkQwVHUdSdagTDA==
X-Google-Smtp-Source: ACHHUZ7JQ4ZVm8PGugsftc1SVJy3DyH8ZuIaSNc8ZBinUmq4bn9LxVCIN9RdU4zy9jhT6rG7fWFoIA==
X-Received: by 2002:a17:902:ea8b:b0:1a0:50bd:31a8 with SMTP id x11-20020a170902ea8b00b001a050bd31a8mr6570076plb.26.1683441157183;
        Sat, 06 May 2023 23:32:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090341d200b001ab2b415bdbsm4643265ple.45.2023.05.06.23.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 23:32:36 -0700 (PDT)
Message-ID: <64574604.170a0220.b7352.813a@mx.google.com>
Date:   Sat, 06 May 2023 23:32:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-1160-g24230ce6f2e2
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 164 runs,
 10 regressions (v6.1.22-1160-g24230ce6f2e2)
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

stable-rc/queue/6.1 baseline: 164 runs, 10 regressions (v6.1.22-1160-g24230=
ce6f2e2)

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

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.22-1160-g24230ce6f2e2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-1160-g24230ce6f2e2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      24230ce6f2e2a72f5ef682680fe6bbe46cd967a8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64570d208fa750477d2e8618

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64570d208fa750477d2e861d
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T02:29:36.214748  <8>[   10.776209] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10220874_1.4.2.3.1>

    2023-05-07T02:29:36.217784  + set +x

    2023-05-07T02:29:36.318988  / #

    2023-05-07T02:29:36.419833  # #export SHELL=3D/bin/sh

    2023-05-07T02:29:36.420047  =


    2023-05-07T02:29:36.520659  / # export SHELL=3D/bin/sh. /lava-10220874/=
environment

    2023-05-07T02:29:36.520849  =


    2023-05-07T02:29:36.621396  / # . /lava-10220874/environment/lava-10220=
874/bin/lava-test-runner /lava-10220874/1

    2023-05-07T02:29:36.621687  =


    2023-05-07T02:29:36.627499  / # /lava-10220874/bin/lava-test-runner /la=
va-10220874/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64570d1651c7b05f432e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64570d1651c7b05f432e85f8
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T02:29:19.465911  + set<8>[   11.803158] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10220858_1.4.2.3.1>

    2023-05-07T02:29:19.466002   +x

    2023-05-07T02:29:19.569945  / # #

    2023-05-07T02:29:19.670556  export SHELL=3D/bin/sh

    2023-05-07T02:29:19.670750  #

    2023-05-07T02:29:19.771266  / # export SHELL=3D/bin/sh. /lava-10220858/=
environment

    2023-05-07T02:29:19.771465  =


    2023-05-07T02:29:19.871930  / # . /lava-10220858/environment/lava-10220=
858/bin/lava-test-runner /lava-10220858/1

    2023-05-07T02:29:19.872178  =


    2023-05-07T02:29:19.876959  / # /lava-10220858/bin/lava-test-runner /la=
va-10220858/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64570d158fa750477d2e85ec

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64570d158fa750477d2e85f1
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T02:29:34.950476  <8>[   10.537136] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10220880_1.4.2.3.1>

    2023-05-07T02:29:34.953813  + set +x

    2023-05-07T02:29:35.059736  =


    2023-05-07T02:29:35.161507  / # #export SHELL=3D/bin/sh

    2023-05-07T02:29:35.162239  =


    2023-05-07T02:29:35.263923  / # export SHELL=3D/bin/sh. /lava-10220880/=
environment

    2023-05-07T02:29:35.264589  =


    2023-05-07T02:29:35.366059  / # . /lava-10220880/environment/lava-10220=
880/bin/lava-test-runner /lava-10220880/1

    2023-05-07T02:29:35.366641  =


    2023-05-07T02:29:35.371734  / # /lava-10220880/bin/lava-test-runner /la=
va-10220880/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64570d04f63a35dc142e85f2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64570d04f63a35dc142e85f7
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T02:29:18.105894  + set +x

    2023-05-07T02:29:18.112946  <8>[   11.746561] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10220830_1.4.2.3.1>

    2023-05-07T02:29:18.217120  / # #

    2023-05-07T02:29:18.317715  export SHELL=3D/bin/sh

    2023-05-07T02:29:18.317916  #

    2023-05-07T02:29:18.418418  / # export SHELL=3D/bin/sh. /lava-10220830/=
environment

    2023-05-07T02:29:18.418603  =


    2023-05-07T02:29:18.519118  / # . /lava-10220830/environment/lava-10220=
830/bin/lava-test-runner /lava-10220830/1

    2023-05-07T02:29:18.519395  =


    2023-05-07T02:29:18.524368  / # /lava-10220830/bin/lava-test-runner /la=
va-10220830/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64570d1fc7ccf0bfe72e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64570d1fc7ccf0bfe72e85eb
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T02:29:31.946865  + set +x

    2023-05-07T02:29:31.953506  <8>[   10.830643] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10220886_1.4.2.3.1>

    2023-05-07T02:29:32.057818  / # #

    2023-05-07T02:29:32.158416  export SHELL=3D/bin/sh

    2023-05-07T02:29:32.158574  #

    2023-05-07T02:29:32.259089  / # export SHELL=3D/bin/sh. /lava-10220886/=
environment

    2023-05-07T02:29:32.259256  =


    2023-05-07T02:29:32.359782  / # . /lava-10220886/environment/lava-10220=
886/bin/lava-test-runner /lava-10220886/1

    2023-05-07T02:29:32.360074  =


    2023-05-07T02:29:32.365459  / # /lava-10220886/bin/lava-test-runner /la=
va-10220886/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64570d1442fb77f1862e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64570d1542fb77f1862e8607
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T02:29:17.974021  + set<8>[   11.087219] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10220841_1.4.2.3.1>

    2023-05-07T02:29:17.974128   +x

    2023-05-07T02:29:18.078939  / # #

    2023-05-07T02:29:18.179622  export SHELL=3D/bin/sh

    2023-05-07T02:29:18.179806  #

    2023-05-07T02:29:18.280301  / # export SHELL=3D/bin/sh. /lava-10220841/=
environment

    2023-05-07T02:29:18.280527  =


    2023-05-07T02:29:18.381102  / # . /lava-10220841/environment/lava-10220=
841/bin/lava-test-runner /lava-10220841/1

    2023-05-07T02:29:18.381436  =


    2023-05-07T02:29:18.386085  / # /lava-10220841/bin/lava-test-runner /la=
va-10220841/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64570d033df18ad72d2e8610

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64570d033df18ad72d2e8615
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T02:29:09.434810  + set<8>[   11.943498] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10220866_1.4.2.3.1>

    2023-05-07T02:29:09.435345   +x

    2023-05-07T02:29:09.542629  / # #

    2023-05-07T02:29:09.644748  export SHELL=3D/bin/sh

    2023-05-07T02:29:09.645400  #

    2023-05-07T02:29:09.746745  / # export SHELL=3D/bin/sh. /lava-10220866/=
environment

    2023-05-07T02:29:09.747531  =


    2023-05-07T02:29:09.848858  / # . /lava-10220866/environment/lava-10220=
866/bin/lava-test-runner /lava-10220866/1

    2023-05-07T02:29:09.850033  =


    2023-05-07T02:29:09.854650  / # /lava-10220866/bin/lava-test-runner /la=
va-10220866/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64571526b0d60315592e862e

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64571526b0d60315592e8632
        new failure (last pass: v6.1.22-704-ga3dcd1f09de2)

    2023-05-07T03:03:55.709829  /lava-10221688/1/../bin/lava-test-case

    2023-05-07T03:03:55.716505  <8>[   22.938023] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64571527b0d60315592e86d6
        new failure (last pass: v6.1.22-704-ga3dcd1f09de2)

    2023-05-07T03:03:50.261927  + set +x

    2023-05-07T03:03:50.268042  <8>[   17.488337] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10221688_1.5.2.3.1>

    2023-05-07T03:03:50.376738  / # #

    2023-05-07T03:03:50.478793  export SHELL=3D/bin/sh

    2023-05-07T03:03:50.479107  #

    2023-05-07T03:03:50.579933  / # export SHELL=3D/bin/sh. /lava-10221688/=
environment

    2023-05-07T03:03:50.580748  =


    2023-05-07T03:03:50.682360  / # . /lava-10221688/environment/lava-10221=
688/bin/lava-test-runner /lava-10221688/1

    2023-05-07T03:03:50.683784  =


    2023-05-07T03:03:50.688551  / # /lava-10221688/bin/lava-test-runner /la=
va-10221688/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64571132b6153457262e8638

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-=
pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g24230ce6f2e2/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-=
pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64571132b6153457262e8=
639
        new failure (last pass: v6.1.22-704-ga3dcd1f09de2) =

 =20

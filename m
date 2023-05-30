Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D31D71581D
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 10:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjE3IP1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 04:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjE3IPZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 04:15:25 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C40990
        for <stable@vger.kernel.org>; Tue, 30 May 2023 01:15:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d341bdedcso2975142b3a.3
        for <stable@vger.kernel.org>; Tue, 30 May 2023 01:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685434522; x=1688026522;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c5Yz2gKYhgkRACaa/sN5hQjLp9tK4F8C9XdMH4n/iYw=;
        b=vm03sKAWQjHCOiYXpmFWzMf6Ke9atY7VatWc5ONnvAuhEnz/lY+TupHHdqfgR+CQUH
         0AIsZ0Q/OPM+fYC/7gAHFvYGgfUC43PhBN6nGbtDRDLbvJ7KWY5AKc1+qt7b8vQnOolF
         qHASUwVCPaS+Bm9Y8oFPjbgZjvfuq3bFaT9oDfe19zV38OvquNapshuUMLuvMyihybCg
         yUte9ubft6oYQebBib1x9jA0l33dViXgU11SffHe8B4Xg+2rn5HorWi3od7zrZ9UCIUA
         tUgb0CZWRZsHyuMtmL+3toDzBszzZzxesWJmvSGQwlFD4ToKgp55xGs6G1dDoJ9t+oZo
         tr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685434522; x=1688026522;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5Yz2gKYhgkRACaa/sN5hQjLp9tK4F8C9XdMH4n/iYw=;
        b=kSKp+0Q3kOyrBOcl6w39MQQtPz97cCfuAv3u7SuaKGaPKis60/hs3EyGlGfdPY98y0
         jPyWHf14W+2uVsvwp9QSBWaI2CQCzJc04qO8ZVoHTpc7P1gqJX/uRq/aMBQd8rY+BAmP
         z4Y2GV3haclc+hE2da5KqJ+SjG4Wa0fTB8OIT+pPR6t4SGMS9orDeVHn3vOdihbPOCOi
         sWauTtfBPCNf8G36/C/Vo4B5c6Y11IMCbRf/fr2ysdxEqS9NnzW7ZJ+YvmipcmurypNW
         L1XtcYrm83Qkn8jtwuX6ocFdhtvHF3aMUPLdCPYCNroPkal2AirDR8xFRQA9qPzcVuL3
         Opuw==
X-Gm-Message-State: AC+VfDxMLU++gagZLh/hnvpP4FBtJ/Kb9RUeuBull2JfCT2CT+jnxoYX
        EtfiXlmtkzOdcHCYvcZs6xRUOJda5owcoGAWKywxwQ==
X-Google-Smtp-Source: ACHHUZ6+4UwYi8rG0XDnl9f9MhLXwNAvg1RzaWYq8FnEPvXnCHDND5UWITpSa9utY/kwKE7KbwFsxA==
X-Received: by 2002:a05:6a20:840c:b0:10f:f672:6e88 with SMTP id c12-20020a056a20840c00b0010ff6726e88mr2129652pzd.4.1685434522291;
        Tue, 30 May 2023 01:15:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z5-20020aa791c5000000b0064fabbc047dsm1117757pfa.55.2023.05.30.01.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:15:21 -0700 (PDT)
Message-ID: <6475b099.a70a0220.242c9.226f@mx.google.com>
Date:   Tue, 30 May 2023 01:15:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-412-gfd06e1e96910
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 162 runs,
 8 regressions (v6.1.29-412-gfd06e1e96910)
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

stable-rc/queue/6.1 baseline: 162 runs, 8 regressions (v6.1.29-412-gfd06e1e=
96910)

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
el/v6.1.29-412-gfd06e1e96910/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-412-gfd06e1e96910
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fd06e1e969109cad293bee405211d9eb1e2ea258 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64757e029d211070392e85fb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64757e029d211070392e8600
        failing since 62 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-30T04:39:05.415953  <8>[    7.930985] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10518378_1.4.2.3.1>

    2023-05-30T04:39:05.419462  + set +x

    2023-05-30T04:39:05.526626  / # #

    2023-05-30T04:39:05.628702  export SHELL=3D/bin/sh

    2023-05-30T04:39:05.629350  #

    2023-05-30T04:39:05.730681  / # export SHELL=3D/bin/sh. /lava-10518378/=
environment

    2023-05-30T04:39:05.731342  =


    2023-05-30T04:39:05.832640  / # . /lava-10518378/environment/lava-10518=
378/bin/lava-test-runner /lava-10518378/1

    2023-05-30T04:39:05.833674  =


    2023-05-30T04:39:05.839663  / # /lava-10518378/bin/lava-test-runner /la=
va-10518378/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64757cc3eefc69290e2e85fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64757cc3eefc69290e2e8601
        failing since 62 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-30T04:33:45.141859  + set<8>[   11.500994] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10518447_1.4.2.3.1>

    2023-05-30T04:33:45.141969   +x

    2023-05-30T04:33:45.245608  / # #

    2023-05-30T04:33:45.346105  export SHELL=3D/bin/sh

    2023-05-30T04:33:45.346260  #

    2023-05-30T04:33:45.446724  / # export SHELL=3D/bin/sh. /lava-10518447/=
environment

    2023-05-30T04:33:45.446914  =


    2023-05-30T04:33:45.547419  / # . /lava-10518447/environment/lava-10518=
447/bin/lava-test-runner /lava-10518447/1

    2023-05-30T04:33:45.547745  =


    2023-05-30T04:33:45.552532  / # /lava-10518447/bin/lava-test-runner /la=
va-10518447/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64757ccceefc69290e2e8653

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64757ccceefc69290e2e8658
        failing since 62 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-30T04:34:00.179839  <8>[   11.137329] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10518443_1.4.2.3.1>

    2023-05-30T04:34:00.183541  + set +x

    2023-05-30T04:34:00.289932  =


    2023-05-30T04:34:00.391666  / # #export SHELL=3D/bin/sh

    2023-05-30T04:34:00.391862  =


    2023-05-30T04:34:00.492388  / # export SHELL=3D/bin/sh. /lava-10518443/=
environment

    2023-05-30T04:34:00.492576  =


    2023-05-30T04:34:00.593186  / # . /lava-10518443/environment/lava-10518=
443/bin/lava-test-runner /lava-10518443/1

    2023-05-30T04:34:00.593830  =


    2023-05-30T04:34:00.598677  / # /lava-10518443/bin/lava-test-runner /la=
va-10518443/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64757d301381eb99bc2e85fb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64757d301381eb99bc2e8=
5fc
        failing since 39 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64757d021e7990fc1d2e8670

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64757d021e7990fc1d2e8675
        failing since 62 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-30T04:34:58.926389  + set +x

    2023-05-30T04:34:58.932999  <8>[   12.900313] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10518366_1.4.2.3.1>

    2023-05-30T04:34:59.037155  / # #

    2023-05-30T04:34:59.137869  export SHELL=3D/bin/sh

    2023-05-30T04:34:59.138074  #

    2023-05-30T04:34:59.238621  / # export SHELL=3D/bin/sh. /lava-10518366/=
environment

    2023-05-30T04:34:59.238873  =


    2023-05-30T04:34:59.339388  / # . /lava-10518366/environment/lava-10518=
366/bin/lava-test-runner /lava-10518366/1

    2023-05-30T04:34:59.339733  =


    2023-05-30T04:34:59.344423  / # /lava-10518366/bin/lava-test-runner /la=
va-10518366/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64757cadfc9089430a2e85fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64757cadfc9089430a2e8603
        failing since 62 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-30T04:33:32.567013  <8>[   10.642030] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10518396_1.4.2.3.1>

    2023-05-30T04:33:32.570828  + set +x

    2023-05-30T04:33:32.672388  #

    2023-05-30T04:33:32.672705  =


    2023-05-30T04:33:32.773294  / # #export SHELL=3D/bin/sh

    2023-05-30T04:33:32.773496  =


    2023-05-30T04:33:32.873972  / # export SHELL=3D/bin/sh. /lava-10518396/=
environment

    2023-05-30T04:33:32.874184  =


    2023-05-30T04:33:32.974737  / # . /lava-10518396/environment/lava-10518=
396/bin/lava-test-runner /lava-10518396/1

    2023-05-30T04:33:32.975015  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64757cc2eefc69290e2e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64757cc2eefc69290e2e85f6
        failing since 62 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-30T04:33:45.558726  + <8>[   10.855094] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10518428_1.4.2.3.1>

    2023-05-30T04:33:45.558834  set +x

    2023-05-30T04:33:45.663397  / # #

    2023-05-30T04:33:45.764014  export SHELL=3D/bin/sh

    2023-05-30T04:33:45.764226  #

    2023-05-30T04:33:45.864753  / # export SHELL=3D/bin/sh. /lava-10518428/=
environment

    2023-05-30T04:33:45.864953  =


    2023-05-30T04:33:45.965553  / # . /lava-10518428/environment/lava-10518=
428/bin/lava-test-runner /lava-10518428/1

    2023-05-30T04:33:45.965890  =


    2023-05-30T04:33:45.970458  / # /lava-10518428/bin/lava-test-runner /la=
va-10518428/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64757caffe306565d12e8606

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-41=
2-gfd06e1e96910/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64757caffe306565d12e860b
        failing since 62 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-30T04:33:35.030347  <8>[   12.619020] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10518397_1.4.2.3.1>

    2023-05-30T04:33:35.135042  / # #

    2023-05-30T04:33:35.235628  export SHELL=3D/bin/sh

    2023-05-30T04:33:35.235810  #

    2023-05-30T04:33:35.336282  / # export SHELL=3D/bin/sh. /lava-10518397/=
environment

    2023-05-30T04:33:35.336485  =


    2023-05-30T04:33:35.436969  / # . /lava-10518397/environment/lava-10518=
397/bin/lava-test-runner /lava-10518397/1

    2023-05-30T04:33:35.437245  =


    2023-05-30T04:33:35.441654  / # /lava-10518397/bin/lava-test-runner /la=
va-10518397/1

    2023-05-30T04:33:35.448295  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =20

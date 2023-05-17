Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04B07073FF
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 23:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjEQVT1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 17:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjEQVTO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 17:19:14 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123696596
        for <stable@vger.kernel.org>; Wed, 17 May 2023 14:18:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae3a5dfa42so10445485ad.0
        for <stable@vger.kernel.org>; Wed, 17 May 2023 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684358311; x=1686950311;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1YWViE8pAcpn10KffTJJbt78Sd9aXfi8bbR3KbmXnYk=;
        b=HHGgViwPSg1KkqEtbGH7zlWptJONlfAt0ovpyRGWiKipDnGmviTFuyqPOW5M7sQaqb
         iNoh9Md5QdzWEvcJ58HqyKYEysoTVq7FghllT5Ylj2QbPK0Avx/SPMaeE6st4h+fv+oX
         6simLjA7DtigYCa5cumTZZ6Q03hJpCCAgUDbi6BK8PDy3WxtCAiB4im4SDoMmYWqvRPb
         Of7/Rap9VL5qJNgaJoaaytR5aOXikULPRb5SWWg/EPHJHkL5CZarrBPlOI7z7ZeUU5ev
         sskyVfVc5Ybs40YiNbtWMZqmKqbAICoFaKnHeaqNLL6eVkKklykjA7lsPRRley9ftmgX
         UCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358311; x=1686950311;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YWViE8pAcpn10KffTJJbt78Sd9aXfi8bbR3KbmXnYk=;
        b=Xx0r1/4HroLA9f95zYmZexC4mdGgUY7LwKVKE48+Ot2EwttPK2fmsd90OI/pm9Zc6O
         io25qKDiQc8EeCVigLns5tne49Jc6F7UMbfpFhrgLJSoLPcJPsEIQPaIM+ZDZHNJpSU1
         PXv6/F60PBc/rozek4CS7K08vyWQwsP5XYHPeTitKyRpVQkNpyQ2k50OxLWi5WXm0j7y
         A4mU1BeMV0+lXKyNHFxk4gJTcYFgToDbKWlZip/N2kIYEAqdHEhB7FkyyajUaV32TTpv
         g+N145xDqeIrLOGmTcpLhRkn8OLEjtwJtGDYv/N0/cBwNdR/TOW4Jdf0FThZ5VAkmAYW
         zqtA==
X-Gm-Message-State: AC+VfDzhsa6hhKnb5vab0ffEWtgYHbKRz868dmy9mSG1wJd6wLO4knyM
        JoWSCJMEQdWWv+JaNm8gnGzwGvRyVobeJDdL7/Vh1A==
X-Google-Smtp-Source: ACHHUZ6R4hYsZ1Cjh5jo/O/UyFsTPsS9Q3CHyyX7noBTX1ilgOmW/Q8SNaE/iQLDu+riZ1V0q+mokQ==
X-Received: by 2002:a17:902:d50e:b0:1ab:1351:979e with SMTP id b14-20020a170902d50e00b001ab1351979emr247727plg.10.1684358310836;
        Wed, 17 May 2023 14:18:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709026b4400b001aaf536b1e3sm16454896plt.123.2023.05.17.14.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:18:30 -0700 (PDT)
Message-ID: <646544a6.170a0220.1b18a.0523@mx.google.com>
Date:   Wed, 17 May 2023 14:18:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 153 runs, 7 regressions (v6.1.29)
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

stable-rc/queue/6.1 baseline: 153 runs, 7 regressions (v6.1.29)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.29/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fa74641fb6b93a19ccb50579886ecc98320230f9 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6465142931a601cbd42e8653

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C43=
6FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C43=
6FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6465142931a601cbd42e8658
        failing since 49 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-17T17:51:16.280088  <8>[   10.493190] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10359441_1.4.2.3.1>

    2023-05-17T17:51:16.283314  + set +x

    2023-05-17T17:51:16.387869  #

    2023-05-17T17:51:16.490256  / # #export SHELL=3D/bin/sh

    2023-05-17T17:51:16.490480  =


    2023-05-17T17:51:16.591119  / # export SHELL=3D/bin/sh. /lava-10359441/=
environment

    2023-05-17T17:51:16.591461  =


    2023-05-17T17:51:16.692299  / # . /lava-10359441/environment/lava-10359=
441/bin/lava-test-runner /lava-10359441/1

    2023-05-17T17:51:16.693051  =


    2023-05-17T17:51:16.698377  / # /lava-10359441/bin/lava-test-runner /la=
va-10359441/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646512f43f49642c772e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM1=
400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM1=
400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646512f43f49642c772e85fb
        failing since 49 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-17T17:46:10.977393  + set<8>[   12.300550] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10359384_1.4.2.3.1>

    2023-05-17T17:46:10.977551   +x

    2023-05-17T17:46:11.082272  / # #

    2023-05-17T17:46:11.183151  export SHELL=3D/bin/sh

    2023-05-17T17:46:11.183436  #

    2023-05-17T17:46:11.284081  / # export SHELL=3D/bin/sh. /lava-10359384/=
environment

    2023-05-17T17:46:11.284366  =


    2023-05-17T17:46:11.385032  / # . /lava-10359384/environment/lava-10359=
384/bin/lava-test-runner /lava-10359384/1

    2023-05-17T17:46:11.385475  =


    2023-05-17T17:46:11.390295  / # /lava-10359384/bin/lava-test-runner /la=
va-10359384/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646512fe3f49642c772e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx9=
400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx9=
400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646512fe3f49642c772e8607
        failing since 49 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-17T17:46:13.893551  <8>[    8.556136] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10359381_1.4.2.3.1>

    2023-05-17T17:46:13.896905  + set +x

    2023-05-17T17:46:13.998277  =


    2023-05-17T17:46:14.098841  / # #export SHELL=3D/bin/sh

    2023-05-17T17:46:14.099001  =


    2023-05-17T17:46:14.199530  / # export SHELL=3D/bin/sh. /lava-10359381/=
environment

    2023-05-17T17:46:14.199693  =


    2023-05-17T17:46:14.300243  / # . /lava-10359381/environment/lava-10359=
381/bin/lava-test-runner /lava-10359381/1

    2023-05-17T17:46:14.300524  =


    2023-05-17T17:46:14.305279  / # /lava-10359381/bin/lava-test-runner /la=
va-10359381/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6465133b56817366d72e8620

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-=
12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-=
12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6465133b56817366d72e8625
        failing since 49 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-17T17:47:22.524987  + set +x

    2023-05-17T17:47:22.531215  <8>[   10.732001] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10359439_1.4.2.3.1>

    2023-05-17T17:47:22.635839  / # #

    2023-05-17T17:47:22.736500  export SHELL=3D/bin/sh

    2023-05-17T17:47:22.736710  #

    2023-05-17T17:47:22.837249  / # export SHELL=3D/bin/sh. /lava-10359439/=
environment

    2023-05-17T17:47:22.837463  =


    2023-05-17T17:47:22.938018  / # . /lava-10359439/environment/lava-10359=
439/bin/lava-test-runner /lava-10359439/1

    2023-05-17T17:47:22.938312  =


    2023-05-17T17:47:22.943495  / # /lava-10359439/bin/lava-test-runner /la=
va-10359439/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646512e0c3fc06a75c2e8682

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-=
14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-=
14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646512e0c3fc06a75c2e8687
        failing since 49 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-17T17:45:55.947875  + set +x

    2023-05-17T17:45:55.954453  <8>[   10.990854] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10359389_1.4.2.3.1>

    2023-05-17T17:45:56.058992  / # #

    2023-05-17T17:45:56.159796  export SHELL=3D/bin/sh

    2023-05-17T17:45:56.160020  #

    2023-05-17T17:45:56.260633  / # export SHELL=3D/bin/sh. /lava-10359389/=
environment

    2023-05-17T17:45:56.260875  =


    2023-05-17T17:45:56.361524  / # . /lava-10359389/environment/lava-10359=
389/bin/lava-test-runner /lava-10359389/1

    2023-05-17T17:45:56.361997  =


    2023-05-17T17:45:56.366618  / # /lava-10359389/bin/lava-test-runner /la=
va-10359389/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646512fae0f405de1b2e85ed

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-=
14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-=
14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646512fae0f405de1b2e85f2
        failing since 49 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-17T17:46:12.159382  + set<8>[   11.221306] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10359434_1.4.2.3.1>

    2023-05-17T17:46:12.159924   +x

    2023-05-17T17:46:12.267502  / # #

    2023-05-17T17:46:12.369945  export SHELL=3D/bin/sh

    2023-05-17T17:46:12.370672  #

    2023-05-17T17:46:12.472148  / # export SHELL=3D/bin/sh. /lava-10359434/=
environment

    2023-05-17T17:46:12.472989  =


    2023-05-17T17:46:12.574510  / # . /lava-10359434/environment/lava-10359=
434/bin/lava-test-runner /lava-10359434/1

    2023-05-17T17:46:12.575767  =


    2023-05-17T17:46:12.580558  / # /lava-10359434/bin/lava-test-runner /la=
va-10359434/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646512fc13449c9cf02e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-T=
Pad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29/x8=
6_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-T=
Pad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646512fc13449c9cf02e85eb
        failing since 49 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-17T17:46:19.348182  + set<8>[   11.476242] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10359461_1.4.2.3.1>

    2023-05-17T17:46:19.348346   +x

    2023-05-17T17:46:19.452800  / # #

    2023-05-17T17:46:19.553565  export SHELL=3D/bin/sh

    2023-05-17T17:46:19.553807  #

    2023-05-17T17:46:19.654371  / # export SHELL=3D/bin/sh. /lava-10359461/=
environment

    2023-05-17T17:46:19.654582  =


    2023-05-17T17:46:19.755104  / # . /lava-10359461/environment/lava-10359=
461/bin/lava-test-runner /lava-10359461/1

    2023-05-17T17:46:19.755476  =


    2023-05-17T17:46:19.760863  / # /lava-10359461/bin/lava-test-runner /la=
va-10359461/1
 =

    ... (12 line(s) more)  =

 =20

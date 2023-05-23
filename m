Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D843970E9D0
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 01:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbjEWXyI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 19:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238855AbjEWXyI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 19:54:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2DDE5
        for <stable@vger.kernel.org>; Tue, 23 May 2023 16:54:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso152310b3a.1
        for <stable@vger.kernel.org>; Tue, 23 May 2023 16:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684886045; x=1687478045;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GH67N3Qt6AwA8f2Oj4m/kB87zMRAM7vSojPcH9WgoCU=;
        b=U9gH/ICnkZ+tM2ByH7n738wLmKfEvn0su9nfN9/f4ld/86Gr3gwQDzFbSJQU1Wco6P
         YLfeb5rKcHzSdgT1z3ulaqGz2dPWBN0x+YcjHNKn2MZItpmXm7Bc4xamqAJDFlLRVkM2
         EBPpswpasAjaxi5CrAAdax57arZUsX49t3LRot40gNE/7qCo4LybpwJ8U/YZm/Sz3K/N
         Cn9Enkaz21wvOoZeMBehUbavy4+hVVVVt8P5Ik9Oqc0twoUp6i18PbQDf4Alc0wEzrsm
         8CHC+H42YkPAuaDrU0n3zPL7mq5qCleQqMqh8lGqVxYwg7AbtZxsw+d5twY6irQlsihh
         0xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684886045; x=1687478045;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GH67N3Qt6AwA8f2Oj4m/kB87zMRAM7vSojPcH9WgoCU=;
        b=XWx82uOw/Coxr51IyulYTuajIBFYbP9trk/zzFl7Z12ctwKmJij3dH21IUkRqO4nrv
         lTeXM5ielTfamKMtSSpQVS0HFDQy4nSAMKJo8Dq+fasuzDhc8VFpxa++ec7MVjoEav/7
         LPYZWiMX4WB4TNKcaf+Fvs084ksULuZNNyd0k64aq52APbZgKnRr0Ey7XhDezucLHxDf
         kvk5J/renJmteQp0XbeYj54c8ItkF0sRUiiW25JNEkEpo0wbjfqhKCxol0lcnaBAP7iI
         X+zsosdoWef6AvPl5vvufvei/E2G06Nt5lOAj1FJJzQgwZTFQgv23I+gOYzdNNzJqSi/
         YrMg==
X-Gm-Message-State: AC+VfDwzpCeMBj5aox3qdt+CS16hF8t60JWqF0/NAikOR1cnDkogQOz2
        Y3P8x2QsdU7YqE1XTV0N8TogjKmV0mi/5iWleTZ/rQ==
X-Google-Smtp-Source: ACHHUZ5J20kEmP3GPOJb2fFawNv7RGouZbvMOU4wDvCVMG58W0XYlbmIUW9aoP6HXDOnEnsayUMiYg==
X-Received: by 2002:a05:6a00:10c4:b0:646:6cc3:4a52 with SMTP id d4-20020a056a0010c400b006466cc34a52mr905913pfu.3.1684886045160;
        Tue, 23 May 2023 16:54:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g4-20020aa78184000000b00643355ff6a6sm6406980pfi.99.2023.05.23.16.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 16:54:04 -0700 (PDT)
Message-ID: <646d521c.a70a0220.90255.bb0a@mx.google.com>
Date:   Tue, 23 May 2023 16:54:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-203-g1fc93ce5abbc
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 158 runs,
 7 regressions (v5.15.112-203-g1fc93ce5abbc)
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

stable-rc/queue/5.15 baseline: 158 runs, 7 regressions (v5.15.112-203-g1fc9=
3ce5abbc)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
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
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-203-g1fc93ce5abbc/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-203-g1fc93ce5abbc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1fc93ce5abbcc5d28e2f0226485501a6639f8bff =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646d20eaeb5239d9312e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-g1fc93ce5abbc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-g1fc93ce5abbc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d20eaeb5239d9312e85ed
        failing since 56 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-23T20:23:49.321921  + <8>[   11.836034] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10430067_1.4.2.3.1>

    2023-05-23T20:23:49.322006  set +x

    2023-05-23T20:23:49.426358  / # #

    2023-05-23T20:23:49.526994  export SHELL=3D/bin/sh

    2023-05-23T20:23:49.527244  #

    2023-05-23T20:23:49.627768  / # export SHELL=3D/bin/sh. /lava-10430067/=
environment

    2023-05-23T20:23:49.627939  =


    2023-05-23T20:23:49.728414  / # . /lava-10430067/environment/lava-10430=
067/bin/lava-test-runner /lava-10430067/1

    2023-05-23T20:23:49.728673  =


    2023-05-23T20:23:49.733215  / # /lava-10430067/bin/lava-test-runner /la=
va-10430067/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646d20fb7ba83c64b32e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-g1fc93ce5abbc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-g1fc93ce5abbc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d20fb7ba83c64b32e85eb
        failing since 56 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-23T20:24:05.773407  <8>[   10.501271] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10430089_1.4.2.3.1>

    2023-05-23T20:24:05.776483  + set +x

    2023-05-23T20:24:05.877676  #

    2023-05-23T20:24:05.877928  =


    2023-05-23T20:24:05.978512  / # #export SHELL=3D/bin/sh

    2023-05-23T20:24:05.978702  =


    2023-05-23T20:24:06.079240  / # export SHELL=3D/bin/sh. /lava-10430089/=
environment

    2023-05-23T20:24:06.079448  =


    2023-05-23T20:24:06.179996  / # . /lava-10430089/environment/lava-10430=
089/bin/lava-test-runner /lava-10430089/1

    2023-05-23T20:24:06.180303  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646d20f93c563eed772e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-g1fc93ce5abbc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-g1fc93ce5abbc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d20f93c563eed772e8605
        failing since 56 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-23T20:24:13.068639  + set +x

    2023-05-23T20:24:13.075498  <8>[   10.460752] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10430068_1.4.2.3.1>

    2023-05-23T20:24:13.179817  / # #

    2023-05-23T20:24:13.280400  export SHELL=3D/bin/sh

    2023-05-23T20:24:13.280638  #

    2023-05-23T20:24:13.381155  / # export SHELL=3D/bin/sh. /lava-10430068/=
environment

    2023-05-23T20:24:13.381363  =


    2023-05-23T20:24:13.481932  / # . /lava-10430068/environment/lava-10430=
068/bin/lava-test-runner /lava-10430068/1

    2023-05-23T20:24:13.482251  =


    2023-05-23T20:24:13.486737  / # /lava-10430068/bin/lava-test-runner /la=
va-10430068/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646d20df8d6e77c83e2e85fb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-g1fc93ce5abbc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-g1fc93ce5abbc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d20df8d6e77c83e2e8600
        failing since 56 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-23T20:23:42.944942  + set +x

    2023-05-23T20:23:42.951278  <8>[   11.199507] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10430063_1.4.2.3.1>

    2023-05-23T20:23:43.055677  / # #

    2023-05-23T20:23:43.156328  export SHELL=3D/bin/sh

    2023-05-23T20:23:43.156533  #

    2023-05-23T20:23:43.257061  / # export SHELL=3D/bin/sh. /lava-10430063/=
environment

    2023-05-23T20:23:43.257295  =


    2023-05-23T20:23:43.357866  / # . /lava-10430063/environment/lava-10430=
063/bin/lava-test-runner /lava-10430063/1

    2023-05-23T20:23:43.358150  =


    2023-05-23T20:23:43.363465  / # /lava-10430063/bin/lava-test-runner /la=
va-10430063/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646d20e73c563eed772e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-g1fc93ce5abbc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-g1fc93ce5abbc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d20e73c563eed772e85eb
        failing since 56 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-23T20:24:00.196067  + set<8>[   10.531990] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10430102_1.4.2.3.1>

    2023-05-23T20:24:00.196195   +x

    2023-05-23T20:24:00.300390  / # #

    2023-05-23T20:24:00.401035  export SHELL=3D/bin/sh

    2023-05-23T20:24:00.401308  #

    2023-05-23T20:24:00.501874  / # export SHELL=3D/bin/sh. /lava-10430102/=
environment

    2023-05-23T20:24:00.502147  =


    2023-05-23T20:24:00.602719  / # . /lava-10430102/environment/lava-10430=
102/bin/lava-test-runner /lava-10430102/1

    2023-05-23T20:24:00.603053  =


    2023-05-23T20:24:00.608040  / # /lava-10430102/bin/lava-test-runner /la=
va-10430102/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646d20e78d6e77c83e2e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-g1fc93ce5abbc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-g1fc93ce5abbc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d20e78d6e77c83e2e8617
        failing since 56 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-23T20:23:49.994831  + <8>[    9.198636] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10430073_1.4.2.3.1>

    2023-05-23T20:23:49.994916  set +x

    2023-05-23T20:23:50.099228  / # #

    2023-05-23T20:23:50.199800  export SHELL=3D/bin/sh

    2023-05-23T20:23:50.200013  #

    2023-05-23T20:23:50.300527  / # export SHELL=3D/bin/sh. /lava-10430073/=
environment

    2023-05-23T20:23:50.300713  =


    2023-05-23T20:23:50.401278  / # . /lava-10430073/environment/lava-10430=
073/bin/lava-test-runner /lava-10430073/1

    2023-05-23T20:23:50.401527  =


    2023-05-23T20:23:50.406359  / # /lava-10430073/bin/lava-test-runner /la=
va-10430073/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/646d1fe2c6c743bb2c2e862c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-g1fc93ce5abbc/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-g1fc93ce5abbc/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646d1fe2c6c743bb2c2e8=
62d
        new failure (last pass: v5.15.112-203-gd61c066794251) =

 =20

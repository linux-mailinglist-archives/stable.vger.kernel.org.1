Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B148C7018E7
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 20:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbjEMSCN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 14:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbjEMSBj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 14:01:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F57B2D48
        for <stable@vger.kernel.org>; Sat, 13 May 2023 11:00:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64ab2a37812so11352069b3a.1
        for <stable@vger.kernel.org>; Sat, 13 May 2023 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684000779; x=1686592779;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1tZRt9pTkqZ/6yMrKVOjuY2xl/QSxdfZxnRtmTte+mM=;
        b=xzJlAVOGpqQ0r8UMKfLf3b+CbWsZVPogjlUXNWnn/ePLafQXYtXxvPtgp/sG/iKoFe
         ZjpgWYV6+rO8GrnnagQkVo+mvkwDUUJq4pXn7/8smahO18rG+DciOneHZAbTnQoLv132
         /UNPOFOJl7CRz8zJEDS1kf4FYCkw2RbDtfe0KgHDCUoHaIxaViVLlwzcB+0jjZLzDtaA
         DaOM7EOFr0mBJ27778lB8YFhBuo/YP1coFLSQKC1OjeWBjxGfoSwscoiJIYh6GaHAMQ4
         OcQd/wZXXFx835uxV/k5YTra4BAMRZqLSWd36RUj+MzQxLWnDTfxcC2b5RvTTJesQUxR
         DD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684000779; x=1686592779;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tZRt9pTkqZ/6yMrKVOjuY2xl/QSxdfZxnRtmTte+mM=;
        b=Z/p4awgw2xmDe9MFenjYaeX2iaCU6Rt3h4kg/wQQWXvJXo5g4ypgfgqB5n4lwihkyc
         uHhL28gQChytJXB0WF+Jrsqvv9n1HwvctZD6HchyDNzIG2wAOxxKoYf7lUOlZnT9bYyY
         3t4GGqolK0jCgBplFWhPJAv9V8whMjta8LuVflnuuzHBp7FZZ57tLUTcZt+JgNhPbSPp
         CBmnZsPD9W+kEoXg912yIdtKaQbbz2vvFUJarhl1pT2qjdFQ7isrAcYiYLqGO/GOxCYf
         otdBjPnSSXT9uGrRqiQwN/YifZQ6KrNhghjMVOWvoHgnLCCJWT3hEf0Y3QnkTF6nrQxg
         n7Pw==
X-Gm-Message-State: AC+VfDyyeOhakdZ4AzC63QF9Es96bgcgPcvVtwcHAT3+HgxZ2pN3uRPj
        s284JrdKpYskwhjRWqSUCzwkKvvdV8wFKC82P64=
X-Google-Smtp-Source: ACHHUZ5xzQwHthErOWT0y2M7+cq61s9GUlH+dErW3zKfzpaNDYfwQuFbKAwomiP4XeufUr/gRSIWrA==
X-Received: by 2002:a17:902:ec87:b0:19c:3d78:6a54 with SMTP id x7-20020a170902ec8700b0019c3d786a54mr33513974plg.14.1684000779280;
        Sat, 13 May 2023 10:59:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902da8200b00186a2274382sm10105007plx.76.2023.05.13.10.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 10:59:38 -0700 (PDT)
Message-ID: <645fd00a.170a0220.aac54.4780@mx.google.com>
Date:   Sat, 13 May 2023 10:59:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.28-184-gd3df9458f0b5a
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 181 runs,
 11 regressions (v6.1.28-184-gd3df9458f0b5a)
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

stable-rc/queue/6.1 baseline: 181 runs, 11 regressions (v6.1.28-184-gd3df94=
58f0b5a)

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

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

qemu_i386-uefi               | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.28-184-gd3df9458f0b5a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.28-184-gd3df9458f0b5a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d3df9458f0b5a5741dd6c115952f586e588a8187 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f9dd1e25b69c9c92e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f9dd1e25b69c9c92e8611
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T14:24:55.809789  <8>[   10.760553] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10305871_1.4.2.3.1>

    2023-05-13T14:24:55.809899  + set +x

    2023-05-13T14:24:55.914583  / # #

    2023-05-13T14:24:56.015152  export SHELL=3D/bin/sh

    2023-05-13T14:24:56.015341  #

    2023-05-13T14:24:56.115917  / # export SHELL=3D/bin/sh. /lava-10305871/=
environment

    2023-05-13T14:24:56.116159  =


    2023-05-13T14:24:56.216742  / # . /lava-10305871/environment/lava-10305=
871/bin/lava-test-runner /lava-10305871/1

    2023-05-13T14:24:56.217009  =


    2023-05-13T14:24:56.222996  / # /lava-10305871/bin/lava-test-runner /la=
va-10305871/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f9db14d170d2e7f2e8650

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f9db14d170d2e7f2e8655
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T14:24:43.503372  + set +x<8>[   10.938748] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10305831_1.4.2.3.1>

    2023-05-13T14:24:43.503462  =


    2023-05-13T14:24:43.607785  / # #

    2023-05-13T14:24:43.708401  export SHELL=3D/bin/sh

    2023-05-13T14:24:43.708640  #

    2023-05-13T14:24:43.809312  / # export SHELL=3D/bin/sh. /lava-10305831/=
environment

    2023-05-13T14:24:43.809538  =


    2023-05-13T14:24:43.910306  / # . /lava-10305831/environment/lava-10305=
831/bin/lava-test-runner /lava-10305831/1

    2023-05-13T14:24:43.910813  =


    2023-05-13T14:24:43.915749  / # /lava-10305831/bin/lava-test-runner /la=
va-10305831/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f9dca78649e842c2e860e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f9dca78649e842c2e8613
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T14:24:55.905012  <8>[   10.570388] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10305828_1.4.2.3.1>

    2023-05-13T14:24:55.908573  + set +x

    2023-05-13T14:24:56.010091  #

    2023-05-13T14:24:56.010445  =


    2023-05-13T14:24:56.111076  / # #export SHELL=3D/bin/sh

    2023-05-13T14:24:56.111259  =


    2023-05-13T14:24:56.211742  / # export SHELL=3D/bin/sh. /lava-10305828/=
environment

    2023-05-13T14:24:56.211930  =


    2023-05-13T14:24:56.312455  / # . /lava-10305828/environment/lava-10305=
828/bin/lava-test-runner /lava-10305828/1

    2023-05-13T14:24:56.312845  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645f9d3084dc5fb1bd2e86d4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645f9d3084dc5fb1bd2e8=
6d5
        failing since 23 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f9e1ed4fbc94c222e8606

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f9e1ed4fbc94c222e860b
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T14:26:23.814578  + set +x

    2023-05-13T14:26:23.820790  <8>[   11.298654] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10305832_1.4.2.3.1>

    2023-05-13T14:26:23.925354  / # #

    2023-05-13T14:26:24.026047  export SHELL=3D/bin/sh

    2023-05-13T14:26:24.026241  #

    2023-05-13T14:26:24.126833  / # export SHELL=3D/bin/sh. /lava-10305832/=
environment

    2023-05-13T14:26:24.127063  =


    2023-05-13T14:26:24.227639  / # . /lava-10305832/environment/lava-10305=
832/bin/lava-test-runner /lava-10305832/1

    2023-05-13T14:26:24.227918  =


    2023-05-13T14:26:24.232525  / # /lava-10305832/bin/lava-test-runner /la=
va-10305832/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f9db74d170d2e7f2e868a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f9db74d170d2e7f2e868f
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T14:24:39.730018  <8>[   10.845536] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10305850_1.4.2.3.1>

    2023-05-13T14:24:39.733002  + set +x

    2023-05-13T14:24:39.834088  /#

    2023-05-13T14:24:39.934793   # #export SHELL=3D/bin/sh

    2023-05-13T14:24:39.934947  =


    2023-05-13T14:24:40.035402  / # export SHELL=3D/bin/sh. /lava-10305850/=
environment

    2023-05-13T14:24:40.035582  =


    2023-05-13T14:24:40.136090  / # . /lava-10305850/environment/lava-10305=
850/bin/lava-test-runner /lava-10305850/1

    2023-05-13T14:24:40.136436  =


    2023-05-13T14:24:40.140958  / # /lava-10305850/bin/lava-test-runner /la=
va-10305850/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f9dbb4d170d2e7f2e86be

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f9dbb4d170d2e7f2e86c3
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T14:24:38.736344  + set<8>[    8.878008] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10305798_1.4.2.3.1>

    2023-05-13T14:24:38.736770   +x

    2023-05-13T14:24:38.844333  / # #

    2023-05-13T14:24:38.946422  export SHELL=3D/bin/sh

    2023-05-13T14:24:38.947028  #

    2023-05-13T14:24:39.048315  / # export SHELL=3D/bin/sh. /lava-10305798/=
environment

    2023-05-13T14:24:39.049080  =


    2023-05-13T14:24:39.150359  / # . /lava-10305798/environment/lava-10305=
798/bin/lava-test-runner /lava-10305798/1

    2023-05-13T14:24:39.151300  =


    2023-05-13T14:24:39.155937  / # /lava-10305798/bin/lava-test-runner /la=
va-10305798/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f9db24d170d2e7f2e865b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f9db24d170d2e7f2e8660
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T14:24:27.734859  <8>[   11.470331] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10305864_1.4.2.3.1>

    2023-05-13T14:24:27.839243  / # #

    2023-05-13T14:24:27.939842  export SHELL=3D/bin/sh

    2023-05-13T14:24:27.940074  #

    2023-05-13T14:24:28.040543  / # export SHELL=3D/bin/sh. /lava-10305864/=
environment

    2023-05-13T14:24:28.040742  =


    2023-05-13T14:24:28.141298  / # . /lava-10305864/environment/lava-10305=
864/bin/lava-test-runner /lava-10305864/1

    2023-05-13T14:24:28.141622  =


    2023-05-13T14:24:28.146809  / # /lava-10305864/bin/lava-test-runner /la=
va-10305864/1

    2023-05-13T14:24:28.153073  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645f9d1482f54f6e712e85f6

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/645f9d1482f54f6e712e8612
        failing since 6 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-13T14:21:43.225189  /lava-10305738/1/../bin/lava-test-case
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f9d1482f54f6e712e869e
        failing since 6 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-13T14:21:37.762282  + set +x

    2023-05-13T14:21:37.768940  <8>[   17.634567] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10305738_1.5.2.3.1>

    2023-05-13T14:21:37.878201  / # #

    2023-05-13T14:21:37.980239  export SHELL=3D/bin/sh

    2023-05-13T14:21:37.981145  #

    2023-05-13T14:21:38.082763  / # export SHELL=3D/bin/sh. /lava-10305738/=
environment

    2023-05-13T14:21:38.083730  =


    2023-05-13T14:21:38.185481  / # . /lava-10305738/environment/lava-10305=
738/bin/lava-test-runner /lava-10305738/1

    2023-05-13T14:21:38.186796  =


    2023-05-13T14:21:38.192205  / # /lava-10305738/bin/lava-test-runner /la=
va-10305738/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_i386-uefi               | i386   | lab-baylibre  | gcc-10   | i386_def=
config               | 1          =


  Details:     https://kernelci.org/test/plan/id/645f9b8ad337c76dd42e8604

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386=
-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
4-gd3df9458f0b5a/i386/i386_defconfig/gcc-10/lab-baylibre/baseline-qemu_i386=
-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645f9b8ad337c76dd42e8=
605
        new failure (last pass: v6.1.28-183-gb35b1f6de36bb) =

 =20

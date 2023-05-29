Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3819714630
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 10:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjE2ISy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 04:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjE2ISx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 04:18:53 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495C690
        for <stable@vger.kernel.org>; Mon, 29 May 2023 01:18:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d3491609fso2228209b3a.3
        for <stable@vger.kernel.org>; Mon, 29 May 2023 01:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685348330; x=1687940330;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Obpazo00GspKQgCSK/zija63EuRltG+4jDUjV9Hux/U=;
        b=en5M6OkJhg3m5Vs9Exm6SjDs/dejui8mJ4dW1I9fX+dsoaD7bzpowndhyW8RqyYKyf
         Xbmk9SfhOiaZco4khkykmGd18BR6KuDEa//UojOn7tsYaECCn4Au41vD8MvTYT4SE0oT
         j3d0BAB20mWF1wYhPdxXvBDgUPpotd0jpLYjVZvGxU3uSjFpL7+KD4SWQTldm/sNQ2LL
         2xjCGe+8kW1rbcB5PMdhSqPc9lx5Hm4ntbVUZnyEsxI4NXzVdfV8CF78buF6yzfhPRUa
         0lEd9UTuAFU+cysSEontPlsIDYIQ8s6JRMZhBFiRkOOX5gBFAcL2O6s5iy6VF3rnrMcL
         pRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685348330; x=1687940330;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Obpazo00GspKQgCSK/zija63EuRltG+4jDUjV9Hux/U=;
        b=YS928+PjYgewsYhDsfiirQvrrPbf7ITC5pDgA4tBJu24WLGtQqhqHt3nGT+iEPTMI2
         EcddTDhz3gCWxWidPXPX2nRO1ob00QWz1rLDqFZDKcnzbsAgr5XOi4uAcOur650mN04w
         1PSKzc+Z6As6kZvSnq2/8Kk70f47ufQc16UFT0rKqr1FfkRkd7N2+otXG0ipf0PM5Ura
         GHkjAe3mMnPkHHBpgXxrihauiLZgKCaar1fS5oZXSUFeSF/xkln13ZwBmHHFTapNoMji
         JBZ5mQEuW2I/iFOtcbS8BrJmvs6t8uJSsbWWcreid888fRR1wpqEUv7N0c1yriqYjDGB
         BV8A==
X-Gm-Message-State: AC+VfDwxqTSgGw6shB2e/NFUaBxEsQiQjXEGBy7iU+ZSqgPzEDIA9Acu
        0/CqpNV1kK7nGVfuHsmZDWcr0l0eH9HQM/n+Wc7M+A==
X-Google-Smtp-Source: ACHHUZ6sP7UOErPzr8abpweZJqGewo85FCXycNyxnVML6SgAcg40FAyBpLQV/goEqiwTkto3vx7tSw==
X-Received: by 2002:a05:6a20:8f02:b0:103:73a6:5cc1 with SMTP id b2-20020a056a208f0200b0010373a65cc1mr10205748pzk.4.1685348330196;
        Mon, 29 May 2023 01:18:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id me15-20020a17090b17cf00b002471deb13fcsm8494858pjb.6.2023.05.29.01.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 01:18:49 -0700 (PDT)
Message-ID: <64745fe9.170a0220.5dc24.0106@mx.google.com>
Date:   Mon, 29 May 2023 01:18:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-438-g81b569a4c469
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 160 runs,
 8 regressions (v6.1.29-438-g81b569a4c469)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/queue/6.1 baseline: 160 runs, 8 regressions (v6.1.29-438-g81b569a=
4c469)

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

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.29-438-g81b569a4c469/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.29-438-g81b569a4c469
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      81b569a4c4697714505e573d1fe2b711de31e62a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647429eb398ce2bfd02e861c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647429eb398ce2bfd02e8621
        failing since 61 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-29T04:28:10.217810  <8>[   11.014129] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10504270_1.4.2.3.1>

    2023-05-29T04:28:10.221316  + set +x

    2023-05-29T04:28:10.325191  / # #

    2023-05-29T04:28:10.425862  export SHELL=3D/bin/sh

    2023-05-29T04:28:10.426010  #

    2023-05-29T04:28:10.526541  / # export SHELL=3D/bin/sh. /lava-10504270/=
environment

    2023-05-29T04:28:10.526702  =


    2023-05-29T04:28:10.627276  / # . /lava-10504270/environment/lava-10504=
270/bin/lava-test-runner /lava-10504270/1

    2023-05-29T04:28:10.627502  =


    2023-05-29T04:28:10.633341  / # /lava-10504270/bin/lava-test-runner /la=
va-10504270/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647429ea398ce2bfd02e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647429ea398ce2bfd02e8611
        failing since 61 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-29T04:28:15.513331  + <8>[   11.558703] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10504246_1.4.2.3.1>

    2023-05-29T04:28:15.513903  set +x

    2023-05-29T04:28:15.622917  / # #

    2023-05-29T04:28:15.725287  export SHELL=3D/bin/sh

    2023-05-29T04:28:15.726077  #

    2023-05-29T04:28:15.827864  / # export SHELL=3D/bin/sh. /lava-10504246/=
environment

    2023-05-29T04:28:15.828598  =


    2023-05-29T04:28:15.930245  / # . /lava-10504246/environment/lava-10504=
246/bin/lava-test-runner /lava-10504246/1

    2023-05-29T04:28:15.931516  =


    2023-05-29T04:28:15.936787  / # /lava-10504246/bin/lava-test-runner /la=
va-10504246/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647429ef398ce2bfd02e863d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647429ef398ce2bfd02e8642
        failing since 61 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-29T04:28:13.228770  <8>[   10.656954] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10504255_1.4.2.3.1>

    2023-05-29T04:28:13.232436  + set +x

    2023-05-29T04:28:13.337989  #

    2023-05-29T04:28:13.339414  =


    2023-05-29T04:28:13.441293  / # #export SHELL=3D/bin/sh

    2023-05-29T04:28:13.442047  =


    2023-05-29T04:28:13.543697  / # export SHELL=3D/bin/sh. /lava-10504255/=
environment

    2023-05-29T04:28:13.544503  =


    2023-05-29T04:28:13.646400  / # . /lava-10504255/environment/lava-10504=
255/bin/lava-test-runner /lava-10504255/1

    2023-05-29T04:28:13.647885  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647429f26ac34d3c812e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647429f26ac34d3c812e8607
        failing since 61 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-29T04:28:07.507965  + set +x

    2023-05-29T04:28:07.514905  <8>[   11.497638] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10504269_1.4.2.3.1>

    2023-05-29T04:28:07.618847  / # #

    2023-05-29T04:28:07.719427  export SHELL=3D/bin/sh

    2023-05-29T04:28:07.719614  #

    2023-05-29T04:28:07.820098  / # export SHELL=3D/bin/sh. /lava-10504269/=
environment

    2023-05-29T04:28:07.820295  =


    2023-05-29T04:28:07.920827  / # . /lava-10504269/environment/lava-10504=
269/bin/lava-test-runner /lava-10504269/1

    2023-05-29T04:28:07.921120  =


    2023-05-29T04:28:07.925626  / # /lava-10504269/bin/lava-test-runner /la=
va-10504269/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647429d1e566f5720f2e85eb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647429d1e566f5720f2e85f0
        failing since 61 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-29T04:27:47.440313  + set +x

    2023-05-29T04:27:47.446841  <8>[   10.028805] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10504263_1.4.2.3.1>

    2023-05-29T04:27:47.555743  =


    2023-05-29T04:27:47.657754  / # #export SHELL=3D/bin/sh

    2023-05-29T04:27:47.658452  =


    2023-05-29T04:27:47.759697  / # export SHELL=3D/bin/sh. /lava-10504263/=
environment

    2023-05-29T04:27:47.759936  =


    2023-05-29T04:27:47.860515  / # . /lava-10504263/environment/lava-10504=
263/bin/lava-test-runner /lava-10504263/1

    2023-05-29T04:27:47.860817  =


    2023-05-29T04:27:47.866401  / # /lava-10504263/bin/lava-test-runner /la=
va-10504263/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647429f16ac34d3c812e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647429f16ac34d3c812e85f9
        failing since 61 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-29T04:28:15.174441  + set<8>[   10.793897] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10504235_1.4.2.3.1>

    2023-05-29T04:28:15.174526   +x

    2023-05-29T04:28:15.279082  / # #

    2023-05-29T04:28:15.379659  export SHELL=3D/bin/sh

    2023-05-29T04:28:15.379867  #

    2023-05-29T04:28:15.480366  / # export SHELL=3D/bin/sh. /lava-10504235/=
environment

    2023-05-29T04:28:15.480546  =


    2023-05-29T04:28:15.581152  / # . /lava-10504235/environment/lava-10504=
235/bin/lava-test-runner /lava-10504235/1

    2023-05-29T04:28:15.581442  =


    2023-05-29T04:28:15.586156  / # /lava-10504235/bin/lava-test-runner /la=
va-10504235/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647429db37f408305f2e861a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647429db37f408305f2e861f
        failing since 61 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-29T04:28:05.009435  <8>[   12.479049] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10504253_1.4.2.3.1>

    2023-05-29T04:28:05.113589  / # #

    2023-05-29T04:28:05.214245  export SHELL=3D/bin/sh

    2023-05-29T04:28:05.214504  #

    2023-05-29T04:28:05.315053  / # export SHELL=3D/bin/sh. /lava-10504253/=
environment

    2023-05-29T04:28:05.315252  =


    2023-05-29T04:28:05.415806  / # . /lava-10504253/environment/lava-10504=
253/bin/lava-test-runner /lava-10504253/1

    2023-05-29T04:28:05.416203  =


    2023-05-29T04:28:05.420553  / # /lava-10504253/bin/lava-test-runner /la=
va-10504253/1

    2023-05-29T04:28:05.427144  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/647429b7cb046f401f2e8638

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.29-43=
8-g81b569a4c469/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647429b7cb046f401f2e8=
639
        new failure (last pass: v6.1.29-412-g59962e745c3c) =

 =20

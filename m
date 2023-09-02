Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC07A7907C7
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 14:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348938AbjIBMQg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 08:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjIBMQf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 08:16:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B101012D
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 05:16:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so2533341b3a.1
        for <stable@vger.kernel.org>; Sat, 02 Sep 2023 05:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693656991; x=1694261791; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wu5mhn5NAFIDJyo1chtMCsQkQBwsU0WbOQyCOSB6vVw=;
        b=d77+AOA9epq0hBd+L50FTpb3FCDDBQbdC0V+k+ow+I5iNop9DhnNLPVz2dzTpujpu5
         sP5tiox4ju7Wo9Nh9nvo7s3TqD+T/ZGtbxzpGkiPexpOnPWb3tD5YcMl/WjUUckU7im0
         zMD16b0el5N4uIAvq2yKfzDYuEYS/1Ii+7Mj5pOSiwvaCWNG802uGOynTl2HdVhDzjfE
         hlJ8KZnPU8pPNpu+5VIUkvB7Bila677Zz+OJ0wwp4T+pL5SMamu2WXkCyLcfflro+ai0
         kb2E1qOp6DAE6FElWO8ckeRRy4tRhLH9ISRZpp4tp2+9VHJRaM9o+BMZzJW/p64pS3ES
         lsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693656991; x=1694261791;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wu5mhn5NAFIDJyo1chtMCsQkQBwsU0WbOQyCOSB6vVw=;
        b=iUr/WyaN4hDoUih2tA0tcLV5lwY7GSmQZuXhsmf/NKavpHp0oiKj33SUgJPk7G77Rp
         bNektsrj8Vipv+X4YBdQkj2v77wag3pa4Cd7RZrxLlwJ1Hdb48xKdqca8SYlgkRnVgLD
         nW+Hb4rA6AjpH4k/c5frzEuHbG9pmjbRHZJ5kWldHQ3yLP9QQeXzlKUq/ANDnvdiQvTU
         XWwPlmWnaDBE1kb7smDFFGxfuAcR8NUz3DXYrjMcCf6X4wmMw5nZYYQZdZzxPQb/OyzK
         vDSQ2AQ5xCoFF0D3WKMMH8+FjeJWdoK3JMzYfybpnCJXJIa+n1Sda3RVNbmKM9EkuGkY
         E+2A==
X-Gm-Message-State: AOJu0YwSAi8IYEstwSTin/E1g1vF85xEo5C+0+85azpZbnoAE1N/imuR
        F8qLVdBvZd55XKd7i6fFaLLMJDSl8vBvp6COvv4=
X-Google-Smtp-Source: AGHT+IFnfovwYg37ALk1c6qWrc3wdy1C8Rqz8RSYl0aJKKyLBIOzJQgs4VIPqnlxVMqsmobr1CRIXg==
X-Received: by 2002:a05:6a20:3c8e:b0:14c:7020:d614 with SMTP id b14-20020a056a203c8e00b0014c7020d614mr7007358pzj.49.1693656990571;
        Sat, 02 Sep 2023 05:16:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f10-20020a639c0a000000b0056001f43726sm4381062pge.92.2023.09.02.05.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 05:16:29 -0700 (PDT)
Message-ID: <64f3279d.630a0220.410b7.8b60@mx.google.com>
Date:   Sat, 02 Sep 2023 05:16:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.194
Subject: stable/linux-5.10.y baseline: 123 runs, 11 regressions (v5.10.194)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.10.y baseline: 123 runs, 11 regressions (v5.10.194)

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

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.194/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.194
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      006d5847646be8d430ae201c445afa93f08c8e52 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f7061554915cc1286d7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f7061554915cc1286d88
        failing since 226 days (last pass: v5.10.158, first fail: v5.10.164)

    2023-09-02T08:48:48.758611  <8>[   11.017039] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3760326_1.5.2.4.1>
    2023-09-02T08:48:48.865625  / # #
    2023-09-02T08:48:48.967255  export SHELL=3D/bin/sh
    2023-09-02T08:48:48.967681  #
    2023-09-02T08:48:49.068925  / # export SHELL=3D/bin/sh. /lava-3760326/e=
nvironment
    2023-09-02T08:48:49.069350  =

    2023-09-02T08:48:49.170457  / # . /lava-3760326/environment/lava-376032=
6/bin/lava-test-runner /lava-3760326/1
    2023-09-02T08:48:49.171059  =

    2023-09-02T08:48:49.176345  / # /lava-3760326/bin/lava-test-runner /lav=
a-3760326/1
    2023-09-02T08:48:49.260463  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f441fca2c5227e286df0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f441fca2c5227e286df9
        failing since 149 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-09-02T08:37:10.909682  + set +x

    2023-09-02T08:37:10.915821  <8>[   11.010497] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11409630_1.4.2.3.1>

    2023-09-02T08:37:11.020520  / # #

    2023-09-02T08:37:11.121104  export SHELL=3D/bin/sh

    2023-09-02T08:37:11.121283  #

    2023-09-02T08:37:11.221916  / # export SHELL=3D/bin/sh. /lava-11409630/=
environment

    2023-09-02T08:37:11.222086  =


    2023-09-02T08:37:11.322614  / # . /lava-11409630/environment/lava-11409=
630/bin/lava-test-runner /lava-11409630/1

    2023-09-02T08:37:11.322882  =


    2023-09-02T08:37:11.327347  / # /lava-11409630/bin/lava-test-runner /la=
va-11409630/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f660a0817f8163286db8

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f660a0817f8163286df8
        new failure (last pass: v5.10.193)

    2023-09-02T08:46:03.185953  / # #
    2023-09-02T08:46:03.288770  export SHELL=3D/bin/sh
    2023-09-02T08:46:03.289544  #
    2023-09-02T08:46:03.391484  / # export SHELL=3D/bin/sh. /lava-83673/env=
ironment
    2023-09-02T08:46:03.392236  =

    2023-09-02T08:46:03.494128  / # . /lava-83673/environment/lava-83673/bi=
n/lava-test-runner /lava-83673/1
    2023-09-02T08:46:03.495418  =

    2023-09-02T08:46:03.510234  / # /lava-83673/bin/lava-test-runner /lava-=
83673/1
    2023-09-02T08:46:03.568049  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-02T08:46:03.568569  + cd /lava-83673/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f305781fe85c8af8286d93

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f305781fe85c8af8286d96
        failing since 37 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-09-02T09:50:31.423981  + set +x
    2023-09-02T09:50:31.424201  <8>[   83.596891] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1004161_1.5.2.4.1>
    2023-09-02T09:50:31.530977  / # #
    2023-09-02T09:50:32.992336  export SHELL=3D/bin/sh
    2023-09-02T09:50:33.012887  #
    2023-09-02T09:50:33.013109  / # export SHELL=3D/bin/sh
    2023-09-02T09:50:34.968067  / # . /lava-1004161/environment
    2023-09-02T09:50:38.564815  /lava-1004161/bin/lava-test-runner /lava-10=
04161/1
    2023-09-02T09:50:38.585598  . /lava-1004161/environment
    2023-09-02T09:50:38.585708  / # /lava-1004161/bin/lava-test-runner /lav=
a-1004161/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f824e559303028286d7b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f824e559303028286d7e
        failing since 37 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-09-02T08:53:16.016398  + set +x
    2023-09-02T08:53:16.016591  <8>[   84.163553] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1004160_1.5.2.4.1>
    2023-09-02T08:53:16.122433  / # #
    2023-09-02T08:53:17.582200  export SHELL=3D/bin/sh
    2023-09-02T08:53:17.602697  #
    2023-09-02T08:53:17.602900  / # export SHELL=3D/bin/sh
    2023-09-02T08:53:19.554923  / # . /lava-1004160/environment
    2023-09-02T08:53:23.147588  /lava-1004160/bin/lava-test-runner /lava-10=
04160/1
    2023-09-02T08:53:23.168329  . /lava-1004160/environment
    2023-09-02T08:53:23.168453  / # /lava-1004160/bin/lava-test-runner /lav=
a-1004160/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f6ad5b83e0ef31286ded

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f6ad5b83e0ef31286df0
        failing since 37 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-09-02T08:47:00.416014  / # #
    2023-09-02T08:47:01.876029  export SHELL=3D/bin/sh
    2023-09-02T08:47:01.896567  #
    2023-09-02T08:47:01.896772  / # export SHELL=3D/bin/sh
    2023-09-02T08:47:03.848308  / # . /lava-1004132/environment
    2023-09-02T08:47:07.442619  /lava-1004132/bin/lava-test-runner /lava-10=
04132/1
    2023-09-02T08:47:07.463363  . /lava-1004132/environment
    2023-09-02T08:47:07.463467  / # /lava-1004132/bin/lava-test-runner /lav=
a-1004132/1
    2023-09-02T08:47:07.543430  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-02T08:47:07.543644  + cd /lava-1004132/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f7f90b87184aa5286da4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f7f90b87184aa5286da7
        failing since 37 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-09-02T08:52:21.637112  / # #
    2023-09-02T08:52:23.096878  export SHELL=3D/bin/sh
    2023-09-02T08:52:23.117375  #
    2023-09-02T08:52:23.117593  / # export SHELL=3D/bin/sh
    2023-09-02T08:52:25.069844  / # . /lava-1004159/environment
    2023-09-02T08:52:28.662325  /lava-1004159/bin/lava-test-runner /lava-10=
04159/1
    2023-09-02T08:52:28.683050  . /lava-1004159/environment
    2023-09-02T08:52:28.683156  / # /lava-1004159/bin/lava-test-runner /lav=
a-1004159/1
    2023-09-02T08:52:28.760561  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-02T08:52:28.760773  + cd /lava-1004159/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64f2f66e3aa1275cce286d85

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64f2f66e3aa1275cce286d8f
        failing since 168 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-09-02T08:46:30.927569  <8>[   61.087777] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-09-02T08:46:31.952496  /lava-11409822/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64f2f66e3aa1275cce286d90
        failing since 168 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-09-02T08:46:30.915695  /lava-11409822/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f5ec6bd3801c23286d93

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f5ec6bd3801c23286d98
        failing since 6 days (last pass: v5.10.191, first fail: v5.10.192)

    2023-09-02T08:45:24.874423  / # #

    2023-09-02T08:45:26.135131  export SHELL=3D/bin/sh

    2023-09-02T08:45:26.146069  #

    2023-09-02T08:45:26.146545  / # export SHELL=3D/bin/sh

    2023-09-02T08:45:27.890244  / # . /lava-11409791/environment

    2023-09-02T08:45:31.095786  /lava-11409791/bin/lava-test-runner /lava-1=
1409791/1

    2023-09-02T08:45:31.107243  . /lava-11409791/environment

    2023-09-02T08:45:31.108971  / # /lava-11409791/bin/lava-test-runner /la=
va-11409791/1

    2023-09-02T08:45:31.162006  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T08:45:31.162504  + cd /lava-11409791/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2f5d305625b073c286d6e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.194/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2f5d305625b073c286d77
        failing since 37 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-09-02T08:45:31.660055  / # #

    2023-09-02T08:45:31.762213  export SHELL=3D/bin/sh

    2023-09-02T08:45:31.762925  #

    2023-09-02T08:45:31.864295  / # export SHELL=3D/bin/sh. /lava-11409796/=
environment

    2023-09-02T08:45:31.865056  =


    2023-09-02T08:45:31.966526  / # . /lava-11409796/environment/lava-11409=
796/bin/lava-test-runner /lava-11409796/1

    2023-09-02T08:45:31.967603  =


    2023-09-02T08:45:32.009362  / # /lava-11409796/bin/lava-test-runner /la=
va-11409796/1

    2023-09-02T08:45:32.009894  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T08:45:32.045843  + cd /lava-1140979<8>[   18.259364] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11409796_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

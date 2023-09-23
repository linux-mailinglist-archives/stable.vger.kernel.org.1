Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE56C7AC24F
	for <lists+stable@lfdr.de>; Sat, 23 Sep 2023 15:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjIWNna (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 09:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIWNn3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 09:43:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AF119E
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 06:43:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6907e44665bso3340152b3a.1
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695476601; x=1696081401; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i7AbQkf6bBsaykHtuF/AZPaPRWvG++gqp2OqIidhdRE=;
        b=ohuGMaZuL+A54uGvjHyjfHn3XGK4Pvl3wO1LP/LmkfxrvemU3uc5sYODOvE2BwA4Rq
         GKOTENGiEznRP7hu9zVnDrNznKG7G0QJRDPF5gvMYfwheB/zwe2TU4xlu1VzeQ6+dR1/
         kqSKluEDfjqeJik3XS7mZCSHwjt9CfefFl0NuCvU++nJ5u2+3fVL/WqXOoAcRb4dQ26L
         3OpfHPE7KTdjfP3f8n69Dz7GngrHrd1VQl5/LWtKhqM09uEk6yubuZufQ25W59wT4hFm
         gBOCfH4ztpgYSoHr8HVF4esl3QQhIBjYkXxa9pOBi1GiVq2GCdmP+EurfLtJ3iEojv1h
         IHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695476601; x=1696081401;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7AbQkf6bBsaykHtuF/AZPaPRWvG++gqp2OqIidhdRE=;
        b=IiFJbHpWPNSfK/qQM/abw18KsX7ElqUEQRrGpmvow4BHroctI08yM6wRE0CY0QyVKu
         /+lv2ibi+T4KI1cdEZAWMouUdJFSVDNyHwEGaYLw2QfFJZic3iaoHwfZcPL9weUdK0nH
         PmuDDHh73o46VZG8JbKJXSKUCMq738evgZk778m5AKxLqMOOYNx/VXqHk9VR/CRIm52F
         +doqsjjX1JsVQ43vy0urXfAkHUOEzgThk6sMzoRA9v5vdoSd+GkW//YWKuYHezlwdMzM
         CZWCPwUzCPSU5wSq9sU5Z5xiKQs6FuIu/UihcZiyRyCE7rp1mSZ2tzLhpnjoFXltiBuR
         HfNQ==
X-Gm-Message-State: AOJu0YxmzidYdM8+anFZYgPPt2Zs0WOytJHuUnHh057j25CpiNQJ7mDr
        l0DL7+BFjr3nrjJWKOdcbcw06utlZAX4JDNdmECH+A==
X-Google-Smtp-Source: AGHT+IH4teTz+lbeJ4zdLYDsevdWhvs5APcQEz9ZcKS2245ASrvjMBj+jieQl7DBbfE+GA+SapbIDQ==
X-Received: by 2002:a05:6a21:819f:b0:14d:d9f8:83ee with SMTP id pd31-20020a056a21819f00b0014dd9f883eemr2333896pzb.61.1695476600494;
        Sat, 23 Sep 2023 06:43:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gj18-20020a17090b109200b002682523653asm4976282pjb.49.2023.09.23.06.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 06:43:19 -0700 (PDT)
Message-ID: <650eeb77.170a0220.f3a30.7878@mx.google.com>
Date:   Sat, 23 Sep 2023 06:43:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.10.197
X-Kernelci-Report-Type: test
Subject: stable/linux-5.10.y baseline: 119 runs, 12 regressions (v5.10.197)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.10.y baseline: 119 runs, 12 regressions (v5.10.197)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.197/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.197
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      393e225fe8ff80ecc47065235027ce1a7fcbb8e5 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650eb8811bd7e12fef8a0a72

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eb8811bd7e12fef8a0a7b
        failing since 170 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-09-23T10:05:39.246217  + <8>[   10.367503] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11601015_1.4.2.3.1>

    2023-09-23T10:05:39.246302  set +x

    2023-09-23T10:05:39.347433  #

    2023-09-23T10:05:39.347668  =


    2023-09-23T10:05:39.448257  / # #export SHELL=3D/bin/sh

    2023-09-23T10:05:39.448428  =


    2023-09-23T10:05:39.548947  / # export SHELL=3D/bin/sh. /lava-11601015/=
environment

    2023-09-23T10:05:39.549128  =


    2023-09-23T10:05:39.649681  / # . /lava-11601015/environment/lava-11601=
015/bin/lava-test-runner /lava-11601015/1

    2023-09-23T10:05:39.649983  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebb3f989cc4264d8a0a91

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ebb3f989cc4264d8a0ad1
        new failure (last pass: v5.10.196)

    2023-09-23T10:16:59.859074  / # #
    2023-09-23T10:16:59.961944  export SHELL=3D/bin/sh
    2023-09-23T10:16:59.962727  #
    2023-09-23T10:17:00.064648  / # export SHELL=3D/bin/sh. /lava-127140/en=
vironment
    2023-09-23T10:17:00.065450  =

    2023-09-23T10:17:00.167378  / # . /lava-127140/environment/lava-127140/=
bin/lava-test-runner /lava-127140/1
    2023-09-23T10:17:00.168659  =

    2023-09-23T10:17:00.182392  / # /lava-127140/bin/lava-test-runner /lava=
-127140/1
    2023-09-23T10:17:00.241225  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-23T10:17:00.241740  + cd /lava-127140/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebb0de2a0a6384e8a0a49

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ebb0de2a0a6384e8a0a50
        failing since 27 days (last pass: v5.10.185, first fail: v5.10.192)

    2023-09-23T10:16:26.591650  + set +x
    2023-09-23T10:16:26.594667  <8>[   83.948105] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1012112_1.5.2.4.1>
    2023-09-23T10:16:26.703269  / # #
    2023-09-23T10:16:28.164994  export SHELL=3D/bin/sh
    2023-09-23T10:16:28.186023  #
    2023-09-23T10:16:28.186492  / # export SHELL=3D/bin/sh
    2023-09-23T10:16:30.141275  / # . /lava-1012112/environment
    2023-09-23T10:16:33.738263  /lava-1012112/bin/lava-test-runner /lava-10=
12112/1
    2023-09-23T10:16:33.759650  . /lava-1012112/environment
    2023-09-23T10:16:33.760013  / # /lava-1012112/bin/lava-test-runner /lav=
a-1012112/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebb3524d2d447248a0a79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ebb3524d2d447248a0a80
        failing since 58 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-09-23T10:16:55.940795  + set +x
    2023-09-23T10:16:55.944023  <8>[   83.948034] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1012120_1.5.2.4.1>
    2023-09-23T10:16:56.053673  / # #
    2023-09-23T10:16:57.517456  export SHELL=3D/bin/sh
    2023-09-23T10:16:57.538408  #
    2023-09-23T10:16:57.538877  / # export SHELL=3D/bin/sh
    2023-09-23T10:16:59.496349  / # . /lava-1012120/environment
    2023-09-23T10:17:03.097333  /lava-1012120/bin/lava-test-runner /lava-10=
12120/1
    2023-09-23T10:17:03.118983  . /lava-1012120/environment
    2023-09-23T10:17:03.119409  / # /lava-1012120/bin/lava-test-runner /lav=
a-1012120/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebd1f7c1b124fe98a0a50

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ebd1f7c1b124fe98a0a57
        failing since 58 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-09-23T10:25:04.917838  + set +x
    2023-09-23T10:25:04.917961  <8>[   84.174887] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1012117_1.5.2.4.1>
    2023-09-23T10:25:05.023423  / # #
    2023-09-23T10:25:06.482995  export SHELL=3D/bin/sh
    2023-09-23T10:25:06.503454  #
    2023-09-23T10:25:06.503644  / # export SHELL=3D/bin/sh
    2023-09-23T10:25:08.455971  / # . /lava-1012117/environment
    2023-09-23T10:25:12.048809  /lava-1012117/bin/lava-test-runner /lava-10=
12117/1
    2023-09-23T10:25:12.069422  . /lava-1012117/environment
    2023-09-23T10:25:12.069553  / # /lava-1012117/bin/lava-test-runner /lav=
a-1012117/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebb661e84abfa398a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ebb661e84abfa398a0a49
        failing since 58 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-09-23T10:17:47.677803  / # #
    2023-09-23T10:17:49.140005  export SHELL=3D/bin/sh
    2023-09-23T10:17:49.160604  #
    2023-09-23T10:17:49.160815  / # export SHELL=3D/bin/sh
    2023-09-23T10:17:51.112857  / # . /lava-1012113/environment
    2023-09-23T10:17:54.703324  /lava-1012113/bin/lava-test-runner /lava-10=
12113/1
    2023-09-23T10:17:54.723844  . /lava-1012113/environment
    2023-09-23T10:17:54.723974  / # /lava-1012113/bin/lava-test-runner /lav=
a-1012113/1
    2023-09-23T10:17:54.802868  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-23T10:17:54.803012  + cd /lava-1012113/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebc42b889c442248a0a44

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ebc42b889c442248a0a4b
        failing since 58 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-09-23T10:21:32.713615  / # #
    2023-09-23T10:21:34.176445  export SHELL=3D/bin/sh
    2023-09-23T10:21:34.197014  #
    2023-09-23T10:21:34.197223  / # export SHELL=3D/bin/sh
    2023-09-23T10:21:36.153563  / # . /lava-1012116/environment
    2023-09-23T10:21:39.752870  /lava-1012116/bin/lava-test-runner /lava-10=
12116/1
    2023-09-23T10:21:39.773655  . /lava-1012116/environment
    2023-09-23T10:21:39.773764  / # /lava-1012116/bin/lava-test-runner /lav=
a-1012116/1
    2023-09-23T10:21:39.850401  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-23T10:21:39.850622  + cd /lava-1012116/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650eba8bcf1c7ed3048a0b20

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eba8bcf1c7ed3048a0b29
        failing since 57 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-09-23T10:18:38.692262  / # #

    2023-09-23T10:18:38.792787  export SHELL=3D/bin/sh

    2023-09-23T10:18:38.792924  #

    2023-09-23T10:18:38.893501  / # export SHELL=3D/bin/sh. /lava-11601118/=
environment

    2023-09-23T10:18:38.893700  =


    2023-09-23T10:18:38.994570  / # . /lava-11601118/environment/lava-11601=
118/bin/lava-test-runner /lava-11601118/1

    2023-09-23T10:18:38.995789  =


    2023-09-23T10:18:39.006654  / # /lava-11601118/bin/lava-test-runner /la=
va-11601118/1

    2023-09-23T10:18:39.048299  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-23T10:18:39.065681  + cd /lav<8>[   16.410238] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11601118_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/650ebac256ff23f5408a0a80

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/650ebac256ff23f5408a0a8a
        failing since 189 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-09-23T10:16:45.092665  /lava-11601140/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/650ebac256ff23f5408a0a8b
        failing since 189 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-09-23T10:16:44.055355  /lava-11601140/1/../bin/lava-test-case

    2023-09-23T10:16:44.066700  <8>[   34.364092] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ebaba7385185bd68a0ada

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ebaba7385185bd68a0ae3
        failing since 27 days (last pass: v5.10.191, first fail: v5.10.192)

    2023-09-23T10:17:17.066005  / # #

    2023-09-23T10:17:18.326953  export SHELL=3D/bin/sh

    2023-09-23T10:17:18.337823  #

    2023-09-23T10:17:18.338290  / # export SHELL=3D/bin/sh

    2023-09-23T10:17:20.082604  / # . /lava-11601112/environment

    2023-09-23T10:17:23.288324  /lava-11601112/bin/lava-test-runner /lava-1=
1601112/1

    2023-09-23T10:17:23.299684  . /lava-11601112/environment

    2023-09-23T10:17:23.301410  / # /lava-11601112/bin/lava-test-runner /la=
va-11601112/1

    2023-09-23T10:17:23.354600  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-23T10:17:23.355063  + cd /lava-11601112/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650eba9f9953d2a4de8a0a6f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.197/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650eba9f9953d2a4de8a0a78
        failing since 58 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-09-23T10:18:56.530550  / # #

    2023-09-23T10:18:56.632610  export SHELL=3D/bin/sh

    2023-09-23T10:18:56.633317  #

    2023-09-23T10:18:56.734661  / # export SHELL=3D/bin/sh. /lava-11601120/=
environment

    2023-09-23T10:18:56.735439  =


    2023-09-23T10:18:56.836904  / # . /lava-11601120/environment/lava-11601=
120/bin/lava-test-runner /lava-11601120/1

    2023-09-23T10:18:56.837919  =


    2023-09-23T10:18:56.854873  / # /lava-11601120/bin/lava-test-runner /la=
va-11601120/1

    2023-09-23T10:18:56.913949  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-23T10:18:56.914439  + cd /lava-1160112<8>[   18.285784] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11601120_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

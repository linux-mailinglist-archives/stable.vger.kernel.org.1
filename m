Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887267EC959
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 18:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjKORHT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 12:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKORHS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 12:07:18 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503B9FA
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 09:07:15 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc3542e328so53538405ad.1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 09:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700068034; x=1700672834; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g6FX0MP50m8ZN7nxDgtcsuBtS10V5ymkViCOYkeg5Fk=;
        b=b1ViU3IjE26+FeNJ+FfVi7EFlNNr9fNq4SdiLdIDE6JpcOOSDnJxwBripsj+t4nBkw
         5NrnFG1QJScd/yKYz6jnV6Ho5zjcUAtOJ9Ao7eYjzEWMxGSs85yo4pbZBaIGmy5fzbZA
         dCnV2I/uJOTv5mDwjB35SfIE6dujWITje93WyLGaD0cTx2OBPwh8QqIBNQRTbMxPNrvG
         2lw8CzQZwPygnddGUM5/zU6g5bqeMdBnr8T+ioVJzRbA17IUAk1Oz75CZGMeb/PfGgcd
         OK5SlzE4IBYEDQUesKqEMdafAvVrJCJeU++5EqIUxk26J/Lxw9eKaZJb+5/7blBYEd+l
         VvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700068034; x=1700672834;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6FX0MP50m8ZN7nxDgtcsuBtS10V5ymkViCOYkeg5Fk=;
        b=tKOUrxzHmlBHPZUiI24XG+eNq3/aFd5mVYkV3/IQHsndC/ND8RDC8R3echG8ODuiv8
         j2o7C7O5pjxX6EM40vIXHZ/LxmWBQYGCX9eyCPC61BSWeqoCion92vhYxF4DK8kdwQK2
         IioGj5LtqjRArbLg4Egw9Lvs0GLUsZTN0Bi95taEjZQXMbH7/9VSNKP/glijHFfgEt9I
         vugVpTCC3eYgD1t1087KLtVPJDk9J80WgpfgmdgWlwa69cesOZwZNYZ15WMsVlnf6q0P
         6I4D/VjUmvrp6wdH8wlmGH5I+oq0RgjgMVUFGM4rZ/Lp3pH6ZZBZNGGuZBxJM9SLUPJk
         bx1A==
X-Gm-Message-State: AOJu0Yw8/0VVm1x6raMUgDFWeaiBjZY4p28XFPK5mzF11l151I2h2U3O
        Av0UPHRyQBbtYswGC2ry8W2kYvYA2L6RXF8cR+8GNQ==
X-Google-Smtp-Source: AGHT+IGPLaU5K229nF5NAA9sSPSaVj7AKDRin6fIjEUnGCNkR5GVpfrNZDZ0PoAM8F+iUu/ggN+fvw==
X-Received: by 2002:a17:902:c40c:b0:1ca:7086:f009 with SMTP id k12-20020a170902c40c00b001ca7086f009mr7649880plk.61.1700068034291;
        Wed, 15 Nov 2023 09:07:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d24-20020a634f18000000b00588e8421fa8sm1416855pgb.84.2023.11.15.09.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:07:13 -0800 (PST)
Message-ID: <6554fac1.630a0220.70010.40cb@mx.google.com>
Date:   Wed, 15 Nov 2023 09:07:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.200-207-gc3a1f056425f
Subject: stable-rc/linux-5.10.y baseline: 103 runs,
 3 regressions (v5.10.200-207-gc3a1f056425f)
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

stable-rc/linux-5.10.y baseline: 103 runs, 3 regressions (v5.10.200-207-gc3=
a1f056425f)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.200-207-gc3a1f056425f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.200-207-gc3a1f056425f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c3a1f056425f657e26f2e5d3264afee187b962b4 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6554c8d6cf032378c67e4abe

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-207-gc3a1f056425f/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-207-gc3a1f056425f/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6554c8d6cf032378c67e4afc
        new failure (last pass: v5.10.200)

    2023-11-15T13:33:49.127862  <8>[   14.480868] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 243456_1.5.2.4.1>
    2023-11-15T13:33:49.237138  / # #
    2023-11-15T13:33:49.340059  export SHELL=3D/bin/sh
    2023-11-15T13:33:49.340850  #
    2023-11-15T13:33:49.442716  / # export SHELL=3D/bin/sh. /lava-243456/en=
vironment
    2023-11-15T13:33:49.443472  =

    2023-11-15T13:33:49.545400  / # . /lava-243456/environment/lava-243456/=
bin/lava-test-runner /lava-243456/1
    2023-11-15T13:33:49.546954  =

    2023-11-15T13:33:49.559869  / # /lava-243456/bin/lava-test-runner /lava=
-243456/1
    2023-11-15T13:33:49.619688  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6554c6b3f71790b7427e4af0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-207-gc3a1f056425f/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-207-gc3a1f056425f/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6554c6b3f71790b7427e4af9
        failing since 35 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-15T13:24:56.655462  <8>[   16.983733] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 444104_1.5.2.4.1>
    2023-11-15T13:24:56.760438  / # #
    2023-11-15T13:24:56.862062  export SHELL=3D/bin/sh
    2023-11-15T13:24:56.862630  #
    2023-11-15T13:24:56.963756  / # export SHELL=3D/bin/sh. /lava-444104/en=
vironment
    2023-11-15T13:24:56.964434  =

    2023-11-15T13:24:57.065532  / # . /lava-444104/environment/lava-444104/=
bin/lava-test-runner /lava-444104/1
    2023-11-15T13:24:57.066722  =

    2023-11-15T13:24:57.070844  / # /lava-444104/bin/lava-test-runner /lava=
-444104/1
    2023-11-15T13:24:57.137845  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6554c6d1c674a445e77e4b3a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-207-gc3a1f056425f/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-207-gc3a1f056425f/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6554c6d1c674a445e77e4b43
        failing since 35 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-15T13:31:58.421827  / # #

    2023-11-15T13:31:58.523922  export SHELL=3D/bin/sh

    2023-11-15T13:31:58.524614  #

    2023-11-15T13:31:58.625868  / # export SHELL=3D/bin/sh. /lava-12008621/=
environment

    2023-11-15T13:31:58.626583  =


    2023-11-15T13:31:58.727878  / # . /lava-12008621/environment/lava-12008=
621/bin/lava-test-runner /lava-12008621/1

    2023-11-15T13:31:58.728949  =


    2023-11-15T13:31:58.745731  / # /lava-12008621/bin/lava-test-runner /la=
va-12008621/1

    2023-11-15T13:31:58.789735  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-15T13:31:58.804794  + cd /lava-1200862<8>[   18.214486] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12008621_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

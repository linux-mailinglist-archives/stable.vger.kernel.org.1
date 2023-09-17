Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02C17A3ED0
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 01:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjIQXcz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 19:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjIQXct (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 19:32:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D48E7
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 16:32:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c4194f769fso26106105ad.3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 16:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694993562; x=1695598362; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZbbDE8rWuXmKxXBNqDofVsgMnnSBeoChUAcq8EqU20=;
        b=lK+ZQfTIifjurZaDN0MLJ3VnIw7zx4kCuSXt/ulDLyVPhBdzMWEjW1SWz2UWBXo+jO
         TR7LnfaeG5rNAC869UXhTKCTZB+yznSXNeXZZ9O7UcxYGepmZhVksA9W8bwT/3Femqva
         3NaTMCVYFDzafOGAEfXWz5diG8vd9BjQ/avPZGFztByrRJ81160BJwSRa3nYzu1C2IiV
         dAkHEWyxSeWZt1D1HlbHF91Vf5N3lH5g69FcZV5e8FXJVNds35v/IkAg4mtr6WjyGrRS
         gA3NvLCUmtvcS2AzORvZMt98u2qq38dY9SJCX2Bc6yJuqE9lIuQxGCo9jWJxp2LWcNDi
         RAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694993562; x=1695598362;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZbbDE8rWuXmKxXBNqDofVsgMnnSBeoChUAcq8EqU20=;
        b=NcKjpnkp7RxQ0Xbugo+FezNlJtcpROMT7ziTqtjECAPElkhdc9tclVkaPS3AtuyNLY
         GhLz0r8IszHoUfgdpgvmzLe+50vAmZsDpJ6CYd/aoNvdR7CzRqlqJBFP/61DsTxti2bz
         PGzgonNBa3oOA6xz2lyVBdGmsbiY+8NYrTeWUAZs8FlfiPNTvt9t6QtDcbJc1qgj6KSK
         tiAM/tpCiGi4tfmvvO/7frwoukd/mq+7Na9q8H0XZGwesT8OHbtblItCpskEat2KnFqa
         PJTEFxxEfnt5Cgda4TMa/vTrSyXd+GM49kN9/GS/zgLqtgCXO+9ogqKk2iejPU+hT9A0
         04KA==
X-Gm-Message-State: AOJu0YyomRxqoCqU2tlSt6Sk0AqMjeTYeRFtESDBvNiF+0Fe0BBz7cdT
        NY5cZU/HKKnn3n7drUv4fKJLqgCZRWWHn0uRmulpw1lj
X-Google-Smtp-Source: AGHT+IG7KfILlF8DofXbID3CGs0jJLBBAENLs5sVCVkD2I+ibZDs8uX6x2GBA1UayJApi3pu0Izqhg==
X-Received: by 2002:a17:902:d486:b0:1c3:e130:18f1 with SMTP id c6-20020a170902d48600b001c3e13018f1mr7072346plg.20.1694993562279;
        Sun, 17 Sep 2023 16:32:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902b60700b001b9f032bb3dsm7110854pls.3.2023.09.17.16.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 16:32:41 -0700 (PDT)
Message-ID: <65078c99.170a0220.20d6f.96f9@mx.google.com>
Date:   Sun, 17 Sep 2023 16:32:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.194-407-g794568ce435b
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 116 runs,
 10 regressions (v5.10.194-407-g794568ce435b)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 116 runs, 10 regressions (v5.10.194-407-g7=
94568ce435b)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.194-407-g794568ce435b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.194-407-g794568ce435b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      794568ce435b62c8e7f1f22e34fce4e6476de509 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650758b7f9eb168f7f8a0a95

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650758b7f9eb168f7f8a0a9e
        failing since 172 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-17T19:52:40.144942  + set +x

    2023-09-17T19:52:40.151547  <8>[   14.538076] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11556635_1.4.2.3.1>

    2023-09-17T19:52:40.255694  / # #

    2023-09-17T19:52:40.356264  export SHELL=3D/bin/sh

    2023-09-17T19:52:40.356465  #

    2023-09-17T19:52:40.456980  / # export SHELL=3D/bin/sh. /lava-11556635/=
environment

    2023-09-17T19:52:40.457189  =


    2023-09-17T19:52:40.557820  / # . /lava-11556635/environment/lava-11556=
635/bin/lava-test-runner /lava-11556635/1

    2023-09-17T19:52:40.558089  =


    2023-09-17T19:52:40.562336  / # /lava-11556635/bin/lava-test-runner /la=
va-11556635/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650758b9f9eb168f7f8a0aa0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650758b9f9eb168f7f8a0aa9
        failing since 172 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-17T19:52:30.894516  + set +x

    2023-09-17T19:52:30.901166  <8>[   10.245118] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11556651_1.4.2.3.1>

    2023-09-17T19:52:31.003583  =


    2023-09-17T19:52:31.104206  / # #export SHELL=3D/bin/sh

    2023-09-17T19:52:31.104443  =


    2023-09-17T19:52:31.205014  / # export SHELL=3D/bin/sh. /lava-11556651/=
environment

    2023-09-17T19:52:31.205256  =


    2023-09-17T19:52:31.305807  / # . /lava-11556651/environment/lava-11556=
651/bin/lava-test-runner /lava-11556651/1

    2023-09-17T19:52:31.306211  =


    2023-09-17T19:52:31.310982  / # /lava-11556651/bin/lava-test-runner /la=
va-11556651/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65075a8e02ca3a458e8a0a54

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65075a8e02ca3a458e8a0a94
        failing since 0 day (last pass: v5.10.194-314-geea281d7b56d, first =
fail: v5.10.194-406-g8281c551d5a7)

    2023-09-17T19:58:42.757353  / # #
    2023-09-17T19:58:42.860210  export SHELL=3D/bin/sh
    2023-09-17T19:58:42.860970  #
    2023-09-17T19:58:42.962924  / # export SHELL=3D/bin/sh. /lava-113372/en=
vironment
    2023-09-17T19:58:42.963701  =

    2023-09-17T19:58:43.065661  / # . /lava-113372/environment/lava-113372/=
bin/lava-test-runner /lava-113372/1
    2023-09-17T19:58:43.066976  =

    2023-09-17T19:58:43.081648  / # /lava-113372/bin/lava-test-runner /lava=
-113372/1
    2023-09-17T19:58:43.140472  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-17T19:58:43.140957  + cd /lava-113372/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6507598bcc95e37d2d8a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6507598bcc95e37d2d8a0a49
        failing since 61 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-17T19:54:31.136070  + set +x
    2023-09-17T19:54:31.139373  <8>[   84.022881] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1009564_1.5.2.4.1>
    2023-09-17T19:54:31.246493  / # #
    2023-09-17T19:54:32.711062  export SHELL=3D/bin/sh
    2023-09-17T19:54:32.732007  #
    2023-09-17T19:54:32.732466  / # export SHELL=3D/bin/sh
    2023-09-17T19:54:34.690564  / # . /lava-1009564/environment
    2023-09-17T19:54:38.292565  /lava-1009564/bin/lava-test-runner /lava-10=
09564/1
    2023-09-17T19:54:38.313993  . /lava-1009564/environment
    2023-09-17T19:54:38.314411  / # /lava-1009564/bin/lava-test-runner /lav=
a-1009564/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65075a678e8aaf2baf8a0a4c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihop=
e-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihop=
e-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65075a678e8aaf2baf8a0a53
        failing since 47 days (last pass: v5.10.186-10-g5f99a36aeb1c, first=
 fail: v5.10.188-107-gc262f74329e1)

    2023-09-17T19:58:07.714736  + set +x
    2023-09-17T19:58:07.717914  <8>[   84.000393] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1009574_1.5.2.4.1>
    2023-09-17T19:58:07.826711  / # #
    2023-09-17T19:58:09.291163  export SHELL=3D/bin/sh
    2023-09-17T19:58:09.312156  #
    2023-09-17T19:58:09.312654  / # export SHELL=3D/bin/sh
    2023-09-17T19:58:11.270619  / # . /lava-1009574/environment
    2023-09-17T19:58:14.872980  /lava-1009574/bin/lava-test-runner /lava-10=
09574/1
    2023-09-17T19:58:14.894478  . /lava-1009574/environment
    2023-09-17T19:58:14.894905  / # /lava-1009574/bin/lava-test-runner /lav=
a-1009574/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650759a1cc95e37d2d8a0a4d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650759a1cc95e37d2d8a0a54
        failing since 61 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-17T19:54:54.708432  / # #
    2023-09-17T19:54:56.173131  export SHELL=3D/bin/sh
    2023-09-17T19:54:56.193842  #
    2023-09-17T19:54:56.194131  / # export SHELL=3D/bin/sh
    2023-09-17T19:54:58.151128  / # . /lava-1009560/environment
    2023-09-17T19:55:01.751449  /lava-1009560/bin/lava-test-runner /lava-10=
09560/1
    2023-09-17T19:55:01.772236  . /lava-1009560/environment
    2023-09-17T19:55:01.772367  / # /lava-1009560/bin/lava-test-runner /lav=
a-1009560/1
    2023-09-17T19:55:01.850734  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-17T19:55:01.850952  + cd /lava-1009560/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65075a7c87a27a59ce8a0a4e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65075a7c87a27a59ce8a0a55
        failing since 61 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-17T19:58:38.823747  / # #
    2023-09-17T19:58:40.291577  export SHELL=3D/bin/sh
    2023-09-17T19:58:40.312153  #
    2023-09-17T19:58:40.312382  / # export SHELL=3D/bin/sh
    2023-09-17T19:58:42.268476  / # . /lava-1009569/environment
    2023-09-17T19:58:45.868681  /lava-1009569/bin/lava-test-runner /lava-10=
09569/1
    2023-09-17T19:58:45.889470  . /lava-1009569/environment
    2023-09-17T19:58:45.889583  / # /lava-1009569/bin/lava-test-runner /lav=
a-1009569/1
    2023-09-17T19:58:45.969000  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-17T19:58:45.969222  + cd /lava-1009569/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650759dbd2fb91d87e8a0a76

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650759dbd2fb91d87e8a0a7f
        failing since 61 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-17T20:00:23.572067  / # #

    2023-09-17T20:00:23.674176  export SHELL=3D/bin/sh

    2023-09-17T20:00:23.674885  #

    2023-09-17T20:00:23.776266  / # export SHELL=3D/bin/sh. /lava-11556696/=
environment

    2023-09-17T20:00:23.776998  =


    2023-09-17T20:00:23.878358  / # . /lava-11556696/environment/lava-11556=
696/bin/lava-test-runner /lava-11556696/1

    2023-09-17T20:00:23.879461  =


    2023-09-17T20:00:23.896332  / # /lava-11556696/bin/lava-test-runner /la=
va-11556696/1

    2023-09-17T20:00:23.945270  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-17T20:00:23.945787  + cd /lav<8>[   16.442397] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11556696_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65075a21607af73e6d8a0a46

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65075a21607af73e6d8a0a4f
        failing since 24 days (last pass: v5.10.191, first fail: v5.10.190-=
136-gda59b7b5c515e)

    2023-09-17T19:58:51.524496  / # #

    2023-09-17T19:58:52.785924  export SHELL=3D/bin/sh

    2023-09-17T19:58:52.796883  #

    2023-09-17T19:58:52.797416  / # export SHELL=3D/bin/sh

    2023-09-17T19:58:54.541608  / # . /lava-11556695/environment

    2023-09-17T19:58:57.747855  /lava-11556695/bin/lava-test-runner /lava-1=
1556695/1

    2023-09-17T19:58:57.759297  . /lava-11556695/environment

    2023-09-17T19:58:57.760306  / # /lava-11556695/bin/lava-test-runner /la=
va-11556695/1

    2023-09-17T19:58:57.814448  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-17T19:58:57.814929  + cd /lava-11556695/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650759ef9c1e2097708a0a50

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-407-g794568ce435b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650759ef9c1e2097708a0a59
        failing since 61 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-17T20:00:40.142053  / # #

    2023-09-17T20:00:40.244427  export SHELL=3D/bin/sh

    2023-09-17T20:00:40.245188  #

    2023-09-17T20:00:40.346616  / # export SHELL=3D/bin/sh. /lava-11556692/=
environment

    2023-09-17T20:00:40.347380  =


    2023-09-17T20:00:40.448854  / # . /lava-11556692/environment/lava-11556=
692/bin/lava-test-runner /lava-11556692/1

    2023-09-17T20:00:40.450091  =


    2023-09-17T20:00:40.465440  / # /lava-11556692/bin/lava-test-runner /la=
va-11556692/1

    2023-09-17T20:00:40.523573  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-17T20:00:40.524113  + cd /lava-1155669<8>[   18.207886] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11556692_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16241744B1D
	for <lists+stable@lfdr.de>; Sat,  1 Jul 2023 23:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGAVM7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 1 Jul 2023 17:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGAVM6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 1 Jul 2023 17:12:58 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0C7135
        for <stable@vger.kernel.org>; Sat,  1 Jul 2023 14:12:57 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-39eab4bbe8aso2264455b6e.1
        for <stable@vger.kernel.org>; Sat, 01 Jul 2023 14:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688245976; x=1690837976;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sWJkwTawHCubuUxFl+Sb9sR6+/SodJoO5cA4kq87obM=;
        b=V+H94c6CO4QiCxlxOiDFHGecfu3De25DRVFPXmzI4n6EoxLN9Fz6CfsYJiT8sH8eJU
         9dqlhKkDBOBHzQOnF9Fn0RYfHHjfZgGAB2Xp5DXi28yTyQF0vMjZd+S4s2c6h8QVryIv
         aFBiygkAQNDGRvn9sApYZX20Yu6+0RM0cG3wRzafSOyb7ZCb7u1qs6ctyavHVzxljoXR
         emj4ywcAm4vc4VlaYJN9xugUeogCgqtccawWTMEtYapS7cNz8zBvrjeqLUmNMmNUAv4f
         1f1hSfeB+gJ1UrEPXp6ZUpT46whBH2ySmmA+aWrEtss5K6qz0CxePHW4P+FQa4AgzWT2
         zIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688245976; x=1690837976;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWJkwTawHCubuUxFl+Sb9sR6+/SodJoO5cA4kq87obM=;
        b=Htqekpab6+9oI71VmkZ9Qe9e027cxG4Rogl7Gk6ORNL9OKjqos8FKrkYl2B0AIyjJH
         XkFsYgmMxpF2giecSDSYuXr2upneOh1oghXVDiQwRtbtP910jqY1WDa9EG6Ri+8epvpq
         25D7Dp4yEKf2F3S5XDteTn7/jVGby3X3AGuqKdUE2SMTUp7iuRbUVBptv6ocINQGo6Dt
         qNznJdhyF0sNAGk5+3tCdYqkHdACV+HVuu9MK5acCEeJ99PcifuyeoJP90UMXqJni1jd
         DYhmrKVUNvXLlF6djvohQt9pAY2VtTj/in6Ap7x+braihHcq5w/xvsFnhYMql/t8X4T8
         aE1w==
X-Gm-Message-State: AC+VfDx2F0TtTNfq7VhEOiIutL9L9qwOQ2os12zTdAO82ZetiDtJMlYc
        HAGfPZUq3hRIVWPtaiLokjWENmw63BpFjNLGtCVScQ==
X-Google-Smtp-Source: ACHHUZ60ZX6Myxgigm8+I2w79DScYJ3fInkGCTyOSD/OUstgQz/1zFFP+9JsmoKw6QpwaW9G08nj8A==
X-Received: by 2002:a05:6808:656:b0:3a3:65a8:c12f with SMTP id z22-20020a056808065600b003a365a8c12fmr6673528oih.16.1688245976036;
        Sat, 01 Jul 2023 14:12:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q17-20020a62ae11000000b00679dc747738sm9451348pff.10.2023.07.01.14.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 14:12:55 -0700 (PDT)
Message-ID: <64a096d7.620a0220.51fff.2f71@mx.google.com>
Date:   Sat, 01 Jul 2023 14:12:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.186
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 170 runs, 6 regressions (v5.10.186)
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

stable-rc/linux-5.10.y baseline: 170 runs, 6 regressions (v5.10.186)

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

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.186/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.186
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      381518b4a9165cd793599c1668c82079fcbcbe1f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64a062a66e49eb785dbb2a75

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a062a66e49eb785dbb2a7a
        failing since 164 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-07-01T17:29:49.945760  <8>[   11.083725] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3705492_1.5.2.4.1>
    2023-07-01T17:29:50.055321  / # #
    2023-07-01T17:29:50.158778  export SHELL=3D/bin/sh
    2023-07-01T17:29:50.159792  #
    2023-07-01T17:29:50.261908  / # export SHELL=3D/bin/sh. /lava-3705492/e=
nvironment
    2023-07-01T17:29:50.263339  =

    2023-07-01T17:29:50.366070  / # . /lava-3705492/environment/lava-370549=
2/bin/lava-test-runner /lava-3705492/1
    2023-07-01T17:29:50.367883  =

    2023-07-01T17:29:50.374407  / # /lava-3705492/bin/lava-test-runner /lav=
a-3705492/1
    2023-07-01T17:29:50.462002  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c20d2c1e469d03bd7d5f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c20d2c1e469d03bd7d5ff
        failing since 91 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-07-01T17:13:57.839625  + set +x

    2023-07-01T17:13:57.846283  <8>[   10.958104] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10977150_1.4.2.3.1>

    2023-07-01T17:13:57.950791  / # #

    2023-07-01T17:13:58.052290  export SHELL=3D/bin/sh

    2023-07-01T17:13:58.052461  #

    2023-07-01T17:13:58.152969  / # export SHELL=3D/bin/sh. /lava-10977150/=
environment

    2023-07-01T17:13:58.153462  =


    2023-07-01T17:13:58.254527  / # . /lava-10977150/environment/lava-10977=
150/bin/lava-test-runner /lava-10977150/1

    2023-07-01T17:13:58.255317  =


    2023-07-01T17:13:58.259692  / # /lava-10977150/bin/lava-test-runner /la=
va-10977150/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c20a06cea47a875d7d5e1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c20a06cea47a875d7d5ea
        failing since 91 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-07-01T17:13:53.428767  <8>[   11.231765] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10977149_1.4.2.3.1>

    2023-07-01T17:13:53.428863  + set +x

    2023-07-01T17:13:53.533489  / # #

    2023-07-01T17:13:53.634067  export SHELL=3D/bin/sh

    2023-07-01T17:13:53.634253  #

    2023-07-01T17:13:53.734779  / # export SHELL=3D/bin/sh. /lava-10977149/=
environment

    2023-07-01T17:13:53.734974  =


    2023-07-01T17:13:53.835510  / # . /lava-10977149/environment/lava-10977=
149/bin/lava-test-runner /lava-10977149/1

    2023-07-01T17:13:53.835836  =


    2023-07-01T17:13:53.835923  / # <6>[   11.550712] ACPI: \_PR_.CP00: Fou=
nd 3 idle states
 =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2502dac82504e6d7d5e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2502dac82504e6d7d5ef
        failing since 60 days (last pass: v5.10.147, first fail: v5.10.176-=
373-g8415c0f9308b)

    2023-06-28T12:17:51.135373  [   15.963611] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3697666_1.5.2.4.1>
    2023-06-28T12:17:51.239903  =

    2023-06-28T12:17:51.341378  / # #export SHELL=3D/bin/sh
    2023-06-28T12:17:51.341818  =

    2023-06-28T12:17:51.342051  / # [   16.093829] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-06-28T12:17:51.443309  export SHELL=3D/bin/sh. /lava-3697666/envir=
onment
    2023-06-28T12:17:51.443747  =

    2023-06-28T12:17:51.545183  / # . /lava-3697666/environment/lava-369766=
6/bin/lava-test-runner /lava-3697666/1
    2023-06-28T12:17:51.545867  =

    2023-06-28T12:17:51.549327  / # /lava-3697666/bin/lava-test-runner /lav=
a-3697666/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c27cc847f774548d7d6f6

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c27cc847f774548d7d71f
        failing since 148 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-28T12:29:35.356885  <8>[   17.098125] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3697683_1.5.2.4.1>
    2023-06-28T12:29:35.476687  / # #
    2023-06-28T12:29:35.582227  export SHELL=3D/bin/sh
    2023-06-28T12:29:35.583726  #
    2023-06-28T12:29:35.687160  / # export SHELL=3D/bin/sh. /lava-3697683/e=
nvironment
    2023-06-28T12:29:35.688743  =

    2023-06-28T12:29:35.792069  / # . /lava-3697683/environment/lava-369768=
3/bin/lava-test-runner /lava-3697683/1
    2023-06-28T12:29:35.794776  =

    2023-06-28T12:29:35.798088  / # /lava-3697683/bin/lava-test-runner /lav=
a-3697683/1
    2023-06-28T12:29:35.839250  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c25fc8229c29b0ad7d657

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c25fc8229c29b0ad7d687
        failing since 148 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-28T12:21:47.166202  + set +x
    2023-06-28T12:21:47.169481  <8>[   17.041970] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 672566_1.5.2.4.1>
    2023-06-28T12:21:47.286069  / # #
    2023-06-28T12:21:47.388153  export SHELL=3D/bin/sh
    2023-06-28T12:21:47.388652  #
    2023-06-28T12:21:47.490137  / # export SHELL=3D/bin/sh. /lava-672566/en=
vironment
    2023-06-28T12:21:47.490596  =

    2023-06-28T12:21:47.592341  / # . /lava-672566/environment/lava-672566/=
bin/lava-test-runner /lava-672566/1
    2023-06-28T12:21:47.593219  =

    2023-06-28T12:21:47.597197  / # /lava-672566/bin/lava-test-runner /lava=
-672566/1 =

    ... (12 line(s) more)  =

 =20

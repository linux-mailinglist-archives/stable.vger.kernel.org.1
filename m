Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B83C78F17C
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 18:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjHaQyl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 12:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbjHaQyk (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 12:54:40 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0B88F
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 09:54:36 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-564cd28d48dso799955a12.0
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693500875; x=1694105675; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/kEZXeTM/EsyTeeMwVvzTx+lPo34UrMHCtsqaijqhX8=;
        b=NJaVF70us/ptG86ixbXNGqLx8TtrAYIyLF1xTnv0gEO9Sd0Ml2939OtPOv/uvUDBgU
         V0VT9jTPwB7qpgTG9vVwnl0M01jb4O8EAGLb/qTaDuIXtgtyoQikQ3UIT1aEtIWIo+Ji
         qr4V9hWDUuH8uZGAJ5RaW2eGloI7Znway6u++f70+Sg6zXZehaSz6g4ZQ9SzlF57Egz9
         PQRrLTpn/ivMR5WGKJHPYfeTn8iwSUdmh4uXwIouD8jylNSoP3rbVB1ShAP/pwUIijeS
         fpo2JPnmVWRl4wNUVwOVj/41Iu7zjM2ShpDcebXmlfgAQvhTIDdqIigEqSz5kd7xMsNP
         IoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693500875; x=1694105675;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kEZXeTM/EsyTeeMwVvzTx+lPo34UrMHCtsqaijqhX8=;
        b=e3780ARSeGpIqKPR4ikvV0OeWM3aBSn9ZyuYYZAsR+fGLQp40YQx67/3gQNgXBLb3S
         lxQX8vFPq1UwIRhuElHtZunjjZWFtphZqcjg7Pyrg5TKxG/9Iq9cbHFa3W3yXojVl8KE
         jjWgJ+VIwE+0pLiABoOstHuOXpRDFsaaDQLZ6c+wSYCFjRCNMAj6pFakr1liEV/0tqVq
         kOzXNmz5FqfmKZ54+vOw7gIYajWFK+sswW0FunYAMAvUunyUIzWA0sihSq4U4wdK85te
         p1dUBC5cFyluOTwLCi9EqCGfdte2JoRxipObC4L8jKRQoynNEzz8A58XO3DDSmyMcPPn
         a76A==
X-Gm-Message-State: AOJu0YwlRlzByZ5QNgzFJo8w/4/mqhUgcMIkiRHO+YhIMR0t60sJnRmC
        s2dRHZ9XuNgCeRIoYFmJBZm8O2Fg16INcIrFBSs=
X-Google-Smtp-Source: AGHT+IG/945C2SjDi8aZNPeUtpmRzywFo2yu2rWvLrf6Wqb5Ophlsz6+iOPDvri+YMZNHBawVqYD/A==
X-Received: by 2002:a17:90a:e2ca:b0:268:c5c7:f7ed with SMTP id fr10-20020a17090ae2ca00b00268c5c7f7edmr5388790pjb.30.1693500875381;
        Thu, 31 Aug 2023 09:54:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090a060100b0026f3e396882sm3378510pjj.45.2023.08.31.09.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 09:54:34 -0700 (PDT)
Message-ID: <64f0c5ca.170a0220.3bf1.7aa9@mx.google.com>
Date:   Thu, 31 Aug 2023 09:54:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.193-12-ge25611a229ff9
Subject: stable-rc/linux-5.10.y baseline: 125 runs,
 13 regressions (v5.10.193-12-ge25611a229ff9)
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

stable-rc/linux-5.10.y baseline: 125 runs, 13 regressions (v5.10.193-12-ge2=
5611a229ff9)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
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

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.193-12-ge25611a229ff9/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.193-12-ge25611a229ff9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e25611a229ff9e907889923c2702d817003bc228 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f0932e7fd1d5ea2e286dae

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f0932e7fd1d5ea2e286db7
        failing since 225 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-31T13:18:24.146842  <8>[   11.210341] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3757910_1.5.2.4.1>
    2023-08-31T13:18:24.256438  / # #
    2023-08-31T13:18:24.359796  export SHELL=3D/bin/sh
    2023-08-31T13:18:24.360940  #
    2023-08-31T13:18:24.463165  / # export SHELL=3D/bin/sh. /lava-3757910/e=
nvironment
    2023-08-31T13:18:24.464372  =

    2023-08-31T13:18:24.566763  / # . /lava-3757910/environment/lava-375791=
0/bin/lava-test-runner /lava-3757910/1
    2023-08-31T13:18:24.568505  =

    2023-08-31T13:18:24.572978  / # /lava-3757910/bin/lava-test-runner /lav=
a-3757910/1
    2023-08-31T13:18:24.659355  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f09427e7d3075c38286da0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f09427e7d3075c38286da3
        failing since 44 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-31T13:22:32.626623  + [   15.659289] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1248310_1.5.2.4.1>
    2023-08-31T13:22:32.626918  set +x
    2023-08-31T13:22:32.732069  =

    2023-08-31T13:22:32.833261  / # #export SHELL=3D/bin/sh
    2023-08-31T13:22:32.833662  =

    2023-08-31T13:22:32.934630  / # export SHELL=3D/bin/sh. /lava-1248310/e=
nvironment
    2023-08-31T13:22:32.935032  =

    2023-08-31T13:22:33.036016  / # . /lava-1248310/environment/lava-124831=
0/bin/lava-test-runner /lava-1248310/1
    2023-08-31T13:22:33.036692  =

    2023-08-31T13:22:33.041050  / # /lava-1248310/bin/lava-test-runner /lav=
a-1248310/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f094243ba88983d4286d7d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f094243ba88983d4286d80
        failing since 180 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-31T13:22:18.291662  [   11.312328] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1248309_1.5.2.4.1>
    2023-08-31T13:22:18.397713  =

    2023-08-31T13:22:18.498975  / # #export SHELL=3D/bin/sh
    2023-08-31T13:22:18.499447  =

    2023-08-31T13:22:18.600429  / # export SHELL=3D/bin/sh. /lava-1248309/e=
nvironment
    2023-08-31T13:22:18.600880  =

    2023-08-31T13:22:18.701879  / # . /lava-1248309/environment/lava-124830=
9/bin/lava-test-runner /lava-1248309/1
    2023-08-31T13:22:18.702646  =

    2023-08-31T13:22:18.705806  / # /lava-1248309/bin/lava-test-runner /lav=
a-1248309/1
    2023-08-31T13:22:18.720750  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f0929622501ad7b7286ddd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f0929622501ad7b7286de6
        failing since 155 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-31T13:15:49.604569  + set +x

    2023-08-31T13:15:49.610895  <8>[   14.296041] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11390529_1.4.2.3.1>

    2023-08-31T13:15:49.715996  / # #

    2023-08-31T13:15:49.816651  export SHELL=3D/bin/sh

    2023-08-31T13:15:49.816922  #

    2023-08-31T13:15:49.917499  / # export SHELL=3D/bin/sh. /lava-11390529/=
environment

    2023-08-31T13:15:49.917711  =


    2023-08-31T13:15:50.018254  / # . /lava-11390529/environment/lava-11390=
529/bin/lava-test-runner /lava-11390529/1

    2023-08-31T13:15:50.018560  =


    2023-08-31T13:15:50.023140  / # /lava-11390529/bin/lava-test-runner /la=
va-11390529/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f09283611fc78da8286db3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f09283611fc78da8286dbc
        failing since 155 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-31T13:15:41.244251  <8>[   11.494060] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11390558_1.4.2.3.1>

    2023-08-31T13:15:41.247389  + set +x

    2023-08-31T13:15:41.348794  =


    2023-08-31T13:15:41.449466  / # #export SHELL=3D/bin/sh

    2023-08-31T13:15:41.449652  =


    2023-08-31T13:15:41.550294  / # export SHELL=3D/bin/sh. /lava-11390558/=
environment

    2023-08-31T13:15:41.550482  =


    2023-08-31T13:15:41.650989  / # . /lava-11390558/environment/lava-11390=
558/bin/lava-test-runner /lava-11390558/1

    2023-08-31T13:15:41.651283  =


    2023-08-31T13:15:41.656649  / # /lava-11390558/bin/lava-test-runner /la=
va-11390558/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f0946ee7d3075c38286e06

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f0946ee7d3075c38286e44
        new failure (last pass: v5.10.192-85-gc40f751018f92)

    2023-08-31T13:23:38.093966  / # #
    2023-08-31T13:23:38.196878  export SHELL=3D/bin/sh
    2023-08-31T13:23:38.197683  #
    2023-08-31T13:23:38.299691  / # export SHELL=3D/bin/sh. /lava-81298/env=
ironment
    2023-08-31T13:23:38.300428  =

    2023-08-31T13:23:38.402485  / # . /lava-81298/environment/lava-81298/bi=
n/lava-test-runner /lava-81298/1
    2023-08-31T13:23:38.403727  =

    2023-08-31T13:23:38.418129  / # /lava-81298/bin/lava-test-runner /lava-=
81298/1
    2023-08-31T13:23:38.476968  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-31T13:23:38.477461  + cd /lava-81298/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f095575ac6b2d5b5286dbb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f095575ac6b2d5b5286dbe
        failing since 44 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-31T13:27:30.867148  + set +x
    2023-08-31T13:27:30.867718  <8>[   83.867722] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1003464_1.5.2.4.1>
    2023-08-31T13:27:30.976419  / # #
    2023-08-31T13:27:32.446847  export SHELL=3D/bin/sh
    2023-08-31T13:27:32.468126  #
    2023-08-31T13:27:32.468687  / # export SHELL=3D/bin/sh
    2023-08-31T13:27:34.434432  / # . /lava-1003464/environment
    2023-08-31T13:27:38.050694  /lava-1003464/bin/lava-test-runner /lava-10=
03464/1
    2023-08-31T13:27:38.072554  . /lava-1003464/environment
    2023-08-31T13:27:38.073059  / # /lava-1003464/bin/lava-test-runner /lav=
a-1003464/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f096503b7c3d31d7286d82

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f096513b7c3d31d7286d85
        failing since 44 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-31T13:31:33.085715  + set +x
    2023-08-31T13:31:33.085837  <8>[   84.251365] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1003466_1.5.2.4.1>
    2023-08-31T13:31:33.191428  / # #
    2023-08-31T13:31:34.653867  export SHELL=3D/bin/sh
    2023-08-31T13:31:34.674570  #
    2023-08-31T13:31:34.674778  / # export SHELL=3D/bin/sh
    2023-08-31T13:31:36.631195  / # . /lava-1003466/environment
    2023-08-31T13:31:40.232340  /lava-1003466/bin/lava-test-runner /lava-10=
03466/1
    2023-08-31T13:31:40.253827  . /lava-1003466/environment
    2023-08-31T13:31:40.254120  / # /lava-1003466/bin/lava-test-runner /lav=
a-1003466/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f094846730eccf64286e1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f094846730eccf64286e1f
        failing since 44 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-31T13:23:55.905690  / # #
    2023-08-31T13:23:57.367906  export SHELL=3D/bin/sh
    2023-08-31T13:23:57.388499  #
    2023-08-31T13:23:57.388708  / # export SHELL=3D/bin/sh
    2023-08-31T13:23:59.344415  / # . /lava-1003455/environment
    2023-08-31T13:24:02.942937  /lava-1003455/bin/lava-test-runner /lava-10=
03455/1
    2023-08-31T13:24:02.963724  . /lava-1003455/environment
    2023-08-31T13:24:02.963834  / # /lava-1003455/bin/lava-test-runner /lav=
a-1003455/1
    2023-08-31T13:24:03.040189  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-31T13:24:03.040425  + cd /lava-1003455/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f095899be3c500f8286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f095899be3c500f8286d6f
        failing since 44 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-31T13:28:09.750855  / # #
    2023-08-31T13:28:11.212651  export SHELL=3D/bin/sh
    2023-08-31T13:28:11.233348  #
    2023-08-31T13:28:11.233552  / # export SHELL=3D/bin/sh
    2023-08-31T13:28:13.189973  / # . /lava-1003460/environment
    2023-08-31T13:28:16.789449  /lava-1003460/bin/lava-test-runner /lava-10=
03460/1
    2023-08-31T13:28:16.810241  . /lava-1003460/environment
    2023-08-31T13:28:16.810352  / # /lava-1003460/bin/lava-test-runner /lav=
a-1003460/1
    2023-08-31T13:28:16.889419  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-31T13:28:16.889636  + cd /lava-1003460/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f093b0aa4d64850f286de9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f093b0aa4d64850f286df2
        failing since 44 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-31T13:22:21.159006  / # #

    2023-08-31T13:22:21.260840  export SHELL=3D/bin/sh

    2023-08-31T13:22:21.261494  #

    2023-08-31T13:22:21.362611  / # export SHELL=3D/bin/sh. /lava-11390595/=
environment

    2023-08-31T13:22:21.363236  =


    2023-08-31T13:22:21.464371  / # . /lava-11390595/environment/lava-11390=
595/bin/lava-test-runner /lava-11390595/1

    2023-08-31T13:22:21.465335  =


    2023-08-31T13:22:21.467521  / # /lava-11390595/bin/lava-test-runner /la=
va-11390595/1

    2023-08-31T13:22:21.531470  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-31T13:22:21.532023  + cd /lav<8>[   16.409062] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11390595_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f093cdaa4d64850f286f07

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f093cdaa4d64850f286f10
        failing since 6 days (last pass: v5.10.191, first fail: v5.10.190-1=
36-gda59b7b5c515e)

    2023-08-31T13:22:26.617302  / # #

    2023-08-31T13:22:27.878197  export SHELL=3D/bin/sh

    2023-08-31T13:22:27.889156  #

    2023-08-31T13:22:27.889640  / # export SHELL=3D/bin/sh

    2023-08-31T13:22:29.630009  / # . /lava-11390592/environment

    2023-08-31T13:22:32.830195  /lava-11390592/bin/lava-test-runner /lava-1=
1390592/1

    2023-08-31T13:22:32.840975  . /lava-11390592/environment

    2023-08-31T13:22:32.841238  / # /lava-11390592/bin/lava-test-runner /la=
va-11390592/1

    2023-08-31T13:22:32.895060  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-31T13:22:32.895209  + cd /lava-11390592/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f093c4aa4d64850f286dff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
93-12-ge25611a229ff9/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f093c4aa4d64850f286e08
        failing since 44 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-31T13:22:35.945756  / # #

    2023-08-31T13:22:36.047076  export SHELL=3D/bin/sh

    2023-08-31T13:22:36.047729  #

    2023-08-31T13:22:36.148956  / # export SHELL=3D/bin/sh. /lava-11390602/=
environment

    2023-08-31T13:22:36.149597  =


    2023-08-31T13:22:36.250719  / # . /lava-11390602/environment/lava-11390=
602/bin/lava-test-runner /lava-11390602/1

    2023-08-31T13:22:36.250988  =


    2023-08-31T13:22:36.254510  / # /lava-11390602/bin/lava-test-runner /la=
va-11390602/1

    2023-08-31T13:22:36.322674  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-31T13:22:36.322825  + cd /lava-1139060<8>[   18.267179] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11390602_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B127654F4
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 15:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjG0N2Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 09:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjG0N2W (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 09:28:22 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFD72723
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 06:28:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666e97fcc60so719344b3a.3
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 06:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690464499; x=1691069299;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rxd60OVdtLKRv0Xyzzs3xsgOrD2yTDDloxJEdksDDx4=;
        b=XGIVH7IG43JnAlEPWCyUVIIwvR0zte2zI60hC6byaTRe+J3eyO9SV+2JBdm/wIlDYs
         xDeR3rFLqnmjFOj7b2BY6lCPuoov4ht4poDsCOmPb7H5Z7JZbrts6zkXr1facoRFZQ6+
         WT0YFn8aTMHQSTFI20t20aDp3i/aaiS9yGXz/tSxzXCv6XM0rCknEbAnklWTX6MzSboe
         oCIiCI6jfAedQU2h2dbHBrjejNB9iRtXqC4NWtNQX5yDv6G+pmbhVuVgrZ4zodnt+13h
         /vFK0dd5RpIDeQ/ZqIds8xWsEOe4WC30Dv/zPFYrV0c6DtkaF7l+WYs2bEjJ0p7WFueh
         EoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690464499; x=1691069299;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxd60OVdtLKRv0Xyzzs3xsgOrD2yTDDloxJEdksDDx4=;
        b=A2WBBmJ9TAQProkJPt2YLvpW9S557hCNHZPqOT9nBrGkpXZaD+8OniFGQj9GG6ePin
         HULftVjiEr+HG47KczMIy8tnY8datEguq9JYDBC5DTZU+DiBSEW1KtssBaUEV/nXbVgY
         8r/l4kJ73cPlpcwPCMslFvcNA/DPpSLUz87Vd34tN+0IieydhypNvaZZN7lievANJuan
         giNueTqWqh51xPrkcN5m1wi8nuvYgoa75WVgPY1wdDcmpaA84A0K+Gfc8KiEC5uUgpIc
         4s3Rpmo4l6Zt6+ArWskf0hY2IcNequZr/XXUE6gl7iac9LgUv27A6VBiKIvc1KHJXyFG
         +7HQ==
X-Gm-Message-State: ABy/qLYlnUwz3wnjP+hJKKwlVUU5StFKoqesaFNrH8Gp+7XYDa5FXz61
        3eqEFuvdpJY1owpkOQZyZe9J0V+UT4UIxkmfgVVK3w==
X-Google-Smtp-Source: APBJJlHXSPIizQ96e+LnbS1fs30NuVM7gdnRpUmuyPAAUMWFK4Jldl4jao3LBEQsbTFopVdw+giArg==
X-Received: by 2002:a05:6a00:140c:b0:686:fd66:a41c with SMTP id l12-20020a056a00140c00b00686fd66a41cmr1158870pfu.17.1690464499240;
        Thu, 27 Jul 2023 06:28:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y15-20020a637d0f000000b00563b36264besm1474084pgc.85.2023.07.27.06.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:28:18 -0700 (PDT)
Message-ID: <64c270f2.630a0220.cc961.22b6@mx.google.com>
Date:   Thu, 27 Jul 2023 06:28:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Kernel: v5.10.188
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 126 runs, 10 regressions (v5.10.188)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 126 runs, 10 regressions (v5.10.188)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

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

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.188/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.188
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3602dbc57b556eff2456715301d35a1ef8964bba =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23ffe07e90ad7338aceec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23ffe07e90ad7338acef1
        failing since 190 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-07-27T09:59:16.023012  <8>[   10.983016] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3725818_1.5.2.4.1>
    2023-07-27T09:59:16.130090  / # #
    2023-07-27T09:59:16.231557  export SHELL=3D/bin/sh
    2023-07-27T09:59:16.232058  #
    2023-07-27T09:59:16.333373  / # export SHELL=3D/bin/sh. /lava-3725818/e=
nvironment
    2023-07-27T09:59:16.333970  =

    2023-07-27T09:59:16.435329  / # . /lava-3725818/environment/lava-372581=
8/bin/lava-test-runner /lava-3725818/1
    2023-07-27T09:59:16.436024  =

    2023-07-27T09:59:16.440850  / # /lava-3725818/bin/lava-test-runner /lav=
a-3725818/1
    2023-07-27T09:59:16.526067  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23f9009d0e3559a8ace53

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-del=
l-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-del=
l-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c23f9009d0e3559a8ac=
e54
        new failure (last pass: v5.10.187-509-g76be48121794) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23fd35d952e1d418ace40

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23fd35d952e1d418ace43
        failing since 9 days (last pass: v5.10.142, first fail: v5.10.186-3=
32-gf98a4d3a5cec)

    2023-07-27T09:58:25.246516  [   14.909841] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1238937_1.5.2.4.1>
    2023-07-27T09:58:25.352285  =

    2023-07-27T09:58:25.453764  / # #export SHELL=3D/bin/sh
    2023-07-27T09:58:25.454368  =

    2023-07-27T09:58:25.555640  / # export SHELL=3D/bin/sh. /lava-1238937/e=
nvironment
    2023-07-27T09:58:25.556237  =

    2023-07-27T09:58:25.657461  / # . /lava-1238937/environment/lava-123893=
7/bin/lava-test-runner /lava-1238937/1
    2023-07-27T09:58:25.658305  =

    2023-07-27T09:58:25.662034  / # /lava-1238937/bin/lava-test-runner /lav=
a-1238937/1
    2023-07-27T09:58:25.683691  + export 'TESTRUN_[   15.346325] <LAVA_SIGN=
AL_STARTRUN 1_bootrr 1238937_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23fd65d952e1d418ace4e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23fd65d952e1d418ace51
        failing since 145 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-07-27T09:58:25.700054  [   14.454170] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1238938_1.5.2.4.1>
    2023-07-27T09:58:25.806466  =

    2023-07-27T09:58:25.907704  / # #export SHELL=3D/bin/sh
    2023-07-27T09:58:25.908089  =

    2023-07-27T09:58:26.009054  / # export SHELL=3D/bin/sh. /lava-1238938/e=
nvironment
    2023-07-27T09:58:26.009520  =

    2023-07-27T09:58:26.110519  / # . /lava-1238938/environment/lava-123893=
8/bin/lava-test-runner /lava-1238938/1
    2023-07-27T09:58:26.111220  =

    2023-07-27T09:58:26.115158  / # /lava-1238938/bin/lava-test-runner /lav=
a-1238938/1
    2023-07-27T09:58:26.129871  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23eb666afdf8bc18ace2b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23eb666afdf8bc18ace30
        failing since 120 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-07-27T09:53:39.813083  + set +x

    2023-07-27T09:53:39.818997  <8>[   10.062446] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11150217_1.4.2.3.1>

    2023-07-27T09:53:39.928287  / # #

    2023-07-27T09:53:40.031015  export SHELL=3D/bin/sh

    2023-07-27T09:53:40.031297  #

    2023-07-27T09:53:40.132143  / # export SHELL=3D/bin/sh. /lava-11150217/=
environment

    2023-07-27T09:53:40.132977  =


    2023-07-27T09:53:40.234509  / # . /lava-11150217/environment/lava-11150=
217/bin/lava-test-runner /lava-11150217/1

    2023-07-27T09:53:40.235669  =


    2023-07-27T09:53:40.240576  / # /lava-11150217/bin/lava-test-runner /la=
va-11150217/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23e8dcc4039dd348acec5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23e8dcc4039dd348aceca
        failing since 120 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-07-27T09:53:11.866230  <8>[   13.020284] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11150179_1.4.2.3.1>

    2023-07-27T09:53:11.869630  + set +x

    2023-07-27T09:53:11.970882  #

    2023-07-27T09:53:11.971115  =


    2023-07-27T09:53:12.071659  / # #export SHELL=3D/bin/sh

    2023-07-27T09:53:12.071838  =


    2023-07-27T09:53:12.172318  / # export SHELL=3D/bin/sh. /lava-11150179/=
environment

    2023-07-27T09:53:12.172524  =


    2023-07-27T09:53:12.273102  / # . /lava-11150179/environment/lava-11150=
179/bin/lava-test-runner /lava-11150179/1

    2023-07-27T09:53:12.273362  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c240019d5b0809508ace6e

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c240019d5b0809508acea7
        failing since 9 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-27T09:58:53.511225  / # #
    2023-07-27T09:58:53.614091  export SHELL=3D/bin/sh
    2023-07-27T09:58:53.614860  #
    2023-07-27T09:58:53.716855  / # export SHELL=3D/bin/sh. /lava-12872/env=
ironment
    2023-07-27T09:58:53.717624  =

    2023-07-27T09:58:53.819591  / # . /lava-12872/environment/lava-12872/bi=
n/lava-test-runner /lava-12872/1
    2023-07-27T09:58:53.820929  =

    2023-07-27T09:58:53.835248  / # /lava-12872/bin/lava-test-runner /lava-=
12872/1
    2023-07-27T09:58:53.893060  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-27T09:58:53.893582  + cd /lava-12872/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23ff308b37a634f8ace65

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23ff308b37a634f8ace68
        failing since 9 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-27T09:58:53.291797  / # #
    2023-07-27T09:58:54.753100  export SHELL=3D/bin/sh
    2023-07-27T09:58:54.773559  #
    2023-07-27T09:58:54.773691  / # export SHELL=3D/bin/sh
    2023-07-27T09:58:56.658075  / # . /lava-989712/environment
    2023-07-27T09:59:00.113983  /lava-989712/bin/lava-test-runner /lava-989=
712/1
    2023-07-27T09:59:00.134771  . /lava-989712/environment
    2023-07-27T09:59:00.134881  / # /lava-989712/bin/lava-test-runner /lava=
-989712/1
    2023-07-27T09:59:00.214001  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-27T09:59:00.214399  + cd /lava-989712/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c265cb9531ca38d98ace1e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c265cb9531ca38d98ace23
        failing since 9 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-27T12:41:59.391062  / # #

    2023-07-27T12:41:59.493127  export SHELL=3D/bin/sh

    2023-07-27T12:41:59.493842  #

    2023-07-27T12:41:59.595267  / # export SHELL=3D/bin/sh. /lava-11150237/=
environment

    2023-07-27T12:41:59.595986  =


    2023-07-27T12:41:59.697474  / # . /lava-11150237/environment/lava-11150=
237/bin/lava-test-runner /lava-11150237/1

    2023-07-27T12:41:59.698574  =


    2023-07-27T12:41:59.715172  / # /lava-11150237/bin/lava-test-runner /la=
va-11150237/1

    2023-07-27T12:41:59.764310  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T12:41:59.764827  + cd /lav<8>[   16.446216] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11150237_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23f57b2c6f7745f8acf6a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23f57b2c6f7745f8acf6f
        failing since 9 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-27T09:58:03.779555  / # #

    2023-07-27T09:58:03.881755  export SHELL=3D/bin/sh

    2023-07-27T09:58:03.882487  #

    2023-07-27T09:58:03.983865  / # export SHELL=3D/bin/sh. /lava-11150250/=
environment

    2023-07-27T09:58:03.984627  =


    2023-07-27T09:58:04.086143  / # . /lava-11150250/environment/lava-11150=
250/bin/lava-test-runner /lava-11150250/1

    2023-07-27T09:58:04.087345  =


    2023-07-27T09:58:04.089595  / # /lava-11150250/bin/lava-test-runner /la=
va-11150250/1

    2023-07-27T09:58:04.133495  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T09:58:04.163562  + cd /lava-1115025<8>[   18.261224] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11150250_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

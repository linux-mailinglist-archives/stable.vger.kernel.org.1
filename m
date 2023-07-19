Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66F175A0A4
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 23:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjGSVf3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 17:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSVf2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 17:35:28 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE87C1FD2
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 14:35:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-66c729f5618so71010b3a.1
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689802525; x=1692394525;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fvJkwsb7NPH4Zo6hE64kxmbabL++zVjdGy1lK5rKeGo=;
        b=Cq57VITubQuAn2fyaonxcLPI+g40O/hZhV8pXASDiYCzVc3tglwnjGO0ACMCkKoco5
         5u9lpwkLCszH/1OSc111OaL8cEEsttjMZqwqBVguexnAFk0HLuqKOwuDWOQjKuGmPoqQ
         J9gap9GmQfSiIZgGhQKLm2vfORAq5MBTuQbWOESQidT8h4F+o48IJC3F/XEgFlRrji6H
         OpyK6c08liIDbpSdolcxNmhZOVkyZoJT+wQLkumkt+MiJa9PCDlcMsxS7RC5xQOiqkdi
         PfJ7Bik/j+c8X3faXaBGPYUz6t902MiRxxMtC5cK04tFkRBd/YIP72BLViz/SIfBmdov
         z43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802525; x=1692394525;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvJkwsb7NPH4Zo6hE64kxmbabL++zVjdGy1lK5rKeGo=;
        b=WS849J30b0MxlxbEbTEV5Q3KnKdUvRvjNFh0hJfB5VYa5abgvxOfjp2x/HT76rGJgG
         TnfnQasLz0pPh9eq0qfqBQFBAvy9nXApVzlhamoD1QxjhNbmbLqIiwnH7pvtJQuFCJpA
         jp4xyj0t+26PJV9KxX5XJQ81DNsTAIWBFMqpfdpb/iaDLi526OsNHZySKMeCp7eyOgxR
         mtKbBu1VD9Bsq7OiLgh1+C3TkDiW0fwgrU+I8o8BQANNNK1Q1H8Ez24elEa35v16MLON
         RPIq22DVBtjq1LQp595udH3Eyl83/yZRn5z5WOdq5q2KbigqS6QfWZ2YLxmITtP5fWJb
         kLsg==
X-Gm-Message-State: ABy/qLabC1DKIivPXGwssMltlZ5KAk1c0VJSCiomemj35SE9ocbF/9gm
        S4O7Wf+fNhEI/XFj1bwlaadf5xanXJVWHj2aIa8DVQ==
X-Google-Smtp-Source: APBJJlH3mSMNFrYUIYdrHqpW2BnEwJQ0BKYO/ID2htzuE9U1kTCszxHycoVc8DKw7ulgDega1yPh9w==
X-Received: by 2002:a05:6a00:1390:b0:666:7bc5:531c with SMTP id t16-20020a056a00139000b006667bc5531cmr5400299pfg.24.1689802524521;
        Wed, 19 Jul 2023 14:35:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j7-20020a62e907000000b00673e652985esm3395764pfh.44.2023.07.19.14.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 14:35:24 -0700 (PDT)
Message-ID: <64b8571c.620a0220.50b76.7633@mx.google.com>
Date:   Wed, 19 Jul 2023 14:35:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Kernel: v5.10.186
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 195 runs, 17 regressions (v5.10.186)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 195 runs, 17 regressions (v5.10.186)

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
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
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

    2023-07-19T17:44:00.323705  <8>[   11.078810] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3723264_1.5.2.4.1>
    2023-07-19T17:44:00.434060  / # #
    2023-07-19T17:44:00.537561  export SHELL=3D/bin/sh
    2023-07-19T17:44:00.538719  #
    2023-07-19T17:44:00.641027  / # export SHELL=3D/bin/sh. /lava-3723264/e=
nvironment
    2023-07-19T17:44:00.642190  =

    2023-07-19T17:44:00.744466  / # . /lava-3723264/environment/lava-372326=
4/bin/lava-test-runner /lava-3723264/1
    2023-07-19T17:44:00.746189  =

    2023-07-19T17:44:00.751050  / # /lava-3723264/bin/lava-test-runner /lav=
a-3723264/1
    2023-07-19T17:44:00.836890  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b8268f8fb48d9aa68ace1d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b8268f8fb48d9aa68ace20
        failing since 1 day (last pass: v5.10.142, first fail: v5.10.186-33=
2-gf98a4d3a5cec)

    2023-07-19T18:08:03.385238  [   14.597351] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1237668_1.5.2.4.1>
    2023-07-19T18:08:03.490384  =

    2023-07-19T18:08:03.591561  / # #export SHELL=3D/bin/sh
    2023-07-19T18:08:03.591957  =

    2023-07-19T18:08:03.692892  / # export SHELL=3D/bin/sh. /lava-1237668/e=
nvironment
    2023-07-19T18:08:03.693290  =

    2023-07-19T18:08:03.794227  / # . /lava-1237668/environment/lava-123766=
8/bin/lava-test-runner /lava-1237668/1
    2023-07-19T18:08:03.794852  =

    2023-07-19T18:08:03.799220  / # /lava-1237668/bin/lava-test-runner /lav=
a-1237668/1
    2023-07-19T18:08:03.819603  + export 'TESTRUN_[   15.030996] <LAVA_SIGN=
AL_STARTRUN 1_bootrr 1237668_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b826a23012741e308ace26

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b826a23012741e308ace29
        failing since 137 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-07-19T18:08:20.875243  [   10.469812] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1237667_1.5.2.4.1>
    2023-07-19T18:08:20.980999  =

    2023-07-19T18:08:21.082306  / # #export SHELL=3D/bin/sh
    2023-07-19T18:08:21.082743  =

    2023-07-19T18:08:21.183767  / # export SHELL=3D/bin/sh. /lava-1237667/e=
nvironment
    2023-07-19T18:08:21.184245  =

    2023-07-19T18:08:21.285313  / # . /lava-1237667/environment/lava-123766=
7/bin/lava-test-runner /lava-1237667/1
    2023-07-19T18:08:21.286109  =

    2023-07-19T18:08:21.289973  / # /lava-1237667/bin/lava-test-runner /lav=
a-1237667/1
    2023-07-19T18:08:21.305672  + export 'TESTRUN_ID=3D1_bootrr' =

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

    2023-07-19T17:53:02.601971  + <8>[   10.436731] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11113917_1.4.2.3.1>

    2023-07-19T17:53:02.602054  set +x

    2023-07-19T17:53:02.703424  =


    2023-07-19T17:53:02.804210  / # #export SHELL=3D/bin/sh

    2023-07-19T17:53:02.804400  =


    2023-07-19T17:53:02.904967  / # export SHELL=3D/bin/sh. /lava-11113917/=
environment

    2023-07-19T17:53:02.905140  =


    2023-07-19T17:53:03.005778  / # . /lava-11113917/environment/lava-11113=
917/bin/lava-test-runner /lava-11113917/1

    2023-07-19T17:53:03.006057  =


    2023-07-19T17:53:03.011031  / # /lava-11113917/bin/lava-test-runner /la=
va-11113917/1
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

    2023-07-19T17:53:19.520836  + set +x<8>[   12.799347] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11113944_1.4.2.3.1>

    2023-07-19T17:53:19.520915  =


    2023-07-19T17:53:19.622430  #

    2023-07-19T17:53:19.622654  =


    2023-07-19T17:53:19.723159  / # #export SHELL=3D/bin/sh

    2023-07-19T17:53:19.723302  =


    2023-07-19T17:53:19.823755  / # export SHELL=3D/bin/sh. /lava-11113944/=
environment

    2023-07-19T17:53:19.823908  =


    2023-07-19T17:53:19.924394  / # . /lava-11113944/environment/lava-11113=
944/bin/lava-test-runner /lava-11113944/1

    2023-07-19T17:53:19.924674  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c260143ee25b183d7d638

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c260143ee25b183d7d678
        failing since 1 day (last pass: v5.10.186-221-gf178eace6e074, first=
 fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-19T18:22:46.236607  / # #
    2023-07-19T18:22:46.339468  export SHELL=3D/bin/sh
    2023-07-19T18:22:46.340236  #
    2023-07-19T18:22:46.442174  / # export SHELL=3D/bin/sh. /lava-2138/envi=
ronment
    2023-07-19T18:22:46.442971  =

    2023-07-19T18:22:46.545046  / # . /lava-2138/environment/lava-2138/bin/=
lava-test-runner /lava-2138/1
    2023-07-19T18:22:46.546357  =

    2023-07-19T18:22:46.560731  / # /lava-2138/bin/lava-test-runner /lava-2=
138/1
    2023-07-19T18:22:46.619514  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-19T18:22:46.620045  + cd /lava-2138/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649ceda8d2d8fe4699bb2a88

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649ceda8d2d8fe4699bb2a8b
        failing since 1 day (last pass: v5.10.186-221-gf178eace6e074, first=
 fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-19T17:51:28.923753  + set +x
    2023-07-19T17:51:28.923862  <8>[   83.634998] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 987690_1.5.2.4.1>
    2023-07-19T17:51:29.029886  / # #
    2023-07-19T17:51:30.489005  export SHELL=3D/bin/sh
    2023-07-19T17:51:30.509426  #
    2023-07-19T17:51:30.509552  / # export SHELL=3D/bin/sh
    2023-07-19T17:51:32.390601  / # . /lava-987690/environment
    2023-07-19T17:51:35.840879  /lava-987690/bin/lava-test-runner /lava-987=
690/1
    2023-07-19T17:51:35.861443  . /lava-987690/environment
    2023-07-19T17:51:35.861542  / # /lava-987690/bin/lava-test-runner /lava=
-987690/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c228686ef8fa008d7d5fd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope=
-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope=
-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c228686ef8fa008d7d604
        failing since 1 day (last pass: v5.10.186-221-gf178eace6e074, first=
 fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-19T17:51:38.587268  + set +x
    2023-07-19T17:51:38.587379  <8>[   83.897005] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 987684_1.5.2.4.1>
    2023-07-19T17:51:38.694164  / # #
    2023-07-19T17:51:40.153182  export SHELL=3D/bin/sh
    2023-07-19T17:51:40.173617  #
    2023-07-19T17:51:40.173791  / # export SHELL=3D/bin/sh
    2023-07-19T17:51:42.054447  / # . /lava-987684/environment
    2023-07-19T17:51:45.504158  /lava-987684/bin/lava-test-runner /lava-987=
684/1
    2023-07-19T17:51:45.524748  . /lava-987684/environment
    2023-07-19T17:51:45.524869  / # /lava-987684/bin/lava-test-runner /lava=
-987684/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649c2287c2d6cd9e36d7d641

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c2287c2d6cd9e36d7d648
        failing since 1 day (last pass: v5.10.186-221-gf178eace6e074, first=
 fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-19T17:51:20.489032  / # #
    2023-07-19T17:51:21.948038  export SHELL=3D/bin/sh
    2023-07-19T17:51:21.968475  #
    2023-07-19T17:51:21.968618  / # export SHELL=3D/bin/sh
    2023-07-19T17:51:23.849970  / # . /lava-987689/environment
    2023-07-19T17:51:27.299814  /lava-987689/bin/lava-test-runner /lava-987=
689/1
    2023-07-19T17:51:27.320532  . /lava-987689/environment
    2023-07-19T17:51:27.320649  / # /lava-987689/bin/lava-test-runner /lava=
-987689/1
    2023-07-19T17:51:27.353111  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-19T17:51:27.401346  + cd /lava-987689/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c26d15e24aa94a5d7d5f3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c26d15e24aa94a5d7d5fa
        failing since 1 day (last pass: v5.10.186-221-gf178eace6e074, first=
 fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-19T18:09:06.341482  / # #
    2023-07-19T18:09:07.800271  export SHELL=3D/bin/sh
    2023-07-19T18:09:07.820724  #
    2023-07-19T18:09:07.820896  / # export SHELL=3D/bin/sh
    2023-07-19T18:09:09.701774  / # . /lava-987693/environment
    2023-07-19T18:09:13.152179  /lava-987693/bin/lava-test-runner /lava-987=
693/1
    2023-07-19T18:09:13.172868  . /lava-987693/environment
    2023-07-19T18:09:13.173011  / # /lava-987693/bin/lava-test-runner /lava=
-987693/1
    2023-07-19T18:09:13.205400  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-19T18:09:13.254271  + cd /lava-987693/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c24d8b9e0420cded7d5e1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c24d8b9e0420cded7d5ea
        failing since 1 day (last pass: v5.10.186-221-gf178eace6e074, first=
 fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-19T18:07:53.890274  / # #

    2023-07-19T18:07:53.992154  export SHELL=3D/bin/sh

    2023-07-19T18:07:53.992297  #

    2023-07-19T18:07:54.092784  / # export SHELL=3D/bin/sh. /lava-11114034/=
environment

    2023-07-19T18:07:54.092905  =


    2023-07-19T18:07:54.193404  / # . /lava-11114034/environment/lava-11114=
034/bin/lava-test-runner /lava-11114034/1

    2023-07-19T18:07:54.193583  =


    2023-07-19T18:07:54.198651  / # /lava-11114034/bin/lava-test-runner /la=
va-11114034/1

    2023-07-19T18:07:54.259250  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-19T18:07:54.259329  + cd /lav<8>[   16.414401] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11114034_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

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

    2023-07-19T18:06:30.744762  [   15.975982] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3723313_1.5.2.4.1>
    2023-07-19T18:06:30.849285  =

    2023-07-19T18:06:30.849525  / # #[   16.061005] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-07-19T18:06:30.950906  export SHELL=3D/bin/sh
    2023-07-19T18:06:30.951516  =

    2023-07-19T18:06:31.053084  / # export SHELL=3D/bin/sh. /lava-3723313/e=
nvironment
    2023-07-19T18:06:31.053840  =

    2023-07-19T18:06:31.155599  / # . /lava-3723313/environment/lava-372331=
3/bin/lava-test-runner /lava-3723313/1
    2023-07-19T18:06:31.156866  =

    2023-07-19T18:06:31.160065  / # /lava-3723313/bin/lava-test-runner /lav=
a-3723313/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b81ff4addf9d9f538ace23

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b81ff4addf9d9f538ace28
        failing since 166 days (last pass: v5.10.147, first fail: v5.10.166=
-10-g6278b8c9832e)

    2023-07-19T17:39:48.634426  <8>[   12.874229] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3723253_1.5.2.4.1>
    2023-07-19T17:39:48.740407  / # #
    2023-07-19T17:39:48.842564  export SHELL=3D/bin/sh
    2023-07-19T17:39:48.844113  #
    2023-07-19T17:39:48.945565  / # export SHELL=3D/bin/sh. /lava-3723253/e=
nvironment
    2023-07-19T17:39:48.945974  =

    2023-07-19T17:39:49.047959  / # . /lava-3723253/environment/lava-372325=
3/bin/lava-test-runner /lava-3723253/1
    2023-07-19T17:39:49.048878  =

    2023-07-19T17:39:49.052500  / # /lava-3723253/bin/lava-test-runner /lav=
a-3723253/1
    2023-07-19T17:39:49.119428  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

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

    2023-07-19T18:18:11.142473  + set +x
    2023-07-19T18:18:11.146293  <8>[   17.061301] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 2136_1.5.2.4.1>
    2023-07-19T18:18:11.257861  / # #
    2023-07-19T18:18:11.360882  export SHELL=3D/bin/sh
    2023-07-19T18:18:11.361601  #
    2023-07-19T18:18:11.463862  / # export SHELL=3D/bin/sh. /lava-2136/envi=
ronment
    2023-07-19T18:18:11.464589  =

    2023-07-19T18:18:11.566925  / # . /lava-2136/environment/lava-2136/bin/=
lava-test-runner /lava-2136/1
    2023-07-19T18:18:11.568191  =

    2023-07-19T18:18:11.572760  / # /lava-2136/bin/lava-test-runner /lava-2=
136/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b8265446e56733b98ace78

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b8265446e56733b98ace7d
        failing since 1 day (last pass: v5.10.186-221-gf178eace6e074, first=
 fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-19T18:07:01.552806  / # #
    2023-07-19T18:07:01.654482  export SHELL=3D/bin/sh
    2023-07-19T18:07:01.654834  #
    2023-07-19T18:07:01.756144  / # export SHELL=3D/bin/sh. /lava-3723334/e=
nvironment
    2023-07-19T18:07:01.756495  =

    2023-07-19T18:07:01.857820  / # . /lava-3723334/environment/lava-372333=
4/bin/lava-test-runner /lava-3723334/1
    2023-07-19T18:07:01.858423  =

    2023-07-19T18:07:01.864840  / # /lava-3723334/bin/lava-test-runner /lav=
a-3723334/1
    2023-07-19T18:07:01.930000  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-19T18:07:01.930258  + cd /lava-3723334<8>[   17.642053] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 3723334_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649c24ecedb58ad3e0d7d5f2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c24ecedb58ad3e0d7d5fb
        failing since 1 day (last pass: v5.10.186-221-gf178eace6e074, first=
 fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-19T18:08:09.144757  / # #

    2023-07-19T18:08:09.246986  export SHELL=3D/bin/sh

    2023-07-19T18:08:09.247679  #

    2023-07-19T18:08:09.349112  / # export SHELL=3D/bin/sh. /lava-11114047/=
environment

    2023-07-19T18:08:09.349804  =


    2023-07-19T18:08:09.451233  / # . /lava-11114047/environment/lava-11114=
047/bin/lava-test-runner /lava-11114047/1

    2023-07-19T18:08:09.452341  =


    2023-07-19T18:08:09.469065  / # /lava-11114047/bin/lava-test-runner /la=
va-11114047/1

    2023-07-19T18:08:09.526943  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-19T18:08:09.527440  + cd /lava-1111404<8>[   18.324509] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11114047_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

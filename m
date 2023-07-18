Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2587572CF
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 06:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjGREcY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 00:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGREcW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 00:32:22 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8671B5
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 21:32:18 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3476c902f2aso25764955ab.3
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 21:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689654738; x=1692246738;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PRHPvUuo3OKENL7Hk+UxxpNHIF4MA9ltu+1dGzfa/Hk=;
        b=utCOr061FpUBR5DKDuaMgDQ5cBqBqhN6hcI68Gq9fLCi3M/pyTUqEovadeGR4S1UH2
         xza8ECS7dGhbhxABRvQstSuUMiVX9YsQQ01eUuylJGt0tmIpKB05H+xmiVmKmVeIPPhv
         8Pa+VDEj8INddCwmCzUNlbIVJoxKUGbk2/piSCXertw/Yf05W6abBENDTxys+ZkIiruc
         tb3eMQ67VuwFNjG1vWnQqX73zXJSyKHI61yG/tikbiqKBzrZfmJ0AuLQ4uel7xtcaRbR
         fxkpj2D84ksDhS9F9SYhzUnQlECMfXShcdrUxQnVrbs0mrXIOva4LU4gnMQ0teDG40vM
         g88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689654738; x=1692246738;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRHPvUuo3OKENL7Hk+UxxpNHIF4MA9ltu+1dGzfa/Hk=;
        b=NN/SMFlsE3BixQsvOey8gNxaV8TM5q9mXV52fWYFM4Hlo7fBL+TqZQipWDnmKk89Xc
         0/xsMjDrOuMi2wvmDd/I1Od9a7y9YnwCrg1Dp1xPEY4EAwZboq7q2Pwn0a+3Sn1xIyCF
         pFn2gmv593M060q32/PDrcYzL/w4bwJ+/vFcXbE4PGvDD35iopQa6GpGZP+AjR20074e
         qHOtcDxUC6+HzeyuuPWkvpea+Dwyfncg+c8vc16gRVVJnyL9VqP3Ws9zgLUAthnbMqXL
         L0tzH4uV5pItSo3VZLwSklM9jgF7VXNM6OyL5liU4kJKqZzbILP/vM36hcZJNqL7TQ1/
         XOXg==
X-Gm-Message-State: ABy/qLbOcrmwOQ6Yx1HM9kQvtbUaE6vBsuy0YjlSewqqakWuPpZqPc6t
        3mPuKoL9SHGNgSAroHeJXgZZcu1aFhzI6Pbwnxlp5g==
X-Google-Smtp-Source: APBJJlHLOEPizWkgbaLFBUxrXBRpRXHlyaFutt4E/B5rm5zCJOLhGEHeaDED6N8rrZDPULKr23k7jQ==
X-Received: by 2002:a05:6e02:15c2:b0:347:73b4:9cf6 with SMTP id q2-20020a056e0215c200b0034773b49cf6mr1994266ilu.23.1689654737478;
        Mon, 17 Jul 2023 21:32:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g12-20020a17090a714c00b00263b4b1255esm5528277pjs.51.2023.07.17.21.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 21:32:16 -0700 (PDT)
Message-ID: <64b615d0.170a0220.92a0a.a244@mx.google.com>
Date:   Mon, 17 Jul 2023 21:32:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Kernel: v5.10.186-332-gf98a4d3a5cec
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 172 runs,
 19 regressions (v5.10.186-332-gf98a4d3a5cec)
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

stable-rc/linux-5.10.y baseline: 172 runs, 19 regressions (v5.10.186-332-gf=
98a4d3a5cec)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

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

meson-gxl-s905d-p230         | arm64  | lab-baylibre  | gcc-10   | defconfi=
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
nel/v5.10.186-332-gf98a4d3a5cec/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.186-332-gf98a4d3a5cec
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f98a4d3a5cece801f74889cb01faf420a9e6a57c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e5548243c02ae28ace48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at=
91-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at=
91-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b5e5548243c02ae28ac=
e49
        new failure (last pass: v5.10.186-221-gf178eace6e074) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e48d3b8b4f82b08ace52

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e48d3b8b4f82b08ace57
        failing since 181 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-07-18T01:01:43.926823  <8>[   11.115534] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3721916_1.5.2.4.1>
    2023-07-18T01:01:44.034157  / # #
    2023-07-18T01:01:44.136975  export SHELL=3D/bin/sh
    2023-07-18T01:01:44.137861  #
    2023-07-18T01:01:44.244475  / # export SHELL=3D/bin/sh. /lava-3721916/e=
nvironment
    2023-07-18T01:01:44.245245  =

    2023-07-18T01:01:44.347053  / # . /lava-3721916/environment/lava-372191=
6/bin/lava-test-runner /lava-3721916/1
    2023-07-18T01:01:44.347686  =

    2023-07-18T01:01:44.352564  / # /lava-3721916/bin/lava-test-runner /lav=
a-3721916/1
    2023-07-18T01:01:44.442428  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e4f065e67f85518acea5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e4f065e67f85518acea8
        new failure (last pass: v5.10.142)

    2023-07-18T01:03:18.848914  [    9.980254] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1237042_1.5.2.4.1>
    2023-07-18T01:03:18.951706  =

    2023-07-18T01:03:19.052521  / # #export SHELL=3D/bin/sh
    2023-07-18T01:03:19.052881  =

    2023-07-18T01:03:19.153604  / # export SHELL=3D/bin/sh. /lava-1237042/e=
nvironment
    2023-07-18T01:03:19.153951  =

    2023-07-18T01:03:19.254703  / # . /lava-1237042/environment/lava-123704=
2/bin/lava-test-runner /lava-1237042/1
    2023-07-18T01:03:19.255633  =

    2023-07-18T01:03:19.259562  / # /lava-1237042/bin/lava-test-runner /lav=
a-1237042/1
    2023-07-18T01:03:19.280783  + export 'TESTRUN_[   10.411310] <LAVA_SIGN=
AL_STARTRUN 1_bootrr 1237042_1.5.2.4.5> =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e4f365e67f85518acec9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e4f365e67f85518acecc
        failing since 136 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-07-18T01:03:36.902561  [   10.313581] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1237043_1.5.2.4.1>
    2023-07-18T01:03:37.007904  =

    2023-07-18T01:03:37.109090  / # #export SHELL=3D/bin/sh
    2023-07-18T01:03:37.109521  =

    2023-07-18T01:03:37.210490  / # export SHELL=3D/bin/sh. /lava-1237043/e=
nvironment
    2023-07-18T01:03:37.210918  =

    2023-07-18T01:03:37.311915  / # . /lava-1237043/environment/lava-123704=
3/bin/lava-test-runner /lava-1237043/1
    2023-07-18T01:03:37.312631  =

    2023-07-18T01:03:37.316557  / # /lava-1237043/bin/lava-test-runner /lav=
a-1237043/1
    2023-07-18T01:03:37.329815  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e40ecb13151fb68ace34

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e40ecb13151fb68ace39
        failing since 111 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-07-18T00:59:50.287948  + set +x

    2023-07-18T00:59:50.295051  <8>[   10.901076] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11104816_1.4.2.3.1>

    2023-07-18T00:59:50.401582  / # #

    2023-07-18T00:59:50.503231  export SHELL=3D/bin/sh

    2023-07-18T00:59:50.504163  #

    2023-07-18T00:59:50.605605  / # export SHELL=3D/bin/sh. /lava-11104816/=
environment

    2023-07-18T00:59:50.605945  =


    2023-07-18T00:59:50.706750  / # . /lava-11104816/environment/lava-11104=
816/bin/lava-test-runner /lava-11104816/1

    2023-07-18T00:59:50.707086  =


    2023-07-18T00:59:50.712143  / # /lava-11104816/bin/lava-test-runner /la=
va-11104816/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e48dc6cdcf8e378ace28

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e48dc6cdcf8e378ace2d
        failing since 111 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-07-18T01:01:47.740316  <8>[   12.737873] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11104832_1.4.2.3.1>

    2023-07-18T01:01:47.745427  + set +x

    2023-07-18T01:01:47.852342  =


    2023-07-18T01:01:47.954051  / # #export SHELL=3D/bin/sh

    2023-07-18T01:01:47.954908  =


    2023-07-18T01:01:48.056790  / # export SHELL=3D/bin/sh. /lava-11104832/=
environment

    2023-07-18T01:01:48.057580  =


    2023-07-18T01:01:48.159316  / # . /lava-11104832/environment/lava-11104=
832/bin/lava-test-runner /lava-11104832/1

    2023-07-18T01:01:48.160695  =


    2023-07-18T01:01:48.165732  / # /lava-11104832/bin/lava-test-runner /la=
va-11104832/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e50e32ae48193e8ace1c

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e50f32ae48193e8ace56
        new failure (last pass: v5.10.186-221-gf178eace6e074)

    2023-07-18T01:03:49.668518  / # #
    2023-07-18T01:03:49.771315  export SHELL=3D/bin/sh
    2023-07-18T01:03:49.772121  #
    2023-07-18T01:03:49.873996  / # export SHELL=3D/bin/sh. /lava-1506/envi=
ronment
    2023-07-18T01:03:49.874767  =

    2023-07-18T01:03:49.976732  / # . /lava-1506/environment/lava-1506/bin/=
lava-test-runner /lava-1506/1
    2023-07-18T01:03:49.977982  =

    2023-07-18T01:03:49.992747  / # /lava-1506/bin/lava-test-runner /lava-1=
506/1
    2023-07-18T01:03:50.051593  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-18T01:03:50.052079  + cd /lava-1506/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905d-p230         | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e5af86de2d965e8ace1d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl=
-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl=
-s905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b5e5af86de2d965e8ac=
e1e
        new failure (last pass: v5.10.186-221-gf178eace6e074) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e5769401d950ed8ace4e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e5769401d950ed8ace51
        new failure (last pass: v5.10.186-221-gf178eace6e074)

    2023-07-18T01:05:34.338809  + set +x
    2023-07-18T01:05:34.338929  <8>[   83.715579] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 987067_1.5.2.4.1>
    2023-07-18T01:05:34.445358  / # #
    2023-07-18T01:05:35.904254  export SHELL=3D/bin/sh
    2023-07-18T01:05:35.924681  #
    2023-07-18T01:05:35.924847  / # export SHELL=3D/bin/sh
    2023-07-18T01:05:37.806363  / # . /lava-987067/environment
    2023-07-18T01:05:41.257815  /lava-987067/bin/lava-test-runner /lava-987=
067/1
    2023-07-18T01:05:41.278554  . /lava-987067/environment
    2023-07-18T01:05:41.278665  / # /lava-987067/bin/lava-test-runner /lava=
-987067/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e6de3f6d8eadbe8ace30

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e6de3f6d8eadbe8ace33
        new failure (last pass: v5.10.186-221-gf178eace6e074)

    2023-07-18T01:11:47.063012  + set +x
    2023-07-18T01:11:47.063231  <8>[   83.963194] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 987069_1.5.2.4.1>
    2023-07-18T01:11:47.169207  / # #
    2023-07-18T01:11:48.632117  export SHELL=3D/bin/sh
    2023-07-18T01:11:48.652774  #
    2023-07-18T01:11:48.652984  / # export SHELL=3D/bin/sh
    2023-07-18T01:11:50.539277  / # . /lava-987069/environment
    2023-07-18T01:11:53.997148  /lava-987069/bin/lava-test-runner /lava-987=
069/1
    2023-07-18T01:11:54.017911  . /lava-987069/environment
    2023-07-18T01:11:54.018020  / # /lava-987069/bin/lava-test-runner /lava=
-987069/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e5128a046a23918ace37

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e5128a046a23918ace3a
        new failure (last pass: v5.10.186-221-gf178eace6e074)

    2023-07-18T01:03:49.223749  / # #
    2023-07-18T01:03:50.682653  export SHELL=3D/bin/sh
    2023-07-18T01:03:50.703229  #
    2023-07-18T01:03:50.703437  / # export SHELL=3D/bin/sh
    2023-07-18T01:03:52.588564  / # . /lava-987060/environment
    2023-07-18T01:03:56.045280  /lava-987060/bin/lava-test-runner /lava-987=
060/1
    2023-07-18T01:03:56.066068  . /lava-987060/environment
    2023-07-18T01:03:56.066179  / # /lava-987060/bin/lava-test-runner /lava=
-987060/1
    2023-07-18T01:03:56.145496  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-18T01:03:56.145715  + cd /lava-987060/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e5ee743a2c3a6a8ace85

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e5ee743a2c3a6a8ace88
        new failure (last pass: v5.10.186-221-gf178eace6e074)

    2023-07-18T01:07:35.898654  / # #
    2023-07-18T01:07:37.359277  export SHELL=3D/bin/sh
    2023-07-18T01:07:37.379828  #
    2023-07-18T01:07:37.380036  / # export SHELL=3D/bin/sh
    2023-07-18T01:07:39.265220  / # . /lava-987070/environment
    2023-07-18T01:07:42.721856  /lava-987070/bin/lava-test-runner /lava-987=
070/1
    2023-07-18T01:07:42.742644  . /lava-987070/environment
    2023-07-18T01:07:42.742755  / # /lava-987070/bin/lava-test-runner /lava=
-987070/1
    2023-07-18T01:07:42.821975  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-18T01:07:42.822192  + cd /lava-987070/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e4c23b8b4f82b08ace6f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e4c23b8b4f82b08ace74
        new failure (last pass: v5.10.186-221-gf178eace6e074)

    2023-07-18T01:04:17.588840  / # #

    2023-07-18T01:04:17.691007  export SHELL=3D/bin/sh

    2023-07-18T01:04:17.691709  #

    2023-07-18T01:04:17.793101  / # export SHELL=3D/bin/sh. /lava-11104903/=
environment

    2023-07-18T01:04:17.793831  =


    2023-07-18T01:04:17.895292  / # . /lava-11104903/environment/lava-11104=
903/bin/lava-test-runner /lava-11104903/1

    2023-07-18T01:04:17.896374  =


    2023-07-18T01:04:17.913057  / # /lava-11104903/bin/lava-test-runner /la=
va-11104903/1

    2023-07-18T01:04:17.962034  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-18T01:04:17.962533  + cd /lav<8>[   16.410578] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11104903_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e456fceb981fa28ace37

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e456fceb981fa28ace3c
        failing since 80 days (last pass: v5.10.147, first fail: v5.10.176-=
373-g8415c0f9308b)

    2023-07-18T01:00:57.603514  [   16.006175] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3721923_1.5.2.4.1>
    2023-07-18T01:00:57.708130  =

    2023-07-18T01:00:57.708413  / # #[   16.066022] rockchip-drm display-su=
bsystem: [drm] Cannot find any crtc or sizes
    2023-07-18T01:00:57.809982  export SHELL=3D/bin/sh
    2023-07-18T01:00:57.810470  =

    2023-07-18T01:00:57.911950  / # export SHELL=3D/bin/sh. /lava-3721923/e=
nvironment
    2023-07-18T01:00:57.912450  =

    2023-07-18T01:00:58.013856  / # . /lava-3721923/environment/lava-372192=
3/bin/lava-test-runner /lava-3721923/1
    2023-07-18T01:00:58.014670  =

    2023-07-18T01:00:58.017856  / # /lava-3721923/bin/lava-test-runner /lav=
a-3721923/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e532ff8a94d8a48ace33

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e532ff8a94d8a48ace38
        failing since 164 days (last pass: v5.10.147, first fail: v5.10.166=
-10-g6278b8c9832e)

    2023-07-18T01:04:26.135345  <8>[  222.256295] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3721910_1.5.2.4.1>
    2023-07-18T01:04:26.241407  / # #
    2023-07-18T01:04:26.343707  export SHELL=3D/bin/sh
    2023-07-18T01:04:26.344445  #
    2023-07-18T01:04:26.446342  / # export SHELL=3D/bin/sh. /lava-3721910/e=
nvironment
    2023-07-18T01:04:26.446730  =

    2023-07-18T01:04:26.548128  / # . /lava-3721910/environment/lava-372191=
0/bin/lava-test-runner /lava-3721910/1
    2023-07-18T01:04:26.548762  =

    2023-07-18T01:04:26.552487  / # /lava-3721910/bin/lava-test-runner /lav=
a-3721910/1
    2023-07-18T01:04:26.619403  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e4bf5946408bcd8ace3f

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e4bf5946408bcd8ace6b
        failing since 168 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-07-18T01:02:33.084683  + set +x
    2023-07-18T01:02:33.088796  <8>[   17.154537] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3721947_1.5.2.4.1>
    2023-07-18T01:02:33.208793  / # #
    2023-07-18T01:02:33.314252  export SHELL=3D/bin/sh
    2023-07-18T01:02:33.315801  #
    2023-07-18T01:02:33.419169  / # export SHELL=3D/bin/sh. /lava-3721947/e=
nvironment
    2023-07-18T01:02:33.420744  =

    2023-07-18T01:02:33.524161  / # . /lava-3721947/environment/lava-372194=
7/bin/lava-test-runner /lava-3721947/1
    2023-07-18T01:02:33.526814  =

    2023-07-18T01:02:33.530098  / # /lava-3721947/bin/lava-test-runner /lav=
a-3721947/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e4834ca50c0e4d8acf54

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e4834ca50c0e4d8acf80
        failing since 168 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-07-18T01:01:33.752317  <8>[   17.055945] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1512_1.5.2.4.1>
    2023-07-18T01:01:33.863588  / # #
    2023-07-18T01:01:33.966146  export SHELL=3D/bin/sh
    2023-07-18T01:01:33.967245  #
    2023-07-18T01:01:34.069579  / # export SHELL=3D/bin/sh. /lava-1512/envi=
ronment
    2023-07-18T01:01:34.069986  =

    2023-07-18T01:01:34.171792  / # . /lava-1512/environment/lava-1512/bin/=
lava-test-runner /lava-1512/1
    2023-07-18T01:01:34.172714  =

    2023-07-18T01:01:34.176609  / # /lava-1512/bin/lava-test-runner /lava-1=
512/1
    2023-07-18T01:01:34.221954  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e47e711f8cd60b8ace28

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e47e711f8cd60b8ace2d
        new failure (last pass: v5.10.186-221-gf178eace6e074)

    2023-07-18T01:01:29.515456  / # #
    2023-07-18T01:01:29.617114  export SHELL=3D/bin/sh
    2023-07-18T01:01:29.617461  #
    2023-07-18T01:01:29.718763  / # export SHELL=3D/bin/sh. /lava-3721936/e=
nvironment
    2023-07-18T01:01:29.719115  =

    2023-07-18T01:01:29.820454  / # . /lava-3721936/environment/lava-372193=
6/bin/lava-test-runner /lava-3721936/1
    2023-07-18T01:01:29.821058  =

    2023-07-18T01:01:29.826907  / # /lava-3721936/bin/lava-test-runner /lav=
a-3721936/1
    2023-07-18T01:01:29.892827  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-18T01:01:29.893360  + cd /lava-3721936<8>[   17.630975] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 3721936_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b5e4863b8b4f82b08ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-332-gf98a4d3a5cec/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b5e4863b8b4f82b08ace21
        new failure (last pass: v5.10.186-221-gf178eace6e074)

    2023-07-18T01:03:24.541476  / # #

    2023-07-18T01:03:24.643542  export SHELL=3D/bin/sh

    2023-07-18T01:03:24.644160  #

    2023-07-18T01:03:24.745327  / # export SHELL=3D/bin/sh. /lava-11104894/=
environment

    2023-07-18T01:03:24.745996  =


    2023-07-18T01:03:24.847131  / # . /lava-11104894/environment/lava-11104=
894/bin/lava-test-runner /lava-11104894/1

    2023-07-18T01:03:24.848104  =


    2023-07-18T01:03:24.893201  / # /lava-11104894/bin/lava-test-runner /la=
va-11104894/1

    2023-07-18T01:03:24.920703  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-18T01:03:24.920785  + cd /lava-1110489<8>[   18.182853] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11104894_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

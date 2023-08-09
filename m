Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5433D7764CA
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjHIQP3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 12:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHIQP2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 12:15:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5AEED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 09:15:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bbf8cb694aso262005ad.3
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691597725; x=1692202525;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nagBxPvhc6xujX0We9laBwHEhR0wtT/ewwC5IZYokoQ=;
        b=s9jqSSXujnnn4rJ8RxaIFVS68jy4RBRKWwi86X8dh6Ts67fcqcZHXia8XPpQItdHE9
         AbKRBbT6BOyt2SodfNqTqj/f6lWF708u0O9oz/xRn1K6JRYfCXFnfGS9wV1GShuenzUW
         Oo15aX6y2XIMwh6b8rRXB4BJDWb9QPuoJdoNQT0xoRCyKi3Ah3sRU2Tyjlo19QYYy8TZ
         7+MxpTV+pXzlzfKCGQ3ztGZFFDpG3iOWCz8tO6eASMU2ejhqZvlfVSNE0XRCNriPV5GH
         pXK/qNTQYNR0+o3j/DuCOWz8saENVSoOIHYuMetkuFOmDg2Fp83MDoAr/SDF1XHxNoLQ
         Bo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691597725; x=1692202525;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nagBxPvhc6xujX0We9laBwHEhR0wtT/ewwC5IZYokoQ=;
        b=RRbfp0BlOHKCyBevYBkq5nlv/+muWxRoZ73S847Zyj6sUKd5T3vQks7wM3stlVqL+z
         kwnJL4J6Xl6ijnTaKZe2clHp84V9g/H2pk4Q/yvkFQcCnAvj/ghsPCQTLZDeLHt0mbRn
         0O4hySU9N9iitu6mJqMfK3WJkkOuzRoWy+71djOGHtkKHsoXwanit9JGCL9NgNhB5T4A
         S8BEF871RwD8N7ugTuj7m7X51dHNcVE+sxMv7Qjsr6ayVbLtOi6LC5EWI3zhMSawUhwD
         riciMbZbyPVgc0dT1J5UN8ihV20fPmTdzq+QR25L90LzyjEBz94lit5Pj1VCROGOmSAt
         oKpQ==
X-Gm-Message-State: AOJu0YykWMEloCi+O6nFz+a1IxwbJcZ6J8Jv07Qswi9Wp+j4zpJOpWN7
        2bkkvtjVDPbymnhTxaPSZ/i52YKoHiKUfie5PoF3xg==
X-Google-Smtp-Source: AGHT+IFjPfXfoA/Ao401kSIvzZdrZehBnV/hCGy8zWoMScrJOxknCAIq1LNsleBaqtEVvKMHPnAnTg==
X-Received: by 2002:a17:902:e5c8:b0:1b7:e355:d1ea with SMTP id u8-20020a170902e5c800b001b7e355d1eamr4012931plf.24.1691597724524;
        Wed, 09 Aug 2023 09:15:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902b10900b001b8622c1ad2sm11332866plr.130.2023.08.09.09.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:15:23 -0700 (PDT)
Message-ID: <64d3bb9b.170a0220.e3f9b.4ae1@mx.google.com>
Date:   Wed, 09 Aug 2023 09:15:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.189-202-g0195dc1d1da1c
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 116 runs,
 12 regressions (v5.10.189-202-g0195dc1d1da1c)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 116 runs, 12 regressions (v5.10.189-202-g0=
195dc1d1da1c)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-R721T-grunt             | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.189-202-g0195dc1d1da1c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.189-202-g0195dc1d1da1c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      0195dc1d1da1c3ea5afb2a07e66d1446ae278243 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-R721T-grunt             | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d388539ddb16c6c535b20f

  Results:     17 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-acer-R721T-grunt.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-acer-R721T-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/64d388539ddb16c=
6c535b222
        new failure (last pass: v5.10.189-202-gb9dd551c546f)
        1 lines

    2023-08-09T12:36:30.915558  kern  :emerg : __common_interrupt: 1.55 No =
irq handler for vector

    2023-08-09T12:36:30.925325  <8>[   10.695242] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38974b82710ccda35b264

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38974b82710ccda35b269
        failing since 203 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-09T12:41:00.089816  <8>[   11.098801] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3735332_1.5.2.4.1>
    2023-08-09T12:41:00.199906  / # #
    2023-08-09T12:41:00.303323  export SHELL=3D/bin/sh
    2023-08-09T12:41:00.304413  #
    2023-08-09T12:41:00.406882  / # export SHELL=3D/bin/sh. /lava-3735332/e=
nvironment
    2023-08-09T12:41:00.408010  =

    2023-08-09T12:41:00.408569  / # <3>[   11.372687] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-08-09T12:41:00.510910  . /lava-3735332/environment/lava-3735332/bi=
n/lava-test-runner /lava-3735332/1
    2023-08-09T12:41:00.512632  =

    2023-08-09T12:41:00.517817  / # /lava-3735332/bin/lava-test-runner /lav=
a-3735332/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38a75f0a3b7a97435b21f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38a76f0a3b7a97435b222
        failing since 22 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-09T12:45:23.269225  [   13.809958] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242150_1.5.2.4.1>
    2023-08-09T12:45:23.375156  =

    2023-08-09T12:45:23.476405  / # #export SHELL=3D/bin/sh
    2023-08-09T12:45:23.476817  =

    2023-08-09T12:45:23.577829  / # export SHELL=3D/bin/sh. /lava-1242150/e=
nvironment
    2023-08-09T12:45:23.578270  =

    2023-08-09T12:45:23.679264  / # . /lava-1242150/environment/lava-124215=
0/bin/lava-test-runner /lava-1242150/1
    2023-08-09T12:45:23.680100  =

    2023-08-09T12:45:23.684055  / # /lava-1242150/bin/lava-test-runner /lav=
a-1242150/1
    2023-08-09T12:45:23.701319  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38a62f0a3b7a97435b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38a62f0a3b7a97435b1dd
        failing since 158 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-09T12:44:59.470622  [   15.905051] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242149_1.5.2.4.1>
    2023-08-09T12:44:59.576627  =

    2023-08-09T12:44:59.677962  / # #export SHELL=3D/bin/sh
    2023-08-09T12:44:59.678423  =

    2023-08-09T12:44:59.779482  / # export SHELL=3D/bin/sh. /lava-1242149/e=
nvironment
    2023-08-09T12:44:59.779934  =

    2023-08-09T12:44:59.880971  / # . /lava-1242149/environment/lava-124214=
9/bin/lava-test-runner /lava-1242149/1
    2023-08-09T12:44:59.881827  =

    2023-08-09T12:44:59.885664  / # /lava-1242149/bin/lava-test-runner /lav=
a-1242149/1
    2023-08-09T12:44:59.900589  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d3884166c16d7d5135b25d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d3884166c16d7d5135b262
        failing since 133 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-09T12:36:05.880587  + <8>[   10.169991] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11245063_1.4.2.3.1>

    2023-08-09T12:36:05.880663  set +x

    2023-08-09T12:36:05.982002  #

    2023-08-09T12:36:06.084577  / # #export SHELL=3D/bin/sh

    2023-08-09T12:36:06.085401  =


    2023-08-09T12:36:06.186909  / # export SHELL=3D/bin/sh. /lava-11245063/=
environment

    2023-08-09T12:36:06.187741  =


    2023-08-09T12:36:06.289407  / # . /lava-11245063/environment/lava-11245=
063/bin/lava-test-runner /lava-11245063/1

    2023-08-09T12:36:06.290544  =


    2023-08-09T12:36:06.295777  / # /lava-11245063/bin/lava-test-runner /la=
va-11245063/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d3886776e11b492f35b1ef

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d3886776e11b492f35b1f4
        failing since 133 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-09T12:36:43.331344  <8>[   11.418870] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11245087_1.4.2.3.1>

    2023-08-09T12:36:43.334483  + set +x

    2023-08-09T12:36:43.435784  #

    2023-08-09T12:36:43.436112  =


    2023-08-09T12:36:43.536688  / # #export SHELL=3D/bin/sh

    2023-08-09T12:36:43.536905  =


    2023-08-09T12:36:43.637466  / # export SHELL=3D/bin/sh. /lava-11245087/=
environment

    2023-08-09T12:36:43.637697  =


    2023-08-09T12:36:43.738247  / # . /lava-11245087/environment/lava-11245=
087/bin/lava-test-runner /lava-11245087/1

    2023-08-09T12:36:43.738577  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d3ba5bb3d17b299735b1d9

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d3ba5bb3d17b299735b215
        failing since 0 day (last pass: v5.10.189-186-g6bbe4c818f99, first =
fail: v5.10.189-202-gb9dd551c546f)

    2023-08-09T16:09:36.167771  / # #
    2023-08-09T16:09:36.270837  export SHELL=3D/bin/sh
    2023-08-09T16:09:36.271633  #
    2023-08-09T16:09:36.373620  / # export SHELL=3D/bin/sh. /lava-41420/env=
ironment
    2023-08-09T16:09:36.374412  =

    2023-08-09T16:09:36.476465  / # . /lava-41420/environment/lava-41420/bi=
n/lava-test-runner /lava-41420/1
    2023-08-09T16:09:36.477882  =

    2023-08-09T16:09:36.491935  / # /lava-41420/bin/lava-test-runner /lava-=
41420/1
    2023-08-09T16:09:36.550781  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T16:09:36.551334  + cd /lava-41420/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38af0588efbdbe335b1e8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38af0588efbdbe335b1eb
        failing since 22 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-09T12:47:21.679030  + set +x
    2023-08-09T12:47:21.679604  <8>[   83.690301] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 995061_1.5.2.4.1>
    2023-08-09T12:47:21.788686  / # #
    2023-08-09T12:47:23.259129  export SHELL=3D/bin/sh
    2023-08-09T12:47:23.280401  #
    2023-08-09T12:47:23.280976  / # export SHELL=3D/bin/sh
    2023-08-09T12:47:25.175656  / # . /lava-995061/environment
    2023-08-09T12:47:28.650024  /lava-995061/bin/lava-test-runner /lava-995=
061/1
    2023-08-09T12:47:28.672026  . /lava-995061/environment
    2023-08-09T12:47:28.672463  / # /lava-995061/bin/lava-test-runner /lava=
-995061/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38c466870d59d4735b1e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38c466870d59d4735b1ea
        failing since 22 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-09T12:52:58.939150  + set +x
    2023-08-09T12:52:58.939369  <8>[   84.008765] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 995062_1.5.2.4.1>
    2023-08-09T12:52:59.044966  / # #
    2023-08-09T12:53:00.507898  export SHELL=3D/bin/sh
    2023-08-09T12:53:00.528519  #
    2023-08-09T12:53:00.528730  / # export SHELL=3D/bin/sh
    2023-08-09T12:53:02.414545  / # . /lava-995062/environment
    2023-08-09T12:53:05.875175  /lava-995062/bin/lava-test-runner /lava-995=
062/1
    2023-08-09T12:53:05.895966  . /lava-995062/environment
    2023-08-09T12:53:05.896077  / # /lava-995062/bin/lava-test-runner /lava=
-995062/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38ae59597a0a93135b27d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek87=
4.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek87=
4.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38ae59597a0a93135b280
        failing since 22 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-09T12:47:09.652595  / # #
    2023-08-09T12:47:11.112753  export SHELL=3D/bin/sh
    2023-08-09T12:47:11.133191  #
    2023-08-09T12:47:11.133336  / # export SHELL=3D/bin/sh
    2023-08-09T12:47:13.015672  / # . /lava-995044/environment
    2023-08-09T12:47:16.468053  /lava-995044/bin/lava-test-runner /lava-995=
044/1
    2023-08-09T12:47:16.488645  . /lava-995044/environment
    2023-08-09T12:47:16.488753  / # /lava-995044/bin/lava-test-runner /lava=
-995044/1
    2023-08-09T12:47:16.567358  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T12:47:16.567493  + cd /lava-995044/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38bc0af45c67e9d35b1f9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38bc0af45c67e9d35b1fc
        failing since 22 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-09T12:50:59.456789  / # #
    2023-08-09T12:51:00.916358  export SHELL=3D/bin/sh
    2023-08-09T12:51:00.936794  #
    2023-08-09T12:51:00.936969  / # export SHELL=3D/bin/sh
    2023-08-09T12:51:02.818179  / # . /lava-995058/environment
    2023-08-09T12:51:06.268222  /lava-995058/bin/lava-test-runner /lava-995=
058/1
    2023-08-09T12:51:06.288886  . /lava-995058/environment
    2023-08-09T12:51:06.289023  / # /lava-995058/bin/lava-test-runner /lava=
-995058/1
    2023-08-09T12:51:06.369139  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T12:51:06.369339  + cd /lava-995058/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d38f37e8666afa9435b1e0

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796=
0-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
89-202-g0195dc1d1da1c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796=
0-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d38f37e8666afa9435b1e5
        failing since 22 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-09T13:07:16.637379  / # #

    2023-08-09T13:07:16.739529  export SHELL=3D/bin/sh

    2023-08-09T13:07:16.740270  #

    2023-08-09T13:07:16.841779  / # export SHELL=3D/bin/sh. /lava-11245127/=
environment

    2023-08-09T13:07:16.842437  =


    2023-08-09T13:07:16.943829  / # . /lava-11245127/environment/lava-11245=
127/bin/lava-test-runner /lava-11245127/1

    2023-08-09T13:07:16.944997  =


    2023-08-09T13:07:16.961309  / # /lava-11245127/bin/lava-test-runner /la=
va-11245127/1

    2023-08-09T13:07:17.010276  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T13:07:17.010794  + cd /lav<8>[   16.408000] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11245127_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =20

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E45970EA35
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 02:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjEXA0j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 20:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjEXA0i (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 20:26:38 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DA6B5
        for <stable@vger.kernel.org>; Tue, 23 May 2023 17:26:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d3fdcadb8so110677b3a.3
        for <stable@vger.kernel.org>; Tue, 23 May 2023 17:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684887996; x=1687479996;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3jmvJ7g+p53JH2w4YK5c3/m/iUBtmSUVoGQd3KQKNi0=;
        b=gdlMuNfaFZ8OtwgBqDEyrwFewJPTLb6xEEa7n6LuuvRf1oWneZtJ8mYiZsq7DcWjp3
         VYw42bhbwRmdfu0XG19Wvy5Pv2VL9wnabN+L5un43qFcIkkg5LIAvCSHf/98M4fzV/h9
         bFFTFw1BtnfOISKcAOEcFSR7sh+86iz0Td+Q4qFnIW1UI8FaZetP50nJlod5qZVfpJNm
         8Ve5s2f55nfMqyaSiAVYfYtlyO46saXT65tDuuB2p1s2+X+oy6TIwdxXLudaTJUAY3cT
         bavvTgnOT0ps8n49VifE38a93/iGpTHXCrPNcSeyzDxxbR4cyFi3TmbOd3pE+vJbaeWr
         3DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684887996; x=1687479996;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jmvJ7g+p53JH2w4YK5c3/m/iUBtmSUVoGQd3KQKNi0=;
        b=UDcGQVHIXUdSmSGM5iQxNrckNvKmBRKyG3bcvyhlKlABs/KvLJtG8412e2mypJJ+o2
         CiLbk4t8gngo4j9TM1IRYqHyB/3E9xVaDFhRSxOsncv/mR0/v6gl+R+/R+eGsibHQUSd
         ops6GjyfQO7bcXy4CAOW/ofdq4RFVHfkPTGErnuUs+PK7LXfKn5b8WhvAR9z9SzjSDuW
         dvyJqXhMubKKKt4X6m6zjDdlIWG/KQjr59yfl8UX+WdwuEj2uAufE97RaI9lGArXtyhh
         qmSXP+0WRQpwn4Mb6JRu/vAIelqe9byIcPCCEjrEhsvWsskPvsuMFxydeMrWaxK9K/rc
         XYAA==
X-Gm-Message-State: AC+VfDwHbL7VI7f1kgmbiyMFRk32gsizY//yfrSDC+Eb8PoW9+S0nbD1
        NA9/Y3rNBQ5wFK/oP2oCc4/jZ2DjLhIHOsaUDb6UCg==
X-Google-Smtp-Source: ACHHUZ6SmZYW0MpwZ5de/kOE7aNiy7HsIIu20t2Z+8L6lM9+qLtzgNzEQZ8AJsuqJdnr36fHwRqEnQ==
X-Received: by 2002:a05:6a00:15cf:b0:638:edbc:74ca with SMTP id o15-20020a056a0015cf00b00638edbc74camr1271837pfu.0.1684887995593;
        Tue, 23 May 2023 17:26:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f22-20020aa782d6000000b0062bc045bf4fsm6510805pfn.19.2023.05.23.17.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:26:34 -0700 (PDT)
Message-ID: <646d59ba.a70a0220.55484.c852@mx.google.com>
Date:   Tue, 23 May 2023 17:26:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-153-gcfb9b5bef849
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 126 runs,
 6 regressions (v5.10.180-153-gcfb9b5bef849)
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

stable-rc/queue/5.10 baseline: 126 runs, 6 regressions (v5.10.180-153-gcfb9=
b5bef849)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.180-153-gcfb9b5bef849/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.180-153-gcfb9b5bef849
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      cfb9b5bef8492873f533c05ae08580169dd60ffd =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646d23b0a097d165a82e85e6

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-gcfb9b5bef849/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-gcfb9b5bef849/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d23b0a097d165a82e861b
        failing since 98 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-23T20:35:41.262120  <8>[   20.111787] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 503521_1.5.2.4.1>
    2023-05-23T20:35:41.373519  / # #
    2023-05-23T20:35:41.476528  export SHELL=3D/bin/sh
    2023-05-23T20:35:41.477440  #
    2023-05-23T20:35:41.579493  / # export SHELL=3D/bin/sh. /lava-503521/en=
vironment
    2023-05-23T20:35:41.580371  =

    2023-05-23T20:35:41.682513  / # . /lava-503521/environment/lava-503521/=
bin/lava-test-runner /lava-503521/1
    2023-05-23T20:35:41.683843  =

    2023-05-23T20:35:41.688472  / # /lava-503521/bin/lava-test-runner /lava=
-503521/1
    2023-05-23T20:35:41.791602  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646d220d8d74fb775c2e8604

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-gcfb9b5bef849/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-gcfb9b5bef849/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d220d8d74fb775c2e8609
        failing since 54 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-23T20:28:44.115912  + <8>[   10.277185] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10430211_1.4.2.3.1>

    2023-05-23T20:28:44.116019  set +x

    2023-05-23T20:28:44.217416  #

    2023-05-23T20:28:44.318351  / # #export SHELL=3D/bin/sh

    2023-05-23T20:28:44.318551  =


    2023-05-23T20:28:44.419219  / # export SHELL=3D/bin/sh. /lava-10430211/=
environment

    2023-05-23T20:28:44.419977  =


    2023-05-23T20:28:44.521604  / # . /lava-10430211/environment/lava-10430=
211/bin/lava-test-runner /lava-10430211/1

    2023-05-23T20:28:44.522760  =


    2023-05-23T20:28:44.527624  / # /lava-10430211/bin/lava-test-runner /la=
va-10430211/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646d21ef62495427232e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-gcfb9b5bef849/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-gcfb9b5bef849/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d21ef62495427232e85f8
        failing since 54 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-23T20:28:07.007790  <8>[   12.800245] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10430235_1.4.2.3.1>

    2023-05-23T20:28:07.011029  + set +x

    2023-05-23T20:28:07.115656  / # #

    2023-05-23T20:28:07.217604  export SHELL=3D/bin/sh

    2023-05-23T20:28:07.217761  #

    2023-05-23T20:28:07.318354  / # export SHELL=3D/bin/sh. /lava-10430235/=
environment

    2023-05-23T20:28:07.318587  =


    2023-05-23T20:28:07.419335  / # . /lava-10430235/environment/lava-10430=
235/bin/lava-test-runner /lava-10430235/1

    2023-05-23T20:28:07.420384  =


    2023-05-23T20:28:07.425564  / # /lava-10430235/bin/lava-test-runner /la=
va-10430235/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/646d25c05073e7cb7d2e85f9

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-gcfb9b5bef849/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-gcfb9b5bef849/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/646d25c05073e7cb7d2e85ff
        failing since 70 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-23T20:44:29.491680  /lava-10430301/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/646d25c05073e7cb7d2e8600
        failing since 70 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-23T20:44:27.427705  <8>[   31.415580] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-23T20:44:28.453591  /lava-10430301/1/../bin/lava-test-case

    2023-05-23T20:44:28.464672  <8>[   32.453304] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646d2653bcaafc90682e8608

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-gcfb9b5bef849/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.180=
-153-gcfb9b5bef849/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646d2653bcaafc90682e860d
        failing since 111 days (last pass: v5.10.165-139-gefb57ce0f880, fir=
st fail: v5.10.165-149-ge30e8271d674)

    2023-05-23T20:46:56.446405  / # #
    2023-05-23T20:46:56.548358  export SHELL=3D/bin/sh
    2023-05-23T20:46:56.548914  #
    2023-05-23T20:46:56.650274  / # export SHELL=3D/bin/sh. /lava-3612458/e=
nvironment
    2023-05-23T20:46:56.650815  =

    2023-05-23T20:46:56.752269  / # . /lava-3612458/environment/lava-361245=
8/bin/lava-test-runner /lava-3612458/1
    2023-05-23T20:46:56.753089  =

    2023-05-23T20:46:56.757069  / # /lava-3612458/bin/lava-test-runner /lav=
a-3612458/1
    2023-05-23T20:46:56.877084  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-23T20:46:56.877479  + cd /lava-3612458/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

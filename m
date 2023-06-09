Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A375F729C88
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 16:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbjFIOQ2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 10:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjFIOQ1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 10:16:27 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B7630E8
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 07:16:22 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so772465a12.1
        for <stable@vger.kernel.org>; Fri, 09 Jun 2023 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686320182; x=1688912182;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s4xKIIrMr7k+zaFmGb9ooymlP9zMR5GgVpGFy9qYOAE=;
        b=QzGpZjifZbLmxkNPYk3rUuo3NqTV2tyDUDnWCs9b6dExLfl5PJnAmekLuVU1ZeANkX
         H2vQhcmBe1/oaLUreDztKOtN5ao9olbJeF1Qo5qaBbj/RwpnCLgQmeJeGjZezqQ28rpn
         LJRgcgVKEnVGOfkHEUNTUNFsy8YMSGEp4XVGn5YlNxkXHSYnBxIXM9nm6I7d3jwzurQz
         bJRVS4JcJISCOtS1WcWmzWVzaIIF6n/nli/K4N9x+lakvAX0maaP2pyRHGOps6hCzoOq
         W67GWTkE2f5QZ9m2Tcj+5kAotHkLJm2Ige/snH1b6CJDDYGUvuCJUmhEOwUEiRBfnLuj
         oTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686320182; x=1688912182;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4xKIIrMr7k+zaFmGb9ooymlP9zMR5GgVpGFy9qYOAE=;
        b=UUxMtM43B3fpQqFxvBxsuCxkU1hxPlTjIqxlwKBpnOaW5jfilOWfy2NyXQwHhT1Q+z
         cfyLurCUlADleTXu6ub7ceb63bp8wfYngbv+NfWJbTKib3EKMjeohH016OHUeR5okzjz
         37/jdzFP/AnLh8EzsEB7XALS1yRdAfPMW/q46SgB03O53qSbxZmycOCqucWB2m/owLHN
         oMzaR7BA1qh1Oz3PPjR/4TthEIohITyUu2A2xaq9qvF7ULK0Znql7S0L1LaouYNAM+9w
         DZhZNBVM7FwsLAqxSBQOytHBrOXdLg1JtX5Ma2IuY++OS75Jx8+phbhVsLOOHXq083PR
         3w3Q==
X-Gm-Message-State: AC+VfDzx2AyjTcvqUoH76Q3bye4BbMnX6oK7LgCh21gin1c6BDJMI07z
        teYyfPwfp6dh3xuitxcYBNSGnYDXlSiHPEocMWVz5w==
X-Google-Smtp-Source: ACHHUZ7aj3jzmmuDaD5TLsI9cmlg1iliaLJxZYN44iqT6OmU+T69AhJLN2yndNyWEy7zTc6Uh4jDAg==
X-Received: by 2002:a17:903:10a:b0:1af:e8cf:7004 with SMTP id y10-20020a170903010a00b001afe8cf7004mr1149150plc.15.1686320180601;
        Fri, 09 Jun 2023 07:16:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902b49400b001a980a23804sm3361610plr.4.2023.06.09.07.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:16:19 -0700 (PDT)
Message-ID: <64833433.170a0220.e650a.6adc@mx.google.com>
Date:   Fri, 09 Jun 2023 07:16:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.116
Subject: stable/linux-5.15.y baseline: 191 runs, 22 regressions (v5.15.116)
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

stable/linux-5.15.y baseline: 191 runs, 22 regressions (v5.15.116)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
am57xx-beagle-x15            | arm    | lab-linaro-lkft | gcc-10   | multi_=
v7_defconfig+kselftest | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.116/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.116
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      7349e40704a0209a2af8b37fa876322209de9684 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
am57xx-beagle-x15            | arm    | lab-linaro-lkft | gcc-10   | multi_=
v7_defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64830ae23a56dd4a0c306143

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-linaro-lkft/baseline-am57xx-bea=
gle-x15.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-linaro-lkft/baseline-am57xx-bea=
gle-x15.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64830ae23a56dd4a0c306=
144
        new failure (last pass: v5.15.114) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f8d25cb8a35ff630618b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f8d25cb8a35ff6306190
        failing since 70 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-09T10:02:48.797321  <8>[   21.416278] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10656629_1.4.2.3.1>

    2023-06-09T10:02:48.800490  + set +x

    2023-06-09T10:02:48.901875  =


    2023-06-09T10:02:49.002691  / # #export SHELL=3D/bin/sh

    2023-06-09T10:02:49.003402  =


    2023-06-09T10:02:49.104719  / # export SHELL=3D/bin/sh. /lava-10656629/=
environment

    2023-06-09T10:02:49.105460  =


    2023-06-09T10:02:49.206973  / # . /lava-10656629/environment/lava-10656=
629/bin/lava-test-runner /lava-10656629/1

    2023-06-09T10:02:49.208247  =


    2023-06-09T10:02:49.214336  / # /lava-10656629/bin/lava-test-runner /la=
va-10656629/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6482fb3ebb5d97738f30613d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482fb3ebb5d97738f306142
        failing since 70 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-09T10:13:04.463349  <8>[   10.892841] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10656837_1.4.2.3.1>

    2023-06-09T10:13:04.466270  + set +x

    2023-06-09T10:13:04.570290  / # #

    2023-06-09T10:13:04.670967  export SHELL=3D/bin/sh

    2023-06-09T10:13:04.671204  #

    2023-06-09T10:13:04.771772  / # export SHELL=3D/bin/sh. /lava-10656837/=
environment

    2023-06-09T10:13:04.772045  =


    2023-06-09T10:13:04.872615  / # . /lava-10656837/environment/lava-10656=
837/bin/lava-test-runner /lava-10656837/1

    2023-06-09T10:13:04.872973  =


    2023-06-09T10:13:04.878510  / # /lava-10656837/bin/lava-test-runner /la=
va-10656837/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6482fa2b4561a1a25f306130

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482fa2b4561a1a25f306135
        failing since 70 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-09T10:08:34.375880  + <8>[   11.965674] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10656620_1.4.2.3.1>

    2023-06-09T10:08:34.375964  set +x

    2023-06-09T10:08:34.480624  / # #

    2023-06-09T10:08:34.581338  export SHELL=3D/bin/sh

    2023-06-09T10:08:34.581597  #

    2023-06-09T10:08:34.682152  / # export SHELL=3D/bin/sh. /lava-10656620/=
environment

    2023-06-09T10:08:34.682388  =


    2023-06-09T10:08:34.782991  / # . /lava-10656620/environment/lava-10656=
620/bin/lava-test-runner /lava-10656620/1

    2023-06-09T10:08:34.783339  =


    2023-06-09T10:08:34.788292  / # /lava-10656620/bin/lava-test-runner /la=
va-10656620/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6482fb441c0cd5472530615f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482fb441c0cd54725306164
        failing since 70 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-09T10:13:01.023532  + set<8>[   11.281290] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10656852_1.4.2.3.1>

    2023-06-09T10:13:01.023617   +x

    2023-06-09T10:13:01.127857  / # #

    2023-06-09T10:13:01.228471  export SHELL=3D/bin/sh

    2023-06-09T10:13:01.228667  #

    2023-06-09T10:13:01.329175  / # export SHELL=3D/bin/sh. /lava-10656852/=
environment

    2023-06-09T10:13:01.329333  =


    2023-06-09T10:13:01.429834  / # . /lava-10656852/environment/lava-10656=
852/bin/lava-test-runner /lava-10656852/1

    2023-06-09T10:13:01.430479  =


    2023-06-09T10:13:01.435544  / # /lava-10656852/bin/lava-test-runner /la=
va-10656852/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f8c29d68cc9f68306131

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f8c29d68cc9f68306136
        failing since 70 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-09T10:02:35.370793  <8>[   11.339402] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10656644_1.4.2.3.1>

    2023-06-09T10:02:35.373977  + set +x

    2023-06-09T10:02:35.475390  =


    2023-06-09T10:02:35.575906  / # #export SHELL=3D/bin/sh

    2023-06-09T10:02:35.576107  =


    2023-06-09T10:02:35.676589  / # export SHELL=3D/bin/sh. /lava-10656644/=
environment

    2023-06-09T10:02:35.676767  =


    2023-06-09T10:02:35.777325  / # . /lava-10656644/environment/lava-10656=
644/bin/lava-test-runner /lava-10656644/1

    2023-06-09T10:02:35.777634  =


    2023-06-09T10:02:35.782489  / # /lava-10656644/bin/lava-test-runner /la=
va-10656644/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6482fb33341e3d1103306157

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482fb33341e3d110330615c
        failing since 70 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-09T10:12:48.225870  <8>[   11.075455] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10656830_1.4.2.3.1>

    2023-06-09T10:12:48.229526  + set +x

    2023-06-09T10:12:48.331146  #

    2023-06-09T10:12:48.331502  =


    2023-06-09T10:12:48.432208  / # #export SHELL=3D/bin/sh

    2023-06-09T10:12:48.432433  =


    2023-06-09T10:12:48.532949  / # export SHELL=3D/bin/sh. /lava-10656830/=
environment

    2023-06-09T10:12:48.533166  =


    2023-06-09T10:12:48.633709  / # . /lava-10656830/environment/lava-10656=
830/bin/lava-test-runner /lava-10656830/1

    2023-06-09T10:12:48.634061  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6482fb20bd405cfea0306165

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6482fb21bd405cfea0306=
166
        failing since 64 days (last pass: v5.15.105, first fail: v5.15.106) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6482fe39181a232e1430614e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482fe39181a232e14306153
        failing since 141 days (last pass: v5.15.82, first fail: v5.15.89)

    2023-06-09T10:25:15.181270  <8>[   10.113498] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3652390_1.5.2.4.1>
    2023-06-09T10:25:15.290731  / # #
    2023-06-09T10:25:15.393472  export SHELL=3D/bin/sh
    2023-06-09T10:25:15.394230  #
    2023-06-09T10:25:15.496166  / # export SHELL=3D/bin/sh. /lava-3652390/e=
nvironment
    2023-06-09T10:25:15.497126  =

    2023-06-09T10:25:15.599221  / # . /lava-3652390/environment/lava-365239=
0/bin/lava-test-runner /lava-3652390/1
    2023-06-09T10:25:15.601003  =

    2023-06-09T10:25:15.605970  / # /lava-3652390/bin/lava-test-runner /lav=
a-3652390/1
    2023-06-09T10:25:15.700692  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f94bb7e948cb25306190

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f94bb7e948cb25306195
        failing since 70 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-09T10:05:04.277686  + set +x

    2023-06-09T10:05:04.284198  <8>[   15.777093] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10656612_1.4.2.3.1>

    2023-06-09T10:05:04.391712  / # #

    2023-06-09T10:05:04.494038  export SHELL=3D/bin/sh

    2023-06-09T10:05:04.494823  #

    2023-06-09T10:05:04.596508  / # export SHELL=3D/bin/sh. /lava-10656612/=
environment

    2023-06-09T10:05:04.597349  =


    2023-06-09T10:05:04.699055  / # . /lava-10656612/environment/lava-10656=
612/bin/lava-test-runner /lava-10656612/1

    2023-06-09T10:05:04.700419  =


    2023-06-09T10:05:04.705719  / # /lava-10656612/bin/lava-test-runner /la=
va-10656612/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6482fbdd38a821b9a9306132

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482fbdd38a821b9a9306137
        failing since 70 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-09T10:15:57.532149  + set +x

    2023-06-09T10:15:57.538654  <8>[   10.725343] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10656817_1.4.2.3.1>

    2023-06-09T10:15:57.643078  / # #

    2023-06-09T10:15:57.743747  export SHELL=3D/bin/sh

    2023-06-09T10:15:57.744012  #

    2023-06-09T10:15:57.844556  / # export SHELL=3D/bin/sh. /lava-10656817/=
environment

    2023-06-09T10:15:57.844787  =


    2023-06-09T10:15:57.945358  / # . /lava-10656817/environment/lava-10656=
817/bin/lava-test-runner /lava-10656817/1

    2023-06-09T10:15:57.945669  =


    2023-06-09T10:15:57.950838  / # /lava-10656817/bin/lava-test-runner /la=
va-10656817/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f8e63fb166b4c930613e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f8e63fb166b4c9306143
        failing since 70 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-09T10:03:18.565401  + set +x

    2023-06-09T10:03:18.572219  <8>[   12.030855] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10656630_1.4.2.3.1>

    2023-06-09T10:03:18.682028  / # #

    2023-06-09T10:03:18.784234  export SHELL=3D/bin/sh

    2023-06-09T10:03:18.785143  #

    2023-06-09T10:03:18.886624  / # export SHELL=3D/bin/sh. /lava-10656630/=
environment

    2023-06-09T10:03:18.887523  =


    2023-06-09T10:03:18.989315  / # . /lava-10656630/environment/lava-10656=
630/bin/lava-test-runner /lava-10656630/1

    2023-06-09T10:03:18.990711  =


    2023-06-09T10:03:18.995393  / # /lava-10656630/bin/lava-test-runner /la=
va-10656630/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6482fb21046890c0d230612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482fb21046890c0d2306133
        failing since 70 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-09T10:12:32.474727  + set +x

    2023-06-09T10:12:32.480837  <8>[   10.993939] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10656819_1.4.2.3.1>

    2023-06-09T10:12:32.585196  / # #

    2023-06-09T10:12:32.685882  export SHELL=3D/bin/sh

    2023-06-09T10:12:32.686106  #

    2023-06-09T10:12:32.786641  / # export SHELL=3D/bin/sh. /lava-10656819/=
environment

    2023-06-09T10:12:32.786859  =


    2023-06-09T10:12:32.887433  / # . /lava-10656819/environment/lava-10656=
819/bin/lava-test-runner /lava-10656819/1

    2023-06-09T10:12:32.887773  =


    2023-06-09T10:12:32.892545  / # /lava-10656819/bin/lava-test-runner /la=
va-10656819/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f8d15cb8a35ff6306180

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f8d15cb8a35ff6306185
        failing since 70 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-09T10:02:35.587747  + <8>[   11.967615] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10656622_1.4.2.3.1>

    2023-06-09T10:02:35.588343  set +x

    2023-06-09T10:02:35.695535  / # #

    2023-06-09T10:02:35.797924  export SHELL=3D/bin/sh

    2023-06-09T10:02:35.798646  #

    2023-06-09T10:02:35.900256  / # export SHELL=3D/bin/sh. /lava-10656622/=
environment

    2023-06-09T10:02:35.900597  =


    2023-06-09T10:02:36.001502  / # . /lava-10656622/environment/lava-10656=
622/bin/lava-test-runner /lava-10656622/1

    2023-06-09T10:02:36.002625  =


    2023-06-09T10:02:36.008318  / # /lava-10656622/bin/lava-test-runner /la=
va-10656622/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6482fb42e79729bf87306161

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482fb42e79729bf87306166
        failing since 70 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-09T10:13:00.230274  + <8>[   11.396453] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10656841_1.4.2.3.1>

    2023-06-09T10:13:00.230360  set +x

    2023-06-09T10:13:00.334853  / # #

    2023-06-09T10:13:00.435374  export SHELL=3D/bin/sh

    2023-06-09T10:13:00.435543  #

    2023-06-09T10:13:00.536002  / # export SHELL=3D/bin/sh. /lava-10656841/=
environment

    2023-06-09T10:13:00.536177  =


    2023-06-09T10:13:00.636735  / # . /lava-10656841/environment/lava-10656=
841/bin/lava-test-runner /lava-10656841/1

    2023-06-09T10:13:00.636979  =


    2023-06-09T10:13:00.641870  / # /lava-10656841/bin/lava-test-runner /la=
va-10656841/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6482fd01dac42e5bec30612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482fd01dac42e5bec306133
        failing since 128 days (last pass: v5.15.81, first fail: v5.15.91)

    2023-06-09T10:20:40.964943  + set +x
    2023-06-09T10:20:40.965228  [    9.471478] <LAVA_SIGNAL_ENDRUN 0_dmesg =
972264_1.5.2.3.1>
    2023-06-09T10:20:41.071805  / # #
    2023-06-09T10:20:41.173417  export SHELL=3D/bin/sh
    2023-06-09T10:20:41.173881  #
    2023-06-09T10:20:41.275068  / # export SHELL=3D/bin/sh. /lava-972264/en=
vironment
    2023-06-09T10:20:41.275510  =

    2023-06-09T10:20:41.376711  / # . /lava-972264/environment/lava-972264/=
bin/lava-test-runner /lava-972264/1
    2023-06-09T10:20:41.377365  =

    2023-06-09T10:20:41.379904  / # /lava-972264/bin/lava-test-runner /lava=
-972264/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f9911f34a338ae3061f2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f9911f34a338ae3061f7
        failing since 70 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-09T10:05:56.761803  + <8>[   12.552712] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10656593_1.4.2.3.1>

    2023-06-09T10:05:56.761912  set +x

    2023-06-09T10:05:56.866014  / # #

    2023-06-09T10:05:56.966700  export SHELL=3D/bin/sh

    2023-06-09T10:05:56.966929  #

    2023-06-09T10:05:57.067427  / # export SHELL=3D/bin/sh. /lava-10656593/=
environment

    2023-06-09T10:05:57.067673  =


    2023-06-09T10:05:57.168260  / # . /lava-10656593/environment/lava-10656=
593/bin/lava-test-runner /lava-10656593/1

    2023-06-09T10:05:57.168622  =


    2023-06-09T10:05:57.174037  / # /lava-10656593/bin/lava-test-runner /la=
va-10656593/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6482fb23bd405cfea030616b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482fb23bd405cfea0306170
        failing since 70 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-09T10:12:31.806504  <8>[    9.176653] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10656855_1.4.2.3.1>

    2023-06-09T10:12:31.910669  / # #

    2023-06-09T10:12:32.011283  export SHELL=3D/bin/sh

    2023-06-09T10:12:32.011478  #

    2023-06-09T10:12:32.112007  / # export SHELL=3D/bin/sh. /lava-10656855/=
environment

    2023-06-09T10:12:32.112207  =


    2023-06-09T10:12:32.212759  / # . /lava-10656855/environment/lava-10656=
855/bin/lava-test-runner /lava-10656855/1

    2023-06-09T10:12:32.213061  =


    2023-06-09T10:12:32.217516  / # /lava-10656855/bin/lava-test-runner /la=
va-10656855/1

    2023-06-09T10:12:32.222859  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f92a238aa03e6e306144

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f92a238aa03e6e306149
        failing since 39 days (last pass: v5.15.71, first fail: v5.15.110)

    2023-06-09T10:04:16.943276  [   16.068348] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3652286_1.5.2.4.1>
    2023-06-09T10:04:17.047713  =

    2023-06-09T10:04:17.047924  / # [   16.095393] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-06-09T10:04:17.149311  #export SHELL=3D/bin/sh
    2023-06-09T10:04:17.150202  =

    2023-06-09T10:04:17.251927  / # export SHELL=3D/bin/sh. /lava-3652286/e=
nvironment
    2023-06-09T10:04:17.252839  =

    2023-06-09T10:04:17.354691  / # . /lava-3652286/environment/lava-365228=
6/bin/lava-test-runner /lava-3652286/1
    2023-06-09T10:04:17.355448  =

    2023-06-09T10:04:17.358807  / # /lava-3652286/bin/lava-test-runner /lav=
a-3652286/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648309ffde0d4c3b09306152

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648309ffde0d4c3b0930617f
        failing since 123 days (last pass: v5.15.82, first fail: v5.15.92)

    2023-06-09T11:15:47.750303  + set +x
    2023-06-09T11:15:47.754451  <8>[   16.053715] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3652282_1.5.2.4.1>
    2023-06-09T11:15:47.874658  / # #
    2023-06-09T11:15:47.980213  export SHELL=3D/bin/sh
    2023-06-09T11:15:47.981804  #
    2023-06-09T11:15:48.085165  / # export SHELL=3D/bin/sh. /lava-3652282/e=
nvironment
    2023-06-09T11:15:48.086674  =

    2023-06-09T11:15:48.190135  / # . /lava-3652282/environment/lava-365228=
2/bin/lava-test-runner /lava-3652282/1
    2023-06-09T11:15:48.192868  =

    2023-06-09T11:15:48.196096  / # /lava-3652282/bin/lava-test-runner /lav=
a-3652282/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6482f95cd705168a14306162

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482f95dd705168a1430618f
        failing since 123 days (last pass: v5.15.82, first fail: v5.15.92)

    2023-06-09T10:04:55.162102  + set +x
    2023-06-09T10:04:55.166069  <8>[   16.144074] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 585460_1.5.2.4.1>
    2023-06-09T10:04:55.275727  / # #
    2023-06-09T10:04:55.377264  export SHELL=3D/bin/sh
    2023-06-09T10:04:55.377851  #
    2023-06-09T10:04:55.479646  / # export SHELL=3D/bin/sh. /lava-585460/en=
vironment
    2023-06-09T10:04:55.480212  =

    2023-06-09T10:04:55.582206  / # . /lava-585460/environment/lava-585460/=
bin/lava-test-runner /lava-585460/1
    2023-06-09T10:04:55.583406  =

    2023-06-09T10:04:55.587308  / # /lava-585460/bin/lava-test-runner /lava=
-585460/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6482fc981831bd68db306164

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-r1.=
txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.116/=
arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-r1.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6482fc981831bd68db306169
        failing since 127 days (last pass: v5.15.82, first fail: v5.15.91)

    2023-06-09T10:18:40.290038  / # #
    2023-06-09T10:18:40.396023  export SHELL=3D/bin/sh
    2023-06-09T10:18:40.397532  #
    2023-06-09T10:18:40.500923  / # export SHELL=3D/bin/sh. /lava-3652329/e=
nvironment
    2023-06-09T10:18:40.502583  =

    2023-06-09T10:18:40.606096  / # . /lava-3652329/environment/lava-365232=
9/bin/lava-test-runner /lava-3652329/1
    2023-06-09T10:18:40.609040  =

    2023-06-09T10:18:40.614192  / # /lava-3652329/bin/lava-test-runner /lav=
a-3652329/1
    2023-06-09T10:18:40.726880  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-09T10:18:40.727988  + cd /lava-3652329/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

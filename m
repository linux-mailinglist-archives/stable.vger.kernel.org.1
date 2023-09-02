Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDFD7907FB
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 15:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjIBNAn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 09:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjIBNAn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 09:00:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF3ED
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 06:00:38 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a1af910e0so2219029b3a.2
        for <stable@vger.kernel.org>; Sat, 02 Sep 2023 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693659638; x=1694264438; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSEYOmldjGsYC/ebkoUXO5LgknyB7bpQovXW7XUU03Q=;
        b=KFk4a77n8wtzDf112XSKJXSVPc/zjent6u8kkZpKrTXt7uOVOEc/nWUOUUEpM1kgJe
         uIa7co5LJmD5ZKf7UJ0FwKPKkNhmNAAmZyFI9JMUq8WanQKmEP6h+3nbO3rwdKpGaaun
         Yy3frVdGwYH0FrxtKxUghHXDau8GUxzzYmcHAXIcDAyIZhcXkhfkZ5F1Gl7Ql3fG5YUn
         ALNNWgcE8WM5Dk7/8mdl7hcXJhFnjX+6h4uHWaHtlYtNT2uqcC4tDP5mCAbt7K9XUnaS
         UAoFX7NSfuILOSM6o8kFCglH/T4SEh/j99u/PgL1G7zT90+DwcDzvw5u0M++24O7UZ63
         2Eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693659638; x=1694264438;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSEYOmldjGsYC/ebkoUXO5LgknyB7bpQovXW7XUU03Q=;
        b=fw4NIEBcS5UIir+KeyQi7rkspTkEEQ44PmV/8qNThX20zvfQ2cMeia7M9P9cX4aIb1
         7EbtLCsml37Gqwq5GFTsDw7jiAwq5AT5Ii+yoq85WzCy8qogu0SY3X8luIfzawbuIWHu
         7AGWazYY9Ysv1CFeREcYaGDcZudRjyHWevNzbv1qMJY9ep23MSrK12ER4AHaNnNO+RF5
         GQ+A4oUJxeb6XZacHfb+Xrw4q9InRiEfEEf/g8o8Tnfh5w7svhrrGP+1z7NbALPVOFw0
         r0w5JQvFiPxnOpnwXgAECznss4MH0DRyCA+YslZm4m/PSN7Qjyl8IpOUunXlnyKLpjy1
         zU7g==
X-Gm-Message-State: AOJu0YzPdiNzqoLKCXx7PsEubnoySC9FXD3qq9piiWGeBtJ4unCcLmo2
        g3RPYMyN/BYQkw2TO/EmN8AhgNdgRevzx2pM8Rk=
X-Google-Smtp-Source: AGHT+IH6qq5qWXmyiJqZAFOr7tEjIcQaK3QcKLC5hsodonzazHiAwhQGL5IvDZHI1v1MNQ2E/cpAQw==
X-Received: by 2002:a05:6a00:1a13:b0:68b:f3a4:ff6b with SMTP id g19-20020a056a001a1300b0068bf3a4ff6bmr5548789pfv.9.1693659637350;
        Sat, 02 Sep 2023 06:00:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t11-20020a63b70b000000b00565d82769d1sm4086036pgf.77.2023.09.02.06.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 06:00:36 -0700 (PDT)
Message-ID: <64f331f4.630a0220.20243.7a1b@mx.google.com>
Date:   Sat, 02 Sep 2023 06:00:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.51
Subject: stable-rc/linux-6.1.y baseline: 125 runs, 14 regressions (v6.1.51)
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

stable-rc/linux-6.1.y baseline: 125 runs, 14 regressions (v6.1.51)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 2          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.51/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.51
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c2cbfe5f51227dfe6ef7be013f0d56a32c040faa =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2ff64d2856dc868286d81

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f2ff64d2856dc868286=
d82
        new failure (last pass: v6.1.50-11-g1767553758a66) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2fe7dfcd349f6cc286d6e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2fe7dfcd349f6cc286d77
        failing since 155 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-02T09:20:44.668850  + set +x

    2023-09-02T09:20:44.675531  <8>[   10.034337] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11410192_1.4.2.3.1>

    2023-09-02T09:20:44.779690  / # #

    2023-09-02T09:20:44.880283  export SHELL=3D/bin/sh

    2023-09-02T09:20:44.880456  #

    2023-09-02T09:20:44.980985  / # export SHELL=3D/bin/sh. /lava-11410192/=
environment

    2023-09-02T09:20:44.981197  =


    2023-09-02T09:20:45.081778  / # . /lava-11410192/environment/lava-11410=
192/bin/lava-test-runner /lava-11410192/1

    2023-09-02T09:20:45.082124  =


    2023-09-02T09:20:45.088074  / # /lava-11410192/bin/lava-test-runner /la=
va-11410192/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2fe705c24ebdff8286e0a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2fe705c24ebdff8286e0f
        failing since 155 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-02T09:20:33.241254  + set<8>[   11.330508] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11410159_1.4.2.3.1>

    2023-09-02T09:20:33.241715   +x

    2023-09-02T09:20:33.349284  / # #

    2023-09-02T09:20:33.451822  export SHELL=3D/bin/sh

    2023-09-02T09:20:33.452613  #

    2023-09-02T09:20:33.554307  / # export SHELL=3D/bin/sh. /lava-11410159/=
environment

    2023-09-02T09:20:33.555101  =


    2023-09-02T09:20:33.656804  / # . /lava-11410159/environment/lava-11410=
159/bin/lava-test-runner /lava-11410159/1

    2023-09-02T09:20:33.658212  =


    2023-09-02T09:20:33.663738  / # /lava-11410159/bin/lava-test-runner /la=
va-11410159/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2fe76a14ba9a1ce286db2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2fe76a14ba9a1ce286dbb
        failing since 155 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-02T09:21:42.947240  <8>[   10.720490] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11410188_1.4.2.3.1>

    2023-09-02T09:21:42.950891  + set +x

    2023-09-02T09:21:43.052419  #

    2023-09-02T09:21:43.052815  =


    2023-09-02T09:21:43.153503  / # #export SHELL=3D/bin/sh

    2023-09-02T09:21:43.153799  =


    2023-09-02T09:21:43.254378  / # export SHELL=3D/bin/sh. /lava-11410188/=
environment

    2023-09-02T09:21:43.254649  =


    2023-09-02T09:21:43.355202  / # . /lava-11410188/environment/lava-11410=
188/bin/lava-test-runner /lava-11410188/1

    2023-09-02T09:21:43.355482  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f30225dec96805e2286f12

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f30225dec96805e2286=
f13
        new failure (last pass: v6.1.48-128-g1aa86af84d82) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f301bc72c709f9aa286d78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f301bc72c709f9aa286=
d79
        failing since 86 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2fe695c24ebdff8286dd2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2fe695c24ebdff8286ddb
        failing since 155 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-02T09:20:31.836998  + set +x

    2023-09-02T09:20:31.843625  <8>[   10.704754] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11410165_1.4.2.3.1>

    2023-09-02T09:20:31.947935  / # #

    2023-09-02T09:20:32.048608  export SHELL=3D/bin/sh

    2023-09-02T09:20:32.048841  #

    2023-09-02T09:20:32.149377  / # export SHELL=3D/bin/sh. /lava-11410165/=
environment

    2023-09-02T09:20:32.149575  =


    2023-09-02T09:20:32.250242  / # . /lava-11410165/environment/lava-11410=
165/bin/lava-test-runner /lava-11410165/1

    2023-09-02T09:20:32.250635  =


    2023-09-02T09:20:32.255141  / # /lava-11410165/bin/lava-test-runner /la=
va-11410165/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2fe70b41f3e7bec286d81

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2fe70b41f3e7bec286d8a
        failing since 155 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-02T09:20:33.310970  + set<8>[   11.796151] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11410186_1.4.2.3.1>

    2023-09-02T09:20:33.311542   +x

    2023-09-02T09:20:33.419749  / # #

    2023-09-02T09:20:33.522528  export SHELL=3D/bin/sh

    2023-09-02T09:20:33.523410  #

    2023-09-02T09:20:33.625141  / # export SHELL=3D/bin/sh. /lava-11410186/=
environment

    2023-09-02T09:20:33.625979  =


    2023-09-02T09:20:33.727757  / # . /lava-11410186/environment/lava-11410=
186/bin/lava-test-runner /lava-11410186/1

    2023-09-02T09:20:33.729150  =


    2023-09-02T09:20:33.734096  / # /lava-11410186/bin/lava-test-runner /la=
va-11410186/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/64f30277ffc8f4cf39286def

  Results:     29 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/64f30277f=
fc8f4cf39286dfc
        new failure (last pass: v6.1.50-11-g1767553758a66)

    2023-09-02T09:37:53.138004  /lava-83926/1/../bin/lava-test-case
    2023-09-02T09:37:53.165687  <8>[   25.675271] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sound-card-probed: https://kernelci.org/test/case/id/64=
f30277ffc8f4cf39286dfd
        new failure (last pass: v6.1.50-11-g1767553758a66)

    2023-09-02T09:37:52.088160  /lava-83926/1/../bin/lava-test-case
    2023-09-02T09:37:52.116394  <8>[   24.625249] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f2fe5a52194628b0286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f2fe5a52194628b0286d75
        failing since 155 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-02T09:20:14.895395  <8>[   12.282194] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11410184_1.4.2.3.1>

    2023-09-02T09:20:14.999579  / # #

    2023-09-02T09:20:15.100140  export SHELL=3D/bin/sh

    2023-09-02T09:20:15.100311  #

    2023-09-02T09:20:15.200787  / # export SHELL=3D/bin/sh. /lava-11410184/=
environment

    2023-09-02T09:20:15.200945  =


    2023-09-02T09:20:15.301410  / # . /lava-11410184/environment/lava-11410=
184/bin/lava-test-runner /lava-11410184/1

    2023-09-02T09:20:15.301690  =


    2023-09-02T09:20:15.306345  / # /lava-11410184/bin/lava-test-runner /la=
va-11410184/1

    2023-09-02T09:20:15.312839  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f32dfdc551fda420286d6f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f32dfdc551fda420286d78
        failing since 46 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-02T12:45:01.769245  / # #

    2023-09-02T12:45:01.870190  export SHELL=3D/bin/sh

    2023-09-02T12:45:01.870899  #

    2023-09-02T12:45:01.972257  / # export SHELL=3D/bin/sh. /lava-11410257/=
environment

    2023-09-02T12:45:01.972523  =


    2023-09-02T12:45:02.073380  / # . /lava-11410257/environment/lava-11410=
257/bin/lava-test-runner /lava-11410257/1

    2023-09-02T12:45:02.074520  =


    2023-09-02T12:45:02.078664  / # /lava-11410257/bin/lava-test-runner /la=
va-11410257/1

    2023-09-02T12:45:02.139430  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T12:45:02.139937  + cd /lav<8>[   19.091993] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11410257_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f3008bd680d64f91286dd5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f3008bd680d64f91286dde
        failing since 46 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-02T09:30:43.268932  / # #

    2023-09-02T09:30:44.349105  export SHELL=3D/bin/sh

    2023-09-02T09:30:44.350970  #

    2023-09-02T09:30:45.841507  / # export SHELL=3D/bin/sh. /lava-11410256/=
environment

    2023-09-02T09:30:45.843488  =


    2023-09-02T09:30:48.567696  / # . /lava-11410256/environment/lava-11410=
256/bin/lava-test-runner /lava-11410256/1

    2023-09-02T09:30:48.570204  =


    2023-09-02T09:30:48.575755  / # /lava-11410256/bin/lava-test-runner /la=
va-11410256/1

    2023-09-02T09:30:48.637731  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T09:30:48.638206  + cd /lav<8>[   28.501752] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11410256_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f30084d680d64f91286d8d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.51/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f30084d680d64f91286d96
        failing since 46 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-02T09:30:58.604196  / # #

    2023-09-02T09:30:58.706423  export SHELL=3D/bin/sh

    2023-09-02T09:30:58.707137  #

    2023-09-02T09:30:58.808555  / # export SHELL=3D/bin/sh. /lava-11410259/=
environment

    2023-09-02T09:30:58.809314  =


    2023-09-02T09:30:58.910746  / # . /lava-11410259/environment/lava-11410=
259/bin/lava-test-runner /lava-11410259/1

    2023-09-02T09:30:58.911866  =


    2023-09-02T09:30:58.953489  / # /lava-11410259/bin/lava-test-runner /la=
va-11410259/1

    2023-09-02T09:30:58.995278  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T09:30:58.995785  + cd /lava-11410259/1/tests/1_boot<8>[   17=
.032057] <LAVA_SIGNAL_STARTRUN 1_bootrr 11410259_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3AA78782F
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 20:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbjHXSob (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 14:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243152AbjHXSoX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 14:44:23 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDD019A3
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 11:44:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26d4e1ba2dbso75855a91.1
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 11:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692902659; x=1693507459;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l1OTjjy5lZZcLwOwmgQZhihDei0dEC2Ikmpx8NxzEKg=;
        b=hNcaCe1wn23BNL/uQ1OZERSZp3vGkc8NO3j/50l8sUDLnbNXYlMh79OhKSF+JnFDOI
         0QXXKRun6gdgeiGwcnc4O7RmQw5/soMcEF8u3jQR0g+xOiNzUp1sScRZU/aUI+8PIMnH
         Tjp6GIu/zraWq/Bh/6VAY2K7DHgDCktQuFmTbawbIatHudWJhk28GC8ca6t6xkwgqjXT
         dO9Emi874NUWDYpDxL3l+0gJitz1nfUkkYrlli4O03aRBYP1/c2yEA/Opc/sShsKAFUF
         PTU3j+cZimGhE0wOsiHtFh5KyOONNYpO1RZlcXUV6Z0y0+MSeqJ0utWnBjtMb/6J2Fc4
         TzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692902659; x=1693507459;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1OTjjy5lZZcLwOwmgQZhihDei0dEC2Ikmpx8NxzEKg=;
        b=TNFgTFxMUPoPB4F6b1yaX6niC9zxwnxDnvUc1w3JN8xwtyxX8PXcOf8OKaBeTvlX4l
         1h2OoyaT3xGY4e+cegVwzXFxtoOF1nuwMLUzB9WRbRDOtS5vuw/RkEI57eJVYcNs+RfW
         hpZsatqhxe0UO2I41wz/PTb8RoyUEWfMo0TuVyfv9EY5zRnD+Vo9DqPbIkmFOqhjpKVT
         FIaNRtfLz59q3uKrPnDcUDEj3wWmXNyz5Nh5LxUQBEN732rVlwhQ7QySzQf042QT8w0n
         F15+RpEO7ah8Abo7xuX3fMr8kBg52H73IywlM23v+lqBd9Rmw6QVVYAyEpLQVQHTz5MX
         /NoQ==
X-Gm-Message-State: AOJu0Yyj/ElAXrKGKihRirgyICfmfHe07/c3KHn3PWW+X7YDXrudHqra
        BuJHPCXwAECJvUBFPtJ3g7iUwLEvw+ByC49FhL0=
X-Google-Smtp-Source: AGHT+IGBpD1jFCFsmIkTtufUKqEX4WV/ZuFbQumSV8UeyUodAWIvuVk3IJ0b3o0pRqvCrvcpusxrgA==
X-Received: by 2002:a17:90a:d258:b0:268:5c3b:6f28 with SMTP id o24-20020a17090ad25800b002685c3b6f28mr13072691pjw.19.1692902658876;
        Thu, 24 Aug 2023 11:44:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090a430f00b00263b9e75aecsm53700pjg.41.2023.08.24.11.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:44:18 -0700 (PDT)
Message-ID: <64e7a502.170a0220.c3d32.0355@mx.google.com>
Date:   Thu, 24 Aug 2023 11:44:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.47-16-gc079d0dd788a
Subject: stable-rc/linux-6.1.y baseline: 124 runs,
 12 regressions (v6.1.47-16-gc079d0dd788a)
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

stable-rc/linux-6.1.y baseline: 124 runs, 12 regressions (v6.1.47-16-gc079d=
0dd788a)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
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
el/v6.1.47-16-gc079d0dd788a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.47-16-gc079d0dd788a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c079d0dd788ad4fe887ee6349fe89d23d72f7696 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e770ce2bd442755f286d6d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e770ce2bd442755f286d76
        failing since 147 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-24T15:02:25.973240  + set +x

    2023-08-24T15:02:25.979663  <8>[    8.369985] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11346195_1.4.2.3.1>

    2023-08-24T15:02:26.081447  =


    2023-08-24T15:02:26.181993  / # #export SHELL=3D/bin/sh

    2023-08-24T15:02:26.182179  =


    2023-08-24T15:02:26.282650  / # export SHELL=3D/bin/sh. /lava-11346195/=
environment

    2023-08-24T15:02:26.282861  =


    2023-08-24T15:02:26.383348  / # . /lava-11346195/environment/lava-11346=
195/bin/lava-test-runner /lava-11346195/1

    2023-08-24T15:02:26.383681  =


    2023-08-24T15:02:26.389469  / # /lava-11346195/bin/lava-test-runner /la=
va-11346195/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e770d3e3e4fca4f0286d6e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e770d3e3e4fca4f0286d73
        failing since 147 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-24T15:01:27.238828  + set +x<8>[   11.933452] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11346145_1.4.2.3.1>

    2023-08-24T15:01:27.238949  =


    2023-08-24T15:01:27.343385  / # #

    2023-08-24T15:01:27.444175  export SHELL=3D/bin/sh

    2023-08-24T15:01:27.444393  #

    2023-08-24T15:01:27.544930  / # export SHELL=3D/bin/sh. /lava-11346145/=
environment

    2023-08-24T15:01:27.545122  =


    2023-08-24T15:01:27.645614  / # . /lava-11346145/environment/lava-11346=
145/bin/lava-test-runner /lava-11346145/1

    2023-08-24T15:01:27.645986  =


    2023-08-24T15:01:27.650294  / # /lava-11346145/bin/lava-test-runner /la=
va-11346145/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e7713b1c8a932103286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e7713b1c8a932103286d71
        failing since 147 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-24T15:02:54.393651  <8>[   16.299175] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11346152_1.4.2.3.1>

    2023-08-24T15:02:54.397054  + set +x

    2023-08-24T15:02:54.503315  =


    2023-08-24T15:02:54.605002  / # #export SHELL=3D/bin/sh

    2023-08-24T15:02:54.656112  =


    2023-08-24T15:02:54.656284  / # export SHELL=3D/bin/sh

    2023-08-24T15:02:54.756971  / #. /lava-11346152/environment

    2023-08-24T15:02:54.858446  /lava-11346152/bin/lava-test-runner /lava-1=
1346152/1

    2023-08-24T15:02:54.859754   . /lava-11346152/environment

    2023-08-24T15:02:54.865307  / # /lava-11346152/bin/lava-test-runner /la=
va-11346152/1
 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e7751559692f5e9a286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e7751559692f5e9a286=
d6d
        failing since 77 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e773967649ca13ea286d86

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e773967649ca13ea286d8b
        failing since 147 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-24T15:13:11.541566  + set +x

    2023-08-24T15:13:11.547692  <8>[   10.758608] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11346198_1.4.2.3.1>

    2023-08-24T15:13:11.652356  / # #

    2023-08-24T15:13:11.753011  export SHELL=3D/bin/sh

    2023-08-24T15:13:11.753218  #

    2023-08-24T15:13:11.853752  / # export SHELL=3D/bin/sh. /lava-11346198/=
environment

    2023-08-24T15:13:11.853942  =


    2023-08-24T15:13:11.954444  / # . /lava-11346198/environment/lava-11346=
198/bin/lava-test-runner /lava-11346198/1

    2023-08-24T15:13:11.954771  =


    2023-08-24T15:13:11.959129  / # /lava-11346198/bin/lava-test-runner /la=
va-11346198/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e770d42bd442755f286d94

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e770d42bd442755f286d9d
        failing since 147 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-24T15:01:21.778095  + set<8>[   11.555810] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11346186_1.4.2.3.1>

    2023-08-24T15:01:21.778712   +x

    2023-08-24T15:01:21.890208  / # #

    2023-08-24T15:01:21.992734  export SHELL=3D/bin/sh

    2023-08-24T15:01:21.993528  #

    2023-08-24T15:01:22.095013  / # export SHELL=3D/bin/sh. /lava-11346186/=
environment

    2023-08-24T15:01:22.095216  =


    2023-08-24T15:01:22.195739  / # . /lava-11346186/environment/lava-11346=
186/bin/lava-test-runner /lava-11346186/1

    2023-08-24T15:01:22.196084  =


    2023-08-24T15:01:22.200840  / # /lava-11346186/bin/lava-test-runner /la=
va-11346186/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/64e76fff72be3e6ab5286f2a

  Results:     29 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-imx6q-u=
doo.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-imx6q-u=
doo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/64e76fff7=
2be3e6ab5286f33
        new failure (last pass: v6.1.47)

    2023-08-24T14:57:53.146195  /lava-68134/1/../bin/lava-test-case
    2023-08-24T14:57:53.174009  <8>[   25.937786] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sound-card-probed: https://kernelci.org/test/case/id/64=
e76fff72be3e6ab5286f34
        new failure (last pass: v6.1.47)

    2023-08-24T14:57:52.097267  /lava-68134/1/../bin/lava-test-case
    2023-08-24T14:57:52.125582  <8>[   24.888843] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e770c213dcbd55f9286d9f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e770c213dcbd55f9286da4
        failing since 147 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-24T15:01:10.411599  <8>[   12.920096] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11346165_1.4.2.3.1>

    2023-08-24T15:01:10.520064  / # #

    2023-08-24T15:01:10.622448  export SHELL=3D/bin/sh

    2023-08-24T15:01:10.623141  #

    2023-08-24T15:01:10.724660  / # export SHELL=3D/bin/sh. /lava-11346165/=
environment

    2023-08-24T15:01:10.725350  =


    2023-08-24T15:01:10.826935  / # . /lava-11346165/environment/lava-11346=
165/bin/lava-test-runner /lava-11346165/1

    2023-08-24T15:01:10.828070  =


    2023-08-24T15:01:10.832831  / # /lava-11346165/bin/lava-test-runner /la=
va-11346165/1

    2023-08-24T15:01:10.839514  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e771643d7c1d92ad286de0

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e771643d7c1d92ad286de9
        failing since 37 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-24T15:05:20.495125  / # #

    2023-08-24T15:05:20.597173  export SHELL=3D/bin/sh

    2023-08-24T15:05:20.597890  #

    2023-08-24T15:05:20.699328  / # export SHELL=3D/bin/sh. /lava-11346228/=
environment

    2023-08-24T15:05:20.700040  =


    2023-08-24T15:05:20.801521  / # . /lava-11346228/environment/lava-11346=
228/bin/lava-test-runner /lava-11346228/1

    2023-08-24T15:05:20.802518  =


    2023-08-24T15:05:20.819608  / # /lava-11346228/bin/lava-test-runner /la=
va-11346228/1

    2023-08-24T15:05:20.867545  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-24T15:05:20.868057  + cd /lav<8>[   19.077260] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11346228_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e7716e454033bbe8286d77

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e7716e454033bbe8286d7c
        failing since 37 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-24T15:04:15.275137  / # #

    2023-08-24T15:04:16.354648  export SHELL=3D/bin/sh

    2023-08-24T15:04:16.356441  #

    2023-08-24T15:04:17.846299  / # export SHELL=3D/bin/sh. /lava-11346225/=
environment

    2023-08-24T15:04:17.848185  =


    2023-08-24T15:04:20.570919  / # . /lava-11346225/environment/lava-11346=
225/bin/lava-test-runner /lava-11346225/1

    2023-08-24T15:04:20.573061  =


    2023-08-24T15:04:20.574844  / # /lava-11346225/bin/lava-test-runner /la=
va-11346225/1

    2023-08-24T15:04:20.640545  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-24T15:04:20.641036  + cd /lav<8>[   28.474496] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11346225_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e7716601536e66e3286dff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.47-=
16-gc079d0dd788a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e7716601536e66e3286e04
        failing since 37 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-24T15:05:30.945409  / # #

    2023-08-24T15:05:31.047786  export SHELL=3D/bin/sh

    2023-08-24T15:05:31.048557  #

    2023-08-24T15:05:31.150062  / # export SHELL=3D/bin/sh. /lava-11346236/=
environment

    2023-08-24T15:05:31.150829  =


    2023-08-24T15:05:31.252319  / # . /lava-11346236/environment/lava-11346=
236/bin/lava-test-runner /lava-11346236/1

    2023-08-24T15:05:31.253632  =


    2023-08-24T15:05:31.257675  / # /lava-11346236/bin/lava-test-runner /la=
va-11346236/1

    2023-08-24T15:05:31.337876  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-24T15:05:31.338378  + cd /lava-11346236/1/tests/1_boot<8>[   16=
.970887] <LAVA_SIGNAL_STARTRUN 1_bootrr 11346236_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

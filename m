Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACDD72CC16
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 19:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbjFLRJo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 13:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjFLRJm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 13:09:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E713EE7B
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:09:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-25c0a7f8999so199055a91.1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686589778; x=1689181778;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YlhWQqUI0C+e19vCukpTq6m0W2Llxnwm9KGIGOw8Q0Y=;
        b=xcGtMZHodjQSqGpEWHJwwixa71BakZf7xNhiLsXp4OQmCOra29gnBbtjXp8Y05vdCF
         kZz+L+wTAHW3RLcwzC6DkqmhbfZ4BZHVPHdChNRqG+FLarT7O+ndyJd4CRobx7btlUJr
         Plbenms0OPhR+QqblUkLM7CMr8MZyH3v7lgIQCJERumAQ1n+afuRpKLbJOLyAwQLausi
         9uga9yCOIAfKO8WjvJW6WMZuLZb1p/DgEIfmOHpRrMJMloi2RoXytAoi2KgNh1aCQlM5
         cgmyY+yG7ksjzWC7tvnNSLWabVv1sNiTui2DOx9AOsxRuOGh6L3/gDw5Csgm/05spe8h
         8AqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686589778; x=1689181778;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlhWQqUI0C+e19vCukpTq6m0W2Llxnwm9KGIGOw8Q0Y=;
        b=giqMWyk56rYR5K3NRf/IFuB3S7sFuGYIgPW8Wzvfk9KzwzLQb4Hp5kaTPoSm962rlT
         8NkjpDbdgK0FBvdap3NqNfFVWqgD5Lfe7YCKXgsMi/ljY6IxnAf5TXm62z2H8euHfv63
         FNUFf31/2/PYVMVtnME4gEuH8Gs+r5ZmJbAAeK9iHO+/Pwu9jGbFxXaghCE6VJTeLfTZ
         vXxAXDuMdaS4gl17eA+wwZqPG6vuQQ6/m579TbICZLJkCD03TeQ2pAe5I4dTNJUIGfIJ
         KKE25gJfRiy5unIcfs/ESyfMQZW90+X7UwovdryTy6Jou0lnkA9OOgsZIK1IOWgvUJ7+
         IQCA==
X-Gm-Message-State: AC+VfDyUyYieRqQ0odhtm8Ff2hR0G04nUN40ytPmiOO53ndcOMbjo9Xi
        f3wHlIFPJ6xsCq3jH7UMhpJhgA0CBMq0UPEbGChY1A==
X-Google-Smtp-Source: ACHHUZ74av2n+FOGvGK+aIjYL14FZdyhIfIAkXteH7ncIUHiLnSszLT+2BMlS1MFbqyTMYAOMiLSiw==
X-Received: by 2002:a17:90a:678e:b0:25b:e766:6c40 with SMTP id o14-20020a17090a678e00b0025be7666c40mr3258945pjj.20.1686589777821;
        Mon, 12 Jun 2023 10:09:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a19d600b0024c1ac09394sm8336239pjj.19.2023.06.12.10.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:09:37 -0700 (PDT)
Message-ID: <64875151.170a0220.83459.0b64@mx.google.com>
Date:   Mon, 12 Jun 2023 10:09:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.183-69-g32cae866b182
Subject: stable-rc/linux-5.10.y baseline: 180 runs,
 8 regressions (v5.10.183-69-g32cae866b182)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 180 runs, 8 regressions (v5.10.183-69-g32c=
ae866b182)

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

qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.183-69-g32cae866b182/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.183-69-g32cae866b182
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      32cae866b1825021bd263dbd8dbb522e1d0df8a6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64871c28d6827b4e0c30614e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871c28d6827b4e0c306153
        failing since 145 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-06-12T13:22:36.625205  <8>[   11.147035] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3659388_1.5.2.4.1>
    2023-06-12T13:22:36.736302  / # #
    2023-06-12T13:22:36.839055  export SHELL=3D/bin/sh
    2023-06-12T13:22:36.839858  #
    2023-06-12T13:22:36.941784  / # export SHELL=3D/bin/sh. /lava-3659388/e=
nvironment
    2023-06-12T13:22:36.942604  =

    2023-06-12T13:22:37.044561  / # . /lava-3659388/environment/lava-365938=
8/bin/lava-test-runner /lava-3659388/1
    2023-06-12T13:22:37.046122  =

    2023-06-12T13:22:37.051241  / # /lava-3659388/bin/lava-test-runner /lav=
a-3659388/1
    2023-06-12T13:22:37.134221  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64871b260b2edec20e30619b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871b260b2edec20e3061a0
        failing since 75 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-12T13:18:25.946581  + set +x

    2023-06-12T13:18:25.953103  <8>[   14.963225] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10690394_1.4.2.3.1>

    2023-06-12T13:18:26.057351  / # #

    2023-06-12T13:18:26.158109  export SHELL=3D/bin/sh

    2023-06-12T13:18:26.158318  #

    2023-06-12T13:18:26.258924  / # export SHELL=3D/bin/sh. /lava-10690394/=
environment

    2023-06-12T13:18:26.259121  =


    2023-06-12T13:18:26.359709  / # . /lava-10690394/environment/lava-10690=
394/bin/lava-test-runner /lava-10690394/1

    2023-06-12T13:18:26.360036  =


    2023-06-12T13:18:26.364483  / # /lava-10690394/bin/lava-test-runner /la=
va-10690394/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64871b1ba45c0c777c3061a2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871b1ba45c0c777c3061a7
        failing since 75 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-12T13:18:04.471454  <8>[   12.629096] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10690407_1.4.2.3.1>

    2023-06-12T13:18:04.474955  + set +x

    2023-06-12T13:18:04.576472  #

    2023-06-12T13:18:04.576790  =


    2023-06-12T13:18:04.677429  / # #export SHELL=3D/bin/sh

    2023-06-12T13:18:04.677661  =


    2023-06-12T13:18:04.778234  / # export SHELL=3D/bin/sh. /lava-10690407/=
environment

    2023-06-12T13:18:04.778469  =


    2023-06-12T13:18:04.879064  / # . /lava-10690407/environment/lava-10690=
407/bin/lava-test-runner /lava-10690407/1

    2023-06-12T13:18:04.879395  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64871c34d6827b4e0c306179

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayli=
bre/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bayli=
bre/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64871c34d6827b4e0c306=
17a
        new failure (last pass: v5.10.183-62-g8bf0074a4df28) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64871aaac728b9c99d3061bf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871aaac728b9c99d3061c4
        failing since 44 days (last pass: v5.10.147, first fail: v5.10.176-=
373-g8415c0f9308b)

    2023-06-12T13:16:02.543441  [   15.985168] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3659327_1.5.2.4.1>
    2023-06-12T13:16:02.648400  =

    2023-06-12T13:16:02.750179  / # #export SHELL=3D/bin/sh
    2023-06-12T13:16:02.750672  =

    2023-06-12T13:16:02.750944  / # [   16.093220] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-06-12T13:16:02.852351  export SHELL=3D/bin/sh. /lava-3659327/envir=
onment
    2023-06-12T13:16:02.852860  =

    2023-06-12T13:16:02.954318  / # . /lava-3659327/environment/lava-365932=
7/bin/lava-test-runner /lava-3659327/1
    2023-06-12T13:16:02.955158  =

    2023-06-12T13:16:02.958464  / # /lava-3659327/bin/lava-test-runner /lav=
a-3659327/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64871b5d38c4e8e813306145

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm=
32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm=
32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871b5d38c4e8e81330614a
        failing since 129 days (last pass: v5.10.147, first fail: v5.10.166=
-10-g6278b8c9832e)

    2023-06-12T13:19:06.008213  <8>[   12.611993] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3659382_1.5.2.4.1>
    2023-06-12T13:19:06.114158  / # #
    2023-06-12T13:19:06.215621  export SHELL=3D/bin/sh
    2023-06-12T13:19:06.216074  #
    2023-06-12T13:19:06.317407  / # export SHELL=3D/bin/sh. /lava-3659382/e=
nvironment
    2023-06-12T13:19:06.317846  =

    2023-06-12T13:19:06.419048  / # . /lava-3659382/environment/lava-365938=
2/bin/lava-test-runner /lava-3659382/1
    2023-06-12T13:19:06.419781  =

    2023-06-12T13:19:06.424242  / # /lava-3659382/bin/lava-test-runner /lav=
a-3659382/1
    2023-06-12T13:19:06.490121  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64871d4bffacc34f05306155

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871d4cffacc34f05306181
        failing since 132 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-12T13:27:13.531230  + set +x
    2023-06-12T13:27:13.535275  <8>[   17.028694] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3659348_1.5.2.4.1>
    2023-06-12T13:27:13.656120  / # #
    2023-06-12T13:27:13.762411  export SHELL=3D/bin/sh
    2023-06-12T13:27:13.763960  #
    2023-06-12T13:27:13.867387  / # export SHELL=3D/bin/sh. /lava-3659348/e=
nvironment
    2023-06-12T13:27:13.868963  =

    2023-06-12T13:27:13.972404  / # . /lava-3659348/environment/lava-365934=
8/bin/lava-test-runner /lava-3659348/1
    2023-06-12T13:27:13.975312  =

    2023-06-12T13:27:13.978613  / # /lava-3659348/bin/lava-test-runner /lav=
a-3659348/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64871aef646977980b306145

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
83-69-g32cae866b182/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871aef646977980b306171
        failing since 132 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-12T13:17:01.226389  + set +x
    2023-06-12T13:17:01.230325  <8>[   17.160748] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 598299_1.5.2.4.1>
    2023-06-12T13:17:01.346137  / # #
    2023-06-12T13:17:01.448868  export SHELL=3D/bin/sh
    2023-06-12T13:17:01.449403  #
    2023-06-12T13:17:01.550639  / # export SHELL=3D/bin/sh. /lava-598299/en=
vironment
    2023-06-12T13:17:01.551319  =

    2023-06-12T13:17:01.653231  / # . /lava-598299/environment/lava-598299/=
bin/lava-test-runner /lava-598299/1
    2023-06-12T13:17:01.654801  =

    2023-06-12T13:17:01.658889  / # /lava-598299/bin/lava-test-runner /lava=
-598299/1 =

    ... (12 line(s) more)  =

 =20

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC42701775
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 15:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbjEMNk2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 09:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjEMNk0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 09:40:26 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD58BD8
        for <stable@vger.kernel.org>; Sat, 13 May 2023 06:40:24 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-52cb78647ecso6594371a12.1
        for <stable@vger.kernel.org>; Sat, 13 May 2023 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683985224; x=1686577224;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=buHJpm3LAiMPuGaF8Ou4CtBmD4xy7bSGen/S1K6sZkE=;
        b=doV4oTt5ZPtxlbiVOQ8ZQ4UfVkxxEuiPLZwJS5endxgvcDtq7BBCAQMf3N6obgG4Kt
         5NIg0i2TLKFdjX6h+8ZheGUi6xeqkb4q6YO6OCCYGMkaUFi4wSbUbxM4bVJjW7ThcqjQ
         PNnve9qpBEUVQFL0GQe0tWsChO+XpVvvnm7Mor/2QXf8Ein6eVcLM91TQkXf9pSHBAHO
         KmEw1SRUmvyF8eF1j5FxeIOb/dEsWsE/oGQMymKaxqbWYBLhKs//XMhnpyyI4i8dm0Xy
         DW0M+2oOSe51bvyjKNY+lV+Fso+4bmpsz6xWaHXGEmA/P0Tc6MndD3fSyjrcpk6dfxy9
         V/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683985224; x=1686577224;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buHJpm3LAiMPuGaF8Ou4CtBmD4xy7bSGen/S1K6sZkE=;
        b=ETfMz4cGep0pfEfuAhdXtgYW8uOhF1VRHUVbYWU0LU5FKVywvOkdFA3UwUgw9veszp
         7Oq8q4EMtaSAjOy85TGSBQlfcTTMLeuZpDNEydsY/Jt/Rwk3RcFcws9MBptgZG+yYND6
         gDgN1b2ZDJIduGFDrfTR1lj7Vsd51tXuKOvp8Tg+l+/3hXjb4GpLB9uRCES0m90VlgoI
         eKFsTLjPuiaGizVkwnDbkKbXqPLHeOZmL6lgG59ozBk0kC4iueJTjVQ7kzZowTST1HFn
         RWmjqspKLAvrT62rOQizaj2YkEC/PLTCU4xSMrC6sue4OI7LST5dCn7+4HKQ7Zz4JR24
         +B7g==
X-Gm-Message-State: AC+VfDwRNkoNY0ma+OzmPN15B78jEScv9crqiYcTJI0nac4ar7S41I0s
        XEIXLkfUvNxnM+FF3iHplCa6y7vSy7G3HrXzaH8=
X-Google-Smtp-Source: ACHHUZ5oqjibhzOdVU5erAHVBJu2BPBh/hcRnwJ3TIVTa4MPTZ80fbJfTGaoKlE5qAF0YLoArusa3w==
X-Received: by 2002:a17:90a:4c81:b0:250:4a18:f575 with SMTP id k1-20020a17090a4c8100b002504a18f575mr26201110pjh.9.1683985223622;
        Sat, 13 May 2023 06:40:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 191-20020a6305c8000000b004e28be19d1csm8454181pgf.32.2023.05.13.06.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 06:40:22 -0700 (PDT)
Message-ID: <645f9346.630a0220.3daa7.fe2e@mx.google.com>
Date:   Sat, 13 May 2023 06:40:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.28-181-g0875fdeac3382
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 179 runs,
 10 regressions (v6.1.28-181-g0875fdeac3382)
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

stable-rc/queue/6.1 baseline: 179 runs, 10 regressions (v6.1.28-181-g0875fd=
eac3382)

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

kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.28-181-g0875fdeac3382/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.28-181-g0875fdeac3382
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      0875fdeac3382ca890bf5d1a8c5a4c4120062478 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f5f1c657e3f26f12e8649

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f5f1c657e3f26f12e864e
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T09:57:33.229618  + set +x

    2023-05-13T09:57:33.236073  <8>[   28.651869] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10303455_1.4.2.3.1>

    2023-05-13T09:57:33.344923  / # #

    2023-05-13T09:57:33.447415  export SHELL=3D/bin/sh

    2023-05-13T09:57:33.448240  #

    2023-05-13T09:57:33.549629  / # export SHELL=3D/bin/sh. /lava-10303455/=
environment

    2023-05-13T09:57:33.549825  =


    2023-05-13T09:57:33.650557  / # . /lava-10303455/environment/lava-10303=
455/bin/lava-test-runner /lava-10303455/1

    2023-05-13T09:57:33.651438  =


    2023-05-13T09:57:33.657022  / # /lava-10303455/bin/lava-test-runner /la=
va-10303455/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f5f111cb224224f2e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f5f111cb224224f2e85ed
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T09:57:16.788276  + <8>[   12.894173] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10303465_1.4.2.3.1>

    2023-05-13T09:57:16.788362  set +x

    2023-05-13T09:57:16.892451  / # #

    2023-05-13T09:57:16.993127  export SHELL=3D/bin/sh

    2023-05-13T09:57:16.993341  #

    2023-05-13T09:57:17.093862  / # export SHELL=3D/bin/sh. /lava-10303465/=
environment

    2023-05-13T09:57:17.094118  =


    2023-05-13T09:57:17.194651  / # . /lava-10303465/environment/lava-10303=
465/bin/lava-test-runner /lava-10303465/1

    2023-05-13T09:57:17.194996  =


    2023-05-13T09:57:17.199245  / # /lava-10303465/bin/lava-test-runner /la=
va-10303465/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f5f10657e3f26f12e8613

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f5f10657e3f26f12e8618
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T09:57:16.615282  <8>[   13.211223] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10303453_1.4.2.3.1>

    2023-05-13T09:57:16.618840  + set +x

    2023-05-13T09:57:16.720028  #

    2023-05-13T09:57:16.820743  / # #export SHELL=3D/bin/sh

    2023-05-13T09:57:16.820974  =


    2023-05-13T09:57:16.921438  / # export SHELL=3D/bin/sh. /lava-10303453/=
environment

    2023-05-13T09:57:16.921665  =


    2023-05-13T09:57:17.022142  / # . /lava-10303453/environment/lava-10303=
453/bin/lava-test-runner /lava-10303453/1

    2023-05-13T09:57:17.022405  =


    2023-05-13T09:57:17.026991  / # /lava-10303453/bin/lava-test-runner /la=
va-10303453/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645f60e17341b119112e866a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645f60e17341b119112e8=
66b
        failing since 22 days (last pass: v6.1.22-477-g2128d4458cbc, first =
fail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f5f04a08174bb002e8623

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f5f04a08174bb002e8628
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T09:57:14.077748  + set +x

    2023-05-13T09:57:14.084824  <8>[   11.232494] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10303448_1.4.2.3.1>

    2023-05-13T09:57:14.188936  / # #

    2023-05-13T09:57:14.289517  export SHELL=3D/bin/sh

    2023-05-13T09:57:14.289703  #

    2023-05-13T09:57:14.390231  / # export SHELL=3D/bin/sh. /lava-10303448/=
environment

    2023-05-13T09:57:14.390421  =


    2023-05-13T09:57:14.490931  / # . /lava-10303448/environment/lava-10303=
448/bin/lava-test-runner /lava-10303448/1

    2023-05-13T09:57:14.491203  =


    2023-05-13T09:57:14.495523  / # /lava-10303448/bin/lava-test-runner /la=
va-10303448/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f5f121cb224224f2e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f5f121cb224224f2e85f8
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T09:57:16.984731  + <8>[   11.648844] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10303443_1.4.2.3.1>

    2023-05-13T09:57:16.985305  set +x

    2023-05-13T09:57:17.093150  / # #

    2023-05-13T09:57:17.195444  export SHELL=3D/bin/sh

    2023-05-13T09:57:17.196226  #

    2023-05-13T09:57:17.297821  / # export SHELL=3D/bin/sh. /lava-10303443/=
environment

    2023-05-13T09:57:17.298611  =


    2023-05-13T09:57:17.400166  / # . /lava-10303443/environment/lava-10303=
443/bin/lava-test-runner /lava-10303443/1

    2023-05-13T09:57:17.401398  =


    2023-05-13T09:57:17.406891  / # /lava-10303443/bin/lava-test-runner /la=
va-10303443/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645f6356ab10a8e09e2e85e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-i=
mx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-i=
mx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645f6356ab10a8e09e2e8=
5e9
        new failure (last pass: v6.1.28-105-gb0c6a42a9d3b) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645f5efd472276e4ef2e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f5efd472276e4ef2e8611
        failing since 45 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-13T09:57:00.863195  + set +x<8>[    9.323828] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10303492_1.4.2.3.1>

    2023-05-13T09:57:00.863280  =


    2023-05-13T09:57:00.967869  / # #

    2023-05-13T09:57:01.068483  export SHELL=3D/bin/sh

    2023-05-13T09:57:01.068640  #

    2023-05-13T09:57:01.169137  / # export SHELL=3D/bin/sh. /lava-10303492/=
environment

    2023-05-13T09:57:01.169328  =


    2023-05-13T09:57:01.269862  / # . /lava-10303492/environment/lava-10303=
492/bin/lava-test-runner /lava-10303492/1

    2023-05-13T09:57:01.270167  =


    2023-05-13T09:57:01.274834  / # /lava-10303492/bin/lava-test-runner /la=
va-10303492/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645f605e80b5d097102e85f5

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-18=
1-g0875fdeac3382/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/645f605e80b5d097102e8611
        failing since 6 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-13T10:02:43.274971  /lava-10303517/1/../bin/lava-test-case

    2023-05-13T10:02:43.284312  <8>[   22.926790] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645f605f80b5d097102e869d
        failing since 6 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-13T10:02:37.817544  + set +x

    2023-05-13T10:02:37.823824  <8>[   17.467306] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10303517_1.5.2.3.1>

    2023-05-13T10:02:37.930565  / # #

    2023-05-13T10:02:38.031452  export SHELL=3D/bin/sh

    2023-05-13T10:02:38.031729  #

    2023-05-13T10:02:38.132375  / # export SHELL=3D/bin/sh. /lava-10303517/=
environment

    2023-05-13T10:02:38.132671  =


    2023-05-13T10:02:38.233346  / # . /lava-10303517/environment/lava-10303=
517/bin/lava-test-runner /lava-10303517/1

    2023-05-13T10:02:38.233786  =


    2023-05-13T10:02:38.238566  / # /lava-10303517/bin/lava-test-runner /la=
va-10303517/1
 =

    ... (13 line(s) more)  =

 =20

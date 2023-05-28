Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B78C713FF3
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjE1T61 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjE1T61 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:58:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C7FAD
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:58:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-25673e8c464so276634a91.3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685303903; x=1687895903;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gyGzJ0vA6AsRdy6n9ttUYaziuNTz6CBHZVGDO1oewjs=;
        b=lAlMj4ap4Owi8F7al/3gHeEY0CtJHjEfQBmrwGjksc+fxLKNFX2zXNgJ1tW+tyBxCd
         uYp1BeuGcobQ2NdHftYB2Ry6+9/IN3avldchTP/f21kyD8/pZltTmbk+wzcrCJTDBrxm
         rKuS/v0FKLKsG4V12BKHqBU8tWXIvS4dNfKt6YVVLPauXVKhldpxsMO3LI6kwcDipEPU
         S7Ccd4UXe2F2xH2vz9SJdzO48K/jiD2xdivIFykBxC+2Td2g9ffJATlOET7qm1AfqMCX
         /o7HlUf6yYAxPzrPIEugmOm734J7e8BX4/8rtHuToSqOnf23BeKsNkngs8Yf05h/TcMG
         zilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685303903; x=1687895903;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyGzJ0vA6AsRdy6n9ttUYaziuNTz6CBHZVGDO1oewjs=;
        b=K5Hc0OP2Xu1aIhXl8h4gqqMkuGErkeeAucADwK04synbrwGB47VJ9BD1QOAnVfn8sS
         61zlNIoMcmRm8QZDBadCzmt6Ckt1fqWpJMtNqrb5tBsbvG08WAKewv58oVm0jD02n3kQ
         tO0sl5P/vWrblW7n3/+BdG91h3Hrv8+xDCbiD8Xf8jHajsQXwo98DVzKRoJoR49O4bE/
         4MgJLzqnTSg8UPvGhrh0ZsX49g58+Zf6lg+lcpYrURtAFu5F50ImnUBZvpSG57XGwspV
         orhW+w4CMxSqkyUk+OyudKBl/HxtoiU2fuw3zlLliEimQ+vuOkbm1DPsj88GJVnvjiSE
         A86A==
X-Gm-Message-State: AC+VfDx/pwOaYMu6e3WqqaPYbLO5o6Rr3JxFnOkrb+uufC8XUsc1NYul
        /eNNuuvBFbDfUtGjPm0cjlt0MipxIYilEixvIgFfyg==
X-Google-Smtp-Source: ACHHUZ78G13ibw16CSUCbySAC1UmI05kq53XtWIGoTSeaTnRLSX0ZVApAJNxt2hdh7Psr1C8hsPbWg==
X-Received: by 2002:a17:90a:fac:b0:255:c829:b638 with SMTP id 41-20020a17090a0fac00b00255c829b638mr9128854pjz.9.1685303903454;
        Sun, 28 May 2023 12:58:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a000500b00253311d508esm8137855pja.27.2023.05.28.12.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 12:58:22 -0700 (PDT)
Message-ID: <6473b25e.170a0220.7c044.07cf@mx.google.com>
Date:   Sun, 28 May 2023 12:58:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-231-ga29aa139444d8
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 174 runs,
 7 regressions (v5.15.112-231-ga29aa139444d8)
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

stable-rc/queue/5.15 baseline: 174 runs, 7 regressions (v5.15.112-231-ga29a=
a139444d8)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-231-ga29aa139444d8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-231-ga29aa139444d8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a29aa139444d8160be7801d1ef323a907c6030bb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64737c1e504ec5fede2e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-231-ga29aa139444d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-231-ga29aa139444d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64737c1e504ec5fede2e85ec
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T16:06:27.664440  + set +x<8>[   11.115175] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10495582_1.4.2.3.1>

    2023-05-28T16:06:27.664913  =


    2023-05-28T16:06:27.772058  / # #

    2023-05-28T16:06:27.874862  export SHELL=3D/bin/sh

    2023-05-28T16:06:27.875616  #

    2023-05-28T16:06:27.977074  / # export SHELL=3D/bin/sh. /lava-10495582/=
environment

    2023-05-28T16:06:27.978036  =


    2023-05-28T16:06:28.079907  / # . /lava-10495582/environment/lava-10495=
582/bin/lava-test-runner /lava-10495582/1

    2023-05-28T16:06:28.081048  =


    2023-05-28T16:06:28.085918  / # /lava-10495582/bin/lava-test-runner /la=
va-10495582/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64737c338c19686f3c2e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-231-ga29aa139444d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-231-ga29aa139444d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64737c348c19686f3c2e860c
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T16:06:56.378188  <8>[   10.072532] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10495626_1.4.2.3.1>

    2023-05-28T16:06:56.381212  + set +x

    2023-05-28T16:06:56.482422  #

    2023-05-28T16:06:56.482742  =


    2023-05-28T16:06:56.583442  / # #export SHELL=3D/bin/sh

    2023-05-28T16:06:56.583656  =


    2023-05-28T16:06:56.684298  / # export SHELL=3D/bin/sh. /lava-10495626/=
environment

    2023-05-28T16:06:56.684488  =


    2023-05-28T16:06:56.785005  / # . /lava-10495626/environment/lava-10495=
626/bin/lava-test-runner /lava-10495626/1

    2023-05-28T16:06:56.785334  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64737f52c5532c81632e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-231-ga29aa139444d8/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-231-ga29aa139444d8/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64737f52c5532c81632e8=
5e8
        failing since 114 days (last pass: v5.15.91-12-g3290f78df1ab, first=
 fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64737e612f533c0f592e862a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-231-ga29aa139444d8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-231-ga29aa139444d8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64737e612f533c0f592e862f
        failing since 131 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-28T16:16:17.377156  + set +x<8>[   10.030083] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3626905_1.5.2.4.1>
    2023-05-28T16:16:17.377833  =

    2023-05-28T16:16:17.486551  / # #
    2023-05-28T16:16:17.589645  export SHELL=3D/bin/sh
    2023-05-28T16:16:17.590617  #
    2023-05-28T16:16:17.692715  / # export SHELL=3D/bin/sh. /lava-3626905/e=
nvironment
    2023-05-28T16:16:17.693757  =

    2023-05-28T16:16:17.694233  / # <3>[   10.273133] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-05-28T16:16:17.796155  . /lava-3626905/environment/lava-3626905/bi=
n/lava-test-runner /lava-3626905/1
    2023-05-28T16:16:17.797567   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64737cdabcdbb05ea02e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-231-ga29aa139444d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-231-ga29aa139444d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64737cdabcdbb05ea02e85ed
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T16:09:43.609692  + set +x

    2023-05-28T16:09:43.615888  <8>[    9.971962] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10495636_1.4.2.3.1>

    2023-05-28T16:09:43.720363  / # #

    2023-05-28T16:09:43.821027  export SHELL=3D/bin/sh

    2023-05-28T16:09:43.821190  #

    2023-05-28T16:09:43.921735  / # export SHELL=3D/bin/sh. /lava-10495636/=
environment

    2023-05-28T16:09:43.921947  =


    2023-05-28T16:09:44.022448  / # . /lava-10495636/environment/lava-10495=
636/bin/lava-test-runner /lava-10495636/1

    2023-05-28T16:09:44.022705  =


    2023-05-28T16:09:44.026799  / # /lava-10495636/bin/lava-test-runner /la=
va-10495636/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64737c26504ec5fede2e861a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-231-ga29aa139444d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-231-ga29aa139444d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64737c26504ec5fede2e861f
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T16:06:53.375984  + set +x<8>[   11.032504] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10495657_1.4.2.3.1>

    2023-05-28T16:06:53.376071  =


    2023-05-28T16:06:53.477675  #

    2023-05-28T16:06:53.578483  / # #export SHELL=3D/bin/sh

    2023-05-28T16:06:53.578665  =


    2023-05-28T16:06:53.679161  / # export SHELL=3D/bin/sh. /lava-10495657/=
environment

    2023-05-28T16:06:53.679437  =


    2023-05-28T16:06:53.780085  / # . /lava-10495657/environment/lava-10495=
657/bin/lava-test-runner /lava-10495657/1

    2023-05-28T16:06:53.780405  =


    2023-05-28T16:06:53.785706  / # /lava-10495657/bin/lava-test-runner /la=
va-10495657/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64737c395b79e817b52e85f0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-231-ga29aa139444d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-231-ga29aa139444d8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64737c395b79e817b52e85f5
        failing since 61 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-28T16:07:06.124204  + <8>[   11.371723] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10495631_1.4.2.3.1>

    2023-05-28T16:07:06.124631  set +x

    2023-05-28T16:07:06.231735  / # #

    2023-05-28T16:07:06.334612  export SHELL=3D/bin/sh

    2023-05-28T16:07:06.335337  #

    2023-05-28T16:07:06.436830  / # export SHELL=3D/bin/sh. /lava-10495631/=
environment

    2023-05-28T16:07:06.437534  =


    2023-05-28T16:07:06.538909  / # . /lava-10495631/environment/lava-10495=
631/bin/lava-test-runner /lava-10495631/1

    2023-05-28T16:07:06.540164  =


    2023-05-28T16:07:06.544406  / # /lava-10495631/bin/lava-test-runner /la=
va-10495631/1
 =

    ... (12 line(s) more)  =

 =20

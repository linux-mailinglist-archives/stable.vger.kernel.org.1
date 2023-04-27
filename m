Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0128F6F079B
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 16:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbjD0Ohs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243906AbjD0Ohq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 10:37:46 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9F130D6
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 07:37:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a667067275so67022565ad.1
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682606263; x=1685198263;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dYbjDLXCT0FOu8UHqiHPpjgd/xr9RpIxYQzJYsZRzMA=;
        b=WpeJhTDrrPwk2YA4ezn9j3Ta4CE4P6I6UDN1zcFEOYnq2h4az2tWMYSDU0xEXjw9oN
         KaF2DYEK5M6m3I9qdUBGHuIWQU/F2nuPx/K9EWCP3ifN0CLnStXm4deHJvLzwdWso9xV
         3ncTKQqKqqqFZeLf7f6CShb9CEz5QB2jCJTrpjcwrZjhI+un0NfgA89tgPWkEqySpuGU
         VOkrkrfS90/6V5fhhSY6zruDGDrAePU6XjNXd5DPDFaVPR4AOcR98BKXitdcdvHQiSd2
         17+rFd1m7SWzYqGxGU+qxK2RW9cWeu/RLjMKwQlakahlX/WTw2rcyFDdJSfSgAQHI2QA
         GnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682606263; x=1685198263;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYbjDLXCT0FOu8UHqiHPpjgd/xr9RpIxYQzJYsZRzMA=;
        b=jpznEHx7PVlySwhiw0pwsKcCjQsAQcV1GSQuwdEjwjtXleXixZ63dLxoYpu3mgadf8
         h5r9M//nGv1J03ucYOxXVzAVrf5VEkawYAO09+R69Bbsgk4AZB72hXjRzba42mJBkzar
         gdh4AHvARk1A7gC4IKwa9ajSjU4Wvr5bXMAHLpWoO2p7vNU1qAJCz3ew3MT7UROwZate
         KLRUEmfhZIZH7CmhYAcXS/+yscZrmUHC1u0KmJqvVzyYw7KQjdXjmBtGkoYaFsi1n9NS
         1waswKsK/twzFfpNzUMH8HTQAJYGMYGQ9JHoTAedTM7MYa1+dyUa1VIH0khpYPrn2mb/
         qkrg==
X-Gm-Message-State: AC+VfDyFDQ8fDQ6LIgojSkagrywTyrkh8xsIDrHaLjesNKXMDv3fZTsk
        7qthX12UwwlF7ZXtJWRAnh7tLstUhnFcOCDqMindHw==
X-Google-Smtp-Source: ACHHUZ6HsgPAO2fdINdVKhNTXV/PtiusRO13xFZPTAIwzbCJth7Xdrf0Ug9V/zK/VntLqy6HpYmInQ==
X-Received: by 2002:a17:902:e805:b0:19e:7a2c:78a7 with SMTP id u5-20020a170902e80500b0019e7a2c78a7mr2356566plg.57.1682606263161;
        Thu, 27 Apr 2023 07:37:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902b20400b001a96496f250sm8141483plr.34.2023.04.27.07.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 07:37:42 -0700 (PDT)
Message-ID: <644a88b6.170a0220.43a93.05f6@mx.google.com>
Date:   Thu, 27 Apr 2023 07:37:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-580-ga9ca34ec26f3
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 118 runs,
 10 regressions (v6.1.22-580-ga9ca34ec26f3)
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

stable-rc/queue/6.1 baseline: 118 runs, 10 regressions (v6.1.22-580-ga9ca34=
ec26f3)

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

bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig            | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.22-580-ga9ca34ec26f3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-580-ga9ca34ec26f3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a9ca34ec26f3fdb386a01ba8aa243186d9104d1c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a50c47140ee39d72e8626

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a50c47140ee39d72e862b
        failing since 29 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-04-27T10:38:39.598366  + set +x

    2023-04-27T10:38:39.605485  <8>[    9.301047] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10141415_1.4.2.3.1>

    2023-04-27T10:38:39.710070  / # #

    2023-04-27T10:38:39.810642  export SHELL=3D/bin/sh

    2023-04-27T10:38:39.810864  #

    2023-04-27T10:38:39.911402  / # export SHELL=3D/bin/sh. /lava-10141415/=
environment

    2023-04-27T10:38:39.911625  =


    2023-04-27T10:38:40.012160  / # . /lava-10141415/environment/lava-10141=
415/bin/lava-test-runner /lava-10141415/1

    2023-04-27T10:38:40.012475  =


    2023-04-27T10:38:40.018783  / # /lava-10141415/bin/lava-test-runner /la=
va-10141415/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a53b047d09f29222e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a53b047d09f29222e860c
        failing since 29 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-04-27T10:51:03.729837  + set<8>[    8.974986] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10141463_1.4.2.3.1>

    2023-04-27T10:51:03.730282   +x

    2023-04-27T10:51:03.837603  / # #

    2023-04-27T10:51:03.939910  export SHELL=3D/bin/sh

    2023-04-27T10:51:03.940620  #

    2023-04-27T10:51:04.042199  / # export SHELL=3D/bin/sh. /lava-10141463/=
environment

    2023-04-27T10:51:04.042928  =


    2023-04-27T10:51:04.144424  / # . /lava-10141463/environment/lava-10141=
463/bin/lava-test-runner /lava-10141463/1

    2023-04-27T10:51:04.145556  =


    2023-04-27T10:51:04.150603  / # /lava-10141463/bin/lava-test-runner /la=
va-10141463/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a50b4041a9940fe2e8751

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a50b4041a9940fe2e8756
        failing since 29 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-04-27T10:38:21.956330  <8>[   10.429480] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10141468_1.4.2.3.1>

    2023-04-27T10:38:21.960023  + set +x

    2023-04-27T10:38:22.061114  #

    2023-04-27T10:38:22.161898  / # #export SHELL=3D/bin/sh

    2023-04-27T10:38:22.162089  =


    2023-04-27T10:38:22.262570  / # export SHELL=3D/bin/sh. /lava-10141468/=
environment

    2023-04-27T10:38:22.262740  =


    2023-04-27T10:38:22.363263  / # . /lava-10141468/environment/lava-10141=
468/bin/lava-test-runner /lava-10141468/1

    2023-04-27T10:38:22.363585  =


    2023-04-27T10:38:22.368579  / # /lava-10141468/bin/lava-test-runner /la=
va-10141468/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/644a4fca025b94f1912e85e6

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/arm/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2835-r=
pi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/arm/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2835-r=
pi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a4fca025b94f1912e8616
        new failure (last pass: v6.1.22-573-g35b4c8b34dab)

    2023-04-27T10:34:26.034874  + set +x
    2023-04-27T10:34:26.038315  <8>[   18.220654] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 393613_1.5.2.4.1>
    2023-04-27T10:34:26.154856  / # #
    2023-04-27T10:34:26.257150  export SHELL=3D/bin/sh
    2023-04-27T10:34:26.257738  #
    2023-04-27T10:34:26.359376  / # export SHELL=3D/bin/sh. /lava-393613/en=
vironment
    2023-04-27T10:34:26.360068  =

    2023-04-27T10:34:26.462174  / # . /lava-393613/environment/lava-393613/=
bin/lava-test-runner /lava-393613/1
    2023-04-27T10:34:26.463062  =

    2023-04-27T10:34:26.469448  / # /lava-393613/bin/lava-test-runner /lava=
-393613/1 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644a52ff02d7f43bae2e8640

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644a52ff02d7f43bae2e8=
641
        failing since 6 days (last pass: v6.1.22-477-g2128d4458cbc, first f=
ail: v6.1.22-474-gecc61872327e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a509e041a9940fe2e85fb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a509e041a9940fe2e8600
        failing since 29 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-04-27T10:38:10.205930  + set +x

    2023-04-27T10:38:10.212041  <8>[    8.049222] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10141424_1.4.2.3.1>

    2023-04-27T10:38:10.316302  / # #

    2023-04-27T10:38:10.416944  export SHELL=3D/bin/sh

    2023-04-27T10:38:10.417143  #

    2023-04-27T10:38:10.517668  / # export SHELL=3D/bin/sh. /lava-10141424/=
environment

    2023-04-27T10:38:10.517877  =


    2023-04-27T10:38:10.618387  / # . /lava-10141424/environment/lava-10141=
424/bin/lava-test-runner /lava-10141424/1

    2023-04-27T10:38:10.618647  =


    2023-04-27T10:38:10.623377  / # /lava-10141424/bin/lava-test-runner /la=
va-10141424/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a515c2291591eb22e8614

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a515c2291591eb22e8619
        failing since 29 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-04-27T10:41:12.565046  <8>[    9.891107] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10141479_1.4.2.3.1>

    2023-04-27T10:41:12.567967  + set +x

    2023-04-27T10:41:12.672928  / # #

    2023-04-27T10:41:12.773684  export SHELL=3D/bin/sh

    2023-04-27T10:41:12.773922  #

    2023-04-27T10:41:12.874487  / # export SHELL=3D/bin/sh. /lava-10141479/=
environment

    2023-04-27T10:41:12.874717  =


    2023-04-27T10:41:12.975304  / # . /lava-10141479/environment/lava-10141=
479/bin/lava-test-runner /lava-10141479/1

    2023-04-27T10:41:12.975616  =


    2023-04-27T10:41:12.981037  / # /lava-10141479/bin/lava-test-runner /la=
va-10141479/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a50b97140ee39d72e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a50b97140ee39d72e8607
        failing since 29 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-04-27T10:38:26.397244  + set<8>[   11.534419] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10141457_1.4.2.3.1>

    2023-04-27T10:38:26.397360   +x

    2023-04-27T10:38:26.501781  / # #

    2023-04-27T10:38:26.602527  export SHELL=3D/bin/sh

    2023-04-27T10:38:26.603453  #

    2023-04-27T10:38:26.705047  / # export SHELL=3D/bin/sh. /lava-10141457/=
environment

    2023-04-27T10:38:26.705799  =


    2023-04-27T10:38:26.807191  / # . /lava-10141457/environment/lava-10141=
457/bin/lava-test-runner /lava-10141457/1

    2023-04-27T10:38:26.808568  =


    2023-04-27T10:38:26.813458  / # /lava-10141457/bin/lava-test-runner /la=
va-10141457/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a509f3093eb70e92e8622

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644a509f3093eb70e92e8627
        failing since 29 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-04-27T10:38:10.045099  <8>[   12.027512] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10141431_1.4.2.3.1>

    2023-04-27T10:38:10.150364  / # #

    2023-04-27T10:38:10.251035  export SHELL=3D/bin/sh

    2023-04-27T10:38:10.251223  #

    2023-04-27T10:38:10.351694  / # export SHELL=3D/bin/sh. /lava-10141431/=
environment

    2023-04-27T10:38:10.351945  =


    2023-04-27T10:38:10.452450  / # . /lava-10141431/environment/lava-10141=
431/bin/lava-test-runner /lava-10141431/1

    2023-04-27T10:38:10.452708  =


    2023-04-27T10:38:10.457753  / # /lava-10141431/bin/lava-test-runner /la=
va-10141431/1

    2023-04-27T10:38:10.464559  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/644a5193c450e0ec522e85f0

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-58=
0-ga9ca34ec26f3/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/mipsel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/644a5193c450e0e=
c522e85f8
        failing since 3 days (last pass: v6.1.22-560-gc4a6f990f6a64, first =
fail: v6.1.22-564-g3588497f7ea83)
        1 lines

    2023-04-27T10:42:20.574546  kern  :alert : CPU 0 Unable to handle kerne=
l paging request at virtual address 3213685c, epc =3D=3D 80202234, ra =3D=
=3D 80204b84
    2023-04-27T10:42:20.574682  =


    2023-04-27T10:42:20.590352  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-04-27T10:42:20.590471  =

   =

 =20

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA87773419E
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 16:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjFQOW6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 17 Jun 2023 10:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjFQOW6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Jun 2023 10:22:58 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5851BDB
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 07:22:55 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-340b48c180bso8497065ab.0
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687011774; x=1689603774;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wA+kvOxTDrd+ygqcNF13LiqInw30jgkZ9RHxxH9nfpg=;
        b=UqKknGxV2Ktt76NQ8rCMfjZEpyH62IbO/KGxbQrXnORA0qBJ9WPfr80UqLMCpJgYjv
         MaD5CW7Ik02cWAVOAW59aDZC3KwnaOSruQDJzafZ+UosQUwQe/s7zKco4oLmbkikcDC5
         wu+hOhEe5xs44aiceIkGBBcyGQE6a+PW01fIk+BDQLoVPaCA0WfxC6u2CvUPIGQrANvs
         VQBy7U0CCTSDfBirhGN4H88rmcUmzXYiiawc5FzHACjqW99ZW46bzPZSKY+DtrEmhRWh
         DwmprDALlMCmev4r3eidV9ochz/08IPVEi97t7t7YCKTIIcDRsows943E+ILqxD1OTfE
         lUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687011774; x=1689603774;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wA+kvOxTDrd+ygqcNF13LiqInw30jgkZ9RHxxH9nfpg=;
        b=UBjOuxC6idKxT3+AeoHvOgsTMjyY7/T7rzwsFtOLOuMFIEj3R3taKtftsfWBMXJKJP
         r+CUWwuvDNOPfzqwGUq5lDSDLA2y4FsPcgu+DTuDKcoIkT2WTHmRjR9e1j/khzir4Ie/
         Q1yVqJB6as71M71s+RPyi+qsJWk6/mGaOtLRxcvQKTFPlSGySInY7TkQwiRJb9sLuRU0
         jwkIoyCZf78w8o0mZWfODbt3SJdltrLknpB1yILEExWA5dKzF9kL/iCIdd2rLZog47R3
         W9+DM9NDCeM7Bp85sBf5hXPkYo2EKjcAvV9uGsxhZUXL2jYYNu7Uu2gQ8FORgd2SQ/EH
         g6Qg==
X-Gm-Message-State: AC+VfDyVtb9y8RGGZUI9jlrmlbvrMbtNNcWzyKzJwNNxYULKDz7gpbTa
        Zp2aNNojKJZsnX/VCgtZVCGT30UAsjHFyqthYWUVxA==
X-Google-Smtp-Source: ACHHUZ6gFwK1Txx9K75m5QN2CtYa5WhW3MHvye6nAIZ47K7Cr5Rz9DtGeFVeTwA3F4QBgTjoea8dQg==
X-Received: by 2002:a92:d486:0:b0:340:d836:1f64 with SMTP id p6-20020a92d486000000b00340d8361f64mr2865869ilg.29.1687011774151;
        Sat, 17 Jun 2023 07:22:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090ac90c00b0023b3d80c76csm3001654pjt.4.2023.06.17.07.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 07:22:53 -0700 (PDT)
Message-ID: <648dc1bd.170a0220.33ee5.5929@mx.google.com>
Date:   Sat, 17 Jun 2023 07:22:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.34-77-g6af270a97965
Subject: stable-rc/linux-6.1.y baseline: 175 runs,
 10 regressions (v6.1.34-77-g6af270a97965)
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

stable-rc/linux-6.1.y baseline: 175 runs, 10 regressions (v6.1.34-77-g6af27=
0a97965)

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

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.34-77-g6af270a97965/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.34-77-g6af270a97965
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6af270a979654a4e0770acbb2ff958dc3db91919 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d8e1fbba3e5e17d3061a2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d8e1fbba3e5e17d3061a7
        failing since 78 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-17T10:42:20.169894  + set +x

    2023-06-17T10:42:20.176564  <8>[    9.999304] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10777793_1.4.2.3.1>

    2023-06-17T10:42:20.278316  #

    2023-06-17T10:42:20.379092  / # #export SHELL=3D/bin/sh

    2023-06-17T10:42:20.379269  =


    2023-06-17T10:42:20.479768  / # export SHELL=3D/bin/sh. /lava-10777793/=
environment

    2023-06-17T10:42:20.479988  =


    2023-06-17T10:42:20.580539  / # . /lava-10777793/environment/lava-10777=
793/bin/lava-test-runner /lava-10777793/1

    2023-06-17T10:42:20.580886  =


    2023-06-17T10:42:20.586811  / # /lava-10777793/bin/lava-test-runner /la=
va-10777793/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d8dadaca1cee6ff306143

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d8dadaca1cee6ff306148
        failing since 78 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-17T10:40:26.644062  + set<8>[   11.123205] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10777732_1.4.2.3.1>

    2023-06-17T10:40:26.644532   +x

    2023-06-17T10:40:26.753246  / # #

    2023-06-17T10:40:26.855533  export SHELL=3D/bin/sh

    2023-06-17T10:40:26.856336  #

    2023-06-17T10:40:26.957712  / # export SHELL=3D/bin/sh. /lava-10777732/=
environment

    2023-06-17T10:40:26.958486  =


    2023-06-17T10:40:27.059904  / # . /lava-10777732/environment/lava-10777=
732/bin/lava-test-runner /lava-10777732/1

    2023-06-17T10:40:27.061050  =


    2023-06-17T10:40:27.066076  / # /lava-10777732/bin/lava-test-runner /la=
va-10777732/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d8db6aca1cee6ff30637e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d8db6aca1cee6ff306383
        failing since 78 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-17T10:40:34.773040  <8>[   11.272315] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10777771_1.4.2.3.1>

    2023-06-17T10:40:34.775890  + set +x

    2023-06-17T10:40:34.880816  / # #

    2023-06-17T10:40:34.981388  export SHELL=3D/bin/sh

    2023-06-17T10:40:34.981578  #

    2023-06-17T10:40:35.082081  / # export SHELL=3D/bin/sh. /lava-10777771/=
environment

    2023-06-17T10:40:35.082265  =


    2023-06-17T10:40:35.182764  / # . /lava-10777771/environment/lava-10777=
771/bin/lava-test-runner /lava-10777771/1

    2023-06-17T10:40:35.183067  =


    2023-06-17T10:40:35.188059  / # /lava-10777771/bin/lava-test-runner /la=
va-10777771/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/648d901d1702b0391430615a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648d901d1702b03914306=
15b
        failing since 9 days (last pass: v6.1.31-40-g7d0a9678d276, first fa=
il: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d8d94b4e14e2cf330615a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d8d94b4e14e2cf330615f
        failing since 78 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-17T10:40:09.278301  + set +x

    2023-06-17T10:40:09.284878  <8>[   10.917915] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10777731_1.4.2.3.1>

    2023-06-17T10:40:09.388667  / # #

    2023-06-17T10:40:09.489258  export SHELL=3D/bin/sh

    2023-06-17T10:40:09.489478  #

    2023-06-17T10:40:09.589990  / # export SHELL=3D/bin/sh. /lava-10777731/=
environment

    2023-06-17T10:40:09.590188  =


    2023-06-17T10:40:09.690701  / # . /lava-10777731/environment/lava-10777=
731/bin/lava-test-runner /lava-10777731/1

    2023-06-17T10:40:09.691022  =


    2023-06-17T10:40:09.695557  / # /lava-10777731/bin/lava-test-runner /la=
va-10777731/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d8d91b4e14e2cf330614c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d8d91b4e14e2cf3306151
        failing since 78 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-17T10:40:01.441166  <8>[   10.271120] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10777788_1.4.2.3.1>

    2023-06-17T10:40:01.444773  + set +x

    2023-06-17T10:40:01.549002  / # #

    2023-06-17T10:40:01.649545  export SHELL=3D/bin/sh

    2023-06-17T10:40:01.649728  #

    2023-06-17T10:40:01.750229  / # export SHELL=3D/bin/sh. /lava-10777788/=
environment

    2023-06-17T10:40:01.750451  =


    2023-06-17T10:40:01.850995  / # . /lava-10777788/environment/lava-10777=
788/bin/lava-test-runner /lava-10777788/1

    2023-06-17T10:40:01.851260  =


    2023-06-17T10:40:01.856367  / # /lava-10777788/bin/lava-test-runner /la=
va-10777788/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d8daf0a2cdcf2fd306180

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d8daf0a2cdcf2fd306185
        failing since 78 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-17T10:40:27.618581  + <8>[   11.215075] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10777724_1.4.2.3.1>

    2023-06-17T10:40:27.619132  set +x

    2023-06-17T10:40:27.726602  / # #

    2023-06-17T10:40:27.829136  export SHELL=3D/bin/sh

    2023-06-17T10:40:27.829345  #

    2023-06-17T10:40:27.930130  / # export SHELL=3D/bin/sh. /lava-10777724/=
environment

    2023-06-17T10:40:27.930932  =


    2023-06-17T10:40:28.032568  / # . /lava-10777724/environment/lava-10777=
724/bin/lava-test-runner /lava-10777724/1

    2023-06-17T10:40:28.033745  =


    2023-06-17T10:40:28.038435  / # /lava-10777724/bin/lava-test-runner /la=
va-10777724/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648d8d9212ab763ade30613e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d8d9212ab763ade306143
        failing since 78 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-17T10:40:11.179527  + set +x<8>[   11.321114] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10777747_1.4.2.3.1>

    2023-06-17T10:40:11.179644  =


    2023-06-17T10:40:11.284145  / # #

    2023-06-17T10:40:11.384911  export SHELL=3D/bin/sh

    2023-06-17T10:40:11.385152  #

    2023-06-17T10:40:11.485715  / # export SHELL=3D/bin/sh. /lava-10777747/=
environment

    2023-06-17T10:40:11.485950  =


    2023-06-17T10:40:11.586583  / # . /lava-10777747/environment/lava-10777=
747/bin/lava-test-runner /lava-10777747/1

    2023-06-17T10:40:11.586920  =


    2023-06-17T10:40:11.591829  / # /lava-10777747/bin/lava-test-runner /la=
va-10777747/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/648d90e1fa744d274f3061ab

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
77-g6af270a97965/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/648d90e1fa744d274f3061c7
        failing since 36 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-17T10:54:25.809027  /lava-10778065/1/../bin/lava-test-case

    2023-06-17T10:54:25.815648  <8>[   23.015402] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648d90e1fa744d274f306253
        failing since 36 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-17T10:54:20.360295  + set +x

    2023-06-17T10:54:20.366868  <8>[   17.564995] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10778065_1.5.2.3.1>

    2023-06-17T10:54:20.471960  / # #

    2023-06-17T10:54:20.572552  export SHELL=3D/bin/sh

    2023-06-17T10:54:20.572737  #

    2023-06-17T10:54:20.673257  / # export SHELL=3D/bin/sh. /lava-10778065/=
environment

    2023-06-17T10:54:20.673458  =


    2023-06-17T10:54:20.773975  / # . /lava-10778065/environment/lava-10778=
065/bin/lava-test-runner /lava-10778065/1

    2023-06-17T10:54:20.774284  =


    2023-06-17T10:54:20.778915  / # /lava-10778065/bin/lava-test-runner /la=
va-10778065/1
 =

    ... (13 line(s) more)  =

 =20

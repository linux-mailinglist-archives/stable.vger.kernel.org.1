Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7BE735719
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 14:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjFSMnj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 08:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFSMnY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 08:43:24 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB3E1FFF
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 05:42:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-668723729c5so828460b3a.3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 05:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687178565; x=1689770565;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WTjf8zMqhQ4c1kFj0JD8QfKwQf4RhXS4CGMBuledAFY=;
        b=uOHfDDWV+4iGKMSipJ3xWG/W61MXwnDlcWRkeo6/D7C4kYJgNiOFmIGbbcAZSWCbLA
         sCx5hR2Q78MBYdKHUtpMEBFwcKXvlZS3y8U07XdUKyT4k3lK3SW+q2ToVLUePJmin0Ov
         QewWeR5QdGT8TEP5Kc3WPnsyD1eJb8tgR0sqxnifN0WmPLuh6Pn1Fu16I0eZyA7ie7Ug
         8AwVp/4poqRAdtUNsfgsOd3VLs3bcKeGpe/r51K63YkjsF73NTEbumpCJaxCvtqpinSf
         RlX6knREJj43JbmLI+EPeRJR0uR0AzcFL/xGtemoz/kDwhENItEoyRflOKVDZDgCX4Gj
         qkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687178565; x=1689770565;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTjf8zMqhQ4c1kFj0JD8QfKwQf4RhXS4CGMBuledAFY=;
        b=SL5QoEPIn4oUm2uXGlZdBAGoZ01n4avhGDBkl8qwoTAMo5lCUe4EzkiLs+MDcS1ps/
         e3ROOejuw/qwXLdfqwpKUn3XN4zJFhcCIzIahYvIkZWVqxugOIn4PmyaSyKON8Dhyjwh
         yPOLAgU/E+86a/4TB70d23pwjFdW3NDNSnzkECIBYkrb+lOHWqSouNfl+0Eq9nh1ZPjy
         X3CwOOt7MDAHBwNK7ntIDS0ClTxB2RU/RVuyb/1ejoQ4KPQ8MZuJbnA3Q09nS0+397Z0
         jia3KdlzSq21w0OoWt3E4mQF2uq47cynXwbg0ymtDHx6JOlZ1g/q8uYq1MlAGsje6c6n
         IxMw==
X-Gm-Message-State: AC+VfDyVGy8wbmumrrTqt9lhg+Yi/oHGkYS3Mn3FKQZ62HwOxrPZyUv8
        ka8Ln0wbqKASjOaPZoPYEPz/6Ih3Aw/mhFeBB2es7XIV
X-Google-Smtp-Source: ACHHUZ7iRRbU8/YisTfvZO/BTThhqlF0NnwTVg7p2NSY2pXaHyb7agd2VLY1YR6/KKX0nza3O9vKTQ==
X-Received: by 2002:a05:6a00:15cc:b0:666:a435:f20c with SMTP id o12-20020a056a0015cc00b00666a435f20cmr10246609pfu.34.1687178564408;
        Mon, 19 Jun 2023 05:42:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i20-20020aa79094000000b0064928cb5f03sm17445709pfa.69.2023.06.19.05.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 05:42:43 -0700 (PDT)
Message-ID: <64904d43.a70a0220.8075d.21fa@mx.google.com>
Date:   Mon, 19 Jun 2023 05:42:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.34-163-gfbff2eddae9a
Subject: stable-rc/linux-6.1.y baseline: 163 runs,
 13 regressions (v6.1.34-163-gfbff2eddae9a)
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

stable-rc/linux-6.1.y baseline: 163 runs, 13 regressions (v6.1.34-163-gfbff=
2eddae9a)

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

kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.34-163-gfbff2eddae9a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.34-163-gfbff2eddae9a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fbff2eddae9a5c403bc0ba1bac1979b5f00c67a4 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64901c67d7b883577e30613e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64901c67d7b883577e306143
        failing since 80 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-19T09:14:03.458872  <8>[   10.872094] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10809523_1.4.2.3.1>

    2023-06-19T09:14:03.462005  + set +x

    2023-06-19T09:14:03.567003  / # #

    2023-06-19T09:14:03.667699  export SHELL=3D/bin/sh

    2023-06-19T09:14:03.667899  #

    2023-06-19T09:14:03.768444  / # export SHELL=3D/bin/sh. /lava-10809523/=
environment

    2023-06-19T09:14:03.768635  =


    2023-06-19T09:14:03.869163  / # . /lava-10809523/environment/lava-10809=
523/bin/lava-test-runner /lava-10809523/1

    2023-06-19T09:14:03.869465  =


    2023-06-19T09:14:03.875523  / # /lava-10809523/bin/lava-test-runner /la=
va-10809523/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64901c68189a09809c30614c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64901c68189a09809c306151
        failing since 80 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-19T09:14:05.567873  + set<8>[   11.975254] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10809487_1.4.2.3.1>

    2023-06-19T09:14:05.567981   +x

    2023-06-19T09:14:05.672362  / # #

    2023-06-19T09:14:05.773061  export SHELL=3D/bin/sh

    2023-06-19T09:14:05.773753  #

    2023-06-19T09:14:05.875247  / # export SHELL=3D/bin/sh. /lava-10809487/=
environment

    2023-06-19T09:14:05.875899  =


    2023-06-19T09:14:05.977554  / # . /lava-10809487/environment/lava-10809=
487/bin/lava-test-runner /lava-10809487/1

    2023-06-19T09:14:05.978825  =


    2023-06-19T09:14:05.983814  / # /lava-10809487/bin/lava-test-runner /la=
va-10809487/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64901c5515527a47f2306139

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64901c5515527a47f230613e
        failing since 80 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-19T09:13:49.133487  <8>[    9.971443] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10809497_1.4.2.3.1>

    2023-06-19T09:13:49.137032  + set +x

    2023-06-19T09:13:49.238575  =


    2023-06-19T09:13:49.339202  / # #export SHELL=3D/bin/sh

    2023-06-19T09:13:49.339361  =


    2023-06-19T09:13:49.439906  / # export SHELL=3D/bin/sh. /lava-10809497/=
environment

    2023-06-19T09:13:49.440078  =


    2023-06-19T09:13:49.540617  / # . /lava-10809497/environment/lava-10809=
497/bin/lava-test-runner /lava-10809497/1

    2023-06-19T09:13:49.540859  =


    2023-06-19T09:13:49.545942  / # /lava-10809497/bin/lava-test-runner /la=
va-10809497/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64901b6088dd17db86306202

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64901b6088dd17db86306=
203
        failing since 11 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64901c4b48084949a630631c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64901c4b48084949a6306321
        failing since 80 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-19T09:13:33.591202  + set +x

    2023-06-19T09:13:33.597619  <8>[   10.960692] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10809505_1.4.2.3.1>

    2023-06-19T09:13:33.702229  / # #

    2023-06-19T09:13:33.802867  export SHELL=3D/bin/sh

    2023-06-19T09:13:33.803068  #

    2023-06-19T09:13:33.903663  / # export SHELL=3D/bin/sh. /lava-10809505/=
environment

    2023-06-19T09:13:33.903882  =


    2023-06-19T09:13:34.004389  / # . /lava-10809505/environment/lava-10809=
505/bin/lava-test-runner /lava-10809505/1

    2023-06-19T09:13:34.004757  =


    2023-06-19T09:13:34.009556  / # /lava-10809505/bin/lava-test-runner /la=
va-10809505/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64901c4748084949a63062df

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64901c4748084949a63062e4
        failing since 80 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-19T09:13:26.912850  <8>[   10.018533] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10809452_1.4.2.3.1>

    2023-06-19T09:13:26.916290  + set +x

    2023-06-19T09:13:27.017550  #

    2023-06-19T09:13:27.118325  / # #export SHELL=3D/bin/sh

    2023-06-19T09:13:27.118512  =


    2023-06-19T09:13:27.219118  / # export SHELL=3D/bin/sh. /lava-10809452/=
environment

    2023-06-19T09:13:27.219291  =


    2023-06-19T09:13:27.319855  / # . /lava-10809452/environment/lava-10809=
452/bin/lava-test-runner /lava-10809452/1

    2023-06-19T09:13:27.320121  =


    2023-06-19T09:13:27.325360  / # /lava-10809452/bin/lava-test-runner /la=
va-10809452/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64901c6c7d25dfa1d730619f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64901c6c7d25dfa1d73061a4
        failing since 80 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-19T09:14:03.819838  + set +x<8>[   11.165699] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10809528_1.4.2.3.1>

    2023-06-19T09:14:03.820188  =


    2023-06-19T09:14:03.928130  / # #

    2023-06-19T09:14:04.029036  export SHELL=3D/bin/sh

    2023-06-19T09:14:04.029403  #

    2023-06-19T09:14:04.130493  / # export SHELL=3D/bin/sh. /lava-10809528/=
environment

    2023-06-19T09:14:04.131302  =


    2023-06-19T09:14:04.232950  / # . /lava-10809528/environment/lava-10809=
528/bin/lava-test-runner /lava-10809528/1

    2023-06-19T09:14:04.234301  =


    2023-06-19T09:14:04.239345  / # /lava-10809528/bin/lava-test-runner /la=
va-10809528/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 2          =


  Details:     https://kernelci.org/test/plan/id/64901adb8188adf30030613e

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-=
imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-=
imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64901adb8188adf300306141
        new failure (last pass: v6.1.34-77-g6af270a97965)

    2023-06-19T09:07:12.104486  / # #
    2023-06-19T09:07:12.207175  export SHELL=3D/bin/sh
    2023-06-19T09:07:12.207938  #
    2023-06-19T09:07:12.309820  / # export SHELL=3D/bin/sh. /lava-359960/en=
vironment
    2023-06-19T09:07:12.310145  =

    2023-06-19T09:07:12.411207  / # . /lava-359960/environment/lava-359960/=
bin/lava-test-runner /lava-359960/1
    2023-06-19T09:07:12.411897  =

    2023-06-19T09:07:12.430489  / # /lava-359960/bin/lava-test-runner /lava=
-359960/1
    2023-06-19T09:07:12.446569  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-19T09:07:12.480582  + cd /l<8>[   14.557338] <LAVA_SIGNAL_START=
RUN 1_bootrr 359960_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/649=
01adb8188adf300306151
        new failure (last pass: v6.1.34-77-g6af270a97965)

    2023-06-19T09:07:14.836895  /lava-359960/1/../bin/lava-test-case
    2023-06-19T09:07:14.837411  <8>[   17.006539] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-06-19T09:07:14.837835  /lava-359960/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64901c3c48084949a6306161

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64901c3c48084949a6306166
        failing since 80 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-19T09:13:17.683445  + set<8>[   12.024901] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10809454_1.4.2.3.1>

    2023-06-19T09:13:17.683614   +x

    2023-06-19T09:13:17.787852  / # #

    2023-06-19T09:13:17.888613  export SHELL=3D/bin/sh

    2023-06-19T09:13:17.888849  #

    2023-06-19T09:13:17.989416  / # export SHELL=3D/bin/sh. /lava-10809454/=
environment

    2023-06-19T09:13:17.989648  =


    2023-06-19T09:13:18.090220  / # . /lava-10809454/environment/lava-10809=
454/bin/lava-test-runner /lava-10809454/1

    2023-06-19T09:13:18.090586  =


    2023-06-19T09:13:18.095365  / # /lava-10809454/bin/lava-test-runner /la=
va-10809454/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64901a04b64e28d5003061ac

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64901a04b64e28d5003061c8
        failing since 38 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-19T09:03:55.680835  /lava-10809130/1/../bin/lava-test-case

    2023-06-19T09:03:55.687558  <8>[   22.980671] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64901a04b64e28d500306254
        failing since 38 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-19T09:03:50.209794  + set +x

    2023-06-19T09:03:50.216620  <8>[   17.507909] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10809130_1.5.2.3.1>

    2023-06-19T09:03:50.321911  / # #

    2023-06-19T09:03:50.422647  export SHELL=3D/bin/sh

    2023-06-19T09:03:50.422887  #

    2023-06-19T09:03:50.523454  / # export SHELL=3D/bin/sh. /lava-10809130/=
environment

    2023-06-19T09:03:50.523691  =


    2023-06-19T09:03:50.624275  / # . /lava-10809130/environment/lava-10809=
130/bin/lava-test-runner /lava-10809130/1

    2023-06-19T09:03:50.624637  =


    2023-06-19T09:03:50.629388  / # /lava-10809130/bin/lava-test-runner /la=
va-10809130/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/649019f539ee556b3b306153

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
163-gfbff2eddae9a/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649019f539ee556b3b306=
154
        new failure (last pass: v6.1.34-90-g7a9de0e648cfb) =

 =20

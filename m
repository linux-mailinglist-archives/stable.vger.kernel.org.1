Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344A1702B7D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 13:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241073AbjEOL2g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 07:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbjEOL2f (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 07:28:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ED613A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 04:28:28 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64cb307d91aso393211b3a.3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 04:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684150107; x=1686742107;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Li9NYZRlyqvz61f5vdbX2+4Y5T0RRWuNi/ktPYqb9ws=;
        b=SVaHxFeIb3XMOxMkRFH4hgm7Voq4UNSg1V3QPBAVEKUNScF7l77hPFdMpBd2JXHlOU
         mvSRa2Hh/emAuAFiz5Q7y88NLJj7HBjVfeoNsU2/bPcv1LfIpa3AIeiQcauhK5XecTiC
         xXQhIrw/xImcxUiFukkUwFUNQUnOG1TnRNpQBr5b3idAFTn9cRrO5VawC7K/fy1ntcxp
         JQV0X9CR8VNPIGNL0IzinrgmSO+3du9i9Ervpo429MBNnT/ujG7C+ktTCjC3pCPASDcX
         UCGSHi0xE9rXezb1oiKoNQPdLooZKfsxy+5+/MTPHBjngFeFHp4jUw30278Vg4/F8cdG
         GEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684150107; x=1686742107;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Li9NYZRlyqvz61f5vdbX2+4Y5T0RRWuNi/ktPYqb9ws=;
        b=Wx3ldbqT+EiCE7VBsvIPJEylTA6RFbeNhuyXCWLDfbnOglCWBIbp7y/DCbxHkjDyFT
         0yDQcrA1M3IiFYYJ5IzstM5lptRkuq9frU6+1Rblh7bxeA6Kl3vZPiFmt59m6+jWGBa1
         y/uG9Jvk0YbAyzoUq+PWputqxDnrlab/RxkNxbKvuLV5jLa7IMSTM4iuLNbKY8QgFuEA
         bxc98BGhMyA161Us+hUV30mV6iJmab3gdAj5qtyK7QcngEgjQuxFxrgXoI0aa0blTSmt
         wN8eUr2dVdW7a7rUDelhgAo4YIAgO2Zx+EHGwXV3zxew1EK79V18TKjEvLEJVZGy+Lzf
         26Cw==
X-Gm-Message-State: AC+VfDzbhGicJNLaEv0UmLeRd3NZz4IjZmeHGVVFgBVxmzvQlkaoK4V8
        hNWKUhiVn/6A6WeOex4PcOk7vC1dsyIrAJRo39a8pA==
X-Google-Smtp-Source: ACHHUZ6EzS/i5mCir1lCgkwt5koCFXBxSv6Y3rGVCmh/6M1OV2/a1tZUO1gLnpS9j9h/EmBR6zKifw==
X-Received: by 2002:a05:6a21:7888:b0:105:41c4:9ead with SMTP id bf8-20020a056a21788800b0010541c49eadmr8543352pzc.43.1684150107229;
        Mon, 15 May 2023 04:28:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e7-20020a63ee07000000b0051f14839bf3sm11375163pgi.34.2023.05.15.04.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 04:28:26 -0700 (PDT)
Message-ID: <6462175a.630a0220.c9f50.3bc2@mx.google.com>
Date:   Mon, 15 May 2023 04:28:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-130-g93ae50a86a5dd
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 131 runs,
 14 regressions (v5.15.111-130-g93ae50a86a5dd)
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

stable-rc/linux-5.15.y baseline: 131 runs, 14 regressions (v5.15.111-130-g9=
3ae50a86a5dd)

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

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.111-130-g93ae50a86a5dd/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.111-130-g93ae50a86a5dd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      93ae50a86a5dd2df4f593cf700fb4eaf736ee972 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461dd5108816de3eb2e85fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461dd5108816de3eb2e8603
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-15T07:20:30.991165  <8>[    8.501390] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10318697_1.4.2.3.1>

    2023-05-15T07:20:30.994497  + set +x

    2023-05-15T07:20:31.102563  / # #

    2023-05-15T07:20:31.204543  export SHELL=3D/bin/sh

    2023-05-15T07:20:31.205205  #

    2023-05-15T07:20:31.306683  / # export SHELL=3D/bin/sh. /lava-10318697/=
environment

    2023-05-15T07:20:31.307394  =


    2023-05-15T07:20:31.409025  / # . /lava-10318697/environment/lava-10318=
697/bin/lava-test-runner /lava-10318697/1

    2023-05-15T07:20:31.410268  =


    2023-05-15T07:20:31.416015  / # /lava-10318697/bin/lava-test-runner /la=
va-10318697/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461dd5608816de3eb2e8611

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461dd5608816de3eb2e8616
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-15T07:20:45.552759  + set +x<8>[    9.378252] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10318689_1.4.2.3.1>

    2023-05-15T07:20:45.552912  =


    2023-05-15T07:20:45.657873  / # #

    2023-05-15T07:20:45.758488  export SHELL=3D/bin/sh

    2023-05-15T07:20:45.758773  #

    2023-05-15T07:20:45.859407  / # export SHELL=3D/bin/sh. /lava-10318689/=
environment

    2023-05-15T07:20:45.859601  =


    2023-05-15T07:20:45.960127  / # . /lava-10318689/environment/lava-10318=
689/bin/lava-test-runner /lava-10318689/1

    2023-05-15T07:20:45.960593  =


    2023-05-15T07:20:45.965923  / # /lava-10318689/bin/lava-test-runner /la=
va-10318689/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461dd3d8cbfb03ad82e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461dd3d8cbfb03ad82e860c
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-15T07:20:15.692207  <8>[   10.846583] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10318736_1.4.2.3.1>

    2023-05-15T07:20:15.695618  + set +x

    2023-05-15T07:20:15.796808  #

    2023-05-15T07:20:15.797108  =


    2023-05-15T07:20:15.897677  / # #export SHELL=3D/bin/sh

    2023-05-15T07:20:15.897890  =


    2023-05-15T07:20:15.998495  / # export SHELL=3D/bin/sh. /lava-10318736/=
environment

    2023-05-15T07:20:15.998708  =


    2023-05-15T07:20:16.099427  / # . /lava-10318736/environment/lava-10318=
736/bin/lava-test-runner /lava-10318736/1

    2023-05-15T07:20:16.099706  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6461df39c4bcb2db982e860d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6461df39c4bcb2db982e8=
60e
        failing since 367 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6461e052e1887f0d4d2e86f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461e052e1887f0d4d2e86f9
        failing since 118 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-05-15T07:33:24.845850  + set +x<8>[   10.015957] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3591043_1.5.2.4.1>
    2023-05-15T07:33:24.846561  =

    2023-05-15T07:33:24.955513  / # #
    2023-05-15T07:33:25.059185  export SHELL=3D/bin/sh
    2023-05-15T07:33:25.060355  #
    2023-05-15T07:33:25.162523  / # export SHELL=3D/bin/sh. /lava-3591043/e=
nvironment
    2023-05-15T07:33:25.163639  =

    2023-05-15T07:33:25.265715  / # . /lava-3591043/environment/lava-359104=
3/bin/lava-test-runner /lava-3591043/1
    2023-05-15T07:33:25.267547  =

    2023-05-15T07:33:25.272539  / # /lava-3591043/bin/lava-test-runner /lav=
a-3591043/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461dd8c72168420942e860f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461dd8c72168420942e8614
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-15T07:21:33.449892  + set +x

    2023-05-15T07:21:33.456525  <8>[   10.568799] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10318750_1.4.2.3.1>

    2023-05-15T07:21:33.564927  / # #

    2023-05-15T07:21:33.667365  export SHELL=3D/bin/sh

    2023-05-15T07:21:33.668151  #

    2023-05-15T07:21:33.770079  / # export SHELL=3D/bin/sh. /lava-10318750/=
environment

    2023-05-15T07:21:33.770873  =


    2023-05-15T07:21:33.872601  / # . /lava-10318750/environment/lava-10318=
750/bin/lava-test-runner /lava-10318750/1

    2023-05-15T07:21:33.873940  =


    2023-05-15T07:21:33.878939  / # /lava-10318750/bin/lava-test-runner /la=
va-10318750/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461dd418cbfb03ad82e862b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461dd418cbfb03ad82e8630
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-15T07:20:21.466447  <8>[   17.688676] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10318713_1.4.2.3.1>

    2023-05-15T07:20:21.469605  + set +x

    2023-05-15T07:20:21.571018  =


    2023-05-15T07:20:21.671623  / # #export SHELL=3D/bin/sh

    2023-05-15T07:20:21.671789  =


    2023-05-15T07:20:21.772477  / # export SHELL=3D/bin/sh. /lava-10318713/=
environment

    2023-05-15T07:20:21.772659  =


    2023-05-15T07:20:21.873200  / # . /lava-10318713/environment/lava-10318=
713/bin/lava-test-runner /lava-10318713/1

    2023-05-15T07:20:21.873465  =


    2023-05-15T07:20:21.878713  / # /lava-10318713/bin/lava-test-runner /la=
va-10318713/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461dd5708816de3eb2e861c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461dd5708816de3eb2e8621
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-15T07:20:35.319762  + set<8>[   11.416548] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10318766_1.4.2.3.1>

    2023-05-15T07:20:35.320188   +x

    2023-05-15T07:20:35.427667  / # #

    2023-05-15T07:20:35.529630  export SHELL=3D/bin/sh

    2023-05-15T07:20:35.530323  #

    2023-05-15T07:20:35.631890  / # export SHELL=3D/bin/sh. /lava-10318766/=
environment

    2023-05-15T07:20:35.632594  =


    2023-05-15T07:20:35.734062  / # . /lava-10318766/environment/lava-10318=
766/bin/lava-test-runner /lava-10318766/1

    2023-05-15T07:20:35.735155  =


    2023-05-15T07:20:35.740823  / # /lava-10318766/bin/lava-test-runner /la=
va-10318766/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6461dd368cbfb03ad82e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461dd368cbfb03ad82e85f6
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-15T07:20:07.060028  + set +x<8>[   11.636032] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10318759_1.4.2.3.1>

    2023-05-15T07:20:07.060117  =


    2023-05-15T07:20:07.164950  / # #

    2023-05-15T07:20:07.265575  export SHELL=3D/bin/sh

    2023-05-15T07:20:07.265774  #

    2023-05-15T07:20:07.366367  / # export SHELL=3D/bin/sh. /lava-10318759/=
environment

    2023-05-15T07:20:07.366547  =


    2023-05-15T07:20:07.467080  / # . /lava-10318759/environment/lava-10318=
759/bin/lava-test-runner /lava-10318759/1

    2023-05-15T07:20:07.467366  =


    2023-05-15T07:20:07.472145  / # /lava-10318759/bin/lava-test-runner /la=
va-10318759/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/6461e2148ff10239db2e85ff

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6461e2148ff10239db2e8619
        new failure (last pass: v5.15.110)

    2023-05-15T07:40:49.958565  /lava-10318918/1/../bin/lava-test-case

    2023-05-15T07:40:49.964924  <8>[   61.563153] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6461e2148ff10239db2e8619
        new failure (last pass: v5.15.110)

    2023-05-15T07:40:49.958565  /lava-10318918/1/../bin/lava-test-case

    2023-05-15T07:40:49.964924  <8>[   61.563153] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6461e2148ff10239db2e861b
        new failure (last pass: v5.15.110)

    2023-05-15T07:40:48.917608  /lava-10318918/1/../bin/lava-test-case

    2023-05-15T07:40:48.923919  <8>[   60.521992] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461e2148ff10239db2e8683
        new failure (last pass: v5.15.110)

    2023-05-15T07:40:34.755011  + <8>[   46.356228] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10318918_1.5.2.3.1>

    2023-05-15T07:40:34.758103  set +x

    2023-05-15T07:40:34.866329  / # #

    2023-05-15T07:40:34.968816  export SHELL=3D/bin/sh

    2023-05-15T07:40:34.969640  #

    2023-05-15T07:40:35.071127  / # export SHELL=3D/bin/sh. /lava-10318918/=
environment

    2023-05-15T07:40:35.071944  =


    2023-05-15T07:40:35.173470  / # . /lava-10318918/environment/lava-10318=
918/bin/lava-test-runner /lava-10318918/1

    2023-05-15T07:40:35.174722  =


    2023-05-15T07:40:35.180003  / # /lava-10318918/bin/lava-test-runner /la=
va-10318918/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6461dd336898b9adb82e8621

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11-130-g93ae50a86a5dd/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6461dd336898b9adb82e8626
        failing since 32 days (last pass: v5.15.82-124-g2b8b2c150867, first=
 fail: v5.15.105-194-g415a9d81c640)

    2023-05-15T07:20:05.525209  / # #
    2023-05-15T07:20:05.631402  export SHELL=3D/bin/sh
    2023-05-15T07:20:05.633294  #
    2023-05-15T07:20:05.737654  / # export SHELL=3D/bin/sh. /lava-3590988/e=
nvironment
    2023-05-15T07:20:05.739668  =

    2023-05-15T07:20:05.844199  / # . /lava-3590988/environment/lava-359098=
8/bin/lava-test-runner /lava-3590988/1
    2023-05-15T07:20:05.847880  =

    2023-05-15T07:20:05.858863  / # /lava-3590988/bin/lava-test-runner /lav=
a-3590988/1
    2023-05-15T07:20:05.978223  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-15T07:20:05.981630  + cd /lava-3590988/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

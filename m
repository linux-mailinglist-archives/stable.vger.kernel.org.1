Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9486476ED32
	for <lists+stable@lfdr.de>; Thu,  3 Aug 2023 16:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjHCOwT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 3 Aug 2023 10:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjHCOwT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 Aug 2023 10:52:19 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A599DA3
        for <stable@vger.kernel.org>; Thu,  3 Aug 2023 07:52:16 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bb119be881so9136245ad.3
        for <stable@vger.kernel.org>; Thu, 03 Aug 2023 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691074336; x=1691679136;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C+Q8dL77MfKgcvfy9SRkejn0A0ETnqOUjSNbIkwHzmg=;
        b=hrxskRWyb5HbOTJl48obxO1eILm5C3kws4skhmdrMWw7sTs4Ei0tJMzKWrPyNPDMjQ
         /KLwQPPJ7Q0RoKNLs8B+xSUW6YvNqdl23AvvpTy/qnjaHukg4+rlDP+AdbFVuYuATvT1
         BHJXY7BmRPd0WiVGQvmzi7nOw4uK+/zsxzMY/rokGv4oLR8fvg5XLuuYFIMBInt/N9aA
         GVeXCnxNFflUiSvERQoCQwU/77j2TjrfSajt60cYEyhUKD8iqEjwep3JHSEu3A6+oT1a
         9gsFJ+k5GlhRlgPBaGSrRxTPPJXv4e0nsgjz4klN1Dl/pNMG/74b38q/FATQsHVYdfqO
         Hbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691074336; x=1691679136;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+Q8dL77MfKgcvfy9SRkejn0A0ETnqOUjSNbIkwHzmg=;
        b=jwHNulnGXfWTjIX6aGdoxYJk6Eze9Uu8Ktr61rAmUa1f5DCPqOKexgIbMZuYFSbak1
         oslDJhcFBJ2HCiS1to8+b+27nnBdNLAq/7/seve94X8T096FjGhtKOcKRf1yRzgjVjh5
         oE6cRDpq4pcFHsM/ol9nF3sAP3dAyImibLqo8JqpqyMgigsqcCoSkDL01NXLeLA2FWb0
         9PtU7bo7Raud+zaXFGu8Mf7qSiRsd//AjF33lDF83X2XFiOxd0zD7Kchpw86PuSG2slh
         G2jRWC2BhMHhpxizhytJgV58ZBe5RxeGNKaaJOjlQJn1w1F2l/Xbc9nu/9J4BUkzMqui
         YzxA==
X-Gm-Message-State: ABy/qLZRYb6aY4rhXfavohJ6o0PTfCKaaT+y/40tEDnYn6PGPjj+Oke0
        4ErsQ0fCRW8P+n19qzVkmnBUY/BQRiV00UMll1I+1w==
X-Google-Smtp-Source: APBJJlEXOBQZZjEmFNc2gTvFKyJKcHkVrwqcG3F6lpZxFoDXkYVigOKbr7cn9HIe6R1Qtbzr8P1W+w==
X-Received: by 2002:a17:903:1cc:b0:1bb:ed01:2d03 with SMTP id e12-20020a17090301cc00b001bbed012d03mr19980211plh.50.1691074335443;
        Thu, 03 Aug 2023 07:52:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iw14-20020a170903044e00b001bb54abfc07sm14398752plb.252.2023.08.03.07.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:52:14 -0700 (PDT)
Message-ID: <64cbbf1e.170a0220.366d5.cc49@mx.google.com>
Date:   Thu, 03 Aug 2023 07:52:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.188
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 131 runs, 12 regressions (v5.10.188)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 131 runs, 12 regressions (v5.10.188)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.188/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.188
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3602dbc57b556eff2456715301d35a1ef8964bba =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23ffe07e90ad7338aceec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23ffe07e90ad7338acef1
        failing since 190 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-03T11:18:52.953794  <8>[   10.964327] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3728113_1.5.2.4.1>
    2023-08-03T11:18:53.062755  / # #
    2023-08-03T11:18:53.165871  export SHELL=3D/bin/sh
    2023-08-03T11:18:53.166359  #
    2023-08-03T11:18:53.166579  / # <3>[   11.132321] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-08-03T11:18:53.267894  export SHELL=3D/bin/sh. /lava-3728113/envir=
onment
    2023-08-03T11:18:53.268864  =

    2023-08-03T11:18:53.370916  / # . /lava-3728113/environment/lava-372811=
3/bin/lava-test-runner /lava-3728113/1
    2023-08-03T11:18:53.372577  =

    2023-08-03T11:18:53.377430  / # /lava-3728113/bin/lava-test-runner /lav=
a-3728113/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23fd35d952e1d418ace40

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23fd35d952e1d418ace43
        failing since 9 days (last pass: v5.10.142, first fail: v5.10.186-3=
32-gf98a4d3a5cec)

    2023-08-03T11:22:34.971895  [    9.385831] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1240593_1.5.2.4.1>
    2023-08-03T11:22:35.077197  =

    2023-08-03T11:22:35.178426  / # #export SHELL=3D/bin/sh
    2023-08-03T11:22:35.178832  =

    2023-08-03T11:22:35.279780  / # export SHELL=3D/bin/sh. /lava-1240593/e=
nvironment
    2023-08-03T11:22:35.280196  =

    2023-08-03T11:22:35.381165  / # . /lava-1240593/environment/lava-124059=
3/bin/lava-test-runner /lava-1240593/1
    2023-08-03T11:22:35.381830  =

    2023-08-03T11:22:35.385944  / # /lava-1240593/bin/lava-test-runner /lav=
a-1240593/1
    2023-08-03T11:22:35.401587  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23fd65d952e1d418ace4e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23fd65d952e1d418ace51
        failing since 145 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-03T11:22:04.642144  [   15.755699] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1240594_1.5.2.4.1>
    2023-08-03T11:22:04.747346  =

    2023-08-03T11:22:04.848549  / # #export SHELL=3D/bin/sh
    2023-08-03T11:22:04.848958  =

    2023-08-03T11:22:04.949898  / # export SHELL=3D/bin/sh. /lava-1240594/e=
nvironment
    2023-08-03T11:22:04.950299  =

    2023-08-03T11:22:05.051254  / # . /lava-1240594/environment/lava-124059=
4/bin/lava-test-runner /lava-1240594/1
    2023-08-03T11:22:05.051914  =

    2023-08-03T11:22:05.055955  / # /lava-1240594/bin/lava-test-runner /lav=
a-1240594/1
    2023-08-03T11:22:05.070001  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23eb666afdf8bc18ace2b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23eb666afdf8bc18ace30
        failing since 120 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-03T11:14:33.035806  + set +x

    2023-08-03T11:14:33.041920  <8>[   12.121203] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11199495_1.4.2.3.1>

    2023-08-03T11:14:33.146626  / # #

    2023-08-03T11:14:33.249006  export SHELL=3D/bin/sh

    2023-08-03T11:14:33.249856  #

    2023-08-03T11:14:33.351484  / # export SHELL=3D/bin/sh. /lava-11199495/=
environment

    2023-08-03T11:14:33.352414  =


    2023-08-03T11:14:33.453690  / # . /lava-11199495/environment/lava-11199=
495/bin/lava-test-runner /lava-11199495/1

    2023-08-03T11:14:33.454056  =


    2023-08-03T11:14:33.458976  / # /lava-11199495/bin/lava-test-runner /la=
va-11199495/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23e8dcc4039dd348acec5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23e8dcc4039dd348aceca
        failing since 120 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-03T11:12:57.434789  + set +x<8>[   10.363954] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11199457_1.4.2.3.1>

    2023-08-03T11:12:57.435227  =


    2023-08-03T11:12:57.542143  #

    2023-08-03T11:12:57.543224  =


    2023-08-03T11:12:57.644908  / # #export SHELL=3D/bin/sh

    2023-08-03T11:12:57.645666  =


    2023-08-03T11:12:57.747253  / # export SHELL=3D/bin/sh. /lava-11199457/=
environment

    2023-08-03T11:12:57.748011  =


    2023-08-03T11:12:57.849530  / # . /lava-11199457/environment/lava-11199=
457/bin/lava-test-runner /lava-11199457/1

    2023-08-03T11:12:57.850708  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c240019d5b0809508ace6e

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c240019d5b0809508acea7
        failing since 9 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-03T11:22:53.482916  / # #
    2023-08-03T11:22:53.585948  export SHELL=3D/bin/sh
    2023-08-03T11:22:53.586704  #
    2023-08-03T11:22:53.688579  / # export SHELL=3D/bin/sh. /lava-26647/env=
ironment
    2023-08-03T11:22:53.689341  =

    2023-08-03T11:22:53.791738  / # . /lava-26647/environment/lava-26647/bi=
n/lava-test-runner /lava-26647/1
    2023-08-03T11:22:53.793128  =

    2023-08-03T11:22:53.805895  / # /lava-26647/bin/lava-test-runner /lava-=
26647/1
    2023-08-03T11:22:53.866769  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-03T11:22:53.867298  + cd /lava-26647/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c2b07346a722ecdd8ace2a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c2b07346a722ecdd8ace2d
        failing since 9 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-07-27T17:58:45.103938  + set +x
    2023-07-27T17:58:45.104157  <8>[   83.680434] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 989717_1.5.2.4.1>
    2023-07-27T17:58:45.210409  / # #
    2023-07-27T17:58:46.673233  export SHELL=3D/bin/sh
    2023-07-27T17:58:46.693877  #
    2023-07-27T17:58:46.694127  / # export SHELL=3D/bin/sh
    2023-07-27T17:58:48.579591  / # . /lava-989717/environment
    2023-07-27T17:58:52.037409  /lava-989717/bin/lava-test-runner /lava-989=
717/1
    2023-07-27T17:58:52.058193  . /lava-989717/environment
    2023-07-27T17:58:52.058301  / # /lava-989717/bin/lava-test-runner /lava=
-989717/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb904372444be19335b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope=
-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope=
-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb904372444be19335b1dc
        failing since 16 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-03T11:31:52.522107  + set +x
    2023-08-03T11:31:52.522217  <8>[   83.979073] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 992142_1.5.2.4.1>
    2023-08-03T11:31:52.627477  / # #
    2023-08-03T11:31:54.086511  export SHELL=3D/bin/sh
    2023-08-03T11:31:54.106933  #
    2023-08-03T11:31:54.107084  / # export SHELL=3D/bin/sh
    2023-08-03T11:31:55.988352  / # . /lava-992142/environment
    2023-08-03T11:31:59.438551  /lava-992142/bin/lava-test-runner /lava-992=
142/1
    2023-08-03T11:31:59.459131  . /lava-992142/environment
    2023-08-03T11:31:59.459248  / # /lava-992142/bin/lava-test-runner /lava=
-992142/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23ff308b37a634f8ace65

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23ff308b37a634f8ace68
        failing since 9 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-03T11:24:01.549813  / # #
    2023-08-03T11:24:03.008971  export SHELL=3D/bin/sh
    2023-08-03T11:24:03.029412  #
    2023-08-03T11:24:03.029561  / # export SHELL=3D/bin/sh
    2023-08-03T11:24:04.910706  / # . /lava-992134/environment
    2023-08-03T11:24:08.361477  /lava-992134/bin/lava-test-runner /lava-992=
134/1
    2023-08-03T11:24:08.382280  . /lava-992134/environment
    2023-08-03T11:24:08.382434  / # /lava-992134/bin/lava-test-runner /lava=
-992134/1
    2023-08-03T11:24:08.414282  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-03T11:24:08.463035  + cd /lava-992134/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64cb8fa54049ce3ba235b1dc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cb8fa54049ce3ba235b1df
        failing since 16 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-03T11:29:21.612288  / # #
    2023-08-03T11:29:23.071298  export SHELL=3D/bin/sh
    2023-08-03T11:29:23.091751  #
    2023-08-03T11:29:23.091928  / # export SHELL=3D/bin/sh
    2023-08-03T11:29:24.972905  / # . /lava-992140/environment
    2023-08-03T11:29:28.422389  /lava-992140/bin/lava-test-runner /lava-992=
140/1
    2023-08-03T11:29:28.443076  . /lava-992140/environment
    2023-08-03T11:29:28.443237  / # /lava-992140/bin/lava-test-runner /lava=
-992140/1
    2023-08-03T11:29:28.476453  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-03T11:29:28.524590  + cd /lava-992140/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c265cb9531ca38d98ace1e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c265cb9531ca38d98ace23
        failing since 9 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-03T11:22:22.043395  / # #

    2023-08-03T11:22:22.145764  export SHELL=3D/bin/sh

    2023-08-03T11:22:22.146493  #

    2023-08-03T11:22:22.247886  / # export SHELL=3D/bin/sh. /lava-11199519/=
environment

    2023-08-03T11:22:22.248607  =


    2023-08-03T11:22:22.350036  / # . /lava-11199519/environment/lava-11199=
519/bin/lava-test-runner /lava-11199519/1

    2023-08-03T11:22:22.351212  =


    2023-08-03T11:22:22.368024  / # /lava-11199519/bin/lava-test-runner /la=
va-11199519/1

    2023-08-03T11:22:22.417053  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-03T11:22:22.417558  + cd /lav<8>[   16.439398] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11199519_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c23f57b2c6f7745f8acf6a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c23f57b2c6f7745f8acf6f
        failing since 9 days (last pass: v5.10.186-221-gf178eace6e074, firs=
t fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-03T11:22:36.970856  / # #

    2023-08-03T11:22:37.072920  export SHELL=3D/bin/sh

    2023-08-03T11:22:37.073619  #

    2023-08-03T11:22:37.174968  / # export SHELL=3D/bin/sh. /lava-11199532/=
environment

    2023-08-03T11:22:37.175651  =


    2023-08-03T11:22:37.277076  / # . /lava-11199532/environment/lava-11199=
532/bin/lava-test-runner /lava-11199532/1

    2023-08-03T11:22:37.278036  =


    2023-08-03T11:22:37.294983  / # /lava-11199532/bin/lava-test-runner /la=
va-11199532/1

    2023-08-03T11:22:37.353008  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-03T11:22:37.353510  + cd /lava-1119953<8>[   18.208894] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11199532_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

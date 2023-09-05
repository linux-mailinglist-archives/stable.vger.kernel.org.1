Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1284C79246D
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 17:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjIEP67 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 11:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243103AbjIEAjc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 20:39:32 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94702BF
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 17:39:27 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1c0fa9dd74fso1684449fac.3
        for <stable@vger.kernel.org>; Mon, 04 Sep 2023 17:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693874366; x=1694479166; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c+0sIlfARHoGuMVPVKFj2PCgkS4sU83R7z3SiyJPNY0=;
        b=azFwzgTwYNs2NurkCmPtIXAkZO9dbYRW0jvBM0NR5GmxIOTFNyQT5IoeoyJ3XILq0t
         clOxuEx9gWQ59dcrIQCYzFOWOrsWfk011B3ZHqN4DJKGDCR/U3KpO+SlRPSMtvYbYtiR
         1MD+tC7ZZB8di4Sg+fv95jVKQjhiGUEGo/ZHymmvaiVy5FSjT5t9RgrD0SgtpBfGfiN8
         dLECS0MVFtFFSQL1OKUL3Q5sF2PnONXxy07RaEmyB9RNHY14rCJ8Hr6LZDOVOPrifj09
         BhzYeviXb4+G5w6BxLQFeb7roiq9maGaJzbZydQuBu+nuXok9pMZJIVP1rc/58XXxq8J
         lb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693874366; x=1694479166;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+0sIlfARHoGuMVPVKFj2PCgkS4sU83R7z3SiyJPNY0=;
        b=QA34vEmd+Muivi6GaR7mpiMjJHNXmPJfATV+mZ3YOSpQUVBQDpThVitux4KGXhJIgB
         5Kfp8EQyL/LNMtXcC3kW5ivC2Cn7IgwRQ48wPKBLtHuFc30ucrwMDXzOIGXlp3pXP+hr
         xZtWEvA4z7d9uoMNOBfRZu1vYT72O8yMwgYewPaZXY4CC2fMnU2dXb7I0/717hrp5axR
         7Zmu5RnW/araRQ69oIylLHIhObpGlj0XUH22y+hGrTnJ58/ioc7FN8AfBNcE8jvYuq8O
         XmjXTiF0nJSzWwG3Bs/Ev10nMJHUMtt1LZ9X+LhDQN8TE6MbXGn2+vESjwPZEQcSA4uV
         0o+w==
X-Gm-Message-State: AOJu0Yw7bbWvMRYDxCL1FIYCjXSE0p6tj50x0GsovdNiL/zJAAAeTGWD
        2B7L6XbKV3HTPHw77LiixH6dSawezn/jw++rnys=
X-Google-Smtp-Source: AGHT+IFjR2xioUH7MivOd0qcSf8zk5HmMcQJnGD3ISyUCFQ3iEYxwIDth67LvKnj28gdnK7T05O+PQ==
X-Received: by 2002:a05:6870:80d1:b0:1b0:2f63:4ff6 with SMTP id r17-20020a05687080d100b001b02f634ff6mr14536477oab.1.1693874366416;
        Mon, 04 Sep 2023 17:39:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a3-20020aa78643000000b0068a2d78890csm7861465pfo.68.2023.09.04.17.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 17:39:25 -0700 (PDT)
Message-ID: <64f678bd.a70a0220.7a4e3.feef@mx.google.com>
Date:   Mon, 04 Sep 2023 17:39:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.130-29-gbec292fb85c5
Subject: stable-rc/linux-5.15.y baseline: 113 runs,
 11 regressions (v5.15.130-29-gbec292fb85c5)
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

stable-rc/linux-5.15.y baseline: 113 runs, 11 regressions (v5.15.130-29-gbe=
c292fb85c5)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =

cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =

fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.130-29-gbec292fb85c5/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.130-29-gbec292fb85c5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      bec292fb85c525832713d1aa73f07c39a477e2ab =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f6428bd689dc9596286db0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f6428bd689dc9596286db5
        failing since 159 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-04T20:48:51.019144  <8>[   10.857484] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11432049_1.4.2.3.1>

    2023-09-04T20:48:51.022279  + set +x

    2023-09-04T20:48:51.126353  / # #

    2023-09-04T20:48:51.226924  export SHELL=3D/bin/sh

    2023-09-04T20:48:51.227098  #

    2023-09-04T20:48:51.327602  / # export SHELL=3D/bin/sh. /lava-11432049/=
environment

    2023-09-04T20:48:51.327839  =


    2023-09-04T20:48:51.428327  / # . /lava-11432049/environment/lava-11432=
049/bin/lava-test-runner /lava-11432049/1

    2023-09-04T20:48:51.428621  =


    2023-09-04T20:48:51.434552  / # /lava-11432049/bin/lava-test-runner /la=
va-11432049/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f64269a24fb081cf286d95

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f64269a24fb081cf286d9a
        failing since 159 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-04T20:47:28.811175  <8>[   10.164282] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11432032_1.4.2.3.1>

    2023-09-04T20:47:28.814712  + set +x

    2023-09-04T20:47:28.915994  #

    2023-09-04T20:47:28.916235  =


    2023-09-04T20:47:29.016831  / # #export SHELL=3D/bin/sh

    2023-09-04T20:47:29.016994  =


    2023-09-04T20:47:29.117552  / # export SHELL=3D/bin/sh. /lava-11432032/=
environment

    2023-09-04T20:47:29.117719  =


    2023-09-04T20:47:29.218243  / # . /lava-11432032/environment/lava-11432=
032/bin/lava-test-runner /lava-11432032/1

    2023-09-04T20:47:29.218511  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f648c3cf462158c8286d89

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f648c3cf462158c8286=
d8a
        failing since 41 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f6450498deaa4461286d94

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f6450498deaa4461286d99
        failing since 230 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-09-04T20:58:31.066824  + set +x<8>[   10.017435] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3762919_1.5.2.4.1>
    2023-09-04T20:58:31.067521  =

    2023-09-04T20:58:31.177934  / # #
    2023-09-04T20:58:31.281313  export SHELL=3D/bin/sh
    2023-09-04T20:58:31.282162  #
    2023-09-04T20:58:31.384061  / # export SHELL=3D/bin/sh. /lava-3762919/e=
nvironment
    2023-09-04T20:58:31.385020  =

    2023-09-04T20:58:31.385574  / # <3>[   10.274179] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-09-04T20:58:31.487582  . /lava-3762919/environment/lava-3762919/bi=
n/lava-test-runner /lava-3762919/1
    2023-09-04T20:58:31.489122   =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f644b8368d3bf11a286e7c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f644b8368d3bf11a286e7f
        failing since 52 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-09-04T20:57:13.929076  + [   16.841332] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1249209_1.5.2.4.1>
    2023-09-04T20:57:13.929359  set +x
    2023-09-04T20:57:14.034394  =

    2023-09-04T20:57:14.135784  / # #export SHELL=3D/bin/sh
    2023-09-04T20:57:14.136329  =

    2023-09-04T20:57:14.237396  / # export SHELL=3D/bin/sh. /lava-1249209/e=
nvironment
    2023-09-04T20:57:14.237872  =

    2023-09-04T20:57:14.338903  / # . /lava-1249209/environment/lava-124920=
9/bin/lava-test-runner /lava-1249209/1
    2023-09-04T20:57:14.339691  =

    2023-09-04T20:57:14.342640  / # /lava-1249209/bin/lava-test-runner /lav=
a-1249209/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f6426d43b50db916286daa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f6426d43b50db916286daf
        failing since 159 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-04T20:47:20.783022  <8>[   10.237581] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11432027_1.4.2.3.1>

    2023-09-04T20:47:20.786676  + set +x

    2023-09-04T20:47:20.894962  / # #

    2023-09-04T20:47:20.997370  export SHELL=3D/bin/sh

    2023-09-04T20:47:20.998063  #

    2023-09-04T20:47:21.099555  / # export SHELL=3D/bin/sh. /lava-11432027/=
environment

    2023-09-04T20:47:21.100202  =


    2023-09-04T20:47:21.201551  / # . /lava-11432027/environment/lava-11432=
027/bin/lava-test-runner /lava-11432027/1

    2023-09-04T20:47:21.202792  =


    2023-09-04T20:47:21.207836  / # /lava-11432027/bin/lava-test-runner /la=
va-11432027/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f64284792ab16b98286d80

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f64284792ab16b98286d85
        failing since 159 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-04T20:47:47.684613  + set<8>[   11.534496] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11432023_1.4.2.3.1>

    2023-09-04T20:47:47.684696   +x

    2023-09-04T20:47:47.789168  / # #

    2023-09-04T20:47:47.889712  export SHELL=3D/bin/sh

    2023-09-04T20:47:47.889850  #

    2023-09-04T20:47:47.990362  / # export SHELL=3D/bin/sh. /lava-11432023/=
environment

    2023-09-04T20:47:47.990516  =


    2023-09-04T20:47:48.091038  / # . /lava-11432023/environment/lava-11432=
023/bin/lava-test-runner /lava-11432023/1

    2023-09-04T20:47:48.091262  =


    2023-09-04T20:47:48.095990  / # /lava-11432023/bin/lava-test-runner /la=
va-11432023/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f64270042c46df32286d7c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f64270042c46df32286d81
        failing since 159 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-04T20:47:31.077659  + <8>[   11.804356] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11432044_1.4.2.3.1>

    2023-09-04T20:47:31.078239  set +x

    2023-09-04T20:47:31.186166  / # #

    2023-09-04T20:47:31.288808  export SHELL=3D/bin/sh

    2023-09-04T20:47:31.289654  #

    2023-09-04T20:47:31.391276  / # export SHELL=3D/bin/sh. /lava-11432044/=
environment

    2023-09-04T20:47:31.392091  =


    2023-09-04T20:47:31.493974  / # . /lava-11432044/environment/lava-11432=
044/bin/lava-test-runner /lava-11432044/1

    2023-09-04T20:47:31.495220  =


    2023-09-04T20:47:31.500222  / # /lava-11432044/bin/lava-test-runner /la=
va-11432044/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f6445cdafc9be3ad286d7b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f6445cdafc9be3ad286d80
        failing since 47 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-04T20:57:25.147126  / # #

    2023-09-04T20:57:25.247682  export SHELL=3D/bin/sh

    2023-09-04T20:57:25.247843  #

    2023-09-04T20:57:25.348324  / # export SHELL=3D/bin/sh. /lava-11432140/=
environment

    2023-09-04T20:57:25.348462  =


    2023-09-04T20:57:25.448999  / # . /lava-11432140/environment/lava-11432=
140/bin/lava-test-runner /lava-11432140/1

    2023-09-04T20:57:25.449180  =


    2023-09-04T20:57:25.461035  / # /lava-11432140/bin/lava-test-runner /la=
va-11432140/1

    2023-09-04T20:57:25.514637  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-04T20:57:25.514725  + cd /lav<8>[   16.005370] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11432140_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f64488dafc9be3ad286db6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f64488dafc9be3ad286dbb
        failing since 47 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-04T20:56:45.455996  / # #

    2023-09-04T20:56:46.534865  export SHELL=3D/bin/sh

    2023-09-04T20:56:46.536629  #

    2023-09-04T20:56:48.026749  / # export SHELL=3D/bin/sh. /lava-11432141/=
environment

    2023-09-04T20:56:48.028502  =


    2023-09-04T20:56:50.750587  / # . /lava-11432141/environment/lava-11432=
141/bin/lava-test-runner /lava-11432141/1

    2023-09-04T20:56:50.752698  =


    2023-09-04T20:56:50.764716  / # /lava-11432141/bin/lava-test-runner /la=
va-11432141/1

    2023-09-04T20:56:50.823886  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-04T20:56:50.824421  + cd /lava-114321<8>[   25.552153] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11432141_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f64471dafc9be3ad286d8d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
30-29-gbec292fb85c5/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f64471dafc9be3ad286d92
        failing since 47 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-04T20:57:39.695706  / # #

    2023-09-04T20:57:39.797835  export SHELL=3D/bin/sh

    2023-09-04T20:57:39.798523  #

    2023-09-04T20:57:39.899498  / # export SHELL=3D/bin/sh. /lava-11432150/=
environment

    2023-09-04T20:57:39.899622  =


    2023-09-04T20:57:40.000118  / # . /lava-11432150/environment/lava-11432=
150/bin/lava-test-runner /lava-11432150/1

    2023-09-04T20:57:40.000372  =


    2023-09-04T20:57:40.002615  / # /lava-11432150/bin/lava-test-runner /la=
va-11432150/1

    2023-09-04T20:57:40.045084  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-04T20:57:40.076292  + cd /lava-1143215<8>[   16.782156] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11432150_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

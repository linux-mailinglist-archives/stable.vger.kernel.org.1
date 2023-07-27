Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3509765401
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 14:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjG0MdK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 08:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjG0Mc5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 08:32:57 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E899A0
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 05:32:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bb8e45185bso5496635ad.1
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690461173; x=1691065973;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8JF5aM4Drz/kYfxpDD5Va3HIR5qtzmCk1X+WRFOZiTc=;
        b=Gr1wZathVNcsOTMd3A+7SPVMnJdhEad/rJHBwmVSfEbm2NlqEnOzWumOIXySyPrcen
         uXvFYAfQRzLcA6QaVSkxD1gDd5skAcBg4f3ny4kGpL2Pp2wPwbWrtY5agTOV2Gt8sOHF
         5UGeLz/H3brj4DgaSUrEab1Iqqkcp9SEIw+i33XPbZCAvkVI9B6OorC7NZGmFrdgSbtb
         OO4DiZBSRge/d/8bZaLRw8Es9x2lmsDEeDuhHIZzt1IYP+dMbwMs+p7+8v4pH2lqiSOD
         WoyA50lvdw91MkG7gDZYOcPCvnNuqUPWD6yPZd38MRC8TT0xXMvPYufYcXBmOWR7goZ4
         0n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690461173; x=1691065973;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JF5aM4Drz/kYfxpDD5Va3HIR5qtzmCk1X+WRFOZiTc=;
        b=jn7xRQmvClymKo1lSv0KW27XHj9aBw0Xvk4lSqkhYWs4T3nmn8WFqbkjstQStsnnqR
         DldrSIrE6L3PJGPDHJm0Y1SVRMXCt/bqNuK8F8Fy86ZR5dN/zC2YiRDxw8QNnwWGHoP2
         87n4gP7OOiI5DilCzCxe7ucmO+tpIChH/lclmoaykuy1vhwQUQiY2Ms00xm1wR9jzTXb
         RxQPlfWjVx2e/pV/C4n8Osvf6mEHfeuNem5e0YGRNd66rKgWqfND2eo33bzwgtLuvS1P
         WT0Cg2zMyqkHVvhf762omXb9TNwoRxolsMm1xC77vyNQgZy6xJ3A1zDVsn1ia7UQHGLV
         zViA==
X-Gm-Message-State: ABy/qLabFMRN046c9bRCii3Ud/oKKnqbOirWk+FzFsRsAAnRdwhkKUIg
        mjFBL3uOoOE1tBSw/4ajzGAV3Ftd5mmuqxZDR0zhjA==
X-Google-Smtp-Source: APBJJlGq66KLfVJUyF7csOsL33wj8hEOWzIDK67k2Dx23qv2TAUWJRlGjLaKjCiAxQDgoOOgeH+fFw==
X-Received: by 2002:a17:903:22d0:b0:1b9:c207:1802 with SMTP id y16-20020a17090322d000b001b9c2071802mr4912866plg.0.1690461173187;
        Thu, 27 Jul 2023 05:32:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jg19-20020a17090326d300b001b8013ed362sm1529978plb.96.2023.07.27.05.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:32:52 -0700 (PDT)
Message-ID: <64c263f4.170a0220.f658a.25be@mx.google.com>
Date:   Thu, 27 Jul 2023 05:32:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.42
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 98 runs, 10 regressions (v6.1.42)
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

stable-rc/linux-6.1.y baseline: 98 runs, 10 regressions (v6.1.42)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.42/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.42
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d2a6dc4eaf6d50ba32a9b39b4c6ec713a92072ab =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22d183de8e17bb88ace71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c22d183de8e17bb88ac=
e72
        new failure (last pass: v6.1.41-184-gb3f8a9d2b1371) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22c218008fbf5bb8ace52

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c22c228008fbf5bb8ace57
        failing since 118 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-27T08:34:54.045022  + set +x

    2023-07-27T08:34:54.051744  <8>[   11.104802] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11149670_1.4.2.3.1>

    2023-07-27T08:34:54.153372  #

    2023-07-27T08:34:54.153599  =


    2023-07-27T08:34:54.254119  / # #export SHELL=3D/bin/sh

    2023-07-27T08:34:54.254297  =


    2023-07-27T08:34:54.354752  / # export SHELL=3D/bin/sh. /lava-11149670/=
environment

    2023-07-27T08:34:54.354917  =


    2023-07-27T08:34:54.455387  / # . /lava-11149670/environment/lava-11149=
670/bin/lava-test-runner /lava-11149670/1

    2023-07-27T08:34:54.455647  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22c1001d34675478ace41

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c22c1001d34675478ace46
        failing since 118 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-27T08:34:16.326058  + set<8>[   11.586353] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11149662_1.4.2.3.1>

    2023-07-27T08:34:16.326141   +x

    2023-07-27T08:34:16.430377  / # #

    2023-07-27T08:34:16.531111  export SHELL=3D/bin/sh

    2023-07-27T08:34:16.531339  #

    2023-07-27T08:34:16.631907  / # export SHELL=3D/bin/sh. /lava-11149662/=
environment

    2023-07-27T08:34:16.632161  =


    2023-07-27T08:34:16.732721  / # . /lava-11149662/environment/lava-11149=
662/bin/lava-test-runner /lava-11149662/1

    2023-07-27T08:34:16.733053  =


    2023-07-27T08:34:16.737374  / # /lava-11149662/bin/lava-test-runner /la=
va-11149662/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22c1c01d34675478ace4e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c22c1c01d34675478ace53
        failing since 118 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-27T08:34:21.156885  <8>[   10.117462] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11149663_1.4.2.3.1>

    2023-07-27T08:34:21.160266  + set +x

    2023-07-27T08:34:21.265563  #

    2023-07-27T08:34:21.266862  =


    2023-07-27T08:34:21.368763  / # #export SHELL=3D/bin/sh

    2023-07-27T08:34:21.369567  =


    2023-07-27T08:34:21.471164  / # export SHELL=3D/bin/sh. /lava-11149663/=
environment

    2023-07-27T08:34:21.472196  =


    2023-07-27T08:34:21.574153  / # . /lava-11149663/environment/lava-11149=
663/bin/lava-test-runner /lava-11149663/1

    2023-07-27T08:34:21.575672  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22c10fb90f50be18ace36

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c22c10fb90f50be18ace3b
        failing since 118 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-27T08:34:40.935723  + set +x

    2023-07-27T08:34:40.942310  <8>[   10.760524] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11149690_1.4.2.3.1>

    2023-07-27T08:34:41.046240  / # #

    2023-07-27T08:34:41.146789  export SHELL=3D/bin/sh

    2023-07-27T08:34:41.146963  #

    2023-07-27T08:34:41.247476  / # export SHELL=3D/bin/sh. /lava-11149690/=
environment

    2023-07-27T08:34:41.247687  =


    2023-07-27T08:34:41.348240  / # . /lava-11149690/environment/lava-11149=
690/bin/lava-test-runner /lava-11149690/1

    2023-07-27T08:34:41.348713  =


    2023-07-27T08:34:41.353710  / # /lava-11149690/bin/lava-test-runner /la=
va-11149690/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22d203de8e17bb88ace76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c22d203de8e17bb88ac=
e77
        new failure (last pass: v6.1.41-184-gb3f8a9d2b1371) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22c08fb90f50be18ace1c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c22c08fb90f50be18ace21
        failing since 118 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-27T08:34:02.018442  + <8>[   11.320112] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11149652_1.4.2.3.1>

    2023-07-27T08:34:02.018941  set +x

    2023-07-27T08:34:02.125985  / # #

    2023-07-27T08:34:02.228484  export SHELL=3D/bin/sh

    2023-07-27T08:34:02.229248  #

    2023-07-27T08:34:02.330803  / # export SHELL=3D/bin/sh. /lava-11149652/=
environment

    2023-07-27T08:34:02.331608  =


    2023-07-27T08:34:02.433143  / # . /lava-11149652/environment/lava-11149=
652/bin/lava-test-runner /lava-11149652/1

    2023-07-27T08:34:02.434345  =


    2023-07-27T08:34:02.439659  / # /lava-11149652/bin/lava-test-runner /la=
va-11149652/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22bff5d0167e5bf8ace9a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c22bff5d0167e5bf8ace9f
        failing since 118 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-27T08:34:02.373802  <8>[   11.904667] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11149666_1.4.2.3.1>

    2023-07-27T08:34:02.481537  / # #

    2023-07-27T08:34:02.583937  export SHELL=3D/bin/sh

    2023-07-27T08:34:02.584719  #

    2023-07-27T08:34:02.686346  / # export SHELL=3D/bin/sh. /lava-11149666/=
environment

    2023-07-27T08:34:02.687126  =


    2023-07-27T08:34:02.788765  / # . /lava-11149666/environment/lava-11149=
666/bin/lava-test-runner /lava-11149666/1

    2023-07-27T08:34:02.790035  =


    2023-07-27T08:34:02.795230  / # /lava-11149666/bin/lava-test-runner /la=
va-11149666/1

    2023-07-27T08:34:02.801928  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22ea78c4bbd313b8acf4f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c22ea78c4bbd313b8acf54
        failing since 9 days (last pass: v6.1.38-393-gb6386e7314b4, first f=
ail: v6.1.38-590-gce7ec1011187)

    2023-07-27T08:45:30.828077  / # #

    2023-07-27T08:45:31.904225  export SHELL=3D/bin/sh

    2023-07-27T08:45:31.905518  #

    2023-07-27T08:45:33.388158  / # export SHELL=3D/bin/sh. /lava-11149735/=
environment

    2023-07-27T08:45:33.389844  =


    2023-07-27T08:45:36.107341  / # . /lava-11149735/environment/lava-11149=
735/bin/lava-test-runner /lava-11149735/1

    2023-07-27T08:45:36.109467  =


    2023-07-27T08:45:36.121110  / # /lava-11149735/bin/lava-test-runner /la=
va-11149735/1

    2023-07-27T08:45:36.180192  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T08:45:36.180690  + cd /lava-111497<8>[   28.433906] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11149735_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c22e818c4bbd313b8ace40

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c22e818c4bbd313b8ace45
        failing since 9 days (last pass: v6.1.38-393-gb6386e7314b4, first f=
ail: v6.1.38-590-gce7ec1011187)

    2023-07-27T08:46:19.483659  / # #

    2023-07-27T08:46:19.585823  export SHELL=3D/bin/sh

    2023-07-27T08:46:19.586494  #

    2023-07-27T08:46:19.687539  / # export SHELL=3D/bin/sh. /lava-11149727/=
environment

    2023-07-27T08:46:19.688138  =


    2023-07-27T08:46:19.789297  / # . /lava-11149727/environment/lava-11149=
727/bin/lava-test-runner /lava-11149727/1

    2023-07-27T08:46:19.790136  =


    2023-07-27T08:46:19.791702  / # /lava-11149727/bin/lava-test-runner /la=
va-11149727/1

    2023-07-27T08:46:19.873823  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T08:46:19.874275  + cd /lava-1114972<8>[   16.977056] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11149727_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

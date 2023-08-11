Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27A67797DB
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 21:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjHKTio (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 15:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjHKTin (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 15:38:43 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FF730E6
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 12:38:42 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bc34b32785so17347515ad.3
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691782721; x=1692387521;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JCPJYvRggexO5yj88redswk7mVXnwNvA6POF0ob6fpA=;
        b=lQY6C2wzsIPvYHzkcvM/srU3eCslnRLPe+A2RMrm4f7mzuWg+gTzCMlKOXtuWB5sH6
         CG/El9kdPAK8M0jdZ11bswR//Ch0+LPvCXhFvTJIuCF0shDbWFfm9gH1R+4D9KJ+hFBE
         Zu+89SyYu+SAtAcoqkQ0g68264RnBQZvt5KCeLXdqZNcRku6Y8ChNKY5IQ6pWqvN1EBO
         GoCn5/g6OGpyppZ8Wk5THlk7/IdISm9ES74RPqtRSZuo+J+B1hX3WAx7+2RhzQ47lBLU
         QkmV3PdF/Z4p3Ojw2rP58Dey7/Yc9+Gkx6zRMs6pRHZPWkXuK/fQfVsKMLK64Z5YF11I
         wgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691782721; x=1692387521;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCPJYvRggexO5yj88redswk7mVXnwNvA6POF0ob6fpA=;
        b=Opkmme7NGck51M97WUQseR4QBrk5bOPdQ6vLzxYdR6apwEFk/n6ofBNAqFFFsbMZzQ
         y0StcW0ZEGPnCltEVDlMmVk0ms0sTdx+tSOIHhgjBukZJk6JfConjR2mKKjqK4gUxiPK
         SxnpbgoOpyoPB8BAhVVSbvllG0FbJv9pgaGPXe3B9uEaiw+LCnhrdDknfEScZ3z/7h8S
         qS3xtnVV6XsXufTK5bzfhcFBQRScbuZ7TVeioHgQBsjN3VkAO/e1N/mUC993yBZv4TnB
         WpzLOmop0O8+lwKH0goTfUFkmq4G7oWxRTHQaDqRo9YbqV5QwnRbeVRTmvp8x1altoyv
         t1IA==
X-Gm-Message-State: AOJu0YxDCODCHJWPjuzYNbpPYJgcxuftr/FPeoU8UdBgi9HgyGtfkZ+x
        2sC3s6gU5SkNWqWHHI0CthZCGZ6ovdhb4i+ZTcjR5w==
X-Google-Smtp-Source: AGHT+IH5MhE3nZqqAWk7bW+kxPhlJRcCmPHSpmFXbt1m+NABBsewJx+WIRY1BJq01in2Pf/VI8wAlA==
X-Received: by 2002:a17:902:f7ce:b0:1bd:b05c:c752 with SMTP id h14-20020a170902f7ce00b001bdb05cc752mr2546994plw.26.1691782721340;
        Fri, 11 Aug 2023 12:38:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902be0a00b001bbab888ba0sm4285911pls.138.2023.08.11.12.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 12:38:40 -0700 (PDT)
Message-ID: <64d68e40.170a0220.c0b15.89fb@mx.google.com>
Date:   Fri, 11 Aug 2023 12:38:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.126
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
Subject: stable-rc/linux-5.15.y baseline: 121 runs, 11 regressions (v5.15.126)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 121 runs, 11 regressions (v5.15.126)

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

fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.126/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.126
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      24c4de4069cbce796a1c71166240807d617cd652 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d65bc3d0c2c47ee635b1e2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d65bc3d0c2c47ee635b1e7
        failing since 135 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-11T16:02:58.065319  + set +x

    2023-08-11T16:02:58.072561  <8>[   10.831938] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11265104_1.4.2.3.1>

    2023-08-11T16:02:58.181208  =


    2023-08-11T16:02:58.283218  / # #export SHELL=3D/bin/sh

    2023-08-11T16:02:58.284061  =


    2023-08-11T16:02:58.385663  / # export SHELL=3D/bin/sh. /lava-11265104/=
environment

    2023-08-11T16:02:58.386465  =


    2023-08-11T16:02:58.488404  / # . /lava-11265104/environment/lava-11265=
104/bin/lava-test-runner /lava-11265104/1

    2023-08-11T16:02:58.489636  =


    2023-08-11T16:02:58.495599  / # /lava-11265104/bin/lava-test-runner /la=
va-11265104/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d65a82c2be62837a35b1eb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d65a82c2be62837a35b1f0
        failing since 135 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-11T15:57:36.228726  <8>[   10.643314] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11265093_1.4.2.3.1>

    2023-08-11T15:57:36.231873  + set +x

    2023-08-11T15:57:36.337011  #

    2023-08-11T15:57:36.337908  =


    2023-08-11T15:57:36.439181  / # #export SHELL=3D/bin/sh

    2023-08-11T15:57:36.439912  =


    2023-08-11T15:57:36.541293  / # export SHELL=3D/bin/sh. /lava-11265093/=
environment

    2023-08-11T15:57:36.541995  =


    2023-08-11T15:57:36.643410  / # . /lava-11265093/environment/lava-11265=
093/bin/lava-test-runner /lava-11265093/1

    2023-08-11T15:57:36.644655  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d65cab8bf0949e9335b2a4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d65cab8bf0949e9335b=
2a5
        failing since 17 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
cubietruck                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d65db0b45883686135b273

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d65db0b45883686135b278
        failing since 206 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-08-11T16:11:05.752953  + set +x
    2023-08-11T16:11:05.761713  <8>[   10.056797] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3737538_1.5.2.4.1>
    2023-08-11T16:11:05.865741  / # #
    2023-08-11T16:11:05.967472  export SHELL=3D/bin/sh
    2023-08-11T16:11:05.968399  #
    2023-08-11T16:11:06.070963  / # export SHELL=3D/bin/sh. /lava-3737538/e=
nvironment
    2023-08-11T16:11:06.072066  =

    2023-08-11T16:11:06.072540  / # . /lava-3737538/environment<3>[   10.35=
3920] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-08-11T16:11:06.174306  /lava-3737538/bin/lava-test-runner /lava-37=
37538/1
    2023-08-11T16:11:06.174796   =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64d65c3bd433a549bd35b21b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d65c3bd433a549bd35b21e
        failing since 28 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-08-11T16:05:00.018359  + [   10.636395] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1242935_1.5.2.4.1>
    2023-08-11T16:05:00.018723  set +x
    2023-08-11T16:05:00.123750  =

    2023-08-11T16:05:00.224701  / # #export SHELL=3D/bin/sh
    2023-08-11T16:05:00.225123  =

    2023-08-11T16:05:00.326080  / # export SHELL=3D/bin/sh. /lava-1242935/e=
nvironment
    2023-08-11T16:05:00.326543  =

    2023-08-11T16:05:00.427495  / # . /lava-1242935/environment/lava-124293=
5/bin/lava-test-runner /lava-1242935/1
    2023-08-11T16:05:00.428139  =

    2023-08-11T16:05:00.431312  / # /lava-1242935/bin/lava-test-runner /lav=
a-1242935/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64d65c519bdf6f5aa635b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d65c519bdf6f5aa635b1dd
        failing since 160 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-08-11T16:05:09.757357  [   10.477508] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242934_1.5.2.4.1>
    2023-08-11T16:05:09.862558  =

    2023-08-11T16:05:09.963736  / # #export SHELL=3D/bin/sh
    2023-08-11T16:05:09.964131  =

    2023-08-11T16:05:10.065063  / # export SHELL=3D/bin/sh. /lava-1242934/e=
nvironment
    2023-08-11T16:05:10.065458  =

    2023-08-11T16:05:10.166415  / # . /lava-1242934/environment/lava-124293=
4/bin/lava-test-runner /lava-1242934/1
    2023-08-11T16:05:10.167070  =

    2023-08-11T16:05:10.171022  / # /lava-1242934/bin/lava-test-runner /lav=
a-1242934/1
    2023-08-11T16:05:10.183919  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d65aa464044c46aa35b221

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d65aa464044c46aa35b226
        failing since 135 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-11T15:58:08.787366  + set +x

    2023-08-11T15:58:08.794025  <8>[   10.528535] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11265083_1.4.2.3.1>

    2023-08-11T15:58:08.898920  / # #

    2023-08-11T15:58:09.001082  export SHELL=3D/bin/sh

    2023-08-11T15:58:09.001637  #

    2023-08-11T15:58:09.102818  / # export SHELL=3D/bin/sh. /lava-11265083/=
environment

    2023-08-11T15:58:09.103394  =


    2023-08-11T15:58:09.204521  / # . /lava-11265083/environment/lava-11265=
083/bin/lava-test-runner /lava-11265083/1

    2023-08-11T15:58:09.205453  =


    2023-08-11T15:58:09.211201  / # /lava-11265083/bin/lava-test-runner /la=
va-11265083/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d65aa1c2be62837a35b229

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d65aa1c2be62837a35b22e
        failing since 135 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-11T15:58:07.980333  + <8>[   11.319520] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11265112_1.4.2.3.1>

    2023-08-11T15:58:07.980895  set +x

    2023-08-11T15:58:08.089322  / # #

    2023-08-11T15:58:08.192138  export SHELL=3D/bin/sh

    2023-08-11T15:58:08.192989  #

    2023-08-11T15:58:08.294682  / # export SHELL=3D/bin/sh. /lava-11265112/=
environment

    2023-08-11T15:58:08.295674  =


    2023-08-11T15:58:08.397314  / # . /lava-11265112/environment/lava-11265=
112/bin/lava-test-runner /lava-11265112/1

    2023-08-11T15:58:08.398828  =


    2023-08-11T15:58:08.403119  / # /lava-11265112/bin/lava-test-runner /la=
va-11265112/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d65a7164044c46aa35b1e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d65a7164044c46aa35b1ed
        failing since 135 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-11T15:57:21.891713  + set<8>[   11.878182] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11265077_1.4.2.3.1>

    2023-08-11T15:57:21.892182   +x

    2023-08-11T15:57:21.999832  / # #

    2023-08-11T15:57:22.102253  export SHELL=3D/bin/sh

    2023-08-11T15:57:22.102986  #

    2023-08-11T15:57:22.204410  / # export SHELL=3D/bin/sh. /lava-11265077/=
environment

    2023-08-11T15:57:22.205243  =


    2023-08-11T15:57:22.306771  / # . /lava-11265077/environment/lava-11265=
077/bin/lava-test-runner /lava-11265077/1

    2023-08-11T15:57:22.308142  =


    2023-08-11T15:57:22.313349  / # /lava-11265077/bin/lava-test-runner /la=
va-11265077/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64d65bd0df1cefb4a635b201

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d65bd0df1cefb4a635b206
        failing since 22 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-11T16:04:47.900166  / # #

    2023-08-11T16:04:48.000604  export SHELL=3D/bin/sh

    2023-08-11T16:04:48.000696  #

    2023-08-11T16:04:48.101091  / # export SHELL=3D/bin/sh. /lava-11265219/=
environment

    2023-08-11T16:04:48.101193  =


    2023-08-11T16:04:48.201591  / # . /lava-11265219/environment/lava-11265=
219/bin/lava-test-runner /lava-11265219/1

    2023-08-11T16:04:48.201754  =


    2023-08-11T16:04:48.213834  / # /lava-11265219/bin/lava-test-runner /la=
va-11265219/1

    2023-08-11T16:04:48.267655  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T16:04:48.267722  + cd /lav<8>[   16.018015] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11265219_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64d65bf4cd1041e34b35b2b9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
26/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d65bf4cd1041e34b35b2be
        failing since 22 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-11T16:04:20.611643  / # #

    2023-08-11T16:04:21.691080  export SHELL=3D/bin/sh

    2023-08-11T16:04:21.693044  #

    2023-08-11T16:04:23.183626  / # export SHELL=3D/bin/sh. /lava-11265221/=
environment

    2023-08-11T16:04:23.185407  =


    2023-08-11T16:04:25.910089  / # . /lava-11265221/environment/lava-11265=
221/bin/lava-test-runner /lava-11265221/1

    2023-08-11T16:04:25.912464  =


    2023-08-11T16:04:25.919540  / # /lava-11265221/bin/lava-test-runner /la=
va-11265221/1

    2023-08-11T16:04:25.983735  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T16:04:25.984246  + cd /lav<8>[   25.504991] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11265221_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =20

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278B978B321
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 16:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjH1O2e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 10:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjH1O2E (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 10:28:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FDC115
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 07:27:55 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a440a8a20so2857553b3a.3
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693232874; x=1693837674;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hgRDFhWCT3K2EQLT/CdwrCR+YT/Zm0N0RyYe5qOGsAc=;
        b=2VXlaFC1hapyePFq9AXGA6MY2rvnGomaMT/uTKbP3iEL/pzgrhqAxbUhAIi4Kn2d1u
         3vxKvsr2TqbNfoB24RLMqgY0XwWFrRIPjeaexfKMOWbl3mcPFSNzoPrDlnaTLA1dgOPG
         k+PoPndF2E12+9r/Mzu9PCJtOaubrTG/WLwsgw2/YVMgpp3J8Lwp5RdWUTIkDY+6TREa
         ak/PWxycF6VPHVa4KHE+/PyneqddA9VfMoWoPAQ7BeqoutlBepA4mJ1F9UHqVLY4UKwY
         Z0FCBrkiisG1/wiGOTROpg555xufk2CCmSFWTn8M584cdK3KtVj9v8KEN3YXaVUM9dPC
         jJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693232874; x=1693837674;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgRDFhWCT3K2EQLT/CdwrCR+YT/Zm0N0RyYe5qOGsAc=;
        b=RMBqwGhuo/JhHB+HY0MYL2DT+dCDXcssmE8qQFMwWiUkpjO735OMdf6kRzKz9yOypf
         AZoJ8y7Hzv0Uk5drUrCp8peVqNjmmmyl4pLTudwqxMLAmWE8BXCj179QpWvVkOckKymR
         nCNOmswAmG2ECm8RE6oZcvAjrgyCms/6YN+zfTC64fePE7njyh4x1i1tqz7acV1wXf5p
         /IH7Ui3pZQXEu1DMDL2LHReoIPTN8VUq432Nj8LZgmVANVqL3SKdcAJs0bsatIR1aYBZ
         XppWFZt+8Ns9HDuuVv7uat9Z5so6PMZwrpUtWMv8F9VDlB34rNTC63Tnt/v2hEHqvP/K
         FoAw==
X-Gm-Message-State: AOJu0YxLVEtwwseTHg+wviNhqXTWKDQ3q3JdYLJiIt453dqyZ5vaNJta
        1hxlY7SyBuG007ZFiQALgAWt5ENtiWTIJYKOVo8=
X-Google-Smtp-Source: AGHT+IEfCSNm/3ciyYSjayuBdMVXvydUYH4VNU9R9Jl8grV0RzVgE8ziVbhBKTaBlYIBL79OwlTFWA==
X-Received: by 2002:a05:6a21:819e:b0:14c:d105:2d16 with SMTP id pd30-20020a056a21819e00b0014cd1052d16mr6922006pzb.32.1693232874119;
        Mon, 28 Aug 2023 07:27:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902db0600b001b8b2b95068sm7447870plx.204.2023.08.28.07.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:27:53 -0700 (PDT)
Message-ID: <64ecaee9.170a0220.1f356.b6f5@mx.google.com>
Date:   Mon, 28 Aug 2023 07:27:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.128-90-g948d61e1588b9
Subject: stable-rc/linux-5.15.y baseline: 121 runs,
 12 regressions (v5.15.128-90-g948d61e1588b9)
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

stable-rc/linux-5.15.y baseline: 121 runs, 12 regressions (v5.15.128-90-g94=
8d61e1588b9)

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

fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

kontron-pitx-imx8m        | arm64  | lab-kontron   | gcc-10   | defconfig  =
                  | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.128-90-g948d61e1588b9/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.128-90-g948d61e1588b9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      948d61e1588b9442fe7390e694431478159553bc =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7be12db5a548e3286dc8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7be12db5a548e3286dd1
        failing since 152 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-28T10:49:44.630190  <8>[   10.669411] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11371270_1.4.2.3.1>

    2023-08-28T10:49:44.633180  + set +x

    2023-08-28T10:49:44.737213  / # #

    2023-08-28T10:49:44.837737  export SHELL=3D/bin/sh

    2023-08-28T10:49:44.837924  #

    2023-08-28T10:49:44.938386  / # export SHELL=3D/bin/sh. /lava-11371270/=
environment

    2023-08-28T10:49:44.938582  =


    2023-08-28T10:49:45.039085  / # . /lava-11371270/environment/lava-11371=
270/bin/lava-test-runner /lava-11371270/1

    2023-08-28T10:49:45.039337  =


    2023-08-28T10:49:45.044651  / # /lava-11371270/bin/lava-test-runner /la=
va-11371270/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7bcfd9853a03e5286de4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7bcfd9853a03e5286ded
        failing since 152 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-28T10:49:31.552031  <8>[   10.417776] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11371233_1.4.2.3.1>

    2023-08-28T10:49:31.555645  + set +x

    2023-08-28T10:49:31.657025  =


    2023-08-28T10:49:31.757625  / # #export SHELL=3D/bin/sh

    2023-08-28T10:49:31.757798  =


    2023-08-28T10:49:31.858329  / # export SHELL=3D/bin/sh. /lava-11371233/=
environment

    2023-08-28T10:49:31.858514  =


    2023-08-28T10:49:31.959067  / # . /lava-11371233/environment/lava-11371=
233/bin/lava-test-runner /lava-11371233/1

    2023-08-28T10:49:31.959340  =


    2023-08-28T10:49:31.964401  / # /lava-11371233/bin/lava-test-runner /la=
va-11371233/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7e4fea3ca4fe35286de2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ec7e4fea3ca4fe35286=
de3
        failing since 33 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7e82cd205d2947286e54

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7e82cd205d2947286e57
        failing since 45 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-08-28T11:01:00.053790  [   11.041994] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1247155_1.5.2.4.1>
    2023-08-28T11:01:00.159465  =

    2023-08-28T11:01:00.260640  / # #export SHELL=3D/bin/sh
    2023-08-28T11:01:00.261069  =

    2023-08-28T11:01:00.362011  / # export SHELL=3D/bin/sh. /lava-1247155/e=
nvironment
    2023-08-28T11:01:00.362388  =

    2023-08-28T11:01:00.463230  / # . /lava-1247155/environment/lava-124715=
5/bin/lava-test-runner /lava-1247155/1
    2023-08-28T11:01:00.464045  =

    2023-08-28T11:01:00.468467  / # /lava-1247155/bin/lava-test-runner /lav=
a-1247155/1
    2023-08-28T11:01:00.483694  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-lx2160a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7e9b0ffbb048aa286dbf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7e9b0ffbb048aa286dc2
        failing since 177 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-08-28T11:01:25.203589  [   10.932593] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1247154_1.5.2.4.1>
    2023-08-28T11:01:25.309823  / # #
    2023-08-28T11:01:25.411650  export SHELL=3D/bin/sh
    2023-08-28T11:01:25.412155  #
    2023-08-28T11:01:25.513325  / # export SHELL=3D/bin/sh. /lava-1247154/e=
nvironment
    2023-08-28T11:01:25.513772  =

    2023-08-28T11:01:25.614839  / # . /lava-1247154/environment/lava-124715=
4/bin/lava-test-runner /lava-1247154/1
    2023-08-28T11:01:25.615943  =

    2023-08-28T11:01:25.619310  / # /lava-1247154/bin/lava-test-runner /lav=
a-1247154/1
    2023-08-28T11:01:25.635433  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7bcdd9853a03e5286dd9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7bcdd9853a03e5286de2
        failing since 152 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-28T10:50:40.793715  + set +x

    2023-08-28T10:50:40.800272  <8>[   10.245410] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11371268_1.4.2.3.1>

    2023-08-28T10:50:40.901901  #

    2023-08-28T10:50:40.902151  =


    2023-08-28T10:50:41.002819  / # #export SHELL=3D/bin/sh

    2023-08-28T10:50:41.002997  =


    2023-08-28T10:50:41.103499  / # export SHELL=3D/bin/sh. /lava-11371268/=
environment

    2023-08-28T10:50:41.103707  =


    2023-08-28T10:50:41.204209  / # . /lava-11371268/environment/lava-11371=
268/bin/lava-test-runner /lava-11371268/1

    2023-08-28T10:50:41.204498  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7bdd2db5a548e3286db0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7bdd2db5a548e3286db9
        failing since 152 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-28T10:49:51.317375  + <8>[   10.652434] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11371262_1.4.2.3.1>

    2023-08-28T10:49:51.317946  set +x

    2023-08-28T10:49:51.425815  / # #

    2023-08-28T10:49:51.528600  export SHELL=3D/bin/sh

    2023-08-28T10:49:51.529364  #

    2023-08-28T10:49:51.630870  / # export SHELL=3D/bin/sh. /lava-11371262/=
environment

    2023-08-28T10:49:51.631666  =


    2023-08-28T10:49:51.733368  / # . /lava-11371262/environment/lava-11371=
262/bin/lava-test-runner /lava-11371262/1

    2023-08-28T10:49:51.734691  =


    2023-08-28T10:49:51.740214  / # /lava-11371262/bin/lava-test-runner /la=
va-11371262/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
kontron-pitx-imx8m        | arm64  | lab-kontron   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7f022c873b0238286d79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ec7f022c873b0238286=
d7a
        new failure (last pass: v5.15.128-91-g59406ae6f227c) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7bd2d9853a03e5286e13

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7bd2d9853a03e5286e1c
        failing since 152 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-08-28T10:49:41.830745  + set +x<8>[   12.508868] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11371249_1.4.2.3.1>

    2023-08-28T10:49:41.830833  =


    2023-08-28T10:49:41.935371  / # #

    2023-08-28T10:49:42.035980  export SHELL=3D/bin/sh

    2023-08-28T10:49:42.036141  #

    2023-08-28T10:49:42.136642  / # export SHELL=3D/bin/sh. /lava-11371249/=
environment

    2023-08-28T10:49:42.136818  =


    2023-08-28T10:49:42.237355  / # . /lava-11371249/environment/lava-11371=
249/bin/lava-test-runner /lava-11371249/1

    2023-08-28T10:49:42.237709  =


    2023-08-28T10:49:42.242411  / # /lava-11371249/bin/lava-test-runner /la=
va-11371249/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec95942fac7e3bbf286d77

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec95942fac7e3bbf286d80
        failing since 39 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-28T12:41:02.976020  / # #

    2023-08-28T12:41:03.078292  export SHELL=3D/bin/sh

    2023-08-28T12:41:03.079027  #

    2023-08-28T12:41:03.180481  / # export SHELL=3D/bin/sh. /lava-11371366/=
environment

    2023-08-28T12:41:03.181275  =


    2023-08-28T12:41:03.282782  / # . /lava-11371366/environment/lava-11371=
366/bin/lava-test-runner /lava-11371366/1

    2023-08-28T12:41:03.283959  =


    2023-08-28T12:41:03.300372  / # /lava-11371366/bin/lava-test-runner /la=
va-11371366/1

    2023-08-28T12:41:03.349509  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T12:41:03.349985  + cd /lav<8>[   16.032201] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11371366_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7e317aa2cb0ff1286db3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7e317aa2cb0ff1286dbc
        failing since 39 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-28T11:00:50.610065  / # #

    2023-08-28T11:00:51.690838  export SHELL=3D/bin/sh

    2023-08-28T11:00:51.692645  #

    2023-08-28T11:00:53.183344  / # export SHELL=3D/bin/sh. /lava-11371375/=
environment

    2023-08-28T11:00:53.185313  =


    2023-08-28T11:00:55.910641  / # . /lava-11371375/environment/lava-11371=
375/bin/lava-test-runner /lava-11371375/1

    2023-08-28T11:00:55.913050  =


    2023-08-28T11:00:55.916370  / # /lava-11371375/bin/lava-test-runner /la=
va-11371375/1

    2023-08-28T11:00:55.984623  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T11:00:55.985123  + cd /lava-113713<8>[   25.570943] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11371375_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ec7dfb93ed6b94ef286d76

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
28-90-g948d61e1588b9/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ec7dfb93ed6b94ef286d7f
        failing since 39 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-28T11:00:41.149854  / # #

    2023-08-28T11:00:41.252009  export SHELL=3D/bin/sh

    2023-08-28T11:00:41.252665  #

    2023-08-28T11:00:41.353911  / # export SHELL=3D/bin/sh. /lava-11371364/=
environment

    2023-08-28T11:00:41.354599  =


    2023-08-28T11:00:41.455956  / # . /lava-11371364/environment/lava-11371=
364/bin/lava-test-runner /lava-11371364/1

    2023-08-28T11:00:41.457116  =


    2023-08-28T11:00:41.473608  / # /lava-11371364/bin/lava-test-runner /la=
va-11371364/1

    2023-08-28T11:00:41.531648  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T11:00:41.532121  + cd /lava-1137136<8>[   16.964206] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11371364_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

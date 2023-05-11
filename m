Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC7A6FF6EA
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 18:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbjEKQQ6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 12:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbjEKQQ5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 12:16:57 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD7930CA
        for <stable@vger.kernel.org>; Thu, 11 May 2023 09:16:47 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b33c72686so5902920a12.1
        for <stable@vger.kernel.org>; Thu, 11 May 2023 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683821806; x=1686413806;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UvFLGyCetB7gpH35C1TpsSdl41A7xRopdOuxPt5k8CM=;
        b=QoXY6nn5gVMUl1Xxw/8HrvYPDmSotqrOHDQGkSEGp2XCybKX7sX9Td4SUrOj1yGsaf
         dEjI4clEFEK/ohmIjWXfuVuDrnIHijpgcCxWYjI2u6a6ir//vuw+GrA8lVS2Naqe+cy0
         bBWmmluZ0VHMIb3dQrc0ktEco+SBO58+aoTMZQsSsITGdf8yHw1m2s2sN3wU2AnZegN4
         32jFthNzyCaeWv8SvbMZPo0v5JVnhl5hTfzAXYk0NulibiWAF9dxaWszzdJKKgtfbgUQ
         jNXGR27NGHu3RmyA2fJhq5/yA0vLAygO0lQT8wpSGOra2sNyOZfEMTFdeAg/PTENJXCw
         dFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683821806; x=1686413806;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvFLGyCetB7gpH35C1TpsSdl41A7xRopdOuxPt5k8CM=;
        b=KF5z9puRNMukC3pF9N4skYdkZRJjbl+qtFUDXnp86PSzMI/0mAB+rbewQcqk+5xdbr
         ebLGxfYF74hG2DUiV1nHNZbgDq1q3s8t+yj8eds4QCrtFXwtvEaRcrQQfVuu0Hh+7Wb7
         Sort5gCMuaT7O4QVn+ThXP7o8wm6w+VMYkbMud8UuTYfvB37Y8Q/QcaHtnAIQeAt/b5e
         o5x6VT2Q+Vr9fMgOImZG2n4lMZz+yDwc8TXITbAGmUPm2r8Cjls4TwNliYh13h56Dhp3
         B2IJX3dQcIh3NZ3Hx6Qoo9HOx9W6v1IeRDGFMg6EqQE/gMBXMHu7W3dYM43Lql27c4zA
         kSCg==
X-Gm-Message-State: AC+VfDzte1vVGjoTRtTvKQ5au7b0OxUQ+WmaZVYsGLGPcDyqbnr62Cs/
        18d0fIeWXVOl2vFHXtVGEbVoCZStVqgtHSDSolMXow==
X-Google-Smtp-Source: ACHHUZ5SM33WS4G5ruItRHYdtJ0+kLFi3XlOuT0NP7UV1XdUdPxLftGS8tajYyAbr/UG5sPaZ1BpfA==
X-Received: by 2002:a17:902:e852:b0:1a9:433e:41e7 with SMTP id t18-20020a170902e85200b001a9433e41e7mr19596641plg.43.1683821805852;
        Thu, 11 May 2023 09:16:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902e9c400b001a673210cf4sm6155705plk.74.2023.05.11.09.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:16:45 -0700 (PDT)
Message-ID: <645d14ed.170a0220.19406.c68d@mx.google.com>
Date:   Thu, 11 May 2023 09:16:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.27-610-g4b10fbec9dd8
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 179 runs,
 11 regressions (v6.1.27-610-g4b10fbec9dd8)
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

stable-rc/queue/6.1 baseline: 179 runs, 11 regressions (v6.1.27-610-g4b10fb=
ec9dd8)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.27-610-g4b10fbec9dd8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.27-610-g4b10fbec9dd8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4b10fbec9dd82f56a1cf147fccf9b5913a52044a =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645cde89903f1b96432e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645cde89903f1b96432e85ec
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T12:24:27.600283  <8>[   11.177141] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10281494_1.4.2.3.1>

    2023-05-11T12:24:27.603843  + set +x

    2023-05-11T12:24:27.710050  =


    2023-05-11T12:24:27.811775  / # #export SHELL=3D/bin/sh

    2023-05-11T12:24:27.812523  =


    2023-05-11T12:24:27.914050  / # export SHELL=3D/bin/sh. /lava-10281494/=
environment

    2023-05-11T12:24:27.914855  =


    2023-05-11T12:24:28.016629  / # . /lava-10281494/environment/lava-10281=
494/bin/lava-test-runner /lava-10281494/1

    2023-05-11T12:24:28.017832  =


    2023-05-11T12:24:28.024194  / # /lava-10281494/bin/lava-test-runner /la=
va-10281494/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645cdea930d0a479132e8609

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645cdea930d0a479132e860e
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T12:24:55.597650  + set<8>[   11.920316] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10281542_1.4.2.3.1>

    2023-05-11T12:24:55.598132   +x

    2023-05-11T12:24:55.706165  / # #

    2023-05-11T12:24:55.808284  export SHELL=3D/bin/sh

    2023-05-11T12:24:55.808473  #

    2023-05-11T12:24:55.909029  / # export SHELL=3D/bin/sh. /lava-10281542/=
environment

    2023-05-11T12:24:55.909237  =


    2023-05-11T12:24:56.009953  / # . /lava-10281542/environment/lava-10281=
542/bin/lava-test-runner /lava-10281542/1

    2023-05-11T12:24:56.011018  =


    2023-05-11T12:24:56.015738  / # /lava-10281542/bin/lava-test-runner /la=
va-10281542/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645cde94488e9cafa62e85fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645cde94488e9cafa62e8602
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T12:24:33.100639  <8>[    7.848720] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10281501_1.4.2.3.1>

    2023-05-11T12:24:33.103425  + set +x

    2023-05-11T12:24:33.204796  =


    2023-05-11T12:24:33.305340  / # #export SHELL=3D/bin/sh

    2023-05-11T12:24:33.305498  =


    2023-05-11T12:24:33.405986  / # export SHELL=3D/bin/sh. /lava-10281501/=
environment

    2023-05-11T12:24:33.406148  =


    2023-05-11T12:24:33.506634  / # . /lava-10281501/environment/lava-10281=
501/bin/lava-test-runner /lava-10281501/1

    2023-05-11T12:24:33.506921  =


    2023-05-11T12:24:33.512142  / # /lava-10281501/bin/lava-test-runner /la=
va-10281501/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645cdf0341f0eacbb22e85f0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645cdf0341f0eacbb22e85f5
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T12:26:29.540630  + set +x

    2023-05-11T12:26:29.546901  <8>[   11.253639] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10281478_1.4.2.3.1>

    2023-05-11T12:26:29.650686  / # #

    2023-05-11T12:26:29.751308  export SHELL=3D/bin/sh

    2023-05-11T12:26:29.751489  #

    2023-05-11T12:26:29.852019  / # export SHELL=3D/bin/sh. /lava-10281478/=
environment

    2023-05-11T12:26:29.852207  =


    2023-05-11T12:26:29.952737  / # . /lava-10281478/environment/lava-10281=
478/bin/lava-test-runner /lava-10281478/1

    2023-05-11T12:26:29.953017  =


    2023-05-11T12:26:29.957929  / # /lava-10281478/bin/lava-test-runner /la=
va-10281478/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645cde821f16c5ecac2e85ef

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645cde821f16c5ecac2e85f4
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T12:24:19.079277  + set +x

    2023-05-11T12:24:19.085576  <8>[   10.155651] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10281492_1.4.2.3.1>

    2023-05-11T12:24:19.187756  #

    2023-05-11T12:24:19.188024  =


    2023-05-11T12:24:19.288648  / # #export SHELL=3D/bin/sh

    2023-05-11T12:24:19.288811  =


    2023-05-11T12:24:19.389365  / # export SHELL=3D/bin/sh. /lava-10281492/=
environment

    2023-05-11T12:24:19.389540  =


    2023-05-11T12:24:19.490065  / # . /lava-10281492/environment/lava-10281=
492/bin/lava-test-runner /lava-10281492/1

    2023-05-11T12:24:19.490365  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645cde8c903f1b96432e8601

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645cde8c903f1b96432e8606
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T12:24:23.825512  + <8>[   11.015816] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10281471_1.4.2.3.1>

    2023-05-11T12:24:23.825614  set +x

    2023-05-11T12:24:23.929488  / # #

    2023-05-11T12:24:24.030056  export SHELL=3D/bin/sh

    2023-05-11T12:24:24.030243  #

    2023-05-11T12:24:24.130711  / # export SHELL=3D/bin/sh. /lava-10281471/=
environment

    2023-05-11T12:24:24.130892  =


    2023-05-11T12:24:24.231432  / # . /lava-10281471/environment/lava-10281=
471/bin/lava-test-runner /lava-10281471/1

    2023-05-11T12:24:24.231743  =


    2023-05-11T12:24:24.236487  / # /lava-10281471/bin/lava-test-runner /la=
va-10281471/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645cdf8a99ec66c8ad2e85e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645cdf8a99ec66c8ad2e85ec
        new failure (last pass: v6.1.27-610-gc6b46250d53e)

    2023-05-11T12:28:34.280858  + set[   14.933258] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 947607_1.5.2.3.1>
    2023-05-11T12:28:34.281005   +x
    2023-05-11T12:28:34.386722  / # #
    2023-05-11T12:28:34.488284  export SHELL=3D/bin/sh
    2023-05-11T12:28:34.488686  #
    2023-05-11T12:28:34.589881  / # export SHELL=3D/bin/sh. /lava-947607/en=
vironment
    2023-05-11T12:28:34.590304  =

    2023-05-11T12:28:34.691529  / # . /lava-947607/environment/lava-947607/=
bin/lava-test-runner /lava-947607/1
    2023-05-11T12:28:34.692155  =

    2023-05-11T12:28:34.695367  / # /lava-947607/bin/lava-test-runner /lava=
-947607/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645cde8c903f1b96432e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645cde8c903f1b96432e8611
        failing since 43 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-11T12:24:26.348084  + set<8>[   12.243871] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10281512_1.4.2.3.1>

    2023-05-11T12:24:26.348526   +x

    2023-05-11T12:24:26.455675  / # #

    2023-05-11T12:24:26.558231  export SHELL=3D/bin/sh

    2023-05-11T12:24:26.559014  #

    2023-05-11T12:24:26.660536  / # export SHELL=3D/bin/sh. /lava-10281512/=
environment

    2023-05-11T12:24:26.661368  =


    2023-05-11T12:24:26.762996  / # . /lava-10281512/environment/lava-10281=
512/bin/lava-test-runner /lava-10281512/1

    2023-05-11T12:24:26.764457  =


    2023-05-11T12:24:26.768984  / # /lava-10281512/bin/lava-test-runner /la=
va-10281512/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645ce4ad97c0feba402e85f9

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/645ce4ad97c0feba402e8615
        failing since 4 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-11T12:50:31.035163  /lava-10281882/1/../bin/lava-test-case

    2023-05-11T12:50:31.041335  <8>[   22.989494] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645ce4ae97c0feba402e86a1
        failing since 4 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-11T12:50:25.615957  + set +x

    2023-05-11T12:50:25.622237  <8>[   17.568615] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10281882_1.5.2.3.1>

    2023-05-11T12:50:25.728556  / # #

    2023-05-11T12:50:25.829292  export SHELL=3D/bin/sh

    2023-05-11T12:50:25.829529  #

    2023-05-11T12:50:25.930100  / # export SHELL=3D/bin/sh. /lava-10281882/=
environment

    2023-05-11T12:50:25.930342  =


    2023-05-11T12:50:26.030921  / # . /lava-10281882/environment/lava-10281=
882/bin/lava-test-runner /lava-10281882/1

    2023-05-11T12:50:26.031309  =


    2023-05-11T12:50:26.035572  / # /lava-10281882/bin/lava-test-runner /la=
va-10281882/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645cde62f4daa772382e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.27-61=
0-g4b10fbec9dd8/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mip=
s-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645cde62f4daa772382e8=
5e7
        failing since 3 days (last pass: v6.1.22-1159-g8729cbdc1402, first =
fail: v6.1.22-1196-g571a2463c150b) =

 =20

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3756FF6C0
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 18:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbjEKQGI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 12:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbjEKQGH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 12:06:07 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84F62683
        for <stable@vger.kernel.org>; Thu, 11 May 2023 09:06:05 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aad5245571so61204045ad.1
        for <stable@vger.kernel.org>; Thu, 11 May 2023 09:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683821165; x=1686413165;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nh6z59Zck1iuER+JvdyvclT615hHnbgRTB5BVO7PX+s=;
        b=uKVzHcpIiNaUuCeAIsSpXzmzo/1bRMLotSQLy+N9pYWhjN8olJTeWMnFYv06c8cx5f
         GsY0wnBLprsArAJeHjdAXReuHfo4p0yiLCNEAhisq0pwR5HmPSeH1ammsiM3CF/l9HEP
         VePQZfrytSCFr4FrH9FIUNsIECZF2diOB7+mex8pXQMHtdtFEbWbbKYFu4tUB723y2Dp
         qNTQORaRg18knb/tgbl58VzphZI62BnfGVP2JDibPq2bbKs/6kkx82EZHHsz9zchmml8
         aicEEPmDjJCJF1miK3xlIhWkChlvo+kzFZO1vkeAb8HqahkyVSl2clP/q0Zg9pPDa3HH
         KWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683821165; x=1686413165;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nh6z59Zck1iuER+JvdyvclT615hHnbgRTB5BVO7PX+s=;
        b=SlVEu58wjV8ySEOiWG8RoRzqKCmGDjf6LnfXBOeqePBxZ/92nrYHcqMBEo8sUVPdfI
         p+xQlJi6lVKT5XnSL8gz0+4Ogav4GjY8SYmJgmM25Ad7siTqlmEt4FYuXP/NNG+0tmsq
         OeuFMXXN6dTK4CCx1K1PqzA7iUfUXXUAnF27iZxfSa9Fu9HH24L6xVEXLFPkXmA6KeGD
         LuCv4mrWQ4X5DC4SPDf/+cv5xaNAL7XOvgD/FCM3FSiIJuTaLkP5EpxhkIv/qL9OoTHV
         Zw/Rttw4f/N0epHoi5mRc/Dz+WT64mMhlxC8MMQrjdW2C3dGQi3yTazbAdoLYTJCKpe5
         uLPw==
X-Gm-Message-State: AC+VfDzRXNCtS0mmyE3E9fmlZLDJrepBShJZE8FuOUJ/rpA6LTDMJ4lO
        drJ3a4NzohI+qZ00GyfSTM1eZpbyAWS90RvBUwoISg==
X-Google-Smtp-Source: ACHHUZ74dGdA3gW5wvYwYw1HfySOddvrxkI8GCjT4jACj2r6miDkkvR+ovdMQdNoLH5kD/hqFtzB+A==
X-Received: by 2002:a17:903:338e:b0:1a9:8ba4:d0d3 with SMTP id kb14-20020a170903338e00b001a98ba4d0d3mr18898465plb.8.1683821164959;
        Thu, 11 May 2023 09:06:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iy3-20020a170903130300b001ab1cdb4295sm6079752plb.130.2023.05.11.09.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:06:04 -0700 (PDT)
Message-ID: <645d126c.170a0220.c73e6.c576@mx.google.com>
Date:   Thu, 11 May 2023 09:06:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.179-295-g424bf19322e3
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 158 runs,
 4 regressions (v5.10.179-295-g424bf19322e3)
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

stable-rc/queue/5.10 baseline: 158 runs, 4 regressions (v5.10.179-295-g424b=
f19322e3)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.179-295-g424bf19322e3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.179-295-g424bf19322e3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      424bf19322e3bc6c1d76dfd5a751b0c23c139396 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645cdc187dce0e18cc2e860f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-295-g424bf19322e3/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-295-g424bf19322e3/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645cdc187dce0e18cc2e8637
        failing since 86 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-11T12:13:49.610710  <8>[   19.568550] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445787_1.5.2.4.1>
    2023-05-11T12:13:49.720743  / # #
    2023-05-11T12:13:49.823293  export SHELL=3D/bin/sh
    2023-05-11T12:13:49.823860  #
    2023-05-11T12:13:49.925788  / # export SHELL=3D/bin/sh. /lava-445787/en=
vironment
    2023-05-11T12:13:49.926481  =

    2023-05-11T12:13:50.028295  / # . /lava-445787/environment/lava-445787/=
bin/lava-test-runner /lava-445787/1
    2023-05-11T12:13:50.029534  =

    2023-05-11T12:13:50.034091  / # /lava-445787/bin/lava-test-runner /lava=
-445787/1
    2023-05-11T12:13:50.141973  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645cdab4f78170320c2e85ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-295-g424bf19322e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-295-g424bf19322e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645cdab4f78170320c2e85ef
        failing since 42 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-11T12:08:02.794319  + set +x

    2023-05-11T12:08:02.800754  <8>[   10.656652] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10281358_1.4.2.3.1>

    2023-05-11T12:08:02.909053  / # #

    2023-05-11T12:08:03.011548  export SHELL=3D/bin/sh

    2023-05-11T12:08:03.012417  #

    2023-05-11T12:08:03.113929  / # export SHELL=3D/bin/sh. /lava-10281358/=
environment

    2023-05-11T12:08:03.114817  =


    2023-05-11T12:08:03.216475  / # . /lava-10281358/environment/lava-10281=
358/bin/lava-test-runner /lava-10281358/1

    2023-05-11T12:08:03.217777  =


    2023-05-11T12:08:03.222550  / # /lava-10281358/bin/lava-test-runner /la=
va-10281358/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645cda9237b6fbf69a2e862b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-295-g424bf19322e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-295-g424bf19322e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645cda9237b6fbf69a2e8630
        failing since 42 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-11T12:07:23.128219  <8>[   13.650570] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10281366_1.4.2.3.1>

    2023-05-11T12:07:23.131526  + set +x

    2023-05-11T12:07:23.239446  / # #

    2023-05-11T12:07:23.340308  export SHELL=3D/bin/sh

    2023-05-11T12:07:23.340514  #

    2023-05-11T12:07:23.440968  / # export SHELL=3D/bin/sh. /lava-10281366/=
environment

    2023-05-11T12:07:23.441122  =


    2023-05-11T12:07:23.541642  / # . /lava-10281366/environment/lava-10281=
366/bin/lava-test-runner /lava-10281366/1

    2023-05-11T12:07:23.541907  =


    2023-05-11T12:07:23.546625  / # /lava-10281366/bin/lava-test-runner /la=
va-10281366/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645cdb4a18aeed1d432e8624

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-295-g424bf19322e3/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.179=
-295-g424bf19322e3/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645cdb4a18aeed1d432e8629
        failing since 98 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-11T12:10:32.274234  / # #
    2023-05-11T12:10:32.375913  export SHELL=3D/bin/sh
    2023-05-11T12:10:32.376263  #
    2023-05-11T12:10:32.477592  / # export SHELL=3D/bin/sh. /lava-3575234/e=
nvironment
    2023-05-11T12:10:32.477943  =

    2023-05-11T12:10:32.579268  / # . /lava-3575234/environment/lava-357523=
4/bin/lava-test-runner /lava-3575234/1
    2023-05-11T12:10:32.579874  =

    2023-05-11T12:10:32.585505  / # /lava-3575234/bin/lava-test-runner /lav=
a-3575234/1
    2023-05-11T12:10:32.649615  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-11T12:10:32.684613  + cd /lava-3575234/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

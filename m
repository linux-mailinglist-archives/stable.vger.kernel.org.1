Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A94E6FBCE3
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 04:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEICLQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 22:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjEICLP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 22:11:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF1F768C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 19:11:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24e3a0aa408so4793125a91.1
        for <stable@vger.kernel.org>; Mon, 08 May 2023 19:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683598273; x=1686190273;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aDzsjOR6EHCKGAd12+za3jgSGxHtaoVYDwUgfozhaOY=;
        b=bOhRhIgsOTEih9ZjwaTsA56jLTfVuseIoxj9DNZxy2J3RoMGYeVn1TTMQ3nD+m2CTM
         auo+iB7QwV6Y//3dWvfVz3gPIsTwFw8FwjzCRxvkJAk/vNCIvKWMO/FuoHyXLuLlAOc+
         J9pRio9RmMFe6nMn4ncxamaHL9Ous6iXlX1BruuxMwOy0nU7iVSfDLwkg/QVLoZmkewk
         zsQ7CYpCcOsLRVR4V03JAhqgMmS+/MYd3qWl5nX5B7ddTjm1/zij5riALh2rWgCswQhu
         hqNYcFKK+Bt8VQU+RVFQ0A3HY5iSZla+fW33m4oK4EXjpMpbvgm7/HT70dGk/sgqH9pe
         ypWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683598273; x=1686190273;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDzsjOR6EHCKGAd12+za3jgSGxHtaoVYDwUgfozhaOY=;
        b=Q51Mcs5BDfG0sUjGl8k8U8Qd54eTcDdmXeWqMkplUbLFN1k13uS2IJhrcU4tssa3tF
         YCN7iJOO9DsI1PRxVz7aNes/sQsrhlugvGC8sRpy+NnNztxvOzMrDDi7AfeeSK47T+N+
         uk0orlx+SnoSNNegeNviPAqj2Ds7VSWMBJnrsYdQjYRCZDmLB7mxruS7RytTet8pBqXC
         QdvPUEHGTiRbTT7cVo2w9ficchogYzkyCokwPmWWQe7Pjb9bbxGcPf9EiBivOKUHzsWH
         UPFNZH4mP7aeWOBp6T5QkwuoMx3m8F79jOuzKJYWAvUQ4gET0mZff8qVsMVrTRtMVY9J
         5WRg==
X-Gm-Message-State: AC+VfDytxGlOKCN7a42WAaWj6n5qax4rEUQqJOQJRGLeZeRNTzOWhDGz
        uhoeUCbTHMi/lcd54JJfE6GAB+6tdREB66JuCOf6f98w
X-Google-Smtp-Source: ACHHUZ5/L7xhbk5MPPLrGTplXZCvIfrw2fmad0QKXJqGfRj48USNPMXENaBWl7LquDPidRMsRkLBMA==
X-Received: by 2002:a17:90a:68c6:b0:247:8ad:d5d4 with SMTP id q6-20020a17090a68c600b0024708add5d4mr12786989pjj.8.1683598272456;
        Mon, 08 May 2023 19:11:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090a784e00b00246b7b8b43asm514931pjl.49.2023.05.08.19.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 19:11:11 -0700 (PDT)
Message-ID: <6459abbf.170a0220.637c7.1aea@mx.google.com>
Date:   Mon, 08 May 2023 19:11:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-732-g348c6f2b4752
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 124 runs,
 8 regressions (v5.15.105-732-g348c6f2b4752)
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

stable-rc/queue/5.15 baseline: 124 runs, 8 regressions (v5.15.105-732-g348c=
6f2b4752)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
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

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-732-g348c6f2b4752/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-732-g348c6f2b4752
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      348c6f2b4752931ee2ccf7f72e5bbac5367a3f9f =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64596af2bf2c98c27e2e8601

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64596af2bf2c98c27e2e8606
        failing since 41 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-08T21:34:20.350412  + <8>[   10.955541] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10242621_1.4.2.3.1>

    2023-05-08T21:34:20.350527  set +x

    2023-05-08T21:34:20.454347  / # #

    2023-05-08T21:34:20.555032  export SHELL=3D/bin/sh

    2023-05-08T21:34:20.555230  #

    2023-05-08T21:34:20.655760  / # export SHELL=3D/bin/sh. /lava-10242621/=
environment

    2023-05-08T21:34:20.655952  =


    2023-05-08T21:34:20.756443  / # . /lava-10242621/environment/lava-10242=
621/bin/lava-test-runner /lava-10242621/1

    2023-05-08T21:34:20.756793  =


    2023-05-08T21:34:20.761280  / # /lava-10242621/bin/lava-test-runner /la=
va-10242621/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64596afa5712db26c12e865e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64596afa5712db26c12e8663
        failing since 41 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-08T21:34:28.442459  <8>[   10.915516] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10242665_1.4.2.3.1>

    2023-05-08T21:34:28.445679  + set +x

    2023-05-08T21:34:28.547193  =


    2023-05-08T21:34:28.647756  / # #export SHELL=3D/bin/sh

    2023-05-08T21:34:28.648037  =


    2023-05-08T21:34:28.748669  / # export SHELL=3D/bin/sh. /lava-10242665/=
environment

    2023-05-08T21:34:28.748959  =


    2023-05-08T21:34:28.849627  / # . /lava-10242665/environment/lava-10242=
665/bin/lava-test-runner /lava-10242665/1

    2023-05-08T21:34:28.850060  =


    2023-05-08T21:34:28.855256  / # /lava-10242665/bin/lava-test-runner /la=
va-10242665/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64596b86f41ef7dbce2e861f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64596b86f41ef7dbce2e8624
        failing since 41 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-08T21:36:56.775332  + set +x

    2023-05-08T21:36:56.781623  <8>[   12.313689] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10242617_1.4.2.3.1>

    2023-05-08T21:36:56.886153  / # #

    2023-05-08T21:36:56.986898  export SHELL=3D/bin/sh

    2023-05-08T21:36:56.987129  #

    2023-05-08T21:36:57.087673  / # export SHELL=3D/bin/sh. /lava-10242617/=
environment

    2023-05-08T21:36:57.087862  =


    2023-05-08T21:36:57.188420  / # . /lava-10242617/environment/lava-10242=
617/bin/lava-test-runner /lava-10242617/1

    2023-05-08T21:36:57.188820  =


    2023-05-08T21:36:57.193566  / # /lava-10242617/bin/lava-test-runner /la=
va-10242617/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64596adb756cc1b0a72e860e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64596adb756cc1b0a72e8613
        failing since 41 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-08T21:34:04.925948  + set +x

    2023-05-08T21:34:04.932441  <8>[   10.361715] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10242644_1.4.2.3.1>

    2023-05-08T21:34:05.037078  / # #

    2023-05-08T21:34:05.137864  export SHELL=3D/bin/sh

    2023-05-08T21:34:05.138158  #

    2023-05-08T21:34:05.238776  / # export SHELL=3D/bin/sh. /lava-10242644/=
environment

    2023-05-08T21:34:05.239023  =


    2023-05-08T21:34:05.339624  / # . /lava-10242644/environment/lava-10242=
644/bin/lava-test-runner /lava-10242644/1

    2023-05-08T21:34:05.340046  =


    2023-05-08T21:34:05.344691  / # /lava-10242644/bin/lava-test-runner /la=
va-10242644/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64596b025712db26c12e8673

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64596b025712db26c12e8678
        failing since 41 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-08T21:34:38.674097  + set +x<8>[   14.847172] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10242668_1.4.2.3.1>

    2023-05-08T21:34:38.674215  =


    2023-05-08T21:34:38.778817  / # #

    2023-05-08T21:34:38.879498  export SHELL=3D/bin/sh

    2023-05-08T21:34:38.879717  #

    2023-05-08T21:34:38.980322  / # export SHELL=3D/bin/sh. /lava-10242668/=
environment

    2023-05-08T21:34:38.980564  =


    2023-05-08T21:34:39.081099  / # . /lava-10242668/environment/lava-10242=
668/bin/lava-test-runner /lava-10242668/1

    2023-05-08T21:34:39.081393  =


    2023-05-08T21:34:39.086473  / # /lava-10242668/bin/lava-test-runner /la=
va-10242668/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645970191a9cf1896d2e85fd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645970191a9cf1896d2e8602
        failing since 101 days (last pass: v5.15.81-121-gcb14018a85f6, firs=
t fail: v5.15.90-146-gbf7101723cc0)

    2023-05-08T21:56:33.154777  + set +x
    2023-05-08T21:56:33.154972  [    9.380562] <LAVA_SIGNAL_ENDRUN 0_dmesg =
943628_1.5.2.3.1>
    2023-05-08T21:56:33.261700  / # #
    2023-05-08T21:56:33.363343  export SHELL=3D/bin/sh
    2023-05-08T21:56:33.363833  #
    2023-05-08T21:56:33.465113  / # export SHELL=3D/bin/sh. /lava-943628/en=
vironment
    2023-05-08T21:56:33.465586  =

    2023-05-08T21:56:33.566822  / # . /lava-943628/environment/lava-943628/=
bin/lava-test-runner /lava-943628/1
    2023-05-08T21:56:33.567422  =

    2023-05-08T21:56:33.570097  / # /lava-943628/bin/lava-test-runner /lava=
-943628/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64596b2c1eeebafb772e860e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64596b2c1eeebafb772e8613
        failing since 41 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-08T21:35:22.466998  <8>[   12.239112] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10242659_1.4.2.3.1>

    2023-05-08T21:35:22.571744  / # #

    2023-05-08T21:35:22.672448  export SHELL=3D/bin/sh

    2023-05-08T21:35:22.672659  #

    2023-05-08T21:35:22.773199  / # export SHELL=3D/bin/sh. /lava-10242659/=
environment

    2023-05-08T21:35:22.773452  =


    2023-05-08T21:35:22.873945  / # . /lava-10242659/environment/lava-10242=
659/bin/lava-test-runner /lava-10242659/1

    2023-05-08T21:35:22.874327  =


    2023-05-08T21:35:22.879040  / # /lava-10242659/bin/lava-test-runner /la=
va-10242659/1

    2023-05-08T21:35:22.884279  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6459700efc4997792a2e8681

  Results:     65 PASS, 5 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3=
288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g348c6f2b4752/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3=
288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
6459700efc4997792a2e86be
        new failure (last pass: v5.15.105-737-g6d55a9d91feaf)

    2023-05-08T21:56:20.084289  <8>[   19.093429] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-keyb-driver-present RESULT=3Dpass>

    2023-05-08T21:56:21.099466  /lava-10243062/1/../bin/lava-test-case
   =

 =20

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4175A6F9AC6
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 19:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjEGR75 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 13:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjEGR74 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 13:59:56 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFDA35AF
        for <stable@vger.kernel.org>; Sun,  7 May 2023 10:59:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64115eef620so29692138b3a.1
        for <stable@vger.kernel.org>; Sun, 07 May 2023 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683482393; x=1686074393;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ldE61jw5YScYs9D4liNQeJtNf8RWYQmdtGvbJiQDXms=;
        b=geMS5EtS93vdB1dn9XdtGibkxPdHtMbTlGyR96v5T1E3daXBgERupB2JIwD6pkJU6F
         eFf/NQMdFIp3orWxyFytGDlw7bKnvwBO6uECPbHmYOD8c6pHcuVIPm1MP7nzcuA9Vxcr
         /omt6xEGO5BPBQUIuEtSsOUHiDzyLsYmlnvyVDUGnmpomrz33E31gyCzbZ2DoFCw41CT
         3xo7nZve1E1Ip3ZfT17QH9en0ewmt65LQJML3VVMi46H3+q2QqOrSrFxaU3VAMC3WJVn
         z04ll0vSntq4D0zyBhLLHnY3t3J1ngNk52xONYeUW2eEvhz8ErtiZb5oUCmRtmRNXF9f
         G1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683482393; x=1686074393;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldE61jw5YScYs9D4liNQeJtNf8RWYQmdtGvbJiQDXms=;
        b=Xf9Yq8Zx7Af/aK71Xp1gj8MckGbBrsDv1w5w+Eyancs54EU/SH/nNrlN/BjfktK/wO
         0y3i6BgWdTYmm1I0io3gKwLh32zwdG88y9Aw2DgqAyqh1g/OarNkCwmxdWMV0gC6YGg5
         DryzfqFd/eZbApsLlUPCOlUuR6k832tFHESYChHgcQ5m7rP49OfWveWj+/5/tVQnsGrj
         yG3NFO1GelfE8jXf6ZcvIRs8eD55D5jetOLXz0nCBB0PL5W0iRqcme3T+AswVdZnQKf+
         xFh7DyZQuJXb7Lu+hmXBwlJEYVed2xhW8RjpkjVQNp+ED4J+XlQCMK8IbbtoK0ncem2n
         8bgw==
X-Gm-Message-State: AC+VfDzWe+7WMGmFaQUxE9EX1J1tnp1btH+pzCJ1nvx1z80ZbXjJJSVk
        tAJNtnd1yJmKA+ESdxL3OC1EeSL2HHn+NcI25L4Efg==
X-Google-Smtp-Source: ACHHUZ5m6Wkqy7VkSk63xdjqyIzVP6IEy7YFCSEnbY5wjgYXEKglgJCq8+WCv/9mT8/VNQfDW8Qg0A==
X-Received: by 2002:a05:6a00:2d94:b0:643:a704:c5a8 with SMTP id fb20-20020a056a002d9400b00643a704c5a8mr9316405pfb.1.1683482392591;
        Sun, 07 May 2023 10:59:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t8-20020a62ea08000000b0063b898b3502sm4638662pfh.153.2023.05.07.10.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 10:59:51 -0700 (PDT)
Message-ID: <6457e717.620a0220.d47c2.8815@mx.google.com>
Date:   Sun, 07 May 2023 10:59:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-727-g36e1e6af436e9
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 160 runs,
 8 regressions (v5.15.105-727-g36e1e6af436e9)
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

stable-rc/queue/5.15 baseline: 160 runs, 8 regressions (v5.15.105-727-g36e1=
e6af436e9)

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

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-727-g36e1e6af436e9/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-727-g36e1e6af436e9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      36e1e6af436e981a3b385ff4627d7ec8428bedb2 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457b17c16822119922e85fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457b17c16822119922e8603
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T14:10:55.996438  + set<8>[   11.708664] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10228205_1.4.2.3.1>

    2023-05-07T14:10:55.997014   +x

    2023-05-07T14:10:56.105146  / # #

    2023-05-07T14:10:56.207797  export SHELL=3D/bin/sh

    2023-05-07T14:10:56.208586  #

    2023-05-07T14:10:56.310274  / # export SHELL=3D/bin/sh. /lava-10228205/=
environment

    2023-05-07T14:10:56.311061  =


    2023-05-07T14:10:56.412712  / # . /lava-10228205/environment/lava-10228=
205/bin/lava-test-runner /lava-10228205/1

    2023-05-07T14:10:56.413972  =


    2023-05-07T14:10:56.418731  / # /lava-10228205/bin/lava-test-runner /la=
va-10228205/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457b17c343b2f94c12e85fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457b17c343b2f94c12e8602
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T14:10:46.512518  <8>[   10.273675] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10228212_1.4.2.3.1>

    2023-05-07T14:10:46.515574  + set +x

    2023-05-07T14:10:46.616967  #

    2023-05-07T14:10:46.617298  =


    2023-05-07T14:10:46.717912  / # #export SHELL=3D/bin/sh

    2023-05-07T14:10:46.718241  =


    2023-05-07T14:10:46.818767  / # export SHELL=3D/bin/sh. /lava-10228212/=
environment

    2023-05-07T14:10:46.819037  =


    2023-05-07T14:10:46.919613  / # . /lava-10228212/environment/lava-10228=
212/bin/lava-test-runner /lava-10228212/1

    2023-05-07T14:10:46.920106  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457b1dee779b9092c2e8611

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457b1dee779b9092c2e8616
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T14:12:33.898385  + <8>[   10.323584] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10228218_1.4.2.3.1>

    2023-05-07T14:12:33.898499  set +x

    2023-05-07T14:12:34.001011  =


    2023-05-07T14:12:34.101559  / # #export SHELL=3D/bin/sh

    2023-05-07T14:12:34.101790  =


    2023-05-07T14:12:34.202320  / # export SHELL=3D/bin/sh. /lava-10228218/=
environment

    2023-05-07T14:12:34.202580  =


    2023-05-07T14:12:34.303098  / # . /lava-10228218/environment/lava-10228=
218/bin/lava-test-runner /lava-10228218/1

    2023-05-07T14:12:34.303497  =


    2023-05-07T14:12:34.308058  / # /lava-10228218/bin/lava-test-runner /la=
va-10228218/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457b160405c1502f42e85eb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457b160405c1502f42e85f0
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T14:10:32.433324  <8>[   10.451863] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10228204_1.4.2.3.1>

    2023-05-07T14:10:32.436410  + set +x

    2023-05-07T14:10:32.541355  =


    2023-05-07T14:10:32.642249  / # #export SHELL=3D/bin/sh

    2023-05-07T14:10:32.642923  =


    2023-05-07T14:10:32.744260  / # export SHELL=3D/bin/sh. /lava-10228204/=
environment

    2023-05-07T14:10:32.745052  =


    2023-05-07T14:10:32.846610  / # . /lava-10228204/environment/lava-10228=
204/bin/lava-test-runner /lava-10228204/1

    2023-05-07T14:10:32.846922  =


    2023-05-07T14:10:32.852294  / # /lava-10228204/bin/lava-test-runner /la=
va-10228204/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457b17ddc70ceebf82e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457b17ddc70ceebf82e8605
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T14:10:44.946348  + set<8>[   11.609592] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10228220_1.4.2.3.1>

    2023-05-07T14:10:44.946464   +x

    2023-05-07T14:10:45.050649  / # #

    2023-05-07T14:10:45.151249  export SHELL=3D/bin/sh

    2023-05-07T14:10:45.151434  #

    2023-05-07T14:10:45.251911  / # export SHELL=3D/bin/sh. /lava-10228220/=
environment

    2023-05-07T14:10:45.252103  =


    2023-05-07T14:10:45.352618  / # . /lava-10228220/environment/lava-10228=
220/bin/lava-test-runner /lava-10228220/1

    2023-05-07T14:10:45.352961  =


    2023-05-07T14:10:45.357593  / # /lava-10228220/bin/lava-test-runner /la=
va-10228220/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6457aec6d0f9523d5c2e8682

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-=
imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-=
imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457aec6d0f9523d5c2e8687
        failing since 100 days (last pass: v5.15.81-121-gcb14018a85f6, firs=
t fail: v5.15.90-146-gbf7101723cc0)

    2023-05-07T13:59:13.048582  + set +x
    2023-05-07T13:59:13.048861  [    9.406429] <LAVA_SIGNAL_ENDRUN 0_dmesg =
942851_1.5.2.3.1>
    2023-05-07T13:59:13.155964  / # #
    2023-05-07T13:59:13.257757  export SHELL=3D/bin/sh
    2023-05-07T13:59:13.258200  #
    2023-05-07T13:59:13.359340  / # export SHELL=3D/bin/sh. /lava-942851/en=
vironment
    2023-05-07T13:59:13.359745  =

    2023-05-07T13:59:13.460932  / # . /lava-942851/environment/lava-942851/=
bin/lava-test-runner /lava-942851/1
    2023-05-07T13:59:13.461440  =

    2023-05-07T13:59:13.464060  / # /lava-942851/bin/lava-test-runner /lava=
-942851/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457b17216822119922e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457b17216822119922e85f6
        failing since 40 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T14:10:38.779774  + set +x<8>[   12.077340] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10228216_1.4.2.3.1>

    2023-05-07T14:10:38.779888  =


    2023-05-07T14:10:38.884547  / # #

    2023-05-07T14:10:38.985204  export SHELL=3D/bin/sh

    2023-05-07T14:10:38.985462  #

    2023-05-07T14:10:39.086065  / # export SHELL=3D/bin/sh. /lava-10228216/=
environment

    2023-05-07T14:10:39.086292  =


    2023-05-07T14:10:39.186826  / # . /lava-10228216/environment/lava-10228=
216/bin/lava-test-runner /lava-10228216/1

    2023-05-07T14:10:39.187161  =


    2023-05-07T14:10:39.191746  / # /lava-10228216/bin/lava-test-runner /la=
va-10228216/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6457b69f3e5a9ae8af2e8602

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-727-g36e1e6af436e9/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457b69f3e5a9ae8af2e862e
        failing since 109 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-07T14:32:47.286733  + set +x
    2023-05-07T14:32:47.290520  <8>[   16.137582] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3560821_1.5.2.4.1>
    2023-05-07T14:32:47.412201  / # #
    2023-05-07T14:32:47.518631  export SHELL=3D/bin/sh
    2023-05-07T14:32:47.520392  #
    2023-05-07T14:32:47.624557  / # export SHELL=3D/bin/sh. /lava-3560821/e=
nvironment
    2023-05-07T14:32:47.626216  =

    2023-05-07T14:32:47.730150  / # . /lava-3560821/environment/lava-356082=
1/bin/lava-test-runner /lava-3560821/1
    2023-05-07T14:32:47.733248  =

    2023-05-07T14:32:47.736220  / # /lava-3560821/bin/lava-test-runner /lav=
a-3560821/1 =

    ... (12 line(s) more)  =

 =20

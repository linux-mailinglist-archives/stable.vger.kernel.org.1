Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3F27A3EFB
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 02:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjIRA3N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 20:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjIRA27 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 20:28:59 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B5E11F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 17:28:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c572c9c852so1824835ad.2
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 17:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694996932; x=1695601732; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DSeyWq97fJQ1nEEu6x7yvt+qq0dNdeUTdiytGOQtt6w=;
        b=wdetP3kWbs423GJCp0gS+VH5aTRtkYNtOawpI9fH/SyUSpom7mj4qUUruuoxQ3Jd1t
         MkwRjtG7emgHXG3hF7dCbuva9DnuSgRklBuUthaiv2qwqb23y0AiiC1uVX03PC6LcIVS
         rpiZNooKOuKRjk9RyY45eWLMHRBvAverYxGfxTOhs5ZOkd87mYuHwupJO8rRqEyrRS8b
         35UUaH4DnTrPZlYeVq/9JqO3kv2h5bJyT3Ifbug6LcMjOpSah9HtueSDR7AsZFw4uFfz
         cdEcAyZ8uBLLfCOewWCzXF2QUlI41PzNnCAPl7zoLy8R4hmSH2+H1NEuSNJ45JeCO+OK
         nzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694996932; x=1695601732;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSeyWq97fJQ1nEEu6x7yvt+qq0dNdeUTdiytGOQtt6w=;
        b=a8IGlWdd2bwNW6FsL3SDSMYKKSJYgBKTZItN7rVXplxDuASfxPD4mEIU9aBvr9V3wI
         XaL3mlQJy+cIGQOm0eDUUU35zl6jjOd8t/SMDI6dhQPZBmchQFEYy56xeVm0vB7eJN4j
         xGN6YYiUCY7cWO0+2hsWF9zQ15muELA5FTCKyHP0NfQXCl3kc2qPU0T2lrX50Pu/tTax
         3pVr3z5H3EcuHzxubjeEdUl27qYo0A2UYmGMNGynuJSKwbNzy+TLefOC+jO9lbn1dBzm
         vLaOIBgyzo1g1H/P6QbTOLf6rLTlUteH8FdK4PpWjsCXKL4tRV4ml5blyuTFfSYzchIm
         d/Sw==
X-Gm-Message-State: AOJu0YzhhTvrmfdeUDCe8a+FiuqpEPCQCvr4Gi+IG4vxDwmfJB6PjvUj
        LfXyWLPbgqeDdr67sFakRiRIZfm2oJyArXFIiUte69+S
X-Google-Smtp-Source: AGHT+IGQ8JlEsT8E7dRxmMr70s1iZ67n5mjZpSBmGfJGFIknuLsYWYTi+lxnw1Pe7vy7L93eHuZ3Sw==
X-Received: by 2002:a17:902:d2cb:b0:1c4:a650:21df with SMTP id n11-20020a170902d2cb00b001c4a65021dfmr2010861plc.50.1694996931870;
        Sun, 17 Sep 2023 17:28:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b001b8a3e2c241sm7169051plh.14.2023.09.17.17.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 17:28:51 -0700 (PDT)
Message-ID: <650799c3.170a0220.eb8fe.9b80@mx.google.com>
Date:   Sun, 17 Sep 2023 17:28:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.131-512-ga8d93816a2f2
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 113 runs,
 9 regressions (v5.15.131-512-ga8d93816a2f2)
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

stable-rc/linux-5.15.y baseline: 113 runs, 9 regressions (v5.15.131-512-ga8=
d93816a2f2)

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
nel/v5.15.131-512-ga8d93816a2f2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.131-512-ga8d93816a2f2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a8d93816a2f2942906a99b5ea77dcc87c483e56e =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650766530d972186958a0a67

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650766530d972186958a0a70
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-17T20:50:32.751786  + set +x

    2023-09-17T20:50:32.758647  <8>[   10.489065] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11557083_1.4.2.3.1>

    2023-09-17T20:50:32.860621  #

    2023-09-17T20:50:32.961460  / # #export SHELL=3D/bin/sh

    2023-09-17T20:50:32.961671  =


    2023-09-17T20:50:33.062273  / # export SHELL=3D/bin/sh. /lava-11557083/=
environment

    2023-09-17T20:50:33.062463  =


    2023-09-17T20:50:33.163001  / # . /lava-11557083/environment/lava-11557=
083/bin/lava-test-runner /lava-11557083/1

    2023-09-17T20:50:33.163411  =


    2023-09-17T20:50:33.168042  / # /lava-11557083/bin/lava-test-runner /la=
va-11557083/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6507664954d81ebede8a0a68

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6507664954d81ebede8a0a71
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-17T20:48:58.471867  <8>[   10.509152] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11557048_1.4.2.3.1>

    2023-09-17T20:48:58.475655  + set +x

    2023-09-17T20:48:58.582322  =


    2023-09-17T20:48:58.684454  / # #export SHELL=3D/bin/sh

    2023-09-17T20:48:58.685314  =


    2023-09-17T20:48:58.786893  / # export SHELL=3D/bin/sh. /lava-11557048/=
environment

    2023-09-17T20:48:58.787753  =


    2023-09-17T20:48:58.889324  / # . /lava-11557048/environment/lava-11557=
048/bin/lava-test-runner /lava-11557048/1

    2023-09-17T20:48:58.890750  =


    2023-09-17T20:48:58.896003  / # /lava-11557048/bin/lava-test-runner /la=
va-11557048/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65076aa834c61628ee8a0a53

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65076aa834c61628ee8a0=
a54
        failing since 54 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6507664305791860ae8a0a9b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6507664305791860ae8a0aa4
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-17T20:49:18.533192  <8>[   10.705696] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11557073_1.4.2.3.1>

    2023-09-17T20:49:18.536489  + set +x

    2023-09-17T20:49:18.640580  / # #

    2023-09-17T20:49:18.741197  export SHELL=3D/bin/sh

    2023-09-17T20:49:18.741367  #

    2023-09-17T20:49:18.841847  / # export SHELL=3D/bin/sh. /lava-11557073/=
environment

    2023-09-17T20:49:18.841980  =


    2023-09-17T20:49:18.942432  / # . /lava-11557073/environment/lava-11557=
073/bin/lava-test-runner /lava-11557073/1

    2023-09-17T20:49:18.942642  =


    2023-09-17T20:49:18.947300  / # /lava-11557073/bin/lava-test-runner /la=
va-11557073/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65076654c81742fd6c8a0a46

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65076654c81742fd6c8a0a4f
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-17T20:49:09.973498  + set<8>[   10.756454] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11557086_1.4.2.3.1>

    2023-09-17T20:49:09.973581   +x

    2023-09-17T20:49:10.077773  / # #

    2023-09-17T20:49:10.178473  export SHELL=3D/bin/sh

    2023-09-17T20:49:10.178670  #

    2023-09-17T20:49:10.279257  / # export SHELL=3D/bin/sh. /lava-11557086/=
environment

    2023-09-17T20:49:10.279434  =


    2023-09-17T20:49:10.380007  / # . /lava-11557086/environment/lava-11557=
086/bin/lava-test-runner /lava-11557086/1

    2023-09-17T20:49:10.380287  =


    2023-09-17T20:49:10.384913  / # /lava-11557086/bin/lava-test-runner /la=
va-11557086/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6507664fa987bac4938a0a4c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6507664fa987bac4938a0a55
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-17T20:48:58.703403  <8>[   11.875359] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11557050_1.4.2.3.1>

    2023-09-17T20:48:58.807653  / # #

    2023-09-17T20:48:58.908374  export SHELL=3D/bin/sh

    2023-09-17T20:48:58.908566  #

    2023-09-17T20:48:59.009057  / # export SHELL=3D/bin/sh. /lava-11557050/=
environment

    2023-09-17T20:48:59.009238  =


    2023-09-17T20:48:59.109778  / # . /lava-11557050/environment/lava-11557=
050/bin/lava-test-runner /lava-11557050/1

    2023-09-17T20:48:59.110051  =


    2023-09-17T20:48:59.114739  / # /lava-11557050/bin/lava-test-runner /la=
va-11557050/1

    2023-09-17T20:48:59.119991  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6507678aa2df4b2fde8a0a94

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6507678ba2df4b2fde8a0a9d
        failing since 60 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-17T20:58:32.825349  / # #

    2023-09-17T20:58:32.927418  export SHELL=3D/bin/sh

    2023-09-17T20:58:32.928098  #

    2023-09-17T20:58:33.029468  / # export SHELL=3D/bin/sh. /lava-11557130/=
environment

    2023-09-17T20:58:33.030157  =


    2023-09-17T20:58:33.131515  / # . /lava-11557130/environment/lava-11557=
130/bin/lava-test-runner /lava-11557130/1

    2023-09-17T20:58:33.132538  =


    2023-09-17T20:58:33.148902  / # /lava-11557130/bin/lava-test-runner /la=
va-11557130/1

    2023-09-17T20:58:33.198113  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-17T20:58:33.198608  + cd /lav<8>[   15.938925] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11557130_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/650767a7ed4df679a38a0b19

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650767a7ed4df679a38a0b22
        failing since 60 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-17T20:56:46.675874  / # #

    2023-09-17T20:56:47.755568  export SHELL=3D/bin/sh

    2023-09-17T20:56:47.757358  #

    2023-09-17T20:56:49.246573  / # export SHELL=3D/bin/sh. /lava-11557124/=
environment

    2023-09-17T20:56:49.247831  =


    2023-09-17T20:56:51.969819  / # . /lava-11557124/environment/lava-11557=
124/bin/lava-test-runner /lava-11557124/1

    2023-09-17T20:56:51.972110  =


    2023-09-17T20:56:51.983993  / # /lava-11557124/bin/lava-test-runner /la=
va-11557124/1

    2023-09-17T20:56:52.042923  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-17T20:56:52.043418  + cd /lava-115571<8>[   25.524547] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11557124_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6507678ca87af3960b8a0ae2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
31-512-ga8d93816a2f2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6507678ca87af3960b8a0aeb
        failing since 60 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-09-17T20:58:45.087849  / # #

    2023-09-17T20:58:45.190059  export SHELL=3D/bin/sh

    2023-09-17T20:58:45.190767  #

    2023-09-17T20:58:45.292153  / # export SHELL=3D/bin/sh. /lava-11557136/=
environment

    2023-09-17T20:58:45.292787  =


    2023-09-17T20:58:45.394082  / # . /lava-11557136/environment/lava-11557=
136/bin/lava-test-runner /lava-11557136/1

    2023-09-17T20:58:45.395077  =


    2023-09-17T20:58:45.412313  / # /lava-11557136/bin/lava-test-runner /la=
va-11557136/1

    2023-09-17T20:58:45.456314  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-17T20:58:45.471217  + cd /lava-1155713<8>[   16.797458] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11557136_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

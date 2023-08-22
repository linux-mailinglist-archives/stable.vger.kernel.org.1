Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0B7783A15
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 08:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjHVGie (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 02:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjHVGid (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 02:38:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5BD1AB
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 23:37:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdbbede5d4so32234055ad.2
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 23:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692686275; x=1693291075;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GQnl+F0cDqKVLNkZSE/Wmw1ZKR1YW4sPzy1yKsuGSv8=;
        b=wz4v2kjQNNdNDQaX1tT1jl9zh2RD+HMCLw+llJrpRZ+HC+ETxeuYFSvWuNRLLS8WIg
         SpYIYS5jIg5MMgW2jECb2qccn3pHBTNEFwMv/3A0wqoz7VsqLoc43JLP3Sa/0s6LNDZB
         dO0e/tQmNTi89P6gMiLFn5Uc9r5t3QsVDKTZMCbGYxVVtXJUHC4NSZYDjIasug5yzbBK
         89yteI72rkyI5HGKniFWJdv39KeXDnbR/Lfv9rRhxKYncZV+jIKK/jkLJpp974xXz/GH
         y+8TV/nELEto4zaRRUftb7ioF5HmjrdaU/vTq0Tdz784zD6vq2ENhOJlxDj4Hv/fhON/
         nE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692686275; x=1693291075;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQnl+F0cDqKVLNkZSE/Wmw1ZKR1YW4sPzy1yKsuGSv8=;
        b=jfIWswbogI0AqygTnsDy2kfQ7NQUiGMNp1mozGgEEfwlRdKxgRweq3bedVAaq4Xxbn
         jQvWjJXZYGbTMSXsjyq0eudHnNGl2Iy5nv29yS+x2dZMZVLT2L2JyqFzrsWCtI2nsx2X
         Xls0nt3BZUv5dulLLq/UR6G4gsb2fcqnocoteQDBwR3o+JZA4IeTnKZYy092rAqSEm8D
         AZdEe/M+QCiTNE0AnLFfo1ICz4J2wiv9jmempXNSbvmtsV6v+OQNEwSU9JyGLLUW2+1T
         NINA0kFFvmRcfOermmKk4LFKiWSqlIBVDjI/Dh5r9ScIaSdpTJyCiL/b+bfDY2L42FTH
         ysIA==
X-Gm-Message-State: AOJu0YxPW66E4B1ZWqpDt+O6cqnSMZk/FlOFnHqjJjFiL1oGPKSsfYao
        BnqHuRl4zO437B5dsWBOM16dh4omTQsyQ45e++yBCg==
X-Google-Smtp-Source: AGHT+IEvSGFGcE+Mm1rXEwAsJYvJ7p4K5YdRcUxcq6QKanwOixfB6l+Ntvw7fMj4JZQSrIzWdwnSQA==
X-Received: by 2002:a17:903:2446:b0:1b1:9233:bbf5 with SMTP id l6-20020a170903244600b001b19233bbf5mr10117698pls.57.1692686274715;
        Mon, 21 Aug 2023 23:37:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902b78900b001b5656b0bf9sm8111412pls.286.2023.08.21.23.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 23:37:54 -0700 (PDT)
Message-ID: <64e457c2.170a0220.f1068.eaa6@mx.google.com>
Date:   Mon, 21 Aug 2023 23:37:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.190-123-gec001faa2c729
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y baseline: 125 runs,
 12 regressions (v5.10.190-123-gec001faa2c729)
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

stable-rc/linux-5.10.y baseline: 125 runs, 12 regressions (v5.10.190-123-ge=
c001faa2c729)

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

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.190-123-gec001faa2c729/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.190-123-gec001faa2c729
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ec001faa2c7293e38e8dcdc5fcce1e8e3298316c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e421e03861668bb3dc962f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e421e03861668bb3dc9634
        failing since 216 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-22T02:47:41.214321  + set +x<8>[   11.152598] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3744915_1.5.2.4.1>
    2023-08-22T02:47:41.214865  =

    2023-08-22T02:47:41.324579  / # #
    2023-08-22T02:47:41.428094  export SHELL=3D/bin/sh
    2023-08-22T02:47:41.429036  #
    2023-08-22T02:47:41.531088  / # export SHELL=3D/bin/sh. /lava-3744915/e=
nvironment
    2023-08-22T02:47:41.531947  =

    2023-08-22T02:47:41.633934  / # . /lava-3744915/environment/lava-374491=
5/bin/lava-test-runner /lava-3744915/1
    2023-08-22T02:47:41.635368  =

    2023-08-22T02:47:41.635823  / # <3>[   11.531919] Bluetooth: hci0: comm=
and 0xfc18 tx timeout =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e422d0c6a0e8a017dc96aa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e422d0c6a0e8a017dc96ad
        failing since 35 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-22T02:51:41.864952  + [   15.141672] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1244668_1.5.2.4.1>
    2023-08-22T02:51:41.865247  set +x
    2023-08-22T02:51:41.971061  =

    2023-08-22T02:51:42.072344  / # #export SHELL=3D/bin/sh
    2023-08-22T02:51:42.072783  =

    2023-08-22T02:51:42.173776  / # export SHELL=3D/bin/sh. /lava-1244668/e=
nvironment
    2023-08-22T02:51:42.174220  =

    2023-08-22T02:51:42.275206  / # . /lava-1244668/environment/lava-124466=
8/bin/lava-test-runner /lava-1244668/1
    2023-08-22T02:51:42.275960  =

    2023-08-22T02:51:42.279258  / # /lava-1244668/bin/lava-test-runner /lav=
a-1244668/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e422facde11c8fb5dc95ed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e422facde11c8fb5dc95f0
        failing since 171 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-22T02:52:15.024247  [   10.637652] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1244669_1.5.2.4.1>
    2023-08-22T02:52:15.129573  =

    2023-08-22T02:52:15.230861  / # #export SHELL=3D/bin/sh
    2023-08-22T02:52:15.231288  =

    2023-08-22T02:52:15.332289  / # export SHELL=3D/bin/sh. /lava-1244669/e=
nvironment
    2023-08-22T02:52:15.332695  =

    2023-08-22T02:52:15.433727  / # . /lava-1244669/environment/lava-124466=
9/bin/lava-test-runner /lava-1244669/1
    2023-08-22T02:52:15.434432  =

    2023-08-22T02:52:15.438297  / # /lava-1244669/bin/lava-test-runner /lav=
a-1244669/1
    2023-08-22T02:52:15.452934  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e420e9de0f204bcddc95da

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e420e9de0f204bcddc95df
        failing since 146 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-22T02:43:48.982483  + set +x

    2023-08-22T02:43:48.988852  <8>[   15.258919] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11328492_1.4.2.3.1>

    2023-08-22T02:43:49.092789  / # #

    2023-08-22T02:43:49.193339  export SHELL=3D/bin/sh

    2023-08-22T02:43:49.193520  #

    2023-08-22T02:43:49.294016  / # export SHELL=3D/bin/sh. /lava-11328492/=
environment

    2023-08-22T02:43:49.294196  =


    2023-08-22T02:43:49.394699  / # . /lava-11328492/environment/lava-11328=
492/bin/lava-test-runner /lava-11328492/1

    2023-08-22T02:43:49.394971  =


    2023-08-22T02:43:49.399886  / # /lava-11328492/bin/lava-test-runner /la=
va-11328492/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e420eade0f204bcddc95e5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e420eade0f204bcddc95ea
        failing since 146 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-22T02:43:40.778307  <8>[   12.925648] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11328529_1.4.2.3.1>

    2023-08-22T02:43:40.781805  + set +x

    2023-08-22T02:43:40.882900  #

    2023-08-22T02:43:40.883152  =


    2023-08-22T02:43:40.983666  / # #export SHELL=3D/bin/sh

    2023-08-22T02:43:40.983815  =


    2023-08-22T02:43:41.084296  / # export SHELL=3D/bin/sh. /lava-11328529/=
environment

    2023-08-22T02:43:41.084460  =


    2023-08-22T02:43:41.184918  / # . /lava-11328529/environment/lava-11328=
529/bin/lava-test-runner /lava-11328529/1

    2023-08-22T02:43:41.185167  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e42302cde11c8fb5dc95f8

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e42303cde11c8fb5dc9634
        new failure (last pass: v5.10.191)

    2023-08-22T02:52:26.774043  <8>[   29.056817] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 63625_1.5.2.4.1>
    2023-08-22T02:52:26.882407  / # #
    2023-08-22T02:52:26.985300  export SHELL=3D/bin/sh
    2023-08-22T02:52:26.986068  #
    2023-08-22T02:52:27.088086  / # export SHELL=3D/bin/sh. /lava-63625/env=
ironment
    2023-08-22T02:52:27.088876  =

    2023-08-22T02:52:27.190879  / # . /lava-63625/environment/lava-63625/bi=
n/lava-test-runner /lava-63625/1
    2023-08-22T02:52:27.192178  =

    2023-08-22T02:52:27.206229  / # /lava-63625/bin/lava-test-runner /lava-=
63625/1
    2023-08-22T02:52:27.265103  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e42365c9f70d7e9edc962e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e42365c9f70d7e9edc9631
        failing since 35 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-22T02:54:04.403180  + set +x
    2023-08-22T02:54:04.403316  <8>[   83.445639] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 999184_1.5.2.4.1>
    2023-08-22T02:54:04.509196  / # #
    2023-08-22T02:54:05.968812  export SHELL=3D/bin/sh
    2023-08-22T02:54:05.989264  #
    2023-08-22T02:54:05.989416  / # export SHELL=3D/bin/sh
    2023-08-22T02:54:07.871170  / # . /lava-999184/environment
    2023-08-22T02:54:11.323169  /lava-999184/bin/lava-test-runner /lava-999=
184/1
    2023-08-22T02:54:11.343941  . /lava-999184/environment
    2023-08-22T02:54:11.344054  / # /lava-999184/bin/lava-test-runner /lava=
-999184/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4247891b4053a50dc95d3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4247891b4053a50dc95d6
        failing since 35 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-22T02:58:42.568744  + set +x
    2023-08-22T02:58:42.568962  <8>[   84.000930] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 999188_1.5.2.4.1>
    2023-08-22T02:58:42.674400  / # #
    2023-08-22T02:58:44.136760  export SHELL=3D/bin/sh
    2023-08-22T02:58:44.157337  #
    2023-08-22T02:58:44.157542  / # export SHELL=3D/bin/sh
    2023-08-22T02:58:46.043734  / # . /lava-999188/environment
    2023-08-22T02:58:49.503319  /lava-999188/bin/lava-test-runner /lava-999=
188/1
    2023-08-22T02:58:49.525039  . /lava-999188/environment
    2023-08-22T02:58:49.525354  / # /lava-999188/bin/lava-test-runner /lava=
-999188/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4231137de57006fdc95ec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek87=
4.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek87=
4.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4231137de57006fdc95ef
        failing since 35 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-22T02:52:53.228158  / # #
    2023-08-22T02:52:54.687626  export SHELL=3D/bin/sh
    2023-08-22T02:52:54.708089  #
    2023-08-22T02:52:54.708206  / # export SHELL=3D/bin/sh
    2023-08-22T02:52:56.590474  / # . /lava-999181/environment
    2023-08-22T02:53:00.042421  /lava-999181/bin/lava-test-runner /lava-999=
181/1
    2023-08-22T02:53:00.063051  . /lava-999181/environment
    2023-08-22T02:53:00.063157  / # /lava-999181/bin/lava-test-runner /lava=
-999181/1
    2023-08-22T02:53:00.139386  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-22T02:53:00.139593  + cd /lava-999181/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e424153dfd872449dc95da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e424153dfd872449dc95dd
        failing since 35 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-22T02:56:54.253862  / # #
    2023-08-22T02:56:55.715660  export SHELL=3D/bin/sh
    2023-08-22T02:56:55.736077  #
    2023-08-22T02:56:55.736204  / # export SHELL=3D/bin/sh
    2023-08-22T02:56:57.617649  / # . /lava-999187/environment
    2023-08-22T02:57:01.073319  /lava-999187/bin/lava-test-runner /lava-999=
187/1
    2023-08-22T02:57:01.094118  . /lava-999187/environment
    2023-08-22T02:57:01.094228  / # /lava-999187/bin/lava-test-runner /lava=
-999187/1
    2023-08-22T02:57:01.173765  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-22T02:57:01.173979  + cd /lava-999187/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e42364fdd96cedd2dc95cc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-=
rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-=
rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e42364fdd96cedd2dc9=
5cd
        new failure (last pass: v5.10.191) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4227d166cdbc4d1dc964a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
90-123-gec001faa2c729/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4227d166cdbc4d1dc964f
        failing since 35 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-22T02:51:53.875255  / # #

    2023-08-22T02:51:53.977216  export SHELL=3D/bin/sh

    2023-08-22T02:51:53.977929  #

    2023-08-22T02:51:54.079343  / # export SHELL=3D/bin/sh. /lava-11328591/=
environment

    2023-08-22T02:51:54.080040  =


    2023-08-22T02:51:54.181413  / # . /lava-11328591/environment/lava-11328=
591/bin/lava-test-runner /lava-11328591/1

    2023-08-22T02:51:54.182407  =


    2023-08-22T02:51:54.199892  / # /lava-11328591/bin/lava-test-runner /la=
va-11328591/1

    2023-08-22T02:51:54.241453  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T02:51:54.257364  + cd /lava-1132859<8>[   18.246987] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11328591_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

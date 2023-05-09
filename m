Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572A86FC8FF
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 16:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjEIO3X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 10:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbjEIO3W (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 10:29:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AB5C3
        for <stable@vger.kernel.org>; Tue,  9 May 2023 07:29:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24e3a0aa408so5362448a91.1
        for <stable@vger.kernel.org>; Tue, 09 May 2023 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683642560; x=1686234560;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4lcSKVcl45vTIyZU6tAXom6SQ9Ax0/ocje5smMT4IM=;
        b=U+BKc2OUB4fta0FlSKU6n88fiE3YPpNqhHzk/SUIuyQi8rIaFsuvlNJ9VY9JiIRn4Q
         4NjcUW7WHsumlhJJiw0TnBXODiTF92EUBtLS0GKxLGhRHF+StpgqgO4Z/lOo3rCQRYwI
         5bC1nLAqxRzaGDqWxrEGusypgsYYn5En/QnfiCSIrZe9iQfUBiQ7kaaKdyjCgwmFzaRo
         WyYE7C20x19sh75EzVa4RX28aoGELwhiXAqf/NzLF8XHFutN5PV9AU4bLdybfSCAg4HK
         EqjoxZhSJ0qIMP7g7KiZCkjDPVoNm9rXki44S4B3ZpRWrykfMPCHF/FTsA6sWqXyRxL6
         SP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683642560; x=1686234560;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4lcSKVcl45vTIyZU6tAXom6SQ9Ax0/ocje5smMT4IM=;
        b=ONW6bDtBCRUU9ma7EADYlcf0Kf4bvuhmVtPkMS0TnXyhc65c2so5WUfNLs5Ozt+RcI
         5VfytyOX8O01yQTwJ75YbJRUOKOLMXLPoHjm5ceqRY5mREKP/NuTr/Vpe7KvBsHUBRgY
         xz7U3h4iMhxPQXzwV0OwWAI3uN+gvXiQHRR32EwYC1cAZ/vp/bxN5dCKdUVnYS3uRhU3
         C2s4Tvzf7q+yAXnVQFE7ehXFQ/0/FY8aPXK0mceHnWFrs5W86pEQe4tU8sWmvWMbSOzv
         nP1DBL57FhrwfWauG+iAep7Lxs7Ec3GfPeMxTtkB0EwnJnG7Hpq/5YJLKMVkU8HM4Hn9
         641w==
X-Gm-Message-State: AC+VfDz2TMGOca0inoS0ry8FtS35DsXU8smEZAyz0lqdwugnSzTu+IiJ
        ZjUO4qVwA5eDPNiAE1ZQiNExnaNpPM8wMXV8j/BicQ==
X-Google-Smtp-Source: ACHHUZ5Ih5euxTBMJ7qb3huCqcyKY8DvWiEMrHowY9HrcNt04BFBY/tSvUdwYNkjlyJVRP1DCcDVmw==
X-Received: by 2002:a17:90b:38c8:b0:23d:500f:e826 with SMTP id nn8-20020a17090b38c800b0023d500fe826mr14110313pjb.14.1683642560168;
        Tue, 09 May 2023 07:29:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id co1-20020a17090afe8100b0024de5227d1fsm11648587pjb.40.2023.05.09.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 07:29:19 -0700 (PDT)
Message-ID: <645a58bf.170a0220.54652.6a1c@mx.google.com>
Date:   Tue, 09 May 2023 07:29:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-658-gc79570f37c8f
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 142 runs,
 4 regressions (v5.10.176-658-gc79570f37c8f)
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

stable-rc/queue/5.10 baseline: 142 runs, 4 regressions (v5.10.176-658-gc795=
70f37c8f)

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
nel/v5.10.176-658-gc79570f37c8f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-658-gc79570f37c8f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c79570f37c8f60746cb70b5573c0f12e08d11ec2 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645a23890b46bdc0b82e860f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-gc79570f37c8f/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-gc79570f37c8f/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a23890b46bdc0b82e8644
        failing since 84 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-05-09T10:42:00.711718  <8>[   19.368182] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 435375_1.5.2.4.1>
    2023-05-09T10:42:00.824282  / # #
    2023-05-09T10:42:00.927450  export SHELL=3D/bin/sh
    2023-05-09T10:42:00.928077  #
    2023-05-09T10:42:01.029707  / # export SHELL=3D/bin/sh. /lava-435375/en=
vironment
    2023-05-09T10:42:01.030456  =

    2023-05-09T10:42:01.132595  / # . /lava-435375/environment/lava-435375/=
bin/lava-test-runner /lava-435375/1
    2023-05-09T10:42:01.134140  =

    2023-05-09T10:42:01.137697  / # /lava-435375/bin/lava-test-runner /lava=
-435375/1
    2023-05-09T10:42:01.242261  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645a309a155bdcf2092e88a2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-gc79570f37c8f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-gc79570f37c8f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a309a155bdcf2092e88a7
        failing since 40 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-09T11:37:49.358799  + set +x

    2023-05-09T11:37:49.365232  <8>[   14.621744] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10255618_1.4.2.3.1>

    2023-05-09T11:37:49.469841  / # #

    2023-05-09T11:37:49.570377  export SHELL=3D/bin/sh

    2023-05-09T11:37:49.570537  #

    2023-05-09T11:37:49.670984  / # export SHELL=3D/bin/sh. /lava-10255618/=
environment

    2023-05-09T11:37:49.671148  =


    2023-05-09T11:37:49.771638  / # . /lava-10255618/environment/lava-10255=
618/bin/lava-test-runner /lava-10255618/1

    2023-05-09T11:37:49.771933  =


    2023-05-09T11:37:49.776564  / # /lava-10255618/bin/lava-test-runner /la=
va-10255618/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645a2a5961a2ebeb042e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-gc79570f37c8f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-gc79570f37c8f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a2a5961a2ebeb042e85eb
        failing since 40 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-09T11:11:02.204160  <8>[   12.797646] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10255652_1.4.2.3.1>

    2023-05-09T11:11:02.207697  + set +x

    2023-05-09T11:11:02.313170  =


    2023-05-09T11:11:02.414779  / # #export SHELL=3D/bin/sh

    2023-05-09T11:11:02.415477  =


    2023-05-09T11:11:02.516032  / # export SHELL=3D/bin/sh. /lava-10255652/=
environment

    2023-05-09T11:11:02.516215  =


    2023-05-09T11:11:02.616762  / # . /lava-10255652/environment/lava-10255=
652/bin/lava-test-runner /lava-10255652/1

    2023-05-09T11:11:02.617023  =


    2023-05-09T11:11:02.622308  / # /lava-10255652/bin/lava-test-runner /la=
va-10255652/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645a239952a8f6803d2e8672

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-gc79570f37c8f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-658-gc79570f37c8f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a239952a8f6803d2e8677
        failing since 96 days (last pass: v5.10.165-139-gefb57ce0f880, firs=
t fail: v5.10.165-149-ge30e8271d674)

    2023-05-09T10:42:08.762928  / # #
    2023-05-09T10:42:08.864840  export SHELL=3D/bin/sh
    2023-05-09T10:42:08.865358  #
    2023-05-09T10:42:08.966680  / # export SHELL=3D/bin/sh. /lava-3567980/e=
nvironment
    2023-05-09T10:42:08.967087  =

    2023-05-09T10:42:09.068445  / # . /lava-3567980/environment/lava-356798=
0/bin/lava-test-runner /lava-3567980/1
    2023-05-09T10:42:09.069154  =

    2023-05-09T10:42:09.075469  / # /lava-3567980/bin/lava-test-runner /lav=
a-3567980/1
    2023-05-09T10:42:09.173304  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-09T10:42:09.173565  + cd /lava-3567980/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

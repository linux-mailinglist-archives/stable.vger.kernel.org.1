Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970C271009F
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 00:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjEXWI5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 18:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjEXWI4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 18:08:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FAC119
        for <stable@vger.kernel.org>; Wed, 24 May 2023 15:08:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2553f2706bfso258076a91.1
        for <stable@vger.kernel.org>; Wed, 24 May 2023 15:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684966133; x=1687558133;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rF9b2TIdSbm014qwndsF5lCp9n6ZPv7UqlDvscHPDgA=;
        b=CfpB6ku88XLQPjLOwAIc3pBhCoHli2A021PYl+w3ihoED4mjFs7Qy0eDpJ1GWWfXTX
         BFz6AiTOS4Tpalm43pfqJa0sXhSqgG3YYIzTp6vj+G2uRfLEMTZHvwejdSXNgQr4I7QR
         6b0IxWfi2aqb5Ux8CyxRtP4zA5Qi3ngIclatVdBNKVe6UHiDTcgwcEH7tucbmaTSm1Sn
         iVKEXL00j8FVmAfJKb9fT/eJtk6psU3E8Gz4/85m95tAJ+QOtfr26kgxycFGtQoaQg50
         UA4skw7HhlYp4peFOx7eW3vNsPhpxW2Y6dO52Orus3Hpry3m8GYc254A4jfEc19rjB2G
         jwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966133; x=1687558133;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rF9b2TIdSbm014qwndsF5lCp9n6ZPv7UqlDvscHPDgA=;
        b=dIHz5I4lFuCUhX6T+tt7LFZWkpkRm0VZDBdDQDqLJFLwq81f3pNBPjhNraL85K5o2s
         OAFe+d//UUUVn1lIKVQ1R0ElzLz8kj5+llDXiqGLcwzaEoyoxBH+JJZoqDtBD1FxCc1M
         xiqbdprJ30+24VDnnRddCHhoi96FC5sY2jOIQElwftM4v9FIzasAjfl/nZ9IOtSoKL9O
         xoqlcALyOMps4D2W/FnzM4gtSNMewGqCC+Kud0b8GuIoemPwekzjuVP2jAqe80QyZmdU
         WeBOsCH19I3sCjsjN03X3xptIwncil4xLSl1j2BobR/70RGlmwXjqgWGEWH6P8fJKxNr
         TWUA==
X-Gm-Message-State: AC+VfDys63HdmaX4etsphdt8NFWjV05PGXugF3HhkEW35qZx6Bm5/Be6
        ndEza2H3LuoSnUgY0XtI8DUsFlQ4+ZNgrLwEe4Q7nA==
X-Google-Smtp-Source: ACHHUZ4cpugH6Jgd+qA9HnEqbBxEGh/wnm/av2y8iXWZuRjlqhZc2r/rLijD82IGMob1D1scSn9CxA==
X-Received: by 2002:a17:90a:fc92:b0:24e:243b:8735 with SMTP id ci18-20020a17090afc9200b0024e243b8735mr713361pjb.13.1684966133112;
        Wed, 24 May 2023 15:08:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b0024de39e8746sm1809468pjt.11.2023.05.24.15.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:08:52 -0700 (PDT)
Message-ID: <646e8af4.170a0220.9978d.394c@mx.google.com>
Date:   Wed, 24 May 2023 15:08:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-203-ge2ce7c03de0b
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 165 runs,
 6 regressions (v5.15.112-203-ge2ce7c03de0b)
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

stable-rc/queue/5.15 baseline: 165 runs, 6 regressions (v5.15.112-203-ge2ce=
7c03de0b)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-203-ge2ce7c03de0b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-203-ge2ce7c03de0b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e2ce7c03de0b60e2a1505919ddcf47ce3d4f3a95 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646e58963499ce3d512e860a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-ge2ce7c03de0b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-ge2ce7c03de0b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e58963499ce3d512e860f
        failing since 57 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-24T18:33:38.059872  + <8>[   11.817038] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10442408_1.4.2.3.1>

    2023-05-24T18:33:38.059961  set +x

    2023-05-24T18:33:38.164060  / # #

    2023-05-24T18:33:38.264658  export SHELL=3D/bin/sh

    2023-05-24T18:33:38.264846  #

    2023-05-24T18:33:38.365378  / # export SHELL=3D/bin/sh. /lava-10442408/=
environment

    2023-05-24T18:33:38.365637  =


    2023-05-24T18:33:38.466198  / # . /lava-10442408/environment/lava-10442=
408/bin/lava-test-runner /lava-10442408/1

    2023-05-24T18:33:38.466506  =


    2023-05-24T18:33:38.471145  / # /lava-10442408/bin/lava-test-runner /la=
va-10442408/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646e588a27d7aa3cb62e85ee

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-ge2ce7c03de0b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-ge2ce7c03de0b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e588a27d7aa3cb62e85f3
        failing since 57 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-24T18:33:22.586346  <8>[   10.830168] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10442423_1.4.2.3.1>

    2023-05-24T18:33:22.589674  + set +x

    2023-05-24T18:33:22.690924  #

    2023-05-24T18:33:22.691222  =


    2023-05-24T18:33:22.791753  / # #export SHELL=3D/bin/sh

    2023-05-24T18:33:22.791925  =


    2023-05-24T18:33:22.892438  / # export SHELL=3D/bin/sh. /lava-10442423/=
environment

    2023-05-24T18:33:22.892629  =


    2023-05-24T18:33:22.993138  / # . /lava-10442423/environment/lava-10442=
423/bin/lava-test-runner /lava-10442423/1

    2023-05-24T18:33:22.993437  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646e5894091ebf2fae2e85f2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-ge2ce7c03de0b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-ge2ce7c03de0b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e5894091ebf2fae2e85f7
        failing since 57 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-24T18:33:36.528306  + set +x

    2023-05-24T18:33:36.535276  <8>[   10.516996] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10442374_1.4.2.3.1>

    2023-05-24T18:33:36.640027  / # #

    2023-05-24T18:33:36.740756  export SHELL=3D/bin/sh

    2023-05-24T18:33:36.740977  #

    2023-05-24T18:33:36.841477  / # export SHELL=3D/bin/sh. /lava-10442374/=
environment

    2023-05-24T18:33:36.841717  =


    2023-05-24T18:33:36.942281  / # . /lava-10442374/environment/lava-10442=
374/bin/lava-test-runner /lava-10442374/1

    2023-05-24T18:33:36.942623  =


    2023-05-24T18:33:36.947147  / # /lava-10442374/bin/lava-test-runner /la=
va-10442374/1
 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646e58817055a650072e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-ge2ce7c03de0b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-ge2ce7c03de0b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e58817055a650072e85ed
        failing since 57 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-24T18:33:24.640353  <8>[   10.805286] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10442361_1.4.2.3.1>

    2023-05-24T18:33:24.643888  + set +x

    2023-05-24T18:33:24.747797  / # #

    2023-05-24T18:33:24.848429  export SHELL=3D/bin/sh

    2023-05-24T18:33:24.848628  #

    2023-05-24T18:33:24.949170  / # export SHELL=3D/bin/sh. /lava-10442361/=
environment

    2023-05-24T18:33:24.949379  =


    2023-05-24T18:33:25.049875  / # . /lava-10442361/environment/lava-10442=
361/bin/lava-test-runner /lava-10442361/1

    2023-05-24T18:33:25.050149  =


    2023-05-24T18:33:25.055713  / # /lava-10442361/bin/lava-test-runner /la=
va-10442361/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646e589618422461212e860e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-ge2ce7c03de0b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-ge2ce7c03de0b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e589618422461212e8613
        failing since 57 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-24T18:33:45.625140  + set<8>[   11.386878] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10442360_1.4.2.3.1>

    2023-05-24T18:33:45.625224   +x

    2023-05-24T18:33:45.729277  / # #

    2023-05-24T18:33:45.829865  export SHELL=3D/bin/sh

    2023-05-24T18:33:45.830031  #

    2023-05-24T18:33:45.930514  / # export SHELL=3D/bin/sh. /lava-10442360/=
environment

    2023-05-24T18:33:45.930697  =


    2023-05-24T18:33:46.031228  / # . /lava-10442360/environment/lava-10442=
360/bin/lava-test-runner /lava-10442360/1

    2023-05-24T18:33:46.031477  =


    2023-05-24T18:33:46.036064  / # /lava-10442360/bin/lava-test-runner /la=
va-10442360/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646e58837055a650072e85fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-ge2ce7c03de0b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-203-ge2ce7c03de0b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646e58837055a650072e8603
        failing since 57 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-24T18:33:27.085524  <8>[   11.808245] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10442414_1.4.2.3.1>

    2023-05-24T18:33:27.189966  / # #

    2023-05-24T18:33:27.290685  export SHELL=3D/bin/sh

    2023-05-24T18:33:27.290918  #

    2023-05-24T18:33:27.391472  / # export SHELL=3D/bin/sh. /lava-10442414/=
environment

    2023-05-24T18:33:27.391703  =


    2023-05-24T18:33:27.492273  / # . /lava-10442414/environment/lava-10442=
414/bin/lava-test-runner /lava-10442414/1

    2023-05-24T18:33:27.492633  =


    2023-05-24T18:33:27.497432  / # /lava-10442414/bin/lava-test-runner /la=
va-10442414/1

    2023-05-24T18:33:27.502595  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =20

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0C4706F15
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 19:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjEQRK5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 13:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEQRK4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 13:10:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB20198E
        for <stable@vger.kernel.org>; Wed, 17 May 2023 10:10:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24e25e2808fso1043917a91.0
        for <stable@vger.kernel.org>; Wed, 17 May 2023 10:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684343453; x=1686935453;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IEVRCT4fvLii290j4luMJB5/efNqp4rP81+XflhKOk0=;
        b=1+5SCaZUtudx8rFa6pVab9QjYlqbEg7z+ewWI7AGpqYGiR5fd1E/83tU46NUOTeoPM
         cJGShiXZ02e6cG6XvIYyM9SPIs52MuP/aOW4gEXU8Q3d59qRC5vvG2Os76zCoI3zTwHH
         JMoLYoEpPpwDyFTxBfZLPVAp65qbATHa2i3Y+2NXBruQU23yt54gA+5RgruMtmJeQJ5f
         FQ30p1vSPqLZxjcB3cOFrJjk1HuwCflTReMI1stL3rFA2tQmFwqCdIO0J3DyRCaVoEow
         1vHl7YG5sdJGy0AqynWoYB6Pr1kxtfvQkyU8hmaDX1kBiixrRKIf4kjwJOT+c8CsY95J
         hoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684343453; x=1686935453;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEVRCT4fvLii290j4luMJB5/efNqp4rP81+XflhKOk0=;
        b=X39yqCbWOaPBuj+y1xM98P0Pl4GkLHAXjkb/vnMpo1NAsquaCdYUYtcb5NxG055tjs
         kBeU5Jv8YftAytjTPiA2XAwHqjQof3IW3jo1Gsyl33hEt9yvwEWgi1h5NBBXfEqTwMfE
         pCQ4DLrMWSFQT1xkrXQGdppkv1Tgc1KecWucBFpW8/g0OopAWbrAodfPSNyuUbfNZAi8
         kRdcCyZY55tcpRFKNk0bFaud97hJYskjSy5Z26wiEt19TVSg6bAASvrPSRDbKF6EVJLV
         BPDHECXJ1kKyieXemN7g6pTD62i1CJJRdpqG4GKp8XZibNumPr4t60ff0XOq9lB7uKuv
         sjUg==
X-Gm-Message-State: AC+VfDxxeJk2CVzjqZBZCdXXzEQRT5Hd6vStDzrdibxgtHrO0paQVW7K
        ogudp8Oe5c1Y9OfmUB+RW7w6Abs6Judm+7uxK+R9IQ==
X-Google-Smtp-Source: ACHHUZ5SdE0Nl/fwSgZkHFhvDr1HUevXJBq/QJriB6MP7A+JB2nSevXMzOdZuG5WCEIRd/OnPAJ+XA==
X-Received: by 2002:a17:90a:6fe4:b0:253:30e1:7d68 with SMTP id e91-20020a17090a6fe400b0025330e17d68mr446557pjk.0.1684343453369;
        Wed, 17 May 2023 10:10:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a0f8a00b0024e06a71ef5sm1880059pjz.56.2023.05.17.10.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:10:52 -0700 (PDT)
Message-ID: <64650a9c.170a0220.7b3b2.37e2@mx.google.com>
Date:   Wed, 17 May 2023 10:10:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.28-238-gdbf289700968
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 157 runs,
 9 regressions (v6.1.28-238-gdbf289700968)
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

stable-rc/queue/6.1 baseline: 157 runs, 9 regressions (v6.1.28-238-gdbf2897=
00968)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

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

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.28-238-gdbf289700968/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.28-238-gdbf289700968
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      dbf28970096864c0ec4b766abcf46c9223c3b1a1 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464d8f2cd131534822e865a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464d8f2cd131534822e865f
        failing since 49 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-17T13:38:37.856267  <8>[   13.887093] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10354709_1.4.2.3.1>

    2023-05-17T13:38:37.859915  + set +x

    2023-05-17T13:38:37.964434  / # #

    2023-05-17T13:38:38.065243  export SHELL=3D/bin/sh

    2023-05-17T13:38:38.065465  #

    2023-05-17T13:38:38.165979  / # export SHELL=3D/bin/sh. /lava-10354709/=
environment

    2023-05-17T13:38:38.166185  =


    2023-05-17T13:38:38.266771  / # . /lava-10354709/environment/lava-10354=
709/bin/lava-test-runner /lava-10354709/1

    2023-05-17T13:38:38.267052  =


    2023-05-17T13:38:38.273072  / # /lava-10354709/bin/lava-test-runner /la=
va-10354709/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464d8c6f40007e28e2e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464d8c6f40007e28e2e85ed
        failing since 49 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-17T13:37:56.983042  + set<8>[   11.981074] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10354703_1.4.2.3.1>

    2023-05-17T13:37:56.983150   +x

    2023-05-17T13:37:57.087656  / # #

    2023-05-17T13:37:57.188243  export SHELL=3D/bin/sh

    2023-05-17T13:37:57.188434  #

    2023-05-17T13:37:57.288964  / # export SHELL=3D/bin/sh. /lava-10354703/=
environment

    2023-05-17T13:37:57.289154  =


    2023-05-17T13:37:57.389686  / # . /lava-10354703/environment/lava-10354=
703/bin/lava-test-runner /lava-10354703/1

    2023-05-17T13:37:57.389993  =


    2023-05-17T13:37:57.394313  / # /lava-10354703/bin/lava-test-runner /la=
va-10354703/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464d8ded28758eb8d2e860a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464d8ded28758eb8d2e860f
        failing since 49 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-17T13:38:23.215565  <8>[    9.922737] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10354731_1.4.2.3.1>

    2023-05-17T13:38:23.218463  + set +x

    2023-05-17T13:38:23.323322  / # #

    2023-05-17T13:38:23.423978  export SHELL=3D/bin/sh

    2023-05-17T13:38:23.424194  #

    2023-05-17T13:38:23.524728  / # export SHELL=3D/bin/sh. /lava-10354731/=
environment

    2023-05-17T13:38:23.524891  =


    2023-05-17T13:38:23.625358  / # . /lava-10354731/environment/lava-10354=
731/bin/lava-test-runner /lava-10354731/1

    2023-05-17T13:38:23.625695  =


    2023-05-17T13:38:23.630575  / # /lava-10354731/bin/lava-test-runner /la=
va-10354731/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464da3011a84e97012e8627

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464da3011a84e97012e862c
        failing since 49 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-17T13:43:57.895154  + set +x

    2023-05-17T13:43:57.901883  <8>[   11.189886] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10354678_1.4.2.3.1>

    2023-05-17T13:43:58.006521  / # #

    2023-05-17T13:43:58.107110  export SHELL=3D/bin/sh

    2023-05-17T13:43:58.107319  #

    2023-05-17T13:43:58.207851  / # export SHELL=3D/bin/sh. /lava-10354678/=
environment

    2023-05-17T13:43:58.208056  =


    2023-05-17T13:43:58.308554  / # . /lava-10354678/environment/lava-10354=
678/bin/lava-test-runner /lava-10354678/1

    2023-05-17T13:43:58.308863  =


    2023-05-17T13:43:58.313304  / # /lava-10354678/bin/lava-test-runner /la=
va-10354678/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464da0b2fe34da3772e8609

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464da0b2fe34da3772e860e
        failing since 49 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-17T13:43:19.333311  + set +x

    2023-05-17T13:43:19.339597  <8>[   10.575541] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10354695_1.4.2.3.1>

    2023-05-17T13:43:19.445170  / # #

    2023-05-17T13:43:19.545812  export SHELL=3D/bin/sh

    2023-05-17T13:43:19.546079  #

    2023-05-17T13:43:19.646724  / # export SHELL=3D/bin/sh. /lava-10354695/=
environment

    2023-05-17T13:43:19.647024  =


    2023-05-17T13:43:19.747691  / # . /lava-10354695/environment/lava-10354=
695/bin/lava-test-runner /lava-10354695/1

    2023-05-17T13:43:19.748145  =


    2023-05-17T13:43:19.753190  / # /lava-10354695/bin/lava-test-runner /la=
va-10354695/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464d8cc41e9fbff862e864f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464d8cc41e9fbff862e8654
        failing since 49 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-17T13:38:00.703971  + set<8>[   11.355964] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10354718_1.4.2.3.1>

    2023-05-17T13:38:00.704050   +x

    2023-05-17T13:38:00.808811  / # #

    2023-05-17T13:38:00.909429  export SHELL=3D/bin/sh

    2023-05-17T13:38:00.909613  #

    2023-05-17T13:38:01.010074  / # export SHELL=3D/bin/sh. /lava-10354718/=
environment

    2023-05-17T13:38:01.010257  =


    2023-05-17T13:38:01.110728  / # . /lava-10354718/environment/lava-10354=
718/bin/lava-test-runner /lava-10354718/1

    2023-05-17T13:38:01.111007  =


    2023-05-17T13:38:01.116109  / # /lava-10354718/bin/lava-test-runner /la=
va-10354718/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464d8bcb8380b40c32e861d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464d8bcb8380b40c32e8622
        failing since 49 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-17T13:37:53.147845  <8>[   11.397432] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10354673_1.4.2.3.1>

    2023-05-17T13:37:53.252439  / # #

    2023-05-17T13:37:53.353071  export SHELL=3D/bin/sh

    2023-05-17T13:37:53.353267  #

    2023-05-17T13:37:53.453783  / # export SHELL=3D/bin/sh. /lava-10354673/=
environment

    2023-05-17T13:37:53.453971  =


    2023-05-17T13:37:53.554498  / # . /lava-10354673/environment/lava-10354=
673/bin/lava-test-runner /lava-10354673/1

    2023-05-17T13:37:53.554775  =


    2023-05-17T13:37:53.559381  / # /lava-10354673/bin/lava-test-runner /la=
va-10354673/1

    2023-05-17T13:37:53.566202  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6464d64f80c0d1dcc22e8603

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.28-23=
8-gdbf289700968/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6464d64f80c0d1dcc22e861f
        failing since 10 days (last pass: v6.1.22-704-ga3dcd1f09de2, first =
fail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-17T13:27:13.845919  /lava-10354282/1/../bin/lava-test-case

    2023-05-17T13:27:13.852267  <8>[   22.916981] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464d64f80c0d1dcc22e86ab
        failing since 10 days (last pass: v6.1.22-704-ga3dcd1f09de2, first =
fail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-17T13:27:08.373040  + set +x

    2023-05-17T13:27:08.379847  <8>[   17.442986] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10354282_1.5.2.3.1>

    2023-05-17T13:27:08.485539  / # #

    2023-05-17T13:27:08.586424  export SHELL=3D/bin/sh

    2023-05-17T13:27:08.586709  #

    2023-05-17T13:27:08.687339  / # export SHELL=3D/bin/sh. /lava-10354282/=
environment

    2023-05-17T13:27:08.687620  =


    2023-05-17T13:27:08.788271  / # . /lava-10354282/environment/lava-10354=
282/bin/lava-test-runner /lava-10354282/1

    2023-05-17T13:27:08.788599  =


    2023-05-17T13:27:08.792933  / # /lava-10354282/bin/lava-test-runner /la=
va-10354282/1
 =

    ... (12 line(s) more)  =

 =20

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F29B6F9159
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjEFLEH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 07:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjEFLEG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 07:04:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4EE59D7
        for <stable@vger.kernel.org>; Sat,  6 May 2023 04:04:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aaf2ede38fso26516535ad.2
        for <stable@vger.kernel.org>; Sat, 06 May 2023 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683371041; x=1685963041;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cgIsWqu6555SGd9emL3rwj1rJ9G2BkrkXJYAApaaGxA=;
        b=2mgBsMf9uH8udpMCu5JBZ4AMQNK+p5lItV46PYJKJxAUntPW5m/HQWjSNEubWvJMwU
         ITmuJNa7pZe7w3di3kvrQGysF0NGTjC1Yw7QuxQrterckveKPSGGYivjjg97XY3Ftp4K
         sbX9CKZRpNttzt84qHW9LO+rYxRHwqwyMSjCY494fBb8mdaIvFREuGxtBWSvZXgxL9Ao
         8OWPqNFp37L/z76w8EDzaJQML0oQxQeN2GvwE8PL23TLna40f2xT6U8e4rDbTgU/STk/
         INZx2TKWMOUBBCxTCs088/BjN4HJtSv2bB1/FoMTvrVglChYOnNLad/+f4IMcoSCMV+m
         IYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683371041; x=1685963041;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgIsWqu6555SGd9emL3rwj1rJ9G2BkrkXJYAApaaGxA=;
        b=ZqZhmzXYfo+0zQnykaTQ7PXT5f+rlbGAY8lP2Oe6Ua+8P3dmGB7gpBVUwzEtY3BblB
         m9DcoLqDMjCKALwn6enLilS8zkspH93VpNmIMztYtq0YBliohXY/orxg2TvgHbLpmaqY
         J9ih2WOcIXdPnMxPtqM7MT3EOQludnEozQQd5Pg2X7h+Q1I55MeFh/IJbetPoDEBq1jC
         8PZCNpdj5frrZ8KWQorE03mEQmGN94I+evZrwqKI1U6k3xnonrjwbu2wbfqRoqDtuNJc
         /22dPkBuhIMvksIbQ5euPORd1JdXfzmjZI6ts0GF0sdeqC/r302yhfhoJVajZb3TTNU8
         x4nQ==
X-Gm-Message-State: AC+VfDzttw1JVHIRWpCi+ciO775/UecZdMY0iWyVrRw+byxGxZ3bVLjk
        Pn7nClEPx6xYQAeW7jSsMOSjRAHdcwPEJrnt+7XZOg==
X-Google-Smtp-Source: ACHHUZ6on9VsSrT33RaxW9NjmP/hE3dbH5LXtwZvqjRmfpzKzZRhPco/L8P+gYPa4mgGonT9KwUusA==
X-Received: by 2002:a17:902:d483:b0:1ac:4bd1:cb69 with SMTP id c3-20020a170902d48300b001ac4bd1cb69mr3256983plg.5.1683371041465;
        Sat, 06 May 2023 04:04:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b001a5260a6e6csm3362024plg.206.2023.05.06.04.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 04:04:00 -0700 (PDT)
Message-ID: <64563420.170a0220.ce375.649a@mx.google.com>
Date:   Sat, 06 May 2023 04:04:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-676-g4511bf086ccf
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 162 runs,
 7 regressions (v6.1.22-676-g4511bf086ccf)
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

stable-rc/queue/6.1 baseline: 162 runs, 7 regressions (v6.1.22-676-g4511bf0=
86ccf)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.22-676-g4511bf086ccf/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-676-g4511bf086ccf
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4511bf086ccf99828b4f3f2273a260d1d8884a84 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6455fcee1c3d7f3f122e8628

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-67=
6-g4511bf086ccf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-67=
6-g4511bf086ccf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6455fcee1c3d7f3f122e862d
        failing since 38 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-06T07:08:12.636815  + set +x

    2023-05-06T07:08:12.643381  <8>[   10.197718] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10213607_1.4.2.3.1>

    2023-05-06T07:08:12.751456  / # #

    2023-05-06T07:08:12.853955  export SHELL=3D/bin/sh

    2023-05-06T07:08:12.854830  #

    2023-05-06T07:08:12.956479  / # export SHELL=3D/bin/sh. /lava-10213607/=
environment

    2023-05-06T07:08:12.957272  =


    2023-05-06T07:08:13.058765  / # . /lava-10213607/environment/lava-10213=
607/bin/lava-test-runner /lava-10213607/1

    2023-05-06T07:08:13.060105  =


    2023-05-06T07:08:13.065555  / # /lava-10213607/bin/lava-test-runner /la=
va-10213607/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6455fcdf08862507a82e862c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-67=
6-g4511bf086ccf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-67=
6-g4511bf086ccf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6455fcdf08862507a82e8631
        failing since 38 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-06T07:07:59.530333  + set +x<8>[   11.356594] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10213581_1.4.2.3.1>

    2023-05-06T07:07:59.530813  =


    2023-05-06T07:07:59.638759  / # #

    2023-05-06T07:07:59.740088  export SHELL=3D/bin/sh

    2023-05-06T07:07:59.740875  #

    2023-05-06T07:07:59.842413  / # export SHELL=3D/bin/sh. /lava-10213581/=
environment

    2023-05-06T07:07:59.843204  =


    2023-05-06T07:07:59.944872  / # . /lava-10213581/environment/lava-10213=
581/bin/lava-test-runner /lava-10213581/1

    2023-05-06T07:07:59.946183  =


    2023-05-06T07:07:59.951348  / # /lava-10213581/bin/lava-test-runner /la=
va-10213581/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6455fcd606a76b5ac52e863c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-67=
6-g4511bf086ccf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-67=
6-g4511bf086ccf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6455fcd606a76b5ac52e8641
        failing since 38 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-06T07:07:51.724836  <8>[   10.294443] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10213656_1.4.2.3.1>

    2023-05-06T07:07:51.728033  + set +x

    2023-05-06T07:07:51.829287  #

    2023-05-06T07:07:51.829626  =


    2023-05-06T07:07:51.930245  / # #export SHELL=3D/bin/sh

    2023-05-06T07:07:51.930483  =


    2023-05-06T07:07:52.031048  / # export SHELL=3D/bin/sh. /lava-10213656/=
environment

    2023-05-06T07:07:52.031229  =


    2023-05-06T07:07:52.131768  / # . /lava-10213656/environment/lava-10213=
656/bin/lava-test-runner /lava-10213656/1

    2023-05-06T07:07:52.132086  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6455fd2b3d0dd9244d2e8625

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-67=
6-g4511bf086ccf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-67=
6-g4511bf086ccf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6455fd2b3d0dd9244d2e862a
        failing since 38 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-06T07:09:16.961488  + set +x

    2023-05-06T07:09:16.967770  <8>[   10.328410] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10213586_1.4.2.3.1>

    2023-05-06T07:09:17.075360  / # #

    2023-05-06T07:09:17.176644  export SHELL=3D/bin/sh

    2023-05-06T07:09:17.177373  #

    2023-05-06T07:09:17.278762  / # export SHELL=3D/bin/sh. /lava-10213586/=
environment

    2023-05-06T07:09:17.279508  =


    2023-05-06T07:09:17.381020  / # . /lava-10213586/environment/lava-10213=
586/bin/lava-test-runner /lava-10213586/1

    2023-05-06T07:09:17.382159  =


    2023-05-06T07:09:17.386717  / # /lava-10213586/bin/lava-test-runner /la=
va-10213586/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6455fccc100be996392e8632

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-67=
6-g4511bf086ccf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-67=
6-g4511bf086ccf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6455fccc100be996392e8637
        failing since 38 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-06T07:07:39.263142  <8>[   10.118505] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10213629_1.4.2.3.1>

    2023-05-06T07:07:39.266477  + set +x

    2023-05-06T07:07:39.370990  / # #

    2023-05-06T07:07:39.471531  export SHELL=3D/bin/sh

    2023-05-06T07:07:39.471718  #

    2023-05-06T07:07:39.572185  / # export SHELL=3D/bin/sh. /lava-10213629/=
environment

    2023-05-06T07:07:39.572361  =


    2023-05-06T07:07:39.672844  / # . /lava-10213629/environment/lava-10213=
629/bin/lava-test-runner /lava-10213629/1

    2023-05-06T07:07:39.673100  =


    2023-05-06T07:07:39.678635  / # /lava-10213629/bin/lava-test-runner /la=
va-10213629/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6455fce51c3d7f3f122e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-67=
6-g4511bf086ccf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-67=
6-g4511bf086ccf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6455fce51c3d7f3f122e85fb
        failing since 38 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-06T07:07:59.789315  + <8>[   10.742479] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10213565_1.4.2.3.1>

    2023-05-06T07:07:59.789409  set +x

    2023-05-06T07:07:59.893512  / # #

    2023-05-06T07:07:59.994117  export SHELL=3D/bin/sh

    2023-05-06T07:07:59.994302  #

    2023-05-06T07:08:00.094784  / # export SHELL=3D/bin/sh. /lava-10213565/=
environment

    2023-05-06T07:08:00.094996  =


    2023-05-06T07:08:00.195513  / # . /lava-10213565/environment/lava-10213=
565/bin/lava-test-runner /lava-10213565/1

    2023-05-06T07:08:00.195777  =


    2023-05-06T07:08:00.200531  / # /lava-10213565/bin/lava-test-runner /la=
va-10213565/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6455fccd06a76b5ac52e85fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-67=
6-g4511bf086ccf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-67=
6-g4511bf086ccf/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6455fccd06a76b5ac52e8603
        failing since 38 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-06T07:07:46.204917  + set<8>[   12.127666] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10213575_1.4.2.3.1>

    2023-05-06T07:07:46.205001   +x

    2023-05-06T07:07:46.309032  / # #

    2023-05-06T07:07:46.409591  export SHELL=3D/bin/sh

    2023-05-06T07:07:46.409729  #

    2023-05-06T07:07:46.510243  / # export SHELL=3D/bin/sh. /lava-10213575/=
environment

    2023-05-06T07:07:46.510430  =


    2023-05-06T07:07:46.610939  / # . /lava-10213575/environment/lava-10213=
575/bin/lava-test-runner /lava-10213575/1

    2023-05-06T07:07:46.611158  =


    2023-05-06T07:07:46.616063  / # /lava-10213575/bin/lava-test-runner /la=
va-10213575/1
 =

    ... (12 line(s) more)  =

 =20

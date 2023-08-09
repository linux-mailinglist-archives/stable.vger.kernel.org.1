Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6921D774FB7
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 02:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjHIAMI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 20:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjHIAMH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 20:12:07 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F7E1BCF
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 17:12:06 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc7e65ea44so2872985ad.1
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 17:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691539925; x=1692144725;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5kdDfpKiR++hd2Uzw/XX22DO6ZCeWTXGgQ9dFi7pXMc=;
        b=o17DdgiIew6W8/9h+76XmxLKEskloE+pPhE+lsezV21v6WGnRuhwCBctWfH8XUotaZ
         V2NSHos2ej4k1YzjiYGIZ2sc8soUgZBU6POsOF+vk62d+ceCkuXS8fZmJR/7dGCvLp52
         961+idwPFbZCFr9GduV7Vxav4WX4/27SAmkeVRPwyXGDiEf20vmIXSh9UjUAwzPtsvnn
         Nqbz5ZlZYdulbOrh+dl1O+ZaDXxIIka8sUPUMcD/JTZvP8y58wqb/NvSXqDyZIhfpuAH
         K31vZZP+M3UxNRXJ4TGJvfAiuQ8iH6peMJscIb88zYukdRRo+6kUtyzC4ceW4wx1rZO1
         2pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691539925; x=1692144725;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kdDfpKiR++hd2Uzw/XX22DO6ZCeWTXGgQ9dFi7pXMc=;
        b=bwtJb7vH9tAOIVdxXwaLLEXFtzuvbii4YEEnFTgoi6VW9dPClbhs7olhYveb+eLtil
         0QFcaCGpmjKUjc48qXDyyYUBnARELDbwAvpFpVmJnURrFsa0zWFzSYWdZrHh7FBTvbPJ
         vsPSiN6w4W0zJjXhF61w84mEJtF0Zd0JG4EyjKXGFRedwR0iiDOHAfh8eAeMK9IR+KKU
         bk9BfPJK80cg/bF1XUdaS3Spx3oEuuleqBNUeU3dsnqSGrzb5wMBPKwk17idppLhxYbE
         XeRZZosQlyx0OQEDTpp/X8bzw/+qCE0Q4bOysHSkA9iPRZzThwWv2FFAwXsQyEAbQ7Z/
         KlSg==
X-Gm-Message-State: AOJu0Ywy/rj2zynVsFrpRscCen93fNT2mG0PneilT3t2y9AE4OhJxXtw
        rxNfcwI0G7aDFvh+VVIoezpq+A0EdLgqK3Cpg74bdA==
X-Google-Smtp-Source: AGHT+IHdjhUJxxqosOYJtI1wM7VB3i79Xp0v69+JhSbftWZMDTTxcaweBP7SGumts2stfDVIkjMcHg==
X-Received: by 2002:a17:903:32c6:b0:1ae:6947:e63b with SMTP id i6-20020a17090332c600b001ae6947e63bmr1663850plr.16.1691539924939;
        Tue, 08 Aug 2023 17:12:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709028f8a00b001bba7aab838sm9601511plo.162.2023.08.08.17.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:12:04 -0700 (PDT)
Message-ID: <64d2d9d4.170a0220.cc4b1.221e@mx.google.com>
Date:   Tue, 08 Aug 2023 17:12:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.44
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-6.1.y
Subject: stable/linux-6.1.y baseline: 118 runs, 11 regressions (v6.1.44)
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

stable/linux-6.1.y baseline: 118 runs, 11 regressions (v6.1.44)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

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

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.44/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      0a4a7855302d56a1d75cec3aa9a6914a3af9c6af =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a92b2ac8201ef835b1ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2a92b2ac8201ef835b=
1ef
        failing since 12 days (last pass: v6.1.39, first fail: v6.1.42) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a90291a6dbd4ac35b207

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a90291a6dbd4ac35b20c
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-08T20:43:30.304534  <8>[   10.082841] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11236602_1.4.2.3.1>

    2023-08-08T20:43:30.308124  + set +x

    2023-08-08T20:43:30.416229  / # #

    2023-08-08T20:43:30.518768  export SHELL=3D/bin/sh

    2023-08-08T20:43:30.519553  #

    2023-08-08T20:43:30.621149  / # export SHELL=3D/bin/sh. /lava-11236602/=
environment

    2023-08-08T20:43:30.621945  =


    2023-08-08T20:43:30.723726  / # . /lava-11236602/environment/lava-11236=
602/bin/lava-test-runner /lava-11236602/1

    2023-08-08T20:43:30.725046  =


    2023-08-08T20:43:30.730391  / # /lava-11236602/bin/lava-test-runner /la=
va-11236602/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a8fc91a6dbd4ac35b1fa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a8fc91a6dbd4ac35b1ff
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-08T20:43:24.091597  + set<8>[   11.970121] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11236608_1.4.2.3.1>

    2023-08-08T20:43:24.092104   +x

    2023-08-08T20:43:24.198114  / # #

    2023-08-08T20:43:24.300146  export SHELL=3D/bin/sh

    2023-08-08T20:43:24.300830  #

    2023-08-08T20:43:24.402156  / # export SHELL=3D/bin/sh. /lava-11236608/=
environment

    2023-08-08T20:43:24.402846  =


    2023-08-08T20:43:24.504334  / # . /lava-11236608/environment/lava-11236=
608/bin/lava-test-runner /lava-11236608/1

    2023-08-08T20:43:24.505381  =


    2023-08-08T20:43:24.510626  / # /lava-11236608/bin/lava-test-runner /la=
va-11236608/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a8f310f3806b3235b220

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a8f310f3806b3235b225
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-08T20:43:21.654254  <8>[   10.135290] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11236619_1.4.2.3.1>

    2023-08-08T20:43:21.657559  + set +x

    2023-08-08T20:43:21.759170  #

    2023-08-08T20:43:21.759512  =


    2023-08-08T20:43:21.860154  / # #export SHELL=3D/bin/sh

    2023-08-08T20:43:21.860449  =


    2023-08-08T20:43:21.961077  / # export SHELL=3D/bin/sh. /lava-11236619/=
environment

    2023-08-08T20:43:21.961325  =


    2023-08-08T20:43:22.061903  / # . /lava-11236619/environment/lava-11236=
619/bin/lava-test-runner /lava-11236619/1

    2023-08-08T20:43:22.062259  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a8dc9231d4de6b35b214

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a8dc9231d4de6b35b219
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-08T20:43:03.253934  + set +x

    2023-08-08T20:43:03.260367  <8>[   11.258840] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11236581_1.4.2.3.1>

    2023-08-08T20:43:03.364529  / # #

    2023-08-08T20:43:03.465124  export SHELL=3D/bin/sh

    2023-08-08T20:43:03.465337  #

    2023-08-08T20:43:03.565788  / # export SHELL=3D/bin/sh. /lava-11236581/=
environment

    2023-08-08T20:43:03.566009  =


    2023-08-08T20:43:03.666509  / # . /lava-11236581/environment/lava-11236=
581/bin/lava-test-runner /lava-11236581/1

    2023-08-08T20:43:03.666778  =


    2023-08-08T20:43:03.671542  / # /lava-11236581/bin/lava-test-runner /la=
va-11236581/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a8ee10f3806b3235b211

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a8ee10f3806b3235b216
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-08T20:43:13.593498  <8>[   10.581953] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11236623_1.4.2.3.1>

    2023-08-08T20:43:13.596635  + set +x

    2023-08-08T20:43:13.697817  #

    2023-08-08T20:43:13.798552  / # #export SHELL=3D/bin/sh

    2023-08-08T20:43:13.798739  =


    2023-08-08T20:43:13.899267  / # export SHELL=3D/bin/sh. /lava-11236623/=
environment

    2023-08-08T20:43:13.899465  =


    2023-08-08T20:43:13.999979  / # . /lava-11236623/environment/lava-11236=
623/bin/lava-test-runner /lava-11236623/1

    2023-08-08T20:43:14.000261  =


    2023-08-08T20:43:14.005262  / # /lava-11236623/bin/lava-test-runner /la=
va-11236623/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a8f191a6dbd4ac35b1ed

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a8f191a6dbd4ac35b1f2
        failing since 131 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-08T20:43:10.085308  + set<8>[   12.249438] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11236618_1.4.2.3.1>

    2023-08-08T20:43:10.085391   +x

    2023-08-08T20:43:10.189850  / # #

    2023-08-08T20:43:10.290510  export SHELL=3D/bin/sh

    2023-08-08T20:43:10.290707  #

    2023-08-08T20:43:10.391204  / # export SHELL=3D/bin/sh. /lava-11236618/=
environment

    2023-08-08T20:43:10.391403  =


    2023-08-08T20:43:10.491903  / # /lava-11236618/bin/lava-test-runner /la=
va-11236618/1

    2023-08-08T20:43:10.492296  . /lava-11236618/environment

    2023-08-08T20:43:10.496784  // # /lava11236618/bin/lava-test-runner /la=
va-11236618/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a42d93d3355d5235b1de

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/arm=
/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/arm=
/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2a42d93d3355d5235b=
1df
        new failure (last pass: v6.1.42) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a6ebf748626b8235b218

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a6ebf748626b8235b21d
        failing since 20 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-08-08T20:36:15.989345  / # #

    2023-08-08T20:36:16.091343  export SHELL=3D/bin/sh

    2023-08-08T20:36:16.092038  #

    2023-08-08T20:36:16.193479  / # export SHELL=3D/bin/sh. /lava-11236517/=
environment

    2023-08-08T20:36:16.194169  =


    2023-08-08T20:36:16.295469  / # . /lava-11236517/environment/lava-11236=
517/bin/lava-test-runner /lava-11236517/1

    2023-08-08T20:36:16.296429  =


    2023-08-08T20:36:16.299012  / # /lava-11236517/bin/lava-test-runner /la=
va-11236517/1

    2023-08-08T20:36:16.361064  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-08T20:36:16.361508  + cd /lav<8>[   19.130580] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11236517_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a715f748626b8235b2aa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a715f748626b8235b2af
        failing since 20 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-08-08T20:35:26.148964  / # #

    2023-08-08T20:35:27.228731  export SHELL=3D/bin/sh

    2023-08-08T20:35:27.230610  #

    2023-08-08T20:35:28.720854  / # export SHELL=3D/bin/sh. /lava-11236509/=
environment

    2023-08-08T20:35:28.722730  =


    2023-08-08T20:35:31.445240  / # . /lava-11236509/environment/lava-11236=
509/bin/lava-test-runner /lava-11236509/1

    2023-08-08T20:35:31.447381  =


    2023-08-08T20:35:31.454973  / # /lava-11236509/bin/lava-test-runner /la=
va-11236509/1

    2023-08-08T20:35:31.515604  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-08T20:35:31.516109  + cd /lava-112365<8>[   28.519702] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11236509_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2a6fef748626b8235b224

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.44/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2a6fef748626b8235b229
        failing since 20 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-08-08T20:36:28.704213  / # #

    2023-08-08T20:36:28.806374  export SHELL=3D/bin/sh

    2023-08-08T20:36:28.807081  #

    2023-08-08T20:36:28.908416  / # export SHELL=3D/bin/sh. /lava-11236510/=
environment

    2023-08-08T20:36:28.909096  =


    2023-08-08T20:36:29.010458  / # . /lava-11236510/environment/lava-11236=
510/bin/lava-test-runner /lava-11236510/1

    2023-08-08T20:36:29.011537  =


    2023-08-08T20:36:29.028371  / # /lava-11236510/bin/lava-test-runner /la=
va-11236510/1

    2023-08-08T20:36:29.094439  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-08T20:36:29.094942  + cd /lava-11236510/1/tests/1_boot<8>[   16=
.958756] <LAVA_SIGNAL_STARTRUN 1_bootrr 11236510_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

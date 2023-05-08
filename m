Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3914F6FB346
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 16:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjEHOw0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 10:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjEHOwY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 10:52:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424774EEB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 07:52:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaec9ad820so43509565ad.0
        for <stable@vger.kernel.org>; Mon, 08 May 2023 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683557541; x=1686149541;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e8qWBHzTcojdOIl4/x2HAAYOFapi7HtN1TMHS2jE8zU=;
        b=cPwbSLiSPHKryl3zyuQ8Nhcw5Xv4MvKUdNhfUYRbXTSEPhCb6/YGtSshzonwy0dvvP
         WU2ezAJLY4/K/IWxmesxaTUIMArwjCh7RdaPGR7uF4Wp8ee+2DZk5ajJCpRpvndVgvRo
         nl9t8ymSZPI4RDC5rC7ySokQpEr4n7drNAuZXsoFRrPdwH4L3EYs2EfsT7/mVL8nzs4a
         NPlioNAngyWMvjd4vIAsLysPkS4fK0tXO4htWKlT9yjfsbjpvHrLA3moPSXj1TKSuON3
         FYWd7aXdgnboIOMimZe+VmWLlqTaUKyZSEl5zrrKhXLXncRpKNE1Pcz588eCr7TzC5rf
         6rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683557541; x=1686149541;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8qWBHzTcojdOIl4/x2HAAYOFapi7HtN1TMHS2jE8zU=;
        b=KWTjR7PWMC7Y/6GFbm7Ha9X7A3KZ74CSe7pnDyHMTfUkpo3stE/tmMRmwYNAkqKYrZ
         BIjJzxiA+VZT7fJ5NqTZlptLrhTnUA5zX60kO3mf0mNR8uSdMW0fvW3B6AvU4iJBsTaH
         eB6zA3UeNV5IFPI38c/zmFBlQotWYN409OYRv/3wlhfBVtK4nBYWbcLjcmC4WB0/G5vI
         RCPogfXR2MBbXzmtkt5m19qAwFtDmGQGKbJIcn51wrM5+NUBwfJT6dl5F1hYMq6FRQbx
         6YPDDP0mdp2Hfj32xJZWLzV2lIY5i5St0XAP0B5K1BmNNTpUk6fLa8/t7spD71QTGmNR
         qboA==
X-Gm-Message-State: AC+VfDwNxGU0uacxZ0Pc+BIRiTTO1Y5PTpceIZDCv3FA5frHaALcLAn2
        hYC6qxNruA262M69KEHJ8xYb0YOnxpz+j7jkUKzywA==
X-Google-Smtp-Source: ACHHUZ6rSf2xulLBExb160yDq3Ci+0CJfpcrhPYN/9mtTX8e0XNReWlXYIRhkbynLvT6vOZ4bKGNBA==
X-Received: by 2002:a17:902:e806:b0:1ac:727b:3a60 with SMTP id u6-20020a170902e80600b001ac727b3a60mr4788269plg.4.1683557540797;
        Mon, 08 May 2023 07:52:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jo18-20020a170903055200b001a6a53c3b04sm7370719plb.306.2023.05.08.07.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:52:19 -0700 (PDT)
Message-ID: <64590ca3.170a0220.8f202.ca2f@mx.google.com>
Date:   Mon, 08 May 2023 07:52:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-1197-g23b4e75cdd2e3
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 160 runs,
 9 regressions (v6.1.22-1197-g23b4e75cdd2e3)
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

stable-rc/linux-6.1.y baseline: 160 runs, 9 regressions (v6.1.22-1197-g23b4=
e75cdd2e3)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.22-1197-g23b4e75cdd2e3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.22-1197-g23b4e75cdd2e3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      23b4e75cdd2e3ffb10d11095d2d96a9ba14c2d4c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457cd044c144027112e864d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457cd044c144027112e8652
        failing since 38 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-07T16:08:17.954197  + set +x

    2023-05-07T16:08:17.961078  <8>[   12.241248] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10229658_1.4.2.3.1>

    2023-05-07T16:08:18.065222  / # #

    2023-05-07T16:08:18.165842  export SHELL=3D/bin/sh

    2023-05-07T16:08:18.166033  #

    2023-05-07T16:08:18.266543  / # export SHELL=3D/bin/sh. /lava-10229658/=
environment

    2023-05-07T16:08:18.266734  =


    2023-05-07T16:08:18.367234  / # . /lava-10229658/environment/lava-10229=
658/bin/lava-test-runner /lava-10229658/1

    2023-05-07T16:08:18.367504  =


    2023-05-07T16:08:18.373059  / # /lava-10229658/bin/lava-test-runner /la=
va-10229658/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457cd024c144027112e8630

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457cd024c144027112e8635
        failing since 38 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-07T16:08:14.541113  + set<8>[   11.425905] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10229671_1.4.2.3.1>

    2023-05-07T16:08:14.541201   +x

    2023-05-07T16:08:14.645313  / # #

    2023-05-07T16:08:14.745966  export SHELL=3D/bin/sh

    2023-05-07T16:08:14.746187  #

    2023-05-07T16:08:14.846705  / # export SHELL=3D/bin/sh. /lava-10229671/=
environment

    2023-05-07T16:08:14.846885  =


    2023-05-07T16:08:14.947390  / # . /lava-10229671/environment/lava-10229=
671/bin/lava-test-runner /lava-10229671/1

    2023-05-07T16:08:14.947663  =


    2023-05-07T16:08:14.952305  / # /lava-10229671/bin/lava-test-runner /la=
va-10229671/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457ccf705a1a2a05f2e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457ccf705a1a2a05f2e8611
        failing since 38 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-07T16:08:03.181091  <8>[   10.189040] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10229672_1.4.2.3.1>

    2023-05-07T16:08:03.184573  + set +x

    2023-05-07T16:08:03.285745  #

    2023-05-07T16:08:03.386489  / # #export SHELL=3D/bin/sh

    2023-05-07T16:08:03.386692  =


    2023-05-07T16:08:03.487255  / # export SHELL=3D/bin/sh. /lava-10229672/=
environment

    2023-05-07T16:08:03.487441  =


    2023-05-07T16:08:03.588000  / # . /lava-10229672/environment/lava-10229=
672/bin/lava-test-runner /lava-10229672/1

    2023-05-07T16:08:03.588265  =


    2023-05-07T16:08:03.593318  / # /lava-10229672/bin/lava-test-runner /la=
va-10229672/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457cceb7c897d15ba2e8609

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457cceb7c897d15ba2e860e
        failing since 38 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-07T16:08:02.668426  + set +x

    2023-05-07T16:08:02.674930  <8>[   11.309651] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10229651_1.4.2.3.1>

    2023-05-07T16:08:02.779883  / # #

    2023-05-07T16:08:02.880598  export SHELL=3D/bin/sh

    2023-05-07T16:08:02.880813  #

    2023-05-07T16:08:02.981343  / # export SHELL=3D/bin/sh. /lava-10229651/=
environment

    2023-05-07T16:08:02.981591  =


    2023-05-07T16:08:03.082275  / # . /lava-10229651/environment/lava-10229=
651/bin/lava-test-runner /lava-10229651/1

    2023-05-07T16:08:03.082620  =


    2023-05-07T16:08:03.087571  / # /lava-10229651/bin/lava-test-runner /la=
va-10229651/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457ccf1c1c96ce2c92e8633

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457ccf1c1c96ce2c92e8638
        failing since 38 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-07T16:08:01.782168  <8>[   10.592305] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10229688_1.4.2.3.1>

    2023-05-07T16:08:01.785700  + set +x

    2023-05-07T16:08:01.887627  #

    2023-05-07T16:08:01.888003  =


    2023-05-07T16:08:01.988777  / # #export SHELL=3D/bin/sh

    2023-05-07T16:08:01.989048  =


    2023-05-07T16:08:02.089679  / # export SHELL=3D/bin/sh. /lava-10229688/=
environment

    2023-05-07T16:08:02.089940  =


    2023-05-07T16:08:02.190583  / # . /lava-10229688/environment/lava-10229=
688/bin/lava-test-runner /lava-10229688/1

    2023-05-07T16:08:02.190992  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457cd014c144027112e8625

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457cd014c144027112e862a
        failing since 38 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-07T16:08:11.170143  + set<8>[   11.348666] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10229674_1.4.2.3.1>

    2023-05-07T16:08:11.170237   +x

    2023-05-07T16:08:11.275322  / # #

    2023-05-07T16:08:11.375984  export SHELL=3D/bin/sh

    2023-05-07T16:08:11.376217  #

    2023-05-07T16:08:11.476741  / # export SHELL=3D/bin/sh. /lava-10229674/=
environment

    2023-05-07T16:08:11.476951  =


    2023-05-07T16:08:11.577455  / # . /lava-10229674/environment/lava-10229=
674/bin/lava-test-runner /lava-10229674/1

    2023-05-07T16:08:11.577783  =


    2023-05-07T16:08:11.582610  / # /lava-10229674/bin/lava-test-runner /la=
va-10229674/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457cceec904a662a52e85eb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457cceec904a662a52e85f0
        failing since 38 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-07T16:07:59.884728  <8>[    9.723843] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10229659_1.4.2.3.1>

    2023-05-07T16:07:59.989462  / # #

    2023-05-07T16:08:00.090042  export SHELL=3D/bin/sh

    2023-05-07T16:08:00.090260  #

    2023-05-07T16:08:00.190765  / # export SHELL=3D/bin/sh. /lava-10229659/=
environment

    2023-05-07T16:08:00.191032  =


    2023-05-07T16:08:00.291534  / # . /lava-10229659/environment/lava-10229=
659/bin/lava-test-runner /lava-10229659/1

    2023-05-07T16:08:00.291971  =


    2023-05-07T16:08:00.296250  / # /lava-10229659/bin/lava-test-runner /la=
va-10229659/1

    2023-05-07T16:08:00.302801  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6457ca7090e7f5c3482e8608

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1197-g23b4e75cdd2e3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6457ca7090e7f5c3482e8624
        new failure (last pass: v6.1.22-574-ge4ff6ff54dea)

    2023-05-07T15:57:15.933306  /lava-10229513/1/../bin/lava-test-case

    2023-05-07T15:57:15.939754  <8>[   23.029216] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457ca7090e7f5c3482e86b0
        new failure (last pass: v6.1.22-574-ge4ff6ff54dea)

    2023-05-07T15:57:10.488820  + set +x

    2023-05-07T15:57:10.494927  <8>[   17.583277] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10229513_1.5.2.3.1>

    2023-05-07T15:57:10.602846  / # #

    2023-05-07T15:57:10.703826  export SHELL=3D/bin/sh

    2023-05-07T15:57:10.704155  #

    2023-05-07T15:57:10.804825  / # export SHELL=3D/bin/sh. /lava-10229513/=
environment

    2023-05-07T15:57:10.805168  =


    2023-05-07T15:57:10.905863  / # . /lava-10229513/environment/lava-10229=
513/bin/lava-test-runner /lava-10229513/1

    2023-05-07T15:57:10.906353  =


    2023-05-07T15:57:10.911068  / # /lava-10229513/bin/lava-test-runner /la=
va-10229513/1
 =

    ... (13 line(s) more)  =

 =20

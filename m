Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEFD70751F
	for <lists+stable@lfdr.de>; Thu, 18 May 2023 00:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjEQWLh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 18:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEQWLg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 18:11:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB98026B9
        for <stable@vger.kernel.org>; Wed, 17 May 2023 15:11:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1adc913094aso13816155ad.0
        for <stable@vger.kernel.org>; Wed, 17 May 2023 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684361494; x=1686953494;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WmVL4e+U2C0w4Vn3Jq4giOE2hcOBrJ5MRkzj7eGuUtA=;
        b=R/gjQJ+KpLp9w2qCXNpzaAvm+VwRXbJ8A1HaAakU2TXBbX+BEGfW+bbyNr/8zCUW+q
         Hcev8YMQu8sgaeCz6B4sxGITBfYMbKfIzxeMPllDCODYAUZAmHEd6oT8XFx0/eHIcB8P
         kVq9T78qKovpm1ay1lmPDeBD5LgOLiFNHKKe+kfp4ArBaXMhJAG4O55FVW3nVPMMtwe8
         hhHaa+NVGYLi+jo6bHxlceFV9HS5q+GIZNgeev+wMPp1TJD+9pKCNPdn69D0ZOHN2mqa
         nFjvYiAf4lHL7Wygthr3jrwzXvlCVhc/hwVae/xkiWvdrtcyfTtVe1DuCZ/DDEz9xGuy
         pHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684361494; x=1686953494;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmVL4e+U2C0w4Vn3Jq4giOE2hcOBrJ5MRkzj7eGuUtA=;
        b=ccnFav7SYbVzb7d6gVdwKiokZKmQl0LPMy1ZNksybEVppK0kxGQtrHqMzEJcA78XWe
         6cF+8JPcprL+/xLbBzWfiRkxBJZb2dAo/J3oRHY5Wkr9fmRaBKgz8086cPV7EUbGpKRv
         yVwwzM9GcnPLQIuyDBcdH6rnKOtIrQmJ4Dn0bMSVCKUsxxq97nShqEm2u4ysH4HOZzps
         kChIaxt+3f0wCyM+EtKubFyIereUxYzyuUs+K0ExMC1NxliTbh4gE4oDqHsZVflAf4ZV
         njJfWPR0XIHorNh/n+5w+4WEm07gAKaXxuqp4Pvq5jeRrGiR+kajjLx2sxrKgbT9XWbM
         hMfA==
X-Gm-Message-State: AC+VfDxx0XMZTgiM1RHMbVpxVcVWPNBiUY0AVHf3mmSQ28xhSwIi4FQw
        ZKruobft9O+QY/Kl5sBpeDV19ND4VQZ1Ge8SA5zwPQ==
X-Google-Smtp-Source: ACHHUZ6YtoIzr93HpJ4ZLcctCJhFMW/xgcFJ/Ia5QaauT/1VrSEl8jSN+aot6FJi4dMKwFyBbKxU/A==
X-Received: by 2002:a17:903:32c8:b0:1ac:7345:f254 with SMTP id i8-20020a17090332c800b001ac7345f254mr339446plr.33.1684361493754;
        Wed, 17 May 2023 15:11:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b001a6c15cad12sm1623751plh.166.2023.05.17.15.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 15:11:33 -0700 (PDT)
Message-ID: <64655115.170a0220.c207e.359b@mx.google.com>
Date:   Wed, 17 May 2023 15:11:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 153 runs, 6 regressions (v5.15.112)
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

stable-rc/queue/5.15 baseline: 153 runs, 6 regressions (v5.15.112)

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
nel/v5.15.112/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      9d6bde853685609a631871d7c12be94fdf8d912e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64651d129e2c6f2eb12e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-=
CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-=
CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64651d129e2c6f2eb12e85ee
        failing since 50 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-17T18:29:19.373341  + set<8>[   11.568937] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10359926_1.4.2.3.1>

    2023-05-17T18:29:19.373531   +x

    2023-05-17T18:29:19.478621  / # #

    2023-05-17T18:29:19.581208  export SHELL=3D/bin/sh

    2023-05-17T18:29:19.581992  #

    2023-05-17T18:29:19.683601  / # export SHELL=3D/bin/sh. /lava-10359926/=
environment

    2023-05-17T18:29:19.684389  =


    2023-05-17T18:29:19.786038  / # . /lava-10359926/environment/lava-10359=
926/bin/lava-test-runner /lava-10359926/1

    2023-05-17T18:29:19.787293  =


    2023-05-17T18:29:19.792335  / # /lava-10359926/bin/lava-test-runner /la=
va-10359926/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64651d09d63a8e6a6f2e85fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-=
cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-=
cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64651d09d63a8e6a6f2e8602
        failing since 50 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-17T18:29:21.989381  <8>[   11.124725] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10359972_1.4.2.3.1>

    2023-05-17T18:29:21.992463  + set +x

    2023-05-17T18:29:22.093984  =


    2023-05-17T18:29:22.194679  / # #export SHELL=3D/bin/sh

    2023-05-17T18:29:22.194965  =


    2023-05-17T18:29:22.295527  / # export SHELL=3D/bin/sh. /lava-10359972/=
environment

    2023-05-17T18:29:22.295753  =


    2023-05-17T18:29:22.396437  / # . /lava-10359972/environment/lava-10359=
972/bin/lava-test-runner /lava-10359972/1

    2023-05-17T18:29:22.396734  =


    2023-05-17T18:29:22.401632  / # /lava-10359972/bin/lava-test-runner /la=
va-10359972/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64651d270681ec1c0b2e8633

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64651d270681ec1c0b2e8638
        failing since 50 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-17T18:29:39.930114  + <8>[   10.638614] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10359987_1.4.2.3.1>

    2023-05-17T18:29:39.930218  set +x

    2023-05-17T18:29:40.031894  =


    2023-05-17T18:29:40.132528  / # #export SHELL=3D/bin/sh

    2023-05-17T18:29:40.132714  =


    2023-05-17T18:29:40.233364  / # export SHELL=3D/bin/sh. /lava-10359987/=
environment

    2023-05-17T18:29:40.234224  =


    2023-05-17T18:29:40.336026  / # . /lava-10359987/environment/lava-10359=
987/bin/lava-test-runner /lava-10359987/1

    2023-05-17T18:29:40.336354  =


    2023-05-17T18:29:40.341074  / # /lava-10359987/bin/lava-test-runner /la=
va-10359987/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64651d120681ec1c0b2e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64651d120681ec1c0b2e85f8
        failing since 50 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-17T18:29:18.137862  <8>[   10.549024] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10359962_1.4.2.3.1>

    2023-05-17T18:29:18.141172  + set +x

    2023-05-17T18:29:18.242670  =


    2023-05-17T18:29:18.343233  / # #export SHELL=3D/bin/sh

    2023-05-17T18:29:18.343412  =


    2023-05-17T18:29:18.443982  / # export SHELL=3D/bin/sh. /lava-10359962/=
environment

    2023-05-17T18:29:18.444443  =


    2023-05-17T18:29:18.545619  / # . /lava-10359962/environment/lava-10359=
962/bin/lava-test-runner /lava-10359962/1

    2023-05-17T18:29:18.546773  =


    2023-05-17T18:29:18.551927  / # /lava-10359962/bin/lava-test-runner /la=
va-10359962/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64651d2633cd5a37892e861a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x3=
60-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64651d2633cd5a37892e861f
        failing since 50 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-17T18:29:39.807053  + set<8>[   10.901606] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10359959_1.4.2.3.1>

    2023-05-17T18:29:39.807146   +x

    2023-05-17T18:29:39.911135  / # #

    2023-05-17T18:29:40.011805  export SHELL=3D/bin/sh

    2023-05-17T18:29:40.012016  #

    2023-05-17T18:29:40.112543  / # export SHELL=3D/bin/sh. /lava-10359959/=
environment

    2023-05-17T18:29:40.112743  =


    2023-05-17T18:29:40.213277  / # . /lava-10359959/environment/lava-10359=
959/bin/lava-test-runner /lava-10359959/1

    2023-05-17T18:29:40.213605  =


    2023-05-17T18:29:40.218564  / # /lava-10359959/bin/lava-test-runner /la=
va-10359959/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64651d24cd7bc0fc672e8634

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenov=
o-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenov=
o-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64651d24cd7bc0fc672e8639
        failing since 50 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-17T18:29:39.849010  + set<8>[   11.024211] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10359994_1.4.2.3.1>

    2023-05-17T18:29:39.849560   +x

    2023-05-17T18:29:39.957167  / # #

    2023-05-17T18:29:40.059754  export SHELL=3D/bin/sh

    2023-05-17T18:29:40.060573  #

    2023-05-17T18:29:40.162148  / # export SHELL=3D/bin/sh. /lava-10359994/=
environment

    2023-05-17T18:29:40.162970  =


    2023-05-17T18:29:40.264769  / # . /lava-10359994/environment/lava-10359=
994/bin/lava-test-runner /lava-10359994/1

    2023-05-17T18:29:40.266075  =


    2023-05-17T18:29:40.271468  / # /lava-10359994/bin/lava-test-runner /la=
va-10359994/1
 =

    ... (12 line(s) more)  =

 =20

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6E36F97D8
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 11:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjEGJKK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 05:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjEGJKJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 05:10:09 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E8D3C14
        for <stable@vger.kernel.org>; Sun,  7 May 2023 02:10:06 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso3071834a12.1
        for <stable@vger.kernel.org>; Sun, 07 May 2023 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683450605; x=1686042605;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=li1VPGN0OX5c77WHNEVCP4lewFhAnXjFvi7lWufgGgg=;
        b=Nk4E2+nphTAQeYoUXzotDifbuz4u/0lLLYDec8+iS4P3eYzOCEZSXEhb+8cc1yQtg/
         5Odojn3/oQw56bJimHlBOWW1Ksmls5NgJqEzrpERP7+2MczWmCT7Y6LmceJX+pMPPp1T
         UxS1itv3eWxbz7K9iuYQKlb+nS3dkX1TEFg007WLlOhRa2bnuwQ4iRSCixGNnOXlp69W
         hzSiy20/uQoKRiNZ5fac92n+1E3wM3HLFg1kcfMuJZKwyoil+36Cs1YRi7RruMVeIiLa
         PfjBETEzJY0zv56WhnG9mrxQVceCagI+dHJ5Dq23qxcdZZWnf/LVSrLmeYMRTOfjv+0Q
         seKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683450605; x=1686042605;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=li1VPGN0OX5c77WHNEVCP4lewFhAnXjFvi7lWufgGgg=;
        b=Zr8SGhEoPy1IZsOiTUCTq7kbN+/bk6pKGtvqSM3TPyMhWnXTGs9PIgySVDBjazl6wO
         6XKInGWAYY2/pu05BalKeoCBal7539gHoGm/YsCWZ0F47m6aMEZ34uzJNz4oeJlCzAhx
         yxuF+WHWs3U2hq54+uv+mudTR2B9qkZWWJMQ5E01EVJfoerc1qKmryr3yMCaTjVDi4wK
         fM2rcfkj8Gb21zGpkVeMlK9S5Emi1sfkbXqZb2lVdHh7v9bt3c0T76hpWrNRmiTewmhh
         z7FIAv1vys6cnoHiXajkwvFzDbMuNm0vImQ7sE3FxScBp8RqbIKYXZcd/Y4OgjlxrXUv
         /WmQ==
X-Gm-Message-State: AC+VfDxcfvTCDxTKXBLq/Dy5otg86fEm++XOuiRDxZ5sRnHpHfSVComT
        5KIshNHbKjgJgOdXVDag2IXu+l6+Ax0XzY7FKGAWHQ==
X-Google-Smtp-Source: ACHHUZ7xtmkXwt5/HQBdSWyGnagG5fLLCoyM7sI9dV7KDq+tzR7pvvcuGDNZx+KaFh5zqUzZlHyFYw==
X-Received: by 2002:a05:6a20:6a2a:b0:f4:d4a8:9c82 with SMTP id p42-20020a056a206a2a00b000f4d4a89c82mr8693040pzk.47.1683450605498;
        Sun, 07 May 2023 02:10:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a7-20020aa78647000000b005a8bf239f5csm4152479pfo.193.2023.05.07.02.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 02:10:05 -0700 (PDT)
Message-ID: <64576aed.a70a0220.d4a55.78f2@mx.google.com>
Date:   Sun, 07 May 2023 02:10:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-1160-g97929780b450
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 163 runs,
 9 regressions (v6.1.22-1160-g97929780b450)
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

stable-rc/queue/6.1 baseline: 163 runs, 9 regressions (v6.1.22-1160-g979297=
80b450)

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
el/v6.1.22-1160-g97929780b450/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-1160-g97929780b450
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      97929780b4506f15f1fa15a83d42db889e0bd8ee =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457375488a9f61b4e2e85ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457375488a9f61b4e2e85ef
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T05:29:36.324845  + set +x

    2023-05-07T05:29:36.331209  <8>[   11.503202] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10222871_1.4.2.3.1>

    2023-05-07T05:29:36.435557  / # #

    2023-05-07T05:29:36.536203  export SHELL=3D/bin/sh

    2023-05-07T05:29:36.536449  #

    2023-05-07T05:29:36.637009  / # export SHELL=3D/bin/sh. /lava-10222871/=
environment

    2023-05-07T05:29:36.637223  =


    2023-05-07T05:29:36.737773  / # . /lava-10222871/environment/lava-10222=
871/bin/lava-test-runner /lava-10222871/1

    2023-05-07T05:29:36.738054  =


    2023-05-07T05:29:36.744234  / # /lava-10222871/bin/lava-test-runner /la=
va-10222871/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64573750081898ed0e2e85fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64573750081898ed0e2e8602
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T05:29:30.965532  <8>[   11.284897] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10222846_1.4.2.3.1>

    2023-05-07T05:29:31.073744  / # #

    2023-05-07T05:29:31.176276  export SHELL=3D/bin/sh

    2023-05-07T05:29:31.177108  #

    2023-05-07T05:29:31.278541  / # export SHELL=3D/bin/sh. /lava-10222846/=
environment

    2023-05-07T05:29:31.279321  =


    2023-05-07T05:29:31.380914  / # . /lava-10222846/environment/lava-10222=
846/bin/lava-test-runner /lava-10222846/1

    2023-05-07T05:29:31.382118  =


    2023-05-07T05:29:31.387340  / # /lava-10222846/bin/lava-test-runner /la=
va-10222846/1

    2023-05-07T05:29:31.394405  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457374a1d14d823ba2e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457374a1d14d823ba2e85f8
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T05:29:34.983183  <8>[   11.487328] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10222844_1.4.2.3.1>

    2023-05-07T05:29:34.986794  + set +x

    2023-05-07T05:29:35.092655  #

    2023-05-07T05:29:35.093960  =


    2023-05-07T05:29:35.196145  / # #export SHELL=3D/bin/sh

    2023-05-07T05:29:35.196956  =


    2023-05-07T05:29:35.298502  / # export SHELL=3D/bin/sh. /lava-10222844/=
environment

    2023-05-07T05:29:35.298726  =


    2023-05-07T05:29:35.399542  / # . /lava-10222844/environment/lava-10222=
844/bin/lava-test-runner /lava-10222844/1

    2023-05-07T05:29:35.400785  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457373d74e58d18382e8627

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457373d74e58d18382e862c
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T05:29:23.598199  + set +x

    2023-05-07T05:29:23.604291  <8>[   11.016164] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10222816_1.4.2.3.1>

    2023-05-07T05:29:23.708976  / # #

    2023-05-07T05:29:23.809570  export SHELL=3D/bin/sh

    2023-05-07T05:29:23.809807  #

    2023-05-07T05:29:23.910321  / # export SHELL=3D/bin/sh. /lava-10222816/=
environment

    2023-05-07T05:29:23.910520  =


    2023-05-07T05:29:24.011081  / # . /lava-10222816/environment/lava-10222=
816/bin/lava-test-runner /lava-10222816/1

    2023-05-07T05:29:24.011488  =


    2023-05-07T05:29:24.015687  / # /lava-10222816/bin/lava-test-runner /la=
va-10222816/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457373c74e58d18382e861c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457373c74e58d18382e8621
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T05:29:15.235389  + set +x

    2023-05-07T05:29:15.242371  <8>[    8.075865] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10222847_1.4.2.3.1>

    2023-05-07T05:29:15.345419  #

    2023-05-07T05:29:15.345869  =


    2023-05-07T05:29:15.446674  / # #export SHELL=3D/bin/sh

    2023-05-07T05:29:15.446964  =


    2023-05-07T05:29:15.547602  / # export SHELL=3D/bin/sh. /lava-10222847/=
environment

    2023-05-07T05:29:15.547885  =


    2023-05-07T05:29:15.648532  / # . /lava-10222847/environment/lava-10222=
847/bin/lava-test-runner /lava-10222847/1

    2023-05-07T05:29:15.648973  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645737511d14d823ba2e8614

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645737511d14d823ba2e8619
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T05:29:32.187907  + set<8>[   10.813034] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10222822_1.4.2.3.1>

    2023-05-07T05:29:32.188406   +x

    2023-05-07T05:29:32.295856  / # #

    2023-05-07T05:29:32.396833  export SHELL=3D/bin/sh

    2023-05-07T05:29:32.397590  #

    2023-05-07T05:29:32.499034  / # export SHELL=3D/bin/sh. /lava-10222822/=
environment

    2023-05-07T05:29:32.499707  =


    2023-05-07T05:29:32.601090  / # . /lava-10222822/environment/lava-10222=
822/bin/lava-test-runner /lava-10222822/1

    2023-05-07T05:29:32.602266  =


    2023-05-07T05:29:32.607363  / # /lava-10222822/bin/lava-test-runner /la=
va-10222822/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457373930551476ca2e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457373930551476ca2e85f6
        failing since 39 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-07T05:29:17.909600  <8>[   12.278388] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10222818_1.4.2.3.1>

    2023-05-07T05:29:18.014177  / # #

    2023-05-07T05:29:18.114848  export SHELL=3D/bin/sh

    2023-05-07T05:29:18.115010  #

    2023-05-07T05:29:18.215482  / # export SHELL=3D/bin/sh. /lava-10222818/=
environment

    2023-05-07T05:29:18.215641  =


    2023-05-07T05:29:18.316172  / # . /lava-10222818/environment/lava-10222=
818/bin/lava-test-runner /lava-10222818/1

    2023-05-07T05:29:18.316670  =


    2023-05-07T05:29:18.321084  / # /lava-10222818/bin/lava-test-runner /la=
va-10222818/1

    2023-05-07T05:29:18.327832  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6457389798f8caf9ad2e8655

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-11=
60-g97929780b450/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6457389798f8caf9ad2e866d
        failing since 0 day (last pass: v6.1.22-704-ga3dcd1f09de2, first fa=
il: v6.1.22-1160-g24230ce6f2e2)

    2023-05-07T05:35:02.271366  /lava-10222974/1/../bin/lava-test-case

    2023-05-07T05:35:02.277977  <8>[   23.091645] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457389798f8caf9ad2e86fd
        failing since 0 day (last pass: v6.1.22-704-ga3dcd1f09de2, first fa=
il: v6.1.22-1160-g24230ce6f2e2)

    2023-05-07T05:34:56.775770  + set +x

    2023-05-07T05:34:56.782023  <8>[   17.594622] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10222974_1.5.2.3.1>

    2023-05-07T05:34:56.886458  / # #

    2023-05-07T05:34:56.987021  export SHELL=3D/bin/sh

    2023-05-07T05:34:56.987191  #

    2023-05-07T05:34:57.087710  / # export SHELL=3D/bin/sh. /lava-10222974/=
environment

    2023-05-07T05:34:57.087875  =


    2023-05-07T05:34:57.188422  / # . /lava-10222974/environment/lava-10222=
974/bin/lava-test-runner /lava-10222974/1

    2023-05-07T05:34:57.188693  =


    2023-05-07T05:34:57.193626  / # /lava-10222974/bin/lava-test-runner /la=
va-10222974/1
 =

    ... (13 line(s) more)  =

 =20

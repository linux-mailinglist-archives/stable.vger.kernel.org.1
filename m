Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C989735655
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 14:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjFSMA3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 08:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFSMA2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 08:00:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A2A10B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 05:00:24 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b4f9583404so26959275ad.2
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687176023; x=1689768023;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uwbWeGJJpOfFqXJ3j1yxlH2y8S859eber5FC6hDNlv8=;
        b=ez5Io1lB7CvNyT0Q6wToBfL7xKG9zAoxpxh9tMKXZ9BeCHUl9idu4GQ7G7G2wyJ8Ky
         ZJc4SlNW9vjs4up7v+WE7aXJ6Sz1m9g27DWLpTQ8GeKZXte2SyyhJ4wVto/njtyybD7V
         4WTgyh+iWZkTfAxMSLSsL/ypg4NpEZOwgUGtheXCZpKvuFC+pWCcTuaPLGf/a88V66jJ
         ZhiCJ/n2mWxCEY3iqwfIXRwIWu3AN/bW66pq6ixiFMAyTHGrKhPuh11/yWOGdzmIjFIY
         dQGUId1/r9u9vbSZRRK0YGXWkDe+61buZMH9ouMLJS7ZINA5YUiaRhDSEmKc5GGdIqD1
         RkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687176023; x=1689768023;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwbWeGJJpOfFqXJ3j1yxlH2y8S859eber5FC6hDNlv8=;
        b=On2JxET4924kStNph6BCdYtVq+DJjbdVBfIMAW4l+dDYqlFgOLr4mc/uMge8uLpQW/
         9NKEL8MzEok0XKe31BlqpwUS4H17+IBtbkpYzE11tDFFGdsqC7nmzyychczHAmA5p3le
         SnrMEB3DGmjlHhC/a9RSzi8GD81DOW3oW3STyu5T3OZI4uFEKMoGJUBxZm+4Riz8ESph
         aaXZDmVVf7kqCEmbqI9GwQeu/CWU4nVmw+dX7534rGUfbAaXDOjSl3RCmlGN/yFSEKu9
         a6zRo1SfX+PeiIuFf62LK5A1c3Ao6ZAWuWOZholxwCwBNTZ1LRJmOppHh/ett/kUxMUh
         Pjcg==
X-Gm-Message-State: AC+VfDxzCmtLk9aIDHa5RTs+f6T361822KN6wUbfa8ae0ZePMOwqJDUM
        p5X2NGVYgeNhf1tj6JX9z1jO5OckUhxiOXiIceQIrfki
X-Google-Smtp-Source: ACHHUZ6u47+xBHF4K+hUHFTWDZOnAIRddMSMowxn61iuSF+FCHPgpAYJSg+3riCfttXrT0DdqQA3xQ==
X-Received: by 2002:a17:902:a3c7:b0:1b5:361:cefe with SMTP id q7-20020a170902a3c700b001b50361cefemr8375098plb.52.1687176022500;
        Mon, 19 Jun 2023 05:00:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709028a8500b001b50f35aff1sm8377070plo.140.2023.06.19.05.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 05:00:21 -0700 (PDT)
Message-ID: <64904355.170a0220.12717.0aa7@mx.google.com>
Date:   Mon, 19 Jun 2023 05:00:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.286-48-g7e26030d4609a
Subject: stable-rc/linux-4.19.y baseline: 144 runs,
 33 regressions (v4.19.286-48-g7e26030d4609a)
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

stable-rc/linux-4.19.y baseline: 144 runs, 33 regressions (v4.19.286-48-g7e=
26030d4609a)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
beaglebone-black           | arm   | lab-broonie   | gcc-10   | omap2plus_d=
efconfig        | 1          =

cubietruck                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

r8a7743-iwg20d-q7          | arm   | lab-cip       | gcc-10   | shmobile_de=
fconfig         | 1          =

r8a7795-salvator-x         | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =

rk3328-rock64              | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =

rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 2          =

sun50i-a64-pine64-plus     | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =

sun50i-a64-pine64-plus     | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.286-48-g7e26030d4609a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.286-48-g7e26030d4609a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      7e26030d4609a742c0035766a82feb26867abb65 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
beaglebone-black           | arm   | lab-broonie   | gcc-10   | omap2plus_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/64900c7130e3b7102430615b

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64900c7130e3b71024306188
        failing since 0 day (last pass: v4.19.286-29-gacd426462533, first f=
ail: v4.19.286-45-g139662f212a6)

    2023-06-19T08:05:49.147079  + set +x<8>[   18.083451] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 629541_1.5.2.4.1>
    2023-06-19T08:05:49.147414  =

    2023-06-19T08:05:49.257933  / # #
    2023-06-19T08:05:49.359961  export SHELL=3D/bin/sh
    2023-06-19T08:05:49.360570  #
    2023-06-19T08:05:49.462531  / # export SHELL=3D/bin/sh. /lava-629541/en=
vironment
    2023-06-19T08:05:49.462982  =

    2023-06-19T08:05:49.564629  / # . /lava-629541/environment/lava-629541/=
bin/lava-test-runner /lava-629541/1
    2023-06-19T08:05:49.565565  =

    2023-06-19T08:05:49.570275  / # /lava-629541/bin/lava-test-runner /lava=
-629541/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
cubietruck                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/64900cc78da606441a306185

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64900cc78da606441a30618a
        failing since 153 days (last pass: v4.19.268-50-gbf741d1d7e6d, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-06-19T08:07:01.401521  <8>[    7.236577] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3676243_1.5.2.4.1>
    2023-06-19T08:07:01.510788  / # #
    2023-06-19T08:07:01.612284  export SHELL=3D/bin/sh
    2023-06-19T08:07:01.612673  #
    2023-06-19T08:07:01.713868  / # export SHELL=3D/bin/sh. /lava-3676243/e=
nvironment
    2023-06-19T08:07:01.714235  =

    2023-06-19T08:07:01.815437  / # . /lava-3676243/environment/lava-367624=
3/bin/lava-test-runner /lava-3676243/1
    2023-06-19T08:07:01.816159  =

    2023-06-19T08:07:01.820954  / # /lava-3676243/bin/lava-test-runner /lav=
a-3676243/1
    2023-06-19T08:07:01.900378  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6490137c3335ca8e423061cc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6490137c3335ca8e42306=
1cd
        failing since 307 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255-191-gab9c8d4442969) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6490141c6d7012377830614a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6490141c6d70123778306=
14b
        failing since 405 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/649014430cc169e60d3061bc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649014430cc169e60d306=
1bd
        failing since 307 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255-191-gab9c8d4442969) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649015fbb728ab8c5130614f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649015fbb728ab8c51306=
150
        failing since 405 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/649013733335ca8e42306197

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649013733335ca8e42306=
198
        failing since 307 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255-191-gab9c8d4442969) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649014bdd336fc9882306158

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649014bdd336fc9882306=
159
        failing since 405 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6490137b3335ca8e423061c9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6490137b3335ca8e42306=
1ca
        failing since 293 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.256-37-g34c3cf0160a8) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64901407476279f72d30618d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64901407476279f72d306=
18e
        failing since 405 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6490142f266877ab9e30613e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6490142f266877ab9e306=
13f
        failing since 293 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.256-37-g34c3cf0160a8) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649015e7b04522d56f306139

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649015e7b04522d56f306=
13a
        failing since 405 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/64901365ec1f70383f306169

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64901365ec1f70383f306=
16a
        failing since 293 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.256-37-g34c3cf0160a8) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649014bcd336fc9882306155

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649014bcd336fc9882306=
156
        failing since 405 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/649013693335ca8e4230615e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649013693335ca8e42306=
15f
        failing since 319 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.254) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6490141e0cc169e60d30612f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6490141e0cc169e60d306=
130
        failing since 405 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/649013df1152efe73d306139

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649013df1152efe73d306=
13a
        failing since 319 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.254) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649016106be479744530616c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649016106be4797445306=
16d
        failing since 405 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/649013514a0c9d1e163061b1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649013514a0c9d1e16306=
1b2
        failing since 319 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.254) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649014cdd336fc9882306195

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649014cdd336fc9882306=
196
        failing since 405 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6490136b3335ca8e42306161

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm6=
4-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6490136b3335ca8e42306=
162
        failing since 305 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6490141d476279f72d306200

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/b=
aseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6490141d476279f72d306=
201
        failing since 405 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/649013e01152efe73d30613c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64=
-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649013e01152efe73d306=
13d
        failing since 305 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649015fdb728ab8c51306152

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649015fdb728ab8c51306=
153
        failing since 405 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/64901364ec1f70383f306162

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm=
64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64901364ec1f70383f306=
163
        failing since 305 days (last pass: v4.19.230-41-g73351b9c55d9, firs=
t fail: v4.19.255) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649014dc1a2051db3e306132

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649014dc1a2051db3e306=
133
        failing since 405 days (last pass: v4.19.241-59-g7070c1b6eeed, firs=
t fail: v4.19.241-79-ge28b1117a7ab) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
r8a7743-iwg20d-q7          | arm   | lab-cip       | gcc-10   | shmobile_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/64900c2be311a48dd930615c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743=
-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743=
-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64900c2be311a48dd9306=
15d
        failing since 1 day (last pass: v4.19.285-24-g0312c44fe5753, first =
fail: v4.19.286-24-gd1785513fcf9) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
r8a7795-salvator-x         | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/649012efee79d8edd33061d5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-s=
alvator-x.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a7795-s=
alvator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649012efee79d8edd33061da
        failing since 11 days (last pass: v4.19.261-20-g5644b22533b36, firs=
t fail: v4.19.284-89-ga1cebe658474)

    2023-06-19T08:33:42.089553  + set +x
    2023-06-19T08:33:42.092109  <8>[   12.804103] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3676486_1.5.2.4.1>
    2023-06-19T08:33:42.198291  / # #
    2023-06-19T08:33:42.300245  export SHELL=3D/bin/sh
    2023-06-19T08:33:42.300768  #
    2023-06-19T08:33:42.402094  / # export SHELL=3D/bin/sh. /lava-3676486/e=
nvironment
    2023-06-19T08:33:42.402609  =

    2023-06-19T08:33:42.504008  / # . /lava-3676486/environment/lava-367648=
6/bin/lava-test-runner /lava-3676486/1
    2023-06-19T08:33:42.504827  =

    2023-06-19T08:33:42.508254  / # /lava-3676486/bin/lava-test-runner /lav=
a-3676486/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
rk3328-rock64              | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/649012b1027322ee9e30612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649012b1027322ee9e306=
12f
        failing since 11 days (last pass: v4.19.266-115-gf65c47c3f336, firs=
t fail: v4.19.284-89-ga1cebe658474) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/649012f26a03b72386306149

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/649012f26a03b7238630614f
        failing since 97 days (last pass: v4.19.276, first fail: v4.19.276-=
4-g4f95ee925a2b)

    2023-06-19T08:33:43.627176  <8>[   36.306596] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-06-19T08:33:44.642711  /lava-10808670/1/../bin/lava-test-case

    2023-06-19T08:33:44.651663  <8>[   37.330768] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/649012f26a03b72386306150
        failing since 97 days (last pass: v4.19.276, first fail: v4.19.276-=
4-g4f95ee925a2b)

    2023-06-19T08:33:43.618152  /lava-10808670/1/../bin/lava-test-case
   =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
sun50i-a64-pine64-plus     | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6490174cc83dce9c3c30613a

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6490174cc83dce9c3c30615f
        failing since 153 days (last pass: v4.19.265-42-ga2d8c749b30c, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-06-19T08:51:46.302287  <8>[   15.873838] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3676478_1.5.2.4.1>
    2023-06-19T08:51:46.422192  / # #
    2023-06-19T08:51:46.527999  export SHELL=3D/bin/sh
    2023-06-19T08:51:46.529752  #
    2023-06-19T08:51:46.633384  / # export SHELL=3D/bin/sh. /lava-3676478/e=
nvironment
    2023-06-19T08:51:46.634990  =

    2023-06-19T08:51:46.738731  / # . /lava-3676478/environment/lava-367647=
8/bin/lava-test-runner /lava-3676478/1
    2023-06-19T08:51:46.741620  =

    2023-06-19T08:51:46.744719  / # /lava-3676478/bin/lava-test-runner /lav=
a-3676478/1
    2023-06-19T08:51:46.775985  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
sun50i-a64-pine64-plus     | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/649013af3ed55509ca30615d

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
86-48-g7e26030d4609a/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649013af3ed55509ca306183
        failing since 153 days (last pass: v4.19.265-42-ga2d8c749b30c, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-06-19T08:36:28.253393  <8>[   15.943295] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 629812_1.5.2.4.1>
    2023-06-19T08:36:28.357294  / # #
    2023-06-19T08:36:28.458825  export SHELL=3D/bin/sh
    2023-06-19T08:36:28.459248  #
    2023-06-19T08:36:28.560441  / # export SHELL=3D/bin/sh. /lava-629812/en=
vironment
    2023-06-19T08:36:28.560844  =

    2023-06-19T08:36:28.662074  / # . /lava-629812/environment/lava-629812/=
bin/lava-test-runner /lava-629812/1
    2023-06-19T08:36:28.662643  =

    2023-06-19T08:36:28.667319  / # /lava-629812/bin/lava-test-runner /lava=
-629812/1
    2023-06-19T08:36:28.698823  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20

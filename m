Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9A877EAB9
	for <lists+stable@lfdr.de>; Wed, 16 Aug 2023 22:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjHPUbk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 16:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346153AbjHPUbN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 16:31:13 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EF426A8
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 13:31:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5654051b27fso5250238a12.0
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692217868; x=1692822668;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9dOo6Y78SkBhF/2ddiEQIsK6epoF5rhY4MRbg//gU9Y=;
        b=XP7XP1RLD0fyveDnYgCwXbv6q8tkgFl6dkb7INneriZXJ/yfyt5dEAI9dxDLv+uFTs
         9gTntd4t41zLeNL+GBlSKytC6HgxQqq2UY4u5aQev31t0wDuG0YcEdbp5ORLEUai/Nl6
         xKI/CF8kfVFMRB+LE7a5r8JHOFfCPLZF3eLwsBRDm0UdkeZ25Xm+hcPHcsyvVJabg+wG
         XjG3fMw5b7VDTB0Z2YkPWgLXDYgCcqKi5tkiTl+x1oB+5G2vmFbOAa5Epq4GNHS+yZ8h
         HOSTy2h5Z8o5Q3c+yBsb0clsgSzwRSanpz7tyUQdoMBcHK6X/rY36QTAi6uSglnmROQL
         +JCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692217868; x=1692822668;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dOo6Y78SkBhF/2ddiEQIsK6epoF5rhY4MRbg//gU9Y=;
        b=bEX5racX39XziuzmbpsqhZC4SugNTVTsmH92I0Fq/QqJw9IlOwikIhr07HmPjSFPtQ
         lWj5cx+r1enUkiZ2uTZMmUQwmcCVlz//Xi9dz29y1ogrttUdFpCYlXq3Dih7I/YYmuhQ
         IkHnAdVf1F4RSmqx4K2YsgxSV8NgAyKojnDkTedEuBIEwCq9O/M4uI5E1NbPSic5Wq9b
         U2Yx++amcegKYu8LwXtB3vw/fL5yTis/dOkr0atTAtx7wbyHrUFfT2jZMbbk4NnxKgmR
         6ZN4GzhYmjF472X8fnrDTeiur7HDscnnsGQTItnekXZ6LEiRvK15SWR+2uT++bhEBmi0
         m+sw==
X-Gm-Message-State: AOJu0YzHoHz3sR0zu9CxeaohHq80I+Rron8v6u4da9Vi30Hg2LK3kZ5N
        ER15+fOvHqJB3otoMPxkcdDj+j7PdqDOGfRmEStXkA==
X-Google-Smtp-Source: AGHT+IF8J6n1Ks9UMkYCKH/OwuD6HQhJKtY/HszX5J9wI7hhqfZNjC86IDBZBJPi6zPPkSA2wcPgXg==
X-Received: by 2002:a05:6a20:321b:b0:133:d17d:193a with SMTP id hl27-20020a056a20321b00b00133d17d193amr3404360pzc.59.1692217867690;
        Wed, 16 Aug 2023 13:31:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a26-20020a62e21a000000b0064d74808738sm11465917pfi.214.2023.08.16.13.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:31:07 -0700 (PDT)
Message-ID: <64dd320b.620a0220.f6909.60fd@mx.google.com>
Date:   Wed, 16 Aug 2023 13:31:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.292
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-4.19.y
Subject: stable/linux-4.19.y baseline: 97 runs, 36 regressions (v4.19.292)
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

stable/linux-4.19.y baseline: 97 runs, 36 regressions (v4.19.292)

Regressions Summary
-------------------

platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

asus-C523NA-A20057-coral   | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

beagle-xm                  | arm    | lab-baylibre  | gcc-10   | omap2plus_=
defconfig          | 1          =

beaglebone-black           | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =

beaglebone-black           | arm    | lab-cip       | gcc-10   | multi_v7_d=
efconfig           | 1          =

beaglebone-black           | arm    | lab-broonie   | gcc-10   | omap2plus_=
defconfig          | 1          =

cubietruck                 | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

imx6q-sabrelite            | arm    | lab-collabora | gcc-10   | multi_v7_d=
efconfig           | 1          =

imx6ul-14x14-evk           | arm    | lab-nxp       | gcc-10   | multi_v7_d=
efconfig           | 1          =

imx7d-sdb                  | arm    | lab-nxp       | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

r8a7796-m3ulcb             | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

rk3288-veyron-jaq          | arm    | lab-collabora | gcc-10   | multi_v7_d=
efconfig           | 3          =

rk3399-gru-kevin           | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 2          =

sun50i-a64-pine64-plus     | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

sun50i-h6-pine-h64         | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

zynqmp-zcu102              | arm64  | lab-cip       | gcc-10   | defconfig =
                   | 1          =

zynqmp-zcu102              | arm64  | lab-cip       | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-4.19.y/kernel=
/v4.19.292/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.292
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      4e5e7fa94ee0ff378b268679d51feb1fd2a04756 =



Test Regressions
---------------- =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcffbb06d213784535b1f0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dcffbb06d213784535b1f5
        failing since 210 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-16T16:57:11.786858  + set +x

    2023-08-16T16:57:11.793374  <8>[   11.511871] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11301232_1.4.2.3.1>

    2023-08-16T16:57:11.897659  / # #

    2023-08-16T16:57:11.998212  export SHELL=3D/bin/sh

    2023-08-16T16:57:11.998372  #

    2023-08-16T16:57:12.098891  / # export SHELL=3D/bin/sh. /lava-11301232/=
environment

    2023-08-16T16:57:12.099068  =


    2023-08-16T16:57:12.199604  / # . /lava-11301232/environment/lava-11301=
232/bin/lava-test-runner /lava-11301232/1

    2023-08-16T16:57:12.199918  =


    2023-08-16T16:57:12.204410  / # /lava-11301232/bin/lava-test-runner /la=
va-11301232/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcffc281c983e07835b1f5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dcffc281c983e07835b1fa
        failing since 210 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-16T16:56:40.413811  + set +x

    2023-08-16T16:56:40.420339  <8>[   11.954767] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11301236_1.4.2.3.1>

    2023-08-16T16:56:40.527580  / # #

    2023-08-16T16:56:40.628301  export SHELL=3D/bin/sh

    2023-08-16T16:56:40.628534  #

    2023-08-16T16:56:40.729148  / # export SHELL=3D/bin/sh. /lava-11301236/=
environment

    2023-08-16T16:56:40.729320  =


    2023-08-16T16:56:40.829873  / # . /lava-11301236/environment/lava-11301=
236/bin/lava-test-runner /lava-11301236/1

    2023-08-16T16:56:40.830179  =


    2023-08-16T16:56:40.835786  / # /lava-11301236/bin/lava-test-runner /la=
va-11301236/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beagle-xm                  | arm    | lab-baylibre  | gcc-10   | omap2plus_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd006431e1d5847535b217

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd006431e1d5847535b=
218
        new failure (last pass: v4.19.291) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beaglebone-black           | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcffdec5240ac61735b299

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dcffdec5240ac61735b2c1
        failing since 210 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-16T16:56:25.110519  <8>[   20.426114] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 57734_1.5.2.4.1>
    2023-08-16T16:56:25.219108  / # #
    2023-08-16T16:56:25.322196  export SHELL=3D/bin/sh
    2023-08-16T16:56:25.322947  #
    2023-08-16T16:56:25.425295  / # export SHELL=3D/bin/sh. /lava-57734/env=
ironment
    2023-08-16T16:56:25.426030  =

    2023-08-16T16:56:25.528410  / # . /lava-57734/environment/lava-57734/bi=
n/lava-test-runner /lava-57734/1
    2023-08-16T16:56:25.529716  =

    2023-08-16T16:56:25.533664  / # /lava-57734/bin/lava-test-runner /lava-=
57734/1
    2023-08-16T16:56:25.601216  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beaglebone-black           | arm    | lab-cip       | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd00eff3ec58dd4c35b204

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd00eff3ec58dd4c35b207
        failing since 210 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-16T17:00:58.918504  + set +x
    2023-08-16T17:00:58.920553  <8>[    9.875058] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997950_1.5.2.4.1>
    2023-08-16T17:00:59.029357  / # #
    2023-08-16T17:00:59.131311  export SHELL=3D/bin/sh
    2023-08-16T17:00:59.131927  #
    2023-08-16T17:00:59.233343  / # export SHELL=3D/bin/sh. /lava-997950/en=
vironment
    2023-08-16T17:00:59.233928  =

    2023-08-16T17:00:59.335331  / # . /lava-997950/environment/lava-997950/=
bin/lava-test-runner /lava-997950/1
    2023-08-16T17:00:59.336086  =

    2023-08-16T17:00:59.337741  / # /lava-997950/bin/lava-test-runner /lava=
-997950/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beaglebone-black           | arm    | lab-broonie   | gcc-10   | omap2plus_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcff8e55fc58eeb035b1d9

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dcff8e55fc58eeb035b20b
        new failure (last pass: v4.19.291)

    2023-08-16T16:55:18.514948  + set +x<8>[   17.143078] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 57718_1.5.2.4.1>
    2023-08-16T16:55:18.515475  =

    2023-08-16T16:55:18.626880  / # #
    2023-08-16T16:55:18.729852  export SHELL=3D/bin/sh
    2023-08-16T16:55:18.730594  #
    2023-08-16T16:55:18.832732  / # export SHELL=3D/bin/sh. /lava-57718/env=
ironment
    2023-08-16T16:55:18.833474  =

    2023-08-16T16:55:18.935820  / # . /lava-57718/environment/lava-57718/bi=
n/lava-test-runner /lava-57718/1
    2023-08-16T16:55:18.937096  =

    2023-08-16T16:55:18.941959  / # /lava-57718/bin/lava-test-runner /lava-=
57718/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
cubietruck                 | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcffc306d213784535b221

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dcffc306d213784535b226
        failing since 210 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-16T16:56:23.128114  + set +x<8>[    7.344499] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3743160_1.5.2.4.1>
    2023-08-16T16:56:23.128824  =

    2023-08-16T16:56:23.238293  / # #
    2023-08-16T16:56:23.341841  export SHELL=3D/bin/sh
    2023-08-16T16:56:23.343039  #
    2023-08-16T16:56:23.445660  / # export SHELL=3D/bin/sh. /lava-3743160/e=
nvironment
    2023-08-16T16:56:23.446720  =

    2023-08-16T16:56:23.549257  / # . /lava-3743160/environment/lava-374316=
0/bin/lava-test-runner /lava-3743160/1
    2023-08-16T16:56:23.551201  =

    2023-08-16T16:56:23.556399  / # /lava-3743160/bin/lava-test-runner /lav=
a-3743160/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
imx6q-sabrelite            | arm    | lab-collabora | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcffb030947fb24635b262

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dcffb030947fb24635b267
        failing since 210 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-16T16:56:07.458739  / # #

    2023-08-16T16:56:07.560748  export SHELL=3D/bin/sh

    2023-08-16T16:56:07.561385  #

    2023-08-16T16:56:07.663274  / # export SHELL=3D/bin/sh. /lava-11301178/=
environment

    2023-08-16T16:56:07.664027  =


    2023-08-16T16:56:07.765895  / # . /lava-11301178/environment/lava-11301=
178/bin/lava-test-runner /lava-11301178/1

    2023-08-16T16:56:07.767014  =


    2023-08-16T16:56:07.781464  / # /lava-11301178/bin/lava-test-runner /la=
va-11301178/1

    2023-08-16T16:56:07.892375  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T16:56:07.892861  + cd /lava-11301178/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
imx6ul-14x14-evk           | arm    | lab-nxp       | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcffe09ded5db3e535b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dcffe09ded5db3e535b1de
        failing since 152 days (last pass: v4.19.260, first fail: v4.19.278)

    2023-08-16T16:56:40.238556  + set +x
    2023-08-16T16:56:40.241172  <8>[   23.093627] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1244203_1.5.2.4.1>
    2023-08-16T16:56:40.349460  / # #
    2023-08-16T16:56:41.505682  export SHELL=3D/bin/sh
    2023-08-16T16:56:41.511302  #
    2023-08-16T16:56:43.055007  / # export SHELL=3D/bin/sh. /lava-1244203/e=
nvironment
    2023-08-16T16:56:43.060733  =

    2023-08-16T16:56:45.873134  / # . /lava-1244203/environment/lava-124420=
3/bin/lava-test-runner /lava-1244203/1
    2023-08-16T16:56:45.879176  =

    2023-08-16T16:56:45.880139  / # /lava-1244203/bin/lava-test-runner /lav=
a-1244203/1 =

    ... (15 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
imx7d-sdb                  | arm    | lab-nxp       | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcffcdc5240ac61735b1e9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dcffcdc5240ac61735b1ee
        failing since 210 days (last pass: v4.19.267, first fail: v4.19.270)

    2023-08-16T16:56:23.856684  / # #
    2023-08-16T16:56:25.011373  export SHELL=3D/bin/sh
    2023-08-16T16:56:25.016769  #
    2023-08-16T16:56:26.557479  / # export SHELL=3D/bin/sh. /lava-1244204/e=
nvironment
    2023-08-16T16:56:26.563103  =

    2023-08-16T16:56:29.375313  / # . /lava-1244204/environment/lava-124420=
4/bin/lava-test-runner /lava-1244204/1
    2023-08-16T16:56:29.381267  =

    2023-08-16T16:56:29.381560  / # /lava-1244204/bin/lava-test-runner /lav=
a-1244204/1
    2023-08-16T16:56:29.489123  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-16T16:56:29.489505  + cd /lava-1244204/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd025882c76121d835b1e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd025882c76121d835b=
1e8
        failing since 345 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd0427553133b89135b1e0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd0427553133b89135b=
1e1
        failing since 383 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd019a35af2d335735b1e3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd019a35af2d335735b=
1e4
        failing since 345 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd027669c7a267e935b205

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd027669c7a267e935b=
206
        failing since 383 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd02965aea7f6f2c35b1e5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd02965aea7f6f2c35b=
1e6
        failing since 345 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd04289a73e29bea35b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd04289a73e29bea35b=
1da
        failing since 383 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd019b05a1817a3d35b1e5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd019b05a1817a3d35b=
1e6
        failing since 345 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd02ee1589f297c135b21e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd02ee1589f297c135b=
21f
        failing since 383 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd026e69c7a267e935b200

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd026e69c7a267e935b=
201
        failing since 345 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd02c05aea7f6f2c35b1f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd02c05aea7f6f2c35b=
1fa
        failing since 383 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd019a081feaa56d35b1e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd019a081feaa56d35b=
1e7
        failing since 345 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd024e82c76121d835b1e1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd024e82c76121d835b=
1e2
        failing since 383 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd02be77393a343135b250

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd02be77393a343135b=
251
        failing since 345 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd0413553133b89135b1db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm64-vir=
t-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd0413553133b89135b=
1dc
        failing since 383 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd02260f1f08423035b1e3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd02260f1f08423035b=
1e4
        failing since 345 days (last pass: v4.19.230, first fail: v4.19.257=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd024f82c76121d835b1e4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_arm64-v=
irt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd024f82c76121d835b=
1e5
        failing since 383 days (last pass: v4.19.230, first fail: v4.19.254=
) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
r8a7796-m3ulcb             | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd009f27a2faabd135b1d9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd009f27a2faabd135b1de
        failing since 209 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-16T17:01:42.246506  / # #

    2023-08-16T17:01:42.348948  export SHELL=3D/bin/sh

    2023-08-16T17:01:42.349655  #

    2023-08-16T17:01:42.451093  / # export SHELL=3D/bin/sh. /lava-11301248/=
environment

    2023-08-16T17:01:42.451793  =


    2023-08-16T17:01:42.553227  / # . /lava-11301248/environment/lava-11301=
248/bin/lava-test-runner /lava-11301248/1

    2023-08-16T17:01:42.554300  =


    2023-08-16T17:01:42.570559  / # /lava-11301248/bin/lava-test-runner /la=
va-11301248/1

    2023-08-16T17:01:42.620627  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T17:01:42.621193  + cd /lav<8>[   12.816389] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11301248_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora | gcc-10   | multi_v7_d=
efconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/64dcff9c30947fb24635b1d9

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64dcff9c30947fb24635b1ff
        failing since 208 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-16T16:57:14.789321  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   10.472760] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-08-16T16:57:14.791155   multi-call binary.

    2023-08-16T16:57:14.791401  =


    2023-08-16T16:57:14.795661  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-16T16:57:14.795951  =


    2023-08-16T16:57:14.800879  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64dcff9c30947fb24635b200
        failing since 208 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-16T16:57:14.770338  <8>[   10.455196] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dcff9c30947fb24635b21d
        failing since 208 days (last pass: v4.19.269, first fail: v4.19.270)

    2023-08-16T16:57:10.942374  <8>[    6.627499] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-16T16:57:10.951792  + <8>[    6.639589] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11301180_1.5.2.3.1>

    2023-08-16T16:57:10.952178  set +x

    2023-08-16T16:57:11.058280  =


    2023-08-16T16:57:11.159958  / # #export SHELL=3D/bin/sh

    2023-08-16T16:57:11.160670  =


    2023-08-16T16:57:11.262117  / # export SHELL=3D/bin/sh. /lava-11301180/=
environment

    2023-08-16T16:57:11.262810  =


    2023-08-16T16:57:11.364217  / # . /lava-11301180/environment/lava-11301=
180/bin/lava-test-runner /lava-11301180/1

    2023-08-16T16:57:11.365368  =

 =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64dd013658cb1f112735b203

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64dd013658cb1f112735b209
        failing since 152 days (last pass: v4.19.277, first fail: v4.19.278)

    2023-08-16T17:03:35.090739  <8>[   36.264526] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-16T17:03:36.102005  /lava-11301266/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64dd013658cb1f112735b20a
        failing since 152 days (last pass: v4.19.277, first fail: v4.19.278)

    2023-08-16T17:03:34.069571  =


    2023-08-16T17:03:35.080780  /lava-11301266/1/../bin/lava-test-case
   =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
sun50i-a64-pine64-plus     | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd00cd6fdf9e8a9e35b22e

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd00cd6fdf9e8a9e35b253
        failing since 210 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-16T17:00:21.493743  <8>[   15.980154] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 57769_1.5.2.4.1>
    2023-08-16T17:00:21.600017  / # #
    2023-08-16T17:00:21.702673  export SHELL=3D/bin/sh
    2023-08-16T17:00:21.703408  #
    2023-08-16T17:00:21.805268  / # export SHELL=3D/bin/sh. /lava-57769/env=
ironment
    2023-08-16T17:00:21.805846  =

    2023-08-16T17:00:21.907423  / # . /lava-57769/environment/lava-57769/bi=
n/lava-test-runner /lava-57769/1
    2023-08-16T17:00:21.908642  =

    2023-08-16T17:00:21.912516  / # /lava-57769/bin/lava-test-runner /lava-=
57769/1
    2023-08-16T17:00:21.944023  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd00b36fdf9e8a9e35b1dc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd00b36fdf9e8a9e35b1e1
        failing since 210 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-16T17:01:52.275031  / # #

    2023-08-16T17:01:52.377196  export SHELL=3D/bin/sh

    2023-08-16T17:01:52.377968  #

    2023-08-16T17:01:52.479388  / # export SHELL=3D/bin/sh. /lava-11301247/=
environment

    2023-08-16T17:01:52.480154  =


    2023-08-16T17:01:52.581593  / # . /lava-11301247/environment/lava-11301=
247/bin/lava-test-runner /lava-11301247/1

    2023-08-16T17:01:52.582747  =


    2023-08-16T17:01:52.597987  / # /lava-11301247/bin/lava-test-runner /la=
va-11301247/1

    2023-08-16T17:01:52.641434  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T17:01:52.655767  + cd /lava-1130124<8>[   15.621512] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11301247_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
zynqmp-zcu102              | arm64  | lab-cip       | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd009ff101f2ba4335b20c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd009ff101f2ba4335b20f
        failing since 210 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-16T17:00:00.322928  + set +x
    2023-08-16T17:00:00.324058  <8>[    3.757642] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997953_1.5.2.4.1>
    2023-08-16T17:00:00.430376  / # #
    2023-08-16T17:00:00.532273  export SHELL=3D/bin/sh
    2023-08-16T17:00:00.532787  #
    2023-08-16T17:00:00.634256  / # export SHELL=3D/bin/sh. /lava-997953/en=
vironment
    2023-08-16T17:00:00.634730  =

    2023-08-16T17:00:00.736203  / # . /lava-997953/environment/lava-997953/=
bin/lava-test-runner /lava-997953/1
    2023-08-16T17:00:00.737043  =

    2023-08-16T17:00:00.739969  / # /lava-997953/bin/lava-test-runner /lava=
-997953/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
zynqmp-zcu102              | arm64  | lab-cip       | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd02078168b954ba35b1e2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.292/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd02078168b954ba35b1e5
        failing since 210 days (last pass: v4.19.268, first fail: v4.19.270)

    2023-08-16T17:05:53.514352  + set +x
    2023-08-16T17:05:53.515476  <8>[    3.733823] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997958_1.5.2.4.1>
    2023-08-16T17:05:53.622884  / # #
    2023-08-16T17:05:53.724816  export SHELL=3D/bin/sh
    2023-08-16T17:05:53.725295  #
    2023-08-16T17:05:53.826685  / # export SHELL=3D/bin/sh. /lava-997958/en=
vironment
    2023-08-16T17:05:53.827166  =

    2023-08-16T17:05:53.928626  / # . /lava-997958/environment/lava-997958/=
bin/lava-test-runner /lava-997958/1
    2023-08-16T17:05:53.929390  =

    2023-08-16T17:05:53.932346  / # /lava-997958/bin/lava-test-runner /lava=
-997958/1 =

    ... (13 line(s) more)  =

 =20

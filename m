Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846067F1D80
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 20:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjKTTqR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 14:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjKTTqR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 14:46:17 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E68A2
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 11:46:12 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc29f39e7aso29568035ad.0
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 11:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700509572; x=1701114372; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5PMsAYjO+Kcx2vKZeDATugrgGupPslis1dupxt2TA98=;
        b=E0r5vTxvEb2jU0kSZBeYwEqZctxcACcFNEe+JI9xgiA6Cb7Ke/dX7T+nO42tkX6s/K
         tMOZfLNjSIPEMhyXMy4yoLgMeDWy+/Zy0bn6ajOZTuILeP1LBx0OIDbIEkR+vNk6XWT0
         gPUniB9d30McXyCr1fYf5gxMi9fJ38UezeGRQjv/bmeh+tNgaLCvL29sBio5cDA4WoQd
         YInnk7erpB/wdBHHf7FJ6k8Ti9xpshVyE2nH72u5lHO+g/xH7kwOUYjdjmnr+2Q/jt3H
         Xvs2KfNuuS0BqO7betdgtWi1KA/pGP6R57HUvSBZePU7HV1AgHWEBzmzEmIrHmPeABXo
         pmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700509572; x=1701114372;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PMsAYjO+Kcx2vKZeDATugrgGupPslis1dupxt2TA98=;
        b=ZBC/X++RlZ9B6Jtx72pwf9v7vrykwFo8Zfsm/ttZwveYgNLJNcAweDcLusXNCf6L3S
         fQVI2z7T00slwqYBKj7H4CCXKLO7wqG6yxO2GA/51JfKnaX2gPaPDk+yV8qOHj1UqjHC
         3OLEwI5QBCXr/eTN5xI2ACxV9+hnZVPuHQBLXcEDb+mJutZZvPk2qSUbZ3COkGbqvnkB
         QgOBPftSMgi1yAa9SdkG+HzAtYKsg9pWddCrE3xCx0IcOdjPij9pfGXeZgF0Dj3B5mDs
         xTrLH7d5peyiopvtqyrl5a1ZtCs6I1a4iMXqMf8O0DKvhWwiwtez4eg8p+1gFtTDdOZT
         FgkA==
X-Gm-Message-State: AOJu0YwrEAOjpBoJcASZw1SoBzylbty5x6IqhkAOAmD8xv7qKojW4E0s
        NFe3cmDRwfBHuzSmdIhwoWiFE4G3M+jCVnbOHMA=
X-Google-Smtp-Source: AGHT+IGptOkdnZjl6HBwlB/JoZ0zOslPipgzH8WeCJcE8ZuONPTAWC5qssDN+UtCXfoDCkU+UYvK1A==
X-Received: by 2002:a17:902:ec02:b0:1cc:482c:bc4d with SMTP id l2-20020a170902ec0200b001cc482cbc4dmr6965211pld.5.1700509571794;
        Mon, 20 Nov 2023 11:46:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902e84d00b001c465bedaccsm517336plg.83.2023.11.20.11.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:46:11 -0800 (PST)
Message-ID: <655bb783.170a0220.4058c.27fb@mx.google.com>
Date:   Mon, 20 Nov 2023 11:46:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.201
Subject: stable-rc/linux-5.10.y baseline: 104 runs, 3 regressions (v5.10.201)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 104 runs, 3 regressions (v5.10.201)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.201/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.201
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6db6caba87efcfbcf57d68b540a1f0a4c0a5539b =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655b855b8bc3372ad87e4a6d

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655b855b8bc3372ad87e4aad
        new failure (last pass: v5.10.200-192-g550b7e1fee20)

    2023-11-20T16:11:46.381840  <8>[   14.663798] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 257007_1.5.2.4.1>
    2023-11-20T16:11:46.491749  / # #
    2023-11-20T16:11:46.594883  export SHELL=3D/bin/sh
    2023-11-20T16:11:46.595748  #
    2023-11-20T16:11:46.697716  / # export SHELL=3D/bin/sh. /lava-257007/en=
vironment
    2023-11-20T16:11:46.698652  =

    2023-11-20T16:11:46.800826  / # . /lava-257007/environment/lava-257007/=
bin/lava-test-runner /lava-257007/1
    2023-11-20T16:11:46.802317  =

    2023-11-20T16:11:46.813422  / # /lava-257007/bin/lava-test-runner /lava=
-257007/1
    2023-11-20T16:11:46.876351  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655b8371a7286707387e4af7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655b8371a7286707387e4b00
        failing since 40 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-20T16:03:51.945013  <8>[   16.954832] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 444711_1.5.2.4.1>
    2023-11-20T16:03:52.050101  / # #
    2023-11-20T16:03:52.151724  export SHELL=3D/bin/sh
    2023-11-20T16:03:52.152309  #
    2023-11-20T16:03:52.253321  / # export SHELL=3D/bin/sh. /lava-444711/en=
vironment
    2023-11-20T16:03:52.254018  =

    2023-11-20T16:03:52.355027  / # . /lava-444711/environment/lava-444711/=
bin/lava-test-runner /lava-444711/1
    2023-11-20T16:03:52.355965  =

    2023-11-20T16:03:52.360271  / # /lava-444711/bin/lava-test-runner /lava=
-444711/1
    2023-11-20T16:03:52.427298  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655b838b2e9e63fa4a7e4a7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655b838b2e9e63fa4a7e4a88
        failing since 40 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-20T16:10:36.900038  / # #

    2023-11-20T16:10:37.001924  export SHELL=3D/bin/sh

    2023-11-20T16:10:37.002580  #

    2023-11-20T16:10:37.103889  / # export SHELL=3D/bin/sh. /lava-12048019/=
environment

    2023-11-20T16:10:37.104133  =


    2023-11-20T16:10:37.204967  / # . /lava-12048019/environment/lava-12048=
019/bin/lava-test-runner /lava-12048019/1

    2023-11-20T16:10:37.206065  =


    2023-11-20T16:10:37.213839  / # /lava-12048019/bin/lava-test-runner /la=
va-12048019/1

    2023-11-20T16:10:37.277789  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-20T16:10:37.278282  + cd /lava-1204801<8>[   18.076675] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12048019_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

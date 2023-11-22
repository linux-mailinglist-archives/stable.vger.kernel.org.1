Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D775F7F51A5
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 21:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjKVU3G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 15:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjKVU3F (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 15:29:05 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3EDA
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 12:29:01 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b4145e887bso132759b6e.3
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 12:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700684940; x=1701289740; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JOcDTC9WepqQIZ/o2pHlgyy64rCqrM93FmeZlWHfMJE=;
        b=TC/s/YqI7yx7k48BSeIZIL03KgquskakpS/m57oZ5IjvKECWF7XvSrkuwzNZVFMfAM
         jKdkM5+lemo+LOmT85Xc+0CuQg4OgKBNWjbYoMRd1O6FMSGNSMwym5ZI9I5sgD7cQU+a
         gjKOv0GQJvC6qXEF7RtW7XC47YMPWbRMtV94dTwcg2j/Zg5H19XMDOefv0N73rtKmpP+
         uYi0aqfTNJ8qd1yD4/33ZZbk8qCH5s82XpqsBo54uFJuRJSdYdnoSR4Bf6aHsrHss/qr
         5nT2eqLbuMIUCtVdzWeq0pACS0ZHvL3deaY6fAHGZciipPUPrrfU/SbPrJJCw62IOvSE
         ZMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700684940; x=1701289740;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOcDTC9WepqQIZ/o2pHlgyy64rCqrM93FmeZlWHfMJE=;
        b=g5UCWaMd4dLz5LfxFyyWOz839dvpFyhOaeam4appN2zhiUFvGEbM5GxIIYzFtMCScD
         s/+vw9R1PZOY8TTziU2CcIZ68wInHUHrizI3RTwU8mliSM8Zu7hT1LMDSB0wdTYTTUyn
         MAk7mZpQs7IxmhIJasWZ/+TFqQuibrVtrj6lUl4LboUSn8k+NB1Z98nDUos0izVQyhum
         yeavn4P2N0qqx/uRva6Hil+1KeyGtz9yNjkA6JhQ4WAUkkINHLCnNpzJBIyxckP8nza4
         2yutmAQapGUMxuXcn+c0ZXVy0sUjliKawUsjcZY5m2OPiKiz0mBgoPuk4Ni0vY6KLbrZ
         GwTQ==
X-Gm-Message-State: AOJu0YxRAkU9YbDJa3F/T1Q9pSU/PQi9URXYhAmO57RjdB29+pesgo6N
        /BQxN35dfoNs6Uml9V5MQvD8U4RD5WIT4VizVWY=
X-Google-Smtp-Source: AGHT+IGE9EGJjfpjxmv3eeuVH47m7sCKWvzKVjGmbqzC3t9Cjl45VrTkcVhkh46P0MPGKzeR8MdwRg==
X-Received: by 2002:a05:6808:2224:b0:3a0:41d4:b144 with SMTP id bd36-20020a056808222400b003a041d4b144mr5021954oib.1.1700684940692;
        Wed, 22 Nov 2023 12:29:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z125-20020a633383000000b005c19c586cb7sm103714pgz.33.2023.11.22.12.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:29:00 -0800 (PST)
Message-ID: <655e648c.630a0220.161a6.07f2@mx.google.com>
Date:   Wed, 22 Nov 2023 12:29:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.63-176-gecc0fed1ffa4
Subject: stable-rc/queue/6.1 baseline: 142 runs,
 3 regressions (v6.1.63-176-gecc0fed1ffa4)
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

stable-rc/queue/6.1 baseline: 142 runs, 3 regressions (v6.1.63-176-gecc0fed=
1ffa4)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.63-176-gecc0fed1ffa4/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.63-176-gecc0fed1ffa4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ecc0fed1ffa4a325e93ac9121a6b1dbdfbd9fa95 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655e30dd91ecae40387e4a8e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-17=
6-gecc0fed1ffa4/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-17=
6-gecc0fed1ffa4/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e30dd91ecae40387e4a97
        new failure (last pass: v6.1.31-26-gef50524405c2)

    2023-11-22T16:54:34.771365  / # #

    2023-11-22T16:54:34.871927  export SHELL=3D/bin/sh

    2023-11-22T16:54:34.872070  #

    2023-11-22T16:54:34.972601  / # export SHELL=3D/bin/sh. /lava-12060562/=
environment

    2023-11-22T16:54:34.972732  =


    2023-11-22T16:54:35.073267  / # . /lava-12060562/environment/lava-12060=
562/bin/lava-test-runner /lava-12060562/1

    2023-11-22T16:54:35.073462  =


    2023-11-22T16:54:35.084963  / # /lava-12060562/bin/lava-test-runner /la=
va-12060562/1

    2023-11-22T16:54:35.138767  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-22T16:54:35.138843  + cd /lav<8>[   19.070482] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12060562_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655e30c31c911259eb7e4bcd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-17=
6-gecc0fed1ffa4/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-17=
6-gecc0fed1ffa4/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e30c31c911259eb7e4bd6
        new failure (last pass: v6.1.22-372-g971903477e72)

    2023-11-22T16:47:58.957550  <8>[   18.039980] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 444875_1.5.2.4.1>
    2023-11-22T16:47:59.066521  / # #
    2023-11-22T16:47:59.168221  export SHELL=3D/bin/sh
    2023-11-22T16:47:59.168876  #
    2023-11-22T16:47:59.269898  / # export SHELL=3D/bin/sh. /lava-444875/en=
vironment
    2023-11-22T16:47:59.270547  =

    2023-11-22T16:47:59.371502  / # . /lava-444875/environment/lava-444875/=
bin/lava-test-runner /lava-444875/1
    2023-11-22T16:47:59.372425  =

    2023-11-22T16:47:59.388832  / # /lava-444875/bin/lava-test-runner /lava=
-444875/1
    2023-11-22T16:47:59.454861  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655e30db91ecae40387e4a81

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-17=
6-gecc0fed1ffa4/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-17=
6-gecc0fed1ffa4/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e30dc91ecae40387e4a8a
        new failure (last pass: v6.1.22-372-g971903477e72)

    2023-11-22T16:54:48.178770  / # #

    2023-11-22T16:54:48.281111  export SHELL=3D/bin/sh

    2023-11-22T16:54:48.281894  #

    2023-11-22T16:54:48.383299  / # export SHELL=3D/bin/sh. /lava-12060558/=
environment

    2023-11-22T16:54:48.384158  =


    2023-11-22T16:54:48.485664  / # . /lava-12060558/environment/lava-12060=
558/bin/lava-test-runner /lava-12060558/1

    2023-11-22T16:54:48.486878  =


    2023-11-22T16:54:48.488148  / # /lava-12060558/bin/lava-test-runner /la=
va-12060558/1

    2023-11-22T16:54:48.569081  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-22T16:54:48.569615  + cd /lava-1206055<8>[   18.771163] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12060558_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

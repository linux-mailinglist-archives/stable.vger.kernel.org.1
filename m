Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2312F6FFADF
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 21:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbjEKTwH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 15:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbjEKTwC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 15:52:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA6B2D74
        for <stable@vger.kernel.org>; Thu, 11 May 2023 12:51:51 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6439df6c268so5702698b3a.0
        for <stable@vger.kernel.org>; Thu, 11 May 2023 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683834710; x=1686426710;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LXQ4jc+QR0DhQW2AbQJ7IyP9fzw8i4d6rLoKWjAbvmM=;
        b=4Y7Dz3DqhbpswUekN8hqnusEW9g3bNvNMVyuSewGXsT28dButggrBRUBpP2gLOYMdi
         wwsVuIjLwfG8I+qRIZ3FABF4Ij+/mI/ezEMBUXD8q4rergw6/HEleLjVH8cnSoX4i41h
         beb4ajCowQgPM08L1hcHfTIWn3YIAepKCHrAZHt9yHn6uQrRWA/Rfu14XhxYm0tpSfz0
         8Dc/mewaHaTfUHHOGgkj91QZbdV26bCjUAUHbHzk6fcDlnedn9m2dTvyZZrpSpf+bTU1
         t3wwFjuNL6A5lyU6rv3/KXO1XMS+yiaj+IUlyvRI0PT2ezPL71ObIELdfHuFFufBVa+N
         40GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683834710; x=1686426710;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXQ4jc+QR0DhQW2AbQJ7IyP9fzw8i4d6rLoKWjAbvmM=;
        b=EnS0Vvm9oWucJO+siBuQqqoLx0eJwc+G0WsVFkaD8Cx7CHcFBPXeSU3YL//30L8T6g
         1TfrnKMRzqPEBruqPthU+sqf8p0ClIfxHIwUFFOJSEdbIefPfZxpfmtGGDgBJMiysd5S
         3Gc0qFMzfmEk0X674R0XIGAO79igMG3o5FSN8APqzFrpvTuYjBzEnFq7pglhdXdg8bhi
         b44of6tY262bfvIA0oEcwCf/fyCqcQn0vKOrsWoT+8Xcaqp+N1ochR6IVGPFmXuAe1uS
         XTY8DgVpyQ9ztylbMjtFrdfUp9WtgDA2plxiH5d8Gxu/O+8AkcfhjP2bljeP0lCHYuEx
         gPLw==
X-Gm-Message-State: AC+VfDxobbx6njq4Yy8VFXKacOGU+9p85/OzDWCmA17dHMlbgPaQJpNX
        mU4cwrQ9I8iao17fDAdOLvf7o+cqHVO0CWQDUlA6xg==
X-Google-Smtp-Source: ACHHUZ7lEbFwyW25DpiV28Sb1XNXvSab38agDZg/atFqZWHsM+43SfOCn+a3fuujg0SaDtCAGEVYfQ==
X-Received: by 2002:a17:902:dace:b0:1ac:6e1f:d1bd with SMTP id q14-20020a170902dace00b001ac6e1fd1bdmr21952006plx.19.1683834709858;
        Thu, 11 May 2023 12:51:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p15-20020a1709027ecf00b001a1a07d04e6sm6355229plb.77.2023.05.11.12.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 12:51:49 -0700 (PDT)
Message-ID: <645d4755.170a0220.44a62.cf8c@mx.google.com>
Date:   Thu, 11 May 2023 12:51:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.15.111
X-Kernelci-Report-Type: test
Subject: stable/linux-5.15.y baseline: 239 runs, 27 regressions (v5.15.111)
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

stable/linux-5.15.y baseline: 239 runs, 27 regressions (v5.15.111)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 4          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.111/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.111
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      b0ece631f84a3e70341496b000b094b7dfdf4e5f =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0d5c69e02a62de2e8634

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0d5c69e02a62de2e8639
        failing since 42 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-11T15:44:11.907183  + set +x

    2023-05-11T15:44:11.914019  <8>[   10.710187] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10284435_1.4.2.3.1>

    2023-05-11T15:44:12.022710  =


    2023-05-11T15:44:12.124576  / # #export SHELL=3D/bin/sh

    2023-05-11T15:44:12.125394  =


    2023-05-11T15:44:12.227024  / # export SHELL=3D/bin/sh. /lava-10284435/=
environment

    2023-05-11T15:44:12.227851  =


    2023-05-11T15:44:12.329426  / # . /lava-10284435/environment/lava-10284=
435/bin/lava-test-runner /lava-10284435/1

    2023-05-11T15:44:12.330681  =


    2023-05-11T15:44:12.336438  / # /lava-10284435/bin/lava-test-runner /la=
va-10284435/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/645d106c9a9664d11c2e86f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d106c9a9664d11c2e86f6
        failing since 42 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-11T15:57:21.194006  + set +x

    2023-05-11T15:57:21.200366  <8>[   11.557705] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10284943_1.4.2.3.1>

    2023-05-11T15:57:21.304892  / # #

    2023-05-11T15:57:21.405648  export SHELL=3D/bin/sh

    2023-05-11T15:57:21.406423  #

    2023-05-11T15:57:21.508067  / # export SHELL=3D/bin/sh. /lava-10284943/=
environment

    2023-05-11T15:57:21.508997  =


    2023-05-11T15:57:21.610892  / # . /lava-10284943/environment/lava-10284=
943/bin/lava-test-runner /lava-10284943/1

    2023-05-11T15:57:21.612481  =


    2023-05-11T15:57:21.617839  / # /lava-10284943/bin/lava-test-runner /la=
va-10284943/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0d17164a9b821e2e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0d17164a9b821e2e8617
        failing since 42 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-11T15:43:05.195155  + set<8>[   11.177599] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10284426_1.4.2.3.1>

    2023-05-11T15:43:05.195733   +x

    2023-05-11T15:43:05.303738  / # #

    2023-05-11T15:43:05.406472  export SHELL=3D/bin/sh

    2023-05-11T15:43:05.407268  #

    2023-05-11T15:43:05.508860  / # export SHELL=3D/bin/sh. /lava-10284426/=
environment

    2023-05-11T15:43:05.509660  =


    2023-05-11T15:43:05.611562  / # . /lava-10284426/environment/lava-10284=
426/bin/lava-test-runner /lava-10284426/1

    2023-05-11T15:43:05.612817  =


    2023-05-11T15:43:05.618063  / # /lava-10284426/bin/lava-test-runner /la=
va-10284426/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/645d10449a9664d11c2e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d10449a9664d11c2e85f6
        failing since 42 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-11T15:56:47.035181  + <8>[   12.572858] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10284947_1.4.2.3.1>

    2023-05-11T15:56:47.035314  set +x

    2023-05-11T15:56:47.139730  / # #

    2023-05-11T15:56:47.240375  export SHELL=3D/bin/sh

    2023-05-11T15:56:47.240618  #

    2023-05-11T15:56:47.341120  / # export SHELL=3D/bin/sh. /lava-10284947/=
environment

    2023-05-11T15:56:47.341360  =


    2023-05-11T15:56:47.441877  / # . /lava-10284947/environment/lava-10284=
947/bin/lava-test-runner /lava-10284947/1

    2023-05-11T15:56:47.442265  =


    2023-05-11T15:56:47.446942  / # /lava-10284947/bin/lava-test-runner /la=
va-10284947/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0d19a4911c7a702e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0d19a4911c7a702e85eb
        failing since 42 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-11T15:43:16.377021  <8>[   10.802435] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10284468_1.4.2.3.1>

    2023-05-11T15:43:16.380388  + set +x

    2023-05-11T15:43:16.485411  #

    2023-05-11T15:43:16.486490  =


    2023-05-11T15:43:16.588237  / # #export SHELL=3D/bin/sh

    2023-05-11T15:43:16.589125  =


    2023-05-11T15:43:16.690587  / # export SHELL=3D/bin/sh. /lava-10284468/=
environment

    2023-05-11T15:43:16.691384  =


    2023-05-11T15:43:16.792718  / # . /lava-10284468/environment/lava-10284=
468/bin/lava-test-runner /lava-10284468/1

    2023-05-11T15:43:16.793912  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/645d1040dccc9407c12e863a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d1040dccc9407c12e863f
        failing since 42 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-11T15:56:41.898768  + set +x

    2023-05-11T15:56:41.905639  <8>[   11.366029] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10284910_1.4.2.3.1>

    2023-05-11T15:56:42.013148  / # #

    2023-05-11T15:56:42.115326  export SHELL=3D/bin/sh

    2023-05-11T15:56:42.116036  #

    2023-05-11T15:56:42.217418  / # export SHELL=3D/bin/sh. /lava-10284910/=
environment

    2023-05-11T15:56:42.218165  =


    2023-05-11T15:56:42.319546  / # . /lava-10284910/environment/lava-10284=
910/bin/lava-test-runner /lava-10284910/1

    2023-05-11T15:56:42.321037  =


    2023-05-11T15:56:42.326267  / # /lava-10284910/bin/lava-test-runner /la=
va-10284910/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645d11c88c91fc759d2e86bd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d11c88c91fc759d2e86c0
        failing since 69 days (last pass: v5.15.79, first fail: v5.15.97)

    2023-05-11T16:02:41.185918  [   19.856717] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1218928_1.5.2.4.1>
    2023-05-11T16:02:41.291343  / # #
    2023-05-11T16:02:41.393177  export SHELL=3D/bin/sh
    2023-05-11T16:02:41.393576  #
    2023-05-11T16:02:41.494741  / # export SHELL=3D/bin/sh. /lava-1218928/e=
nvironment
    2023-05-11T16:02:41.495214  =

    2023-05-11T16:02:41.596541  / # . /lava-1218928/environment/lava-121892=
8/bin/lava-test-runner /lava-1218928/1
    2023-05-11T16:02:41.597154  =

    2023-05-11T16:02:41.598829  / # /lava-1218928/bin/lava-test-runner /lav=
a-1218928/1
    2023-05-11T16:02:41.616619  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0d0110c2094a5c2e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0d0110c2094a5c2e85f8
        failing since 42 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-11T15:42:46.200747  + <8>[   10.704735] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10284485_1.4.2.3.1>

    2023-05-11T15:42:46.200826  set +x

    2023-05-11T15:42:46.301997  #

    2023-05-11T15:42:46.302225  =


    2023-05-11T15:42:46.402855  / # #export SHELL=3D/bin/sh

    2023-05-11T15:42:46.403095  =


    2023-05-11T15:42:46.503833  / # export SHELL=3D/bin/sh. /lava-10284485/=
environment

    2023-05-11T15:42:46.504568  =


    2023-05-11T15:42:46.606025  / # . /lava-10284485/environment/lava-10284=
485/bin/lava-test-runner /lava-10284485/1

    2023-05-11T15:42:46.607080  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/645d1091124f8794682e8629

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d1091124f8794682e862e
        failing since 42 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-11T15:58:01.715039  + set<8>[   12.702610] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10284932_1.4.2.3.1>

    2023-05-11T15:58:01.715196   +x

    2023-05-11T15:58:01.819556  / # #

    2023-05-11T15:58:01.920299  export SHELL=3D/bin/sh

    2023-05-11T15:58:01.920518  #

    2023-05-11T15:58:02.021047  / # export SHELL=3D/bin/sh. /lava-10284932/=
environment

    2023-05-11T15:58:02.021299  =


    2023-05-11T15:58:02.121893  / # . /lava-10284932/environment/lava-10284=
932/bin/lava-test-runner /lava-10284932/1

    2023-05-11T15:58:02.122221  =


    2023-05-11T15:58:02.127092  / # /lava-10284932/bin/lava-test-runner /la=
va-10284932/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0d10d1d37f36762e860f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0d10d1d37f36762e8614
        failing since 42 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-11T15:42:54.613117  <8>[   10.107426] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10284465_1.4.2.3.1>

    2023-05-11T15:42:54.616076  + set +x

    2023-05-11T15:42:54.717529  =


    2023-05-11T15:42:54.818173  / # #export SHELL=3D/bin/sh

    2023-05-11T15:42:54.818386  =


    2023-05-11T15:42:54.918957  / # export SHELL=3D/bin/sh. /lava-10284465/=
environment

    2023-05-11T15:42:54.919199  =


    2023-05-11T15:42:55.019684  / # . /lava-10284465/environment/lava-10284=
465/bin/lava-test-runner /lava-10284465/1

    2023-05-11T15:42:55.020009  =


    2023-05-11T15:42:55.025069  / # /lava-10284465/bin/lava-test-runner /la=
va-10284465/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/645d10449a9664d11c2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d10449a9664d11c2e85eb
        failing since 42 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-11T15:56:29.553574  + set +x

    2023-05-11T15:56:29.560234  <8>[   12.133116] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10284926_1.4.2.3.1>

    2023-05-11T15:56:29.664468  / # #

    2023-05-11T15:56:29.765022  export SHELL=3D/bin/sh

    2023-05-11T15:56:29.765172  #

    2023-05-11T15:56:29.865676  / # export SHELL=3D/bin/sh. /lava-10284926/=
environment

    2023-05-11T15:56:29.865826  =


    2023-05-11T15:56:29.966370  / # . /lava-10284926/environment/lava-10284=
926/bin/lava-test-runner /lava-10284926/1

    2023-05-11T15:56:29.966598  =


    2023-05-11T15:56:29.971503  / # /lava-10284926/bin/lava-test-runner /la=
va-10284926/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0d21a4911c7a702e8604

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0d21a4911c7a702e8609
        failing since 42 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-11T15:43:06.112541  + set<8>[    8.658365] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10284484_1.4.2.3.1>

    2023-05-11T15:43:06.112627   +x

    2023-05-11T15:43:06.216761  / # #

    2023-05-11T15:43:06.317284  export SHELL=3D/bin/sh

    2023-05-11T15:43:06.317417  #

    2023-05-11T15:43:06.417916  / # export SHELL=3D/bin/sh. /lava-10284484/=
environment

    2023-05-11T15:43:06.418063  =


    2023-05-11T15:43:06.518573  / # . /lava-10284484/environment/lava-10284=
484/bin/lava-test-runner /lava-10284484/1

    2023-05-11T15:43:06.518792  =


    2023-05-11T15:43:06.523548  / # /lava-10284484/bin/lava-test-runner /la=
va-10284484/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/645d104fdccc9407c12e874e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d104fdccc9407c12e8753
        failing since 42 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-11T15:56:38.526366  + <8>[   11.559360] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10284936_1.4.2.3.1>

    2023-05-11T15:56:38.526447  set +x

    2023-05-11T15:56:38.631148  / # #

    2023-05-11T15:56:38.731855  export SHELL=3D/bin/sh

    2023-05-11T15:56:38.732063  #

    2023-05-11T15:56:38.832605  / # export SHELL=3D/bin/sh. /lava-10284936/=
environment

    2023-05-11T15:56:38.832821  =


    2023-05-11T15:56:38.933358  / # . /lava-10284936/environment/lava-10284=
936/bin/lava-test-runner /lava-10284936/1

    2023-05-11T15:56:38.933687  =


    2023-05-11T15:56:38.938401  / # /lava-10284936/bin/lava-test-runner /la=
va-10284936/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645d10ffa813776dbc2e8729

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d10ffa813776dbc2e872e
        failing since 99 days (last pass: v5.15.81, first fail: v5.15.91)

    2023-05-11T15:59:33.316536  + set +x
    2023-05-11T15:59:33.316681  [    9.423542] <LAVA_SIGNAL_ENDRUN 0_dmesg =
947929_1.5.2.3.1>
    2023-05-11T15:59:33.424269  / # #
    2023-05-11T15:59:33.525853  export SHELL=3D/bin/sh
    2023-05-11T15:59:33.526323  #
    2023-05-11T15:59:33.627768  / # export SHELL=3D/bin/sh. /lava-947929/en=
vironment
    2023-05-11T15:59:33.628207  =

    2023-05-11T15:59:33.729401  / # . /lava-947929/environment/lava-947929/=
bin/lava-test-runner /lava-947929/1
    2023-05-11T15:59:33.729886  =

    2023-05-11T15:59:33.732559  / # /lava-947929/bin/lava-test-runner /lava=
-947929/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0d0310c2094a5c2e8601

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0d0310c2094a5c2e8606
        failing since 42 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-11T15:42:50.110829  + <8>[   11.284677] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10284490_1.4.2.3.1>

    2023-05-11T15:42:50.110963  set +x

    2023-05-11T15:42:50.215314  / # #

    2023-05-11T15:42:50.315948  export SHELL=3D/bin/sh

    2023-05-11T15:42:50.316168  #

    2023-05-11T15:42:50.416729  / # export SHELL=3D/bin/sh. /lava-10284490/=
environment

    2023-05-11T15:42:50.416945  =


    2023-05-11T15:42:50.517492  / # . /lava-10284490/environment/lava-10284=
490/bin/lava-test-runner /lava-10284490/1

    2023-05-11T15:42:50.517824  =


    2023-05-11T15:42:50.522759  / # /lava-10284490/bin/lava-test-runner /la=
va-10284490/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/645d1038481ca87abc2e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d1038481ca87abc2e85fc
        failing since 42 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-11T15:56:18.789932  + <8>[   11.790082] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10284945_1.4.2.3.1>

    2023-05-11T15:56:18.790033  set +x

    2023-05-11T15:56:18.894038  / # #

    2023-05-11T15:56:18.994929  export SHELL=3D/bin/sh

    2023-05-11T15:56:18.995636  #

    2023-05-11T15:56:19.096853  / # export SHELL=3D/bin/sh. /lava-10284945/=
environment

    2023-05-11T15:56:19.097084  =


    2023-05-11T15:56:19.197629  / # . /lava-10284945/environment/lava-10284=
945/bin/lava-test-runner /lava-10284945/1

    2023-05-11T15:56:19.198046  =


    2023-05-11T15:56:19.203110  / # /lava-10284945/bin/lava-test-runner /la=
va-10284945/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/645d1115a1436454ec2e86af

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645d1115a1436454ec2e8=
6b0
        failing since 107 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/645d0f364d7e3f91192e860d

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/645d0f364d7e3f91192e861a
        new failure (last pass: v5.15.110)

    2023-05-11T15:52:04.382418  /lava-10284721/1/../bin/lava-test-case

    2023-05-11T15:52:04.388568  <8>[   60.577149] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/645d0f364d7e3f91192e8638
        new failure (last pass: v5.15.110)

    2023-05-11T15:52:05.422174  /lava-10284721/1/../bin/lava-test-case

    2023-05-11T15:52:05.428617  <8>[   61.617892] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/645d0f364d7e3f91192e8638
        new failure (last pass: v5.15.110)

    2023-05-11T15:52:05.422174  /lava-10284721/1/../bin/lava-test-case

    2023-05-11T15:52:05.428617  <8>[   61.617892] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0f364d7e3f91192e8693
        new failure (last pass: v5.15.110)

    2023-05-11T15:51:50.171730  + set +x

    2023-05-11T15:51:50.177903  <8>[   46.366671] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10284721_1.5.2.3.1>

    2023-05-11T15:51:50.285398  / # #

    2023-05-11T15:51:50.387730  export SHELL=3D/bin/sh

    2023-05-11T15:51:50.388450  #

    2023-05-11T15:51:50.489799  / # export SHELL=3D/bin/sh. /lava-10284721/=
environment

    2023-05-11T15:51:50.490561  =


    2023-05-11T15:51:50.592023  / # . /lava-10284721/environment/lava-10284=
721/bin/lava-test-runner /lava-10284721/1

    2023-05-11T15:51:50.593203  =


    2023-05-11T15:51:50.598601  / # /lava-10284721/bin/lava-test-runner /la=
va-10284721/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 4          =


  Details:     https://kernelci.org/test/plan/id/645d10589a9664d11c2e862c

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/645d10589a9664d11c2e8646
        new failure (last pass: v5.15.110)

    2023-05-11T15:56:57.630901  /lava-10284868/1/../bin/lava-test-case

    2023-05-11T15:56:57.649794  <8>[   69.966271] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/645d10589a9664d11c2e8646
        new failure (last pass: v5.15.110)

    2023-05-11T15:56:57.630901  /lava-10284868/1/../bin/lava-test-case

    2023-05-11T15:56:57.649794  <8>[   69.966271] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/645d10589a9664d11c2e8648
        new failure (last pass: v5.15.110)

    2023-05-11T15:56:56.519810  /lava-10284868/1/../bin/lava-test-case

    2023-05-11T15:56:56.538358  <8>[   68.854758] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d10589a9664d11c2e86b1
        new failure (last pass: v5.15.110)

    2023-05-11T15:56:37.325261  + set +x<8>[   49.645606] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10284868_1.5.2.3.1>

    2023-05-11T15:56:37.328795  =


    2023-05-11T15:56:37.438729  / # #

    2023-05-11T15:56:37.541214  export SHELL=3D/bin/sh

    2023-05-11T15:56:37.542043  #

    2023-05-11T15:56:37.643658  / # export SHELL=3D/bin/sh. /lava-10284868/=
environment

    2023-05-11T15:56:37.644498  =


    2023-05-11T15:56:37.746056  / # . /lava-10284868/environment/lava-10284=
868/bin/lava-test-runner /lava-10284868/1

    2023-05-11T15:56:37.747272  =


    2023-05-11T15:56:37.752411  / # /lava-10284868/bin/lava-test-runner /la=
va-10284868/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645d1352c971014d812e8626

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d1352c971014d812e8653
        failing since 94 days (last pass: v5.15.82, first fail: v5.15.92)

    2023-05-11T16:09:22.818619  <8>[   16.101653] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3575914_1.5.2.4.1>
    2023-05-11T16:09:22.938976  / # #
    2023-05-11T16:09:23.044596  export SHELL=3D/bin/sh
    2023-05-11T16:09:23.046105  #
    2023-05-11T16:09:23.149535  / # export SHELL=3D/bin/sh. /lava-3575914/e=
nvironment
    2023-05-11T16:09:23.151101  =

    2023-05-11T16:09:23.254552  / # . /lava-3575914/environment/lava-357591=
4/bin/lava-test-runner /lava-3575914/1
    2023-05-11T16:09:23.257312  =

    2023-05-11T16:09:23.259616  / # /lava-3575914/bin/lava-test-runner /lav=
a-3575914/1
    2023-05-11T16:09:23.307394  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0c8c9c1b53f5112e8629

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-r1.=
txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.111/=
arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-r1.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0c8c9c1b53f5112e862e
        failing since 98 days (last pass: v5.15.82, first fail: v5.15.91)

    2023-05-11T15:40:42.432320  / # #
    2023-05-11T15:40:42.546513  export SHELL=3D/bin/sh
    2023-05-11T15:40:42.549079  #
    2023-05-11T15:40:42.653837  / # export SHELL=3D/bin/sh. /lava-3575797/e=
nvironment
    2023-05-11T15:40:42.656314  =

    2023-05-11T15:40:42.760438  / # . /lava-3575797/environment/lava-357579=
7/bin/lava-test-runner /lava-3575797/1
    2023-05-11T15:40:42.763918  =

    2023-05-11T15:40:42.781600  / # /lava-3575797/bin/lava-test-runner /lav=
a-3575797/1
    2023-05-11T15:40:42.881261  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-11T15:40:42.884595  + cd /lava-3575797/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

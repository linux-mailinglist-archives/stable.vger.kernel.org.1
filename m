Return-Path: <stable+bounces-5192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3533F80B97B
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 07:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C335B20AC0
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 06:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CBB4426;
	Sun, 10 Dec 2023 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="rx+IttFm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1431010C4
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 22:58:32 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d0a7b72203so29964675ad.2
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 22:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702191512; x=1702796312; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zp9/K/lLG+hPK7y7jiqIXTY0xfN4bqdomZS0cVCYWOo=;
        b=rx+IttFmFaHwToPvOOC1Z68Jj2zxtL/f4VaSE6I+4Mcyl9i/dnqhSWMoOqhAip8z1/
         dET7lEh0NrWM8JmyjRWUN9B54i6n8bwHfju23JLtNKUoVzDtqwj/52I24FocBvMeDkv/
         JsPFLLeJGImjac5Xg/9/16k1piwenlDddJAQ0Ry1hVmYK6ednwzCQapb1zHM9CSmsa3S
         TslqBQ8MtPCTmTLvpNkoc4dwja0f/QDdjplnmJDLxATQas343My26NmM4MDlhf0BiG2K
         zJU4IUmwaTNBPc/0q2KmSrdPoeT97abBwI18PpWfWqu47evYL8X5Y+J4/Xn20CKbhT11
         nETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702191512; x=1702796312;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zp9/K/lLG+hPK7y7jiqIXTY0xfN4bqdomZS0cVCYWOo=;
        b=UplK09lglKDE7jTZnbEb0HqIo8vKjwBsTYPslj7BchnX7czQMNLN7CylcEpXn8GcOq
         zC8d8Hu7mE9Bl8kNr4KBp8fWTm5QnfIyBQ965sGWRwAB8wf8N5a1iyZ6Y27CKuOQ+SSX
         ZdsYDVm8IlHpDze5NTvTVF5a3+3jVT0EY+AWnNLu6IQCplTwRXMbnif3M+04ewu5tXYt
         hPbdhVjpoI9zcuzth0AL1AZwJSeXZC+Kp6nf/sl+RIfBJBPOX7D5mZXHA3QIaORdn7gG
         UkBF9rGfrsnxDE10OC/N7zZTP6zw5NaTY660Hauvtrie5Nk3vuNEJbpSwRi9vInvp+rO
         7Z5Q==
X-Gm-Message-State: AOJu0YxMeBG0Ijkl4rhh4zComJBPzx4L/iH9wMpfj5Bh+HU16rRswVvc
	M4NkPThBIOGpW5ppR4qXbD8Cp1qhlNcYKjDd7PUzZg==
X-Google-Smtp-Source: AGHT+IFw2NQLgvRqsTCyj49d60A7Pq+5x3uEBsl/jJLqynuqcRTi+j/bqWC0EI0XhqbFW95SoIgGBg==
X-Received: by 2002:a17:903:245:b0:1d0:c1fe:694c with SMTP id j5-20020a170903024500b001d0c1fe694cmr3438538plh.47.1702191511750;
        Sat, 09 Dec 2023 22:58:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902dacb00b001d053a56fb4sm4332612plx.67.2023.12.09.22.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 22:58:31 -0800 (PST)
Message-ID: <65756197.170a0220.46e6c.ccb7@mx.google.com>
Date: Sat, 09 Dec 2023 22:58:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.203-59-ge7f08cc8d6a32
Subject: stable-rc/queue/5.10 baseline: 132 runs,
 11 regressions (v5.10.203-59-ge7f08cc8d6a32)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 132 runs, 11 regressions (v5.10.203-59-ge7f0=
8cc8d6a32)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beagle-xm                    | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =

beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

meson-gxbb-p200              | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

panda                        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =

r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =

sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.203-59-ge7f08cc8d6a32/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.203-59-ge7f08cc8d6a32
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e7f08cc8d6a327dcd7e7776f8b61b3ab46c48d9b =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beagle-xm                    | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6575321657e15d4fa5e13532

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6575321657e15d4fa5e13=
533
        new failure (last pass: v5.10.203-59-gaffef748422f6) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6575309da91f745365e134e0

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575309da91f745365e13515
        failing since 299 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-10T03:29:13.202933  <8>[   15.895813] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 333241_1.5.2.4.1>
    2023-12-10T03:29:13.311939  / # #
    2023-12-10T03:29:13.415067  export SHELL=3D/bin/sh
    2023-12-10T03:29:13.415965  #
    2023-12-10T03:29:13.518089  / # export SHELL=3D/bin/sh. /lava-333241/en=
vironment
    2023-12-10T03:29:13.519002  =

    2023-12-10T03:29:13.620984  / # . /lava-333241/environment/lava-333241/=
bin/lava-test-runner /lava-333241/1
    2023-12-10T03:29:13.622386  =

    2023-12-10T03:29:13.626564  / # /lava-333241/bin/lava-test-runner /lava=
-333241/1
    2023-12-10T03:29:13.734162  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6575319e3ccd2f09e5e1348a

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575319e3ccd2f09e5e134c6
        new failure (last pass: v5.10.203-59-gaffef748422f6)

    2023-12-10T03:33:19.616514  / # #
    2023-12-10T03:33:19.719474  export SHELL=3D/bin/sh
    2023-12-10T03:33:19.720273  #
    2023-12-10T03:33:19.822188  / # export SHELL=3D/bin/sh. /lava-333237/en=
vironment
    2023-12-10T03:33:19.822970  =

    2023-12-10T03:33:19.924948  / # . /lava-333237/environment/lava-333237/=
bin/lava-test-runner /lava-333237/1
    2023-12-10T03:33:19.926248  =

    2023-12-10T03:33:19.940826  / # /lava-333237/bin/lava-test-runner /lava=
-333237/1
    2023-12-10T03:33:19.999688  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-10T03:33:20.000197  + cd /lava-333237/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxbb-p200              | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6575314f88a37afb49e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6575314f88a37afb49e13=
476
        failing since 0 day (last pass: v5.10.203-46-g46c237c8ed938, first =
fail: v5.10.203-59-gaffef748422f6) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
panda                        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/657530e2db8ffeef0de134e0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657530e2db8ffeef0de134e5
        failing since 3 days (last pass: v5.10.148-91-g23f89880f93d, first =
fail: v5.10.202-131-g761b9c32d3c8b)

    2023-12-10T03:30:19.611973  + <8>[   24.576507] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 3872322_1.5.2.4.1>
    2023-12-10T03:30:19.612216  set +x
    2023-12-10T03:30:19.716731  / # #
    2023-12-10T03:30:19.818011  export SHELL=3D/bin/sh
    2023-12-10T03:30:19.818471  #
    2023-12-10T03:30:19.919273  / # export SHELL=3D/bin/sh. /lava-3872322/e=
nvironment
    2023-12-10T03:30:19.919676  =

    2023-12-10T03:30:20.020536  / # . /lava-3872322/environment/lava-387232=
2/bin/lava-test-runner /lava-3872322/1
    2023-12-10T03:30:20.021246  =

    2023-12-10T03:30:20.026293  / # /lava-3872322/bin/lava-test-runner /lav=
a-3872322/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77960-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65753045e255139393e13476

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65753045e255139393e1347b
        failing since 17 days (last pass: v5.10.181-18-g1622068b57a4, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-10T03:35:17.432639  / # #

    2023-12-10T03:35:17.533127  export SHELL=3D/bin/sh

    2023-12-10T03:35:17.533303  #

    2023-12-10T03:35:17.633752  / # export SHELL=3D/bin/sh. /lava-12233308/=
environment

    2023-12-10T03:35:17.633877  =


    2023-12-10T03:35:17.734303  / # . /lava-12233308/environment/lava-12233=
308/bin/lava-test-runner /lava-12233308/1

    2023-12-10T03:35:17.734490  =


    2023-12-10T03:35:17.746592  / # /lava-12233308/bin/lava-test-runner /la=
va-12233308/1

    2023-12-10T03:35:17.807113  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T03:35:17.807213  + cd /lav<8>[   16.394328] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12233308_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/657531083035f6aa5ae13475

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/657531083035f6aa5ae1347d
        failing since 271 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-10T03:31:06.651853  <8>[   61.093790] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-12-10T03:31:07.675865  /lava-12233358/1/../bin/lava-test-case

    2023-12-10T03:31:07.687484  <8>[   62.129127] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/657531083035f6aa5ae1347e
        failing since 271 days (last pass: v5.10.172-529-g06956b9e9396, fir=
st fail: v5.10.173-69-gfcbe6bd469ed)

    2023-12-10T03:31:06.640743  /lava-12233358/1/../bin/lava-test-case
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-clabbe    | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6575303e57fb116c26e134e3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575303e57fb116c26e134e8
        failing since 17 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-10T03:27:52.769237  <8>[   16.995301] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447364_1.5.2.4.1>
    2023-12-10T03:27:52.874405  / # #
    2023-12-10T03:27:52.976033  export SHELL=3D/bin/sh
    2023-12-10T03:27:52.976606  #
    2023-12-10T03:27:53.077694  / # export SHELL=3D/bin/sh. /lava-447364/en=
vironment
    2023-12-10T03:27:53.078345  =

    2023-12-10T03:27:53.179659  / # . /lava-447364/environment/lava-447364/=
bin/lava-test-runner /lava-447364/1
    2023-12-10T03:27:53.180562  =

    2023-12-10T03:27:53.184632  / # /lava-447364/bin/lava-test-runner /lava=
-447364/1
    2023-12-10T03:27:53.251634  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6575304d693feae199e134da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575304d693feae199e134df
        failing since 17 days (last pass: v5.10.176-241-ga0049fd9c865, firs=
t fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-10T03:35:32.249632  / # #

    2023-12-10T03:35:32.351403  export SHELL=3D/bin/sh

    2023-12-10T03:35:32.352087  #

    2023-12-10T03:35:32.453383  / # export SHELL=3D/bin/sh. /lava-12233317/=
environment

    2023-12-10T03:35:32.453588  =


    2023-12-10T03:35:32.554103  / # . /lava-12233317/environment/lava-12233=
317/bin/lava-test-runner /lava-12233317/1

    2023-12-10T03:35:32.554370  =


    2023-12-10T03:35:32.563401  / # /lava-12233317/bin/lava-test-runner /la=
va-12233317/1

    2023-12-10T03:35:32.625047  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-10T03:35:32.625130  + cd /lava-1223331<8>[   18.143532] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12233317_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6575306827df9c49a1e13492

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.203=
-59-ge7f08cc8d6a32/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8=
i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6575306827df9c49a1e13497
        failing since 17 days (last pass: v5.10.165-77-g4600242c13ed, first=
 fail: v5.10.201-98-g6f84b6dba25c)

    2023-12-10T03:28:07.665797  / # #
    2023-12-10T03:28:07.766992  export SHELL=3D/bin/sh
    2023-12-10T03:28:07.767434  #
    2023-12-10T03:28:07.868253  / # export SHELL=3D/bin/sh. /lava-3872324/e=
nvironment
    2023-12-10T03:28:07.868677  =

    2023-12-10T03:28:07.969527  / # . /lava-3872324/environment/lava-387232=
4/bin/lava-test-runner /lava-3872324/1
    2023-12-10T03:28:07.970200  =

    2023-12-10T03:28:07.977776  / # /lava-3872324/bin/lava-test-runner /lav=
a-3872324/1
    2023-12-10T03:28:08.075762  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-10T03:28:08.076302  + cd /lava-3872324/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20


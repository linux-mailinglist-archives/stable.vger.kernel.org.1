Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1FF73564C
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjFSLzC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjFSLy5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:54:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356D8102
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:54:54 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b52bf6e66aso13328525ad.3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687175693; x=1689767693;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ihJfDGjP1tovUehUyFR5t83szJ3NttlW53eCl7hYgNY=;
        b=E3t9EMWHlfoVLXs52UhdiF5VA9E1KWhl5iiMEUa0JujwxDxBbQq0GP5TEmaPeAzUey
         QNXRXnWXX0w1M7fPiClb7Uwonnzg5TVLg5NCY0qaVRDIKLKJ64qnF25yjFJO+RsIPLrz
         z6ZPTmWU4sKjB3v9vINF6hgH3pyTBPaW4VzoL0GzNVhK02BNkKztF6vComVDJDdZEXyi
         08lYQ14bePzCwttIz1AhWv8NpJM/5JA5JbuaF7UoJUM0ZpiAjzZJkoprK3fo5rUCVjYP
         hW+U9iqJNgpkdSOqE9GjGcsh0LET2kxmwrvfCccEYsE6s1Tmt2IjUty6Pzyyj3u0tViB
         WT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687175693; x=1689767693;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihJfDGjP1tovUehUyFR5t83szJ3NttlW53eCl7hYgNY=;
        b=UndhjzPE3T8SjFTGcFRhOJYdEwaEqRHV0NEZ8bpRh2DeMtv7eFPZuXwOcJeSSaCiV3
         7a21C6cM0a2iIqZz3NfoxHcFqCMih8PGxjBwTYC/4OZAgbRM9ZxWlzQGssgQaY1yYHZL
         ROqmFvT6bEPuYUSegGH2i4W/vmIu3Xdh53NZHiTQHhSvX3cSmvTTxf7qk/n8zisI5q/H
         tZwdbjlwPjLDOS2g/78chPrDXvQsRDOZ9LdTJOiVKfJeoaqHt4kCyCXjJvnjetfIm8hF
         VO9So8D6fZ/0uVXcCaoX3VE7YHlf9mkBmeTpX5FFyBrFj/ZnFR1DGNhZD7wOMwIXxaO2
         ta3w==
X-Gm-Message-State: AC+VfDw53NWcjNKYOX1Xu1pWVZ1CPWJIyQFOvthXR7Tg8kRnWta3D25C
        YFivVY6qC8eoIPDoy7Ll9HmZIkDdx1Kv/+bIQdL7XJdn
X-Google-Smtp-Source: ACHHUZ6cj33vp8enZZ2Mjr4++Gp0fPT4nuDAHBnlQVV38jyzLIL4cqf/5ne5Cpldjsh0mOlOIgZqxQ==
X-Received: by 2002:a17:902:f550:b0:1b5:ddf:b1b0 with SMTP id h16-20020a170902f55000b001b50ddfb1b0mr703186plf.20.1687175692597;
        Mon, 19 Jun 2023 04:54:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902bd0800b001b56012be2csm2355674pls.231.2023.06.19.04.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 04:54:51 -0700 (PDT)
Message-ID: <6490420b.170a0220.a8cc4.390c@mx.google.com>
Date:   Mon, 19 Jun 2023 04:54:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.117-107-g3f3aec31cf77
Subject: stable-rc/linux-5.15.y baseline: 160 runs,
 18 regressions (v5.15.117-107-g3f3aec31cf77)
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

stable-rc/linux-5.15.y baseline: 160 runs, 18 regressions (v5.15.117-107-g3=
f3aec31cf77)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =

rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.117-107-g3f3aec31cf77/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.117-107-g3f3aec31cf77
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3f3aec31cf77e80559597f642575faf78ca7df7a =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649010c234ebeb7c46306159

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649010c234ebeb7c4630615e
        failing since 82 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-19T08:24:18.696277  <8>[   10.836562] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10808423_1.4.2.3.1>

    2023-06-19T08:24:18.699914  + set +x

    2023-06-19T08:24:18.808529  / # #

    2023-06-19T08:24:18.910863  export SHELL=3D/bin/sh

    2023-06-19T08:24:18.911230  #

    2023-06-19T08:24:19.012039  / # export SHELL=3D/bin/sh. /lava-10808423/=
environment

    2023-06-19T08:24:19.012833  =


    2023-06-19T08:24:19.114248  / # . /lava-10808423/environment/lava-10808=
423/bin/lava-test-runner /lava-10808423/1

    2023-06-19T08:24:19.115426  =


    2023-06-19T08:24:19.122063  / # /lava-10808423/bin/lava-test-runner /la=
va-10808423/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649011b01bac3f7cd4306165

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649011b01bac3f7cd430616a
        failing since 82 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-19T08:28:12.358547  + set +x<8>[   11.480742] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10808409_1.4.2.3.1>

    2023-06-19T08:28:12.358637  =


    2023-06-19T08:28:12.462647  / # #

    2023-06-19T08:28:12.564776  export SHELL=3D/bin/sh

    2023-06-19T08:28:12.565433  #

    2023-06-19T08:28:12.666875  / # export SHELL=3D/bin/sh. /lava-10808409/=
environment

    2023-06-19T08:28:12.667533  =


    2023-06-19T08:28:12.768813  / # . /lava-10808409/environment/lava-10808=
409/bin/lava-test-runner /lava-10808409/1

    2023-06-19T08:28:12.769079  =


    2023-06-19T08:28:12.773538  / # /lava-10808409/bin/lava-test-runner /la=
va-10808409/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649010b134ebeb7c4630612f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649010b134ebeb7c46306134
        failing since 82 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-19T08:24:08.796166  <8>[   10.408437] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10808439_1.4.2.3.1>

    2023-06-19T08:24:08.799391  + set +x

    2023-06-19T08:24:08.905066  =


    2023-06-19T08:24:09.006592  / # #export SHELL=3D/bin/sh

    2023-06-19T08:24:09.006798  =


    2023-06-19T08:24:09.107287  / # export SHELL=3D/bin/sh. /lava-10808439/=
environment

    2023-06-19T08:24:09.107482  =


    2023-06-19T08:24:09.208013  / # . /lava-10808439/environment/lava-10808=
439/bin/lava-test-runner /lava-10808439/1

    2023-06-19T08:24:09.208262  =


    2023-06-19T08:24:09.213135  / # /lava-10808439/bin/lava-test-runner /la=
va-10808439/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64900f5707451c2d3e306133

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64900f5707451c2d3e306=
134
        failing since 402 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64900fe53e2079f7be30612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64900fe53e2079f7be306133
        failing since 153 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-19T08:20:46.554377  + set +x<8>[   10.002354] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3676325_1.5.2.4.1>
    2023-06-19T08:20:46.555018  =

    2023-06-19T08:20:46.665199  / # #
    2023-06-19T08:20:46.768518  export SHELL=3D/bin/sh
    2023-06-19T08:20:46.769449  #
    2023-06-19T08:20:46.871472  / # export SHELL=3D/bin/sh. /lava-3676325/e=
nvironment
    2023-06-19T08:20:46.872363  =

    2023-06-19T08:20:46.974424  / # . /lava-3676325/environment/lava-367632=
5/bin/lava-test-runner /lava-3676325/1
    2023-06-19T08:20:46.976098  =

    2023-06-19T08:20:46.981300  / # /lava-3676325/bin/lava-test-runner /lav=
a-3676325/1<3>[   10.433361] Bluetooth: hci0: command 0xfc79 tx timeout =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649011f85243dd538a30613c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649011f85243dd538a306141
        failing since 82 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-19T08:29:31.209210  + set +x

    2023-06-19T08:29:31.215959  <8>[   10.352292] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10808418_1.4.2.3.1>

    2023-06-19T08:29:31.320205  / # #

    2023-06-19T08:29:31.420897  export SHELL=3D/bin/sh

    2023-06-19T08:29:31.421122  #

    2023-06-19T08:29:31.521666  / # export SHELL=3D/bin/sh. /lava-10808418/=
environment

    2023-06-19T08:29:31.521888  =


    2023-06-19T08:29:31.622435  / # . /lava-10808418/environment/lava-10808=
418/bin/lava-test-runner /lava-10808418/1

    2023-06-19T08:29:31.622824  =


    2023-06-19T08:29:31.627084  / # /lava-10808418/bin/lava-test-runner /la=
va-10808418/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649011c014a1420e22306161

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649011c014a1420e22306166
        failing since 82 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-19T08:28:25.596440  <8>[    7.984047] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10808422_1.4.2.3.1>

    2023-06-19T08:28:25.599402  + set +x

    2023-06-19T08:28:25.700772  =


    2023-06-19T08:28:25.801346  / # #export SHELL=3D/bin/sh

    2023-06-19T08:28:25.801607  =


    2023-06-19T08:28:25.902190  / # export SHELL=3D/bin/sh. /lava-10808422/=
environment

    2023-06-19T08:28:25.902384  =


    2023-06-19T08:28:26.002869  / # . /lava-10808422/environment/lava-10808=
422/bin/lava-test-runner /lava-10808422/1

    2023-06-19T08:28:26.003199  =


    2023-06-19T08:28:26.008638  / # /lava-10808422/bin/lava-test-runner /la=
va-10808422/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649010c0f5718958f23061a4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649010c0f5718958f23061a9
        failing since 82 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-19T08:24:17.236395  + set<8>[   10.872670] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10808376_1.4.2.3.1>

    2023-06-19T08:24:17.236481   +x

    2023-06-19T08:24:17.340849  / # #

    2023-06-19T08:24:17.441467  export SHELL=3D/bin/sh

    2023-06-19T08:24:17.441682  #

    2023-06-19T08:24:17.542194  / # export SHELL=3D/bin/sh. /lava-10808376/=
environment

    2023-06-19T08:24:17.542487  =


    2023-06-19T08:24:17.643077  / # . /lava-10808376/environment/lava-10808=
376/bin/lava-test-runner /lava-10808376/1

    2023-06-19T08:24:17.643361  =


    2023-06-19T08:24:17.648378  / # /lava-10808376/bin/lava-test-runner /la=
va-10808376/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64900ef3091abfad1f306148

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64900ef3091abfad1f30614d
        failing since 139 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-06-19T08:16:42.895492  + set +x
    2023-06-19T08:16:42.895676  [    9.421891] <LAVA_SIGNAL_ENDRUN 0_dmesg =
980970_1.5.2.3.1>
    2023-06-19T08:16:43.003487  / # #
    2023-06-19T08:16:43.105417  export SHELL=3D/bin/sh
    2023-06-19T08:16:43.105924  #
    2023-06-19T08:16:43.207261  / # export SHELL=3D/bin/sh. /lava-980970/en=
vironment
    2023-06-19T08:16:43.207746  =

    2023-06-19T08:16:43.309314  / # . /lava-980970/environment/lava-980970/=
bin/lava-test-runner /lava-980970/1
    2023-06-19T08:16:43.309945  =

    2023-06-19T08:16:43.312439  / # /lava-980970/bin/lava-test-runner /lava=
-980970/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649010a85073d622dc30613b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649010a85073d622dc306140
        failing since 82 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-19T08:23:48.687257  + set<8>[   11.827321] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10808443_1.4.2.3.1>

    2023-06-19T08:23:48.687380   +x

    2023-06-19T08:23:48.792329  / # #

    2023-06-19T08:23:48.893033  export SHELL=3D/bin/sh

    2023-06-19T08:23:48.893294  #

    2023-06-19T08:23:48.993872  / # export SHELL=3D/bin/sh. /lava-10808443/=
environment

    2023-06-19T08:23:48.994105  =


    2023-06-19T08:23:49.094674  / # . /lava-10808443/environment/lava-10808=
443/bin/lava-test-runner /lava-10808443/1

    2023-06-19T08:23:49.095043  =


    2023-06-19T08:23:49.099477  / # /lava-10808443/bin/lava-test-runner /la=
va-10808443/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/64901078f025b0bd9d306191

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64901078f025b0bd9d3061a5
        failing since 35 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-19T08:23:14.961583  /lava-10808340/1/../bin/lava-test-case

    2023-06-19T08:23:14.967833  <8>[   60.509416] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/64901078f025b0bd9d3061ee
        failing since 35 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-19T08:23:16.002760  /lava-10808340/1/../bin/lava-test-case

    2023-06-19T08:23:16.008782  <8>[   61.549902] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/64901078f025b0bd9d3061ee
        failing since 35 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-19T08:23:16.002760  /lava-10808340/1/../bin/lava-test-case

    2023-06-19T08:23:16.008782  <8>[   61.549902] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64901078f025b0bd9d306235
        failing since 35 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-19T08:23:00.794834  + set +x

    2023-06-19T08:23:00.801696  <8>[   46.342897] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10808340_1.5.2.3.1>

    2023-06-19T08:23:00.906561  / # #

    2023-06-19T08:23:01.007362  export SHELL=3D/bin/sh

    2023-06-19T08:23:01.007585  #

    2023-06-19T08:23:01.108194  / # export SHELL=3D/bin/sh. /lava-10808340/=
environment

    2023-06-19T08:23:01.108425  =


    2023-06-19T08:23:01.208987  / # . /lava-10808340/environment/lava-10808=
340/bin/lava-test-runner /lava-10808340/1

    2023-06-19T08:23:01.209289  =


    2023-06-19T08:23:01.214232  / # /lava-10808340/bin/lava-test-runner /la=
va-10808340/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6490110f1b4546433d30615a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-ro=
ck64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6490110f1b4546433d30615f
        failing since 11 days (last pass: v5.15.72-38-gebe70cd7f5413, first=
 fail: v5.15.114-196-g00621f2608ac)

    2023-06-19T08:25:28.207244  [   16.042357] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3676386_1.5.2.4.1>
    2023-06-19T08:25:28.311178  =

    2023-06-19T08:25:28.311381  / # [   16.061814] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-06-19T08:25:28.412826  #export SHELL=3D/bin/sh
    2023-06-19T08:25:28.413177  =

    2023-06-19T08:25:28.514364  / # export SHELL=3D/bin/sh. /lava-3676386/e=
nvironment
    2023-06-19T08:25:28.514791  =

    2023-06-19T08:25:28.616126  / # . /lava-3676386/environment/lava-367638=
6/bin/lava-test-runner /lava-3676386/1
    2023-06-19T08:25:28.616840  =

    2023-06-19T08:25:28.620185  / # /lava-3676386/bin/lava-test-runner /lav=
a-3676386/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649011bf14a1420e2230612e

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a6=
4-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649011bf14a1420e2230615a
        failing since 152 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-19T08:28:22.065605  + set +x
    2023-06-19T08:28:22.069645  <8>[   16.100323] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3676404_1.5.2.4.1>
    2023-06-19T08:28:22.190916  / # #
    2023-06-19T08:28:22.296722  export SHELL=3D/bin/sh
    2023-06-19T08:28:22.298436  #
    2023-06-19T08:28:22.402323  / # export SHELL=3D/bin/sh. /lava-3676404/e=
nvironment
    2023-06-19T08:28:22.403972  =

    2023-06-19T08:28:22.507713  / # . /lava-3676404/environment/lava-367640=
4/bin/lava-test-runner /lava-3676404/1
    2023-06-19T08:28:22.510638  =

    2023-06-19T08:28:22.513777  / # /lava-3676404/bin/lava-test-runner /lav=
a-3676404/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64901130320f066519306184

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64901130320f0665193061b1
        failing since 152 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-19T08:25:51.588662  + set +x
    2023-06-19T08:25:51.591788  <8>[   16.081976] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 629747_1.5.2.4.1>
    2023-06-19T08:25:51.704332  / # #
    2023-06-19T08:25:51.806766  export SHELL=3D/bin/sh
    2023-06-19T08:25:51.807424  #
    2023-06-19T08:25:51.909204  / # export SHELL=3D/bin/sh. /lava-629747/en=
vironment
    2023-06-19T08:25:51.909895  =

    2023-06-19T08:25:52.011806  / # . /lava-629747/environment/lava-629747/=
bin/lava-test-runner /lava-629747/1
    2023-06-19T08:25:52.013205  =

    2023-06-19T08:25:52.016224  / # /lava-629747/bin/lava-test-runner /lava=
-629747/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64900e8236eb8286d430612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
17-107-g3f3aec31cf77/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i=
-h2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64900e8236eb8286d4306131
        failing since 67 days (last pass: v5.15.82-124-g2b8b2c150867, first=
 fail: v5.15.105-194-g415a9d81c640)

    2023-06-19T08:14:38.676612  <8>[    5.874410] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3676276_1.5.2.4.1>
    2023-06-19T08:14:38.796413  / # #
    2023-06-19T08:14:38.902112  export SHELL=3D/bin/sh
    2023-06-19T08:14:38.903706  #
    2023-06-19T08:14:39.007018  / # export SHELL=3D/bin/sh. /lava-3676276/e=
nvironment
    2023-06-19T08:14:39.008609  =

    2023-06-19T08:14:39.111957  / # . /lava-3676276/environment/lava-367627=
6/bin/lava-test-runner /lava-3676276/1
    2023-06-19T08:14:39.114553  =

    2023-06-19T08:14:39.121078  / # /lava-3676276/bin/lava-test-runner /lav=
a-3676276/1
    2023-06-19T08:14:39.222757  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20

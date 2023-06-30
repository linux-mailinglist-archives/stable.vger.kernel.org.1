Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30609743259
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 03:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjF3Bo3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 21:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjF3Bo2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 21:44:28 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920602D55
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:44:26 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55ac628e3cfso790421a12.3
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688089465; x=1690681465;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cPUSUlLtnqUN++x9GC0FeykRZOSpM0zROHZFLPhgPnk=;
        b=Vz1/FeodiVaX1C+D8MDX02Rhr1ORVc80V+mSr7eLAYUV6JtSJMcBLeoC0WTGIZfOXQ
         02CV/rvreGTY1/q+Ac5BV3b5gp3homDQ/uv9ezI2bh+TOR+s77c0+7vwMajze4CJX7l3
         DAhbjW0iAkQolPGyHO3c1C87/uXpW7f7K5Hi/DIE6FJLFYf6hMe12KP/CSxnzSrjk17V
         aWT/4tpiukecxyw2rBtbLb7c/rPOkZLGIziTSTf0xkYUs6jHX4Vv8qNGCd6nGbzJvkdg
         1lEnEIlK95fbFu09388Q4lXy1tPH2+iluez93My9QLDXFUQtk+/oEsBsEz+nITbErcyV
         2BxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688089465; x=1690681465;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPUSUlLtnqUN++x9GC0FeykRZOSpM0zROHZFLPhgPnk=;
        b=MC8PiXREZVGbh3/ogk8R4IIWN6birFYesvtpr8aChDPPnjcGr5lR9IDm+nwDcmfXG3
         UlhKHjwy83Ej1G8se9suZSVWWscb2nO3B6UBSYn1z6UVrNY8hz8gBbx5nZOcZ+wX9rLr
         qDbiVuVqUYkvSizHXyW2Ay7SW3g8+wy5kbCEsT3BbCl0E4wOwJyyaCjGXVOOFhzonFUy
         IgNCCcaft6s9o7jl9uts+iVX/8yY63O9nXm1Bmek+tqcrxhUFBpTrxiwBcdSBFAp0To2
         CW0DEXWwOSfVgyL1DmOTMlcvtKynsVPdDWGtuEYK3Z11b1D57iSUOAB7/FS5W7rsjRrM
         ggyg==
X-Gm-Message-State: AC+VfDxamr+NOx8KOdM5odwOYh1GYFqLM1b9Sal+Etv423eYCUrrFf2h
        hr1LR0Q6NrsNsoDgQzran4GHcNpiNpkSz58GOjZzxg==
X-Google-Smtp-Source: ACHHUZ6UmDKRpWosLwWTBNmsGGuFJiQE4R3g3iOdhjAUBhWaisJQZ9Lt2/thBYN7yO4HjPoKXwObrg==
X-Received: by 2002:a05:6a20:9695:b0:127:4fb0:d448 with SMTP id hp21-20020a056a20969500b001274fb0d448mr1237027pzc.9.1688089465278;
        Thu, 29 Jun 2023 18:44:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jl23-20020a170903135700b001aafa2e212esm9658593plb.52.2023.06.29.18.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 18:44:24 -0700 (PDT)
Message-ID: <649e3378.170a0220.2c829.2ec0@mx.google.com>
Date:   Thu, 29 Jun 2023 18:44:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.186-10-g5f99a36aeb1c
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 166 runs,
 7 regressions (v5.10.186-10-g5f99a36aeb1c)
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

stable-rc/linux-5.10.y baseline: 166 runs, 7 regressions (v5.10.186-10-g5f9=
9a36aeb1c)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-gxl-s905d-p230         | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.186-10-g5f99a36aeb1c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.186-10-g5f99a36aeb1c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5f99a36aeb1c74d6d540796fbbe4904016140d5d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649e10aac6d88fc4a3bb2a9f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-10-g5f99a36aeb1c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-10-g5f99a36aeb1c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cub=
ietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e10aac6d88fc4a3bb2aa4
        failing since 163 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-06-29T23:15:37.239441  + set +x<8>[   11.105957] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3701280_1.5.2.4.1>
    2023-06-29T23:15:37.239967  =

    2023-06-29T23:15:37.349073  / # #
    2023-06-29T23:15:37.452210  export SHELL=3D/bin/sh
    2023-06-29T23:15:37.453039  #
    2023-06-29T23:15:37.554839  / # export SHELL=3D/bin/sh. /lava-3701280/e=
nvironment
    2023-06-29T23:15:37.555609  =

    2023-06-29T23:15:37.657632  / # . /lava-3701280/environment/lava-370128=
0/bin/lava-test-runner /lava-3701280/1
    2023-06-29T23:15:37.658996  =

    2023-06-29T23:15:37.663154  / # /lava-3701280/bin/lava-test-runner /lav=
a-3701280/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649dff10bf89c8127cbb2ad6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-10-g5f99a36aeb1c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-10-g5f99a36aeb1c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649dff10bf89c8127cbb2adb
        failing since 93 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-29T22:00:41.197153  + set +x

    2023-06-29T22:00:41.203440  <8>[   10.438581] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10956360_1.4.2.3.1>

    2023-06-29T22:00:41.307716  / # #

    2023-06-29T22:00:41.408397  export SHELL=3D/bin/sh

    2023-06-29T22:00:41.408620  #

    2023-06-29T22:00:41.509122  / # export SHELL=3D/bin/sh. /lava-10956360/=
environment

    2023-06-29T22:00:41.509345  =


    2023-06-29T22:00:41.609877  / # . /lava-10956360/environment/lava-10956=
360/bin/lava-test-runner /lava-10956360/1

    2023-06-29T22:00:41.610221  =


    2023-06-29T22:00:41.615146  / # /lava-10956360/bin/lava-test-runner /la=
va-10956360/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649dff2312c869a96dbb2a86

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-10-g5f99a36aeb1c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-10-g5f99a36aeb1c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649dff2312c869a96dbb2a8b
        failing since 93 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-29T22:00:48.033382  + set +x<8>[   13.165268] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10956401_1.4.2.3.1>

    2023-06-29T22:00:48.033469  =


    2023-06-29T22:00:48.135014  #

    2023-06-29T22:00:48.235768  / # #export SHELL=3D/bin/sh

    2023-06-29T22:00:48.236011  =


    2023-06-29T22:00:48.336601  / # export SHELL=3D/bin/sh. /lava-10956401/=
environment

    2023-06-29T22:00:48.336814  =


    2023-06-29T22:00:48.437339  / # . /lava-10956401/environment/lava-10956=
401/bin/lava-test-runner /lava-10956401/1

    2023-06-29T22:00:48.437615  =


    2023-06-29T22:00:48.442701  / # /lava-10956401/bin/lava-test-runner /la=
va-10956401/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905d-p230         | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649e03071f1858540bbb2aa8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-10-g5f99a36aeb1c/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-=
s905d-p230.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-10-g5f99a36aeb1c/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-=
s905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649e03071f1858540bbb2=
aa9
        new failure (last pass: v5.10.186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649e00a95177e8ed98bb2a97

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-10-g5f99a36aeb1c/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-10-g5f99a36aeb1c/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-roc=
k64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e00a95177e8ed98bb2a9c
        failing since 62 days (last pass: v5.10.147, first fail: v5.10.176-=
373-g8415c0f9308b)

    2023-06-29T22:07:20.680709  [   16.018709] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3701310_1.5.2.4.1>
    2023-06-29T22:07:20.785741  =

    2023-06-29T22:07:20.785931  / # [   16.066028] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-06-29T22:07:20.887253  #export SHELL=3D/bin/sh
    2023-06-29T22:07:20.887599  =

    2023-06-29T22:07:20.988769  / # export SHELL=3D/bin/sh. /lava-3701310/e=
nvironment
    2023-06-29T22:07:20.989161  =

    2023-06-29T22:07:21.090353  / # . /lava-3701310/environment/lava-370131=
0/bin/lava-test-runner /lava-3701310/1
    2023-06-29T22:07:21.090945  =

    2023-06-29T22:07:21.094402  / # /lava-3701310/bin/lava-test-runner /lav=
a-3701310/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649e054ab573489482bb2a83

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-10-g5f99a36aeb1c/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-10-g5f99a36aeb1c/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64=
-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e054ab573489482bb2a9b
        failing since 150 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-29T22:26:08.807143  + set +x
    2023-06-29T22:26:08.811298  <8>[   17.053657] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3701343_1.5.2.4.1>
    2023-06-29T22:26:08.932349  / # #
    2023-06-29T22:26:09.038278  export SHELL=3D/bin/sh
    2023-06-29T22:26:09.039874  #
    2023-06-29T22:26:09.143556  / # export SHELL=3D/bin/sh. /lava-3701343/e=
nvironment
    2023-06-29T22:26:09.145221  =

    2023-06-29T22:26:09.248907  / # . /lava-3701343/environment/lava-370134=
3/bin/lava-test-runner /lava-3701343/1
    2023-06-29T22:26:09.251746  =

    2023-06-29T22:26:09.254825  / # /lava-3701343/bin/lava-test-runner /lav=
a-3701343/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649e01031cabcfd614bb2aa4

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-10-g5f99a36aeb1c/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-10-g5f99a36aeb1c/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e01031cabcfd614bb2ace
        failing since 150 days (last pass: v5.10.158-107-g6b6a42c25ed4, fir=
st fail: v5.10.165-144-g930bc29c79c4)

    2023-06-29T22:08:51.160145  + set +x
    2023-06-29T22:08:51.164181  <8>[   17.047286] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 678468_1.5.2.4.1>
    2023-06-29T22:08:51.276036  / # #
    2023-06-29T22:08:51.378282  export SHELL=3D/bin/sh
    2023-06-29T22:08:51.378785  #
    2023-06-29T22:08:51.480311  / # export SHELL=3D/bin/sh. /lava-678468/en=
vironment
    2023-06-29T22:08:51.480864  =

    2023-06-29T22:08:51.582708  / # . /lava-678468/environment/lava-678468/=
bin/lava-test-runner /lava-678468/1
    2023-06-29T22:08:51.583975  =

    2023-06-29T22:08:51.587665  / # /lava-678468/bin/lava-test-runner /lava=
-678468/1 =

    ... (12 line(s) more)  =

 =20

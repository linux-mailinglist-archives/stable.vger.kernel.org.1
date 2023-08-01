Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D6D76B5CD
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 15:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjHAN2B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 09:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjHAN16 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 09:27:58 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F9F199E
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 06:27:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686f0d66652so5367947b3a.2
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690896474; x=1691501274;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+7KqnbOJdhgSzyxAwDGskROW5XKWJJbqeZliGdT5zMg=;
        b=JqUKpqwGR6DTC/KlGCbGJyWDtuQ56Ja+Cl1QiOd+hUEsUQTX0cXCB2MHo9yKIEP4vN
         GJbXy2OVtjawo6iNum5ExUVRtxLMD2LOGt+iUnWZuJhrYYbML7HetgvFQrMzUuEZhgd7
         kxi/6ez9ZiSRH3RtvjsBSw+JVBJveW3MOYcxWdilo0BEtDOelCTXWZZzRmEcpOfZ8HPo
         vj11yeBBP2DEikOK7RUFNHXq6jALuZ2wfeeHCTl9e0n2q0PWo8fWhpdD9uHhcS9bcVgc
         hsfrugtJjWbn7QRViGyYh9xiKiYc8IaumZjRjKge37EcRuK5S4j106ezzq7i9w/m7vqz
         PG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690896474; x=1691501274;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7KqnbOJdhgSzyxAwDGskROW5XKWJJbqeZliGdT5zMg=;
        b=AdleTsGIdjfv7bZ1WuskD4wDFL4zmcAr+m/8C4fsSH4vnNqNdyyPi/II1uoAMtOX9g
         N4+icMoiyVG9XqOEYWMoNY5mfGL9qX6NmXhomU8NqsKL5g7p98tufRJJLp/2g6oRiH8x
         KH2iCXAYIQY1MHnbpjcqtBtbFPw3Nr9yfVxf6+BllBWBcRl8JanURzgU2Z85SpEkrH7y
         8b7vdCtRRSfMXmXqBFWyGvufk48X42iurKScTV0MbSvU7fkAGkNG3RvWP3WD+i5c+gIH
         oZZqRbdHNWY7iLzmBjb2KaQ3zhVZ0kIkZzGgSGiFb5SuYXMDm5kov+zOZDiJpR6KcwPJ
         xKPw==
X-Gm-Message-State: ABy/qLZKx/PZ424KhEmaXDxWEWmmMowkP0yLo7ZrAEvK9QNcvulkmPxd
        lNJtQYe2STDuAG/b8a0K7fnmad8bY/1MZC2THb6O1A==
X-Google-Smtp-Source: APBJJlGrrgJH6liJgRwgZni7N5l+C40LsB5DL2TjuogbcjdEgROIugaEOMG4aoVwxoDZ/O5x1mkTVg==
X-Received: by 2002:a05:6a20:1d8:b0:137:2b6f:4307 with SMTP id 24-20020a056a2001d800b001372b6f4307mr12612571pzz.27.1690896473438;
        Tue, 01 Aug 2023 06:27:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u23-20020a62ed17000000b00640dbbd7830sm647041pfh.18.2023.08.01.06.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:27:52 -0700 (PDT)
Message-ID: <64c90858.620a0220.22fcd.0ea9@mx.google.com>
Date:   Tue, 01 Aug 2023 06:27:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Kernel: v5.10.188-113-gbaae5ca1b36f
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 132 runs,
 15 regressions (v5.10.188-113-gbaae5ca1b36f)
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

stable-rc/linux-5.10.y baseline: 132 runs, 15 regressions (v5.10.188-113-gb=
aae5ca1b36f)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.188-113-gbaae5ca1b36f/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.188-113-gbaae5ca1b36f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      baae5ca1b36f1d8a166963760a0bb8358d481ebd =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d6d57cf5bc96978ace84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at=
91-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at=
91-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c8d6d57cf5bc96978ac=
e85
        new failure (last pass: v5.10.188-107-gc262f74329e1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d61fc8705522418ace63

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d61fc8705522418ace68
        failing since 195 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-08-01T09:53:10.683236  <8>[   11.033629] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3727067_1.5.2.4.1>
    2023-08-01T09:53:10.793048  / # #
    2023-08-01T09:53:10.894588  export SHELL=3D/bin/sh
    2023-08-01T09:53:10.895443  #
    2023-08-01T09:53:10.997301  / # export SHELL=3D/bin/sh. /lava-3727067/e=
nvironment
    2023-08-01T09:53:10.998114  =

    2023-08-01T09:53:11.100105  / # . /lava-3727067/environment/lava-372706=
7/bin/lava-test-runner /lava-3727067/1
    2023-08-01T09:53:11.101412  =

    2023-08-01T09:53:11.101771  / # /lava-3727067/bin/lava-test-runner /lav=
a-3727067/1<3>[   11.452673] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-08-01T09:53:11.105993   =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d73584f00576ee8ace2d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d73584f00576ee8ace30
        failing since 14 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-08-01T09:57:52.890190  [    9.749139] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1239951_1.5.2.4.1>
    2023-08-01T09:57:52.995254  =

    2023-08-01T09:57:53.096481  / # #export SHELL=3D/bin/sh
    2023-08-01T09:57:53.096877  =

    2023-08-01T09:57:53.197829  / # export SHELL=3D/bin/sh. /lava-1239951/e=
nvironment
    2023-08-01T09:57:53.198325  =

    2023-08-01T09:57:53.299349  / # . /lava-1239951/environment/lava-123995=
1/bin/lava-test-runner /lava-1239951/1
    2023-08-01T09:57:53.300057  =

    2023-08-01T09:57:53.303993  / # /lava-1239951/bin/lava-test-runner /lav=
a-1239951/1
    2023-08-01T09:57:53.319979  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d748626a848bdc8ace73

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rd=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d748626a848bdc8ace76
        failing since 150 days (last pass: v5.10.155, first fail: v5.10.172)

    2023-08-01T09:58:14.034379  [   16.197349] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1239953_1.5.2.4.1>
    2023-08-01T09:58:14.139884  =

    2023-08-01T09:58:14.241548  / # #export SHELL=3D/bin/sh
    2023-08-01T09:58:14.241958  =

    2023-08-01T09:58:14.342915  / # export SHELL=3D/bin/sh. /lava-1239953/e=
nvironment
    2023-08-01T09:58:14.343380  =

    2023-08-01T09:58:14.444554  / # . /lava-1239953/environment/lava-123995=
3/bin/lava-test-runner /lava-1239953/1
    2023-08-01T09:58:14.445391  =

    2023-08-01T09:58:14.449218  / # /lava-1239953/bin/lava-test-runner /lav=
a-1239953/1
    2023-08-01T09:58:14.465178  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d5182cb10cc8df8ace44

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d5182cb10cc8df8ace49
        failing since 125 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-01T09:49:06.082891  + set +x

    2023-08-01T09:49:06.089642  <8>[   10.524504] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11182358_1.4.2.3.1>

    2023-08-01T09:49:06.197331  / # #

    2023-08-01T09:49:06.299384  export SHELL=3D/bin/sh

    2023-08-01T09:49:06.300125  #

    2023-08-01T09:49:06.401499  / # export SHELL=3D/bin/sh. /lava-11182358/=
environment

    2023-08-01T09:49:06.402171  =


    2023-08-01T09:49:06.503762  / # . /lava-11182358/environment/lava-11182=
358/bin/lava-test-runner /lava-11182358/1

    2023-08-01T09:49:06.504780  =


    2023-08-01T09:49:06.509751  / # /lava-11182358/bin/lava-test-runner /la=
va-11182358/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d51878845ce9fc8ace49

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d51878845ce9fc8ace4e
        failing since 125 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-08-01T09:48:58.744598  <8>[   11.265185] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11182376_1.4.2.3.1>

    2023-08-01T09:48:58.747708  + set +x

    2023-08-01T09:48:58.852721  #

    2023-08-01T09:48:58.853812  =


    2023-08-01T09:48:58.955566  / # #export SHELL=3D/bin/sh

    2023-08-01T09:48:58.956330  =


    2023-08-01T09:48:59.057723  / # export SHELL=3D/bin/sh. /lava-11182376/=
environment

    2023-08-01T09:48:59.058480  =


    2023-08-01T09:48:59.159896  / # . /lava-11182376/environment/lava-11182=
376/bin/lava-test-runner /lava-11182376/1

    2023-08-01T09:48:59.160953  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d75a7b94f5957a8ace46

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d75a7b94f5957a8ace82
        failing since 14 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-01T09:58:29.209725  / # #
    2023-08-01T09:58:29.312729  export SHELL=3D/bin/sh
    2023-08-01T09:58:29.313503  #
    2023-08-01T09:58:29.415419  / # export SHELL=3D/bin/sh. /lava-22830/env=
ironment
    2023-08-01T09:58:29.416229  =

    2023-08-01T09:58:29.518218  / # . /lava-22830/environment/lava-22830/bi=
n/lava-test-runner /lava-22830/1
    2023-08-01T09:58:29.519582  =

    2023-08-01T09:58:29.532977  / # /lava-22830/bin/lava-test-runner /lava-=
22830/1
    2023-08-01T09:58:29.592823  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-01T09:58:29.593344  + cd /lava-22830/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d7eb4bd7338fb28acf5a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12=
b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12=
b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c8d7eb4bd7338fb28ac=
f5b
        new failure (last pass: v5.10.188-107-gc262f74329e1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d727e892962dc38ace79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihop=
e-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihop=
e-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d727e892962dc38ace7c
        failing since 0 day (last pass: v5.10.186-10-g5f99a36aeb1c, first f=
ail: v5.10.188-107-gc262f74329e1)

    2023-08-01T09:57:37.509822  + set +x
    2023-08-01T09:57:37.510391  <8>[   83.724305] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 991204_1.5.2.4.1>
    2023-08-01T09:57:37.618986  / # #
    2023-08-01T09:57:39.089341  export SHELL=3D/bin/sh
    2023-08-01T09:57:39.110610  #
    2023-08-01T09:57:39.111216  / # export SHELL=3D/bin/sh
    2023-08-01T09:57:41.006208  / # . /lava-991204/environment
    2023-08-01T09:57:44.481725  /lava-991204/bin/lava-test-runner /lava-991=
204/1
    2023-08-01T09:57:44.503582  . /lava-991204/environment
    2023-08-01T09:57:44.504021  / # /lava-991204/bin/lava-test-runner /lava=
-991204/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d840b023dd59678ace7e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d840b023dd59678ace81
        failing since 14 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-01T10:02:22.267334  + set +x
    2023-08-01T10:02:22.267441  <8>[   83.623113] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 991208_1.5.2.4.1>
    2023-08-01T10:02:22.373454  / # #
    2023-08-01T10:02:23.832427  export SHELL=3D/bin/sh
    2023-08-01T10:02:23.852852  #
    2023-08-01T10:02:23.853021  / # export SHELL=3D/bin/sh
    2023-08-01T10:02:25.734399  / # . /lava-991208/environment
    2023-08-01T10:02:29.184804  /lava-991208/bin/lava-test-runner /lava-991=
208/1
    2023-08-01T10:02:29.205386  . /lava-991208/environment
    2023-08-01T10:02:29.205501  / # /lava-991208/bin/lava-test-runner /lava=
-991208/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d96ca3948343318ace25

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d96ca3948343318ace28
        failing since 14 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-01T10:07:10.449418  + set +x
    2023-08-01T10:07:10.449548  <8>[   83.967273] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 991205_1.5.2.4.1>
    2023-08-01T10:07:10.555235  / # #
    2023-08-01T10:07:12.014363  export SHELL=3D/bin/sh
    2023-08-01T10:07:12.034795  #
    2023-08-01T10:07:12.034967  / # export SHELL=3D/bin/sh
    2023-08-01T10:07:13.916370  / # . /lava-991205/environment
    2023-08-01T10:07:17.366845  /lava-991205/bin/lava-test-runner /lava-991=
205/1
    2023-08-01T10:07:17.387470  . /lava-991205/environment
    2023-08-01T10:07:17.387590  / # /lava-991205/bin/lava-test-runner /lava=
-991205/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d77aaafa19ce2f8ace3b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d77aaafa19ce2f8ace3e
        failing since 14 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-01T09:58:56.778468  / # #
    2023-08-01T09:58:58.237453  export SHELL=3D/bin/sh
    2023-08-01T09:58:58.257886  #
    2023-08-01T09:58:58.258030  / # export SHELL=3D/bin/sh
    2023-08-01T09:59:00.139525  / # . /lava-991201/environment
    2023-08-01T09:59:03.589921  /lava-991201/bin/lava-test-runner /lava-991=
201/1
    2023-08-01T09:59:03.610556  . /lava-991201/environment
    2023-08-01T09:59:03.610710  / # /lava-991201/bin/lava-test-runner /lava=
-991201/1
    2023-08-01T09:59:03.690681  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-01T09:59:03.690844  + cd /lava-991201/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d890f6a4f0ffbb8ace48

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d890f6a4f0ffbb8ace4b
        failing since 14 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-01T10:03:32.426564  / # #
    2023-08-01T10:03:33.885586  export SHELL=3D/bin/sh
    2023-08-01T10:03:33.906024  #
    2023-08-01T10:03:33.906170  / # export SHELL=3D/bin/sh
    2023-08-01T10:03:35.787597  / # . /lava-991209/environment
    2023-08-01T10:03:39.238023  /lava-991209/bin/lava-test-runner /lava-991=
209/1
    2023-08-01T10:03:39.258614  . /lava-991209/environment
    2023-08-01T10:03:39.258729  / # /lava-991209/bin/lava-test-runner /lava=
-991209/1
    2023-08-01T10:03:39.340117  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-01T10:03:39.340233  + cd /lava-991209/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c904d8f55aa999de8ad062

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c904d8f55aa999de8ad067
        failing since 14 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-01T13:14:13.195317  / # #

    2023-08-01T13:14:13.297529  export SHELL=3D/bin/sh

    2023-08-01T13:14:13.298242  #

    2023-08-01T13:14:13.399694  / # export SHELL=3D/bin/sh. /lava-11182452/=
environment

    2023-08-01T13:14:13.400464  =


    2023-08-01T13:14:13.501950  / # . /lava-11182452/environment/lava-11182=
452/bin/lava-test-runner /lava-11182452/1

    2023-08-01T13:14:13.503171  =


    2023-08-01T13:14:13.519405  / # /lava-11182452/bin/lava-test-runner /la=
va-11182452/1

    2023-08-01T13:14:13.568496  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T13:14:13.569049  + cd /lav<8>[   16.394994] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11182452_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c8d6bc1c0efcd3978ace37

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
88-113-gbaae5ca1b36f/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c8d6bc1c0efcd3978ace3c
        failing since 14 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-08-01T09:57:34.578453  / # #

    2023-08-01T09:57:34.679121  export SHELL=3D/bin/sh

    2023-08-01T09:57:34.679400  #

    2023-08-01T09:57:34.780027  / # export SHELL=3D/bin/sh. /lava-11182455/=
environment

    2023-08-01T09:57:34.780284  =


    2023-08-01T09:57:34.880876  / # . /lava-11182455/environment/lava-11182=
455/bin/lava-test-runner /lava-11182455/1

    2023-08-01T09:57:34.881271  =


    2023-08-01T09:57:34.891959  / # /lava-11182455/bin/lava-test-runner /la=
va-11182455/1

    2023-08-01T09:57:34.953992  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-01T09:57:34.954158  + cd /lava-1118245<8>[   18.263308] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11182455_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

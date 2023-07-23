Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F1475E3EB
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 18:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjGWQqB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 12:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGWQqA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 12:46:00 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0651A1
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 09:45:59 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b9d562f776so2741598a34.2
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690130758; x=1690735558;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8vJGtSuVxyNIx5hP3MuvyAK0IvtyS9HhAl4iKnq2x0Q=;
        b=p/N72izcq0rreWy0/1BuvSkBdOgTH6fUZpeZXUpK2/GS+A3RC7rD6y6+2ALM9niANX
         toekJonQXKxt3GIWWoQIwrvHjzr7ivF+CHQRGGxwg6i/4HuOtBVWOl1P1sq3cwtYbC1N
         Hav4n2K8BEfDFPPsaQ2BZ+ChG1RgcPCM8mbXMCkSacBryiFUWh+M6ApNXio4q6GNFVoh
         vSSLDfhjqUE8VRu3jfKae4deZWzdG25nPH+jV2yCDgvJvGq+i3hF11LliGnKGcW+ZZZR
         Jl0h9QkUr+rvyOEhKECaloCcvzBwgq8R97qm911hMOoa4Ff6p5Ds4Hh7bGpIlt2vKTiC
         dbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690130758; x=1690735558;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vJGtSuVxyNIx5hP3MuvyAK0IvtyS9HhAl4iKnq2x0Q=;
        b=IC5mvIqep3hg/8TBicbFNKiEl4inyIoe7y7EWZe4vnNhH6QqOtyQoxnfcsyEq2NkY1
         GnFshNDK8KW6d48dtwxs4Whvhox11V/hF302CEv/7qOQKcH6jNZo5rMmLKaaBXoJ/B8R
         ijCAZNMztPZACEZwco0YNy6na2+wW35+XjUlhpcZBMeOntLQfP4t4256Q0RRqs9nAcou
         /xikxaf4qK5wjthHZDJJNbiLt2yAxtxWYf2edt0XchKgj1/Oez9dNq1peV7FT5DzIYBi
         TY+cwUbHGVzW0AHr2LINhVdTJ8QhpTYVW51G1zFrr3LI3BMhMkiHYlSEZZTkWAEEvD4+
         7quw==
X-Gm-Message-State: ABy/qLYBpojsQXaLFTss12fNmV8t8J/NYhazIc/s4jC2gzRUolf+HH1m
        Gx0/EkF1a21326CYRwHzgj5NNSgb4Zvfh5VYkZw=
X-Google-Smtp-Source: APBJJlFK1YoDNtzPdGAuerzIrLsMn9J/yKdse8UzP7FIqe2+PCqsVYoF4pnDQQAq0ymOShry2JlwDw==
X-Received: by 2002:a05:6808:1389:b0:3a4:8a13:98a1 with SMTP id c9-20020a056808138900b003a48a1398a1mr10289043oiw.49.1690130758094;
        Sun, 23 Jul 2023 09:45:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n1-20020a17090a670100b002630bfd35b0sm6851559pjj.7.2023.07.23.09.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:45:56 -0700 (PDT)
Message-ID: <64bd5944.170a0220.11f68.c301@mx.google.com>
Date:   Sun, 23 Jul 2023 09:45:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Kernel: v6.3.11
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.3.y baseline: 115 runs, 3 regressions (v6.3.11)
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

stable-rc/linux-6.3.y baseline: 115 runs, 3 regressions (v6.3.11)

Regressions Summary
-------------------

platform                    | arch   | lab           | compiler | defconfig=
                    | regressions
----------------------------+--------+---------------+----------+----------=
--------------------+------------
acer-R721T-grunt            | x86_64 | lab-collabora | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

beagle-xm                   | arm    | lab-baylibre  | gcc-10   | omap2plus=
_defconfig          | 1          =

sun8i-h2-plus-orangepi-zero | arm    | lab-baylibre  | gcc-10   | sunxi_def=
config              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.11/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.11
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      429cff33b400edd76fc4d5e470742812a44fbc91 =



Test Regressions
---------------- =



platform                    | arch   | lab           | compiler | defconfig=
                    | regressions
----------------------------+--------+---------------+----------+----------=
--------------------+------------
acer-R721T-grunt            | x86_64 | lab-collabora | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a05067c06d6c4468bb2b50

  Results:     18 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.11/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-R=
721T-grunt.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.11/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-R=
721T-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.tpm-chip-is-online: https://kernelci.org/test/case/id/6=
4a05067c06d6c4468bb2b5f
        new failure (last pass: v6.3.10-33-g45e606c9f23d)

    2023-07-01T16:11:59.452005  /usr/bin/tpm2_getcap

    2023-07-01T16:12:09.682911  /lava-10976509/1/../bin/lava-test-case<8>[ =
  21.202038] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dtpm-chip-is-online RESULT=
=3Dfail>
   =

 =



platform                    | arch   | lab           | compiler | defconfig=
                    | regressions
----------------------------+--------+---------------+----------+----------=
--------------------+------------
beagle-xm                   | arm    | lab-baylibre  | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64a05102b6b697012bbb2a8a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.11/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.11/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a05102b6b697012bbb2=
a8b
        failing since 1 day (last pass: v6.3.10-31-ge236789dc329, first fai=
l: v6.3.10-33-g45e606c9f23d) =

 =



platform                    | arch   | lab           | compiler | defconfig=
                    | regressions
----------------------------+--------+---------------+----------+----------=
--------------------+------------
sun8i-h2-plus-orangepi-zero | arm    | lab-baylibre  | gcc-10   | sunxi_def=
config              | 1          =


  Details:     https://kernelci.org/test/plan/id/64a0502ac4bd19657bbb2aa8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.11/=
arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-zer=
o.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.11/=
arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-zer=
o.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a0502ac4bd19657bbb2aad
        new failure (last pass: v6.3.10-33-g45e606c9f23d)

    2023-07-01T16:10:56.311592  / # #
    2023-07-01T16:10:56.417108  export SHELL=3D/bin/sh
    2023-07-01T16:10:56.418646  #
    2023-07-01T16:10:56.522019  / # export SHELL=3D/bin/sh. /lava-3705330/e=
nvironment
    2023-07-01T16:10:56.523624  =

    2023-07-01T16:10:56.626955  / # . /lava-3705330/environment/lava-370533=
0/bin/lava-test-runner /lava-3705330/1
    2023-07-01T16:10:56.629677  =

    2023-07-01T16:10:56.636674  / # /lava-3705330/bin/lava-test-runner /lav=
a-3705330/1
    2023-07-01T16:10:56.787295  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-01T16:10:56.788412  + cd /lava-3705330/1/tests/1_bootrr =

    ... (11 line(s) more)  =

 =20

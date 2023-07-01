Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87D8744B05
	for <lists+stable@lfdr.de>; Sat,  1 Jul 2023 22:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjGAUTV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 1 Jul 2023 16:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGAUTV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 1 Jul 2023 16:19:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679FF1999
        for <stable@vger.kernel.org>; Sat,  1 Jul 2023 13:19:19 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b80b3431d2so15438815ad.1
        for <stable@vger.kernel.org>; Sat, 01 Jul 2023 13:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688242758; x=1690834758;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8vJGtSuVxyNIx5hP3MuvyAK0IvtyS9HhAl4iKnq2x0Q=;
        b=XDXipSdbl6natyYTKldKo+zmpLcFUnefxDvWswUn02E4daH/i94w1bbjOs6NzpPHe3
         tQn01C/zqbYCA27FfhX8/odh4RrcBMoqiPbNjgc9mthAiHFPAVswDtkbP4bk2YwoT7kT
         uf3NvdBMsbRng3NtflEGjX73fy48sJldJ4xPJGlpLkoYggXmZD92FZ8cp3l8sTCVJJeU
         Z9n7kXgJM/S+hUCfv3WkWPRREv/YU/V+vDd98jVnus09vc3fU2uxCwR0vgBzqQjTcu6R
         OBJXeOpc6S53KzLbGwfql2YW9pvkIJxF2L3QCQwDPGM5ECBV1IG0kCUKFvOcljF9ka8G
         5QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688242758; x=1690834758;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vJGtSuVxyNIx5hP3MuvyAK0IvtyS9HhAl4iKnq2x0Q=;
        b=MOzvn0ktUI6M2bb46JxUfHqPjnwM4uUy6WEnvuv9NronwpDxfZwAIPQCXqOXhGBQIL
         NXtDVeSJBkJSE+NO0ERZfKDql0msreKIlYbHjjGWSgYGtFcKMVKCpiN2+xXlWnF2gs1Q
         SVG0ZTOAkI6O5gAhaeYV6rTzPJeKLjEiKmHOPIwPE33mlgUCuhkhUWOwqwXNQ1iHfwUj
         y9Wi8LfBcHIwfpMlS/N4Kef+NP6V7kCqBoI19k30JhTCYMU0Z9Y/fBXbdwoZ1TvQtAYG
         HABOEne21hxBKvDTiE5DfuZulUxnWhReSRvhT2O2YuVD5uDpnC93O3RI81ik96p5fTtK
         JTPw==
X-Gm-Message-State: ABy/qLY57HNHmi4Q9B5d5TtwEEyV6m1BKvsktVZ2SkAG+PkM8VzE/Gau
        i4jta90dx9M66D6ZGUBTnVyu68WpWDIxROyv4pY+TQ==
X-Google-Smtp-Source: APBJJlHm1GobUsUM+C3GpRxk/n9BFrAFDALuqU0t19i7DD03hRzH2rhMs8HZFS2XEyXgSdcusO0XPw==
X-Received: by 2002:a17:903:2304:b0:1b3:a928:18e7 with SMTP id d4-20020a170903230400b001b3a92818e7mr4338804plh.59.1688242758341;
        Sat, 01 Jul 2023 13:19:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902854100b001ae365072ccsm12619433plo.122.2023.07.01.13.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 13:19:17 -0700 (PDT)
Message-ID: <64a08a45.170a0220.44f73.7d66@mx.google.com>
Date:   Sat, 01 Jul 2023 13:19:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.3.11
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.3.y
Subject: stable-rc/linux-6.3.y baseline: 115 runs, 3 regressions (v6.3.11)
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
